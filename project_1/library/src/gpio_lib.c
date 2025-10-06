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

int pwm_write(const char *path_format, int channel, long value) {
    char path[100];
    sprintf(path, path_format, channel);
    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        perror("Error opening PWM file");
        fprintf(stderr, "Failed on path: %s\n", path);
        return -1;
    }
    fprintf(fp, "%ld", value);
    fclose(fp);
    return 0;
}

int pwm_export_unexport(const char* path, int channel) {
    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        perror("Error opening PWM export/unexport");
        return -1;
    }
    fprintf(fp, "%d", channel);
    fclose(fp);
    return 0;
}

int boot_gpio_system(void) {
    // Export pwm channels
    pwm_export_unexport(PWM_EXPORT, 0);
    pwm_export_unexport(PWM_EXPORT, 1);
    usleep(250000); //Delay for directory creation

    // Configure and enable channels
    for (int i = 0; i < 2; i++) {
        pwm_write(PWM_PERIOD(i), i, PWM_PERIOD_NS);
        pwm_write(PWM_DUTY_CYCLE(i), i, 0); // Begins at 0 speed
        pwm_write(PWM_ENABLE(i), i, 1);     // Enable pwm output
    }

    // Light settings
    int light_pins[] = { FRONT_LIGHT, BACK_LIGHT, LEFT_LIGHT, RIGHT_LIGHT };
    for (int i = 0; i < 4; i++) {
        if (gpio_export(light_pins[i]) != 0) return -1;
        if (gpio_set_direction(light_pins[i], "out") != 0) return -1;
        if (gpio_set_value(light_pins[i], 0) != 0) return -1;
    }
    
    return 0;
}

void clean_gpio_system(void) {
    stop_movement();
    light_control(LIGHT_OFF);

    // PWM cleaning
    for (int i = 0; i < 2; i++) {
        pwm_write(PWM_ENABLE(i), i, 0); // Disable PWM
    }
    pwm_export_unexport(PWM_UNEXPORT, 0);
    pwm_export_unexport(PWM_UNEXPORT, 1);

    // GPIO cleaning for lights
    int light_pins[] = { FRONT_LIGHT, BACK_LIGHT, LEFT_LIGHT, RIGHT_LIGHT };
    for (int i = 0; i < 4; i++) {
        gpio_unexport(light_pins[i]);
    }
}

void stop_movement(void) {
    // Turn off all engines
    pwm_write(PWM_DUTY_CYCLE(0), 0, 0);
    pwm_write(PWM_DUTY_CYCLE(1), 1, 0);
    current_direction = NO_DIRECTION;
}

int motor_control(direction_t direction, int speed) {
    if (speed < 0) speed = 0;
    if (speed > 100) speed = 100;
    
    // Calculate duty cycle
    long duty_cycle_ns = (speed * (long)PWM_PERIOD_NS) / 100;
    
    stop_movement(); // Stop previous movements

    switch (direction) {
        case DIRECTION_AHEAD:
            // Both engines ahead
            pwm_write(PWM_DUTY_CYCLE(0), 0, duty_cycle_ns);
            break;
        case DIRECTION_REVERSE:
            // Both engines backwards
            pwm_write(PWM_DUTY_CYCLE(1), 1, duty_cycle_ns);
            break;
        case DIRECTION_LEFT:
            // Right engine ahead, left engine back
            pwm_write(PWM_DUTY_CYCLE(0), 0, duty_cycle_ns);
            pwm_write(PWM_DUTY_CYCLE(1), 1, duty_cycle_ns);
            break;
        case DIRECTION_RIGHT:
            // Left engine ahead, right engine backwards
            pwm_write(PWM_DUTY_CYCLE(0), 0, duty_cycle_ns);
            pwm_write(PWM_DUTY_CYCLE(1), 1, duty_cycle_ns);
            break;
        case NO_DIRECTION:
        default:
            break;
    }
    
    current_direction = direction;
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