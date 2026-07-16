#include <stdio.h>
#include <stdlib.h>

#include "switch_config.h"

int main(int argc, char **argv) {
    uint32_t port_mask;

    if (argc != 2 || switch_parse_u32(argv[1], &port_mask) != 0 || port_mask > 3U) {
        fprintf(stderr, "Usage: router-config <port-mask 0..3>\n");
        return EXIT_FAILURE;
    }
    printf("requested enabled-port mask: %u\n", port_mask);
    return EXIT_SUCCESS;
}
