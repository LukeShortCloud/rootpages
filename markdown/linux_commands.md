# Linux Commands

* [Hardware](#hardware)
    * [North Bridge](#hardware---north-bridge)
    * IPMI
    * Graphics
    * Audio

# Hardware


## Hardware - North Bridge

See also: Administrative, Drives, Virtualization

| Command | Usage | Examples | Explaination | Package |  Sources |
| ------- | ----- | -------- | ------------ | ------- | -------- |
| lscpu | | | view processor information | util-linux | |
| lspci | -k [show kernel modules using the PCI device] | | view PCI device information | pciutils | |
| lsusb | | | view USB device information | usbutils | |
| sensors-detect | | | automatically detect available power and/or tempature sensors on the motherboard | lm_sensors | |
| sensors | | | view the read out of the motherboard sensors | lm_sensors | |
| stress | <li> -c, --cpu [spawn CPU workers] <li>-i, --io [spawn I/O workers in RAM and HDDs] <li>-m,--vm [spawns RAM workers] <li>--vm-bytes [specify bytes to write to RAM] <li>-d, --hdd [spawn I/O workers on the actual drive] <li>-t [timeout time] <li>-v [verbose] | | run a stress test on CPU, RAM, and/or a storage device | EPEL: stress | |
