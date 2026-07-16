#!/usr/bin/env bash
set -euo pipefail

mkdir -p build
gcc -std=c11 -Wall -Wextra -Werror -pedantic -Isw/common \
  sw/common/switch_config.c sw/tests/test_switch_config.c -o build/test_switch_config
./build/test_switch_config
