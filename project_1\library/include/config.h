#ifndef CONFIG_H
#define CONFIG_H

// GPIO pin definition (BCM numbering)
#define SERVO_AHEAD_1   17
#define SERVO_AHEAD_2   18
#define SERVO_REVERSE_1      22
#define SERVO_REVERSE_2      23
#define SERVO_LEFT_1 24
#define SERVO_LEFT_2  25
#define SERVO_RIGHT_1    26
#define SERVO_RIGHT_2    27

#define FRONT_LIGHT      5
#define BACK_LIGHT          6
#define LEFT_LIGHT      12
#define RIGHT_LIGHT        13

#define GPIO_EXPORT        "/sys/class/gpio/export"
#define GPIO_UNEXPORT      "/sys/class/gpio/unexport"
#define GPIO_DIR           "/sys/class/gpio/gpio%d/direction"
#define GPIO_VALUE         "/sys/class/gpio/gpio%d/value"

#endif
