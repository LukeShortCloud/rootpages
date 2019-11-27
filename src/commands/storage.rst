Storage
=======

.. contents:: Table of Contents

See also: Administrative, Hardware, Virtualization

Partitioning
------------

cfdisk
~~~~~~

A command line user interface (CLUI) wrapper for fdisk.

fdisk 
~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -l, "lists all partitions, sector and disk label information"
   m, shows menu options
   p, show current parition layout
   d, deletes paritition

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sdc, modify partitions on the third SATA drive

parted
~~~~~~

Partition manager that supports creating, reading, updating, and deleting MBR and GPT partitions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   help, show the help guide
   help mkpart, shows how to make a new partition
   select, select a partition
   print all, shows all the partitions; you will need to know where the last one ends to create a new one
   mktable, create either a ""msdos"" (MBR) or ""gpt"" partition table on the selected drive
   align-check optimal, check a partition to see if it is properly aligned

mkfs.btrfs
~~~~~~~~~~

Package: btrfs-progs

Create Btrfs file systems.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -d, "specify a RAID type (raid0, raid1, raid5, raid6, raid10) and drives for creating a RAID for daa"
   -m, the same as ""-d"" but instead specifying where the RAID filesystem metadata should be spread out to

btrfs
~~~~~

Manage Btrfs partitions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   filesystem show, list all BTRFS partitions and their usage
   filesystem df /, show disk usage on the root partition; this should be used instead of just running ""df"" outside of the btrfs command
   filesystem resize {+|-}<SIZE>{m|g}, resize the filesystem on an active/live mount
   subvolume list, list all of the snapshots and subvolumes under a specified mount directory
   snapshot create, create a snapshot of the partition
   subvolume snapshot, create a snapshot of a subvolume
   filesystem defragment -r -v -c lzo, "defragment the system files, recursively, verbosely, and compress them using the high performance ""lzo"" algorithim; be sure to add the ""compress=lzo"" mount option in /etc/fstab for the partition"
   balance start / -v, "rebalance/defragment the repartition at the block level, on the root partition, verbosely; this will help free up space"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   subvolume create /var/ /var/var-snapshot/, create a snapshot of the /var/ folder

mkfs.ext4
~~~~~~~~~

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sdc3, creates a ext4 formatted partition on /dev/sdc3

mkswap
~~~~~~

Package: util-linux

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sda2, creates swap parition format on /dev/sda2

swapon
~~~~~~

Package: util-linux

Configure Linux to swap on certain partitions.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sda2, tells Linux swap on /dev/sda2

partclone
~~~~~~~~~

An efficient partition backup utility.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -c, clone a partition
   -r, restore a cloned partition
   -s, specify the source partition
   -o, save the partition clone to a specified file

mount
~~~~~

Mount a partition onto a folder.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -l, lists all current mounts
   -r, read-only
   -t, file system to use
   -o loop, for loop devices such as ISO images
   -o remount, remount a directory
   -a, remounts all entries in the /etc/fstab

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sda1 /var, "mounts the first SCSI drive's (sda) first partition onto the folder /var"

umount
~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -l, lazy unmount; unmount the file system and let the running processes on it complete
   -f, force dismount now

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /var, dismount the partition that is on /var

lsblk
~~~~~

Lists partition, their size, and mount point information.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --scsi, "list SCSI devices like iSCSI, SATA, SAS, etc."
   -f, show file systems

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   /dev/sda, show information only about the sda drive

blkid
~~~~~

Shows UUIDs and labels for all of the partitions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -c /dev/null, regenerate the partition UUIDs for the /etc/blkid.tab file

touch /forcefsck
~~~~~~~~~~~~~~~~

Forces a files system check on the next boot.

dd
~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   if=, specify an input device to read from
   of=, specify an output device to write to
   bs=, specify the byte size
   count=, number of times it should copy each byte size
   conv=fdatasync, flush data to the disk; do not cache it in memory

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   if=/dev/zero of=/tmp/50MB.img bs=1M count=50, create a blank file that is 50MB	
   if=/dev/sda1 of=file.img, copy blocks from a partition to a file

