File Systems
============

.. contents:: Table of Contents

Partition Table
---------------

Every drive needs a partition tables before it can create partitions and format file systems onto them. There are two types of partition tables:

.. csv-table::
   :header: Partition Type, BIOS Type, Drive Size Limit, Number of Partitions, Beginning of Drive Space
   :widths: 20, 20, 20, 20, 20

   Master Boot Record (MBR), Legacy BIOS, 2\* TB, 4\*\*, 31\*\*\* KiB
   GUID Partition Table (GPT), UEFI, 9.7 ZB, 128, 1 MiB [63]

-  \*A larger drive can be used with MBR but only 2 TB will be usable.
-  \*\*MBR can have an extended partition to store additional partition table information. That allows up to 26 partitions.
-  \*\*\*It is recommended to have 1 MiB for MBR but most older partitioning tools defaulted to 31 KiB. [64]

[61][62]

In Linux, you may also see MBR commonly referred to as BIOS, DOS, or MSDOS.

View the current partition table for a drive using ``parted``. It will display "msdos" for MBR, "gpt" for GPT, or "unknown" if there is no partition table.

.. code-block:: sh

   $ sudo parted /dev/<DEVICE> print | grep "Partition Table:"

::

   Partition Table: msdos

::

   Partition Table: gpt

::

   Partition Table: unknown

Create a partition table as "msdos" or "gpt". This will wipe any existing partition table making existing data difficult to recovery:

.. code-block:: sh

   $ sudo parted /dev/<DEVICE> mklabel <PARTITION_TABLE_TYPE>

Types
-----

Many types of file systems exist for various operating systems. These
are used to handle the underlying file and data structure when it is
being read and written to. Every file system has a limit to the number
of inodes (files and directories) it can handle. The inode limit can be
calculated by using the equation: ``2^<BIT_SIZE> - 1``.

.. csv-table::
   :header: "Name (mount type)", OS, Description, File Size Limit, Partition Size Limit, Bits
   :widths: 20, 20, 20, 20, 20, 20

   "Fat16 (vfat)", "DOS", "No journaling.", "2GiB", "2GiB", "16"
   "Fat32 (vfat)", "DOS", "No journaling.", "4GiB", "8TiB", "32"
   "exFAT", "Windows NT", "No journaling.", "128 PiB", "128 PiB", "32"
   "NTFS (ntfs-3g)", "Windows NT", "Journaling, encryption, compression.", "2TiB", "256TiB", "32"
   "ext4 [2]", "Linux", "Journaling, less fragmentation, better performance.", "16TiB", "1EiB", "32"
   "XFS", "Linux", "Journaling, online resizing (but cannot shrink), and online defragmentation.", "8EiB (theoretically up to 16EiB)", "8EiB (theoretically up to 16EiB)", "64"
   "Btrfs [3]", "Linux", "Journaling, copy-on-write (CoW), compression, snapshots, and RAID.", "8EiB (theoretically up to 16EiB)", "8EiB (theoretically up to 16EiB)", 64
   "tmpfs", "Linux", "RAM and swap", "", "", ""
   "ramfs", "Linux", "RAM (no swap).", "", "", ""
   "swap", "Linux", "A temporary storage file system to use when RAM is unavailable.", "", "", ""

[1]

Btrfs
~~~~~

Btrfs stands for the "B-tree file system." The file system is commonly
referred to as "BtreeFS", "ButterFS", and "BetterFS". In this model,
data is organized efficiently for fast I/O operations. This helps to
provide copy-on-write (CoW) for efficient file copies as well as other
useful features. Btrfs supports subvolumes, CoW snapshots, online
defragmentation, built-in RAID, compression, and the ability to upgrade
an existing ext file systems to Btrfs. [4]

Common mount options:

-  autodefrag = Automatically defragment the file system. This can
   negatively impact performance, especially if the partition has active
   virtual machine images on it.
-  compress = File system compression can be used. Valid options are:

   -  zlib = Higher compression
   -  lzo = Faster file system performance
   -  no = Disable compression (default)

-  notreelog = Disable journaling. This may improve performance but can
   result in a loss of the file system if power is lost.
-  subvol = Mount a subvolume contained inside a Btrfs file system.
-  ssd = Enables various solid state drive optimizations. This does not
   turn on TRIM support.
-  discard = Enables TRIM support. [5]

Snapper
^^^^^^^

Snapper provides automatic Btrfs snapshots. It is configured individually on a subvolume basis.

-  Arch Linux

   .. code-block:: sh

      $ sudo pacman -S snapper

-  Fedora

   .. code-block:: sh

      $ sudo dnf install snapper

Enable the cleanup and timeline snapshot services [65]:

.. code-block:: sh

   $ sudo systemctl enable --now snapper-cleanup.timer snapper-timeline.timer

Package Manager Snapshots
'''''''''''''''''''''''''

Snapshots can be created automatically whenever the package manager is used to install or remove packages.

-  Arch Linux [66]

   .. code-block:: sh

      $ sudo pacman -S snap-pac

-  Fedora [67]

   .. code-block:: sh

      $ sudo dnf install python3-dnf-plugin-snapper

RAIDs
^^^^^

In the latest Linux kernels, all Btrfs software RAID types (0, 1, 5, 6, and 10) are supported. [6]

Limitations
^^^^^^^^^^^

Known limitations:

-  The "df" (disk free) command does not report an accurate disk usage
   due to Btrfs's fragmentation. Instead, ``btrfs filesystem df`` should
   be used to view disk space usage on mount points and "btrfs
   filesystem show" for partitions.

   -  For freeing up space, run a block-level and then a file-level
      defragmentation. Then the disk space usage should be accurate to
      df's output. [7]

      -  ``$ sudo btrfs balance start /``
      -  ``$ sudo btrfs filesystem defrag -r /``

-  The ``btrfs-convert`` command used for converting an Ext3 or Ext4 filesystems to Btrfs was rewritten in btrfs-progs 4.6. Older versions of this may not work reliably. [17]

exFAT
~~~~~

exFAT is an enhanced version of the FAT32 file system created by Microsoft. It offers the best cross-platform compatibility between Linux, macOS, and Windows. It is commonly used on external storage devices. As of Linux kernel version 5.4, exFAT is now natively supported. As of Linux kernel version 5.7, a faster driver has been implemented.

Installation:

-  Arch Linux [39]:

   -  Linux kernel >= 5.4

      .. code-block:: sh

         $ sudo pacman -S exfatprogs

   -  Linux kernel < 5.4

      .. code-block:: sh

         $ sudo pacman -S exfat-utils

-  Debian [40]:

   -  Linux kernel >= 5.4

      .. code-block:: sh

         $ sudo apt-get install exfatprogs

   -  Linux kernel < 5.4

      .. code-block:: sh

         $ sudo exfat-fuse exfat-utils

-  Fedora [40]:

   -  Linux kernel >= 5.4

      .. code-block:: sh

         $ sudo dnf install exfatprogs

   -  Linux kernel < 5.4

      .. code-block:: sh

         $ sudo dnf install exfat fuse-exfat

Windows will not automatically mount a exFAT partition unless (1) it uses the GPT partitioning layout and (2) it has the ``msftdata`` flag on. [42]

.. code-block:: sh

   $ sudo parted /dev/<DEVICE> set <PARTITION_NUMBER> msftdata on

ext4
~~~~

The Extended File System 4 (ext4) is the default file system for most
Linux operating systems. It's focus is on performance and reliability.
It is also backwards compatible with the ext3 file system. [8]

Mount options:

-  ro = Mount as read-only.
-  data

   -  journal = All data is saved in the journal before writing it to
      the storage device. This is the safest option.
   -  ordered = All data is written to the storage device before
      updating the journal's metadata.
   -  writeback = Data can be written to the drive at the same time it
      updates the journal.

-  barrier

   -  1 = On. The file system will ensure that data gets written to the
      drive in the correct order. This provides better integrity to the
      file system due to power failure.
   -  0 = Off. If a battery backup RAID unit is used, then the barrier
      is not needed as it should be able to finish the writes after a
      power failure. This could provide a performance increase.

-  noacl = Disable the Linux extended access control lists.
-  nouser\_xattr = Disable extended file attributes.
-  errors = Specify what happens when there is an error in the file
   system.

   -  remount-ro = Automatically remount the partition into a read-only
      mode.
   -  continue = Ignore the error.
   -  panic = Shutdown the operating system if any errors are found.

-  discard = Enables TRIM support. The file system will immediately free
   up the space from a deleted file for use with new files.
-  nodiscard = Disables TRIM. [9]

NTFS
~~~~

The New Technology File System (NT File System or NTFS) is the primary file system used by Windows. As of Linux kernel version 5.15, it is natively supported by the new ``ntfs3`` Linux kernel driver instead of the FUSE ``ntfs-3g`` driver. [41] The new driver is faster and also allows NTFS file systems to be writeable on Linux. [43] The original ``ntfs-3g`` CLI tool (not the driver) is still used with the new ``ntfs3`` driver.

Installation:

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S ntfs-3g

-  Debian:

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install ntfs-3g

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install ntfs-3g

OpenZFS
~~~~~~~

OpenZFS is a unified project aimed at providing support for the ZFS file system on FreeBSD, Linux, macOS, and Windows operating systems. [21] It is not included in most Linux distributions due to licensing issues with the kernel. Debian and Ubuntu are the only Linux distribution that provide the Linux kernel module for ZFS in their official repositories. [22][23]

Installation (Source)
^^^^^^^^^^^^^^^^^^^^^

Debian:

