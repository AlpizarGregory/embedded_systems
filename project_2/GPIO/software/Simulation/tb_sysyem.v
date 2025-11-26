`timescale 1ns / 1ps

module tb_system;

    // Señales de simulación
    reg clk;
    reg reset_n;
    reg [3:0] gpio_in;
    wire [3:0] leds;

    // Instancia del sistema (reemplaza 'system' por el nombre de tu top module)
    system uut (
        .clk(clk),
        .reset_n(reset_n),
        .gpio_in(gpio_in),
        .leds(leds)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock de 100 MHz (período 10 ns)
    end

    // Secuencia de reset
    initial begin
        reset_n = 0;
        #20;
        reset_n = 1; // Libera reset
    end

    // Simulación de GPIO y flancos
    initial begin
        gpio_in = 4'b0000;

        // Esperar a que termine el reset
        #30;

        // Simular flanco en pin 0
        gpio_in[0] = 1;
        #10;
        gpio_in[0] = 0;
        #10;

        // Flanco en pin 1
        gpio_in[1] = 1;
        #10;
        gpio_in[1] = 0;
        #10;

        // Flanco en pin 2 y 3 juntos
        gpio_in[2] = 1;
        gpio_in[3] = 1;
        #10;
        gpio_in[2] = 0;
        gpio_in[3] = 0;
        #10;

        // Fin de simulación
        #50;
        $stop;
    end

endmodule