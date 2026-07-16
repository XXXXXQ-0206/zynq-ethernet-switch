# System Architecture

The design is organized into four integration layers:

1. **Processing system**: configures and observes the switch register block through generic UIO.
2. **Ethernet MAC and DMA**: platform-supplied components move frames between PHY-facing interfaces and the switching core.
3. **AXI interconnect**: connects the control-plane register block and platform memory or DMA services.
4. **Switching core**: parses Ethernet II headers, learns source MAC-to-port mappings, looks up destination ports, and requests flooding for unknown destinations.

The repository supplies the switching core, AXI-Lite register template, and UIO utilities. MAC, DMA, PHY, processing-system, address assignment, and constraints are board-integration inputs.
