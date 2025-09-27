#ifndef GPIO_LIB_H
#define GPIO_LIB_H

typedef enum {
    DIRECCION_NINGUNA = 0,
    DIRECCION_ADELANTE,
    DIRECCION_ATRAS,
    DIRECCION_IZQUIERDA,
    DIRECCION_DERECHA
} direccion_t;

typedef enum {
    LUZ_APAGADA = 0,
    LUZ_ADELANTE_ON,
    LUZ_ATRAS_ON,
    LUZ_IZQUIERDA_ON,
    LUZ_DERECHA_ON
} estado_luz_t;

// Function prototypes
int gpio_export(int gpio);
int gpio_unexport(int gpio);
int gpio_set_direction(int gpio, const char *direction);
int gpio_set_value(int gpio, int value);
int gpio_get_value(int gpio);

int inicializar_sistema_gpio(void);
void limpiar_sistema_gpio(void);

int controlar_motor(direccion_t direccion);
int controlar_luz(estado_luz_t estado);
void detener_movimiento(void);

#endif
