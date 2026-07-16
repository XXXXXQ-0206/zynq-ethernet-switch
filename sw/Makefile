CC := gcc
CFLAGS ?= -std=c11 -Wall -Wextra -Werror -pedantic
COMMON = common/switch_config.c
INCLUDES = -Icommon
BUILD_DIR = build

ifeq ($(OS),Windows_NT)
EXEEXT := .exe
else
EXEEXT :=
endif

.PHONY: all test clean

all: $(BUILD_DIR)/switch-config$(EXEEXT) $(BUILD_DIR)/router-config$(EXEEXT)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/switch-config$(EXEEXT): $(COMMON) switch_config/main.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) $^ -o $@

$(BUILD_DIR)/router-config$(EXEEXT): $(COMMON) router_config/main.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) $^ -o $@

test: | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) $(COMMON) tests/test_switch_config.c -o $(BUILD_DIR)/test_switch_config$(EXEEXT)
	./$(BUILD_DIR)/test_switch_config$(EXEEXT)

clean:
	rm -rf $(BUILD_DIR)
