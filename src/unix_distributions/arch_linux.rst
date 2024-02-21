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

Pacman GPG Keyrings
-------------------

The Arch Linux GPG keyring, used for verifying package integrity, constantly change along with rolling release updates. These occasionally need to be updated for Pacman upgrades to work. Use one of the methods below to update the keyring.

1.  Manually update the keyring.

   -  Using ``pacman``:

      -  Arch Linux:

         .. code-block:: sh

            $ sudo pacman -S -y
            $ sudo pacman -S archlinux-keyring

      -  Manjaro:

         .. code-block:: sh

            $ sudo pacman -S -y
            $ sudo pacman -S archlinux-keyring manjaro-keyring

   -  Using ``pacman-key``:

      .. code-block:: sh

         $ sudo pacman-key --refresh-keys

2.  Reset the keyring.

   .. code-block:: sh

      $ sudo rm -r -f /etc/pacman.d/gnupg
      $ sudo pacman-key --init

   -  Populate the keyrings.

      -  Arch Linux:

         -  Using ``pacman``:

            .. code-block:: sh

               $ sudo pacman -S -y
               $ sudo pacman -S archlinux-keyring

         -  Using ``pacman-key``:

            .. code-block:: sh

               $ sudo pacman-key --populate archlinux

      -  Manjaro:

         -  Using ``pacman``:

            .. code-block:: sh

               $ sudo pacman -S -y
               $ sudo pacman -S archlinux-keyring manjaro-keyring

         -  Using ``pacman-key``:

            .. code-block:: sh

               $ sudo pacman-key --populate archlinux manjaro

[4][5]

On an Arch Linux or Manjaro live installation environment, it takes a few minutes after boot to automatically update the keyring in the background.

Arch Linux User Repository (AUR)
--------------------------------

Package Managers
~~~~~~~~~~~~~~~~

The AUR repository provides unofficial packages. Those packages only contain build instructions and do not contain binary builds. This avoids legal issues regarding the redistribution of proprietary software. As of the end of 2023, there are over 87,000 packages hosted on the AUR. Search for packages `here <https://aur.archlinux.org/>`__. [6]

There are a few different AUR package managers. These all automate and  wrap around using ``makepkg`` to build the binary package and ``pacman`` to install the package.

-  ``yay`` = The most popular AUR package manager.
-  ``paru`` = The most feature rich AUR package manager.

Installation:

-  ``yay`` [7]

   -  Using ``makepkg``:

      .. code-block:: sh

         $ sudo pacman -S base-devel git
         $ git clone https://aur.archlinux.org/yay.git
         $ cd yay
         $ makepkg -s -i

   -  Using ``yay``:

      .. code-block:: sh

         $ export YAY_VERSION=12.3.0
         $ wget https://github.com/Jguer/yay/releases/download/v${YAY_VERSION}/yay_${YAY_VERSION}_x86_64.tar.gz
         $ tar -x -v -f yay_${YAY_VERSION}_x86_64.tar.gz
         $ sudo cp ./yay_${YAY_VERSION}_x86_64/yay /usr/local/bin/
         $ yay -S yay-bin
         $ sudo rm -f /usr/local/bin/yay

-  ``paru`` [8]

   -  Using ``makepkg``:

      .. code-block:: sh

         $ sudo pacman -S base-devel git
         $ git clone https://aur.archlinux.org/paru.git
         $ cd paru
         $ makepkg -s -i

   -  Using ``paru``:

      .. code-block:: sh

         $ export PARU_VERSION=2.0.1
         $ mkdir paru
         $ cd paru
         $ wget https://github.com/Morganamilo/paru/releases/download/v${PARU_VERSION}/paru-v${PARU_VERSION}-x86_64.tar.zst
         $ tar -x -v -f paru-v${PARU_VERSION}-x86_64.tar.zst
         $ sudo mv ./paru /usr/local/bin/
         $ paru -S paru-bin
         $ sudo rm -f /usr/local/bin/paru

Chaotic AUR Repository
~~~~~~~~~~~~~~~~~~~~~~

The Chaotic AUR repository provides binary packages for the most popular AUR packages. As of the end of 2023, there are over 7,000 packages available to install. Search for packages `here <https://builds.garudalinux.org/repos/chaotic-aur/x86_64/>`__. Requests for new packages can be submitted `here <https://github.com/chaotic-aur/packages/issues>`__.

Installation [9]:

.. code-block:: sh

   sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
   sudo pacman-key --init
   sudo pacman-key --lsign-key 3056513887B78AEB
   sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
   sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
   echo "[chaotic-aur]
   Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
   sudo pacman -S -y

Usage:

-  Install a package from the Chaotic AUR or force install it from source from the AUR.

   .. code-block:: sh

      $ pacman -S <AUR_PACKAGE>

   .. code-block:: sh

      $ yay -S aur/<AUR_PACKAGE>

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
4. "pacman/Package signing." ArchWiki. November 21, 2023. Accessed December 28, 2023. https://wiki.archlinux.org/title/Pacman/Package_signing
5. "Pacman troubleshooting." Manjaro. October 9, 2023. Accessed December 28, 2023. https://wiki.manjaro.org/index.php/Pacman_troubleshooting
6. "AUR Home." Arch Linux. Accessed February 19, 2024. https://aur.archlinux.org/
7. "Jguer/yay." GitHub. January 25, 2024. Accessed February 19, 2024. https://github.com/Jguer/yay
8. "Morganamilo/paru." GitHub. October 13, 2023. Accessed February 19, 2024. https://github.com/Morganamilo/paru
9. "Chaotic-AUR - an automated building repo for AUR packages." Chaotic-AUR. May 17, 2023. Accessed February 20, 2024. https://aur.chaotic.cx/
