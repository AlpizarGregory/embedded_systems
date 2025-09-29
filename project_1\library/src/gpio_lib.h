#ifndef GPIO_LIB_H
#define GPIO_LIB_H

typedef enum {
    NO_DIRECTION = 0,
    DIRECTION_AHEAD,
    DIRECTION_REVERSE,
    DIRECTION_LEFT,
    DIRECTION_RIGHT
} direction_t;

typedef enum {
    LIGHT_OFF = 0,
    FRONT_LIGHT_ON,
    BACK_LIGHT_ON,
    LEFT_LIGHT_ON,
    RIGHT_LIGHT_ON
} light_status_t;

// Function prototypes
int gpio_export(int gpio);
int gpio_unexport(int gpio);
int gpio_set_direction(int gpio, const char *direction);
int gpio_set_value(int gpio, int value);
int gpio_get_value(int gpio);

int boot_gpio_system(void);
void clean_gpio_system(void);

int servo_control(direction_t direccion);
int light_control(light_status_t estado);
void stop_movement(void);

#endif
