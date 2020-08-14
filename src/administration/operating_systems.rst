Operating Systems
=================

.. contents:: Table of Contents

The Linux kernel is used in many different operating systems. These are commonly referred to as "distributions." Major distributions sometimes have "derivative" operating systems that are created using the major distribution as a base.

Arch Linux
----------

Arch Linux is a 64-bit operating system whose motto is "Keep it Simple." There is no graphical installer and the end-user is expected to manually configure their own system to their liking. Unlike Gentoo, compiled system packages are provided. Very detailed documentation about the operating system is provided in the official Arch Linux Wiki: https://wiki.archlinux.org/. [1]

- Life Cycle:
   - `Rolling Release <https://wiki.archlinux.org/index.php/Arch_Linux>`__

- Package Format:
    - Tape archive, LZMA2 compressed (tar.xz)

- Package Manager:
    - Pacman (CLI)

- Popular derivatives [2]:
    - Antergos
    - ArchLabs
    - Manjaro

Debian
------

Debian was designed to be a free operating. It is built to use the Hurd, FreeBSD, and Linux kernels. [11]

- Life Cycle:
   - Debian: `5 Years <https://www.debian.org/releases/>`__
   - Ubuntu LTS (>= 18.04): `10 Years <https://wiki.ubuntu.com/Releases>`__
   - Ubuntu LTS (<= 16.04): `5 Years <https://wiki.ubuntu.com/LTS>`__

- Package Format:
    - deb

- Package Managers:
    - Apt (CLI)
    - Synaptic (GUI)

[3]

- Popular derivatives [2]:
    - elementary
    - Linux Mint
    - Ubuntu

Fedora
------

Fedora is a upstream community operating system that is sponsored by Red Hat, Inc. that is designed to test the latest technologies. After years of testing, Fedora is eventually used as a base to create a new Red Hat Enterprise Linux (RHEL) operating system that is known for it's enterprise support and long life cycle. [4] The Community Enterprise Operating System (CentOS) is a rebuild of RHEL without the Red Hat, Inc. branding. [5]

- Life Cycle:
   - Fedora: `13 months <https://fedoraproject.org/wiki/Fedora_Release_Life_Cycle>`__
   - CentOS: `10 Years <https://www.centosblog.com/centos-eol-dates/>`__
   - RHEL: `> 10 Years <https://access.redhat.com/support/policy/updates/errata>`__

- Package Format:
    - rpm

- Package Managers:
    - dnf (CLI)
    - dnfdragora (GUI)

- Popular derivatives [2]:
    - Community Enterprise Linux (CentOS)
    - Red Hat Enterprise Linux (RHEL)
    - Yellow Dog Linux (YDL)

Fedora Silverblue
~~~~~~~~~~~~~~~~~

Fedora Silverblue uses ostree (via rpm-ostree) to manage the operating system in a way similar to git. There is a history of each update that can easily be rolled back. The file system is read-only except for writable directories for the user. Beyond the base operating system, it is recommended to install and manage applications as Flatpaks and/or containers. Silverblue may eventually replace the normal Fedora Workstation as the default desktop operating system.

Pros:

-  Automatic updates by default.
-  Easy to rollback updates.
-  Difficult to break due to the read-only file system.

Cons:

-  Does not support dual-booting.
-  Partitions cannot be customized as fully as Fedora Workstation.
-  RPM updates require a system reboot.
-  Cannot search for specific packages (no ``dnf search`` equivalent).

[13]

Gentoo
------

Gentoo is designed to be very configurable and optimized. Most packages need to be compiled from source code that is distributed through the package manager, Portage. This allows customized compilation options and compiler tuning.

- Life Cycle:
   - `Rolling Release <https://wiki.gentoo.org/wiki/FAQ>`__

- Package Format:
    - Tape archive, block-sorting compressed (tbz2) [6]

- Package Manager:
    - Portage (CLI)

- Popular derivatives [2][7]:
    - Calculate Linux
    - Chromium OS
    - Container Linux

Mandriva
--------

Mandriva, which was originally called Mandrake Linux, was a fork of the original Red Hat Linux 5.1 in 1998. After it's start, Mandriva no longer shares code with Fedora or RHEL and is it's own operating system. The last release came out in 2011. Several derivatives still keep the Mandriva operating system alive. The Mageia project is the closest spiritual successor to the original Mandriva project.

- Life Cycle:
   - Mageia: `1.5 Years <https://www.mageia.org/en/support/>`__

- Package Format:
    - rpm

- Package Managers:
    - urpmi (CLI)
    - rpmdrake (GUI)

