#include <stdint.h>
#include "sys/alt_stdio.h"
#include <unistd.h>

/*******************************************************
 *  NIOS II CPU REGISTER ACCESS (no HAL)
 *******************************************************/
static inline void nios2_write_ienable(uint32_t val)
{
    asm volatile ("wrctl ienable,%0" : : "r"(val));
}

static inline void nios2_write_status(uint32_t val)
{
    asm volatile ("wrctl status,%0" : : "r"(val));
}

/*******************************************************
 *  BASE ADDRESSES
 *******************************************************/
#define FIFO_CSR_BASE    0x00011080
#define FIFO_OUT_BASE    0x00011088

#define AUDIO_BASE       0x00011070
volatile int* audio_ptr = (volatile int*) AUDIO_BASE;

#define audio_ctrl_reg   (audio_ptr + 0)
#define audio_stat_reg   (audio_ptr + 1)
#define audio_left_reg   (audio_ptr + 2)
#define audio_right_reg  (audio_ptr + 3)

#define SEVEN_SEG        0x00011043

#define BUTTON_BASE      0x00011050     // Given
#define BUTTON_IRQ       4
#define PIO_IRQ_MASK     (BUTTON_BASE + 8)
#define PIO_EDGE_CAP     (BUTTON_BASE + 12)

/*******************************************************
 *  Global pause flag
 *******************************************************/
volatile uint8_t paused = 0;

/*******************************************************
 *  ISR — NO HAL — direct MMIO
 *******************************************************/
void button_ISR()
{
    /* Clear edge capture */
    *(volatile uint32_t*)PIO_EDGE_CAP = 0x1;

    paused ^= 1;

    if (paused)
        alt_putstr("[PAUSA]\n");
    else
        alt_putstr("[CONTINUAR]\n");
}

/*******************************************************
 *  FIFO access
 *******************************************************/
static inline uint32_t mmio_read32(uint32_t addr)
{
    return *(volatile uint32_t*)addr;
}

static inline void mmio_write32(uint32_t addr, uint32_t val)
{
    *(volatile uint32_t*)addr = val;
}

static inline uint32_t fifo_level()
{
    return mmio_read32(FIFO_CSR_BASE) & 0xFFFF;
}

static inline uint32_t fifo_pop()
{
    return mmio_read32(FIFO_OUT_BASE);
}

/*******************************************************
 *  Audio helpers
 *******************************************************/
static inline void audio_reset()
{
    *audio_ctrl_reg = 0x0C;
    *audio_ctrl_reg = 0x02;
}

static inline void audio_write(uint32_t L24, uint32_t R24)
{
    uint32_t tries = 0;

    while (1)
    {
        uint32_t st = *audio_stat_reg;

        uint8_t left_space  = (st >> 16) & 0xFF;
        uint8_t right_space = (st >> 24) & 0xFF;

        if (left_space && right_space)
            break;

        if (++tries > 50000)
        {
            tries = 0;
            alt_putstr("[WARN] AUDIO_CORE WAIT...\n");
        }
    }

    *audio_left_reg  = L24;
    *audio_right_reg = R24;
}

static inline uint32_t expand24(uint16_t pcm16)
{
    return ((uint32_t)pcm16) << 8;
}

/*******************************************************
 *  Heartbeat
 *******************************************************/
static inline void heartbeat()
{
    static uint8_t state = 0;
    state ^= 1;
    mmio_write32(SEVEN_SEG, state ? 0x3F : 0x00);
}

/*******************************************************
 *  IRQ INSTALL — NO HAL
 *******************************************************/
void irq_init()
{
    /* Clear pending flag */
    *(volatile uint32_t*)PIO_EDGE_CAP = 0x1;

    /* Enable PIO interrupt generation */
    *(volatile uint32_t*)PIO_IRQ_MASK = 0x1;

    /* Register handler */
    extern void (*alt_irq[])(void);   // table exists even in bare-metal
    alt_irq[BUTTON_IRQ] = button_ISR;

    /* Enable IRQ bit 4 (button IRQ) */
    nios2_write_ienable( (1 << BUTTON_IRQ) );

    /* Enable global CPU interrupt flag */
    nios2_write_status(1);
}

/*******************************************************
 *  FIFO to AUDIO streaming
 *******************************************************/
void stream_fifo_to_audio()
{
    alt_putstr("[RUN] Streaming...\n");

    uint32_t tick = 0;

    while(1)
    {
        if (paused)
        {
            usleep(150000);
            continue;
        }

        uint32_t sample;

        if (fifo_level())
        {
            sample = fifo_pop();
            uint16_t L16 =  sample        & 0xFFFF;
            uint16_t R16 = (sample >> 16) & 0xFFFF;
            audio_write(expand24(L16), expand24(R16));
        }
        else
        {
            audio_write(0, 0);
        }

        if (++tick >= 20000)
        {
            heartbeat();
            tick = 0;
        }
    }
}

