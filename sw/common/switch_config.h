#ifndef SWITCH_CONFIG_H
#define SWITCH_CONFIG_H

#include <stdint.h>

#define SWITCH_REG_CONTROL 0x00U
#define SWITCH_REG_RX_COUNTER 0x04U
#define SWITCH_REG_TX_COUNTER 0x08U
#define SWITCH_REG_LOOKUP_MAC_HIGH 0x0CU
#define SWITCH_REG_LOOKUP_MAC_LOW 0x10U
#define SWITCH_REG_LOOKUP_RESULT 0x14U
#define SWITCH_REG_TABLE_CLEAR 0x18U

int switch_parse_u32(const char *text, uint32_t *value);
int switch_validate_register_offset(uint32_t offset);

#endif