- Popular derivatives [2]:
    - Mageia
    - OpenMandriva
    - PCLinuxOS

[8]

openSUSE Leap
-------------

openSUSE Leap is a upstream community operating system that is sponsored by SUSE. It is a stable release based off of openSUSE Tumbleweed. It is used as a base for the SUSE Linux Enterprise Server (SLES).

- Life Cycle:
   - Leap: `3 Years <https://en.opensuse.org/Lifetime>`__
   - Tumbleweed: `Rolling Release <https://en.opensuse.org/Portal:Tumbleweed>`__

- Package Format:
    - rpm

- Package Manager:
    - zypper (CLI)
    - YaST (GUI)

- Popular derivatives [2][12]:
    - FyreLinux
    - GeckoLinux
    - SLES

[10]

Top Distributions
-----------------

This is an extremely biased list of the best distribution for each use case.

-  Alternative to Chrome OS = 1. ArnoldTheBats Chromium OS 2. CloudReady 3. GalliumOS
-  Alternative to macOS = elementary OS
-  Alternative to Windows = Zorion OS
-  Arm single-board computer (SBC) = Debian
-  Bleeding edge (stable) = Manjaro
-  Bleeding edge (unstable) = Arch Linux
-  Community support = Arch Linux
-  CPU architectures supported = Debian
-  Customizable = Gentoo
-  Customizable (easy) = Arch Linux
-  Desktop (slow updates) = Debian
-  Desktop (moderate updates) = openSUSE Leap
-  Desktop (fast updates) = Fedora
-  Easiest = Zorion OS
-  Free and open source software (FOSS) = Fedora
-  Gaming = 1. Pop!_OS 2. Manjaro
-  Hardest = Linux From Scratch
-  Hardware support = Arch Linux
-  Lightweight = Tiny Core Linux
-  Longest support = RHEL
-  Old Computer = Linux Lite
-  Packages available = Ubuntu
-  Security penetration testing = Kali Linux
-  Server = 1. RHEL 2. CentOS 3. Debian
-  Stable = 1. RHEL 2. CentOS 3. Debian
-  Touchscreen = Fedora
-  USB drive = Puppy Linux
-  Desktop environments:

   -  Cinnamon = Linux Mint
   -  Deepin = Deepin
   -  Enlightenment = Bodhi Linux
   -  GNOME = Fedora
   -  KDE = KDE neon
   -  LXDE/LXQt = Mageia
   -  MATE = Solus MATE
   -  Pantheon = elementary OS
   -  Xfce = Xubuntu

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/administration/operating_systems.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/operating_systems.rst>`__

Bibliography
------------

1. "Arch Linux." Arch Linux. November 8, 2017. Accessed January 2, 2018. https://www.archlinux.org/
2. "DistroWatch." DistroWatch. Accessed April 27, 2020. https://distrowatch.com/
3. "Chapter 8 - The Debian package management tools." The Debian GNU/Linux FAQ. Accessed January 2, 2018. https://www.debian.org/doc/manuals/debian-faq/ch-pkgtools.en.html
4. "What is the relationship between Fedora and Red Hat Enterprise Linux?" Red Hat. Accessed January 2, 2018. https://www.redhat.com/en/technologies/linux-platforms/articles/relationship-between-fedora-and-rhel
5. "About CentOS." CentOS. Accessed January 2, 2018. https://www.centos.org/about/
6. "Binary package guide." Gentoo Linux Wiki. November 13, 2017. Accessed January 2, 2018. https://wiki.gentoo.org/wiki/Binary_package_guide
7. "Chromium OS SDK Creation." The Chromium Projects. Accessed January 1, 2018. https://www.chromium.org/chromium-os/build/sdk-creation
8. "Mandriva Linux is dead, but these 3 forked distros carry on its legacy." PCWorld. June 4, 2015. Accessed January 1, 2018. https://www.pcworld.com/article/2930369/mandriva-linux-is-dead-but-these-3-forked-distros-carry-on-its-legacy.html
9. "About Gentoo." Gentoo Linux. Accessed January 2, 2018. https://www.gentoo.org/get-started/about/
10. "[openSUSE Wiki] Main Page." openSUSE Wiki. November 16, 2016. Accessed January 2, 2018. https://en.opensuse.org/Main_Page
11. "About Debian." Debian. June 6, 2017. Accessed January 2, 2018. https://www.debian.org/intro/about
12. "Derivatives." OpenSUSE Wiki. Accessed March 20, 2018. https://en.opensuse.org/Derivatives
13. "What is Silverblue?" Fedora Magazine. July 12, 2019. Accessed July 29, 2019. https://fedoramagazine.org/what-is-silverblue/
