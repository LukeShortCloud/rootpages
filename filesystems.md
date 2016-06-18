# File Systems
* [Types](#types)
  * ext4
  * XFS
  * BtrFS
* Network
  * NFS
  * SMB/CIFS
* RAIDs
 * mdadm
* LVM

## Types
| Name (mount type) | OS | Notes |  File Size Limit | Inode Limit | Partition Size Limit |
| --- | --- | --- | --- | --- | --- |
| Fat16 (vfat) | DOS | no journaling | 2GiB | | 2GiB |
| Fat32 (vfat) | DOS | no journaling, generally cross platform compatible | 4GiB | | 8TiB |
| NTFS (ntfs-3g)  | Windows | journaling, encryption, compression | 2TiB | | 256TiB |
| ext4 | Linux | journaling, less fragmentation, better performance | 16TiB | | 1EiB |
| XFS | Linux | journaling, online resizing (but cannot shrink), online defragmentation, 64-bit file system | 8 EiB (theoretically up to 16EiB) | | 8 EiB (theoretically up to 16EiB)
| BtrFS | Linux | journaling, copy-on-write (CoW), compression, snapshots, RAID, 64-bit file system  | 8EiB (theoretically up to 16EiB) | | 8EiB (theoretically up to 16EiB) |
| tmpfs | Linux | RAM and swap | | | |
| ramfs | Linux | RAM (no swap) | | | | |

Sources:
https://help.ubuntu.com/community/LinuxFilesystemsExplained 
https://btrfs.wiki.kernel.org/index.php/Main_Page

