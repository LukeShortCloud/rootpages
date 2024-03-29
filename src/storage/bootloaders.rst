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

Install the GRUB 2 packages:

-  Arch Linux:

   .. code-block:: sh

      $ pacman -S efibootmgr efivar grub os-prober

-  Debian:

   .. code-block:: sh

      $ apt-get install efibootmgr grub-common grub-efi-amd64-bin grub-efi-amd64-signed grub-gfxpayload-lists grub-pc grub-pc-bin libefiboot1 libefivar1 os-prober shim shim-signed

-  Fedora:

   .. code-block:: sh

      $ dnf install efibootmgr efi-filesystem grub2-common grub2-efi-x64 grub2-pc grub2-tools grub2-tools-efi grub2-tools-extra grub2-tools-minimal grubby os-prober shim-x64

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

.. csv-table::
   :header: File, Description
   :widths: 20, 20

   "/etc/default/grub", "Default GRUB settings."
   "/etc/grub.d/", "A folder with various scripts that make up the grub.cfg. Scripts prefixed with lower numbers are executed first."
   "/boot/grub/grub.cfg", "This is automatically generated using the settings from /etc/default/grub and the scripts in /etc/grub.d/ . Manual changes may get overwritten."

Common options:

-  /etc/default/grub

   -  ``GRUB_DEFAULT`` = The default menu entry to autoboot into.

       -  ``saved`` = Boot from the last option selected. This is cached in the /boot/grub/grubenv file.
       -  Alternatively, this can either be the number of the "menuentry" section, in order from top to bottom, starting at "0".
       -  Or the menu entry title can be explicitly specified. For example, "CentOS Linux (3.10.0-327.13.1.el7.x86\_64) 7 (Core)".

   -  ``GRUB_GFXPAYLOAD_LINUX`` = The graphics settings to use for the GRUB menu. [14][15]

      -  ``auto`` = Let GRUB guess the best graphics settings to use.
      -  ``text`` = Basic GRUB text rendering that works on all hardware.
      -  ``keep`` = Use advanced graphical rendering that can show themes and images. For unsupported graphics devices, the system will be unbootable.

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

