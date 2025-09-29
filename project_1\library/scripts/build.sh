#!/bin/bash

echo "=== Building Car Control ==="

# Create build directory if none exist
mkdir -p build

# Compile
make clean
make

if [ $? -eq 0 ]; then
    echo "=== Build succesful ==="
    echo "Executable: car_control"
    file car_control
else
    echo "=== Build Error ==="
    exit 1
fi
