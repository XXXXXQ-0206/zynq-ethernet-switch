#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef _WIN32
#include "switch_config.h"

int main(void) {
    fprintf(stderr, "switch-config requires a POSIX UIO device and is unavailable on Windows.\n");
    return EXIT_FAILURE;
}
#else
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#include "switch_config.h"

#define UIO_MAP_SIZE 4096U

static int read_register(volatile unsigned char *base, uint32_t offset, uint32_t *value) {
    if (switch_validate_register_offset(offset) != 0 || value == NULL) {
        return -1;
    }
    *value = *(volatile uint32_t *)(base + offset);
    return 0;
}

int main(int argc, char **argv) {
    const char *device_path = "/dev/uio0";
    volatile unsigned char *registers;
    int file_descriptor;
    uint32_t value;

    if (argc > 1 && strcmp(argv[1], "--device") == 0 && argc == 3) {
        device_path = argv[2];
        argv += 2;
        argc -= 2;
    }
    if (argc != 2 || (strcmp(argv[1], "counters") != 0 && strcmp(argv[1], "clear") != 0)) {
        fprintf(stderr, "Usage: switch-config [--device /dev/uioN] {counters|clear}\n");
        return EXIT_FAILURE;
    }

    file_descriptor = open(device_path, O_RDWR | O_SYNC);
    if (file_descriptor < 0) {
        perror("open UIO device");
        return EXIT_FAILURE;
    }
    registers = mmap(NULL, UIO_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, file_descriptor, 0);
    if (registers == MAP_FAILED) {
        perror("map UIO device");
        close(file_descriptor);
        return EXIT_FAILURE;
    }

    if (strcmp(argv[1], "counters") == 0) {
        if (read_register(registers, SWITCH_REG_RX_COUNTER, &value) != 0) {
            fprintf(stderr, "Unable to read RX counter\n");
        } else {
            printf("rx_packets=%u\n", value);
            read_register(registers, SWITCH_REG_TX_COUNTER, &value);
            printf("tx_packets=%u\n", value);
        }
    } else {
        *(volatile uint32_t *)(registers + SWITCH_REG_TABLE_CLEAR) = 1U;
        printf("forwarding table clear requested\n");
    }

    munmap((void *)registers, UIO_MAP_SIZE);
    close(file_descriptor);
    return EXIT_SUCCESS;
}
#endif
