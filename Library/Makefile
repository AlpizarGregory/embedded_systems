# Configuración de cross-compiling
CC = arm-linux-gnueabihf-gcc
CFLAGS = -Wall -Wextra -O2 -I./include
LDFLAGS = -static

# Directorios
SRCDIR = src
INCDIR = include
BUILDDIR = build
TARGET = carro_control

# Archivos fuente
SOURCES = $(SRCDIR)/gpio_lib.c $(SRCDIR)/carro_control.c
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)

# Regla principal
all: $(BUILDDIR) $(TARGET)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Limpieza
clean:
	rm -rf $(BUILDDIR) $(TARGET)

# Instalación en target (ejemplo)
install: $(TARGET)
	scp $(TARGET) root@raspberrypi:/usr/local/bin/

.PHONY: all clean install
