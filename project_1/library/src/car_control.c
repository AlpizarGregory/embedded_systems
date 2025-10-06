#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include "gpio_lib.h"

volatile sig_atomic_t stop = 0;

void signal_handler(int sig __attribute__((unused))) {
    stop = 1;
}

int main() {
    char action[10], direction[10];
    int speed = 0;
    
    // Configure signal handler
    signal(SIGINT, signal_handler);
    
    printf("Booting GPIO Systems...\n");
    if (boot_gpio_system() != 0) {
        printf("Error Initializing GPIOs\n");
        return -1;
    }
    
    printf("System booted correctly\n");
    
    printf("Enter command (e.g., move front 80) or (light left 0): ");
    
    // Read the three parts of the input command
    if (scanf("%9s %9s %d", action, direction, &speed) < 2) {
        printf("Invalid input format.\n");
        clean_gpio_system();
        return 1;
    }

    if (strcmp(action, "move") == 0) {
        if (strcmp(direction, "front") == 0) {
            motor_control(DIRECTION_AHEAD, speed);
            printf("Action: MOVING AHEAD at %d%% speed\n", speed);
        } else if (strcmp(direction, "rear") == 0) {
            motor_control(DIRECTION_REVERSE, speed);
            printf("Action: MOVING REVERSE at %d%% speed\n", speed);
        } else if (strcmp(direction, "left") == 0) {
            motor_control(DIRECTION_LEFT, speed);
            printf("Action: TURNING LEFT at %d%% speed\n", speed);
        } else if (strcmp(direction, "right") == 0) {
            motor_control(DIRECTION_RIGHT, speed);
            printf("Action: TURNING RIGHT at %d%% speed\n", speed);
        } else {
            printf("Invalid move direction: %s\n", direction);
        }
    } else if (strcmp(action, "light") == 0) {
        if (strcmp(direction, "front") == 0) {
            light_control(FRONT_LIGHT_ON);
            printf("Action: FRONT light ON\n");
        } else if (strcmp(direction, "rear") == 0) {
            light_control(BACK_LIGHT_ON);
            printf("Action: BACK light ON\n");
        } else if (strcmp(direction, "left") == 0) {
            light_control(LEFT_LIGHT_ON);
            printf("Action: LEFT light ON\n");
        } else if (strcmp(direction, "right") == 0) {
            light_control(RIGHT_LIGHT_ON);
            printf("Action: RIGHT light ON\n");
        } else {
            printf("Invalid light direction: %s\n", direction);
        }
    } else {
        printf("Invalid action: %s\n", action);
    }

    // Hold the action for 2 seconds
    if (!stop) {
        printf("Executing for 2 seconds...\n");
        sleep(2);
    }
    
    printf("\nCleaning System...\n");
    clean_gpio_system();
    printf("System Shut Down\n");
    
    return 0;
}