#ifndef CONFIG_H
#define CONFIG_H

// THIS IS THE KEY: The GPIO base offset for your specific Yocto kernel
#define GPIO_BASE 512

// --- GPIO pin definitions using the correct base offset ---

// REVERSE MOVEMENT PINS (GPIO)
#define LEFT_MOTOR_REVERSE   (GPIO_BASE + 23)
#define RIGHT_MOTOR_REVERSE  (GPIO_BASE + 24)

// LIGHT PINS (GPIO) - Non-conflicting pins
#define FRONT_LIGHT      (GPIO_BASE + 5)
#define BACK_LIGHT       (GPIO_BASE + 6)
#define LEFT_LIGHT       (GPIO_BASE + 20)
#define RIGHT_LIGHT      (GPIO_BASE + 21)

// --- PWM Configuration (This remains the same) ---
#define PWM_FREQUENCY_HZ 1000
#define PWM_PERIOD_NS (1000000000 / PWM_FREQUENCY_HZ)

// Filesystem paths for GPIO (Correct for sysfs)
#define GPIO_EXPORT        "/sys/class/gpio/export"
#define GPIO_UNEXPORT      "/sys/class/gpio/unexport"
#define GPIO_DIR           "/sys/class/gpio/gpio%d/direction"
#define GPIO_VALUE         "/sys/class/gpio/gpio%d/value"

// Filesystem paths for PWM
#define PWM_EXPORT         "/sys/class/pwm/pwmchip0/export"
#define PWM_UNEXPORT       "/sys/class/pwm/pwmchip0/unexport"
#define PWM_PERIOD(ch)     "/sys/class/pwm/pwmchip0/pwm%d/period"
#define PWM_DUTY_CYCLE(ch) "/sys/class/pwm/pwmchip0/pwm%d/duty_cycle"
#define PWM_ENABLE(ch)     "/sys/class/pwm/pwmchip0/pwm%d/enable"

#endif
