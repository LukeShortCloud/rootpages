File Systems
============

-  `Types <#types>`__

   -  `Btrfs <#types---btrfs>`__

      -  `Btrfs RAIDs <#types---btrfs---btrfs-raids>`__
      -  `Btrfs Limitations <#types---btrfs---btrfs-limitations>`__

   -  `ext4 <#types---ext4>`__
   -  XFS
   -  ZFS

-  LVM
-  `RAIDs <#raids>`__

   -  `mdadm <#raids---mdadm>`__

-  `Network <#network>`__

   -  `NFS <#network---nfs>`__
   -  `SMB <#network---smb>`__
   -  `iSCSI <#network---iscsi>`__

      -  `Target <#network---iscsi---target>`__
      -  `Initiator <#network---iscsi---initiator>`__

   -  `Ceph <#network---ceph>`__

      -  `Installation <#network---ceph---installation>`__

         -  `Quick <#network---ceph---installation---quick>`__
         -  Full
         -  `Ceph-Ansible <#ceph---installation---ceph-ansible>`__

      -  `CRUSH Map <#network---ceph---crush-map>`__
      -  `Repair <#network---ceph---repair>`__
      -  `libvirt <#network---ceph---libvirt>`__
      -  `CephFS <#network---ceph---cephfs>`__

Types
-----

Many types of file systems exist for various operating systems. These
are used to handle the underlying file and data structure when it is
being read and written to. Every file system has a limit to the number
of inodes (files and directories) it can handle. The inode limit can be
calculated by using the equation: ``2^<BIT_SIZE> - 1``.

+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| Name (mount type) | OS      | Notes                                                                        | File Size Limit                  | Partition Size Limit             | Bits |
+===================+=========+==============================================================================+==================================+==================================+======+
| Fat16 (vfat)      | DOS     | No journaling.                                                               | 2GiB                             | 2GiB                             | 16   |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| Fat32 (vfat)      | DOS     | No journaling.                                                               | 4GiB                             | 8TiB                             | 32   |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| NTFS (ntfs-3g)    | Windows | Journaling, encyption, compression.                                          | 2TiB                             | 256TiB                           | 32   |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| ext4 [2]          | Linux   | Journaling, less fragmentation, better performance.                          | 16TiB                            | 1EiB                             | 32   |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| XFS               | Linux   | Journaling, online resizing (but cannot shrink), and online defragmentation. | 8EiB (theoretically up to 16EiB) | 8EiB (theoretically up to 16EiB) | 64   |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| Btrfs [3]         | Linux   | Journaling, copy-on-write (CoW), compression, snapshots, and RAID.           | 8EiB (theoretically up to 16EiB) | 8EiB (theoretically up to 16EiB) | 64   |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| tmpfs             | Linux   | RAM and swap.                                                                |                                  |                                  |      |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| ramfs             | Linux   | RAM (no swap).                                                               |                                  |                                  |      |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+
| swap              | Linux   | A temporary storage file system to use when RAM is unavailable.              |                                  |                                  |      |
+-------------------+---------+------------------------------------------------------------------------------+----------------------------------+----------------------------------+------+

[1]

Sources:

1. "Linux File systems Explained." Ubuntu Documentation. November 8,
   2015. https://help.ubuntu.com/community/LinuxFilesystemsExplained
2. "How many files can I put in a directory?" Stack Overflow. July 14,
   2015.
   http://stackoverflow.com/questions/466521/how-many-files-can-i-put-in-a-directory
3. "Btrfs Main Page." Btrfs Kernel Wiki. June 24, 2016.
   https://btrfs.wiki.kernel.org/index.php/Main\_Page

Types - Btrfs
~~~~~~~~~~~~~

Btrfs stands for the "B-tree file system." The file system is commonly
referred to as "BtreeFS", "ButterFS", and "BetterFS". In this model,
data is organized efficiently for fast I/O operations. This helps to
provide copy-on-write (CoW) for efficient file copies as well as other
useful features. Btrfs supports subvolumes, CoW snapshots, online
defragmentation, built-in RAID, compression, and the ability to upgrade
an existing ext file systems to Btrfs. [1]

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
-  discard = Enables TRIM support. [2]

Sources:

1. "What’s All This I Hear About Btrfs For Linux." The Personal Blog of
   Dan Calloway. December 16, 2012.
   https://danielcalloway.wordpress.com/2012/12/16/whats-all-this-i-hear-about-btrfs-for-linux/
2. "Mount Options" Btrfs Kernel Wiki. May 5, 2016.
   https://btrfs.wiki.kernel.org/index.php/Mount\_options

Types - Btrfs - Btrfs RAIDs
^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the latest Linux kernels, all RAID types (0, 1, 5, 6, and 10) are
supported. [1]

Source:

1. "Using Btrfs with Multiple Devices" Btrfs Kernel Wiki. May 14, 2016.
   https://btrfs.wiki.kernel.org/index.php/Using\_Btrfs\_with\_Multiple\_Devices

