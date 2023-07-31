Backup and Recovery
===================

.. contents:: Table of Contents

Philosophies
------------

3-2-1
~~~~~

The principles of the 3-2-1 backup philosophy help to effectively backup data. That data can be recovered in a worst-case scenario where one or two backups may be corrupted or lost.

-  3 = Keep three backups of a file.
-  2 = Keep two backups on different storage devices.
-  1 = Keep one backup in a remote location.

These are the absolute minimum. More backups can be used as needed. [1]

Btrfs
-----

grub-btrfs
~~~~~~~~~~

The `Antynea/grub-btrfs <https://github.com/Antynea/grub-btrfs>`__ project will automatically generate GRUB entries for every Btrfs snapshot.

Install:

.. code-block:: sh

   $ git clone https://github.com/Antynea/grub-btrfs.git
   $ cd grub-btrfs
   $ sudo make install

It can now be configured. Change the GRUB submenu entry name to an agnostic name (by default, it will say "ArchLinux Snapshots").

.. code-block:: sh

   $ sudo ${EDITOR} /etc/default/grub-btrfs/config
   GRUB_BTRFS_SUBMENUNAME="Btrfs Snapshots"

Now, whenever the GRUB configuration is re-generated, the Btrfs snapshots will be shown on boot.

.. code-block:: sh

   $ sudo grub-mkconfig -o /boot/grub/grub.cfg

Clonezilla
----------

Introduction
~~~~~~~~~~~~

`Clonezilla <https://clonezilla.org/>`__ is a live Debian ISO that can do a fast and efficient backup of a drive. It takes into account file systems, sector sizes, and partition alignment. It is recommended to use this over ``dd``. [2][3] However, Clonezilla does not support going from a large drive to a small drive. [7]

Drive to Drive
~~~~~~~~~~~~~~

Clonezilla can clone from one drive to another.

-  `Download <https://clonezilla.org/downloads.php>`__ Clonezilla.
-  Use ``dd`` on Linux or Rufus on Windows to flash the Clonezilla ISO to an external drive.
-  For backing up a Windows >= 8 drive, first fully shutdown the operating system. Fast Startup is enabled by default which makes it so the "Shutdown" button in Windows acts more like a hibernate state. [4]

   ::

      C:\Windows\system32>shutdown /s /f /t 0

-  Boot into Clonezilla. Select all of the default options until you get to the "Select mode:" screen.
-  Select the "device-device" mode.
-  Select "Beginner mode".
-  Select "disk_to_local_disk local_disk_to_local_disk_clone".
-  Choose the source/original storage device.
-  Choose the destination/new storage device.
-  Select "-sfsck" to skip checking the file system.
-  Select "-k0    Use the partition table from the source disk". [5]
-  Select what to do after the clone is complete: "choose" when done, "true" for getting a command prompt, "reboot", or "shutdown".

After the drive has been cloned, it is required to resize and/or move the partitions to take advantage of the increased space. [6]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/storage/backup_and_recovery.rst>`__

Bibliography
------------

1. "The 3-2-1 Backup Rule – An Efficient Data Protection Strategy." NAKIVO. November 13, 2017. Accessed September 5, 2020. https://www.nakivo.com/blog/3-2-1-backup-rule-efficient-data-protection-strategy/
2. "[SOLVED] dd or clonezilla." Ubuntu Forums. May 3, 2018. Accessed July 30, 2023. https://ubuntuforums.org/showthread.php?t=2390792
3. "Why is Clonezilla faster than dd?" Server Fault. January 8, 2021. Accessed July 30, 2023. https://serverfault.com/questions/495723/why-is-clonezilla-faster-than-dd
4. "How to Fully Shutdown Windows?" Vovsoft. July 30, 2023. March 15, 2023. https://vovsoft.com/blog/how-to-fully-shutdown-windows/
5. "[Solved] Clonzilla Does Not See New SSD." Linux Mint Forums. June 26, 2021. Accessed July 30, 2023. https://forums.linuxmint.com/viewtopic.php?t=351705
6. "How to clone a Windows 10 installation to new drive using Clonezilla." Pureinfotech. June 29, 2023. Accessed July 30, 2023. https://pureinfotech.com/clone-windows-10-drive-clonezilla/
7. "DRBL/Clonezilla FAQ/Q&A." DRBL. July 1, 2023. Accessed July 30, 2023. https://drbl.org/fine-print.php?path=./faq/2_System/25_restore_larger_disk_to_smaller_one.faq#25_restore_larger_disk_to_smaller_one.faq
