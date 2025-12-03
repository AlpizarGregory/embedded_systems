#include <stdint.h>
#include "sys/alt_stdio.h"
#include <unistd.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "nios2.h"

/**************************************/
/* BASES						      */
/**************************************/
#define FIFO_CSR_BASE   0x00011080
#define FIFO_OUT_BASE   0x00011088

#define AUDIO_BASE      0x00011070
volatile int* audio_ptr = (volatile int*)AUDIO_BASE;

#define audio_ctrl_reg   (audio_ptr + 0)
#define audio_stat_reg   (audio_ptr + 1)
#define audio_left_reg   (audio_ptr + 2)
#define audio_right_reg  (audio_ptr + 3)

#define SEVEN_SEGMENTS_BASE 0x11040

#define BUTTON1_BASE      0x00011050
#define BUTTON1_IRQ       4
#define BUTTON1_IRQ_MASK  (BUTTON1_BASE + 8)
#define BUTTON1_EDGE_CAP  (BUTTON1_BASE + 12)

#define BUTTON2_BASE      0x00011030
#define BUTTON2_IRQ       5
#define BUTTON2_IRQ_MASK  (BUTTON2_BASE + 8)
#define BUTTON2_EDGE_CAP  (BUTTON2_BASE + 12)

#define BUTTON3_BASE      0x00011020
#define BUTTON3_IRQ       6
#define BUTTON3_IRQ_MASK  (BUTTON3_BASE + 8)
#define BUTTON3_EDGE_CAP  (BUTTON3_BASE + 12)

/**************************************/
volatile uint8_t paused = 0;
volatile uint32_t irq_block_ms = 0;
volatile uint8_t print_state_flag = 0;
volatile uint8_t next_song = 0;
volatile uint8_t prev_song = 0;

/**************************************/
static inline void audio_reset()
{
    *audio_ctrl_reg = 0x0C;
    *audio_ctrl_reg = 0x02;
}

/**************************************/
static inline void audio_write(uint32_t L24, uint32_t R24)
{
    while (1)
    {
        uint32_t st = *audio_stat_reg;
        if (((st >> 16) & 0xFF) && ((st >> 24) & 0xFF))
            break;
    }

    *audio_left_reg  = L24;
    *audio_right_reg = R24;
}

/**************************************/
static const uint8_t seg_lut[10] = {
    0b1000000, // 0
    0b1111001, // 1
    0b0100100, // 2
    0b0110000, // 3
    0b0011001, // 4
    0b0010010, // 5
    0b0000010, // 6
    0b1111000, // 7
    0b0000000, // 8
    0b0010000  // 9
};

static inline void display_number(uint16_t n)
{
    uint32_t val = 0;

    uint8_t d0 = n % 10;          // unidades
    uint8_t d1 = (n / 10) % 10;   // decenas
    uint8_t d2 = (n / 100) % 10;  // centenas
    uint8_t d3 = (n / 1000) % 10; // millares

    // Limpieza por seguridad: cada dígito usa 7 bits
    val |= (seg_lut[d0] & 0x7F) << 0;   // bits 0-6
    val |= (seg_lut[d1] & 0x7F) << 7;   // bits 7-13
    val |= (seg_lut[d2] & 0x7F) << 14;  // bits 14-20
    val |= (seg_lut[d3] & 0x7F) << 21;  // bits 21-27

    // Depuración opcional
    // printf("val = 0x%08X\n", val);

    *(volatile uint32_t*)SEVEN_SEGMENTS_BASE = val;
}

static inline void heartbeat_counter()
{
	static uint8_t d0=0, d1=0, d2=0, d3=0;
	static uint8_t tick = 0;

    tick++;
    if (tick >= 2) // d0 avanza cada 2 llamadas a la función
    {
        tick = 0;
        d0++;
        if(d0 > 9) { d0 = 0; d1++; }
        if(d1 > 5) { d1 = 0; d2++; }
        if(d2 > 9) { d2 = 0; d3++; }
        if(d3 > 5) { d3 = 0; }
    }

	uint16_t n = d3*1000 + d2*100 + d1*10 + d0;
	display_number(n);
}


/**************************************/
/* ISR 		                          */
/**************************************/
static void button1_ISR(void* context)
{
    uint32_t cap = *(volatile uint32_t*)BUTTON1_EDGE_CAP;
    *(volatile uint32_t*)BUTTON1_EDGE_CAP = cap;

    if (!(cap & 1)) return;
    if (irq_block_ms) return;

    paused ^= 1;
    print_state_flag = 1;

    *(volatile uint32_t*)BUTTON1_IRQ_MASK = 0;
    irq_block_ms = 2;
}