Types - Btrfs - Btrfs Limitations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Known limitations:

-  The "df" (disk free) command does not report an accurate disk usage
   due to Btrfs's fragmentation. Instead, ``btrfs filesystem df`` should
   be used to view disk space usage on mount points and "btrfs
   filesystem show" for partitions.

   -  For freeing up space, run a block-level and then a file-level
      defragmentation. Then the disk space usage should be accurate to
      df's output.

      -  ``# btrfs balance start /``
      -  ``# btrfs defragment -r /``

[1]

Source:

1. "Preventing a btrfs Nightmare." Jupiter Broadcasting. July 6, 2014.
   http://www.jupiterbroadcasting.com/61572/preventing-a-btrfs-nightmare-las-320/

Types - ext4
~~~~~~~~~~~~

The Extended File System 4 (ext4) is the default file system for most
Linux operating systems. It's focus is on performance and reliability.
It is also backwards compatible with the ext3 file system. [1]

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
-  nodiscard = Disables TRIM. [2]

Sources:

1. "Linux File Systems: Ext2 vs Ext3 vs Ext4." The Geek Stuff. May 16,
   2011. Accessed October 1, 2016.
   http://www.thegeekstuff.com/2011/05/ext2-ext3-ext4
2. "Ext4 Filesystem." Kernel Documentation. May 29, 2015. Accessed
   October 1, 2016.
   https://kernel.org/doc/Documentation/filesystems/ext4.txt

RAIDs
-----

RAID officially stands for "Redundant Array of Independent Disks." The
idea of a RAID is to get either increased performance and/or an
automatic backup from using multiple disks together. It utilizes these
drives to create 1 logical drive.

+-------+----------------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+-------+-------------------+------------+
| Level | Minimum Drives | Benefits                                                                       | Drawbacks                                                                                                                  | Speed | Increased Storage | Redundancy |
+=======+================+================================================================================+============================================================================================================================+=======+===================+============+
| 0     | 2              | I/O operations are equally spread to each disk.                                | No redundancy.                                                                                                             | X     | X                 |            |
+-------+----------------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+-------+-------------------+------------+
| 1     | 2              | If one drive fails, a second drive will have an exact copy of all of the data. | Slower write speeds.                                                                                                       |       |                   | X          |
+-------+----------------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+-------+-------------------+------------+
| 5     | 3              | This can recover from a failed drive without any affect on performance.        | Drive recovery takes a long time and will not work if more than on drive fails. Rebuilding or restoring takes a long time. | X     | X                 | X          |
+-------+----------------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+-------+-------------------+------------+
| 6     | 4              | This is an enhanced RAID 5 that can survive up to 2 drive failures.            | Refer to RAID 5 drawbacks.                                                                                                 | X     | X                 | X          |
+-------+----------------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+-------+-------------------+------------+
| 10    | 4              | This uses both RAID 1 and 0 together.                                          | Requires more physical drives. Rebuilding or restoring a RAID 10 will require downtime.                                    | X     | X                 | X          |
+-------+----------------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+-------+-------------------+------------+

[1]

Source:

1. "RAID levels 0, 1, 2, 3, 4, 5, 6, 0+1, 1+0 features explained in
   detail." GOLINUXHUB. April 09, 2016. Accessed August 13th, 2016.
   http://www.golinuxhub.com/2014/04/raid-levels-0-1-2-3-4-5-6-01-10.html

RAIDs - mdadm
~~~~~~~~~~~~~

Most software RAIDs in Linux are handled by the "mdadm" utility and the
"md\_mod" kernel module. Creating a new RAID requires specifying the
RAID level and the partitions you will use to create it.

Syntax:

::

    # mdadm --create --level=<LEVEL> --raid-devices=<NUMBER_OF_DISKS> /dev/md<DEVICE_NUMBER_TO_CREATE> /dev/sd<PARTITION1> /dev/sd<PARTITION2>

Example:

::

    # mdadm --create --level=10 --raid-devices=4 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1

Then to automatically create the partition layout file run this:

::

    # echo 'DEVICE partitions' > /etc/mdadm.conf
    # mdadm --detail --scan >> /etc/mdadm.conf

Finally, you can initialize the RAID.

::

    # mdadm --assemble --scan

[1]

Source:

1. "RAID." Arch Linux Wiki. August 7, 2016. Accessed August 13, 2016.
   https://wiki.archlinux.org/index.php/RAID

Network
-------

Network - NFS
~~~~~~~~~~~~~

The Network File System (NFS) aims to universally provide a way to
remotely mount directories between servers. All subdirectories from a
shared directory will also be available.

NFS Ports: \* 111 TCP/UDP \* 2049 TCP/UDP \* 4045 TCP/UDP

On the server, the /etc/exports file is used to manage NFS exports. Here
a directory can be specified to be shared via NFS to a specific IP
address or CIDR range. After adjusting the exports, the NFS daemon will
need to be restarted.

