Performance Tuning
===================

.. contents:: Table of Contents

Linux Kernel Version
--------------------

-  Use the latest stable `upstream Linux kernel <https://kernel.org/>`__ for the best performance.

   -  Despite claims of custom kernels providing enhanced performance, benchmarks show that in most cases they are still not as fast as the upstream Linux kernel. [1] The LTS Linux kernel is slower and does not support newer hardware compared to the latest stable version but it is more stable. [2]

-  Use at least Linux kernel 6.6 [3] to get the low latency benefits of the new EEVDF CPU scheduler. [4]

Minimize Writes
---------------

Introduction
~~~~~~~~~~~~

By moving more writes into RAM, both (1) the lifespan of a storage device and (2) the speed of a computer will be faster.

Swap
~~~~

-  Do not use a swap file. Instead, configure zram with lz4 compression and other optimized setings. Refer to `zram <../storage/file_systems.html#zram>`__.

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

Ephemeral Logs
~~~~~~~~~~~~~~

Thes changes generally reduce the amount of logs for security and troubleshooting purposes. In exchange, a storage device will have a longer lifespan.


-  Use ``tmpfs`` as the file system for ``/tmp``, ``/var/log``, and ``/var/tmp`` mounts in ``/etc/fstab``. Refer to `ramfs and tmpfs <../storage/file_systems.html#ramfs-and-tmpfs>`__.

-  Store journald logs in memory. Refer to `journald configuration <init.html#configuration>`__.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/systemd/journald.conf
      [Journal]
      Storage=volatile

-  Use the mount options ``noatime,nodiratime`` in ``/etc/fstab``. Refer to `Mount Options <../storage/file_systems.html#mount-options>`__.

Delay Writes
~~~~~~~~~~~~

Delay storage writes to reduce the wear on the storage device's lifespan. These changes can lead to data loss if there is a power outage.

-  Keep writes in RAM for much longer. Refer to `Memory Caching <linux_kernel.html#memory-caching>`__.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/sysctl.d/50-ram-write-cache.conf
      vm.dirty_background_ratio = 40
      vm.dirty_ratio = 80
      vm.vfs_cache_pressure = 50

-  Increase the commit time (the interval before syncing writes to the storage device) to 5 minutes by using the mount option ``commit=300`` in ``/etc/fstab``. There may be noticeable lag or a system hang if the interval is too long or if the drive is too slow. Refer to `Mount Options <../storage/file_systems.html#mount-options>`__.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/performance_tuning.rst>`__

Bibliography
------------

1. "The Performance Impact From Different Arch Linux Kernel Flavors." Phoronix. January 25, 2023. Accessed December 29, 2023. https://www.phoronix.com/review/arch-linux-kernels-2023
2. "Why and How to install the LTS kernel in Arch Linux." Average Linux User. August 23, 2018. Accessed December 29, 2023. https://averagelinuxuser.com/the-lts-kernel-in-arch-linux/
3. "EEVDF Scheduler Merged For Linux 6.6, Intel Hybrid Cluster Scheduling Re-Introduced." Phoronix. August 29, 2023. Accessed February 17, 2024. https://www.phoronix.com/news/Linux-6.6-EEVDF-Merged
4. "An EEVDF CPU scheduler for Linux." LWN.net. March 9, 2023. Accessed February 17, 2024. https://lwn.net/Articles/925371/
