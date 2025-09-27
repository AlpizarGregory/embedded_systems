#ifndef CONFIG_H
#define CONFIG_H

// GPIO pin definition (BCM numbering)
#define MOTOR_ADELANTE_1   17
#define MOTOR_ADELANTE_2   18
#define MOTOR_ATRAS_1      22
#define MOTOR_ATRAS_2      23
#define MOTOR_IZQUIERDA_1  24
#define MOTOR_IZQUIERDA_2  25
#define MOTOR_DERECHA_1    26
#define MOTOR_DERECHA_2    27

#define LUZ_ADELANTE       5
#define LUZ_ATRAS          6
#define LUZ_IZQUIERDA      12
#define LUZ_DERECHA        13

#define GPIO_EXPORT        "/sys/class/gpio/export"
#define GPIO_UNEXPORT      "/sys/class/gpio/unexport"
#define GPIO_DIR           "/sys/class/gpio/gpio%d/direction"
#define GPIO_VALUE         "/sys/class/gpio/gpio%d/value"

#endif
