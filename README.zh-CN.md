# Zynq 以太网交换机实验项目

[English](README.md) | [中文](README.zh-CN.md)

这是一个 Zynq 多端口以太网交换机实现。仓库提供 Ethernet II 报文解析、MAC 学习/查找、简化 AXI-Lite 寄存器模块、基于 UIO 的管理工具，以及 Vivado/PetaLinux 集成模板。

## 项目概述

`eth_parser` 提取目的/源 MAC 地址和 EtherType，`mac_cam_lut` 根据源地址学习端口映射并按目的地址转发，C 工具通过通用 UIO 访问寄存器。

仓库只分发源码和集成模板，不包含生成的 XSA/比特流、板卡约束或专有厂商 IP。

## 特性

- 流式 Ethernet II 报文头解析。
- 参数化 CAM/LUT：源 MAC 学习、目的查询、泛洪和老化。
- 用于控制和报文计数的可移植 AXI-Lite 寄存器模块。
- 严格 C11 的 UIO 管理工具及单元测试。
- Vivado 建工程和 PetaLinux 设备树模板。

## 截图

本仓库以 RTL 和命令行工具为主，不包含图形界面。为保持可移植性并避免隐私风险，不提供截图。

## 安装

```bash
git clone https://github.com/XXXXXQ-0206/zynq-ethernet-switch-lab.git
cd zynq-ethernet-switch-lab
```

可移植检查需要 GCC、Icarus Verilog 和 Verilator；只有进行板卡集成时才需要 Vivado 和 PetaLinux。

## 使用

```bash
make -C sw test
bash scripts/test-hdl.sh
./sw/switch-config --device /dev/uio0 counters
```

`switch-config` 需要已授权且映射到文档所述寄存器块的 UIO 设备，不使用硬编码主机地址、串口或凭证。

## 构建说明

先运行可移植测试，再用 `vivado/create_project.tcl` 创建 RTL 工程；随后加入已获授权的 MAC/DMA/PHY 与板卡材料，在 `petalinux/system-user.dtsi` 中写入 AXI-Lite 地址，启用通用 UIO，并在受许可的 PetaLinux 环境构建应用。详见 [集成模板](petalinux/README.md)。

## 项目结构

```text
rtl/        解析器、CAM/LUT、AXI-Lite 寄存器和集成封装
tb/         自检 Verilog 测试平台
sw/         C11 UIO 工具和测试
petalinux/  设备树与应用集成模板
vivado/     可移植建工程 Tcl
docs/       架构和寄存器映射说明
```

## 路线图

- 增加 AXI-Lite 总线协议断言。
- 仅在取得可再分发材料后加入板卡专用集成。
- 以可复现约束记录硬件在环测试结果。

## 参与贡献

请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)，遵守 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)，并向 `dev` 分支提交变更。

## 许可证

本人编写的文件采用 [MIT](LICENSE)。没有明确再分发条款时，请勿加入厂商、课程或板卡资产。

## 常见问题

**包含原始比特流吗？** 不包含。仓库只发布源码和模板。

**这份源码在板卡上跑过吗？** CI 验证可移植 RTL/C 行为。板卡集成需要兼容且已获授权的 MAC/DMA/PHY 和约束材料。

**支持哪块板卡？** 模板面向 Zynq 类集成，但需要用户提供已授权的板卡设计和约束。

## 致谢

Xilinx、Zynq、Vivado、PetaLinux、AXI 和 UIO 均归各自权利人所有，提及它们不代表获得认可或背书。

## 免责声明

本软件按**现状（AS IS）**提供，不附带任何明示或暗示担保。对于因使用本软件而产生的任何直接、间接、附带、特殊或后果性损失，作者概不承担责任。使用、修改、综合、部署或将本软件接入硬件和网络所产生的一切风险均由使用者自行承担。除非自行完成验证并承担全部责任，否则不得将其用于违法用途、安全关键、生命关键、生产网络或其他失效后可能造成伤害的场景。
