#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include "gpio_lib.h"
#include "../include/config.h"

// Basic GPIO and PWM functions (unchanged)
int gpio_export(int gpio) {
    FILE *fp = fopen(GPIO_EXPORT, "w");
    if (fp == NULL) {
        perror("Error opening export");
        return -1;
    }
    fprintf(fp, "%d", gpio);
    fclose(fp);
    usleep(100000); // Give the system time to create the directory
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

// --- MODIFIED FUNCTIONS ---

int boot_gpio_system(void) {
    // Export PWM channels for turning (previously forward movement)
    pwm_export_unexport(PWM_EXPORT, 0); // Right Motor
    pwm_export_unexport(PWM_EXPORT, 1); // Left Motor
    usleep(250000); 

    // Configure and enable PWM channels
    for (int i = 0; i < 2; i++) {
        pwm_write(PWM_PERIOD(i), i, PWM_PERIOD_NS);
        pwm_write(PWM_DUTY_CYCLE(i), i, 0); // Start with motors off
        pwm_write(PWM_ENABLE(i), i, 1);
    }

    // Export GPIOs for lights
    int light_pins[] = { FRONT_LIGHT, BACK_LIGHT, LEFT_LIGHT, RIGHT_LIGHT };
    for (int i = 0; i < 4; i++) {
        if (gpio_export(light_pins[i]) != 0) {
            fprintf(stderr, "Error: Failed to export light GPIO %d\n", light_pins[i]);
            return -1;
        }
        if (gpio_set_direction(light_pins[i], "out") != 0) return -1;
        if (gpio_set_value(light_pins[i], 0) != 0) return -1;
    }
    
    // Export GPIOs for forward movement
    int forward_pins[] = { LEFT_MOTOR_FORWARD, RIGHT_MOTOR_FORWARD };
    for (int i = 0; i < 2; i++) {
        if (gpio_export(forward_pins[i]) != 0) {
            fprintf(stderr, "Error: Failed to export forward GPIO %d\n", forward_pins[i]);
            return -1;
        }
        if (gpio_set_direction(forward_pins[i], "out") != 0) return -1;
        if (gpio_set_value(forward_pins[i], 0) != 0) return -1;
    }

    // Export GPIOs for reverse movement
    int reverse_pins[] = { LEFT_MOTOR_REVERSE, RIGHT_MOTOR_REVERSE };
    for (int i = 0; i < 2; i++) {
        if (gpio_export(reverse_pins[i]) != 0) {
            fprintf(stderr, "Error: Failed to export reverse GPIO %d\n", reverse_pins[i]);
            return -1;
        }
        if (gpio_set_direction(reverse_pins[i], "out") != 0) return -1;
        if (gpio_set_value(reverse_pins[i], 0) != 0) return -1;
    }
    
    return 0;
}

void clean_gpio_system(void) {
    stop_movement();
    light_control(LIGHT_OFF);

    // PWM cleanup
    for (int i = 0; i < 2; i++) {
        pwm_write(PWM_ENABLE(i), i, 0);
    }
    pwm_export_unexport(PWM_UNEXPORT, 0);
    pwm_export_unexport(PWM_UNEXPORT, 1);

    // GPIO cleanup for lights
    int light_pins[] = { FRONT_LIGHT, BACK_LIGHT, LEFT_LIGHT, RIGHT_LIGHT };
    for (int i = 0; i < 4; i++) {
        gpio_unexport(light_pins[i]);
    }

    // GPIO cleanup for forward pins
    int forward_pins[] = { LEFT_MOTOR_FORWARD, RIGHT_MOTOR_FORWARD };
    for (int i = 0; i < 2; i++) {
        gpio_unexport(forward_pins[i]);
    }

    // GPIO cleanup for reverse pins
    int reverse_pins[] = { LEFT_MOTOR_REVERSE, RIGHT_MOTOR_REVERSE };
    for (int i = 0; i < 2; i++) {
        gpio_unexport(reverse_pins[i]);
    }
}

void stop_movement(void) {
    // Turn off PWM motors (for turning)
    pwm_write(PWM_DUTY_CYCLE(0), 0, 0);
    pwm_write(PWM_DUTY_CYCLE(1), 1, 0);
    
    // Turn off GPIO motors (forward)
    gpio_set_value(LEFT_MOTOR_FORWARD, 0);
    gpio_set_value(RIGHT_MOTOR_FORWARD, 0);

    // Turn off GPIO motors (reverse)
    gpio_set_value(LEFT_MOTOR_REVERSE, 0);
    gpio_set_value(RIGHT_MOTOR_REVERSE, 0);
    light_control(LIGHT_OFF);
}

int motor_control(direction_t direction, int speed) {
    if (speed < 0) speed = 0;
    if (speed > 100) speed = 100;
    
    long duty_cycle_ns = (speed * (long)PWM_PERIOD_NS) / 100;
    
    // Stop any previous movement before starting a new one
    stop_movement();

    // --- REWRITTEN MOVEMENT LOGIC ---
    switch (direction) {
        case DIRECTION_AHEAD:
            // Forward: Both motors use GPIO (no speed control)
            gpio_set_value(RIGHT_MOTOR_FORWARD, 1); // Right motor forward
            gpio_set_value(LEFT_MOTOR_FORWARD, 1);  // Left motor forward
            light_control(FRONT_LIGHT_ON);
            break;

        case DIRECTION_REVERSE:
            // Reverse: Both motors use GPIO (no speed control)
            gpio_set_value(RIGHT_MOTOR_REVERSE, 1); // Right motor reverse
            gpio_set_value(LEFT_MOTOR_REVERSE, 1);  // Left motor reverse
            light_control(BACK_LIGHT_ON);
            break;

        case DIRECTION_LEFT: // Turn left
            // Right motor forward (PWM), left motor reverse (GPIO)
            pwm_write(PWM_DUTY_CYCLE(0), 0, duty_cycle_ns); // Right motor forward
            gpio_set_value(LEFT_MOTOR_REVERSE, 1);  // Left motor reverse
            light_control(LEFT_LIGHT_ON);
            break;

        case DIRECTION_RIGHT: // Turn right
            // Left motor forward (PWM), right motor reverse (GPIO)
            pwm_write(PWM_DUTY_CYCLE(1), 1, duty_cycle_ns); // Left motor forward
            gpio_set_value(RIGHT_MOTOR_REVERSE, 1); // Right motor reverse
            light_control(RIGHT_LIGHT_ON);
            break;

        case NO_DIRECTION:
        default:
            // Do nothing (stop_movement was already called)
            break;
    }
    
    return 0;
}

int light_control(light_status_t status) {
    // This function requires no changes
    gpio_set_value(FRONT_LIGHT, 0);
    gpio_set_value(BACK_LIGHT, 0);
    gpio_set_value(LEFT_LIGHT, 0);
    gpio_set_value(RIGHT_LIGHT, 0);
    
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
    
    return 0;
}
