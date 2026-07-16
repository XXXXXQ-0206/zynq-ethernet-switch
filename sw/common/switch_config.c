#include "switch_config.h"

#include <errno.h>
#include <limits.h>
#include <stdlib.h>

int switch_parse_u32(const char *text, uint32_t *value) {
    char *end_pointer = NULL;
    unsigned long parsed_value;

    if (text == NULL || value == NULL || *text == '\0') {
        return -1;
    }

    errno = 0;
    parsed_value = strtoul(text, &end_pointer, 0);
    if (errno != 0 || end_pointer == text || *end_pointer != '\0' ||
        parsed_value > UINT32_MAX) {
        return -1;
    }

    *value = (uint32_t)parsed_value;
    return 0;
}

int switch_validate_register_offset(uint32_t offset) {
    switch (offset) {
        case SWITCH_REG_CONTROL:
        case SWITCH_REG_RX_COUNTER:
        case SWITCH_REG_TX_COUNTER:
        case SWITCH_REG_LOOKUP_MAC_HIGH:
        case SWITCH_REG_LOOKUP_MAC_LOW:
        case SWITCH_REG_LOOKUP_RESULT:
        case SWITCH_REG_TABLE_CLEAR:
            return 0;
        default:
            return -1;
    }
}
