/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'NIOSII' in SOPC Builder design 'audio_soc'
 * SOPC Builder design path: ../../audio_soc.sopcinfo
 *
 * Generated: Wed Dec 03 01:30:49 CST 2025
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * AUDIO configuration
 *
 */

#define ALT_MODULE_CLASS_AUDIO altera_up_avalon_audio
#define AUDIO_BASE 0x11070
#define AUDIO_IRQ 2
#define AUDIO_IRQ_INTERRUPT_CONTROLLER_ID 0
#define AUDIO_NAME "/dev/AUDIO"
#define AUDIO_SPAN 16
#define AUDIO_TYPE "altera_up_avalon_audio"


/*
 * AUDIO_CONFIG configuration
 *
 */

#define ALT_MODULE_CLASS_AUDIO_CONFIG altera_up_avalon_audio_and_video_config
#define AUDIO_CONFIG_BASE 0x11060
#define AUDIO_CONFIG_IRQ -1
#define AUDIO_CONFIG_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AUDIO_CONFIG_NAME "/dev/AUDIO_CONFIG"
#define AUDIO_CONFIG_SPAN 16
#define AUDIO_CONFIG_TYPE "altera_up_avalon_audio_and_video_config"


/*
 * BUTTON_1 configuration
 *
 */

#define ALT_MODULE_CLASS_BUTTON_1 altera_avalon_pio
#define BUTTON_1_BASE 0x11050
#define BUTTON_1_BIT_CLEARING_EDGE_REGISTER 1
#define BUTTON_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUTTON_1_CAPTURE 1
#define BUTTON_1_DATA_WIDTH 1
#define BUTTON_1_DO_TEST_BENCH_WIRING 0
#define BUTTON_1_DRIVEN_SIM_VALUE 0
#define BUTTON_1_EDGE_TYPE "FALLING"
#define BUTTON_1_FREQ 50000000
#define BUTTON_1_HAS_IN 1
#define BUTTON_1_HAS_OUT 0
#define BUTTON_1_HAS_TRI 0
#define BUTTON_1_IRQ 4
#define BUTTON_1_IRQ_INTERRUPT_CONTROLLER_ID 0
#define BUTTON_1_IRQ_TYPE "EDGE"
#define BUTTON_1_NAME "/dev/BUTTON_1"
#define BUTTON_1_RESET_VALUE 0
#define BUTTON_1_SPAN 16
#define BUTTON_1_TYPE "altera_avalon_pio"


/*
 * BUTTON_2 configuration
 *
 */

#define ALT_MODULE_CLASS_BUTTON_2 altera_avalon_pio
#define BUTTON_2_BASE 0x11030
#define BUTTON_2_BIT_CLEARING_EDGE_REGISTER 1
#define BUTTON_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUTTON_2_CAPTURE 1
#define BUTTON_2_DATA_WIDTH 1
#define BUTTON_2_DO_TEST_BENCH_WIRING 0
#define BUTTON_2_DRIVEN_SIM_VALUE 0
#define BUTTON_2_EDGE_TYPE "FALLING"
#define BUTTON_2_FREQ 50000000
#define BUTTON_2_HAS_IN 1
#define BUTTON_2_HAS_OUT 0
#define BUTTON_2_HAS_TRI 0
#define BUTTON_2_IRQ 5
#define BUTTON_2_IRQ_INTERRUPT_CONTROLLER_ID 0
#define BUTTON_2_IRQ_TYPE "EDGE"
#define BUTTON_2_NAME "/dev/BUTTON_2"
#define BUTTON_2_RESET_VALUE 0
#define BUTTON_2_SPAN 16
#define BUTTON_2_TYPE "altera_avalon_pio"


/*
 * BUTTON_3 configuration
 *
 */

#define ALT_MODULE_CLASS_BUTTON_3 altera_avalon_pio
#define BUTTON_3_BASE 0x11020
#define BUTTON_3_BIT_CLEARING_EDGE_REGISTER 1
#define BUTTON_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUTTON_3_CAPTURE 1
#define BUTTON_3_DATA_WIDTH 1
#define BUTTON_3_DO_TEST_BENCH_WIRING 0
#define BUTTON_3_DRIVEN_SIM_VALUE 0
#define BUTTON_3_EDGE_TYPE "FALLING"
#define BUTTON_3_FREQ 50000000
#define BUTTON_3_HAS_IN 1
#define BUTTON_3_HAS_OUT 0
#define BUTTON_3_HAS_TRI 0
#define BUTTON_3_IRQ 6
#define BUTTON_3_IRQ_INTERRUPT_CONTROLLER_ID 0
#define BUTTON_3_IRQ_TYPE "EDGE"
#define BUTTON_3_NAME "/dev/BUTTON_3"
#define BUTTON_3_RESET_VALUE 0
#define BUTTON_3_SPAN 16
#define BUTTON_3_TYPE "altera_avalon_pio"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00010820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x11
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00008020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x11
#define ALT_CPU_NAME "NIOSII"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00008000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00010820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x11
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x11
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00008000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_FIFO
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_GEN2
#define __ALTERA_UP_AVALON_AUDIO
#define __ALTERA_UP_AVALON_AUDIO_AND_VIDEO_CONFIG