-  GRUB\_PRELOAD\_MODULES = Default: ``part_gpt part_msdos``. Additional GRUB modules to load. These may be required for special file systems or boot configurations. [12]

   -  View all of the UEFI GRUB modules:

      .. code-block:: sh

         $ ls -1 /boot/grub/x86_64-efi/*.mod

   -  View all of the legacy BIOS boot GRUB modules:

      .. code-block:: sh

         $ ls -1 /boot/grub/i386-pc/*.mod

Examples
^^^^^^^^

These are examples configurations for ``/etc/default/grub``. Use ``grub-mkconfig -o /boot/grub/grub.cfg`` to load up the new configurations.

-  Do not show the GRUB menu on boot:

   ::

      GRUB_TIMEOUT=0
      GRUB_TIMEOUT_STYLE=hidden

-  Show the consolidated GRUB menu on boot:

   ::

      GRUB_TIMEOUT=5
      GRUB_TIMEOUT_STYLE=menu

-  Show everything on the main GRUB menu page on boot:

   ::

      GRUB_TIMEOUT=5
      GRUB_TIMEOUT_STYLE=menu
      GRUB_DISABLE_SUBMENU=y

-  Save the selected boot kernel as the default for the next boot:

   ::

      GRUB_DEFAULT=saved
      GRUB_SAVEDEFAULT=true

[10]

-  Support for booting off of any file systems:

   ::

      GRUB_PRELOAD_MODULES="part_gpt part_msdos affs afs bfs btrfs cbfs ext2 fat fshelp geli hfs hfspluscomp hfsplus http iso9660 luks macbless memdisk minix nilfs2 ntfscomp ntfs pxe reiserfs scsi sfs squash4 tftp usf1_be ufs1 ufs2 xfs zfscrypt zfsinfo zfs"

-  Support for booting more than one operating system:

   ::

      GRUB_PRELOAD_MODULES="part_gpt part_msdos multiboot2"

-  Support for compression (required by some file systems):

   ::

      GRUB_PRELOAD_MODULES="part_gpt part_msdos hfspluscomp lzopio ntfscomp zstd zxio"

[12]

UEFI Boot Name
~~~~~~~~~~~~~~

When using the UEFI boot menu provided by the BIOS of a motherboard, each operating system has its own name. It is possible to configure this name by using ``efibootmgr`` and then re-generating the GRUB configuration file.

-  Arch Linux:

   .. code-block:: sh

      $ sudo efibootmgr --create --disk /dev/<DEVICE> --part <EFI_PARTITION_NUMBER> --label "Arch Linux Custom Boot Name" --loader /EFI/BOOT/BOOTX64.efi
      $ sudo grub-mkconfig -o /boot/grub/grub.cfg

-  Fedora:

   .. code-block:: sh

      $ sudo efibootmgr --create --disk /dev/<DEVICE> --part <EFI_PARTITION_NUMBER> --label "Fedora Custom Boot Name" --loader \\EFI\\fedora\\shimx64.efi
      $ sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

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

USB Installation with Both Legacy BIOS and UEFI Support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Linux can be installed onto a portable storage device that can boot on both legacy BIOS computers and newer UEFI computers. UEFI requires a GPT partition table which means a legacy MBR partition scheme will not work.

-  GPT partitions:

   1.  BIOS GRUB boot partition. This extra space provides more room for GRUB to store its boot and partition table data.

      -  Size: 1 MiB.
      -  File system: none.
      -  Partition flag: ``bios_grub``.
      -  Mount point: none.

   2.  EFI partition. This stores the UEFI firmware.

      -  Size: >= 200 MiB.
      -  File system: FAT32.
      -  Partition flags: ``boot`` and ``esp``.
      -  Mount point: ``/boot/efi/``.

   3.  Linux boot partition. This stores the Linux kernel and boot configuration files (optional).

      -  Size: 1 GiB.
      -  File system: ext4.
      -  Partition flags: none.
      -  Mount point: ``/boot/``.

-  GRUB requirements:

   -  Configure GRUB to use partition UUIDs instead of Linux UUIDs. Partition UUIDs will not change between different UEFI motherboards. [21][22]
   -  Install GRUB to the UEFI partition mount. Use the ``--removable`` option to set a default UEFI firmware at ``/boot/efi/EFI/BOOT/BOOTX64.efi``. This assumes that only one operating system will be installed on the storage device. [9] Also use the ``--no-vram`` option to avoid modifying UEFI variables on the local motherboard. [20]
   -  Install GRUB to the block device (not a partition) that will be used for legacy BIOS boot.
   -  Regenerate the GRUB configuration file.

-  initramfs requirements to load all kernel modules:

   -  Arch Linux = Remove "autodetect" from the ``HOOKS=()`` section in ``/etc/mkinitcpio.conf``. Then run ``sudo mkinitcpio -P``. [18]
   -  Fedora = Install ``dracut-config-generic``. Then run ``sudo dracut --regenerate-all --force``. [19]

-  Processor microcode updates for better supporting CPUs:

   -  Arch Linux = Install ``amd-ucode intel-ucode``.
   -  Fedora = Install ``amd-ucode-firmware microcode_ctl``.

Example partition layout:

::

   Number  Start   End 	Size	File system 	Name 	Flags
    1  	1049kB  2097kB  1049kB              	primary  bios_grub
    2  	2097kB  500MB   498MB   fat32       	primary  boot, esp
    3  	500MB   8500MB  8000MB  linux-swap(v1)  primary  swap
    4  	8500MB  128GB   120GB   btrfs       	primary

Arch Linux and Debian:

.. code-block:: sh

   # UEFI
   $ sudo crudini --ini-options=nospace --set /etc/default/grub "" GRUB_DISABLE_LINUX_UUID true
   $ sudo crudini --ini-options=nospace --set /etc/default/grub "" GRUB_DISABLE_LINUX_PARTUUID false
   $ sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=<OPERATING_SYSTEM_NAME> --removable --no-vram
   # BIOS
   $ sudo grub-install --target=i386-pc /dev/<DEVICE>
   $ sudo grub-mkconfig -o /boot/grub/grub.cfg

Fedora:

.. code-block:: sh

   # UEFI
   $ sudo crudini --ini-options=nospace --set /etc/default/grub "" GRUB_DISABLE_LINUX_UUID true
   $ sudo crudini --ini-options=nospace --set /etc/default/grub "" GRUB_DISABLE_LINUX_PARTUUID false
   $ sudo grub2-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=<OPERATING_SYSTEM_NAME> --removable
   # BIOS
   $ sudo grub2-mkconfig -o /boot/grub2/grub.cfg
   $ sudo grub2-install --target=i386-pc /dev/<DEVICE>

Most modern Linux installers will default to installing GRUB with UEFI support. After installation, ensure to run the necessary commands to setup legacy BIOS boot.

[8]

Linux Boot Order
~~~~~~~~~~~~~~~~

The default order of the Linux kernels is different for each Linux distribution. It is usually managed in the ``/etc/grub.d/10_linux`` file. The ``sort`` command can have different arguments given to it to customize this.

-  Arch Linux:

   .. code-block:: sh

      $ sudo sed -i s'/version_sort\ -r/sort/'g /etc/grub.d/10_linux
      $ sudo grub-mkconfig -o /boot/grub/grub.cfg

-  Debian has no easy ``sort`` function to change.

-  Fedora:

   .. code-block:: sh

      $ sudo sed -i s'/sort\ -Vr/sort/'g /etc/grub.d/10_linux
      $ sudo grub2-mkconfig -o /boot/grub2/grub.cfg

Troubleshooting
---------------

Errors
~~~~~~

Error after selecting a boot entry in the GRUB menu:

::

   ERROR: device 'UUID=9d4e74d8-8046-4f12-9ac9-624b8f306343' not found. Skipping fsck.
   mount: /new_root: can't find UUID=9d4e74d8-8046-4f12-9ac9-624b8f306343.
   You are now being dropped into an emergency shell.

Solutions:

1.  Boot from the fallback initramfs instead. This uses a full kernel and extra dependencies compared to the minimal default initramfs.
2.  Ensure that the initramfs has all of the Linux kernel modules that are required for storage devices. Normally this is a missing hardware RAID driver.
3.  Ensure that the UUID for the root device is correct. If not, update ``/etc/fstab`` and then rebuild the ``grub.cfg`` configuration.
4.  On Arch Linux, ensure both the "block" and "keyboard" hooks are loaded before the "autodetect" hook in the initramfs. [11]

   ::

      $ sudo vim /etc/mkinitcpio.conf
      HOOKS=(base udev keyboard block autodetect modconf resume filesystems fsck)
      $ sudo mkinitpcio -p linux

----

Error from GRUB during boot:

::

   error: sparse file not allowed

Solutions:

This means that GRUB was unable to save information such as which kernel was used to boot into and should be the default next time.

1.  Configure GRUB to not automatically save the last boot option.

   .. code-block:: sh

      $ sudo vim /etc/default/grub
      GRUB_DEFAULT=0
      GRUB_SAVEDEFAULT=false
      $ sudo grub-mkconfig -o /boot/grub/grub.cfg

2.  Add support for the correct file system (including compression, if necessary). Refer to the `GRUB 2 - Configuration <#configuration>`_ section for a list of valid GRUB modules.

   -  Syntax:

      .. code-block:: sh

         $ sudo vim /etc/default/grub
         GRUB_PRELOAD_MODULES="part_gpt part_msdos <FILE_SYSTEM_MODULE> <COMPRESSION_MODULE>"
         $ sudo grub-mkconfig -o /boot/grub/grub.cfg

   -  Example:

      .. code-block:: sh

         $ sudo vim /etc/default/grub
         GRUB_PRELOAD_MODULES="part_gpt part_msdos btrfs zstd"
         $ sudo grub-mkconfig -o /boot/grub/grub.cfg

[13]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/bootloaders.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/bootloaders.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/bootloaders.md>`__

Bibliography
------------

1. "GRUB Legacy." Arch Linux Wiki. January 11, 2017. Accessed February 8, 2017. https://wiki.archlinux.org/index.php/GRUB\_Legacy
2. "GNU GRUB Manual 0.97." GNU. Accessed February 8, 2017. https://www.gnu.org/software/grub/manual/legacy/grub.html
3. "GRUB." Arch Linux Wiki. May 27, 2016. https://wiki.archlinux.org/index.php/GRUB
4. "GRUB2-INSTALL MAN PAGE." Mankier. February 26, 2014. https://www.mankier.com/8/grub2-install
5. "GRUB2/Setup." Ubuntu Documentation. November 29, 2015. https://help.ubuntu.com/community/Grub2/Setup
6. "Grub2/Installing." Ubuntu Documentation. March 6, 2015. https://help.ubuntu.com/community/Grub2/Installing
7. "GNU GRUB Manual 2.00." GNU. Accessed June 27, 2016. https://www.gnu.org/software/grub/manual/grub.html
8. "Is a hybrid Linux USB-Stick for UEFI & legacy BIOS possible?" Super User. March 11, 2018. Accessed June 17, 2020. https://superuser.com/questions/801515/is-a-hybrid-linux-usb-stick-for-uefi-legacy-bios-possible
9. "GRUB/Tips and tricks." ArchWiki. April 17, 2021. Accessed May 31, 2021. https://wiki.archlinux.org/title/GRUB/Tips_and_tricks
10. "Simple configuration handling." GNU GRUB Manual 2.06. Accessed February 5, 2022. https://www.gnu.org/software/grub/manual/grub/html_node/Simple-configuration.html
11. "Install Arch Linux on a removable medium." ArchWiki. July 12, 2021. Accessed July 17, 2021. https://wiki.archlinux.org/title/Install_Arch_Linux_on_a_removable_medium
12. "Understanding the Various Grub Modules." Linux.org. March 2, 2015. Accessed February 5, 2022. https://www.linux.org/threads/understanding-the-various-grub-modules.11142/
13. "GRUB error: sparse file not allowed." Support - Manjaro Linux. September 6, 2020. Accessed February 2022. https://forum.manjaro.org/t/grub-error-sparse-file-not-allowed/20267/6
14. "15.1.13 gfxpayload." GNU GRUB Manual 2.06. Accessed February 16, 2023. https://www.gnu.org/software/grub/manual/grub/html_node/gfxpayload.html
15. "GRUB gfxpayload blacklist." Launchpad Ubuntu. Accessed February 16, 2023. https://launchpad.net/ubuntu/xenial/+package/grub-gfxpayload-lists
16. "Use Linux efibootmgr Command to Manage UEFI Boot Menu." LinuxBabe. November 13, 2022. Accessed October 4, 2023. https://www.linuxbabe.com/command-line/how-to-use-linux-efibootmgr-examples
17. "Kickstart overcoming UEFi or converting from MBR." Light At The End Of The Tunnel. May 10, 2021. Accessed October 4, 2023. https://pkje.net/meander/2016/09/01/kickstart-overcoming-uefi-or-converting-from-mbr/
18. "mkinitcpio." Arch Wiki. February 16, 2024. Accessed February 21, 2024. https://wiki.archlinux.org/title/Mkinitcpio
19. "CentOS 7 - Updates for x86_64: system environment/base: dracut-config-generic." Linux @ CERN. June 18, 2020. Accessed February 21, 2024. https://linuxsoft.cern.ch/cern/centos/7/updates/x86_64/repoview/dracut-config-generic.html
20. "What does "--no-nvram" do while installing grub?" Ask Ubuntu. October 7, 2019. Accessed March 28, 2024. https://askubuntu.com/questions/1170347/what-does-no-nvram-do-while-installing-grub
21. "Arch Linux installed on a portable SSD doesn't boot on my other machine." Reddit r/archlinux. January 5, 2024. Accessed March 28, 2024. https://www.reddit.com/r/archlinux/comments/18z64sh/arch_linux_installed_on_a_portable_ssd_doesnt/
22. "Why do I need GRUB_DISABLE_LINUX_UUID=true." Unix & Linux Stack Exchange. March 26, 2023. Accessed March 28, 2024. https://unix.stackexchange.com/questions/127658/why-do-i-need-grub-disable-linux-uuid-true
