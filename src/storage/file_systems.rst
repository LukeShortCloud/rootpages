File Systems
============

.. contents:: Table of Contents

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

OpenZFS
~~~~~~~

OpenZFS is a unified project aimed at providing support for the ZFS file system on FreeBSD, Linux, macOS, and Windows operating systems. [21] It is not included in most Linux distributions due to licensing issues with the kernel. Debian and Ubuntu are the only Linux distribution that provide the Linux kernel module for ZFS in their official repositories. [22][23]

Installation (Source)
^^^^^^^^^^^^^^^^^^^^^

Debian:

-  Install the build dependencies:

   .. code-block:: sh

      $ sudo apt install alien autoconf automake build-essential dkms fakeroot gawk libaio-dev libattr1-dev libblkid-dev libelf-dev libffi-dev libssl-dev libtool libudev-dev libzstd-dev linux-headers-$(uname -r) python3 python3-dev python3-cffi python3-setuptools uuid-dev zlib1g-dev

-  View and download an OpenZFS release from `here <https://github.com/openzfs/zfs/releases>`__.

   .. code-block:: sh

      $ export OPENZFS_VER="2.0.0"
      $ wget https://github.com/openzfs/zfs/releases/download/zfs-${OPENZFS_VER}/zfs-${OPENZFS_VER}.tar.gz

-  Build the DKMS packages so that the kernel module will be automatically rebuilt upon kernel updates.

   .. code-block:: sh

      $ tar -z -x -v -f zfs-${OPENZFS_VER}.tar.gz
      $ cd ./zfs-${OPENZFS_VER}
      $ ./configure --enable-systemd
      $ make -j $(nproc) deb-utils deb-dkms

-  Install the Debian package files. [24]

   .. code-block:: sh

      $ sudo dpkg -i ./.*deb

-  Load the ZFS kernel module and verify it works.

   .. code-block:: sh

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

   $ sudo zpool create <POOL_NAME> <DEVICE_NAME>
   $ sudo zfs create <POOL_NAME>/<DATASET_NAME>
   $ sudo zfs list

Mount points:

-  Pool = /<POOL_NAME>
-  Dataset = /<POOL_NAME>/<DATASET_NAME>

Change the mountpoint.

.. code-block:: sh

   $ sudo zfs set mountpoint=/mnt <POOL_NAME>/<DATASET_NAME>

View all of the available properties that can be set for the pool and/or datasets.

.. code-block:: sh

   $ man zfsprops

View the current value of a property and set a new one.

.. code-block:: sh

   $ sudo zfs get <PROPERTY> <POOL_NAME>/<DATASET_NAME>
   $ sudo zfs set <PROPERTY>=<VALUE> <POOL_NAME>/<DATASET_NAME>

Adaptive Replacement Cache (ARC)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ARC is the name for the automatic file caching of frequently accessed files by ZFS. Level 1 ARC (L1ARC) stores the cache in RAM. Level 2 ARC (L2ARC) can be configured to use a faster storage device (such as a SSD) as an extra layer of cache for slower devices (such as a HDD). Files stored in L1ARC will be downgraded to L2ARC if they are not used. If L2ARC cache becomes unavailable when the same file is accessed again, it will be accessed directly from the storage device again and placed back into L1ARC.

Life cycle of a file in relation to ARC:

::

   File is accessed from the disk --> Stored in L1ARC (RAM) --> Stored in L2ARC (SSD) --> Uncached

ARC usage:

-  Add a L2ARC device to an existing ZFS pool. [25]

   .. code-block:: sh

      $ sudo zpool add <POOL> cache <STORAGE_DEVICE>

-  View a summary of the ARC cache statistics.

   .. code-block:: sh

      $ sudo arc_summary

-  View real-time statistics for ARC cache. [29]

   .. code-block:: sh

      $ sudo arcstat

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

Swap
~~~~

Swap is a special file system that cannot be mounted. It is used by the operating system to temporarily read and write files to when the RAM is full. It prevents out-of-memory (oom) errors but it leads to a huge performance penalty because device storage is typically a lot slower than RAM. It is recommended to allocate more RAM instead of relying on swap wherever possible. According to `this poll <https://opensource.com/article/19/2/swap-space-poll>`__, most users prefer to allocate this amount of swap based on the available system RAM:

-  ``<RAM>`` = ``<SWAP>``
-  <= 2GB = x2 RAM
-  2-8GB = RAM
-  > 8GB = 8GB

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

The Network File System (NFS) aims to universally provide a way to
remotely mount directories between servers. All subdirectories from a
shared directory will also be available.

NFSv4 port:

-  2049 TCP

NFSv3 ports:

-  111 TCP/UDP
-  2049 TCP/UDP
-  4045 TCP/UDP

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
-  sec = Specify a type of Kerberos authentication to use.

   -  krb5 = Use Kerberos for authentication only.

[12]

On Red Hat Enterprise Linux systems, the exported directory will need to
have the "nfs\_t" file context for SELinux to work properly.

.. code-block:: sh

    $ sudo semanage fcontext -a -t nfs_t "/path/to/dir{/.*)?"
    $ sudo restorecon -R "/path/to/dir"

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

Configuration - Global:

-  [global]

   -  workgroup = Define a WORKGROUP name.
   -  interfaces = Specify the interfaces to listen on.
   -  hosts allow = Specify hosts allowed to access any of the shares.
      Wildcard IP addresses can be used by omitting different octets.
      For example, "127." would be a wildcard for anything in the
      127.0.0.0/8 range.

Configuration - Share:

-  [smb] = The share can be named anything.

   -  path = The path to the directory to share (required).
   -  writable = Use "yes" or "no." This specifies if the folder share
      is writable.
   -  read only = Use "yes" or "no." This is the opposite of the
      writable option. Only one or the other option should be used. If
      set to no, the share will have write permissions.
   -  write list = Specify users that can write to the share, separated
      by spaces. Groups can also be specified using by appending a "+"
      to the front of the name.
   -  comment = Place a comment about the share. [14]

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

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/storage/file_systems.rst>`__
-  `< 2020.07.01 <https://github.com/ekultails/rootpages/commits/master/src/administration/file_systems.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/file_systems.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/file_systems.md>`__

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
14. "The Samba Configuration File." SAMBA. September 26th, 2003. Accessed September 18th, 2016. https://www.samba.org/samba/docs/using\_samba/ch06.html
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
