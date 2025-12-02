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
#include <unistd.h>
#include <math.h>
#include <stdint.h> // <--- ESTA FALTABA

// --- Punteros de Hardware ---
volatile int* audio_ptr = (volatile int*) AUDIO_BASE;
#define audio_control_reg (audio_ptr + 0)
#define audio_status_reg  (audio_ptr + 1)
#define audio_fifo_L_reg  (audio_ptr + 2)
#define audio_fifo_R_reg  (audio_ptr + 3)

// --- Configuración del Buffer Perfecto ---
#define BUFFER_SIZE 1200
#define PI 3.14159265358979323846

// Buffer en memoria (Usamos 'int' que es 32-bit en Nios II)
int sine_buffer[BUFFER_SIZE];

// --- Función para pre-calcular la onda ---
void generar_seno_perfecto() {
    double amplitud = 8300000.0;

    for (int i = 0; i < BUFFER_SIZE; i++) {
        double tiempo = (double)i / 48000.0;
        double valor_rad = 2.0 * PI * 440.0 * tiempo;

        // Casting a int normal
        sine_buffer[i] = (int)(amplitud * sin(valor_rad));
    }
}

int main(void)
{
    alt_putstr("--- Prueba SENO PERFECTO (Buffer 1200) ---\n");

    // 1. Inicializar Audio
    *audio_control_reg = 0x0C;
    *audio_control_reg = 0x02;

    // 2. Pre-cargar la memoria
    alt_putstr("Calculando tabla de ondas...\n");
    generar_seno_perfecto();

    // 3. Reproducción
    int play_cursor = 0;
    int samples_to_play = 960000; // 20 segundos

    alt_putstr("Reproduciendo...\n");

    for (int i = 0; i < samples_to_play; ++i) {

        // --- A. LEER ---
        int sample = sine_buffer[play_cursor];

        // --- B. CONTROL DE FLUJO ---
        unsigned int status;
        do {
            status = *audio_status_reg;
        } while (((status >> 16) & 0xFF) == 0 || ((status >> 24) & 0xFF) == 0);

        // --- C. ESCRIBIR ---
        *audio_fifo_L_reg = sample;
        *audio_fifo_R_reg = sample;

        // --- D. AVANZAR PUNTERO ---
        play_cursor++;

        if (play_cursor >= BUFFER_SIZE) {
            play_cursor = 0;
        }
    }

    alt_putstr("Fin del tono perfecto.\n");
    usleep(500 * 1000);

    return 0;
}