/*******************************************************
 * FIFO to AUDIO streaming (FILTRO PASAALTAS / HIGH-PASS)
 *******************************************************/
#define HP_SHIFT 3  // Ajusta esto.
                    // Valores altos (ej. 4 o 5) dejan pasar mas medios.
                    // Valores bajos (ej. 1 o 2) dejan pasar solo agudos muy finos.

void stream_fifo_to_audiohp()
{
    alt_putstr("[RUN] Streaming HIGH-PASS...\n");

    uint32_t tick = 0;

    // Estado para el componente pasabajas interno
    static int32_t acc_L = 0;
    static int32_t acc_R = 0;

    while(1)
    {
        if (paused)
        {
            usleep(150000);
            continue;
        }

        if (fifo_level())
        {
            uint32_t sample = fifo_pop();

            // 1. Extraer como con signo
            int16_t in_L = (int16_t)(sample & 0xFFFF);
            int16_t in_R = (int16_t)((sample >> 16) & 0xFFFF);

            // 2. Calcular componente de baja frecuencia (igual que el filtro anterior)
            acc_L = acc_L - (acc_L >> HP_SHIFT) + in_L;
            acc_R = acc_R - (acc_R >> HP_SHIFT) + in_R;

            int16_t low_part_L = (int16_t)(acc_L >> HP_SHIFT);
            int16_t low_part_R = (int16_t)(acc_R >> HP_SHIFT);

            // 3. Calcular Pasaaltas: Original - Baja Frecuencia
            int16_t out_L = in_L - low_part_L;
            int16_t out_R = in_R - low_part_R;

            // 4. Escribir
            audio_write(expand24((uint16_t)out_L), expand24((uint16_t)out_R));
        }
        else
        {
            audio_write(0, 0);
        }

        if (++tick >= 20000)
        {
            heartbeat();
            tick = 0;
        }
    }
}

/*******************************************************
 * FIFO to AUDIO streaming (FILTRO PASABAJAS / LOW-PASS)
 *******************************************************/
#define LP_SHIFT 3  // Ajusta esto entre 1 y 5.
                    // 1 = filtro suave, 5 = filtro muy fuerte (sonido opaco)

void stream_fifo_to_audiolp()
{
    alt_putstr("[RUN] Streaming LOW-PASS...\n");

    uint32_t tick = 0;

    // Variables de estado (Historia) para el filtro
    // Deben ser static para mantener el valor entre iteraciones
    // Usamos int32 para evitar desbordamiento durante la suma acumulativa
    static int32_t acc_L = 0;
    static int32_t acc_R = 0;

    while(1)
    {
        if (paused)
        {
            usleep(150000);
            continue;
        }

        if (fifo_level())
        {
            uint32_t sample = fifo_pop();

            // 1. Extraer muestras como ENTEROS CON SIGNO (Crucial para audio)
            int16_t in_L = (int16_t)(sample & 0xFFFF);
            int16_t in_R = (int16_t)((sample >> 16) & 0xFFFF);

            // 2. Aplicar Filtro Pasabajas (Algoritmo de media móvil exponencial)
            // Formula: y[n] = y[n-1] - (y[n-1] >> SHIFT) + x[n]
            // El acumulador 'acc' mantiene una versión escalada de la señal

            acc_L = acc_L - (acc_L >> LP_SHIFT) + in_L;
            acc_R = acc_R - (acc_R >> LP_SHIFT) + in_R;

            // 3. Escalar de vuelta para obtener la salida
            int16_t out_L = (int16_t)(acc_L >> LP_SHIFT);
            int16_t out_R = (int16_t)(acc_R >> LP_SHIFT);

            // 4. Escribir al audio (Castear de vuelta a uint para tus funciones helpers)
            audio_write(expand24((uint16_t)out_L), expand24((uint16_t)out_R));
        }
        else
        {
            audio_write(0, 0);
        }

        if (++tick >= 20000)
        {
            heartbeat();
            tick = 0;
        }
    }
}
/*******************************************************
 *  MAIN
 *******************************************************/
int main()
{
    alt_putstr("\n=== FIFO + PAUSE BUTTON PLAYER ===\n");

    mmio_write32(SEVEN_SEG, 0x00);

    audio_reset();
    irq_init();

    stream_fifo_to_audio();
    return 0;
}
