/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "system.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include <sys/alt_timestamp.h>
#include <unistd.h> // Para usleep


#include <stdint.h>
#include <stdint.h>

/************************************************************
 *  Memory-Mapped Hardware Base Addresses
 ************************************************************/
#define FIFO_CSR_BASE      0x00011080   // FIFO status register
#define FIFO_OUT_BASE      0x00011088   // FIFO pop

#define AUDIO_BASE         0x00011070
#define AUDIO_CONTROL      (AUDIO_BASE + 0x00)
#define AUDIO_LEFT         (AUDIO_BASE + 0x04)
#define AUDIO_RIGHT        (AUDIO_BASE + 0x08)

/************************************************************
 *  MMIO ACCESSORS (replace REG32 macro)
 ************************************************************/
static inline void write32(uint32_t addr, uint32_t value)
{
    *(volatile uint32_t*)addr = value;
}

static inline uint32_t read32(uint32_t addr)
{
    return *(volatile uint32_t*)addr;
}

/************************************************************
 *  FIFO ACCESS (Polling-Based)
 ************************************************************/
static inline int fifo_level()
{
    return (read32(FIFO_CSR_BASE) & 0xFFFF);
}

static inline uint32_t fifo_pop()
{
    return read32(FIFO_OUT_BASE);
}

/************************************************************
 *  AUDIO CORE ACCESS
 ************************************************************/
static inline void audio_reset()
{
    write32(AUDIO_CONTROL, 0x01);
}

static inline void audio_write_left(uint32_t s24)
{
    write32(AUDIO_LEFT, s24);
}

static inline void audio_write_right(uint32_t s24)
{
    write32(AUDIO_RIGHT, s24);
}

/************************************************************
 *  PCM Conversion Helper
 ************************************************************/
static inline uint32_t expand24(uint16_t pcm16)
{
    return ((uint32_t)pcm16) << 8;
}

/************************************************************
 *  FIFO -> AUDIO Streaming Loop
 ************************************************************/
void audio_stream()
{
    uint32_t sample;
    uint16_t L16, R16;
    uint32_t L24, R24;

    while (1)
    {
        if (fifo_level() > 0)
        {
            sample = fifo_pop();

            L16 = sample & 0xFFFF;
            R16 = (sample >> 16) & 0xFFFF;

            L24 = expand24(L16);
            R24 = expand24(R16);
        }
        else
        {
            L24 = 0;
            R24 = 0;
        }

        audio_write_left(L24);
        audio_write_right(R24);
    }
}

/************************************************************
 *  MAIN ENTRY POINT
 ************************************************************/
int main()
{
    audio_reset();
    audio_stream();
    return 0;
}
