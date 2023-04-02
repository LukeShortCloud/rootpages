Arch Linux
===========

.. contents:: Table of Contents

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
