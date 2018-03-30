Bootloaders
===========

.. contents:: Table of Contents

GRUB 1
------

GRUB 1 is a legacy version of GRUB that is no longer supported. The last
version made available was 0.97 in 2008. GRUB 2 should be used for newer
Linux distributions.

Installation
~~~~~~~~~~~~

Install GRUB to the primary drive. This will use the MSDOS partition
scheme on the first 512 bytes as GPT was not supported until GRUB 2.

.. code-block:: sh

    $ sudo grub-install --root-directory=/ /dev/<DEVICE>

A basic boot menu must be configured to specify the boot partition, the
kernel to use, the root partition to mount, and the initrd/initramfs to
load.

File: /boot/grub/menu.lst

::

    root   (hd0,0)
    kernel /vmlinuz-linux root=/dev/sda2 ro
    initrd /initramfs-linux.img

[1]

Recovery
~~~~~~~~

When GRUB fails to boot, or if the boot settings need to be modified,
the GRUB recovery shell can be used.

Common options:

-  help = Show help messages.
-  cat = View the contents of a file.
-  find = View the contents of a file or locate a specific file.
-  dhcp = Obtain an IP address from DHCP.
-  ifconfig = Manually configure IP addressing.
-  tftpserver = Specify a TFTP server to PXE boot from.
-  module = Load a GRUB module.
-  root hd(\ ``X``,\ ``Y``) = Specify the root drive ``X`` and partition
   ``Y`` (the partition starts at "0" in GRUB 1 and "1" in GRUB 2). Use
   the "Tab" key on the keyboard to auto-complete if the partitions are
   unknown.
-  boot = Boot the operating system.
-  halt = Turn the computer off.
-  reboot = Reboot the computer

Example of manually booting a server:

.. code-block:: sh

    grub> root hd(0,0)
    grub> kernel /vmzlinuz-4.0.img root=/dev/sda2 ro
    grub> initrd /initramfs-4.0.img
    grub> boot

[2]

GRUB 2
------

GRUB stands for the GRand Unified Bootloader. It was designed to be
cross platform compatible with most operating systems including BSD,
Linux, and Windows variants. [7]

Installation
~~~~~~~~~~~~

GRUB must be installed onto the start of the entire drive, not a
partition, to avoid issues in the case of partitions needing to be
modified. The first 512 bytes of a drive are used for the Master Boot
Record (MBR). If you are using a GPT partition then it uses the first
2048 bytes. GRUB will add it's own data right after that. It is usually
a safe and recommended option to create your first partition 1MB after
the start of the drive, especially if GPT is in use.

Install GRUB to a drive (replace "X") and then generate a boot menu
configuration file. This will create the menu file that loads up to the
end-user upon boot.

.. code-block:: sh

    $ sudo grub-install /dev/sdX
    $ sudo grub-mkconfig -o /boot/grub/grub.cfg

If any changes are made to GRUB's settings and/or it's various scripts,
run this command to update the changes. [3]

.. code-block:: sh

    $ sudo update-grub

Common "grub-install" options:

-  compress = Compress GRUB-related files. Valid options are:

    -  no (default), xz, gz, lzo

-  --modules = List kernel modules that are required for boot. Depending on the end-user's setup, "lvm", "raid" (for mdadm), and/or "encrypt" (for LUKS) may be required.
-  --force = Install despite any warnings.
-  --recheck = Remove the original /boot/grub/device.map file (if it exists) and then review the current mapping of partitions.
-  --boot-directory = The directory that the "grub/" folder should exist in. This is typically "/boot". [4]

Configuration
~~~~~~~~~~~~~

Important files:

+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------+
| FILE                | DESCRIPTION                                                                                                                                     |
+=====================+=================================================================================================================================================+
| /etc/default/grub   | GRUB default settings.                                                                                                                          |
+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------+
| /etc/grub.d/        | A folder with various scripts that make up the grub.cfg. Scripts prefixed with lower numbers are executed first.                                |
+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------+
| /boot/grub/grub.cfg | This is automatically generated using the settings from /etc/default/grub and the scripts in /etc/grub.d/ . Manual changes may get overwritten. |
+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------+

Common options:

-  /etc/default/grub

    -   GRUB\_DEFAULT = The default menu entry to autoboot into.

        -  saved = Boot from the last option selected. This is cached in the /boot/grub/grubenv file.
        -  Alternatively, this can either be the number of the "menuentry" section, in order from top to bottom, starting at 0.
        -  Or the menu entry title can be explicitly specified. For example, "CentOS Linux (3.10.0-327.13.1.el7.x86\_64) 7 (Core)."

