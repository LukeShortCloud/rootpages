Arch Linux
===========

.. contents:: Table of Contents

ISO
---

The ISO is used as a live environment to do a manual install or run the guided ``archinstall`` script.

-  All downloads: `here <https://archlinux.org/download/>`__.
-  Fast geolocation mirror from Rackspace: `here <https://mirror.rackspace.com/archlinux/iso/>`__.

By default, the live environment only provides 256 MB of writable space by using RAM as storage. This can be increased by one of two ways. [3]

-  Before booting into the Arch Linux ISO live environment:

   -  Press the "e" key when the GRUB boot menu appears and "Arch Linux install medium (x86_64, x64 UEFI)" is selected. Go to the end of the line that starts with "linux" and add "cow_spacesize=<WRITABLE_SPACE>G". Finally, press both the "CTRL" and "x" keys at the same time to boot.

-  After booting into the Arch Linux ISO live environment:

   .. code-block:: sh

      $ mount -o remount,size=<WRITIABLE_SPACE>G /run/archiso/cowspace

Faster Updates
--------------

Mirrors
~~~~~~~

The Reflector program is used to find the fastest mirrors for Arch Linux. This will not work for other distributions based on Arch Linux such as Manjaro.

-  Installation:

   .. code-block:: sh

      $ sudo pacman -S reflector

-  Optionally configure it by setting one argument per line in the configuration file:

   .. code-block:: sh

      $ sudo vim /etc/xdg/reflector/reflector.conf
      --protocol [http|https]
      --latest <NUMBER_OF_MIRRORS_TO_USE>
      --country <COUNTRY1>,<COUNTRY2>
      --save /etc/pacman.d/mirrorlist

-  Start it once:

   .. code-block:: sh

      $ sudo systemctl enable reflector.service

-  Run it once a week:

   .. code-block:: sh

      $ sudo systemctl enable reflector.timer

[1]

Parallel Downloads
~~~~~~~~~~~~~~~~~~

This is documented in `Administration - Package Managers - PKGBUILD - Pacman - Parallel Downloads <../administration/package_managers.html#parallel-downloads>`__.

Linux Kernels
-------------

There are lots of Linux kernels available for Arch Linux. Here are the Linux kernels in order of fastest to slowest [2]:

1. ``linux``
2. ``linux-zen``
3. ``linux-hardened``
4. ``linux-lts``
5. ``linux-rt``

For being able to install additional drivers, it is recommended to also install the ``<LINUX_KERNEL>-headers`` package.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/arch_linux.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/arch_linux.rst>`__

Bibliography
------------

1. "Reflector." ArchWiki. November 19, 2021. Accessed January 10, 2022. https://wiki.archlinux.org/title/reflector
2. "The Performance Impact From Different Arch Linux Kernel Flavors." Phoronix. January 25, 2023. Accessed February 10, 2023. https://www.phoronix.com/review/arch-linux-kernels-2023/8
3. "grow live rootfs ?" Arch Linux Forums. December 30, 2017. Accessed October 26, 2023. https://bbs.archlinux.org/viewtopic.php?id=210389
