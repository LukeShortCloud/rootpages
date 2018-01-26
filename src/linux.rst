Linux
=====

.. contents:: Table of Contents

Linux is a kernel designed to be similar to the original UNIX kernel. It
is a modern, free, and open source alternative that was originally
created by Linus Torvalds. It is built to work on many processor
architectures. "Linux" is sometimes used to generally describe the many
operating systems that use the Linux kernel. [1] In the context of this
Root Pages guide, the focus is on the actual kernel.

Source:

1. "About Linux Kernel." The Linux Kernel Archives. April 23, 2017.
   Accessed July 9, 2016. https://www.kernel.org/linux.html

System Calls
------------

Programs use system calls to interact with the kernel to do tasks.

Common system calls:

+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| Call        | Type                 | Description                                                                                                       |
+=============+======================+===================================================================================================================+
| accept      | Network              | Accept an incoming network connection.                                                                            |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| bind        | Network              | Associate a network socket to a specific IP address.                                                              |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| chdir       | Process              | Change to a different working directory.                                                                          |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| chmod       | File                 | Change the mode permissions.                                                                                      |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| chown       | File                 | Change the owner permissions.                                                                                     |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| chroot      | Process              | Change the working root directory.                                                                                |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| close       | File                 | Close a file.                                                                                                     |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| connect     | Network              | Make an external network connection.                                                                              |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| exec        | Process              | Execute/start a program.                                                                                          |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| exit        | Process              | End a process.                                                                                                    |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| fork        | Process              | Spawn a new process.                                                                                              |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| getgid      | Process              | Find the group ID.                                                                                                |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| getuid      | Process              | Find the user ID.                                                                                                 |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| kill        | Process              | Send a signal to a process.                                                                                       |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| link        | File                 | Create a shortcut that mirrors an existing inode (a hard link).                                                   |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| mkdir       | File                 | Create a directory.                                                                                               |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| mknod       | File                 | Create a file.                                                                                                    |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| mount       | File                 | Mount a file system onto a directory.                                                                             |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| nice        | Process              | Modify the priority of a process.                                                                                 |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| open        | File                 | Open a file.                                                                                                      |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| pause       | Process              | Temporarily stop a process from running until a signal is given to continue.                                      |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| pipe        | Process              | Stream output data from one process to another.                                                                   |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| read        | File                 | Read data..                                                                                                       |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| setgid      | Process              | Change a process' group ID.                                                                                       |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| setpriority | Process              | Change a process' kernel scheduling priority.                                                                     |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| setuid      | Process              | Change a process' user ID.                                                                                        |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| socket      | File/Network/Process | Create a socket that can listen for requests. This can be a UNIX file socket, network port, or a special process. |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| symlink     | File                 | Create a shortcut that redirects to another file (a symbolic link).                                               |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| sync        | File                 | Flush data from memory to the disk.                                                                               |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| stat        | File                 | View a file's metadata.                                                                                           |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| time        | Process              | A count of seconds since 1970-01-01.                                                                              |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| ulimit      | Process              | View and modify user process limits                                                                               |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| unlink      | File                 | Delete a directory.                                                                                               |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| umask       | File                 | View and modify the default permissions of files and directories.                                                 |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| wait        | Process              | Wait for a child process to end.                                                                                  |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+
| write       | File                 | Write data.                                                                                                       |
+-------------+----------------------+-------------------------------------------------------------------------------------------------------------------+

[1]

Source:

1. "UNIX System Calls." University of Miami's Department of Computer
   Science. August 22, 2016. Accessed July 1, 2017.
   http://www.cs.miami.edu/home/wuchtys/CSC322-17S/Content/UNIXProgramming/UNIXSystemCalls.shtml

Modules
-------

The kernel is composed of a large number of modules. These can be found
here:

::

    /lib/modules/<KERNEL_VERSION>/

View all of the loaded modules:

::

    # lsmod

Custom modules can be compiled for a specific kernel and copied in their
respective driver directory. A few common drivers types are "iscsi",
"net/ethernet", "net/wireless", "usb", "pci", "video", etc.

::

    /lib/modules/<KERNEL_VERSION>/kernel/drivers/<DRIVER_TYPE>/

After copying over the necessary \*.ko file(s) for custom modules, load

::

    # depmod <MODULE>

If there are a large number of new modules, it is possible to make sure
all module dependencies are installed.

::

    # depmod --all

Modules can be temporarily loaded:

::

    # modprobe <MODULE>

Or permanently add the module to a file with the extension ".conf" in
the modules load directory.