df
~~

Show disk space usage.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -h, human readable space usage
   -i, inonde/file count
   -T, also display the filesystem types
   -t, only show filesystems of this type

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -h -t xfs, show human readable sizes for only XFS file systems

du
~~

Show folder disk space usage.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -h, human readable size format
   --max-depth=, the maximum number of subdirectories to find their disk space

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -h --max-depth=2, show sizes up to two directories deep

ncdu
~~~~

Interactively show and navigate through "du" disk space usage reports.

testdisk
~~~~~~~~

Data recovery tool.

fsck
~~~~

File system check utility for helping fixing corrupt file systems.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -y, automatically attempt to repair any problems
   -t, the file system type
   -C, show the progress
   -V, verbosely show the specific file system commands that are being run and their output

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -C -t ext4 -y /dev/sdb2, automatically fix any problems with the ext4 file system on /dev/sdb2

dumpe2fs
~~~~~~~~

Lookup UUIDs of partitions. These can be used in /etc/fstab.

dmesg
~~~~~

Kernel logs for hardware devices. After plugging in a USB device, check this to find it's device name and parition to mount.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   dmesg | grep SCSI, shows all connected SCSI devices

mkisofs
~~~~~~~

Create ISO images.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -o <FILE>.iso <DIRECTORY>, creates an ISO file from the contents of a directory

lsof
~~~~

List open files is used to show what processes are using a certain file or directory.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   +D <DIRECTORY>, shows what PIDs are using the drive

fuser
~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -uz <DIRECTORY>, forcefully unmount a a file system
   -mv <DIRECTORY>, used to see what user's are using the file or directory

iostat
~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -x <INTEGER>, monitor every specifed number of seconds

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -x 5, report on I/O usage every 5 seconds

partprobe
~~~~~~~~~

Pacakage: parted

Rescan for the latest information about available partitions. Sometimes required after updating or changing a partition.

smartctl
~~~~~~~~

Package: smartmontools

Monitor drive health using SMART firmware (standard on mondern storage devices).

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -a, shows all SMART information
   -i, shows detailed drive information
   -H, shows health status
   -t, "test for any errors, this can be ""short"" or ""long"""
   -l selftest, shows the results of a test
   -s {on|off}, turn SMART recording on or off for a specified drive

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -t short /dev/sdb, run a quick test on the drive /dev/sdb

kpartx
~~~~~~

Find and attach partitions from storage devices.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -a, find all partitions in a given LV or image file and create loop devices for them
   -d, detach the loop devices for a given LV or image file
   -u, update the partition mapping
   -v, verbose

losetup
~~~~~~~

Controls loop devices.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -a, view all loop devices created by losetup
   -d <LOOP_DEVICE>, detach a loop device
   --detach-all, detach all loop devices created by losetup

xfs_admin
~~~~~~~~~

Manage XFS partitions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -L, creates a label

e2label
~~~~~~~

Create labels on EXT file systems.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   <DEVICE>, shows any label names
   <DEVICE> <LABLE>, create a label for a device

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sda1 BackupDrive, label sda1 as BackupDrive

mdadm
~~~~~

Create and manage software RAIDs.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --create, create a RAID...
   --level=<INTEGER>, ...specify the RAID level
   --raid-device=<INTEGER>, ...and specify the amount of drives to be used.
   --detail, shows details about a current RAID
   --detail --scan, automatically scan for all RAIDs in use and show details
   --examine --scan, look for inactive RAIDs
   --assemble, recreate RAID with specified drives
   --assemble --scan, automatically recreate existing RAIDs
   --stop /dev/md<NUMBER>, disable a RAID device

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   mdam --create --level=0 --raid-device=2 /dev/md0 /dev/sda /dev/sdb, use sda and sdb to create a software RAID0

ssm
~~~

Create and manage encrypted partitions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   create, create a new volume
   open, specifiy a partition and a mapper to map it to
   close, remove the mapper device
   --fstype, specify filesystem
   --encrypt, specify encryption

