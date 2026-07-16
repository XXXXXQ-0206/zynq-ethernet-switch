# Vivado Template

Run `vivado -mode batch -source create_project.tcl` from this directory. Set `DEVICE_PART` when the target differs from the default Zynq-7000 part.

The generated project imports only public RTL. It intentionally does not create PHY constraints, vendor MAC/DMA IP, a processing-system block design, or a bitstream. Those board-specific inputs were not recovered and must be supplied from licensed, authorized sources.