static void button2_ISR(void* context)
{
    uint32_t cap = *(volatile uint32_t*)BUTTON2_EDGE_CAP;
    *(volatile uint32_t*)BUTTON2_EDGE_CAP = cap;

    if (!(cap & 1)) return;
    if (irq_block_ms) return;

    next_song = 1;

    *(volatile uint32_t*)BUTTON2_IRQ_MASK = 0;
}

static void button3_ISR(void* context)
{
    uint32_t cap = *(volatile uint32_t*)BUTTON3_EDGE_CAP;
    *(volatile uint32_t*)BUTTON3_EDGE_CAP = cap;

    if (!(cap & 1)) return;
    if (irq_block_ms) return;

    prev_song = 1;

    *(volatile uint32_t*)BUTTON3_IRQ_MASK = 0;
}

/**************************************/
void irq_init()
{
    // BUTTON 1
    *(volatile uint32_t*)BUTTON1_EDGE_CAP = 1;
    *(volatile uint32_t*)BUTTON1_IRQ_MASK = 1;
    alt_irq_register(BUTTON1_IRQ, NULL, button1_ISR);

    // BUTTON 2
    *(volatile uint32_t*)BUTTON2_EDGE_CAP = 1;
    *(volatile uint32_t*)BUTTON2_IRQ_MASK = 1;
    alt_irq_register(BUTTON2_IRQ, NULL, button2_ISR);

    // BUTTON 3
    *(volatile uint32_t*)BUTTON3_EDGE_CAP = 1;
    *(volatile uint32_t*)BUTTON3_IRQ_MASK = 1;
    alt_irq_register(BUTTON3_IRQ, NULL, button3_ISR);

    // Habilitar todas
    NIOS2_WRITE_IENABLE((1<<BUTTON1_IRQ) | (1<<BUTTON2_IRQ) | (1<<BUTTON3_IRQ));
    NIOS2_WRITE_STATUS(1);

    alt_putstr("[IRQ Ready]\n");
}
/**************************************/
void stream_fifo_to_audio()
{
    alt_putstr("[RUN] Streaming...\n");

    uint32_t tick = 0;

    while (1)
    {
        if (irq_block_ms)
        {
            irq_block_ms--;
            if (irq_block_ms == 0)
            {
                *(volatile uint32_t*)BUTTON1_IRQ_MASK = 0;
                uint32_t cap = *(volatile uint32_t*)BUTTON1_EDGE_CAP;
                *(volatile uint32_t*)BUTTON1_EDGE_CAP = cap;
                *(volatile uint32_t*)BUTTON1_IRQ_MASK = 1;
            }
        }

        if (print_state_flag)
        {
            alt_putstr(paused ? "[PAUSA]\n" : "[CONTINUAR]\n");
            print_state_flag = 0;

        }

        if (next_song)
        {
            *(volatile uint32_t*)BUTTON2_IRQ_MASK = 0;
            uint32_t cap = *(volatile uint32_t*)BUTTON2_EDGE_CAP;
            *(volatile uint32_t*)BUTTON2_EDGE_CAP = cap;
            *(volatile uint32_t*)BUTTON2_IRQ_MASK = 1;
            alt_putstr("[SIGUIENTE CANCION]\n");
            next_song = 0;

            // PROSEGUIR
        }
        if (prev_song)
        {
            *(volatile uint32_t*)BUTTON3_IRQ_MASK = 0;
            uint32_t cap = *(volatile uint32_t*)BUTTON3_EDGE_CAP;
            *(volatile uint32_t*)BUTTON3_EDGE_CAP = cap;
            *(volatile uint32_t*)BUTTON3_IRQ_MASK = 1;
            alt_putstr("[CANCION ANTERIOR]\n");
            prev_song = 0;

            // RETROCEDER
        }
        if (paused)
        {
            usleep(150000);
            continue;
        }

        if (*(volatile uint32_t*)FIFO_CSR_BASE & 0xFFFF)
        {
            uint32_t sample = *(volatile uint32_t*)FIFO_OUT_BASE;

            uint32_t L24 = (uint16_t)(sample & 0xFFFF) << 8;
            uint32_t R24 = (uint16_t)(sample >> 16)    << 8;

            audio_write(L24, R24);
        }
        else
        {
            audio_write(0,0);
        }

        if (++tick >= 20000)
        {
            heartbeat_counter();
            tick = 0;
        }
    }
}

/**************************************/
int main()
{
    alt_putstr("\n=== PLAYER SIMPLIFICADO ===\n");

    *(volatile uint32_t*)SEVEN_SEGMENTS_BASE  = 0;

    heartbeat_counter();

    audio_reset();
    irq_init();

    stream_fifo_to_audio();
    return 0;
}
