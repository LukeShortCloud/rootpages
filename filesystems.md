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
* RAIDs
 * mdadm
* Network
  * NFS
  * SMB/CIFS

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






