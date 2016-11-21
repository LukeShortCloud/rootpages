* [Linux](#linux)
    * [Modules](#linux---modules)
* [Initial RAM Filesystem](#initial-ram-filesystem)
    * [Arch Linux (mkinitcpio)](#initial-ram-filesystem---arch-linux)
    * Debian (initramfs-tools)
    * [RHEL (dracut)](#initial-ram-filesystem---rhel)


# Linux

Linux is a kernel designed to be similar to the original Unix kernel, but modern, free and open source. It is built to work on many mondern proccessor aritecthures including the 32-bit and 64-bit versions of i386. This is also used to generally describe the many operating systems that use the Linux kernel. [1]

Source:

1. "About Linux Kernel." The Linux Kernel Archives. Accessed November 19, 2016. https://www.kernel.org/linux.html


## Linux - Modules

The kernel is composed of a large number of modules. These can be found here:

```
/lib/modules/<KERNEL_VERSION>/
```

View all of the loaded moudles:
```
# lsmod
```



Custom modules can be compiled for a specific kernel and copied in their respective driver directory. A few common drivers types are "iscsi", "net/ethernet", "net/wireless", "usb", "pci", "video", etc.
```
/lib/modules/<KERNEL_VERSION>/kernel/drivers/<DRIVER_TYPE>/
```

After copying over the necessary *.ko file(s) for custom modules, load
```
# depmod <MODULE>
```

If there are a large number of new modules, it is possible to make sure all module depdendencies are installed.
```
# depmod --all
```

Modules can be temporarily loaded:
```
# modprobe <MODULE>
```

Or permanetly add the module to a file with the extension ".conf" in the modules load directory.
```
/etc/modules-load.d/*.conf
```

Modules can be deactivated by running one of these two commands:
```
# rmmod <MODULE>
```
```
# modprobe -r <MODULE>
```

Modules can also be blocked from starting on boot:
```
/etc/modprobe.d/blacklist.conf
```
```
blacklist <MODULE>
```

[1]

Source:

1. "Kernel modules." The Arch Linux Wiki. August 8, 2016. Accessed November 19, 2016. https://wiki.archlinux.org/index.php/Kernel_modules


# Initial RAM Filesystem

The initramfs (inital RAM filesystem) is used to boot up a system before loading the full Linux kernel. It is the successor to the initrd (inital RAM disk). A boot loader, such as GRUB, loads the initramfs first. This usually contains a minimum copy of the kernel and drivers required to boot up the system. Once the boot initalization is complete, the initramfs continues to load all of the available kernel modules. [1][2]

Sources:

1. 'The Kernel Newbie Corner: "initrd" and "initramfs"--What's Up With That?' Linux.com September 30, 2009. Accessed November 19, 2016. https://www.linux.com/learn/kernel-newbie-corner-initrd-and-initramfs-whats
2. "ramfs, rootfs and initramfs." The Linux Kernel Documentation. May 29, 2015. Accessed November 19, 2016. https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt


## Initial RAM Filesystem - Arch Linux

All modifications of the initramfs in Arch Linux are handled by the "mkinitcpio" utility.

```
/etc/mkinitcpio.conf
```

* MODULES = A list of kernel modules to compile in.
* FILES = A list of files that should be included in the initramfs.
* BINARIES = A list of binaries that should be included to use in the initramfs environment. This is useful for having more recovery utilies. The "mkinitcpio" program will automatically detect the binary's depdencies and add them to the initramfs image.
* HOOKS = Custom hooks for compiling in certain software packages.
    * Common hooks:
        * btrfs = BtrFS RAID.
        * net = Add networking.
        * mdadm = mdadm software RAID modules.
        * fsck = FSCK utilies for available operating systems.
        * encrypt = LUKS encyrption modules.
        * lvm2 = Logical volume manager (LVM) modules.
        * shutdown = Allows the initramfs to properly shutdown.

Create a new initramfs.
```
# mkinitcpio
```

[1]

Source:

1. "mkinitcpio." The Arch Linux Wiki. November 13, 2016. Accessed November 19, 2016. https://wiki.archlinux.org/index.php/mkinitcpio


## Initial RAM Filesystem - RHEL

On Red Hat Enterprise Linux (RHEL) based operating systems (such as RHEL itself, CentOS, and Fedora), Dracut is used to manage the initramfs.

```
/etc/dracut.conf
```

* add_drivers+= A list of kernel modules to compile in.
* install_items+= A list of files to compile in.
* add_dracutmodules+= A list of Dracut modules to compile.

Source:

1. "Dracut." The Linux Kernel Archives. October, 2013. Accessed November 19, 2016. https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
