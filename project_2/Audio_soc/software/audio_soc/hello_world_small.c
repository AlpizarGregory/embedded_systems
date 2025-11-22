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
#include <unistd.h> // Para usleep

// --- 1. Definir Punteros Directos a los Registros de Audio ---
volatile int* audio_ptr = (volatile int*) AUDIO_BASE;

#define audio_control_reg (audio_ptr + 0)
#define audio_status_reg  (audio_ptr + 1)
#define audio_fifo_L_reg  (audio_ptr + 2)
#define audio_fifo_R_reg  (audio_ptr + 3)

// --- Constantes ---
#define SAMPLE_RATE 48000
#define FREQ        440   // Frecuencia deseada (aprox. 440 Hz)
#define DURATION_SEC 20    // Duración del tono

// --- 2. Tabla de Onda Sinusoidal (32 muestras, 24-bit) ---
// Valores pre-calculados que van de 0x800000 (min) a 0x7FFFFF (max)
const unsigned int sine_wave_table[32] = {
    0x000000, 0x18F8B8, 0x30FB8C, 0x471C71, 0x5A8279, 0x6A6D9A, 0x7641AF, 0x7D8A21,
    0x7FFFFF, 0x7D8A21, 0x7641AF, 0x6A6D9A, 0x5A8279, 0x471C71, 0x30FB8C, 0x18F8B8,
    0x000000, 0xE70748, 0xCF0474, 0xB8E38F, 0xA57D87, 0x959266, 0x89BE51, 0x8275DF,
    0x800001, 0x8275DF, 0x89BE51, 0x959266, 0xA57D87, 0xB8E38F, 0xCF0474, 0xE70748
};


int main(void)
{
    alt_putstr("--- Prueba de Audio (Modo Puntero - SENOIDAL) ---\n");

    alt_putstr("Limpiando FIFOs de audio...\n");

    // --- 3. Limpiar FIFOs y Habilitar DAC ---
    *audio_control_reg = 0x0C; // Limpia FIFOs (WCLR + RCLR)
    *audio_control_reg = 0x02; // Habilita el DAC (Bit 1 = WE)

    // --- 4. Calcular parámetros del tono ---
    int samples_per_cycle = SAMPLE_RATE / FREQ;     // ~109 muestras por ciclo de 440Hz
    int total_samples = DURATION_SEC * SAMPLE_RATE; // 96,000 muestras en total

    // Cuántas muestras de 48kHz deben pasar antes de avanzar al siguiente
    // paso de nuestra tabla de 32 muestras
    int samples_per_table_step = samples_per_cycle / 32; // 109 / 32 = 3

    // (La frecuencia real será 48000 / (3 * 32) = 500 Hz, que es cercano)
    alt_printf("Generando tono SENOIDAL de ~500 Hz por %d segundos...\n", DURATION_SEC);

    // --- 5. Bucle principal de generación de audio ---
    for (int i = 0; i < total_samples; ++i) {

        // --- Generar la muestra ---
        // Calcula en qué punto de la tabla senoidal deberíamos estar
        int table_index = (i / samples_per_table_step) % 32;

        // Toma la muestra de la tabla
        unsigned int sample = sine_wave_table[table_index];

        // --- 6. Esperar espacio en FIFO (Modo Puntero) ---
        // (Esta parte es idéntica a la prueba anterior)
        unsigned int status_value;
        int espacio_L, espacio_R;
        do {
            status_value = *audio_status_reg;
            espacio_L = (status_value >> 16) & 0xFF; // WSRC_L
            espacio_R = (status_value >> 24) & 0xFF; // WSRC_R
        } while (espacio_L == 0 || espacio_R == 0);

        // --- 7. Escribir en FIFO (Modo Puntero) ---
        // (Esta parte es idéntica a la prueba anterior)
        *audio_fifo_L_reg = sample;
        *audio_fifo_R_reg = sample;
    }

    alt_putstr("Fin del tono.\n");

    usleep(200 * 1000); // 200ms

    return 0;
}
