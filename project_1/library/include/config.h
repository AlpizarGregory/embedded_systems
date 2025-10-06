#ifndef CONFIG_H
#define CONFIG_H

#define GPIO_BASE 512 //Offset

// GPIO pin definition (BCM numbering)
#define RIGHT_MOTOR_AHEAD  12
#define RIGHT_MOTOR_REVERSE   13
#define LEFT_MOTOR_AHEAD 18
#define LEFT_MOTOR_REVERSE 19

// Frequency and Period for PWM
#define PWM_FREQUENCY_HZ 1000
#define PWM_PERIOD_NS (1000000000 / PWM_FREQUENCY_HZ)

#define FRONT_LIGHT      (GPIO_BASE + 5)
#define BACK_LIGHT       (GPIO_BASE + 6)
#define LEFT_LIGHT       (GPIO_BASE + 12)
#define RIGHT_LIGHT      (GPIO_BASE + 13)

#define GPIO_EXPORT        "/sys/class/gpio/export"
#define GPIO_UNEXPORT      "/sys/class/gpio/unexport"
#define GPIO_DIR           "/sys/class/gpio/gpio%d/direction"
#define GPIO_VALUE         "/sys/class/gpio/gpio%d/value"

//PWM Routes

#define PWM_EXPORT         "/sys/class/pwm/pwmchip0/export"
#define PWM_UNEXPORT       "/sys/class/pwm/pwmchip0/unexport"
#define PWM_PERIOD(ch)     "/sys/class/pwm/pwmchip0/pwm%d/period"
#define PWM_DUTY_CYCLE(ch) "/sys/class/pwm/pwmchip0/pwm%d/duty_cycle"
#define PWM_ENABLE(ch)     "/sys/class/pwm/pwmchip0/pwm%d/enable"

#endif
