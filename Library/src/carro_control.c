#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include "gpio_lib.h"

volatile sig_atomic_t stop = 0;

void signal_handler(int sig) {
    stop = 1;
}

void mostrar_menu(void) {
    printf("\n=== CONTROL DEL CARRO ===\n");
    printf("1. Adelante\n");
    printf("2. Atras\n");
    printf("3. Izquierda\n");
    printf("4. Derecha\n");
    printf("5. Stop\n");
    printf("6. Luz Adelante\n");
    printf("7. Luz Atras\n");
    printf("8. Luz Izquierda\n");
    printf("9. Luz Derecha\n");
    printf("0. Apagar Luces\n");
    printf("q. Salir\n");
    printf("Seleccione opcion: ");
}

int main() {
    char opcion;
    
    // Configure signal handler
    signal(SIGINT, signal_handler);
    
    printf("Inicializando sistema GPIO...\n");
    
    if (inicializar_sistema_gpio() != 0) {
        printf("Error inicializando GPIOs\n");
        return -1;
    }
    
    printf("Sistema inicializado correctamente\n");
    
    while (!stop) {
        mostrar_menu();
        scanf(" %c", &opcion);
        
        switch (opcion) {
            case '1':
                controlar_motor(DIRECCION_ADELANTE);
                printf("Movimiento: ADELANTE\n");
                break;
            case '2':
                controlar_motor(DIRECCION_ATRAS);
                printf("Movimiento: ATRAS\n");
                break;
            case '3':
                controlar_motor(DIRECCION_IZQUIERDA);
                printf("Movimiento: IZQUIERDA\n");
                break;
            case '4':
                controlar_motor(DIRECCION_DERECHA);
                printf("Movimiento: DERECHA\n");
                break;
            case '5':
                detener_movimiento();
                printf("Movimiento: DETENIDO\n");
                break;
            case '6':
                controlar_luz(LUZ_ADELANTE_ON);
                printf("Luz: ADELANTE\n");
                break;
            case '7':
                controlar_luz(LUZ_ATRAS_ON);
                printf("Luz: ATRAS\n");
                break;
            case '8':
                controlar_luz(LUZ_IZQUIERDA_ON);
                printf("Luz: IZQUIERDA\n");
                break;
            case '9':
                controlar_luz(LUZ_DERECHA_ON);
                printf("Luz: DERECHA\n");
                break;
            case '0':
                controlar_luz(LUZ_APAGADA);
                printf("Luces: APAGADAS\n");
                break;
            case 'q':
                stop = 1;
                break;
            default:
                printf("Opcion no valida\n");
                break;
        }
    }
    
    printf("\nLimpiando sistema...\n");
    limpiar_sistema_gpio();
    printf("Sistema apagado correctamente\n");
    
    return 0;
}
