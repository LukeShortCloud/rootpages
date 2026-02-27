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

-  linux-next = Daily unstable development releases from the "master" git branch.

   -  ``https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git``

-  mainline = The latest development release candidate that is working towards a stable release.

   -  ``https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git``

-  stable = The current stable release.

   -  ``https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git``

-  longterm = Long-term supported kernels are older versions that primarily only receive bug fixes. The source code for these can be found in the "stable" repository under the branch names "``linux-<MAJOR_VERSION>-<MINOR_VERSION>.y``".

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

Capabilities
------------

The ``root`` user with the user ID of ``0`` has access to all capabilities exposed by the Linux kernel. All other users are considered unprivileged and do not have access to any of the capabilities. Each capability allows certain system calls and other specific actions. Unprivileged users can be run binaries that a ``root`` user enables specific privileged capabilities on.

Common capabilities in the Linux kernel:

.. csv-table::
   :header: Capability, Description, System Calls
   :widths: 20, 20, 20

   CAP_CHOWN, Change ownership of files and directories., chown
   CAP_KILL, Kill any process., "ioctl, kill"
   CAP_NET_ADMIN, Access to all networking functions., "setsockopt"
   CAP_NET_BIND_SERVICE, Bind to a port below 1024., "(None)"
   CAP_SYS_ADMIN, Provide a process most of the  privileged capabilities., "accept, bdflush, clone, execve, fanotify_init, ioctl, ioprio_set, keyctl, lookup_dcookie, madvise, mount, nfsservctl, open, pipe, pivot_root, ptrace, quotactl, random, sched, seccomp, setdomainname, sethostname, setns, swapoff, swapon, syslog, umount, unshare, xattr"
   CAP_SYS_CHROOT, Change the root directory and namespace., "chroot, nets"
   CAP_SYS_NICE, Change the priority of a process., "ioprio_set, mbind, migrate_pages, move_pages, nice, sched_setattr, sched_setparam, sched_setscheduler, setpriority"
   CAP_SYS_RESOURCE, Change resource limits and quotas., "fcntl, ioctl, mq_overview, msgop, msgctl, prctl, setrlimit, unix"
   CAP_SYS_TIME, Change the system time., "adjtimex, settimeofday, stime"

[17]

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

The Linux kernel handles incoming requests differently depending on the CPU scheduler. The CPU scheduler is determined at compile time for the kernel and cannot be changed later. [5][32] For compiling with different CPU schedulers, use `linux-tkg <https://github.com/Frogging-Family/linux-tkg>`__. [32] The current CPU scheduler is EEVDF [35] which provides lower latency than CFS. [36]

.. csv-table::
   :header: Scheduler, First Linux Kernel Release
   :widths: 20, 20

   EEVDF, 6.6
   CFS, 2.6.23
   O(1), 2.6.0
   O(N), 2.4
   Symmetric Multiprocessing (SMP), 2.2
   Round-Robin Scheduler, 1.2

[33][34]

`Unofficial <https://github.com/Frogging-Family/linux-tkg/blob/843725ec7c3559e05b713f48f0a9a97a82b668e5/.github/workflows/build-release-kernels.yml#L47>`_ CPU schedulers [32]:

-  bmq
-  bore
-  pds

There are 6 different kernel scheduling classes/policies that can be set to processes manually. These are set by using the ``chrt`` command.

Policies [38][39]:

-  SCHED\_BATCH = Batch handles CPU-intensive tasks with real time priority.
-  SCHED\_DEADLINE = Available since Linux 3.14. [37] Prioritize processes based on what needs to be completed first based on the values of deadline, period, and runtime.
-  SCHED\_FIFO (first-in first-out) = Handles each task that is requested, in order.
-  SCHED\_IDLE = Tasks will only be processed when the processor is mostly idle.
-  SCHED\_OTHER (CFS) = All tasks are treated equally and are handled with the same amount of priority.
-  SCHED\_RR (round robin) = This is similar to SCHED\_BATCH except that tasks are handled for a short amount of time before moving onto a different task to handle.

The relevant ``sysctl`` parameters can be adjusted for system-wide scheduling settings can be found by running:

.. code-block:: sh

    $ sudo sysctl -a | grep "sched_"

[4]

I/O
~~~

The kernel provides many input/output (I/O) schedulers to configure how a hard drive handles a queue of read/write requests from the operating system. Different schedulers can be used to adjust performance based on the hardware and/or software requirements. There are two types of scheulers:

