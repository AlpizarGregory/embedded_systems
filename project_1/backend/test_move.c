#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <direction> <speed>\n", argv[0]);
        return 1;
    }

    char *direction = argv[1];
    int speed = atoi(argv[2]);

    printf("🚗 Car is moving %s at speed %d\n", direction, speed);

    return 0;
}