-  Syntax:

   ::

       <DIRECTORY> <ALLOWED_HOST>(<OPTIONS>)

-  Example:

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

[1]

On Red Hat Enterprise Linux systems, the exported directory will need to
have the "nfs\_t" file context for SELinux to work properly.

::

    # semanage fcontext -a -t nfs_t "/path/to/dir{/.*)?"
    # restorecon -R "/path/to/dir"

Source:

1. "NFS SERVER CONFIGURATION." Red Hat Documentation. Accessed September
   19, 2016.
   https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux/7/html/Storage\_Administration\_Guide/nfs-serverconfig.html

Network - SMB
~~~~~~~~~~~~~

The Server Message Block (SMB) protocol was created to view and edit
files remotely over a network. The Common Internet File System (CIFS)
was created by Microsoft as an enhanced fork of SMB but was eventually
replaced with newer versions of SMB. On Linux, the "Samba" service is
typically used for setting up SMB share. [1]

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
   -  comment = Place a comment about the share. [2]

Verify the Samba configuration.

::

    # testparm
    # smbclient //localhost/<SHARE_NAME> -U <SMB_USER1>%<SMB_USER1_PASS>

The Linux user for accessing the SMB share will need to be created and
have their password added to the Samba configuration. These are stored
in a binary file at "/var/lib/samba/passdb.tdb." This can be updated by
running:

::

    # useradd <SMB_USER1>
    # smbpasswd -a <SMB_USER1>

On Red Hat Enterprise Linux systems, the exported directory will need to
have the "samba\_share\_t" file context for SELinux to work properly.
[3]

::

    # semanage fcontext -a -t samba_share_t "/path/to/dir{/.*)?"
    # restorecon -R "/path/to/dir"

Sources:

1. "The Difference between CIFS and SMB." VARONIS. February 14, 1024.
   Accessed September 18th, 2016.
   https://blog.varonis.com/the-difference-between-cifs-and-smb/
2. "The Samba Configuration File." SAMBA. September 26th, 2003. Accessed
   September 18th, 2016.
   https://www.samba.org/samba/docs/using\_samba/ch06.html
3. "RHEL7: Provide SMB network shares to specific clients." CertDepot.
   August 25, 2016. Accessed September 18th, 2016.
   https://www.certdepot.net/rhel7-provide-smb-network-shares/

Network - iSCSI
~~~~~~~~~~~~~~~