-  Non-multiqueue = Legacy. These are single-threaded. Deprecated since Linux 5.3.
-  Multiqueue = Modern. These are multi-threaded.

**Non-multiqueue Schedulers:**

-  cfq = Completely Fair Queueing. All I/O requests are treated equally and are handled in the order that they are received. [6]

   -  Usage: MMC and SD cards. [28]
   -  This is the only non-multiqueue scheduler that ``ionice`` works with to change the I/O priority. [25]

-  deadline = Large I/O requests are done in high-priority sectors until smaller I/O requests are about to time out. Then Deadline takes care of the small tasks before continuing with the original large I/O task.

   -  Usage: spinning hard disk drive with heavy I/O operations.

-  noop = No Operation. Only basic merging of read and/or write requests and no rescheduling.

   -  Usage: virtual drives (such as QCOW2) where the hypervisor node handles the I/O scheduling [7], SSDs, or RAID cards with write-back cache where the firmware of the hardware takes care of the sorting. [6]

**Multiqueue Schedulers:**

-  bfq = Budget Fair Queuing. The multiqueue equivalent for CFQ.

   -  This is the only multiqueue scheduler that ``ionice`` works with to change the I/O priority. [27]

-  kyber = A small scheduler that uses minimal logic to provide higher throughput and lower latency. [29]
-  mq-deadline = The multiqueue equivalent for Deadline.
-  none = The multiqueue equivalent for NOOP.

[30][31]

Temporarily change the scheduler to one of the three options:

.. code-block:: sh

    $ sudo echo [bfq|kyber|mq-deadline|none] > /sys/block/<DEVICE>/queue/scheduler

Permanently change the scheduler by appending the existing GRUB\_CMDLINE\_LINUX kernel arguments:

.. code-block:: sh

    $ sudo vim /etc/default/grub
    GRUB_CMDLINE_LINUX="elevator=<IO_SCHEDULER>"
    $ sudo grub-mkconfig -o /boot/grub/grub.cfg

[7]

Priority
^^^^^^^^

When using the BFQ or CFQ scheduler, the ``ionice`` command can be used to set different priorities for running processes. Typical usage of the command is to run ``ionice -c <IONICE_CLASS> -n <PRIORITY> -p <PID>``.

Classes:

-  0 = None. On modern Linux, this is the same as 2 (best-effort).
-  1 = Realtime. Use the I/O immediately.
-  2 = Best-effort. This is the default if no class is provided. Use a round-robin algorithm.
-  3 = Idle. Wait for the I/O usage to be low.

Priority:

-  0 = Highest.
-  7 = Lowest.

Give a running process the highest I/O priority:

.. code-block:: sh

   $ ionice -c 1 -n 0 <PID>

Give a running process the lowest I/O priority:

.. code-block:: sh

   $ ionice -c 3 -n 7 <PID>

[25][26]

Memory
------

Memory Caching
~~~~~~~~~~~~~~

