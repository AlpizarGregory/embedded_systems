#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include "gpio_lib.h"
#include "../include/config.h"

// Global variables for current states
static direction_t current_direction = NO_DIRECTION;
static light_status_t current_light = LIGHT_OFF;

int gpio_export(int gpio) {
    FILE *fp = fopen(GPIO_EXPORT, "w");
    if (fp == NULL) {
        perror("Error opening export");
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
        perror("Error opening unexport");
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
        perror("Error opening direction");
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
        perror("Error opening value");
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
        perror("Error reading value");
        return -1;
    }
    if (fgets(value_str, 3, fp) == NULL) {
        // Handle error or log it, for now, just return -1
        fclose(fp);
        return -1;
    }
    fclose(fp);
    return atoi(value_str);
}

int boot_gpio_system(void) {
    int servo_pins[] = {
        SERVO_AHEAD_1, SERVO_AHEAD_2,
        SERVO_REVERSE_1, SERVO_REVERSE_2,
        SERVO_LEFT_1, SERVO_LEFT_2,
        SERVO_RIGHT_1, SERVO_RIGHT_2
    };
    
    int light_pins[] = {
        FRONT_LIGHT, BACK_LIGHT,
        LEFT_LIGHT, RIGHT_LIGHT
    };
    
    // Export and configure servo pins
    for (int i = 0; i < 8; i++) {
        if (gpio_export(servo_pins[i]) != 0) return -1;
        if (gpio_set_direction(servo_pins[i], "out") != 0) return -1;
        if (gpio_set_value(servo_pins[i], 0) != 0) return -1;
    }
    
    // Export and configure light pins
    for (int i = 0; i < 4; i++) {
        if (gpio_export(light_pins[i]) != 0) return -1;
        if (gpio_set_direction(light_pins[i], "out") != 0) return -1;
        if (gpio_set_value(light_pins[i], 0) != 0) return -1;
    }
    
    return 0;
}

void clean_gpio_system(void) {
    int servo_pins[] = {
        SERVO_AHEAD_1, SERVO_AHEAD_2,
        SERVO_REVERSE_1, SERVO_REVERSE_2,
        SERVO_LEFT_1, SERVO_LEFT_2,
        SERVO_RIGHT_1, SERVO_RIGHT_2
    };
    
    int light_pins[] = {
        FRONT_LIGHT, BACK_LIGHT,
        LEFT_LIGHT, RIGHT_LIGHT
    };
    
    // Shut down before unexport
    stop_movement();
    light_control(LIGHT_OFF);
    
    // Unexport pines
    for (int i = 0; i < 8; i++) {
        gpio_unexport(servo_pins[i]);
    }
    
    for (int i = 0; i < 4; i++) {
        gpio_unexport(light_pins[i]);
    }
}

void stop_movement(void) {
    // Shut down servos
    int servo_pins[] = {
        SERVO_AHEAD_1, SERVO_AHEAD_2,
        SERVO_REVERSE_1, SERVO_REVERSE_2,
        SERVO_LEFT_1, SERVO_LEFT_2,
        SERVO_RIGHT_1, SERVO_RIGHT_2
    };
    
    for (int i = 0; i < 8; i++) {
        gpio_set_value(servo_pins[i], 0);
    }
    
    current_direction = NO_DIRECTION;
}

int servo_control(direction_t direction) {
    // Stop current movement
    stop_movement();
    
    // Configure new direction
    switch (direction) {
        case DIRECTION_AHEAD:
            gpio_set_value(SERVO_AHEAD_1, 1);
            gpio_set_value(SERVO_AHEAD_2, 0);
            break;
            
        case DIRECTION_REVERSE:
            gpio_set_value(SERVO_REVERSE_1, 1);
            gpio_set_value(SERVO_REVERSE_2, 0);
            break;
            
        case DIRECTION_LEFT:
            gpio_set_value(SERVO_LEFT_1, 1);
            gpio_set_value(SERVO_LEFT_2, 0);
            break;
            
        case DIRECTION_RIGHT:
            gpio_set_value(SERVO_RIGHT_1, 1);
            gpio_set_value(SERVO_RIGHT_2, 0);
            break;
            
        case NO_DIRECTION:
        default:
            break;
    }
    
    current_direction = direction;
    
    // If movement, turn on corresponding lights
    if (direction != NO_DIRECTION) {
        light_status_t light_direction = LIGHT_OFF;
        
        switch (direction) {
            case DIRECTION_AHEAD: light_direction = FRONT_LIGHT_ON; break;
            case DIRECTION_REVERSE: light_direction = BACK_LIGHT_ON; break;
            case DIRECTION_LEFT: light_direction = LEFT_LIGHT_ON; break;
            case DIRECTION_RIGHT: light_direction = RIGHT_LIGHT_ON; break;
            default: break;
        }
        
        light_control(light_direction);
    }
    
    return 0;
}

int light_control(light_status_t status) {
    // Turn all lights off first
    gpio_set_value(FRONT_LIGHT, 0);
    gpio_set_value(BACK_LIGHT, 0);
    gpio_set_value(LEFT_LIGHT, 0);
    gpio_set_value(RIGHT_LIGHT, 0);
    
    // Turn on a specific light
    switch (status) {
        case FRONT_LIGHT_ON:
            gpio_set_value(FRONT_LIGHT, 1);
            break;
        case BACK_LIGHT_ON:
            gpio_set_value(BACK_LIGHT, 1);
            break;
        case LEFT_LIGHT_ON:
            gpio_set_value(LEFT_LIGHT, 1);
            break;
        case RIGHT_LIGHT_ON:
            gpio_set_value(RIGHT_LIGHT, 1);
            break;
        case LIGHT_OFF:
        default:
            break;
    }
    
    current_light = status;
    return 0;
}