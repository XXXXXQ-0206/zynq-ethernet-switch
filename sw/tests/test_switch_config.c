#include <assert.h>
#include <stdint.h>

#include "switch_config.h"

int main(void) {
    uint32_t parsed_value = 0;

    assert(switch_parse_u32("0x10", &parsed_value) == 0);
    assert(parsed_value == 16U);
    assert(switch_parse_u32("not-a-number", &parsed_value) != 0);
    assert(switch_validate_register_offset(SWITCH_REG_RX_COUNTER) == 0);
    assert(switch_validate_register_offset(3U) != 0);
    return 0;
}
