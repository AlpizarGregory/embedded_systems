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
    printf("1. Ahead\n");
    printf("2. Reverse\n");
    printf("3. Left\n");
    printf("4. Right\n");
    printf("5. Stop\n");
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
        if (scanf(" %c", &option) != 1) {
            // Handle error or log it, for now, just continue
            continue;
        }
        
        switch (option) {
            case '1':
                servo_control(DIRECTION_AHEAD);
                printf("Movement: FRONT\n");
                break;
            case '2':
                servo_control(DIRECTION_REVERSE);
                printf("Movement: REVERSE\n");
                break;
            case '3':
                servo_control(DIRECTION_LEFT);
                printf("Movement: LEFT\n");
                break;
            case '4':
                servo_control(DIRECTION_RIGHT);
                printf("Movement: RIGHT\n");
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
                printf("Luces: OFF\n");
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