/*
 * FIFO configuration
 *
 */

#define ALT_MODULE_CLASS_FIFO altera_avalon_fifo
#define FIFO_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_BASE 0x11088
#define FIFO_BITS_PER_SYMBOL 16
#define FIFO_CHANNEL_WIDTH 8
#define FIFO_ERROR_WIDTH 8
#define FIFO_FIFO_DEPTH 1024
#define FIFO_IRQ -1
#define FIFO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_NAME "/dev/FIFO"
#define FIFO_SINGLE_CLOCK_MODE 1
#define FIFO_SPAN 4
#define FIFO_SYMBOLS_PER_BEAT 2
#define FIFO_TYPE "altera_avalon_fifo"
#define FIFO_USE_AVALONMM_READ_SLAVE 1
#define FIFO_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_USE_AVALONST_SINK 0
#define FIFO_USE_AVALONST_SOURCE 0
#define FIFO_USE_BACKPRESSURE 1
#define FIFO_USE_IRQ 1
#define FIFO_USE_PACKET 1
#define FIFO_USE_READ_CONTROL 0
#define FIFO_USE_REGISTER 0
#define FIFO_USE_WRITE_CONTROL 1


/*
 * JTAG_UART configuration
 *
 */

#define ALT_MODULE_CLASS_JTAG_UART altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x11080
#define JTAG_UART_IRQ 1
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/JTAG_UART"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * RAM configuration
 *
 */

#define ALT_MODULE_CLASS_RAM altera_avalon_onchip_memory2
#define RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_BASE 0x8000
#define RAM_CONTENTS_INFO ""
#define RAM_DUAL_PORT 0
#define RAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_INIT_CONTENTS_FILE "audio_soc_RAM"
#define RAM_INIT_MEM_CONTENT 1
#define RAM_INSTANCE_ID "NONE"
#define RAM_IRQ -1
#define RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_NAME "/dev/RAM"
#define RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_RAM_BLOCK_TYPE "AUTO"
#define RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_SINGLE_CLOCK_OP 0
#define RAM_SIZE_MULTIPLE 1
#define RAM_SIZE_VALUE 32768
#define RAM_SPAN 32768
#define RAM_TYPE "altera_avalon_onchip_memory2"
#define RAM_WRITABLE 1


/*
 * SEVEN_SEGMENTS configuration
 *
 */

#define ALT_MODULE_CLASS_SEVEN_SEGMENTS altera_avalon_pio
#define SEVEN_SEGMENTS_BASE 0x11040
#define SEVEN_SEGMENTS_BIT_CLEARING_EDGE_REGISTER 0
#define SEVEN_SEGMENTS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SEVEN_SEGMENTS_CAPTURE 0
#define SEVEN_SEGMENTS_DATA_WIDTH 28
#define SEVEN_SEGMENTS_DO_TEST_BENCH_WIRING 0
#define SEVEN_SEGMENTS_DRIVEN_SIM_VALUE 0
#define SEVEN_SEGMENTS_EDGE_TYPE "NONE"
#define SEVEN_SEGMENTS_FREQ 50000000
#define SEVEN_SEGMENTS_HAS_IN 0
#define SEVEN_SEGMENTS_HAS_OUT 1
#define SEVEN_SEGMENTS_HAS_TRI 0
#define SEVEN_SEGMENTS_IRQ -1
#define SEVEN_SEGMENTS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEVEN_SEGMENTS_IRQ_TYPE "NONE"
#define SEVEN_SEGMENTS_NAME "/dev/SEVEN_SEGMENTS"
#define SEVEN_SEGMENTS_RESET_VALUE 0
#define SEVEN_SEGMENTS_SPAN 16
#define SEVEN_SEGMENTS_TYPE "altera_avalon_pio"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/JTAG_UART"
#define ALT_STDERR_BASE 0x11080
#define ALT_STDERR_DEV JTAG_UART
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/JTAG_UART"
#define ALT_STDIN_BASE 0x11080
#define ALT_STDIN_DEV JTAG_UART
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/JTAG_UART"
#define ALT_STDOUT_BASE 0x11080
#define ALT_STDOUT_DEV JTAG_UART
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "audio_soc"


/*
 * TIMER configuration
 *
 */

#define ALT_MODULE_CLASS_TIMER altera_avalon_timer
#define TIMER_ALWAYS_RUN 0
#define TIMER_BASE 0x11000
#define TIMER_COUNTER_SIZE 32
#define TIMER_FIXED_PERIOD 1
#define TIMER_FREQ 50000000
#define TIMER_IRQ 0
#define TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_LOAD_VALUE 24999999
#define TIMER_MULT 0.001
#define TIMER_NAME "/dev/TIMER"
#define TIMER_PERIOD 500
#define TIMER_PERIOD_UNITS "ms"
#define TIMER_RESET_OUTPUT 0
#define TIMER_SNAPSHOT 1
#define TIMER_SPAN 32
#define TIMER_TICKS_PER_SEC 2
#define TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_TYPE "altera_avalon_timer"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

#endif /* __SYSTEM_H_ */
