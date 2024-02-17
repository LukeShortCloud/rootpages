Performance Tuning
===================

.. contents:: Table of Contents

Linux Kernel Version
--------------------

-  Use the latest stable `upstream Linux kernel <https://kernel.org/>`__ for the best performance.

   -  Despite claims of custom kernels providing enhanced performance, benchmarks show that in most cases they are still not as fast as the upstream Linux kernel. [1] The LTS Linux kernel is slower and does not support newer hardware compared to the latest stable version but it is more stable. [2]

-  Use at least Linux kernel 6.6 [3] to get the low latency benefits of the new EEVDF CPU scheduler. [4]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/performance_tuning.rst>`__

Bibliography
------------

1. "The Performance Impact From Different Arch Linux Kernel Flavors." Phoronix. January 25, 2023. Accessed December 29, 2023. https://www.phoronix.com/review/arch-linux-kernels-2023
2. "Why and How to install the LTS kernel in Arch Linux." Average Linux User. August 23, 2018. Accessed December 29, 2023. https://averagelinuxuser.com/the-lts-kernel-in-arch-linux/
3. "EEVDF Scheduler Merged For Linux 6.6, Intel Hybrid Cluster Scheduling Re-Introduced." Phoronix. August 29, 2023. Accessed February 17, 2024. https://www.phoronix.com/news/Linux-6.6-EEVDF-Merged
4. "An EEVDF CPU scheduler for Linux." LWN.net. March 9, 2023. Accessed February 17, 2024. https://lwn.net/Articles/925371/