-  Install the build dependencies [38]:

   .. code-block:: sh

      $ sudo apt install alien autoconf automake build-essential dkms fakeroot gawk libaio-dev libattr1-dev libblkid-dev libcurl4-openssl-dev libelf-dev libffi-dev libssl-dev libtool libudev-dev libzstd-dev linux-headers-$(uname -r) python3 python3-dev python3-distutils python3-cffi python3-packaging python3-pyparsing python3-setuptools uuid-dev zlib1g-dev

-  View and download an OpenZFS release from `here <https://github.com/openzfs/zfs/releases>`__.

   .. code-block:: sh

      $ export OPENZFS_VER="2.0.4"
      $ wget https://github.com/openzfs/zfs/releases/download/zfs-${OPENZFS_VER}/zfs-${OPENZFS_VER}.tar.gz

-  Build the DKMS packages so that the kernel module will be automatically rebuilt upon kernel updates.

   .. code-block:: sh

      $ tar -z -x -v -f zfs-${OPENZFS_VER}.tar.gz
      $ cd ./zfs-${OPENZFS_VER}
      $ ./configure --enable-systemd
      $ make -j $(nproc) deb-utils deb-dkms

-  Install the Debian package files. [24]

   .. code-block:: sh

      $ sudo dpkg -i ./*.deb

-  Load the ZFS kernel module and verify it works.

   .. code-block:: sh

      $ echo -n "zfs" | sudo tee -a /etc/modules-load.d/zfs.conf
      $ sudo modprobe zfs
      $ lsmod | grep zfs

-  Start and enable these services so that the ZFS pools and mounts will be persistent upon reboots. [28]

   .. code-block:: sh

      $ sudo systemctl enable --now zfs-import-cache.service zfs-import-scan.service zfs-mount.service zfs-share.service zfs-zed.service zfs.target zfs-import.target

Usage
^^^^^

ZFS manages multiple devices as a single "pool" of devices. The pool can have several "datasets" (the equivalent to subvolumes in Btrfs) which can have their own settings, mount points, and separate snapshots.

Create a pool and then a dataset within the pool. Verify it was created.

.. code-block:: sh

   $ sudo zpool create <POOL_NAME> <STORAGE_DEVICE_OR_FILE>
   $ sudo zfs create <POOL_NAME>/<DATASET_NAME>
   $ sudo zfs list

Mount points:

-  Pool = /<POOL_NAME>
-  Dataset = /<POOL_NAME>/<DATASET_NAME>

If a dataset is accidently created over an existing directory it will be mounted on top. This means that the data is still there but is inaccessible. Either unmount the dataset and rename the existing directory or permanently change the mount point.

Unmount and then re-mount a dataset:

.. code-block:: sh

   $ sudo zfs unmount <POOL_NAME>/<DATASET_NAME>
   $ sudo zfs mount <POOL_NAME>/<DATASET_NAME>

Change the mountpoint:

.. code-block:: sh

   $ sudo zfs set mountpoint=/mnt <POOL_NAME>/<DATASET_NAME>

View all of the available properties that can be set for the pool and/or datasets.

.. code-block:: sh

   $ man zfsprops

View the current value of a property and set a new one.

.. code-block:: sh

   $ sudo zfs get <PROPERTY> <POOL_NAME>/<DATASET_NAME>
   $ sudo zfs set <PROPERTY>=<VALUE> <POOL_NAME>/<DATASET_NAME>

Change the name of a ZFS pool. [44]

.. code-block:: sh

   $ sudo zpool export <ZFS_POOL_NAME_ORIGINAL>
   $ sudo zpool import <ZFS_POOL_NAME_ORIGINAL> <ZFS_POOL_NAME_NEW>
   $ sudo zpool list

Adaptive Replacement Cache (ARC)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ARC is the name for the automatic file caching of frequently accessed files by ZFS. Level 1 ARC (L1ARC) stores the cache in RAM. Level 2 ARC (L2ARC) can be configured to use a faster storage device (such as a SSD) as an extra layer of cache for slower devices (such as a HDD). Files stored in L1ARC will be downgraded to L2ARC if they are not used. If L2ARC cache becomes unavailable when the same file is accessed again, it will be accessed directly from the storage device again and placed back into L1ARC.

Life cycle of a file in relation to ARC:

::

   File is accessed from the disk --> Stored in L1ARC (RAM) --> Stored in L2ARC (SSD) --> Uncached

ARC usage:

-  Add a L2ARC device to an existing ZFS pool. [25]

   .. code-block:: sh

      $ sudo zpool add <ZFS_POOL> cache <STORAGE_DEVICE_OR_FILE>

-  View a summary of the ARC cache statistics.

   .. code-block:: sh

      $ sudo arc_summary

-  View real-time statistics for ARC cache. [29]

   .. code-block:: sh

      $ sudo arcstat

-  Remove a L2ARC cache device. Verify that the cache device was listed before and removed afterwards. [49]

   .. code-block:: sh

      $ sudo zpool status
      $ sudo zpool remove <ZFS_POOL> <STORAGE_DEVICE_OR_FILE>
      $ sudo zpool status

ZFS Intent Log (ZIL)
^^^^^^^^^^^^^^^^^^^^

ZIL is a write buffer for a ZFS pool. By default, it uses existing drives in a pool. A Seconary Log (SLOG) can be configured to be a dedicated device for the ZIL. It is recommended to use a fast SSD with high IOPS, DRAM cache, and power loss protection (PLP) for the SLOG. It is similar in concept to the L2ARC except this is for write (not read) operations. It is possible, but not recommended, to put the L2ARC and SLOG cache on different partitions of the same drive. [54][60]

-  Add a SLOG to a ZFS pool.

   .. code-block:: sh

      $ sudo zpool add <ZFS_POOL> log <STORAGE_DEVICE_OR_FILE>

NFS and Samba Support
^^^^^^^^^^^^^^^^^^^^^

OpenZFS supports automatically configuring pools and datasets for both the NFS and Samba (CIFS) network file systems.

NFS [27]:

-  Install the NFS service.

   .. code-block:: sh

      $ sudo apt install nfs-kernel-server

-  Configure a Samba CIFS share using ZFS.

   .. code-block:: sh

      $ sudo zfs set sharenfs=on <POOL>/<DATASET>

-  Test the NFS mount.

   .. code-block:: sh

      $ sudo apt install nfs-common
      $ sudo mount -t nfs 127.0.0.1:/<POOL>/<DATASET> /mnt

Samba [25]:

-  Install the Samba service.

   .. code-block:: sh

      $ sudo apt install samba

-  Configure a Samba CIFS share using ZFS.

   .. code-block:: sh

      $ sudo zfs set sharesmb=on <POOL>/<DATASET>

-  Configure a user for Samba and correct the permissions.

   .. code-block:: sh

      $ sudo useradd <SAMBA_USER>
      $ sudo chown -r <SAMBA_USER>:<SAMBA_GROUP> <POOL>/<DATASET>
      $ sudo smbpasswd -a <SAMBA_USER>

-  Test the CIFS mount.

   .. code-block:: sh

      $ sudo apt install cifs-utils
      $ sudo mount -t cifs -o username=foo,password=foobar //127.0.0.1/<POOL>_<DATASET> /mnt

Properties and Options
^^^^^^^^^^^^^^^^^^^^^^

ZFS settings are configured in one of two ways:

1.  Properties can be set using ``sudo zfs set <PROPERTY>=<VALUE> <POOL_NAME>/<DATASET_NAME>``.
2.  ZFS kernel module settings can be set by creating a modprobe configuration file, updating the initramfs, and rebooting. [54]

   -  Syntax:

      .. code-block:: sh

         $ sudo -E ${EDITOR} /etc/modprobe.d/zfs.conf
         options zfs <KEY_1>=<VALUE_1> <KEY_2>=<VALUE_2>

      -  Arch Linux:

         .. code-block:: sh

            $ sudo mkinitcpio -P

      -  Debian:

         .. code-block:: sh

            $ sudo update-initramfs -u

      -  Fedora:

         .. code-block:: sh

            $ sudo dracut --regenerate-all --force

**Properties [53]:**

.. code-block:: sh

   $ man zfsprops

.. csv-table::
   :header: Property, Default Value, Description
   :widths: 20, 20, 20

   atime, on, Update the access time for every file that is opened.
   casesensitivity, sensitive, "If file and directory names should be case sensitive. Use ``insensitive`` if OpenZFS will be used for Samba, Wine, or Windows. [57]"
   compression, on (lzjb), Compression method to use for each file.
   xattr, on, How to store Linux extended attributes. ``on`` uses hidden files. ``sa`` uses file system inodes which are faster. [52]

**Kernel Module Options:**

.. code-block:: sh

   $ sudo modinfo zfs

.. csv-table::
   :header: Option, Default Value, Description
   :widths: 20, 20, 20

   l2arc_headroom, 2, "A multiplier of ``l2arc_write_max`` for how much new data should be written to the L2ARC cache. With default values, the L2ARC writes 675 GiB per day. [56] Use ``0`` to make the L2ARC cache persistent. [50]"
   l2arc_noprefetch, 1, If ZFS should guess what files will be accessed next and automatically store them in L2ARC.
   l2arc_write_max, 8388508 (8 MiB), "The amount of data to write to the L2ARC cache. It is recommended to modify ``l2arc_headroom`` instead of changing ``l2arc_write_max`` as that affects the frequency of when data is written to the L2ARC cache. It can become either too slow or too fast. [51]"
   zfs_arc_max, (50% of available bytes of RAM), The amount of RAM to use for ARC cache.

Performance Tuning
^^^^^^^^^^^^^^^^^^

**General**

-  Disable access times to lower the IOPS load by up to half. [52]

   .. code-block:: sh

      $ sudo zfs set atime=off <POOL_NAME>/<DATASET_NAME>

-  Enable Zstandard compression. The default compression level of 3 provides a good balance of compression to performance ration and is better than Gzip and LZ4. [58][59] Even the lowest compression level will save space while using minimal CPU resources. Existing files cannot be compressed. [55] Use one of these two settings [53]:

   .. code-block:: sh

      $ sudo zfs set compression=zstd-3 <POOL_NAME>/<DATASET_NAME>

   .. code-block:: sh

      $ sudo zfs set compression=zstd-fast-1 <POOL_NAME>/<DATASET_NAME>

-  Store extended attributes as part of the file system instead of hidden files. This increases the performance of SELinux. [52]

   .. code-block:: sh

      $ sudo zfs set xattr=sa <POOL_NAME>/<DATASET_NAME>

**Cache**

-  Set the ARC cache to be larger than the default of 50% of RAM on the system. These requires configuring the kernel module and then rebuilding the initramfs so the option takes affect when the file system is initialized. [54]

   -  Example (100 GB):

      ::

         options zfs zfs_arc_max=107374182400

-  Configure L2ARC cache to be persistent across reboots. Requires OpenZFS 2.0 or newer. [50]

   ::

      options zfs l2arc_headroom=0

-  Prevent L2ARC from guessing what files should be cached. This wastes time and resources. [51]

   ::

      options zfs l2arc_noprefetch=1

Swap
~~~~

Introduction
^^^^^^^^^^^^

Swap is a special file system that cannot be mounted. It is used by the operating system to temporarily read and write files to when the RAM is full. It prevents out-of-memory (oom) errors but it leads to a huge performance penalty because device storage is typically a lot slower than RAM. It is recommended to allocate more RAM instead of relying on swap wherever possible. According to `this poll <https://opensource.com/article/19/2/swap-space-poll>`__, most users prefer to allocate this amount of swap based on the available system RAM:

-  ``<RAM>`` = ``<SWAP>``
-  <= 2GB = x2 RAM
-  2-8GB = RAM
-  > 8GB = 8GB

`Tests <../unix_distributions/steamos.html#increase-swap-size-and-vram>`__ on the Steam Deck show that a total of 32 GB of tmpfs (RAM and swap) provide the best gaming performance for APUs. Anything beyond that provides no performance benefits. This assumes that the iGPU from the APU will use 8 GB as VRAM. That means that systems with dGPUs can use 24 GB of tmpfs instead. For the best results, use zram or add swap to a fast drive such as a NVMe drive.

Swap File
^^^^^^^^^

A swap file provides hibernation support in addition to more temporary memory. However, `zram <#zram>`__ provides better performance. It is recommended to create a swap file the same size or, at most, double the amount of RAM. [77] Fedora recommends using 1.5x the amount of RAM for swap when a system has a modern RAM size of 4 GB or more. [78]

Notes about swap files:

-  ``fallocate`` cannot be used to create swap files on most file systems. Prefer ``dd`` instead. [79]
-  Copy-on-write is not supported and can lead to unnecessary wear. Disable it for the swap file by using ``chattr +C``.

Examples of creating 12 GB of swap for a system that has 8 GB of RAM:

-  Btrfs

   .. code-block:: sh

      $ sudo btrfs subvolume create /swap
      $ sudo touch /swap/swapfile
      $ sudo chattr +C /swap/swapfile
      $ sudo dd if=/dev/zero of=/swap/swapfile bs=1M count=12000
      $ sudo chmod 600 /swap/swapfile
      $ sudo mkswap /swap/swapfile
      $ sudo swapon /swap/swapfile

-  ext4

  .. code-block:: sh

      $ sudo touch /swapfile
      $ sudo dd if=/dev/zero of=/swapfile bs=1M count=12000
      $ sudo chmod 600 /swapfile
      $ sudo mkswap /swapfile
      $ sudo swapon /swapfile

On Fedora, there is no SELinux policy for hibernation. Set SELinux to permissive mode, hibernate, turn the computer on, and then automatically create a SELinux policy for hibernation. [78]

.. code-block:: sh

   $ sudo audit2allow -b -M systemd_sleep
   $ sudo semodule -i systemd_sleep.pp

Hibernation
'''''''''''

Once a swap file has been configured, hibernation can then also be configured.

If a NVIDIA graphics card with either the proprietary or open kernel module drivers is used, it needs additional configuration first for hibernation to work.

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/modprobe.d/nvidia-hibernation-support.conf
   options nvidia NVreg_PreserveVideoMemoryAllocations=1


On immutable bootc systems such as Fedora Atomic Desktops, NVIDIA needs to use the full path to a persistent temporary directory. A symlink location will not work. [82]

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/modprobe.d/nvidia-hibernation-support.conf
   options nvidia NVreg_PreserveVideoMemoryAllocations=1
   options nvidia NVreg_TemporaryFilePath=/var/tmp

On Arch Linux, mkinitcpio needs to be configured with the "resume" hook. It must be in-between the "filesystems" and "fsck" hooks. For example [80]:

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/mkinitcpio.conf
   HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)
   $ sudo mkinitcpio -P

On Fedora, dracut needs to be configured with the "resume" hook. [81]

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/dracut.conf.d/resume.conf
   add_dracutmodules+=" resume "
   $ sudo dracut --regenerate-all --force

Enable related services. [82]

.. code-block:: sh

   $ sudo systemctl enable nvidia-hibernate nvidia-resume nvidia-suspend

zram
^^^^

zram compresses RAM as a faster alternative to a swap file. [68] It should not be used with a swap file. [72] As of Linux 6.1.0, this feature is now stable. [69] The zram size needs 0.1% of additional reserved RAM space for mapping compressed memory. [70] Either a ratio and/or maximum zram size needs to be configured. For example, a zram compression ratio of 1.5:1 with 4 GiB of RAM will result in a total tmpfs of 10 GiB.

Default settings for operating systems [71][76]:

.. csv-table::
   :header: Operating System, Compression Algorithm, Compression Ratio, Maximum Size
   :widths: 20, 20, 20, 20

   Fedora, zstd, 0.5, 8 GiB
   GalliumOS, zstd, 1.5, None
   SteamOS, zstd, 0.5, None
   winesapOS, lz4, 2.0, None

zram supports the following algorithms [70]:

-  lzo
-  lzo-rle
-  lz4
-  lz4hc
-  zstd

Benchmarks show that zstd can reliably handle up to a 3:1 compression ratio. However, zstd is also 3x slower at decompression and 2x slower at compression compared to lz4 which can reliably handle up to a 2:1 compression ratio.

Bare-metal benchmarks:

.. csv-table::
   :header: Compression Algorithm, Compression Ratio, Decompression (GiB/s)
   :widths: 20, 20, 20

   lz4, 3.00, 12.4
   lzo, 3.25, 9.31
   lzo-rle, 3.25, 9.78
   zstd, 4.43, 3.91

Virtual machine benchmarks [72]:

.. csv-table::
   :header: Compression Algorithm, Compression Ratio, Decompression (GiB/s)
   :widths: 20, 20, 20

   lz4, 2.63, 9.62
   lzo, 2.74,  6.66
   lzo-rle, 2.77, 7.27
   zstd, 3.37, 2.61

Additional virtual machine benchmarks [73]:

.. csv-table::
   :header: Compression Algorithm, Compression Ratio, Compression Time (Seconds)
   :widths: 20, 20, 20

   lz4, 2.7, 4.467
   lzo, 2.8, 4.571
   lzo-rle, 2.8, 4.471
   zstd, 3.8, 7.897

Install zram-generator for configuring zram.

-  Arch Linux:

     .. code-block:: sh

        $ sudo pacman -S zram-generator

-  Debian [74]:

     .. code-block:: sh

        $ sudo apt-get install systemd-zram-generator

-  Fedora:

     .. code-block:: sh

        $ sudo dnf install zram-generator

Configure lz4 for a faster but smaller zram. Set ``vm.page-cluster=1`` to enable a short readahead as this provides the best performance with lz4. Additionally use other ``vm.watermark_*`` optimizations found by Pop!_OS to improve gaming performance. [75]

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/sysctl.d/99-zram.conf
   vm.swappiness = 180
   vm.watermark_boost_factor = 0
   vm.watermark_scale_factor = 125
   vm.page-cluster = 1
   $ sudo -E ${EDITOR} /etc/systemd/zram-generator.conf
   [zram0]
   compression-algorithm = lz4
   zram-size = ram * 2
   $ sudo systemctl enable systemd-zram-setup@zram0.service

Alternatively, configure zstd for a larger but slower zram. Set ``vm.page-cluster=0`` to disable readahead as it only hurts performance with zstd.

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/sysctl.d/99-zram.conf
   vm.swappiness = 180
   vm.watermark_boost_factor = 0
   vm.watermark_scale_factor = 125
   vm.page-cluster = 0
   $ sudo -E ${EDITOR} /etc/systemd/zram-generator.conf
   [zram0]
   compression-algorithm = zstd
   zram-size = ram * 3
   $ sudo systemctl enable systemd-zram-setup@zram0.service

ramfs and tmpfs
^^^^^^^^^^^^^^^

``ramfs`` is a RAM-only file system. ``tmpfs`` uses a combination of RAM and swap. The contents of these file systems are lost after a shutdown.

Reduce writes by configuring temporary and log directories to use ``tmpfs`` (if using zram) or ``ramfs`` (if using a swap file). [86]

.. code-block:: sh

    $ sudo -E ${EDITOR} /etc/fstab
    tmpfs    /tmp        tmpfs    defaults,rw,nosuid,nodev,inode64,mode=1777    0 0
    tmpfs    /var/log    tmpfs    defaults,rw,nosuid,nodev,inode64              0 0
    tmpfs    /var/tmp    tmpfs    defaults,rw,nosuid,nodev,inode64,mode=1777    0 0

RAIDs
-----

RAID officially stands for "Redundant Array of Independent Disks." The
idea of a RAID is to get either increased performance and/or an
automatic backup from using multiple disks together. It utilizes these
drives to create 1 logical drive.

.. csv-table::
   :header: RAID Level, Minimum Drivers, Speed, Redundancy, Increased Storage, Description
   :widths: 20, 20, 20, 20, 20, 20

   0, 2, Yes, No, Yes, "I/O operations are equally spread to each disk."
   1, 2, No, Yes, No, "If one drive fails, a second drive will have an exact copy of all of the data. Slower write speeds."
   5, 3, Yes, Yes, Yes, "This can recover from a failed drive without any affect on performance. Drive recovery takes a long time and will not work if more than on drive fails."
   6, 4, Yes, Yes, Yes, "This is an enhanced RAID 5 that can survive up to 2 drive failures."
   10, 4, Yes, Yes, Yes, "This uses both RAID 1 and 0 together. Requires more physical drives. Rebuilding or restoring a RAID 10 will require downtime."

[10]

mdadm
~~~~~

Most software RAIDs in Linux are handled by the "mdadm" utility and the
"md\_mod" kernel module. Creating a new RAID requires specifying the
RAID level and the partitions you will use to create it.

Syntax:

.. code-block:: sh

    $ sudo mdadm --create --level=<LEVEL> --raid-devices=<NUMBER_OF_DISKS> /dev/md<DEVICE_NUMBER_TO_CREATE> /dev/sd<PARTITION1> /dev/sd<PARTITION2>

Example:

.. code-block:: sh

    $ sudo mdadm --create --level=10 --raid-devices=4 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1

Then to automatically create the partition layout file run this:

.. code-block:: sh

    $ sudo echo 'DEVICE partitions' > /etc/mdadm.conf
    $ sudo mdadm --detail --scan >> /etc/mdadm.conf

Finally, you can initialize the RAID.

.. code-block:: sh

    $ sudo mdadm --assemble --scan

[11]

Network
-------

NFS
~~~

Linux Client and Server
^^^^^^^^^^^^^^^^^^^^^^^

The Network File System (NFS) aims to universally provide a way to
remotely mount directories between servers. All subdirectories from a
shared directory will also be available.

NFSv4 port:

-  2049 TCP

NFSv3 ports:

-  111 TCP/UDP
-  2049 TCP/UDP
-  4045 TCP/UDP

**Client**

Install:

-  Arch Linux

   .. code-block:: sh

      $ sudo dnf install nfs-utils

-  Debian

   .. code-block:: sh

      $ sudo apt-get install nfs-common

-  Fedora

   .. code-block:: sh

      $ sudo dnf install nfs-utils

**Server**

Install:

-  Arch Linux

   .. code-block:: sh

      $ sudo dnf install nfs-utils

-  Debian

   .. code-block:: sh

      $ sudo apt-get install nfs-kernel-server

-  Fedora

   .. code-block:: sh

      $ sudo dnf install nfs-utils

On the server, the /etc/exports file is used to manage NFS exports. Here
a directory can be specified to be shared via NFS to a specific IP
address or CIDR range. After adjusting the exports, the NFS daemon will
need to be restarted.

Syntax:

::

    <DIRECTORY> <ALLOWED_HOST>(<OPTIONS>)

Example:

::

    /path/to/dir 192.168.0.0/24(rw,no_root_squash)

NFS export options:

-  rw = The directory will be writable.
-  ro (default) = The directory will be read-only.
-  no\_root\_squash = Allow remote root users to access the directory
   and create files owned by root.
-  root\_squash (default) = Do not allow remote root users to create
   files as root. Instead, they will be created as an anonymous user
   (typically "nobody").
-  all\_squash = All files are created as the anonymous user.
-  sync = Writes are instantly written to the disk. When one process is
   writing, the other processes wait for it to finish.
-  async (default) = Multiple writes are optimized to run in parallel.
   These writes may be cached in memory.
-  insecure = Allow NFS server connections from non-standard client ports.
-  sec = Specify a type of Kerberos authentication to use.

   -  krb5 = Use Kerberos for authentication only.

[12]

On Red Hat Enterprise Linux systems, the exported directory will need to
have the "nfs\_t" file context for SELinux to work properly.

.. code-block:: sh

    $ sudo semanage fcontext -a -t nfs_t "/path/to/dir{/.*)?"
    $ sudo restorecon -R "/path/to/dir"

macOS Client
^^^^^^^^^^^^

macOS defaults to using NFS version 3 but also supports version 4. [46]

-  Configure the macOS client to use NFS version 4 by default instead of 3.

   .. code-block:: sh

      $ sudo nano /etc/nfs.conf
      nfs.client.mount.options = vers=4

-  Configure the Linux NFS server to use the "insecure" export option. [47] macOS uses non-standard client ports. [48]

Windows Client
^^^^^^^^^^^^^^

Windows NFS clients require a very specific NFS server configuration.

-  Find out which user and group is being used as the default anonymous accounts on the system. Newer systems use ``nobody``/``nogroup`` and older systems use ``nfsnobody``. The default UID/GID for these accounts is normally ``65534``.

   .. code-block:: sh

      $ less /etc/idmapd.conf
      [Mapping]

      Nobody-User = nobody
      Nobody-Group = nogroup

   -  Create the accounts manually if they do not exist. [36]

      .. code-block:: sh

         $ sudo groupadd -g 65534 nfsnobody
         $ sudo useradd -u 65534 -g 65534 -d /nonexistent -s /sbin/nologin nfsnobody
         $ sudo vim /etc/idmapd.conf
         [Mapping]

         Nobody-User = nfsnobody
         Nobody-Group = nfsnobody

      -  Debian:

         .. code-block:: sh

            $ sudo systemctl restart nfs-idmapd

      -  Fedora:

         .. code-block:: sh

            $ sudo systemctl restart rpcidmapd

-  Find the exact UID and GID used by the anonymous NFS account.

   .. code-block:: sh

      $ grep nobody /etc/passwd
      nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
      $ grep nogroup /etc/group
      nogroup:x:65534:

-  Create an export using that anonymous NFS user. This will make it so that only a root user can access the share. Windows also requires all files in the NFS export to be executable, readable, and writable.

   .. code-block:: sh

      $ sudo vim /etc/exports
      /exports/foobar *(rw,sync,no_root_squash,all_squash,anonuid=65534,anongid=65534)
      $ sudo mkdir -p /exports/foobar/
      $ sudo chown -R nobody.nogroup /exports/foobar
      $ sudo chmod -R 0770 /exports/foobar
      $ sudo systemctl restart nfs-server

   -  Alternatively, set the ``anonuid`` and ``anongid`` to a Linux account that can also access the share such as ``1000``. By default, most Linux distributions create the first system user with the UID and GID of ``1000``. This user and group needs to be created and exist on both the client and the server.

-  For configuring a Windows NFS client that can be connected to a Linux NFS server, refer to `here <../windows/storage.html#nfs>`__.

[37]

GlusterFS
~~~~~~~~~

Gluster syncs two or more network shares. It is recommended to use an odd number of nodes to maintain quorum and prevent split-brain issues. [19]

**Install**

CentOS:

.. code-block:: sh

   $ sudo yum install centos-release-gluster
   $ sudo yum install glusterfs-server

Debian:

.. code-block:: sh

   $ sudo apt-get install glusterfs-server

Fedora:

.. code-block:: sh

   $ sudo dnf install glusterfs-server

Start and enable the service.

.. code-block:: sh

   $ sudo systemctl enable --now glusterd

**Usage**

From one of the nodes, peer the other nodes to add them to the known hosts running Gluster services.

.. code-block:: sh

   $ sudo gluster peer probe <NODE2>
   $ sudo gluster peer probe <NODE3>
   $ sudo gluster peer status

There are three types of volumes that can be created:

-  replica = Reliability. Save a copy of every file to each node.
-  disperse = Reliability and performance. A combination of replica and stripe. Files are read from and written to different nodes.
-  stripe = Performance. Spread each file onto different nodes to spread out the I/O load among all of the nodes.

.. code-block:: sh

   $ gluster volume create <VOLUME_NAME> <VOLUME_TYPE> <NODE1>:/<PATH_TO_STORAGE> <NODE2>:/<PATH_TO_STORAGE> <NODE3>:/<PATH_TO_STORAGE> force
   $ gluster volume start <VOLUME_NAME>
   $ gluster volume status <VOLUME_NAME>

On a client, mount the ``glusterfs`` file system and verify that it works.

.. code-block:: sh

   $ sudo mount -t glusterfs <NODE1>:/<VOLUME_NAME> /mnt
   $ sudo touch /mnt/test

[20]

SMB
~~~

The Server Message Block (SMB) protocol was created to view and edit
files remotely over a network. The Common Internet File System (CIFS)
was created by Microsoft as an enhanced fork of SMB but was eventually
replaced with newer versions of SMB. On Linux, the "Samba" service is
typically used for setting up SMB share. [13]

SMB Ports:

-  137 UDP
-  138 UDP
-  139 TCP
-  445 TCP

Samba
^^^^^

CIFS and SMB are network file system protocols created by Microsoft. Samba is an open source server created for UNIX-like servers that implements these protocols.

**Client**

Installation:

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S cifs-utils

-  Debian:

   .. code-block:: sh

      $ sudo apt-get install cifs-utils

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install cifs-utils

**Server**

Installation:

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S samba

-  Debian [45]:

   .. code-block:: sh

      $ sudo apt-get samba samba-client

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install samba samba-client

The default configuration file is located at ``/etc/samba/smb.conf`` and is in an "ini" format. Samba share settings can be set at the ``[global]`` or in a ``[<SHARE_NAME>]``. Global settings cannot be defined in a ``[<SHARE_NAME>]``. [14] Boolean settings can have a value of ``false``/``no`` or ``true``/``yes``.

.. code-block:: ini

   [global]
   <GLOBAL_CONFIG_KEY> = <GLOBAL_CONFIG_VALUE>
   <SHARE_CONFIG_KEY> = <SHARE_CONFIG_VALUE>

   [<SHARE_NAME>]
   <SHARE_CONFIG_KEY> = <SHARE_CONFIG_VALUE>

Global:

-  interfaces (string) = Specify the interfaces to listen on.
-  unix extensions (boolean) = This only works for the NT1 protocol. Samba developers are working on adding support to the SMB3 protocol. [30] It enables UNIX file system capabilities such as symbolic and hard links. Default: ``yes``.
-  workgroup (string) = Define a workgroup name. Default: ``MYGROUP``.

Share:

-  acl allow execute always (boolean) = If all files should be executable by Windows (not UNIX) clients. Default: ``no``.
-  allocation roundup size (integer) = The number of bytes for rounding up. This used to be set to ``1048576`` bytes (which is 1 MiB). Using ``0`` will not round up and provide an accurate size. Default: ``0``.
-  [client|server] [max|min] protocol (string) = The protocol restrictions that should be set. Common protocols: ``NT1``, ``SMB2``, and ``SMB3``. All protocols: ``CORE``, ``COREPLUS``, ``LANMAN1``, ``LANMAN2``, ``NT1``, ``SMB2_02``, ``SMB2_10``, ``SMB2_22``, ``SMB2_24``, ``SMB3_00``, ``SMB3_02``, ``SMB3_10``, ``SMB3_11`` (``SMB3``), or ``SMB2_FF``.

   -  client max protocol = Default: ``SMB3_11``.
   -  client min protocol = Default: ``SMB2_02``.
   -  server max protocol = Default: ``SMB3_11``.
   -  server min protocol = Default: ``SMB2_02``.

-  comment (string) = Place a comment about the share. Default: none.
-  create mask, create mode (integer) = The maximum permissions a file can have when it is created. Default: ``0744``.
-  directory mask (integer) = The maximum permissions a directory can have when it is created.: Default: ``0755``.
-  force create mode (integer) = The minimum permissions a file can have when it is created. Default: ``0000``.
-  force directory mode (integer) = The minimum permissions a directory can have when it is created. Default: ``0000``.
-  hosts allow (string) = Specify hosts allowed to access any of the shares. Wildcard IP addresses can be used by omitting different octets. For example, "127." would be a wildcard for anything in the 127.0.0.0/8 range. Default: all hosts are allowed.
-  **path** (string) = The path to the directory to share. Default is what the ``root directory`` value is set to.
-  read only (boolean) = This is the opposite of the writable option. Only one or the other option should be used. If set to no, the share will have write permissions. Default: ``yes``.
-  root directory (string) = The primary directory for Samba to share. Default: none.
-  writeable, writable, and write ok (boolean) = This specifies if the folder share is writable. Default: ``no``.
-  write list (string) = Specify users that can write to the share, separated by spaces. Groups can also be specified using by appending a "+" to the front of the name. Default: none.

Deprecated and removed settings:

-  Share:

   -  directory security mask (integer) = Removed in Samba 4. The maximum Windows permissions for a directory.
   -  force security mode (integer) = Removed in Samba 4. The minimum Windows permissions for a file.
   -  force directory security mode (integer) = Removed in Samba 4. The minimum Windows permissions for a directory.
   -  security mask (integer) = Removed in Samba 4. The maximum Windows permissions for a file.

[14][31]

Example configurations:

-  Force specific permissions for all files and directories.

   .. code-block:: ini

      [share]
      create mask = 0664
      force create mode = 0664
      directory mask = 0775
      force directory mode = 0775

-  Force all files to be executable.

   .. code-block:: ini

      [share]
      acl allow execute always = yes
      create mask = 0775
      force create mode = 0775

-  Enable UNIX extensions for soft and hard links to work.

   .. code-block:: ini

      [global]
      client min protocol = NT1
      server min protocol = NT1
      unix extensions = yes

Verify the Samba configuration.

.. code-block:: sh

    $ sudo testparm
    $ sudo smbclient //localhost/<SHARE_NAME> -U <SMB_USER1>%<SMB_USER1_PASS>

The Linux user for accessing the SMB share will need to be created and
have their password added to the Samba configuration. These are stored
in a binary file at "/var/lib/samba/passdb.tdb." This can be updated by
running:

.. code-block:: sh

    $ sudo useradd <SMB_USER1>
    $ sudo smbpasswd -a <SMB_USER1>

On Red Hat Enterprise Linux systems, the exported directory will need to
have the "samba\_share\_t" file context for SELinux to work properly.
[15]

.. code-block:: sh

    $ sudo semanage fcontext -a -t samba_share_t "/path/to/dir{/.*)?"
    $ sudo restorecon -R "/path/to/dir"

iSCSI
~~~~~

The "Internet Small Computer Systems Interface" (also known as "Internet
SCSI" or simply "iSCSI") is used to allocate block storage to servers
over a network. It relies on two components: the target (server) and the
initiator (client). The target must first be configured to allow the
client to attach the storage device.

Target
^^^^^^

For setting up a target storage, these are the general steps to follow
in order:

-  Create a backstores device.
-  Create an iSCSI target.
-  Create a network portal to listen on.
-  Create a LUN associated with the backstores.
-  Create an ACL.
-  Optionally configure ACL rules.

-  First, start and enable the iSCSI service to start on bootup.

Syntax:

.. code-block:: sh

    $ sudo systemctl enable target && systemctl start target

-  Create a storage device. This is typically either a block device or a
   file.

Block syntax:

.. code-block:: sh

       $ sudo targetcli
       > cd /backstores/block/
       > create iscsidisk1 dev=/dev/sd<DISK>

File syntax:

.. code-block:: sh

       $ sudo targetcli
       > cd /backstore/fileio/
       > create iscsidisk1 /<PATH_TO_DISK>.img <SIZE_IN_MB>M

-  A special iSCSI Qualified Name (IQN) is required to create a Target
   Portal Group (TPG). The syntax is
   "iqn.YYYY-MM.tld.domain.subdomain:exportname."

Syntax:

.. code-block:: sh

    > cd /iscsi
    > create iqn.YYYY-MM.<TLD.DOMAIN>:<ISCSINAME>

Example:

.. code-block:: sh

    > cd /iscsi
    > create iqn.2016-01.com.example.server:iscsidisk
    > ls

-  Create a portal for the iSCSI device to be accessible on.

Syntax:

.. code-block:: sh

    > cd /iscsi/iqn.YYYY-MM.<TLD.DOMAIN>:<ISCSINAME>/tpg1
    > portals/ create

Example:

.. code-block:: sh

    > cd /iscsi/iqn.2016-01.com.example.server:iscsidisk/tpg1
    > ls
    o- tpg1
    o- acls
    o- luns
    o- portals
    > portals/ create
    > ls
    o- tpg1
    o- acls
    o- luns
    o- portals
        o- 0.0.0.0:3260

-  Create a LUN.

Syntax:

.. code-block:: sh

    > luns/ create /backstores/block/<DEVICE>

Example:

.. code-block:: sh

    > luns/ create /backstores/block/iscsidisk

-  Create a blank ACL. By default, this will allow any user to access
   this iSCSI target.

Syntax:

.. code-block:: sh

    > acls/ create iqn.YYYY-MM.<TLD.DOMAIN>:<ACL_NAME>

Example:

.. code-block:: sh

   > acls/ create iqn.2016-01.com.example.server:client

-  Optionally, add a username and password.


Syntax:

.. code-block:: sh

    > cd acls/iqn.YYYY-MM.<TLD.DOMAIN>:<ACL_NAME>
    > set auth userid=<USER>
    > set auth password=<PASSWORD>

Example:

.. code-block:: sh

    > cd acls/iqn.2016-01.com.example.server:client
    > set auth userid=toor
    > set auth password=pass

-  Any ACL rules that were created can be overridden by turning off
   authentication entirely.

Syntax:

.. code-block:: sh

    > set attribute authentication=0
    > set attribute generate_node_acls=1
    > set attribute demo_mode_write_protect=0

-  Finally, make sure that both the TCP and UDP port 3260 are open in
   the firewall. [16]

Initiator
^^^^^^^^^

This should be configured on the client server.

-  In the initiator configuration file, specify the IQN along with the
   ACL used to access it.

Syntax:

.. code-block:: sh

    $ sudo vim /etc/iscsi/initiatorname.iscsi
    InitiatorName=<IQN>:<ACL>

Example:

.. code-block:: sh

    $ sudo vim /etc/iscsi/initiatorname.iscsi
    InitiatorName=iqn.2016-01.com.example.server:client

-  Start and enable the iSCSI initiator to load on bootup.

Syntax:

.. code-block:: sh

    $ sudo systemctl start iscsi && systemctl enable iscsi

-  Once started, the iSCSI device should be able to be attached.

Syntax:

.. code-block:: sh

    $ sudo iscsiadm --mode node --targetname <IQN>:<TARGET> --portal <iSCSI_SERVER_IP> --login

Example:

.. code-block:: sh

    $ sudo iscsiadm --mode node --targetname iqn.2016-01.com.example.server:iscsidisk --portal 10.0.0.1 --login

-  Verify that a new "iscsi" device exists.

Syntax:

.. code-block:: sh

    $ sudo lsblk --scsi

[16]

Encrypted Partitions
--------------------

Linux Unified Key Setup (LUKS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Setup
^^^^^

Install LUKS:

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S cryptsetup

-  Debian:

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install cryptsetup

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install cryptsetup-luks

Encrypt a partition non-interactively:

.. code-block:: sh

   $ echo <PASSWORD> | sudo cryptsetup -q luksFormat /dev/<DEVICE><PARTITION_NUMBER>

Open the encrypted partition as a specified ``/dev/mapper/<DEVICE_MAPPER_NAME>`` device which can be formatted and mounted as normal.

.. code-block:: sh

   $ echo <PASSWORD> | sudo cryptsetup luksOpen /dev/<DEVICE><PARTITION_NUMBER> <DEVICE_MAPPER_NAME>

[33]

Passwords
^^^^^^^^^

LUKS encrypted partitions can be accessed either with a password from standard input or a key file.

Add an additional password to unlock the encrypted partition:

.. code-block:: sh

   $ sudo cryptsetup luksAddKey /dev/<DEVICE><PARTITION_NUMBER>

Change an existing password (add a new password and delete the old one):

.. code-block:: sh

   $ sudo cryptsetup luksChangeKey /dev/<DEVICE><PARTITION_NUMBER>

Remove one of the existing passwords:

.. code-block:: sh

   $ sudo cryptsetup luksRemoveKey /dev/<DEVICE><PARTITION_NUMBER>

[34]

LUKS can use a key file to decrypt a partition. This can contain any kind of data. It is recommended to use either data from ``/dev/urandom``, ``/dev/random``, or the command ``openssl``.

.. code-block:: sh

   $ dd bs=512 count=8 if=/dev/urandom of=<PATH_TO_NEW_KEY_FILE>

.. code-block:: sh

   $ openssl genrsa -out <PATH_TO_NEW_KEY_FILE> 4096

Add an additional key file to unlock the encrypted partition:

.. code-block:: sh

   $ sudo cryptsetup luksAddKey /dev/<DEVICE><PARTITION_NUMBER> <PATH_TO_NEW_KEY_FILE>

Use a key file to open an encrypted partition:

.. code-block:: sh

   $ sudo cryptsetup luksOpen /dev/<DEVICE><PARTITION_NUMBER> <DEVICE_MAPPER_NAME> --key-file=<PATH_TO_KEY_FILE>

[35]

Mounting
--------

Mount Options
~~~~~~~~~~~~~

Mount options can be specified with the ``mount -o`` command or in the fourth column of the ``/etc/fstab`` file.

-  ``commit=<COMMIT_TIME>`` = The time before the file system runs ``sync`` to flush writes in RAM to the storage device. There may be noticeable lag or a system hang if the interval is too long or if the drive is too slow. Default values:

   -  Btrfs = 30 seconds [83]
   -  ext4 (Linux) = 5 seconds
   -  ext4 (ChromeOS) = 600 seconds [84]
   -  ZFS (zfs_txg_timeout) = 5 seconds [85]

      -  Create a configuration file ``/etc/modprobe.d/zfs-txg-timeout.conf`` with ``options zfs zfs_txg_timeout=<COMMIT_TIME>``.

-  ``noatime,nodiratime`` = Do not write the access time for files or directories (as seen by ``stat <FILE_OR_DIRECTORY>``) when a file is viewed. This reduces writes but also reduces the amount of security logs. Modify and change times are still logged.

Image Files
~~~~~~~~~~~

ISO:

-  Mount an ISO (CD/DVD) image:

   .. code-block:: sh

      $ sudo mount -t iso9660 -o loop <IMAGE>.iso /mnt

Raw image with partitions [32]:

-  Expose the partitions in the raw image. The image file extension is normally ``bin``, ``img``, or ``raw``. The partitions will be available at ``/dev/mapper/loop<LOOP_DEVICE_NUMBER>p<PARTITION_NUMBER>``.

   .. code-block:: sh

      $ sudo kpartx -a -v <IMAGE>.img

-  Mount and unmount the first partition.

   .. code-block:: sh

      $ sudo mount /dev/mapper/loop0p1 /mnt
      $ sudo umount /dev/mapper/loop0p1

-  Remove the partition mappings by referencing the raw image file or the loop device. This essentially ejects the raw image.

   .. code-block:: sh

      $ sudo kpartx -d -v <IMAGE>.img

   .. code-block:: sh

      $ sudo kpartx -d -v /dev/loop<LOOP_DEVICE_NUMBER>

Filesystem Hierarchy Standard
-----------------------------

The FHS provides a standard layout for files and directories for UNIX-like operating systems and is adopted by most Linux distributions.

Minimal [18]:

-  / = The top level root directory that the operating system is installed in.
-  /bin/ = Binaries for common utilities for end-users.
-  /boot/ = The boot loader, Linux kernel, and initial RAM disk image.
-  /dev/ = Files for handling devices that support input and/or output.
-  /etc/ = Configuration files for services.
-  /home/ = All user home directories.
-  /lib/ = Libraries for all of the binaries.
-  /media/ = Mount points for physical media such as USB and disk drives.
-  /mnt/ = Temporary mount point for other file systems.
-  /opt/ = Optional third-party (usually proprietary) software.
-  /proc/ = Information about the system reported by the Linux kernel.
-  /root/ = The "root" user's home directory.
-  /sbin/ = System binaries required to start the operating system.
-  /sys/ = Configurable kernel settings.
-  /tmp/ = Temporary storage.
-  /usr/ = Unix system resources. These programs are not used when booting a system.
-  /var/ = Variable data. Databases, logs, and temporary files are normally stored here.

Full:

-  /etc/

   - /etc/bash.bashrc = Bash specific shell functions.
   - /etc/crypttab = The LUKS encrypted partition table.
   - /etc/environment = Global shell variables.
   - /etc/fstab = The partition table of partitions to mount on boot.
   - /etc/issue = The message banner to display before login for local users.
   - /etc/issue.net = The message banner to displaybefore login for remote users. This also needs to be configured in the ``/etc/ssh/sshd_config`` for SSH users.
   - /etc/motd = The message of the day banner to display after a successful login.
   - /etc/passwd = Basic user account settings.
   - /etc/profile = Generic shell functions.
   - /etc/profile.d/ = A collection of custom user-defined shell functions.
   - /etc/rsyslog.conf = rsyslogd configuration for most handling OS system logs.
   - /etc/shadow = Encrypted user passwords.
   - /etc/shells = Lists all available CLI shells.
   - /etc/sysconfig/selinux = SELinux configuration.
   - /etc/systemd/system/ = Administrator defined custom systemd service files. These will override any files from the default ``/usr/lib/systemd/system/`` location.

-  /proc/

   - /proc/<PID>/ = A folder will exist for every running PID.
   - /proc/cmdline = Kernel boot arguments provided by the bootloader.
   - /proc/cpuinfo = Information about the processor.
   - `/proc/sys/vm/ <https://www.kernel.org/doc/Documentation/sysctl/vm.txt>`__

      - /proc/sys/vm/drop_caches = Handles removing cached memory. Set to "3" for dropping all caches.

-  /sys/

   - /sys/class/backlight/<BACKLIGHT_DEVICE>/{brightness,actual_brightness,max_brightness} = View and set the brightness level of the physical monitor.
   - /sys/class/net = The full list of network devices.
   - /sys/class/power_supply/BAT1/capacity = Show the maximum charge of the battery.
   - /sys/class/power_supply/BAT1/status = Show the current battery charge left.
   - /sys/class/scsi_device/device/rescan = Force a rescan of all drives by setting to "1".
   - /sys/class/scsi_host/host<PORT>/scan = Manually scan for a device on that port by setting to "- - -".
   - /sys/block/<DEVICE>/device/delete = Manually deactivate a device by setting to "1".

-  /var/

   -  /var/log/ = System logs.

      -  /var/log/audit/audit.log = SELinux log file.

   -  /var/run/utmp = Shows currently logged in users.
   -  /var/spool/cron/ = User crontabs are stored here.

-  ~/ or $HOME

   - ~/.bash_profile = Shell aliases and functions are sourced for interactive users only.
   - ~/.bashrc = Non-interactive and interactive shells will source aliases and functions from here.
   - ~/.local/share/applications/ = Desktop application shortcuts.

Troubleshooting
---------------

Errors
~~~~~~

Error when looking up ZFS pools.

.. code-block:: sh

   $ sudo zpool list
   no pools available

Temporary solutions [26]:

1. Import the pool automatically. This will search for available ZFS devices with the defined pool name.

   .. code-block:: sh

      $ sudo zpool import <POOL>

2.  Or explicitly import a specific device and name.

   .. code-block:: sh

      $ sudo zpool import -d /dev/<DEVICE> <POOL>

Permanent solution [28]:

1.  Start and enable these services so any zpools that are created and/or changed will be persistent upon reboots. Existing zpools will be loaded immediately.

   .. code-block:: sh

      $ sudo systemctl enable zfs-import-cache
      $ sudo systemctl enable zfs-import.target

----

Mounting a CIFS share states that it is read-only.

.. code-block:: sh

   $ sudo mount -t cifs //<SAMBA_SERVER_ADDRESS>/<SAMBA_SHARE> /mnt
   mount: /mnt: cannot mount //<SAMBA_SERVER_ADDRESS>/<SAMBA_SHARE> read-only.

Solution:

-  Install the package for CIFS client tools: ``cifs-utils``.

----

Mounting a NFS export on macOS fails because ``rpc.statd`` is not running on the server.

::

   $ sudo mount -t nfs 10.10.10.5:/export /Users/sjobs/NFSDocuments
   mount_nfs: can't mount with remote locks when server (10.10.10.5) is not running rpc.statd: RPC prog. not avail
   mount: /Users/sjobs/NFSDocuments failed with 74

Solutions [46]:

-  The NFS server may be running NFS version 4 which does not require the ``rpc.statd`` service.

   -  Force the use of NFS version 4.

      -  Temporarily: ``$ sudo mount -t nfs -o ver=4``
      -  Permanently:

         .. code-block:: sh

            $ sudo nano /etc/nfs.conf
            nfs.client.mount.options = vers=4

   -  Alternatively, enable backwards compatibility on the NFS server.

      .. code-block:: sh

         $ sudo systemctl enable --now rpc-statd

----

Mounting a NFS export on macOS with a generic error message saying ``Operation not permitted``.

::

   $ sudo mount -t nfs 10.10.10.5:/export /Users/sjobs/NFSDocuments
   mount_nfs: can't mount /export from 10.10.10.5 onto /Users/sjobs/NFSDocuments: Operation not permitted
   mount: /Users/sjobs/NFSDocuments failed with 1

Solutions:

-  The ``mount`` command needs to be run with ``sudo``.
-  macOS uses non-standard NFS client ports. The NFS server needs to update the export to include the "insecure" option. [46]

   .. code-block:: sh

      $ sudo nano /etc/exports
      $ sudo systemctl restart nfs-server

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/storage/file_systems.rst>`__
-  `< 2020.07.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/file_systems.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/file_systems.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/file_systems.md>`__

Bibliography
------------

1. "Linux File systems Explained." Ubuntu Documentation. November 8, 2015. https://help.ubuntu.com/community/LinuxFilesystemsExplained
2. "How many files can I put in a directory?" Stack Overflow. July 14, 2015.http://stackoverflow.com/questions/466521/how-many-files-can-i-put-in-a-directory
3. "Btrfs Main Page." Btrfs Kernel Wiki. June 24, 2016. https://btrfs.wiki.kernel.org/index.php/Main\_Page
4. "What’s All This I Hear About Btrfs For Linux." The Personal Blog of Dan Calloway. December 16, 2012. https://danielcalloway.wordpress.com/2012/12/16/whats-all-this-i-hear-about-btrfs-for-linux/
5. "Mount Options" Btrfs Kernel Wiki. May 5, 2016. https://btrfs.wiki.kernel.org/index.php/Mount\_options
6. "Using Btrfs with Multiple Devices" Btrfs Kernel Wiki. May 14, 2016. https://btrfs.wiki.kernel.org/index.php/Using\_Btrfs\_with\_Multiple\_Devices
7. "Preventing a btrfs Nightmare." Jupiter Broadcasting. July 6, 2014. http://www.jupiterbroadcasting.com/61572/preventing-a-btrfs-nightmare-las-320/
8. "Linux File Systems: Ext2 vs Ext3 vs Ext4." The Geek Stuff. May 16, 2011. Accessed October 1, 2016. http://www.thegeekstuff.com/2011/05/ext2-ext3-ext4
9. "Ext4 Filesystem." Kernel Documentation. May 29, 2015. Accessed October 1, 2016. https://kernel.org/doc/Documentation/filesystems/ext4.txt
10. "RAID levels 0, 1, 2, 3, 4, 5, 6, 0+1, 1+0 features explained in detail." GOLINUXHUB. April 09, 2016. Accessed August 13th, 2016. http://www.golinuxhub.com/2014/04/raid-levels-0-1-2-3-4-5-6-01-10.html
11. "RAID." Arch Linux Wiki. August 7, 2016. Accessed August 13, 2016. https://wiki.archlinux.org/index.php/RAID
12. "NFS SERVER CONFIGURATION." Red Hat Documentation. Accessed September 19, 2016.  https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux/7/html/Storage\_Administration\_Guide/nfs-serverconfig.html
13. "The Difference between CIFS and SMB." VARONIS. February 14, 1024. Accessed September 18th, 2016. https://blog.varonis.com/the-difference-between-cifs-and-smb/
14. "Chapter 6. The Samba Configuration File." Samba Docs Using Samba. April 26, 2018. Accessed March 13, 2021. https://www.samba.org/samba/docs/using_samba/ch06.html
15. "RHEL7: Provide SMB network shares to specific clients." CertDepot. August 25, 2016. Accessed September 18th, 2016. https://www.certdepot.net/rhel7-provide-smb-network-shares/
16. "RHEL7: Configure a system as either an iSCSI target or initiator that persistently mounts an iSCSI target." CertDepot. July 30, 2016. Accessed August 13, 2016. https://www.certdepot.net/rhel7-configure-iscsi-target-initiator-persistently/
17. "Btrfs." Fedora Project Wiki. March 9, 2017. Accessed May 11, 2018. https://fedoraproject.org/wiki/Btrfs
18. "FilesystemHierarchyStandard." Debian Wiki. April 21, 2017. Accessed December 5, 2018. https://wiki.debian.org/FilesystemHierarchyStandard
19. "Split brain and the ways to deal with it." Gluster Docs. Accessed February 12, 2019. https://docs.gluster.org/en/latest/Administrator%20Guide/Split%20brain%20and%20ways%20to%20deal%20with%20it/
20. "Setting up GlusterFS Volumes." Gluster Docs. Accessed February 12, 2019. https://docs.gluster.org/en/latest/Administrator%20Guide/Setting%20Up%20Volumes/
21. "Main Page." OpenZFS Wiki. October 15, 2020. Accessed December 4, 2020. https://openzfs.org/wiki/Main_Page
22. "ZFS." Debian Wiki. November 4, 2020. Accessed December 4, 2020. https://wiki.debian.org/ZFS
23. "ZFS." Ubuntu Wiki. January 22, 2019. Accessed December 4, 2020. https://wiki.ubuntu.com/ZFS
24. "Custom Packages." OpenZFS Documentation. 2020. Accessed December 6, 2020. https://openzfs.github.io/openzfs-docs/Developer%20Resources/Custom%20Packages.html
25. "ZFS on Ubuntu: Create ZFS pool with NVMe L2ARC and share via SMB." ServeTheHome. October 25, 2015. Accessed December 5, 2020. https://www.servethehome.com/zfs-on-ubuntu-create-zfs-pool-with-nvme-l2arc-and-share-via-smb/
26. "Error: no pools available." Reddit /r/zfs. March 7, 2020. Accessed December 5, 2020. https://www.reddit.com/r/zfs/comments/ff5ea5/error_no_pools_available/
27. "Sharing ZFS Datasets Via NFS." Programster's Blog. July 6, 2019. Accessed December 6, 2020. https://blog.programster.org/sharing-zfs-datasets-via-nfs
28. "ZFS." ArchWiki. November 23, 2020. Accessed December 5, 2020. https://wiki.archlinux.org/index.php/ZFS
29. "25. Command Line Interface." FreeNAS 11.3-RELEASE User Guide. https://www.ixsystems.com/documentation/freenas/11.3-RELEASE/cli.html
30. "unix extensions not working?" Ubuntu Bugs samba package. June 12, 2020. Accessed March 13, 2021. https://bugs.launchpad.net/ubuntu/+source/samba/+bug/1883234
31. "smb.conf - The configuration file for the Samba suite." Samba Docs. Accessed March 13, 2021. https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html
32. "kpartx - Create device maps from partition tables." Ubuntu Manpage. Accessed August 2, 2021. https://manpages.ubuntu.com/manpages/focal/man8/kpartx.8.html
33. "Encrypting data partitions using LUKS." IBM Sterling Order Management Software 10.0.0 Documentation. Accessed September 12, 2021. https://www.ibm.com/docs/en/order-management-sw/10.0?topic=considerations-encrypting-data-partitions-using-luks
34. "cryptsetup(8)." Linux manual page. Accessed September 12, 2021. https://man7.org/linux/man-pages/man8/cryptsetup.8.html
35. "How to enable LUKS disk encryption with keyfile on Linux." nixCraft. Accessed September 12, 2021. https://www.cyberciti.biz/hardware/cryptsetup-add-enable-luks-disk-encryption-keyfile-linux/
36. "chown: invalid user: 'nfsnobody' in fedora 32 after install nfs." Stack Overflow. August 14, 2020. Accessed December 20, 2021. https://stackoverflow.com/questions/62980913/chown-invalid-user-nfsnobody-in-fedora-32-after-install-nfs
37. "Mounting NFS share from Linux to Windows server." techbeatly. June 12, 2019. Accessed December 20, 2021. https://www.techbeatly.com/mounting-nfs-share-from-linux-to-windows-server/
38. "Building ZFS." OpenZFS Documentation. 2021. Accessed February 5, 2022. https://openzfs.github.io/openzfs-docs/Developer%20Resources/Building%20ZFS.html
39. "File systems." Arch Wiki. January 25, 2022. Accessed February 9, 2022. https://wiki.archlinux.org/title/file_systems
40. "How to mount an exFAT drive on Linux." Xmodulo. January 31, 2021. Accessed February 9, 2022. https://www.xmodulo.com/mount-exfat-drive-linux.html
41. "Linux 5.15 Delivers Many Features With New NTFS Driver, In-Kernel SMB3 Server, New Hardware." Phoronix. September 13, 2021. Accessed March 30, 2022. https://www.phoronix.com/scan.php?page=article&item=linux-515-features&num=1
42. "exFAT external drive not recognized on Windows." Ask Ubuntu. August 16, 2016. Accessed March 2, 2023. https://askubuntu.com/questions/706608/exfat-external-drive-not-recognized-on-windows
43. "Kernel 5.15 : ntfs3 vs ntfs-3g." LinuxQuestions.org. September 9, 2021. Accessed March 2, 2023. https://www.linuxquestions.org/questions/slackware-14/kernel-5-15-ntfs3-vs-ntfs-3g-4175702945/
44. "Renaming a ZFS pool." Prefetch Technologies. November 15, 2006. Accessed May 15, 2023. https://prefetch.net/blog/2006/11/15/renaming-a-zfs-pool/
45. "Samba file sharing server." Debian Wiki. January 27, 2021. Accessed June 24, 2023. https://wiki.debian.org/Samba/ServerSimple
46. "AFP vs NFS vs SMB Performance on macOS Mojave." Photography Life. April 25, 2020. Accessed August 2, 2023. https://photographylife.com/afp-vs-nfs-vs-smb-performance
47. "Can't mount NFS share on Mac OS Big Sur shared from Ubuntu 21.04 - rpc.statd not running." Ask Ubuntu. July 13, 2022. Accessed August 2, 2023. https://askubuntu.com/questions/1344687/cant-mount-nfs-share-on-mac-os-big-sur-shared-from-ubuntu-21-04-rpc-statd-not
48. "mount.nfs: rpc.statd is not running but is required for remote locking." Super User. August 14, 2020. Accessed August 2, 2023. https://superuser.com/questions/657071/mount-nfs-rpc-statd-is-not-running-but-is-required-for-remote-locking
49. "Remove ZIL/L2ARC device." Proxmox Support Forum. May 12, 2021. Accessed August 8, 2023. https://forum.proxmox.com/threads/remove-zil-l2arc-device.48181/
50. "OpenZFS 2.2-rc3 Released With Linux 6.4 Support." Phoronix Forums. July 28, 2023. Accessed August 8, 2023. https://www.phoronix.com/forums/forum/software/general-linux-open-source/1400550-openzfs-2-2-rc3-released-with-linux-6-4-support
51. "Higher l2arc_write_max is considered harmful." Days of a mirror admin. December 4, 2011. Accessed August 8, 2023. https://mirror-admin.blogspot.com/2011/12/higher-l2arcwritemax-is-considered.html
52. "ZFS tuning cheat sheet." JRS Systems: the blog. July 8, 2023. Accessed August 8, 2023. https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/
53. "zfsprops.7." OpenZFS documentation. April 18, 2023. Accessed August 8, 2023. https://openzfs.github.io/openzfs-docs/man/master/7/zfsprops.7.html
54. "Configuring ZFS Cache for High-Speed IO." Linux Hint. 2021. Accessed August 9, 2023. https://linuxhint.com/configure-zfs-cache-high-speed-io/
55. "ZFS: re-compress existing files after change in compression algorithm." Server Fault. September 4, 2019. Accessed August 8, 2023. https://serverfault.com/questions/933387/zfs-re-compress-existing-files-after-change-in-compression-algorithm
56. "OpenZFS: All about the cache vdev or L2ARC." Klara Inc Articles. Accessed August 8, 2023. https://klarasystems.com/articles/openzfs-all-about-l2arc/
57. "Workload Tuning." OpenZFS documentation. April 20, 2023. Accessed August 8, 2023. https://openzfs.github.io/openzfs-docs/Performance%20and%20Tuning/Workload%20Tuning.html
58. "A simple (real world) ZFS compression speed an compression ratio benchmark." Reddit r/zfs. March 15, 2022. Accessed August 9, 2023. https://www.reddit.com/r/zfs/comments/svnycx/a_simple_real_world_zfs_compression_speed_an/
59. "Reducing AWS Fargate Startup Times with zstd Compressed Container Images." AWS Blog. October 19, 2022. Accessed August 9, 2023. https://aws.amazon.com/blogs/containers/reducing-aws-fargate-startup-times-with-zstd-compressed-container-images/
60. "What is ZIL and how does it affect Write Coalescing performance." Reddit r/qnap. July 12, 2022. Accessed August 9, 2023. https://www.reddit.com/r/qnap/comments/vww2fc/what_is_zil_and_how_does_it_affect_write/
61. "MBR vs GPT: What's the Difference Between an MBR Partition and a GPT Partition? [Solved]." freeCodeCamp. October 12, 2020. Accessed January 11, 2024. https://www.freecodecamp.org/news/mbr-vs-gpt-whats-the-difference-between-an-mbr-partition-and-a-gpt-partition-solved/
62. "What do MBR and GPT mean, and when do I use them?" StarTech.com. Accessed January 11, 2024. https://www.startech.com/en-us/faq/mbr-vs-gpt
63. "Why does the partition start on sector 2048 instead of 63?" Super User. May 6, 2023. Accessed January 11, 2024. https://superuser.com/questions/352572/why-does-the-partition-start-on-sector-2048-instead-of-63
64. "4.4 BIOS installation." GNU GRUB Manual. Accessed January 11, 2024. https://www.gnu.org/software/grub/manual/grub/html_node/BIOS-installation.html
65. "Snapper not deleting old snapshots?" Reddit r/archlinux. November 25, 2022. Accessed September 15, 2024. https://www.reddit.com/r/archlinux/comments/z4r4u4/snapper_not_deleting_old_snapshots/
66. "Snapper." ArchWiki. September 11, 2024. Accessed September 15, 2024. https://wiki.archlinux.org/title/Snapper
67. "How to Install Fedora 36 with Snapper and Grub-Btrfs." SysGuides. October 16, 2023. Accessed September 15, 2024. https://sysguides.com/install-fedora-36-with-snapper-and-grub-btrfs
68. "Changes/SwapOnZRAM." Fedora Project Wiki. October 13, 2020. Accessed October 14, 2024. https://www.fedoraproject.org/wiki/Changes/SwapOnZRAM
69. "Disabling zswap? #156." GitHub systemd/zram-generator. Feburary 10, 2024. Accessed October 14, 2024. https://github.com/systemd/zram-generator/issues/156#issuecomment-1314177603
70. "zram: Compressed RAM based block devices." The Linux kernel user's and administartor's guide. Accessed October 14, 2024. https://docs.kernel.org/admin-guide/blockdev/zram.html
71. "zRAM size." Reddit r/linux4noobs. April 18, 2023. Accessed October 14, 2024. https://www.reddit.com/r/linux4noobs/comments/12owyt2/zram_size/
72. "New zram tuning benchmarks." Reddit r/Fedora. September 7, 2023. Accessed October 14, 2024. https://www.reddit.com/r/Fedora/comments/mzun99/new_zram_tuning_benchmarks/
73. "Zram." LinuxReviews. March 10, 2021. Accessed October 14, 2024. https://linuxreviews.org/Zram
74. "ZRam." Debian Wiki. June 28, 20223. Accessed October 14, 2024. https://wiki.debian.org/ZRam
75. "Auto-configure zram with optimal settings #163." GitHub pop-os/default-settings. September 3, 2024. Accessed October 14, 2024. https://github.com/pop-os/default-settings/pull/163
76. "[setup] Increase zram size." GitHub winesapOS/winesapOS. October 14, 2024. Accessed October 14, 2024. https://github.com/winesapOS/winesapOS/commit/27febeea36f958e3280e62540c4978a19a60ae25
77. "Swap Space in Linux: What It Is & How It Works." phoenixNAP. August 31, 2023. Accessed November 13, 2024. https://phoenixnap.com/kb/swap-space
78. "What's the right amount of swap space for a modern Linux system?" opensource.com. February 11, 2019. Accessed November 13, 2024. https://opensource.com/article/19/2/swap-space-poll
79. "swapon(8)." Linux manual page. August 25, 2023. Accessed November 13, 2024. https://www.man7.org/linux/man-pages/man8/swapon.8.html
80. "Power management/Suspend and hibernate." ArchWiki. January 15, 2025. Accessed January 20, 2025. https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate
81. "Hibernation in Fedora Workstation." Fedora Magazine. August 10, 2022. Accessed January 20, 2025. https://fedoramagazine.org/hibernation-in-fedora-36-workstation/
82. "Howto/NVIDIA." RPM Fusion. January 14, 2025. Accessed January 20, 2025. https://rpmfusion.org/Howto/NVIDIA
83. "Btrfs/Mount Options." Forza's Ramblings. June 5, 2025. Accessed June 19, 2025. https://wiki.tnonline.net/w/Btrfs/Mount_Options
84. "ext4 commit= mount option and dirty_writeback_centisecs." Stack Overflow. July 13, 2021. Accessed June 19, 2025. https://stackoverflow.com/questions/32393458/ext4-commit-mount-option-and-dirty-writeback-centisecs
85. "Module Parameters." OpenZFS documentation. September 24, 2024. Accessed June 19, 2025. https://openzfs.github.io/openzfs-docs/Performance%20and%20Tuning/Module%20Parameters.html
86. "Best way to mount /tmp in fstab?" Ask Ubuntu. February 20, 2022. Accessed June 20, 2025. https://askubuntu.com/questions/550589/best-way-to-mount-tmp-in-fstab
