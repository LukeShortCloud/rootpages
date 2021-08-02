Linux Kernel
============

.. contents:: Table of Contents

Linux is a kernel designed to be similar to the original UNIX kernel. It
is a modern, free, and open source alternative that was originally
created by Linus Torvalds. It is built to work on many processor
architectures. "Linux" is sometimes used to generally describe the many
operating systems that use the Linux kernel. [1] In the context of this
Root Pages guide, the focus is on the actual kernel.

Each kernel new kernel in development normally goes through 7 to 9 weeks of release candidates before it is marked as stable. [12] At some point after the Linux git repository has added more than 2 million git objects, the major version number is increased. [13] The latest kernels can be found `here <https://www.kernel.org/>`__.

The types of Linux kernel releases include:

-  mainline = The latest development release that is working towards a stable release.
-  stable = The current stable release.
-  longterm = Long-term supported kernels are older versions that primarily only receive bug fixes.
-  linux-next = Daily unstable development releases from the "master" git branch.

System Calls
------------

Programs use system calls to interact with the kernel to do tasks.

Common system calls:

.. csv-table::
   :header: Call, Type, Description
   :widths: 20, 20, 20

   accept, Network, Accept an incoming network connection.
   bind, Network, Associate a network socket to a specific IP address.
   chdir, Process, Change to a different working directory.
   chmod, File, Change the mode permissions.
   chown, File, Change the owner permissions.
   chroot, Process, Change the working root directory.
   close, File, Close a file.
   connect, Network, Make an external network connection.
   exec, Process, "Execute/start a program."
   exit, Process, End a process.
   fork, Process, Spawn a new process.
   getgid, Process, Find the group ID.
   getuid, Process, Find the user ID.
   kill, Process, Send a signal to a process.
   link, File, "Create a shortcut that mirrors an existing inode (a hard link)."
   mkdir, File, Create a directory.
   mknod, File, Create a file (node).
   mount, File, Mount a file system onto a directory.
   nice, Process, Modify the priority of a process.
   open, File, Open a file.
   pause, Process, Temporarily stop a process from running until a signal is given to continue.
   pipe, Process, Stream output data from one process to another. 
   read, File, Read data from a file.
   setgid, Process, "Change a process' group ID."
   setpriority, Process, "Change a process' kernel scheduling priority."
   setuid, Process, "Change a process' user ID."
   socket, "File/Network/Process", "Create a socket that can listen for requests. This can be a UNIX file socket, network port, or a special process."
   symlink, File, "Create a shortcut that redirects to another file (a symbolic link)."
   sync, File, Flush data from memory to the disk.
   stat, File, "View a file's metadata."
   time, Process, "A count of seconds since 1970-01-01."
   ulimit, Process, View and modify user process limits.
   unlink, File, Delete a directory.
   umask, File, View and modify the default permissions of files and directories.
   wait, Process,  Wait for a child process to end.
   write, File, Write data to a file.

[2]

Modules
-------

The kernel is composed of a large number of modules. These can be found
here:

::

    /lib/modules/<KERNEL_VERSION>/

View all of the loaded modules:

.. code-block:: sh

    $ sudo lsmod

Custom modules can be compiled for a specific kernel and copied in their
respective driver directory. A few common drivers types are "iscsi",
"net/ethernet", "net/wireless", "usb", "pci", "video", etc.

::

    /lib/modules/<KERNEL_VERSION>/kernel/drivers/<DRIVER_TYPE>/

After copying over the necessary \*.ko file(s) for custom modules, load

.. code-block:: sh

    $ sudo depmod <MODULE>

If there are a large number of new modules, it is possible to make sure
all module dependencies are installed.

.. code-block:: sh

    $ sudo depmod --all

Modules can be temporarily loaded:

.. code-block:: sh

    $ sudo modprobe <MODULE>

Or permanently add the module to a file with the extension ".conf" in
the modules load directory.

Files: /etc/modules-load.d/\*.conf

Modules can be deactivated by running one of these two commands:

.. code-block:: sh

    $ sudo rmmod <MODULE>

.. code-block:: sh

    $ sudo modprobe -r <MODULE>

Modules can also be blocked from starting on boot:

File: /etc/modprobe.d/blacklist.conf

::

    blacklist <MODULE>

[3]

Configuration
~~~~~~~~~~~~~

