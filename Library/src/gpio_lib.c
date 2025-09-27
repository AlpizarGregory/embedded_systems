#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include "gpio_lib.h"
#include "../include/config.h"

// Global variables for current states
static direccion_t direccion_actual = DIRECCION_NINGUNA;
static estado_luz_t luz_actual = LUZ_APAGADA;

int gpio_export(int gpio) {
    FILE *fp = fopen(GPIO_EXPORT, "w");
    if (fp == NULL) {
        perror("Error abriendo export");
        return -1;
    }
    fprintf(fp, "%d", gpio);
    fclose(fp);
    
    // Wait until the system creates the directory
    usleep(100000);
    return 0;
}

int gpio_unexport(int gpio) {
    FILE *fp = fopen(GPIO_UNEXPORT, "w");
    if (fp == NULL) {
        perror("Error abriendo unexport");
        return -1;
    }
    fprintf(fp, "%d", gpio);
    fclose(fp);
    return 0;
}

int gpio_set_direction(int gpio, const char *direction) {
    char path[50];
    sprintf(path, GPIO_DIR, gpio);
    
    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        perror("Error abriendo direction");
        return -1;
    }
    fprintf(fp, "%s", direction);
    fclose(fp);
    return 0;
}

int gpio_set_value(int gpio, int value) {
    char path[50];
    sprintf(path, GPIO_VALUE, gpio);
    
    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        perror("Error abriendo value");
        return -1;
    }
    fprintf(fp, "%d", value);
    fclose(fp);
    return 0;
}

int gpio_get_value(int gpio) {
    char path[50];
    char value_str[3];
    sprintf(path, GPIO_VALUE, gpio);
    
    FILE *fp = fopen(path, "r");
    if (fp == NULL) {
        perror("Error leyendo value");
        return -1;
    }
    fgets(value_str, 3, fp);
    fclose(fp);
    return atoi(value_str);
}

int inicializar_sistema_gpio(void) {
    int pines_motores[] = {
        MOTOR_ADELANTE_1, MOTOR_ADELANTE_2,
        MOTOR_ATRAS_1, MOTOR_ATRAS_2,
        MOTOR_IZQUIERDA_1, MOTOR_IZQUIERDA_2,
        MOTOR_DERECHA_1, MOTOR_DERECHA_2
    };
    
    int pines_luces[] = {
        LUZ_ADELANTE, LUZ_ATRAS,
        LUZ_IZQUIERDA, LUZ_DERECHA
    };
    
    // Export and configure motor pins
    for (int i = 0; i < 8; i++) {
        if (gpio_export(pines_motores[i]) != 0) return -1;
        if (gpio_set_direction(pines_motores[i], "out") != 0) return -1;
        if (gpio_set_value(pines_motores[i], 0) != 0) return -1;
    }
    
    // Export and configure light pins
    for (int i = 0; i < 4; i++) {
        if (gpio_export(pines_luces[i]) != 0) return -1;
        if (gpio_set_direction(pines_luces[i], "out") != 0) return -1;
        if (gpio_set_value(pines_luces[i], 0) != 0) return -1;
    }
    
    return 0;
}

void limpiar_sistema_gpio(void) {
    int pines_motores[] = {
        MOTOR_ADELANTE_1, MOTOR_ADELANTE_2,
        MOTOR_ATRAS_1, MOTOR_ATRAS_2,
        MOTOR_IZQUIERDA_1, MOTOR_IZQUIERDA_2,
        MOTOR_DERECHA_1, MOTOR_DERECHA_2
    };
    
    int pines_luces[] = {
        LUZ_ADELANTE, LUZ_ATRAS,
        LUZ_IZQUIERDA, LUZ_DERECHA
    };
    
    // Shut down before unexport
    detener_movimiento();
    controlar_luz(LUZ_APAGADA);
    
    // Unexport pines
    for (int i = 0; i < 8; i++) {
        gpio_unexport(pines_motores[i]);
    }
    
    for (int i = 0; i < 4; i++) {
        gpio_unexport(pines_luces[i]);
    }
}

void detener_movimiento(void) {
    // Shut down motors
    int pines_motores[] = {
        MOTOR_ADELANTE_1, MOTOR_ADELANTE_2,
        MOTOR_ATRAS_1, MOTOR_ATRAS_2,
        MOTOR_IZQUIERDA_1, MOTOR_IZQUIERDA_2,
        MOTOR_DERECHA_1, MOTOR_DERECHA_2
    };
    
    for (int i = 0; i < 8; i++) {
        gpio_set_value(pines_motores[i], 0);
    }
    
    direccion_actual = DIRECCION_NINGUNA;
}

int controlar_motor(direccion_t direccion) {
    // Stop current movement
    detener_movimiento();
    
    // Configure new direction
    switch (direccion) {
        case DIRECCION_ADELANTE:
            gpio_set_value(MOTOR_ADELANTE_1, 1);
            gpio_set_value(MOTOR_ADELANTE_2, 0);
            break;
            
        case DIRECCION_ATRAS:
            gpio_set_value(MOTOR_ATRAS_1, 1);
            gpio_set_value(MOTOR_ATRAS_2, 0);
            break;
            
        case DIRECCION_IZQUIERDA:
            gpio_set_value(MOTOR_IZQUIERDA_1, 1);
            gpio_set_value(MOTOR_IZQUIERDA_2, 0);
            break;
            
        case DIRECCION_DERECHA:
            gpio_set_value(MOTOR_DERECHA_1, 1);
            gpio_set_value(MOTOR_DERECHA_2, 0);
            break;
            
        case DIRECCION_NINGUNA:
        default:
            break;
    }
    
    direccion_actual = direccion;
    
    // If movement, turn on corresponding lights
    if (direccion != DIRECCION_NINGUNA) {
        estado_luz_t luz_direccion = LUZ_APAGADA;
        
        switch (direccion) {
            case DIRECCION_ADELANTE: luz_direccion = LUZ_ADELANTE_ON; break;
            case DIRECCION_ATRAS: luz_direccion = LUZ_ATRAS_ON; break;
            case DIRECCION_IZQUIERDA: luz_direccion = LUZ_IZQUIERDA_ON; break;
            case DIRECCION_DERECHA: luz_direccion = LUZ_DERECHA_ON; break;
            default: break;
        }
        
        controlar_luz(luz_direccion);
    }
    
    return 0;
}

int controlar_luz(estado_luz_t estado) {
    // Turn all lights off first
    gpio_set_value(LUZ_ADELANTE, 0);
    gpio_set_value(LUZ_ATRAS, 0);
    gpio_set_value(LUZ_IZQUIERDA, 0);
    gpio_set_value(LUZ_DERECHA, 0);
    
    // Encender luz específica
    switch (estado) {
        case LUZ_ADELANTE_ON:
            gpio_set_value(LUZ_ADELANTE, 1);
            break;
        case LUZ_ATRAS_ON:
            gpio_set_value(LUZ_ATRAS, 1);
            break;
        case LUZ_IZQUIERDA_ON:
            gpio_set_value(LUZ_IZQUIERDA, 1);
            break;
        case LUZ_DERECHA_ON:
            gpio_set_value(LUZ_DERECHA, 1);
            break;
        case LUZ_APAGADA:
        default:
            break;
    }
    
    luz_actual = estado;
    return 0;
}
