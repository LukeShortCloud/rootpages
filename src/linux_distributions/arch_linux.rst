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

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/arch_linux.rst>`__

Bibliography
------------

1. "Reflector." ArchWiki. November 19, 2021. Accessed January 10, 2022. https://wiki.archlinux.org/title/reflector