cryptsetup
~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -y, verify password; ask for it to be input twice
   luksFormat, specify a partition to format with LUKS encryption
   open --type luks /dev/<DEVICE> <MAP>, mount the encrypted partition
   close, remove the mapper device

   open --type luks /dev/sda4 mydata, mount the /dev/sda4 partition as /dev/mapper/mydata

od
~~

Octal dump is used to read 8 bits (1 byte) at a time of data directly from a storage device.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -c, shows special characters
   -N<INTEGER>, read the first specified number of bytes
   -j<INTEGER>, skip the first specified number of bytes
   -v, output duplicate information

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -N32, read the first 32 bytes
   -j512, skip the first 512 bytes

gddrescue
~~~~~~~~~

GNU ddrescue.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -r 1, try to recover bad sectors
   -n, copy non-error sectors

ddrescue
~~~~~~~~

Not to be confused with GNU ddrescue.

guestfish
~~~~~~~~~

Package: libguestfs-tools-c

Mount QCOW2 images interactively.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --rw, mount in read/write mode
   --ro, mount in read-only mode
   -a, specify the image file
   >run, run a search of information on the used disk
   >list-filesystems, show all of the filesystems
   >mount, mount a partition onto a mountpoint
   >ls, list a directory
   >edit, open up the ""vi"" editor
   >touch, create a new file
   >exit, properly close the image and exit out of the prompt

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   echo -e "run\nlist-filesystems" | guestfish -a centos-7.qcow, use guestfish to non-interactively view the file systems on a QCOW2 image

guestmount
~~~~~~~~~~

Mount QCOW2 images non-interactively.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -a, specify the image file
   -m, specify the partition to use and then a mount point
   --rw, mount in read-write mode
   --ro, mount in read-only mode

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   guestmount -a image.qcow2 -m /dev/sda1 --rw /mnt, mount the sda1 partition from a QCOW2 image in a writeable mode to the /mnt directory

guestunmount
~~~~~~~~~~~~

Unmount QCOW2 image partitions mounted by guestmount.

LVM
---

The Logical Volume Manager (LVM) is an implementation to help easily configure and setup partitions and drives.

pvcreate
~~~~~~~~

Create physical volumes.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   pvcreate /dev/sdb1 /dev/sdc1 /dev/sdc2, create a physical volume from these three partitions

pvremove
~~~~~~~~

Remove physical volumes.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   /dev/sdb1 /dev/sdc1 /dev/sdc2, remove these three partitions from physical volumes

pvdisplay
~~~~~~~~~

Show all physical of the LVM partitions.

vgcreate
~~~~~~~~

Create logical volume groups.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   fileserver /dev/sdb1 /dev/sdc1, creates a volume group of LVMs that can be partitioned for actual use

vgdisplay
~~~~~~~~~

Show information about the volume groups.

vgrename
~~~~~~~~

Rename volume groups.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   fileserver fileserver_new, change volume group name to fileserver_new

lvcreate
~~~~~~~~

Create a logical volume.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --name <NAME> --size <SIZE>G <VOLUME_GROUP>, create a new logical volume
   -l 100%FREE --thinpool <LOGICAL_VOLUME> <VOLUME_GROUP>, create a thin provisioning pool to allow for more efficent snapshots
   -s <VOLUME_GROUP>/<LOGICAL_NAME>, create a snapshot of a logical volume (this can be restored at a later point in time)

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   --name media --size 30G fileserver, create a logical volume to be used as a virtual drive/parition
   -L30G -s -n newsnapshot /dev/fileserver/media, create a 30GB snapshot of the media logical volume
   -V 4G --thin -n <NEW_LOGICAL_VOLUME> <VOLUME_GROUP>/<LOGICAL_VOLUME>, "create a logical thin volume within a logical thin pool (does not fully allocate the space, allows for over-allocating resources)"

lvrename
~~~~~~~~

