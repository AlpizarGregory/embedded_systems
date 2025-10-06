#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include "gpio_lib.h"

// The signal handler remains the same
volatile sig_atomic_t stop = 0;
void signal_handler(int sig __attribute__((unused))) {
    stop = 1;
}

// Change main to accept command-line arguments
int main(int argc, char *argv[]) {
    // Check if enough arguments were provided. We need at least 3:
    // argv[0]: ./car_control
    // argv[1]: action (move/light)
    // argv[2]: direction
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <move|light> <direction> [speed]\n", argv[0]);
        fprintf(stderr, "Example: %s move front 80\n", argv[0]);
        fprintf(stderr, "Example: %s light left\n", argv[0]);
        return 1; // Return an error code
    }

    // Get action, direction and speed from argv
    char *action = argv[1];
    char *direction = argv[2];
    int speed = 0;

    // A "move" action requires a speed argument
    if (strcmp(action, "move") == 0 && argc < 4) {
        fprintf(stderr, "Error: 'move' action requires a speed parameter.\n");
        fprintf(stderr, "Usage: %s move <direction> <speed>\n", argv[0]);
        return 1;
    }
    
    // Get speed from argv[3] only if it exists, converting it from string to int
    if (argc >= 4) {
        speed = atoi(argv[3]);
    }

    // --- The program logic starts here, no need for scanf ---

    signal(SIGINT, signal_handler);
    
    printf("Booting GPIO Systems...\n");
    if (boot_gpio_system() != 0) {
        printf("Error Initializing GPIOs\n");
        return -1;
    }
    
    printf("System booted correctly\n");

    // Process the command received from the arguments
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
        // The speed argument is ignored for the 'light' action, as requested
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