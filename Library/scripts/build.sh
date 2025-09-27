#!/bin/bash

echo "=== Building Carro Control ==="

# Create build directory if none exist
mkdir -p build

# Compilar
make clean
make

if [ $? -eq 0 ]; then
    echo "=== Build completado exitosamente ==="
    echo "Ejecutable: carro_control"
    file carro_control
else
    echo "=== Error en el build ==="
    exit 1
fi