::

    /etc/modules-load.d/*.conf

Modules can be deactivated by running one of these two commands:

::

    # rmmod <MODULE>

::

    # modprobe -r <MODULE>

Modules can also be blocked from starting on boot:

::

    /etc/modprobe.d/blacklist.conf

::

    blacklist <MODULE>

[1]

Source:

1. "Kernel modules." The Arch Linux Wiki. August 8, 2016. Accessed
   November 19, 2016.
   https://wiki.archlinux.org/index.php/Kernel\_modules

Schedulers
----------

Processor
~~~~~~~~~

The Linux kernel can handling incoming requests differently depending on
the scheduler method. By default, all processes use the Completely Fair
Scheduler (CFS) that tries to handle all incoming tasks equally. It is
only technically possible to change the default scheduler by modifying
the Linux kernel's source code and then recompiling the kernel. [2]
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

::

    # sysctl -a | grep "sched_"
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

[1]

Sources:

1. "Tuning the Task Scheduler." openSUSE Documentation. December 15,
   2016. Accessed July 9, 2017.
   https://doc.opensuse.org/documentation/leap/tuning/html/book.sle.tuning/cha.tuning.taskscheduler.html
2. "Change Linux CPU default scheduler." A else B. January 6, 2016.
   Accessed July 9, 2017.
   https://aelseb.wordpress.com/2016/01/06/change-linux-cpu-default-scheduler/

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
   and are handled in the order that they are received. [1]
-  NOOP (No Operation) = Only basic merging of read and/or write
   requests and no rescheduling. This is ideal for virtual drives (such
   as QCOW2) where the hypervisor node handles the I/O scheduling [2]
   and physical flash based media or RAID cards with write-back cache
   where the hardware's firmware takes care of the sorting. [1]

Temporarily change the scheduler to one of the three options:

::

    # echo {deadline|cfg|noop} > /sys/block/<DEVICE>/queue/scheduler

Permanently change the scheduler by appending the existing
GRUB\_CMDLINE\_LINUX kernel arguments:

::

    # vim /etc/default/grub
    GRUB_CMDLINE_LINUX="elevator={deadline|cfg|noop}"
    # grub-mkconfig -o /boot/grub/grub.cfg

[2]

Sources:

1. Linux System Programming. (Love: O’Reilly Media, Inc., 2007).
2. "What is the suggested I/O scheduler to improve disk performance when
   using Red Hat Enterprise Linux with virtualization?" Red Hat
   Knowledgebase. December 16, 2016. Accessed December 18, 2016.
   https://access.redhat.com/solutions/5427

Initial RAM File System
-----------------------

The initramfs (initial RAM file system) is used to boot up a system
before loading the full Linux kernel. It is the successor to the initrd
(initial RAM disk). A boot loader, such as GRUB, loads the initramfs
first. This usually contains a minimum copy of the kernel and drivers
required to boot up the system. Once the boot initialization is
complete, the initramfs continues to load all of the available kernel
modules. [1][2]

Sources:

1. 'The Kernel Newbie Corner: "initrd" and "initramfs"--What's Up With
   That?' Linux.com September 30, 2009. Accessed November 19, 2016.
   https://www.linux.com/learn/kernel-newbie-corner-initrd-and-initramfs-whats
2. "ramfs, rootfs and initramfs." The Linux Kernel Documentation. May
   29, 2015. Accessed November 19, 2016.
   https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

Arch Linux
~~~~~~~~~~

All modifications of the initramfs in Arch Linux are handled by the
"mkinitcpio" utility.

::

    /etc/mkinitcpio.conf

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
      -  encrypt = LUKS encyrption modules.
      -  lvm2 = Logical volume manager (LVM) modules.
      -  shutdown = Allows the initramfs to properly shutdown.

Create a new initramfs.

::

    # mkinitcpio

[1]

Source:

1. "mkinitcpio." The Arch Linux Wiki. November 13, 2016. Accessed
   November 19, 2016. https://wiki.archlinux.org/index.php/mkinitcpio

RHEL
~~~~

On Red Hat Enterprise Linux (RHEL) based operating systems (such as RHEL
itself, CentOS, and Fedora), Dracut is used to manage the initramfs.

::

    /etc/dracut.conf

-  add\_drivers+= A list of kernel modules to compile in.
-  install\_items+= A list of files to compile in.
-  add\_dracutmodules+= A list of Dracut modules to compile.

[1]

Source:

1. "Dracut." The Linux Kernel Archives. October, 2013. Accessed November
   19, 2016.
   https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