Rename logical volumes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   <VOLUME_GROUP> <LOGICAL_VOLUME_NAME> <NEW_LOGICAL_VOLUME_NAME>

lvresize
~~~~~~~~

Resize logical volumes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -r, resize the filesystem
   -L, size in M(B) or G(B)
   -l 100%FREE, expand to use all available free space

lvextend
~~~~~~~~~

Increase the size of logical volumes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -L, size in M(B) or G(B)

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -L55.5G /dev/fileserver/media, increases LV size of media by 55.5 gigabytes
   --extents +100%FREE lv_example, extend the LV lv_example to utilize all of the available space in VG

lvreduce
~~~~~~~~

Decrease the size of a logical volume.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -L, size in M(B) or G(B)

lvremove
~~~~~~~~

Remove logical volumes.

lvconvert
~~~~~~~~~

Restore a snapshot.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --merge <LOGICAL_VOLUME_SNAPSHOT>, the original logical volume will be restoed to this specified snapshot

lvchange
~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -ay <VOLUME_GROUP>/<LOGICAL_VOLUME>, activate a logical volume
   -an <VOLUME_GROUP>/<LOGICAL_VOLUME>, deactivate a logical volume

Boot Loaders
------------

grub-customizer
~~~~~~~~~~~~~~~

A GUI for modifying GRUB boot entries.

gnome-disks
~~~~~~~~~~~

Package: gnome-disk-utility

Provides a GUI for modifying disk partitions

grub2-mkconfig
~~~~~~~~~~~~~~

A utility to dynamically rebuild the GRUB 2 configuration based on the installed kernels and GRUB settings. On Fedora, the utility is ``grub2-mkconfig``. On other operating systems it is ``grub-mkconfig``.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -o, output the GRUB configuration to a specified file

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -o /boot/grub2/grub.cfg, rebuild the GRUB2 BIOS configuration on RHEL 7 and Fedora
   -o /boot/grub/grub.cfg, rebuild the GRUB2 BIOS or UEFI configuration on Arch Linux
   -o /boot/efi/EFI/redhat/grub.cfg, rebuild the GRUB2 UEFI config on RHEL 7
   -o /boot/efi/EFI/fedora/grub.cfg, rebuild the GRUB2 UEFI config on Fedora

grub-update
~~~~~~~~~~~

Update the GRUB bootloader data on the start of the storage device.

(GRUB Rescue Prompt)
~~~~~~~~~~~~~~~~~~~~

If GRUB fails to boot, a ``grub rescue>`` prompt is presented to the end-user.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   insmod normal; normal, this will load the kernel module for the GUI GRUB prompt
   blkid, list partitions and their UUIDs
   ls, list the partitions; this can also be used to view files in the partition
   busybox, busybox is sometimes provided to have common shell utilies available

dracut
~~~~~~

Rebuild the initramfs on Fedora.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", rebuild the initramfs for the current running kernel; optionally specify a kernel version
   "-f, --force", replace the initramfs if it already exists
   --add-drivers, a list of kernel modules to append to the default modules
   --drivers, a specific list of kernel modules to compile into the initramfs
   --list-modules, show all Dracut modules
   --add, "Dracut modules to add, appending the default modules"
   --driver, a specific list of Dracut modules to add
   --omit-drivers, specify a list of kernel modules to exclude
   --install, a list of files to add
   --compress {gzip|bzip2|lzma|xz|lzo|lz4}, specify the type of compression to use; default is gzip
   --kernel-image, the kernel image file to use

Ceph
----

ceph-deploy
~~~~~~~~~~~

