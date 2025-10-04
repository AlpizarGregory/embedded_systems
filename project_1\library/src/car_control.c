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

void show_menu(void) {
    printf("\n=== CAR CONTROL ===\n");
    printf("Movement (command speed), e.g., '1 80' for 80%% speed\n");
    printf("1. Ahead\n");
    printf("2. Reverse\n");
    printf("3. Left\n");
    printf("4. Right\n");
    printf("5. Stop\n");
    printf("Lights (command only)\n");
    printf("6. Front Light\n");
    printf("7. Back Light\n");
    printf("8. Left Light\n");
    printf("9. Right Light\n");
    printf("0. Lights Off\n");
    printf("q. Exit\n");
    printf("Select Option: ");
}

int main() {
    char option;
    int speed = 0;
    
    // Configure signal handler
    signal(SIGINT, signal_handler);
    
    printf("Booting GPIO Systems...\n");
    if (boot_gpio_system() != 0) {
        printf("Error Initializing GPIOs\n");
        return -1;
    }
    
    printf("System booted correctly\n");
    
    while (!stop) {
        show_menu();
        
        // Read character choice
        if (scanf(" %c", &option) != 1) {
            // Clean buffer in case of error
            while(getchar() != '\n'); 
            continue;
        }

        // If movement option, also read speed
        if (option >= '1' && option <= '4') {
            if (scanf("%d", &speed) != 1) {
                printf("Please provide a speed (0-100) after the command.\n");
                // Clean buffer if speed is invalid
                while(getchar() != '\n');
                continue;
            }
        }
        
        // Clean every remaining character
        while(getchar() != '\n');

        switch (option) {
            case '1':
                motor_control(DIRECTION_AHEAD, speed);
                printf("Movement: AHEAD at %d%% speed\n", speed);
                break;
            case '2':
                motor_control(DIRECTION_REVERSE, speed);
                printf("Movement: REVERSE at %d%% speed\n", speed);
                break;
            case '3':
                motor_control(DIRECTION_LEFT, speed);
                printf("Movement: LEFT at %d%% speed\n", speed);
                break;
            case '4':
                motor_control(DIRECTION_RIGHT, speed);
                printf("Movement: RIGHT at %d%% speed\n", speed);
                break;
            case '5':
                stop_movement();
                printf("Movement: STOPPED\n");
                break;
            case '6':
                light_control(FRONT_LIGHT_ON);
                printf("Light: FRONT\n");
                break;
            case '7':
                light_control(BACK_LIGHT_ON);
                printf("Light: BACK\n");
                break;
            case '8':
                light_control(LEFT_LIGHT_ON);
                printf("Light: LEFT\n");
                break;
            case '9':
                light_control(RIGHT_LIGHT_ON);
                printf("Light: RIGHT\n");
                break;
            case '0':
                light_control(LIGHT_OFF);
                printf("Lights: OFF\n");
                break;
            case 'q':
                stop = 1;
                break;
            default:
                printf("Invalid Option\n");
                break;
        }
    }
    
    printf("\nCleaning System...\n");
    clean_gpio_system();
    printf("System Shut Down\n");
    
    return 0;
}