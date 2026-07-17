# Zynq Ethernet Switch Lab

[English](README.md) | [中文](README.zh-CN.md)

A Zynq Ethernet multi-port-switch implementation. It provides portable RTL for Ethernet II header parsing and MAC learning/lookup, a small AXI-Lite register block, UIO management utilities, and Vivado/PetaLinux integration templates.

## Project Overview

`eth_parser` extracts Ethernet destination/source MAC addresses and EtherType; `mac_cam_lut` learns source MAC-to-port mappings and resolves destination forwarding; the C utilities access the register map through generic UIO.

The repository distributes source code and integration templates only. It does not include generated XSA/bitstream output, board constraints, or proprietary vendor IP.

## Features

- Streaming Ethernet II header parser.
- Parameterized CAM/LUT source learning, lookup, flooding, and entry aging.
- Portable AXI-Lite register block for control and packet counters.
- Strict C11 UIO management utilities and unit tests.
- Vivado project-generation and PetaLinux device-tree templates.

## Screenshots

The repository contains RTL and command-line tools, not a graphical application. No screenshots are included to keep the project portable and privacy-clean.

## Installation

```bash
git clone https://github.com/XXXXXQ-0206/zynq-ethernet-switch.git
cd zynq-ethernet-switch
```

Install GCC, Icarus Verilog, and Verilator for portable checks. Vivado and PetaLinux are required only for board integration.

## Usage

```bash
make -C sw test
bash scripts/test-hdl.sh
./sw/switch-config --device /dev/uio0 counters
```

`switch-config` requires an authorized UIO device mapped to the documented register block. It never uses a hard-coded host address, serial port, or credential.

## Build Instructions

Run portable tests first. Then use `vivado/create_project.tcl` to create an RTL project, add authorized MAC/DMA/PHY and board collateral, assign the AXI-Lite address in `petalinux/system-user.dtsi`, enable generic UIO, and build applications in a licensed PetaLinux environment. See [the integration template](petalinux/README.md).

## Project Structure

```text
rtl/        Parser, CAM/LUT, AXI-Lite register block, integration wrapper
tb/         Self-checking Verilog testbenches
sw/         C11 UIO utilities and tests
petalinux/  Device-tree and application-integration template
vivado/     Portable project-generation Tcl
docs/       Architecture and register-map documentation
```

## Roadmap

- Add AXI-Lite bus-protocol assertions.
- Add a board-specific integration only when redistributable collateral is available.
- Add hardware-in-the-loop results with reproducible constraints.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md), follow [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), and open changes against `dev`.

## License

User-authored files are released under [MIT](LICENSE). Do not add vendor, course, or board assets without documented redistribution terms.

## FAQ

**Does this contain the original bitstream?** No. The repository intentionally contains source and templates only.

**Has this implementation run on a board?** CI validates portable RTL/C behavior. Board integration requires compatible, authorized MAC/DMA/PHY and constraint collateral.

**Which board is supported?** The templates target Zynq-class integration but require an authorized board-specific design and constraints.

## Acknowledgements

Xilinx, Zynq, Vivado, PetaLinux, AXI, and UIO are trademarks or technologies of their respective owners; mention does not imply endorsement.

## Disclaimer

This software is provided **AS IS**, without warranty of any kind. The author is not liable for any direct, indirect, incidental, special, or consequential damages arising from its use. You assume all risks when using, modifying, synthesizing, deploying, or connecting this software to hardware or a network. Do not use it for unlawful, safety-critical, life-critical, production-network, or other applications where failure could cause harm unless you independently validate and accept full responsibility.