**Options**

View all of the available options for a kernel module [15]:

.. code-block:: sh

   $ modinfo --parameters <KERNEL_MODULE> # Method 1
   $ ls -1 /sys/module/<KERNEL_MODULE>/parameters/ # Method 2

Temporarily set module parameters:

.. code-block:: sh

   $ sudo modprobe -r <KERNEL_MODULE>
   $ sudo modprobe <KERNEL_MODULE> <PARAMETER>=<VALUE>

There are two ways to permanently set options: (1) modprobe configuration or (2) GRUB configuration.

1. modprobe:

   .. code-block:: sh

      $ sudo vim /etc/modprobe.d/<MODPROBE_FILENAME>.conf
      options <KERNEL_MODULE> <PARAMETER>=<VALUE>

2. GRUB:

   .. code-block:: sh

      $ vim /etc/default/grub
      GRUB_CMDLINE_LINUX="<PARAMETER>=<VALUE>"
      $ sudo grub-mkconfig -o /boot/grub/grub.cfg

**Alias**

Create a short and/or memorable alias name for the kernel module:

.. code-block:: sh

   $ sudo vim /etc/modprobe.d/<MODPROBE_FILENAME>.conf
   alias <ALIAS> <KERNEL_MODULE>

[16]

Schedulers
----------

Processor
~~~~~~~~~

The Linux kernel can handling incoming requests differently depending on
the scheduler method. By default, all processes use the Completely Fair
Scheduler (CFS) that tries to handle all incoming tasks equally. It is
only technically possible to change the default scheduler by modifying
the Linux kernel's source code and then recompiling the kernel. [5]
There are 5 different kernel scheduling policies that can be set to
processes manually. These are set by using the ``chrt`` command.

-  SCHED\_BATCH = Batch handles CPU-intensive tasks with real time
   priority.
-  SCHED\_FIFO (first-in first-out) = Handles each task that is
   requested, in order.
-  SCHED\_IDLE = Tasks will only be processed when the processor is
   mostly idle.
-  SCHED\_OTHER (CFS) = All tasks are treated equally and are handled
   with the same amount of priority.
-  SCHED\_RR (round robin) = This is similar to SCHED\_BATCH except that
   tasks are handled for a short amount of time before moving onto a
   different task to handle.

The relevant ``sysctl`` parameters can be adjusted for system-wide
scheduling settings are:

.. code-block:: sh

    $ sudo sysctl -a | grep "sched_"
    kernel.sched_autogroup_enabled = 0
    kernel.sched_cfs_bandwidth_slice_us = 5000
    kernel.sched_child_runs_first = 0
    kernel.sched_latency_ns = 6000000
    kernel.sched_migration_cost_ns = 500000
    kernel.sched_min_granularity_ns = 10000000
    kernel.sched_nr_migrate = 32
    kernel.sched_rr_timeslice_ms = 100
    kernel.sched_rt_period_us = 1000000
    kernel.sched_rt_runtime_us = 950000
    kernel.sched_schedstats = 0
    kernel.sched_shares_window_ns = 10000000
    kernel.sched_time_avg_ms = 1000
    kernel.sched_tunable_scaling = 1
    kernel.sched_wakeup_granularity_ns = 15000000

[4]

I/O
~~~

The kernel provides many input/output (I/O) schedulers to configure how
a hard drive handles a queue of read/write requests from the operating
system. Different schedulers can be used to adjust performance based on
the hardware and/or software requirements.

-  Deadline = Large I/O requests are done in high-priority sectors until
   smaller I/O requests are about to time out. Then Deadline takes care
   of the small tasks before continuing with the original large I/O
   task. This is ideal for heavy read/write applications on a spinning
   disk drive.
-  CFQ (Completely Fair Queueing) = All I/O requests are treated equally
   and are handled in the order that they are received. [6]
-  NOOP (No Operation) = Only basic merging of read and/or write
   requests and no rescheduling. This is ideal for virtual drives (such
   as QCOW2) where the hypervisor node handles the I/O scheduling [7]
   and physical flash based media or RAID cards with write-back cache
   where the hardware's firmware takes care of the sorting. [6]

Temporarily change the scheduler to one of the three options:

.. code-block:: sh

    $ sudo echo {deadline|cfg|noop} > /sys/block/<DEVICE>/queue/scheduler