Use a configuration file at ``/etc/sysctl.d/*.conf`` for permanent settings or run ``sysctl -w <KEY>=<VALUE>`` for temporary settings.

Default values relating to memory caching [40]:

.. code-block:: ini

   # The minimum percentage of RAM used for caching writes before they should be written to the storage device.
   vm.dirty_background_ratio = 10
   # The percentage of RAM to use for caching writes.
   vm.dirty_ratio = 20
   # The maximum time before writing a file to the storage device.
   vm.dirty_expire_centisecs = 3000
   # The minimum time before writing a file to the storage device.
   vm.dirty_writeback_centisecs = 500
   # Determines how quickly vm.dirty_background_ratio writes need to be written back to the storage device.
   vm.vfs_cache_pressure = 100

``vm.dirty_background_ratio`` should be anywhere from 1/4 to 1/2 of ``vm.dirty_ratio`` for optimal performance.

Decrease the amount of memory caching / increase the amount of file writes. [41]

.. code-block:: ini

   vm.dirty_background_ratio = 5
   vm.dirty_ratio = 10

Increase the amount of memory caching / decrease the amount of file writes. [42]

.. code-block:: ini

   vm.dirty_background_ratio = 40
   vm.dirty_ratio = 80

For slow drives only, 50 is the recommended cache pressure to delay writes until the RAM starts to get more full. [43][44]

.. code-block:: ini

   vm.vfs_cache_pressure = 50

Delay writes to the drive by 1 hour or forever. Writes will get flushed to the disk when a ``sync`` or ``shutdown`` command is received. This is not recommended because a power outage will result in lost data. [45][46]

.. code-block:: ini

   vm.dirty_expire_centisecs = 360000
   vm.dirty_writeback_centisecs = 360000

.. code-block:: ini

   vm.dirty_expire_centisecs = 0
   vm.dirty_writeback_centisecs = 0

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

Build
-----

Mailing List Patches
~~~~~~~~~~~~~~~~~~~~

All upstream patches must go through review on the Linux kernel mailing list (LKML) by e-mailing ``linux-kernel@vger.kernel.org``. [49]

Download git commits from the mailing list:

1.  Search for a patch series: https://lore.kernel.org/lkml/
2.  Find the "Message-ID" (within the ``<`` and ``>`` characters).

   -  If it is not on that page, select the "raw" button to see it.

3.  Download the entire e-mail thread as a single "mbx" text file.

   .. code-block:: sh

      $ b4 am <MESSAGE_ID>

4.  Import all of the git commits from a ``linux`` git repository. [50]

   .. code-block:: sh

      $ git am ./*.mbx

Configure Features
~~~~~~~~~~~~~~~~~~

Enable any of the following features using the following ``.config`` options.

The two must common Mandatory Access Control (MAC) systems for Linux are AppArmor and SELinux. Using both is not supported.

   -  AppArmor [47]:

      ::

         CONFIG_SECURITY_APPARMOR=y
         CONFIG_DEFAULT_SECURITY="apparmor"
         CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
         # CONFIG_SECURITY_APPARMOR_DEBUG is not set
         CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
         CONFIG_SECURITY_APPARMOR_HASH=y
         CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
         CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
         CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
         # CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
         CONFIG_DEFAULT_SECURITY_APPARMOR=y
         CONFIG_LSM="lockdown,yama,integrity,apparmor,bpf,landlock"

   -  SELinux [48]:

      ::

         # CONFIG_SECURITY_APPARMOR is not set
         CONFIG_DEFAULT_SECURITY_SELINUX=y
         CONFIG_LSM="landlock,lockdown,yama,integrity,selinux,bpf"
         CONFIG_SECURITY_SELINUX_AVC_STATS=y
         CONFIG_SECURITY_SELINUX_BOOTPARAM=y
         CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
         # CONFIG_SECURITY_SELINUX_DEBUG is not set
         CONFIG_SECURITY_SELINUX_DEVELOP=y
         # CONFIG_SECURITY_SELINUX_DISABLE is not set
         CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
         CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
         CONFIG_SECURITY_SELINUX=y

Upstream
~~~~~~~~

-  Install the build dependencies for the Linux kernel:

   -  Debian:

      .. code-block:: sh

         $ sudo apt-get install bc build-essential cpio dwarves findutils flex git kmod libelf-dev libncurses5-dev libssl-dev linux-source rsync

   -  Fedora:

      .. code-block:: sh

         $ sudo dnf install bc bison diffutils dwarves elfutils-devel elfutils-libelf-devel findutils flex git gcc make openssl openssl-devel perl rpm-build rsync

-  Download the Linux kernel source code:

   -  Using the newest kernel tarball from here: https://www.kernel.org/
   -  Or using any kernel version tarball from here: https://www.kernel.org/pub/linux/kernel/
   -  Or from the stable kernel git repository:

      -  Using a specific version tag:

         .. code-block:: sh

            $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ --depth=1 --branch v<VERSION_MAJOR>.<VERSION_MINOR>.<VERSION_PATCH>

      -  Using a specific version branch:

         .. code-block:: sh

            $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ --depth=1 --branch linux-<VERSION_MAJOR>.<VERSION_MINOR>.y

      -  Or all history from the git repository where you can select any version after downloading (this will take a long time):

         .. code-block:: sh

            $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
            $ cd linux
            $ git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
            $ git fetch stable
            $ git remote add next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
            $ git fetch next

-  Add the kernel headers to the system to help with building DKMS modules in the future. The "linux" folder will need to later be renamed to reflect the output of ``uname -r`` of the installed kernel.

   -  Arch Linux:

      .. code-block:: sh

         $ sudo cp -r ./linux* /usr/lib/modules/

   -  Debian:

      .. code-block:: sh

         $ sudo cp -r ./linux* /usr/src/

   -  Fedora:

      .. code-block:: sh

         $ sudo cp -r ./linux* /usr/src/kernels/

-  Create the ``.config`` file in the top-level of the kernel directory. It defines what features will be built for the Linux kernel.

   -  Use a default configuration:

      .. code-block:: sh

         $ cd ./linux/
         $ make defconfig

   -  Or use a configuration as a base and then accept the defaults:

      .. code-block:: sh

         $ cd ./linux/
         $ cp arch/<CPU_ARCHITECTURE>/configs/<CONFIG>.config .config
         $ make olddefconfig

   -  Or merge two configurations together. If an option is configured in both files, then the option from ``<CONFIG_2>`` is applied. If an option is undefined in ``<CONFIG_2>``, then the option from ``<CONFIG_1>`` is applied.

      .. code-block:: sh

         $ cd ./linux/
         $ ./scripts/kconfig/merge_config.sh <CONFIG_1> <CONFIG_2>
         $ make olddefconfig

-  Build the Linux kernel:

   -  Generic:

      .. code-block:: sh

         $ make -j $(nproc)

   -  DEB (Debian) packages:

      .. code-block:: sh

         $ make -j $(nproc) bindeb-pkg

   -  RPM (Fedora) packages:

      .. code-block:: sh

         $ sudo dnf install dnf5-plugins
         $ sudo dnf builddep ./scripts/package/kernel.spec
         $ make -j $(nproc) binrpm-pkg

-  Install the Linux kernel:

   -  Generic:

      .. code-block:: sh

         $ sudo make install
         $ sudo make modules_install

   -  DEB (Debian) packages:

      .. code-block:: sh

         $ sudo dpkg -i ../linux-*.deb

   -  RPM (Fedora) packages:

      .. code-block:: sh

         $ sudo rpm -iU ./rpmbuild/RPMS/<CPU_ARCHITECTURE>/kernel-*.rpm

[18][19]

Fedora
~~~~~~

-  Install the required packages to build Fedora packages:

   .. code-block:: sh

      $ sudo dnf install fedora-packager fedpkg git grubby ncurses-devel pesign rpmdevtools

-  Download the Fedora package for the Linux kernel. This first requires increasing the git buffer size or else the download of the large git repository will fail.

   .. code-block:: sh

      $ git config --global http.postBuffer 157286400
      $ fedpkg clone -a kernel
      $ cd kernel

-  Switch to the desired branch to build.

   .. code-block:: sh

      $ git checkout origin/f<FEDORA_MAJOR_VERSION>

-  Install the build dependencies of the Linux kernel and the source files needed for building the RPMs.

   .. code-block:: sh

      $ sudo dnf install dnf5-plugins
      $ sudo dnf builddep kernel.spec
      $ fedpkg sources

-  If the ``sources`` file does not exist, use ``rpmbuild -bs kernel.spec`` to see what source files are missing. Then manually search for and download them from ``https://src.fedoraproject.org/repo/pkgs/rpms/kernel/``. Copy them to ``~/rpmbuild/SOURCES/``.
-  Fix the PKI signing keys permissions which are required for the Linux kernel.

   .. code-block:: sh

      $ sudo /usr/libexec/pesign/pesign-authorize

-  Change the build name to something other than the default of "local". This prevents conflicts with other kernels built with the default options. In the example below, it is changed to "custom". [20]

   .. code-block:: sh

      $ sed -i 's/# define buildid .local/%define buildid .custom/g' kernel.spec

-  Build the kernel.

   -  RPM

      -  Build and package a release kernel as RPMs using Mock to isolate dependencies. By default, kernels are built with debugging support which are slower and bigger. They are named ``kernel-debug-<VERSION>.rpm``. [23] This can be disabled. [21][22] If the user doing the build is not in the ``mock`` group, the ``fedpkg`` command will manually prompt the user to enter the ``root`` password.

         .. code-block:: sh

            $ sudo usermod -a -G mock ${USER}
            $ fedpkg --release f<FEDORA_MAJOR_VERSION> mockbuild --without debug --without debuginfo --with release --with headers

      -  The resulting RPMs will be saved to: ``$(pwd)/results_kernel/<KERNEL_FULL_VERSION>/<RPM_RELEASE>.<RPM_LOCAL_NAME>.fc<FEDORA_MAJOR_VERSION>``.  For example, the directory should look similar to this:

         .. code-block:: sh

            $ ls -1 results_kernel/6.3.13/200.custom.fc38/
            build.log
            hw_info.log
            installed_pkgs.log
            kernel-6.3.13-200.custom.fc38.src.rpm
            kernel-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-core-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-devel-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-devel-matched-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-headers-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-modules-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-modules-core-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-modules-extra-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-modules-internal-6.3.13-200.custom.fc38.x86_64.rpm
            kernel-uki-virt-6.3.13-200.custom.fc38.x86_64.rpm
            root.log
            state.log

   -  SRPM

      -  Build a source RPM package with the sources for the release kernel. This is normally configured via RPM build configurations (BCONF) statements such as ``--with`` and ``--without`` [24] but it is not possible to create a SRPM with those pre-defined. Fedora Copr also does not support changing these values. Instead, manually modify the ``kernel.spec`` file.

         .. code-block:: sh

            $ sed -i s'/%define with_debug     %{?_without_debug:     0} %{?!_without_debug:     1}/%define with_debug 0/'g kernel.spec
            $ sed -i s'/%define with_debuginfo %{?_without_debuginfo: 0} %{?!_without_debuginfo: 1}/%define with_debuginfo 0/'g kernel.spec
            $ sed -i s'/%define with_headers   %{?_without_headers:   0} %{?!_without_headers:   1}/%define with_headers 1/'g kernel.spec
            $ sed -i s'/with_headers 0/with_headers 1/'g kernel.spec
            $ sed -i s'/%define with_release   %{?_with_release:      1} %{?!_with_release:      0}/%define with_release 1/'g kernel.spec
            $ sed -i s'/%define with_selftests %{?_without_selftests: 0} %{?!_without_selftests: 1}/%define with_selftests 0/'g kernel.spec
            $ fedpkg --release f38 srpm

      -  The resulting SRPM will be saved to the current working directory.

         .. code-block:: sh

            $ ls -1 | grep src.rpm
            kernel-6.3.13-200.custom.fc38.src.rpm

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

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/linux_kernel.rst>`__
-  `< 2021.10.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/linux.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/linux.md>`__

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
17. "capabilities (7)." Linux manual page. June 20, 2021. Accessed August 2, 2021. https://man7.org/linux/man-pages/man7/capabilities.7.html
18. "BuildADebianKernelPackage." Debian Wiki. December 1, 2021. Accessed January 10, 2022. https://wiki.debian.org/BuildADebianKernelPackage
19. "How to compile vanilla Linux kernel from source on Fedora." LinuxConfig.org. May 30, 2019. Accessed January 10, 2022. https://linuxconfig.org/how-to-compile-vanilla-linux-kernel-from-source-on-fedora
20. "Building a custom kernel." Fedora Project Wiki. August 16, 2022. Accessed July 19, 2023. https://fedoraproject.org/wiki/Building_a_custom_kernel
21. "Build a fedora kernel: Updated." ASUS NoteBook Linux. Accessed July 19, 2023. https://asus-linux.org/blog/fedora-kernel-build/
22. "Has anyone managed to build a Fedora patched kernel in 2022?" Reddit r/Fedora. December 12, 2022. Accessed July 19, 2023. https://www.reddit.com/r/Fedora/comments/zgdkrc/has_anyone_managed_to_build_a_fedora_patched/
23. "KernelDebugStrategy." Fedora Project Wiki. August 11, 2016. Accessed July 28, 2023. https://fedoraproject.org/wiki/KernelDebugStrategy
24. "Conditional Builds." RPM Package Manager. Accessed July 30, 2023. https://rpm-software-management.github.io/rpm/manual/conditionalbuilds.html
25. "Block io priorities." The Linux Kernel documentation. March 11, 2005. Accessed August 13, 2023. https://docs.kernel.org/block/ioprio.html
26. "Linux Tips: nice and ionice." Tiger Computing. June 12, 2018. Accessed August 13, 2023. https://www.tiger-computing.co.uk/linux-tips-nice-and-ionice/
27. "Tuning I/O performance." System Analysis and Tuning Guide. Accessed August 23, 2023. https://doc.opensuse.org/documentation/leap/tuning/html/book-tuning/cha-tuning-io.html
28. "Linux 6.3 Now Suggests The BFQ I/O Scheduler When Building MMC/SD Support." Phoronix. March 1, 2023. Accessed August 13, 2023. https://www.phoronix.com/news/Linux-6.3-MMC-BFQ-Suggests
29. "Two new block I/O schedulers for 4.12." LWN.net April 24, 2017. Accessed August 13, 2023. https://lwn.net/Articles/720675/
30. "Noop now named none." SUSE Communities. November 29, 2019. Accessed August 13, 2023. https://www.suse.com/c/noop-now-named-none/
31. "IOSchedulers." Ubuntu Wiki. September 10, 2019. Accessed August 13, 2023. https://wiki.ubuntu.com/Kernel/Reference/IOSchedulers
32. "How can I change the CPU scheduler?" Reddit r/archlinux. January 31, 2023. Accessed January 16, 2023. https://www.reddit.com/r/archlinux/comments/g2re6r/how_can_i_change_the_cpu_scheduler/
33. "Inside the Linux 2.6 Completely Fair Scheduler." IBM Developer. September 19, 2018. Accessed January 30, 2024. https://developer.ibm.com/tutorials/l-completely-fair-scheduler/
34. "A brief history of the Linux Kernel's process scheduler: The very first scheduler, v0.01." DEV Community Satoru Takeuchi. December 3, 2019. Accessed January 30, 2024. https://dev.to/satorutakeuchi/a-brief-history-of-the-linux-kernel-s-process-scheduler-the-very-first-scheduler-v0-01-9e4
35. "EEVDF Scheduler Merged For Linux 6.6, Intel Hybrid Cluster Scheduling Re-Introduced." Phoronix. August 29, 2023. Accessed January 30, 2024. https://www.phoronix.com/news/Linux-6.6-EEVDF-Merged
36. "Updated EEVDF Linux CPU Scheduler Patches Posted That Plan To Replace CFS." Phoronix. June 1, 2023. Accessed January 30, 2024. https://www.phoronix.com/news/EEVDF-Scheduler-Linux-EO-May
37. "Deadline scheduler merged for 3.14." January 22, 2014. Accessed January 30, 2024. https://lwn.net/Articles/581491/
38. "Chapter 5. Priorities and policies." Red Hat Customer Portal. Accessed January 30, 2024. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_for_real_time/8/html/reference_guide/chap-priorities_and_policies
39. "chrt command in Linux with examples." GeeksforGeeks. May 15, 2019. Accessed January 30, 2024. https://www.geeksforgeeks.org/chrt-command-in-linux-with-examples/
40. "Documentation for /proc/sys/vm/* kernel version 2.6.29." Linux Kernel Documentation. 2008. Accessed May 3, 2025.  https://www.kernel.org/doc/Documentation/sysctl/vm.txt
41. "Low write performance on Linux servers with large RAM." SUSE Support. April 20, 2023. Accessed May 3, 2025. https://www.suse.com/support/kb/doc/?id=000017857
42. "Better Linux Disk Caching & Performance with vm.dirty_ratio & vm.dirty_background_ratio." The Lone Sysadmin. December 22, 2013. Accessed May 3, 2025. https://lonesysadmin.net/2013/12/22/better-linux-disk-caching-performance-vm-dirty_ratio/
43. "Speed up your Mint!" easylinuxtipsproject. March 21, 2015. Accessed May 3, 2025. https://web.archive.org/web/20150321012336/https://sites.google.com/site/easylinuxtipsproject/3
44. "Linux simple performance tweaks." GitHub Nihhaar/linux_performance.md. September 18, 2017. Accessed May 3, 2025. https://gist.github.com/Nihhaar/ca550c221f3c87459ab383408a9c3928
45. "Using RAM Cache to Speed Up Linux Disk Performance." Medium Andre Rocha. April 5, 2022. Accessed May 3, 2025. https://andrerochaos.medium.com/using-ram-cache-to-speed-up-linux-disk-performance-e6d568d486c4
46. "Optimizing Ubuntu to run from a USB key or SD card." Steve Hanov's Blog. 2009. Accessed May 3, 2025. https://stevehanov.ca/blog/?id=48
47. "Files b27d68a rpm-sources/baseos/kernel/6.14/config." GitHub Nobara-Project/rpm-sources. May 18, 2025. Accessed June 18, 2025. https://github.com/Nobara-Project/rpm-sources/blob/b27d68abdd1864a712d5401b67dc9fee18ed3344/baseos/kernel/6.14/config
48. "Files f42/kernel-x86_64.config." Fedora Package Sources rpm/kernel. May 18, 2025. Accessed June 16, 2025. https://src.fedoraproject.org/rpms/kernel/blob/f42/f/kernel-x86_64-fedora.config
49. "vger.kernel.org." Subspace mailing list server. 2023. Accessed January 19, 2026. https://subspace.kernel.org/vger.kernel.org.html
50. "am,shazam: retrieving and applying patches." B4 end-user docs. 2022. Accessed January 19, 2026. https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html