.. code-block:: sh

    $ sudo grep ^menuentry /boot/grub2/grub.cfg
    menuentry 'CentOS Linux (3.10.0-327.18.2.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-327.18.2.el7.x86_64-advanced-d2e5b723-0055-4157-9197-e7d715937e8b' {
    menuentry 'CentOS Linux (3.10.0-327.13.1.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-327.13.1.el7.x86_64-advanced-d2e5b723-0055-4157-9197-e7d715937e8b' {

-  GRUB\_TIMEOUT = Set the timeout (in seconds) before booting into the
   default menu entry.
-  GRUB\_CMDLINE\_LINUX = Append kernel options to the end of the
   "linux" line. These can later be seen in the operating system in
   /proc/cmdline. This applies to both the normal and recovery mode
   options.
-  GRUB\_CMDLINE\_LINUX\_DEFAULT = The same as the above setting except
   this option does not affect the recovery kernel options.
-  GRUB\_DISABLE\_LINUX\_UUID = If set to "true", devices from /dev/
   will be used for specifying the root instead of the UUID. The default
   is "false" which will use UUIDs.
-  GRUB\_BACKGROUND = Specify the full path to a custom image for GRUB's
   menu background.

[5]

Recovery
~~~~~~~~

In cases where GRUB fails (because it was installed incorrectly), the
end-user is automatically switched into GRUB's rescue shell.

Common options:

-  insmod = Load kernel modules.
-  ls = List partitions and file systems within them.
-  cat = View file contents.
-  set = Set a boot option.
-  unset = Remove a boot option.
-  boot = Attempt to boot again.
-  halt = Shutdown the computer.
-  reboot = Restart the computer.

The rescue prompt will look similar to this.

.. code-block:: sh

    grub rescue>

Example of using these commands to do a custom rescue boot.

.. code-block:: sh

    grub rescue> ls
    (hd0) (hd0,msdos1)
    grub rescue> ls (hd0,1)/boot/
    grub/
    vmlinuz
    initramfs-linux.img
    grub rescue> set root=(hd0,1)
    grub rescue> linux /boot/vmlinuz root=/dev/sda1
    grub rescue> initrd /boot/initramfs-linux.img
    grub rescue> boot

Alternatively, you can switch back to the graphical GRUB menu and make
changes there.

.. code-block:: sh

    grub rescue> insmod normal
    grub rescue> normal

For recovering from a corrupt GRUB installation, fully change root into
the environment from a live CD, USB, or PXE network boot. Then you can
modify configuration files and re-install GRUB using the same commands
used during the installation.

In this example, /dev/sda2 is the root partition and /dev/sda1 is the
boot partition. [6]

.. code-block:: sh

    $ sudo mount /dev/sda2 /mnt
    $ sudo mount /dev/sda1 /mnt/boot
    $ sudo mount --bind /dev /mnt/dev
    $ sudo mount -t proc proc /mnt/proc
    $ sudo mount --bind /run /mnt/run
    $ sudo mount -t sysfs sys /mnt/sys
    $ chroot /mnt
    $ /bin/bash
    $ export PATH="$PATH:/sbin:/bin"

If you need to recover GRUB from a chroot that is based on a LVM on the
host node, make sure that LVM tools are installed on the guest. This way
it can properly see the logical volume as a block device.

Debian:

.. code-block:: sh

    $ sudo apt-get install lvm2

Fedora:

.. code-block:: sh

    $ sudo yum install lvm2

`Errata <https://github.com/ekultails/rootpages/commits/master/src/bootloaders.rst>`__
--------------------------------------------------------------------------------------

Bibliography
------------

1. "GRUB Legacy." Arch Linux Wiki. January 11, 2017. Accessed February 8, 2017. https://wiki.archlinux.org/index.php/GRUB\_Legacy
2. "GNU GRUB Manual 0.97." GNU. Accessed February 8, 2017. https://www.gnu.org/software/grub/manual/legacy/grub.html
3. "GRUB." Arch Linux Wiki. May 27, 2016. https://wiki.archlinux.org/index.php/GRUB
4. "GRUB2-INSTALL MAN PAGE." Mankier. February 26, 2014. https://www.mankier.com/8/grub2-install
5. "GRUB2/Setup." Ubuntu Documentation. November 29, 2015. https://help.ubuntu.com/community/Grub2/Setup
6. "Grub2/Installing." Ubuntu Documentation. March 6, 2015. https://help.ubuntu.com/community/Grub2/Installing
7. "GNU GRUB Manual 2.00." GNU. Accessed June 27, 2016. https://www.gnu.org/software/grub/manual/grub.html