Permanently change the scheduler by appending the existing
GRUB\_CMDLINE\_LINUX kernel arguments:

.. code-block:: sh

    $ sudo vim /etc/default/grub
    GRUB_CMDLINE_LINUX="elevator={deadline|cfg|noop}"
    $ sudo grub-mkconfig -o /boot/grub/grub.cfg

[7]

Initial RAM File System
-----------------------

The initramfs (initial RAM file system) is used to boot up a system
before loading the full Linux kernel. It is the successor to the initrd
(initial RAM disk). A boot loader, such as GRUB, loads the initramfs
first. This usually contains a minimum copy of the kernel and drivers
required to boot up the system. Once the boot initialization is
complete, the initramfs continues to load all of the available kernel
modules. [8][9]

Arch Linux
~~~~~~~~~~

All modifications of the initramfs in Arch Linux are handled by the
"mkinitcpio" utility.

File: /etc/mkinitcpio.conf

-  MODULES = A list of kernel modules to compile in.
-  FILES = A list of files that should be included in the initramfs.
-  BINARIES = A list of binaries that should be included to use in the
   initramfs environment. This is useful for having more recovery
   utilities. The "mkinitcpio" program will automatically detect the
   binary's dependencies and add them to the initramfs image.
-  HOOKS = Custom hooks for compiling in certain software packages.

   -  Common hooks:

      -  btrfs = BtrFS RAID.
      -  net = Add networking.
      -  mdadm = mdadm software RAID modules.
      -  fsck = FSCK utilities for available operating systems.
      -  encrypt = LUKS encryption modules.
      -  lvm2 = Logical volume manager (LVM) modules.
      -  shutdown = Allows the initramfs to properly shutdown.

Create a new initramfs.

.. code-block:: sh

    $ sudo mkinitcpio

[10]

RHEL
~~~~

On Red Hat Enterprise Linux (RHEL) based operating systems (such as RHEL
itself, CentOS, and Fedora), Dracut is used to manage the initramfs.

File: /etc/dracut.conf

-  add\_drivers+= A list of kernel modules to compile in.
-  install\_items+= A list of files to compile in.
-  add\_dracutmodules+= A list of Dracut modules to compile.

[11]

Install
-------

Debian
~~~~~~

The latest Linux kernels for both Debian and Ubuntu are provided by the Ubuntu project.

-  These are the required DEB packages that need to be downloaded and installed:

    -  linux-headers (all) = The full Linux kernel source code.
    -  linux-headers (generic) = The source code specific to a CPU architecture.
    -  linux-image-unsigned = The Linux kernel image.
    -  linux-modules = Additional/useful Linux kernel modules.

-  Find the desired Linux kernel version from `here <https://kernel.ubuntu.com/~kernel-ppa/mainline/>`__. Set these variables based on the built packages. This example is for Linux ``5.10.0``.

   .. code-block:: sh

      $ export KERNEL_VERSION_SHORT="5.10"
      $ export KERNEL_VERSION_FULL="5.10.0-051000"
      $ export KERNEL_DATE="202012132330"
      $ export KERNEL_ARCHITECTURE="amd64" # Or use "arm64" or "ppc64el".

-  Download the required packages.

   .. code-block:: sh

      $ curl -LO https://kernel.ubuntu.com/~kernel-ppa/mainline/v${KERNEL_VERSION_SHORT}/amd64/linux-image-unsigned-${KERNEL_VERSION_FULL}-generic_${KERNEL_VERSION_FULL}.${KERNEL_DATE}_${KERNEL_ARCHITECTURE}.deb
      $ curl -LO https://kernel.ubuntu.com/~kernel-ppa/mainline/v${KERNEL_VESION_SHORT}/amd64/linux-modules-${KERNEL_VERSION_FULL}-generic_${KERNEL_VERSION_FULL}.${KERNEL_DATE}_${KERNEL_ARCHITECTURE}.deb
      $ curl -LO https://kernel.ubuntu.com/~kernel-ppa/mainline/v${KERNEL_VERSION_SHORT}/amd64/linux-headers-${KERNEL_VERSION_FULL}-generic_${KERNEL_VERSION_FULL}.${KERNEL_DATE}_${KERNEL_ARCHITECTURE}.deb
      $ curl -LO https://kernel.ubuntu.com/~kernel-ppa/mainline/v${KERNEL_VERSION_SHORT}/amd64/linux-headers-${KERNEL_VERSION_FULL}_${KERNEL_VERSION_FULL}.${KERNEL_DATE}_all.deb

