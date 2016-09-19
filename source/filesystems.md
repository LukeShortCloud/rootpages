# File Systems
* [Types](#types)
  * [BtrFS](#btrfs)
    * [BtrFS Mount Options](#btrfs-mount-options)
    * [BtrFS RAIDs](#btrfs-raids)
    * [BtrFS Limitations](#btrfs-limitations)
  * ext4
  * XFS
  * ZFS
* LVM
* [RAIDs](#raids)
 * [mdadm](#raids---mdadm)
* [Network](#network)
  * [NFS](#network---nfs)
  * SMB/CIFS
  * [iSCSI](#network---iscsi)
    * [Target](#network---iscsi---target)
    * [Initiator](#network---iscsi---initiator)
  * Ceph


## Types
| Name (mount type) | OS | Notes |  File Size Limit | File Count (Inode) Limit | Partition Size Limit |
| --- | --- | --- | --- | --- | --- |
| Fat16 (vfat) | DOS | no journaling | 2GiB | | 2GiB |
| Fat32 (vfat) | DOS | no journaling, generally cross platform compatible | 4GiB | 268,173,300 [2] | 8TiB |
| NTFS (ntfs-3g)  | Windows | journaling, encryption, compression | 2TiB | 2^32 - 1 [2] | 256TiB |
| ext4 | Linux | journaling, less fragmentation, better performance | 16TiB | 2^32 - 1 [2] | 1EiB |
| XFS[1] | Linux | journaling, online resizing (but cannot shrink), online defragmentation, 64-bit file system | 8 EiB (theoretically up to 16EiB) | 2^64 - 1 | 8 EiB (theoretically up to 16EiB)
| BtrFS[3] | Linux | journaling, copy-on-write (CoW), compression, snapshots, RAID, 64-bit file system  | 8EiB (theoretically up to 16EiB) | 2^64 - 1 | 8EiB (theoretically up to 16EiB) |
| tmpfs | Linux | RAM and swap | | | |
| ramfs | Linux | RAM (no swap) | | | | |
[1]

Sources:
1. "Linux File systems Explained." Ubuntu Documentation. November 8, 2015. https://help.ubuntu.com/community/LinuxFilesystemsExplained
2. "How many files can I put in a directory?" Stack Overflow. July 14, 2015. http://stackoverflow.com/questions/466521/how-many-files-can-i-put-in-a-directory
3. "BtrFS Main Page." BtrFS Kernel Wiki. June 24, 2016. https://btrfs.wiki.kernel.org/index.php/Main_Page

### BtrFS
BtrFS stands for the "B-tree filesystem." The file system is commonly referred to as "BtreeFS", "ButterFS", and "BetterFS". In this model, data is organized efficently for fast I/O operations. This helps to provide copy-on-write (CoW) for efficent file copies as well as other useful features. BtrFS supports subvolumes, CoW snapshots, online defragementation, built-in RAID, compression, and the ability to upgrade an existing ext file systems to BtrFS [1].

Source:

1. "What’s All This I Hear About Btrfs For Linux." The Personal Blog of Dan Calloway. December 16, 2012. https://danielcalloway.wordpress.com/2012/12/16/whats-all-this-i-hear-about-btrfs-for-linux/

#### BtrFS Mount Options
Common options include:
* autodefrag = Automatically defragement the file system. This can negatively impact performance.
* compress = File system compression can be used. Valid options are:
  * zlib = Higher compression
  * lzo = Faster file system performance
  * no = Disable compression (default)
* notreelog = Disable journaling. This may improve performance but can result in a loss of the file system if power is lost.
* subvolume = Mount a subvolume contained inside a BtrFS file system.
* ssd = Enables various solid state drive optimizations. This does not turn on TRIM support.
* discard = Enables TRIM support. [1]

Source:
1. "Mount Options" BtrFS Kernel Wiki. May 5, 2016. https://btrfs.wiki.kernel.org/index.php/Mount_options

#### BtrFS RAIDs
In the latest Linux kernels, all RAID types (0, 1, 5, 6, and 10) are supported. [1]

Source:

1. "Using Btrfs with Multiple Devices" BtrFS Kernel Wiki. May 14, 2016. https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices

#### BtrFS Limitations
Known limitations:
* The "df" (disk free) command does not report an accurate disk usage due to BtrFS's fragmentation. Instead, "btrfs filesystem df" should be used to view disk space usage on mount points and "btrfs filesystem show" for partitions.
  * For freeing up space, run a block-level and then a file-level defragmentation. Then the disk space usage should be accurate to df's output. [1]
    * \# btrfs balance start /
    * \# btrfs defragment -r /

Source:

1. "Preventing a btrfs Nightmare." Jupiter Boradcasting. July 6, 2014.
http://www.jupiterbroadcasting.com/61572/preventing-a-btrfs-nightmare-las-320/

# RAIDs

RAID officially stands for "Redundant Array of Independent Disks." The idea of a RAID is to get either increased performance and/or an automatic backup from using multiple disks together. It utilizes these drives to create 1 logical drive.


| Level | Minimum Drives | Benefit | Fallbacks |
| ----- | -------------- | ------- | --------- |
| 0 | 2 | Speed and increased drive space. I/O operations are equally spread to each disk. | No redudnacy. |
| 1 | 2 | Redundancy. If one drive fails, a second drive will have an exact copy of all of the data. | Slower write speeds. |
| 5 | 3 | Speed, space, and redudnancy. It can also recover from a failed drive without any affect on performance. | Drive recovery takes a long time and will not work if more than one drive fails. Rebuilding/restoring a RAID 5 takes a long time. |
| 6 | 4 | This is an enhanced RAID 5 that can survive up to 2 drive failures. | See the other RAID 5 fallbacks.
| 10 | 4 | Speed, space, and redudnacy. This uses both RAID 1 and 0. | Requires more physical drives. Rebuilding/restoring a RAID 10 will require some downtime. |

[1]

Source:

1. "RAID levels 0, 1, 2, 3, 4, 5, 6, 0+1, 1+0 features explained in detail." GOLINUXHUB. April 09, 2016. Accessed August 13th, 2016. http://www.golinuxhub.com/2014/04/raid-levels-0-1-2-3-4-5-6-01-10.html

## RAIDs - mdadm

Most software RAIDs in Linux are handled by the "mdadm" utility and the "md_mod" kernel module. Creating a new RAID requires specifying the RAID level and the partitions you will use to create it.

Syntax:
```
# mdadm --create --level=<LEVEL> --raid-devices=<NUMBER_OF_DISKS> /dev/md<DEVICE_NUMBER_TO_CREATE> /dev/sd<PARTITION1> /dev/sd<PARTITION2>
```

Example:
```
# mdadm --create --level=10 --raid-devices=4 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1
```

Then to automatically create the partition layout file run this:
```
# echo 'DEVICE partitions' > /etc/mdadm.conf
# mdadm --detail --scan >> /etc/mdadm.conf
```

Finally, you can initalize the RAID.
```
# mdadm --assemble --scan
```

[1]

1. "RAID." Arch Linux Wiki. August 7, 2016. Accessed August 13, 2016. https://wiki.archlinux.org/index.php/RAID

# Network

## Network - NFS

The Network File System (NFS) aims to universally provide a way to remotely mount directories between servers. All subdirectories from a shared directory will also be available.

Ports:
* 111 TCP/UDP
* 2049 TCP/UDP
* 4045 TCP/UDP

On the server, the /etc/exports file is used to manage NFS exports. Here a directory can be specified to be shared via NFS to a specific IP address or CIDR range. After adjusting the exports, the NFS daemon will need to be restarted.

Example:
```
# vim /etc/exports
/path/to/dir 192.168.0.0/24(rw,no_root_squash)
# systemctl restart nfs
```

NFS export options:
* rw = The directory will be writable.
* ro (default) = The directory will be read-only.
* no_root_squash = Allow remote root users to access the directory and create files owned by root.
* root_squash (default) = Do not allow remote root users to create files as root. Instead, they will be created as an anonymous user (typically "nobody").
* all_squash = All files are created as the anonymouse user.
* sync = Writes are instantly written to the disk. When one process is writing, the other processes wait for it to finish.
* async (default) = Multiple writes are optimized to run in parallel. These writes may be cached in memory.
* sec = Specify a type of Kerberos authentication to use.
  * krb5 = Use Kerberos for authentication only.

[1]

On Red Hat Enterprise Linux systems, the exported directory will need to have the "nfs_t" file context for SELinux to work properly.

```
# semanage fcontext -a -t nfs_t "/path/to/dir{/.*)?"
# restorecon -R "/path/to/dir"
```

Sources:

1. "NFS SERVER CONFIGURATION." Red Hat Documentation. Accessed September 19, 2016. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Storage_Administration_Guide/nfs-serverconfig.html

## Network - iSCSI

The "Inernet Small Computer Systems Interface" (also known as "Internet SCSI" or simply "iSCSI") is used to allocate block storage to servers over a network. It relies on two components: the target (server) and the initiator (client). The target must first be configured to allow the client to attach the storage device.


### Network - iSCSI Target

For setting up a target storage, these are the general steps to follow in order:
* Create a backstores device.
* Create an iSCSI domain.
* Create a network portal to listen on.
* Create a LUN associated with the backstores.
* Create an ACL.
* Optionally configure ACLs.

* First, start and enable the iSCSI service to start on bootup.
```
# systemctl enable target && systemctl start target
```

* Create a storage device. This is typically either a block device or a file.
  * Block syntax:
```
# targetcli
> cd /backstores/block/
> create iscsidisk1 dev=/dev/sd<DISK>
```
  * File syntax:
```
# targetcli
> cd /backstore/fileio/
> create iscsidisk1 /<PATH_TO_DISK>.img <SIZE_IN_MB>M
```

* A special iSCSI Qualified Name (IQN) is required to create a Target Portal Group (TPG). The syntax is "iqn.YYYY-MM.tld.domain.subdomain:exportname."
  * Syntax:
```
> cd /iscsi
> create iqn.YYYY-MM.<TLD.DOMAIN>:<ISCSINAME>
```
  * Example:
```
> cd /iscsi
> create iqn.2016-01.com.example.server:iscsidisk
> ls
```

* Create a portal for the iSCSI device to be accessible on.
  * Syntax:
```
> cd /iscsi/iqn.YYYY-MM.<TLD.DOMAIN>:<ISCSINAME>/tpg1
> portals/ create
```
  * Example:
```
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
```

* Create a LUN.
  * Syntax:
```
> luns/ create /backstores/block/<DEVICE>
```
  * Example:
```
> luns/ create /backstores/block/iscsidisk
```

* Create a blank ACL. By default, this will allow any user to access this iSCSI target.
  * Syntax:
```
> acls/ create iqn.YYYY-MM.<TLD.DOMAIN>:<ACL_NAME>
```
  * Example:
```
> acls/ create iqn.2016-01.com.example.server:client
```

* Optionally, add a username and password.
  * Syntax:
```
> cd acls/iqn.YYYY-MM.<TLD.DOMAIN>:<ACL_NAME>
> set auth userid=<USER>
> set auth password=<PASSWORD>
```
  *  Example:
```
> cd acls/iqn.2016-01.com.example.server:client
> set auth userid=toor
> set auth password=pass
```

* Finally, make sure that both the TCP and UDP port 3260 are open in the firewall.

[1]

### Network - iSCSI - Initiator

This should be configured on the client server.

* In the initiator configuration file, specify the IQN along with the ACL used to access it.
  * Example:
```
# vim /etc/iscsi/initiatorname.iscsi
InitiatorName=iqn.2016-01.com.example.server:client
```

* Start and enable the iSCSI initiator to load on bootup.
```
# systemctl start iscsi && systemctl enable iscsi
```

* Once started, the iSCSI device should be able to be attached.
  * Syntax:
```
# iscsiadm --mode node --targetname <IQN>:<iSCSI_DEVICE> --portal <iSCSI_SERVER_IP> --login
```
  * Example:
```
# iscsiadm --mode node --targetname iqn.2016-01.com.example.server:iscsidisk --portal 10.0.0.1 --login
```

* Verify that a new "iscsi" device exists.
```
# lsblk --scsi
```

[1]

1. "RHEL7: Configure a system as either an iSCSI target or initiator that persistently mounts an iSCSI target." CertDepot. July 30, 2016. Accessed August 13, 2016. https://www.certdepot.net/rhel7-configure-iscsi-target-initiator-persistently/









