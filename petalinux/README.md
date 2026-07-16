# PetaLinux Integration Template

Enable `Userspace I/O drivers` and `Userspace platform driver with generic IRQ handling` in the kernel configuration. Copy `system-user.dtsi` into `project-spec/meta-user/recipes-bsp/device-tree/files/` and replace the `reg` value with the assigned AXI-Lite address from the Vivado block design.

Build the applications from `sw/` in a PetaLinux recipe or copy their sources into application recipes. The original hardware platform export and generated PetaLinux build tree were not retained, so this directory is a reproducible configuration template rather than an exported image project.