-  Install the packages.

   .. code-block:: sh

      $ sudo dpkg -i ./*.deb

[14]

Troubleshooting
---------------

Errors Messages
~~~~~~~~~~~~~~~

**Compiling**

This is a list of common errors and warnings that make occur while building a kernel and how to resolve them.

-  ``.config:<LINE_NUMBER>:warning: symbol value '<SYMBOL_VALUE>' invalid for <CONFIG_OPTION>`` = The symbol (y, n, or m) is invalid. Use a different symbol.
-  ``.config:<LINE_NUMBER>:warning: override: reassigning to symbol <CONFIG_OPTION>`` = A configuration option is listed more than once. Remove the duplicates.

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/administration/linux_kernel.rst>`__
-  `< 2021.10.01 <https://github.com/ekultails/rootpages/commits/master/src/administration/linux.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/linux.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/linux.md>`__

Bibliography
------------

1. "About Linux Kernel." The Linux Kernel Archives. April 23, 2017. Accessed July 9, 2016. https://www.kernel.org/linux.html
2. "UNIX System Calls." University of Miami's Department of Computer Science. August 22, 2016. Accessed July 1, 2017. http://www.cs.miami.edu/home/wuchtys/CSC322-17S/Content/UNIXProgramming/UNIXSystemCalls.shtml
3. "Kernel modules." The Arch Linux Wiki. August 8, 2016. Accessed November 19, 2016. https://wiki.archlinux.org/index.php/Kernel\_modules
4. "Tuning the Task Scheduler." openSUSE Documentation. December 15, 2016. Accessed July 9, 2017. https://doc.opensuse.org/documentation/leap/tuning/html/book.sle.tuning/cha.tuning.taskscheduler.html
5. "Change Linux CPU default scheduler." A else B. January 6, 2016. Accessed July 9, 2017. https://aelseb.wordpress.com/2016/01/06/change-linux-cpu-default-scheduler/
6. Linux System Programming. (Love: O'Reilly Media, Inc., 2007).
7. "What is the suggested I/O scheduler to improve disk performance when using Red Hat Enterprise Linux with virtualization?" Red Hat Knowledgebase. December 16, 2016. Accessed December 18, 2016. https://access.redhat.com/solutions/5427
8. 'The Kernel Newbie Corner: "initrd" and "initramfs"--What's Up With That?' Linux.com September 30, 2009. Accessed November 19, 2016. https://www.linux.com/learn/kernel-newbie-corner-initrd-and-initramfs-whats
9. "ramfs, rootfs and initramfs." The Linux Kernel Documentation. May 29, 2015. Accessed November 19, 2016. https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt
10. "mkinitcpio." The Arch Linux Wiki. November 13, 2016. Accessed November 19, 2016. https://wiki.archlinux.org/index.php/mkinitcpio
11. "Dracut." The Linux Kernel Archives. October, 2013. Accessed November 19, 2016. https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
12. "Which Linux Kernel Version Is 'Stable'?" Linux.com. February 3, 2018. Accessed September 25, 2018. https://www.linux.com/blog/learn/2018/2/which-linux-kernel-version-stable
13. "Linux Kernel 5.0 to Be Released When We Hit 6M Git Objects, Says Linus Torvalds." Softpedia News. October 9, 2016. Accessed September 25, 2018. https://news.softpedia.com/news/linux-kernel-5-0-to-be-released-when-we-hit-6m-git-objects-says-linus-torvalds-509108.shtml
14. "How to install Linux 5.8 Kernel on Ubuntu 20.04 LTS." Linux Shout. August 5, 2020. Accessed December 13, 2020. https://www.how2shout.com/linux/install-linux-5-8-kernel-on-ubuntu-20-04-lts/
15. "How can I know/list available options for kernel modules?" Ask Ubuntu. December 13, 2017. Accessed January 21, 2021. https://askubuntu.com/questions/59135/how-can-i-know-list-available-options-for-kernel-modules
16. "Kernel module." Arch Wiki. October 14, 2020. Accessed January 21, 2021. https://wiki.archlinux.org/index.php/Kernel_module
