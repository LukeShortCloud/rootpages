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

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/storage/backup_and_recovery.rst>`__

Bibliography
------------

1. "The 3-2-1 Backup Rule – An Efficient Data Protection Strategy." NAKIVO. November 13, 2017. Accessed September 5, 2020. https://www.nakivo.com/blog/3-2-1-backup-rule-efficient-data-protection-strategy/
