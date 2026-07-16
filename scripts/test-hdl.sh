#!/usr/bin/env bash
set -euo pipefail

mkdir -p build
iverilog -g2012 -o build/tb_eth_parser tb/tb_eth_parser.v rtl/eth_parser.v
vvp build/tb_eth_parser
iverilog -g2012 -o build/tb_mac_cam_lut tb/tb_mac_cam_lut.v rtl/mac_cam_lut.v
vvp build/tb_mac_cam_lut
verilator --lint-only --Wno-fatal --top-module ethernet_switch rtl/*.v
