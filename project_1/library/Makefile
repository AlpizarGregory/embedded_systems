# Cross-compiling configuration
CC = arm-linux-gnueabihf-gcc
CFLAGS = -Wall -Wextra -O2 -I./include
LDFLAGS = -static

# Directories
SRCDIR = src
INCDIR = include
BUILDDIR = build
TARGET = car_control

# Source files
SOURCES = $(SRCDIR)/gpio_lib.c $(SRCDIR)/car_control.c
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)

# Main rules
all: $(BUILDDIR) $(TARGET)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Cleaning
clean:
	rm -rf $(BUILDDIR) $(TARGET)

# Target installation (Example)
install: $(TARGET)
	scp $(TARGET) root@192.168.0.40

.PHONY: all clean install
