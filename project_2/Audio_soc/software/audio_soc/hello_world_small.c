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

#define SEVEN_SEG        0x00011043

#define BUTTON_BASE      0x00011050
#define BUTTON_IRQ       4
#define PIO_IRQ_MASK     (BUTTON_BASE + 8)
#define PIO_EDGE_CAP     (BUTTON_BASE + 12)

/**************************************/
volatile uint8_t paused = 0;
volatile uint32_t irq_block_ms = 0;
volatile uint8_t print_state_flag = 0;

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
static inline void heartbeat()
{
    static uint8_t s = 0;
    s ^= 1;
    *(volatile uint32_t*)SEVEN_SEG = s ? 0x3F : 0x00;
}

/**************************************/
/* ISR 		                          */
/**************************************/
static void button_ISR(void* context)
{
    uint32_t cap = *(volatile uint32_t*)PIO_EDGE_CAP;
    *(volatile uint32_t*)PIO_EDGE_CAP = cap;

    if (!(cap & 1)) return;
    if (irq_block_ms) return;

    paused ^= 1;
    print_state_flag = 1;

    *(volatile uint32_t*)PIO_IRQ_MASK = 0;
    irq_block_ms = 2;
}

/**************************************/
void irq_init()
{
    *(volatile uint32_t*)PIO_EDGE_CAP = 1;
    *(volatile uint32_t*)PIO_IRQ_MASK = 1;

    alt_irq_register(BUTTON_IRQ, NULL, button_ISR);

    NIOS2_WRITE_IENABLE(1 << BUTTON_IRQ);
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
                *(volatile uint32_t*)PIO_IRQ_MASK = 0;
                uint32_t cap = *(volatile uint32_t*)PIO_EDGE_CAP;
                *(volatile uint32_t*)PIO_EDGE_CAP = cap;
                *(volatile uint32_t*)PIO_IRQ_MASK = 1;
            }
        }

        if (print_state_flag)
        {
            alt_putstr(paused ? "[PAUSA]\n" : "[CONTINUAR]\n");
            print_state_flag = 0;
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
            heartbeat();
            tick = 0;
        }
    }
}

/**************************************/
int main()
{
    alt_putstr("\n=== PLAYER SIMPLIFICADO ===\n");

    *(volatile uint32_t*)SEVEN_SEG = 0;

    audio_reset();
    irq_init();

    stream_fifo_to_audio();
    return 0;
}