The "Internet Small Computer Systems Interface" (also known as "Internet
SCSI" or simply "iSCSI") is used to allocate block storage to servers
over a network. It relies on two components: the target (server) and the
initiator (client). The target must first be configured to allow the
client to attach the storage device.

Network - iSCSI - Target
^^^^^^^^^^^^^^^^^^^^^^^^

For setting up a target storage, these are the general steps to follow
in order:

-  Create a backstores device.
-  Create an iSCSI target.
-  Create a network portal to listen on.
-  Create a LUN associated with the backstores.
-  Create an ACL.
-  Optionally configure ACL rules.

-  First, start and enable the iSCSI service to start on bootup.

   -  Syntax:

      ::

          # systemctl enable target && systemctl start target

-  Create a storage device. This is typically either a block device or a
   file.
-  Block syntax:

   ::

       # targetcli
       > cd /backstores/block/
       > create iscsidisk1 dev=/dev/sd<DISK>

-  File syntax:

   ::

       # targetcli
       > cd /backstore/fileio/
       > create iscsidisk1 /<PATH_TO_DISK>.img <SIZE_IN_MB>M

-  A special iSCSI Qualified Name (IQN) is required to create a Target
   Portal Group (TPG). The syntax is
   "iqn.YYYY-MM.tld.domain.subdomain:exportname."
-  Syntax:

   ::

       > cd /iscsi
       > create iqn.YYYY-MM.<TLD.DOMAIN>:<ISCSINAME>

-  Example:

   ::

       > cd /iscsi
       > create iqn.2016-01.com.example.server:iscsidisk
       > ls

-  Create a portal for the iSCSI device to be accessible on.
-  Syntax:

   ::

       > cd /iscsi/iqn.YYYY-MM.<TLD.DOMAIN>:<ISCSINAME>/tpg1
       > portals/ create

-  Example:

   ::

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
-  Syntax:

   ::

       > luns/ create /backstores/block/<DEVICE>

-  Example:

   ::

       > luns/ create /backstores/block/iscsidisk

-  Create a blank ACL. By default, this will allow any user to access
   this iSCSI target.

-  Syntax:

   ::

       > acls/ create iqn.YYYY-MM.<TLD.DOMAIN>:<ACL_NAME>

-  Example:

   ::

       > acls/ create iqn.2016-01.com.example.server:client

-  Optionally, add a username and password.
-  Syntax:

   ::

       > cd acls/iqn.YYYY-MM.<TLD.DOMAIN>:<ACL_NAME>
       > set auth userid=<USER>
       > set auth password=<PASSWORD>

-  Example:

   ::

       > cd acls/iqn.2016-01.com.example.server:client
       > set auth userid=toor
       > set auth password=pass

-  Any ACL rules that were created can be overridden by turning off
   authentication entirely.

   -  Syntax:

      ::

          > set attribute authentication=0
          > set attribute generate_node_acls=1
          > set attribute demo_mode_write_protect=0

-  Finally, make sure that both the TCP and UDP port 3260 are open in
   the firewall. [1]

Network - iSCSI - Initiator
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This should be configured on the client server.

-  In the initiator configuration file, specify the IQN along with the
   ACL used to access it.
-  Syntax:

   ::

       # vim /etc/iscsi/initiatorname.iscsi
       InitiatorName=<IQN>:<ACL>

-  Example:

   ::

       # vim /etc/iscsi/initiatorname.iscsi
       InitiatorName=iqn.2016-01.com.example.server:client

-  Start and enable the iSCSI initiator to load on bootup.

   -  Syntax:

      ::

          # systemctl start iscsi && systemctl enable iscsi

-  Once started, the iSCSI device should be able to be attached.
-  Syntax:

   ::

       # iscsiadm --mode node --targetname <IQN>:<TARGET> --portal <iSCSI_SERVER_IP> --login

-  Example:

   ::

       # iscsiadm --mode node --targetname iqn.2016-01.com.example.server:iscsidisk --portal 10.0.0.1 --login

-  Verify that a new "iscsi" device exists.

   -  Syntax:

      ::

          # lsblk --scsi

[1]

Source:

1. "RHEL7: Configure a system as either an iSCSI target or initiator
   that persistently mounts an iSCSI target." CertDepot. July 30, 2016.
   Accessed August 13, 2016.
   https://www.certdepot.net/rhel7-configure-iscsi-target-initiator-persistently/

Network - Ceph
~~~~~~~~~~~~~~

Ceph has developed a concept called Reliable Autonomic Distributed
Object Store (RADOS). It provides scalable, fast, and reliable
software-defined storage by storing files as objects and calculating
their location on the fly. Failovers will even happen automatically so
no data is lost.

Vocabulary:

-  Object Storage Device (OSD) = The device that stores data.
-  OSD Daemon = Handles storing all user data as objects.
-  Ceph Block Device (RBD) = Provides a block device over the network,
   similar in concept to iSCSI.
-  Ceph Object Gateway = A RESTful API which works with Amazon S3 and
   OpenStack Swift.
-  Ceph Monitors (MONs) = Store and provide a map of data locations.
-  Ceph Metadata Server (MDS) = Provides metadata about file system
   hierarchy for CephFS. This is not required for RBD or RGW.
-  Ceph File System (CephFS) = A POSIX-compliant distributed file system
   with unlimited size.
-  Controlled Replication Under Scalable Hash (CRUSH) = Uses an
   algorithm to provide metadata about an object's location.
-  Placement Groups (PGs) = Object storage data.

Ceph monitor nodes have a master copy of a cluster map. This contains 5
separate maps that have information about data location and the
cluster's status. If an OSD fails, the monitor daemon will automatically
reorganize everything and provided end-user's with an updated cluster
map.

Cluster map:

-  Monitor map = The cluster fsid (uuid), position, name, address and
   port of each monitor server.

   -  ``# ceph mon dump``

-  OSD map = The cluster fsid, available pools, PG numbers, and OSDs
   current status.

   -  ``# ceph osd dump``

-  PG map = PG version, PG ID, ratios, and data usage statistics.

   -  ``# ceph pg dump``

-  `CRUSH map <#network---ceph---crush-map>`__ = Storage devices,
   physical locations, and rules for storing objects. It is recommended
   to tweak this for production clusters.
-  MDS map

   -  ``# ceph fs dump``

When the end-user asks for a file, that name is combined with it's PG ID
and then CRUSH hashes it to find the exact location of it on all of the
OSDs. The master OSD for that file serves the content. [1]

The current back-end for handling data storage is FileStore. When data
is written to a Ceph OSD, it is first fully written to the OSD journal.
This is a separate partition that can be on the same drive or a
different drive. It is faster to have the journal on an SSD if the OSD
drive is a regular spinning-disk drive.

The new BlueStore was released as a technology preview in the Ceph Jewel
release. In the next LTS release this will become the default data
storage handler. This helps to overcome the double write penalty of
FileStore by writing the the data to the block device first and then
updating the metadata of the data's location. All of the metadata is
also stored in the fast RocksDB key-value store. File systems are no
longer required for OSDs because BlueStore can write data directly to
the block device of the hard drive. [2]

The optimal number of PGs is found be using this equation (replacing the
number of OSD daemons and how many replicas are set). This number should
be rounded up to the next power of 2.

Syntax:

::

    Total PGs = (<NUMBER_OF_OSDS> * 100) / <REPLICA_COUNT> / <NUMBER_OF_POOLS>

Example:

::

    OSD count = 30, replica count = 3, pool count = 1
    Run the calculations: 1000 = (30 * 100) / 3 / 1
    Find the next highest power of 2: 2^10 = 1024
    1000 =< 1024
    Total PGs = 1024

With Ceph's configuration, the Placement Group for Placement purpose
(PGP) should be set to the same PG number. PGs are the number of number
of times a file should be split. This change only makes the Ceph cluster
rebalance when the PGP count is increased.

-  New pools:

   ::

       # vim /etc/ceph/ceph.conf
       ...
       [global]
       osd pool default pg num = <OPTIMAL_PG_NUMBER>
       osd pool default pgp num = <OPTIMAL_PG_NUMBER>

-  Existing pools:

   ::

       # ceph osd pool set <POOL> pg_num <OPTIMAL_PG_NUMBER>
       # ceph osd pool set <POOL> pgp_num <OPTIMAL_PG_NUMBER>

Cache pools can be configured used to cache files onto faster drives.
When a file is continually being read, it will be copied to the faster
drive. When a file is first written, it will go to the faster drives.
After a period of time of lesser use, those files will be moved to the
slow drives. [3]

For testing, the "cephx" authentication protocols can temporarily be
disabled. This will require a restart of all of the Ceph services.
Re-enable ``cephx`` by setting these values from "none" to "cephx." [4]

::

    # vim /etc/ceph/ceph.conf
    [global]
    auth cluster required = none
    auth service required = none
    auth client required = none

Sources:

1. Karan Singh *Learning Ceph* (Birmingham, UK: Packet Publishing, 2015)
2. https://www.sebastien-han.fr/blog/2016/03/21/ceph-a-new-store-is-coming/
3. "CACHE POOL." Ceph Documentation. Accessed January 19, 2017.
   http://docs.ceph.com/docs/jewel/dev/cache-pool/
4. "CEPHX CONFIG REFERENCE." Ceph Docmentation. Accessed January 28,
   2017.
   http://docs.ceph.com/docs/master/rados/configuration/auth-config-ref/

Network - Ceph - Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ceph Requirements:

-  Fast CPU for OSD and metadata nodes.
-  1GB RAM per 1TB of Ceph OSD storage, per OSD daemon.
-  1GB RAM per monitor daemon.
-  1GB RAM per metadata daemon.
-  An odd number of montior nodes (starting at least 3 for high
   availability and quorum). [1]

Source:

1. "INTRO TO CEPH." Ceph Documentation. Accessed January 15, 2017.
   http://docs.ceph.com/docs/jewel/start/intro/

Network - Ceph - Installation - Quick
'''''''''''''''''''''''''''''''''''''

This example demonstrates how to deploy a 3 node Ceph cluster with both
the monitor and OSD services. In production, monitor servers should be
separated from the OSD storage nodes.

-  Create a new Ceph cluster group, by default called "ceph."

   ::

       # ceph-deploy new <SERVER1>

-  Install the latest LTS release for production environments on the
   specified servers. SSH access is required.

   ::

       # ceph-deploy install --release jewel <SERVER1> <SERVER2> <SERVER3>

-  Initialize the first monitor.

   ::

       # ceph-deploy mon create-inital <SERVER1>

-  Install the monitor service on the other nodes.

   ::

       # ceph-deploy mon create <SERVER2> <SERVER3>

-  List the available hard drives from all of the servers. It is
   recommended to have a fully dedicated drive, not a partition, for
   each Ceph OSD.

   ::

       # ceph-deploy disk list <SERVER1> <SERVER2> <SERVER3>

-  Carefully select the drives to use. Then use the "disk zap" arguments
   to zero out the drive before use.

   ::

       # ceph-deploy disk zap <SERVER1>:<DRIVE> <SERVER2>:<DRIVE> <SERVER3>:<DRIVE>

-  Prepare and deploy the OSD service for the specified drives. The
   default file system is XFS, but Btrfs is much feature-rich with
   technologies such as copy-on-write (CoW) support.

   ::

       # ceph-deploy osd create --fs-type btrfs <SERVER1>:<DRIVE> <SERVER2>:<DRIVE> <SERVER3>:<DRIVE>

-  Verify it's working.

   ::

       # ceph status

[1]

Source:

1. "Ceph Deployment." Ceph Jewel Documentation. Accessed January 14,
   2017. http://docs.ceph.com/docs/jewel/rados/deployment/

Network - Ceph - Installation - ceph-ansible
''''''''''''''''''''''''''''''''''''''''''''

The ceph-ansible project is used to help deploy and automate updates.

::

    # git clone https://github.com/ceph/ceph-ansible/
    # cd ceph-ansible/

Configure the Ansible inventory hosts file. This should contain the SSH
connection details to access the relevant servers.

Inventory hosts:

-  [mons] = Monitors for tracking and locating object storage data.
-  [osds] = Object storage device nodes for storing the user data.
-  [mdss] = Metadata servers for CephFS. (Optional)
-  [rwgs] = RADOS Gateways for Amazon S3 or OpenStack Swift object
   storage API support. (Optional)

Example inventory:

::

    ceph_monitor_01 ansible_host=192.168.20.11
    ceph_monitor_02 ansible_host=192.168.20.12
    ceph_monitor_03 ansible_host=192.168.20.13
    ceph_osd_01 ansible_host=192.168.20.101 ansible_port=2222
    ceph_osd_02 ansible_host=192.168.20.102 ansible_port=2222
    ceph_osd_03 ansible_host=192.168.20.103 ansible_port=2222

    [mons]
    ceph_monitor_01
    ceph_monitor_02
    ceph_monitor_03

    [osds]
    ceph_osd_01
    ceph_osd_02
    ceph_osd_03

Copy the sample configurations and modify the variables.

::

    # cp site.yml.sample site.yml
    # cd group_vars/
    # cp all.yml.sample all.yml
    # cp mons.yml.sample mons.yml
    # cp osds.yml.sample osds.yml

Common variables:

-  group\_vars/all.yml = Global variables.

   -  ceph\_origin = Specify how to install the Ceph software.

      -  upstream = Use the official repositories.
      -  Upstream related variables:

         -  ceph\_dev: Boolean value. Use a development branch of Ceph
            from GitHub.
         -  ceph\_dev\_branch = The exact branch or commit of Ceph from
            GitHub to use.
         -  ceph\_stable = Boolean value. Use a stable release of Ceph.
         -  ceph\_stable\_release = The release name to use. The LTS
            "jewel" release is recommended.

      -  distro = Use repositories already present on the system.
         ceph-ansible will not install Ceph repositories with this
         method, they must already be installed.

   -  ceph\_release\_num = If "ceph\_stable" is not defined, use any
      specific major release number.

      -  9 = infernalis
      -  10 = jewel
      -  11 = kraken

-  group\_vars/osds.yml = Object storage daemon variables.

   -  devices = A list of drives to use for each OSD daemon.
   -  osd\_auto\_discovery = Boolean value. Default: false. Instead of
      manually specifying devices to use, automatically use any drive
      that does not have a partition table.
   -  OSD option #1:

      -  journal\_collocation = Boolean value. Default: false. Use the
         same drive for journal and data storage.

   -  OSD option #2:

      -  raw\_multi\_journal = Boolean value. Default: false. Store
         journals on different hard drives.
      -  raw\_journal\_devices = A list of devices to use for
         journaling.

   -  OSD option #3:

      -  osd\_directory = Boolean value. Default: false. Use a specified
         directory for OSDs. This assumes that the end-user has already
         partitioned the drive and mounted it to
         ``/var/lib/ceph/osd/<OSD_NAME>`` or a custom directory.
      -  osd\_directories = The directories to use for OSD storage.

   -  OSD option #4:

      -  bluestore: Boolean value. Default: false. Use the new and
         experimental BlueStore file store that can provide twice the
         performance for drives that have both a journal and OSD for
         Ceph.

   -  OSD option #5:

      -  dmcrypt\_journal\_collocation = Use Linux's "dm-crypt" to
         encrypt objects when both the journal and data are stored on
         the same drive.

   -  OSD option #6:

      -  dmcrypt\_dedicated\_journal = Use Linux's "dm-crypt" to encrypt
         objects when both the journal and data are stored on the
         different drives.

Finally, run the Playbook to deploy the Ceph cluster.

::

    # ansible-playbook -i production site.yml

[1]

Source:

1. "ceph-ansible Wiki." ceph-ansible GitHub. February 29, 2016. Accessed
   January 15, 2017. https://github.com/ceph/ceph-ansible/wiki

Network - Ceph - CRUSH Map
^^^^^^^^^^^^^^^^^^^^^^^^^^

CRUSH maps are used to keep track of OSDs, physical locations of
servers, and it defines how to replicate objects.

These maps are divided into four main parts:

-  Devices = The list of each OSD daemon in the cluster.
-  Bucket Types = Definitions that can group OSDs into groups with their
   own location and weights based on servers, rows, racks, datacenters,
   etc.
-  Bucket Instances = A bucket instance is created by specifying a
   bucket type and one or more OSDs.
-  Rules = Rules can be defined to configure which bucket instances will
   be used for reading, writing, and/or replicating data.

A binary of the configuration must be saved and then decompiled before
changes can be made. Then the file must be recompiled for the updates to
be loaded.

::

    # ceph osd getcrushmap -o <NEW_COMPILED_FILE>
    # crushtool -d <NEW_COMPILED_FILE> -o <NEW_DECOMPILED_FILE>
    # vim <NEW_DECOMPILED_FILE>`
    # crushtool -c <NEW_DECOMPILED_FILE> -o <UPDATED_COMPILED_FILE>
    # ceph osd setcrushmap -i <UPDATED_COMPILED_FILE>

Network - Ceph - CRUSH Map - Devices
''''''''''''''''''''''''''''''''''''

Devices must follow the format of ``device <COUNT> <OSD_NAME>``. These
are automatically generated but can be adjusted and new nodes can be
manually added here.

::

    # devices
    device 0 osd.0
    device 1 osd.1
    device 2 osd.2

Network - Ceph - CRUSH Map - Bucket Types
'''''''''''''''''''''''''''''''''''''''''

Bucket types follow a similar format of ``type <COUNT> <TYPE_NAME>``.
The name of the type can be anything. The higher numbered type always
inherits the lower numbers. The default types include:

::

    # types
    type 0 osd
    type 1 host
    type 2 chassis
    type 3 rack
    type 4 row
    type 5 pdu
    type 6 pod
    type 7 room
    type 8 datacenter
    type 9 region
    type 10 root

Network - Ceph - CRUSH Map - Bucket Instances
'''''''''''''''''''''''''''''''''''''''''''''

Bucket instances are used to group OSD configurations together.
Typically these should define physical locations of the OSDs.

::

    <CUSTOM_BUCKET_TYPE> <UNIQUE_BUCKET_NAME> {
        id <UNIQUE_NEGATIVE_NUMBER>
        weight <FLOATING_NUMBER>
        alg <BUCKET_TYPE>
        hash 0
        item <OSD_NAME> weight <FLOATING_NUMBER>
    }

-  ``<CUSTOM_BUCKET_TYPE>`` = Required. This should be one of the
   user-defined bucket types.
-  ``<UNIQUE_BUCKET_NAME>`` = Required. A unique name that describes the
   bucket.
-  id = Required. A unique negative number to identify the bucket.
-  weight = Optional. A floating/decimal number for all of the weight of
   all of the OSDs in this bucket.
-  alg = Required. Choose which Ceph bucket type/method that is used to
   read and write objects. This should not be confused with the
   user-defined bucket types.

   -  Uniform = Assumes that all hardware in the bucket instance is
      exactly the same so all OSDs receive the same weight.
   -  List = Lists use the RUSH algorithim to read and write objects in
      sequential order from the first OSD to the last. This is best
      suited for data that does not need to be deleted (to avoid
      rebalancing).
   -  Tree = The binary search tree uses the RUSH algorithim to
      efficiently handle larger amounts of data.
   -  Straw = A combination of both "list" and "tree." One of the two
      bucket types will randomly be selected for operations. Replication
      is fast but rebalancing will be slow.

-  hash = Required. The hashing algorithim used by CRUSH to lookup and
   store files. As of the Jewel release, only option "0" for "rjenkins1"
   is supported.
-  item = Optional. The OSD name and weight for individual OSDs. This is
   useful if a bucket instance has hard drives of different speeds.

Network - Ceph - CRUSH Map - Rules
''''''''''''''''''''''''''''''''''

By modifying the CRUSH map, replication can be configured to go to a
different drive, server, chassis, row, rack, datacenter, etc.

::

    rule <RULE_NAME> {
        ruleset <RULESET>
        type <RULE_TYPE>
        min_size <MINIMUM_SIZE>
        max_size <MAXIMUM_SIZE>
        step take <BUCKET_INSTANCE_NAME>
        step <CHOOSE_OPTION>
        step emit
    }

-  ``<RULE_NAME>``
-  ruleset = Required. An integer that can be used to reference this
   ruleset by a pool.
-  type = Required. Default is "replicated." How to handle data
   replication.

   -  replicated = Data is replicated to different hard drives.
   -  erasure = This a similar concept to RAID 5. Data is only
      replicated to one drive. This option helps to save space.

-  min\_size
-  max\_size
-  step take
-  step emit = Required. This signifies the end of the rule block.

[1]

Source:

1. "CRUSH MAPS." Ceph Documentation. Accessed January 29, 2017.
   http://docs.ceph.com/docs/master/rados/operations/crush-map/

Network - Ceph - Repair
^^^^^^^^^^^^^^^^^^^^^^^

Ceph automatically runs through a data integrity check called
"scrubbing." This checks the health of each placement group (object).
Sometimes these can fail due to inconsistencies, commonly a mismatch in
time on the OSD servers.

In this example, the placement group "1.28" failed to be scrubbed. This
object exists on the 8, 11, and 20 OSD drives.

-  Check the health information.

   -  Example:

      ::

          # ceph health detail
          HEALTH_ERR 1 pgs inconsistent; 1 scrub errors
          pg 1.28 is active+clean+inconsistent, acting [8,11,20]
          1 scrub errors

-  Manually run a repair.

   -  Syntax:

      ::

          # ceph pg repar <PLACEMENT_GROUP>

   -  Example:

      ::

          # ceph pg repair 1.28

-  Find the error:

   -  Syntax:

      ::

          # grep ERR /var/log/ceph/ceph-osd.<OSD_NUMBER>.log

   -  Example:

      ::

          # grep ERR /var/log/ceph/ceph-osd.11.log
          2017-01-12 22:27:52.626252 7f5b511e8700 -1 log_channel(cluster) log [ERR] : 1.27 shard 12: soid 1:e4c200f7:::rbd_data.a1e002238e1f29.000000000000136d:head candidate had a read error

-  Find the bad file.

   -  Syntax:

      ::

          # find /var/lib/ceph/osd/ceph-<OSD_NUMBER>/current/<PLACEMENT_GROUP>_head/ -name '*<OBJECT_ID>*' -ls

   -  Example:

      ::

          # find /var/lib/ceph/osd/ceph-11/current/1.28_head/ -name "*a1e002238e1f29.000000000000136d*"
          /var/lib/ceph/osd/ceph-11/current/1.28_head/DIR_7/DIR_2/DIR_3/rbd\udata.b3e012238e1f29.000000000000136d__head_EF004327__1

-  Stop the OSD.

   -  Syntax:

      ::

          # systemctl stop ceph-osd@<OSD_NUMBER>.service

   -  Example:

      ::

          # systemctl stop ceph-osd@11.service

-  Flush the journal to save the current files cached in memory.

   -  Syntax:

      ::

          # ceph-osd -i <OSD_NUMBER> --flush-journal

   -  Example:

      ::

          # ceph-osd -i 11 --flush-journal

-  Move the bad object out of it's current directory in the OSD.

   -  Example:

      ::

          # mv /var/lib/ceph/osd/ceph-11/current/1.28_head/DIR_7/DIR_2/DIR_3/rbd\\udata.b3e012238e1f29.000000000000136d__head_EF004327__1 /root/ceph_osd_backups/

-  Restart the OSD.

   -  Syntax:

      ::

          # systemctl restart ceph-osd@<OSD_NUMBER>.service

   -  Example:

      ::

          # systemctl restart ceph-osd@11.service

-  Run another placement group repair.

   -  Syntax:

      ::

          # ceph pg repar <PLACEMENT_GROUP>

   -  Example:

      ::

          # ceph pg repair 1.28

[1]

Source:

1. "Ceph: manually repair object." April 27, 2015. Accessed January 15,
   2017. http://ceph.com/planet/ceph-manually-repair-object/

Network - Ceph - libvirt
^^^^^^^^^^^^^^^^^^^^^^^^

Virtual machines that are run via the libvirt front-end can utilize
Ceph's RADOS block devices (RBDs) as their main disk.

-  Add the network disk to the available devices in the Virsh
   configuration.

   ::

       <devices>
       <disk type='network' device='disk'>
           <source protocol='rbd' name='<POOL>/<IMAGE>'>
               <host name='<MONITOR_IP>' port='6789'/>
           </source>
           <target dev='vda' bus='virtio'/>
       </disk>
       ...
       </devices>

-  Authentication is required so the Ceph client credentials must be
   encrypted by libvirt. This encrypted hash is called a "secret."

-  Create a Virsh template that has a secret of type "ceph" with a
   description for the end user. Optionally specify a UUID for this
   secret to be associated with or else one will be generated.

   ::

       # vim ceph-secret.xml
       <secret ephemeral='no' private='no'>
       <uuid>51757078-7d63-476f-8524-5d46119cfc8a</uuid>
       <usage type='ceph'>
           <name>The Ceph client key</name>
       </usage>
       </secret>

-  Define a blank secret from this template.

   ::

       # virsh secret-define --file ceph-secret.xml

-  Verify that the secret was created.

   ::

       # virsh secret-list

-  Set the secret to the Ceph client's key. [1]

   ::

       # virsh secret-set-value --secret <GENERATED_UUID> --base64 $(ceph auth get-key client.<USER>)

-  Finally, the secret needs to be referenced as type "ceph" with either
   the "usage" (description) or "uuid" or the secret element that has
   been created. [2]

   ::

       <devices>
       <disk type='network' device='disk'>
       ...
       <auth username='<CLIENT>'>
         <secret type='ceph' usage='The Ceph client key'/>
       </auth>
       ...
       <disk>
       ...
       </devices>

Sources:

1. "USING LIBVIRT WITH CEPH RBD." Ceph Documentation. Accessed January
   27, 2017. http://docs.ceph.com/docs/master/rbd/libvirt/
2. "Secret XML." libvirt. Accessed January 27, 2017.
   https://libvirt.org/formatsecret.html

Network - Ceph - CephFS
^^^^^^^^^^^^^^^^^^^^^^^

CephFS has been stable since the Ceph Jewel 10.2.0 release. This now
includes repair utilities, including fsck. For clients, it is
recommended to use a Linux kernel in the 4 series, or newer, to have the
latest features and bug fixes for the file system. [1]

Source:

1. "USING CEPHFS." Ceph Documentation. Accessed January 15, 2017.
   http://docs.ceph.com/docs/master/cephfs/