Install and manage Ceph.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   install --release <RELEASE> <SERVER1> <SERVER2>, install or upgrade the release version of Ceph (see http://docs.ceph.com/docs/master/releases/) on the specified servers
   mon create-inital, install the Ceph monitor services on the local node
   disk list <SERVER1>, show all avaiable disks on a specified server
   disk zap <SERVER1>:<DRIVE1>, remove the partition table off of the specified server's drives
   osd create <SERVER1>:<DRIVE1>, "prepare the drives; two partitions are created, a (1) data and (2) journal partition"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   disk zap node1:sdc, wipe the sdc drive from node1

ceph
~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   auth list, show users and their permissions
   status, show information about the Ceph cluster
   mon {stat|dump}, show the status of the Ceph monitoring services
   tell osd.* version, show the Ceph version on the OSD nodes
   tell mon.* version, show the Ceph version on the monitor nodes
   osd pool ls, list all created pools
   health, show the health status of the cluster
   health detail, show a more detailed report of any issues
   pg repair <PG>, fix inconsistencies within a placement group
   osd <POOL> set data size <COUNT>, set the total number of all objects (replicas and the original file) that should be created per object
   osd pool get <POOL> <KEY>, get the current value for the key for a specific pool
   osd pool get rbd size, show the replica count
   pg dump, display the placement group map
   osd dump, display the OSD map
   osd tree, show OSD weights and brief status
   osd pool create <NAME> <PG_NUM> <PGP_NUM>, create a new pool in Ceph
   osd pool get volumes size, show volume sizes
   osd pool set volumes size <INTEGER>, set volumes size

ceph-osd
~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -i, specify the OSD drive number
   --flush-journal, flush the journal to the disk

rbd
~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   {ls|list}, show block devices in a specified pool
   rm <DEVICE> -p <POOL>, delete a device from a pool
   export <POOL>/<VOLUME> --path <FILE>.img, download the block image
   snap ls <POOL>/<VOLUME>, show all snapshots for a block device
   snap purge, remove all snapshots
   snap protect, prevent a snapshot from being deletable
   snap unprotect, allow a snapshot to be deleted
   create <POOL>/<IMAGE> --size <SIZE_IN_MB>, create a new RBD image
   map <POOL>/<IMAGE>, map an RBD image to a client server as a block device
   feature disable imagename deep-flatten fast-diff object-map exclusive-lock, disable all of the new RBD features for an image that are new to the Jewel release; these require the Linux 4.8 kernel or newer
   rbd snap purge <POOL>/<VOLUME_ID>@<SNAPSHOT>, remove a snapshot

rados
~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   lspools, view RADOS pools
   df, show Ceph disk usage
   -p <POOL> ls, show raw PG files that are part of a pool

iSCSI
-----

targetcli (interactive)
~~~~~~~~~~~~~~~~~~~~~~~

Create iSCSI targets.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   ls, view the current configuration tree
   cd, change to a different path
   saveconfig, save the configuration
   restoreconfig, restore a specified configuration file
   clearconfig, delete the current configuration
   help, view help output

.. csv-table::
   :header: Variables, Explanation
   :widths: 20, 20

   auto_save_on_exit, run saveconfig on exit; default: True
   confirm, allow the configuration to be cleared; default: False

iscsiadm
~~~~~~~~

Package: iscsi-initiator-utils

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --mode discoverydb --type sendtargets --portal <IPADDRESS> --discover, search for iSCSI targets at a given address
   iscsiadm --mode node --targetname <TPG> --portal <IPADDRESS> --login, attach the target portal group

Windows Partitioning
--------------------

These are utilities to manage Windows file systems from UNIX-like operating systems.

fatresize
~~~~~~~~~

Resize FAT file systems.

mkdosfs
~~~~~~~

Package: dosfstools

Manage DOS filesystems.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -F 16, format a partition to FAT16

mkfs.ntfs
~~~~~~~~~

Create NTFS file systems.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -Q, quickly formats 1 partition to NTFS on a device

mount -t ntfs-3g
~~~~~~~~~~~~~~~~

Package: ntfs-3g

Mount NTFS file systems. The Windows operating system had to have been cleanly and fully shutdown first by running ``shutdown /s /f /t 0`` from Windows.

ms-sys
~~~~~~

Utility for creating Windows Master Boot Records (MBR).

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --fat32, create a FAT32 DOS MBR
   -7, create a Windows 7 MBR

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/commands/storage.rst>`__
