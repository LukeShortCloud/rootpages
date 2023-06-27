Asahi Linux
===========

.. contents:: Table of Contents

Introduction
------------

Asahi Linux is a build of Arch Linux for Apple Silicon devices. The goal of the project is to reverse-engineer that hardware and work towards upstreaming support for it in all of the various open source projects in the Linux community.

Installation
------------

Requirements:

-  macOS >= 12.3
-  53 GB of free space

There is no offline installation media yet. Asahi Linux must be installed using an online connection to download the latest in-development packages.

The installation will configure a dual-boot. Since Ashai Linux is not stable yet and macOS provides updated firmware files, macOS is left installed.

Three options are provided for the installation:

1.  Ashai Linux with the KDE Plasma desktop environment
2.  Ashai Linux without the KDE Plasma desktop environment (terminal only)
3.  UEFI environment for testing other Linux operating systems

Start the installer:

.. code-block:: sh

   $ curl https://alx.sh | sh

[1]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/asahi_linux.rst>`__

Bibliography
------------

1. "The first Asahi Linux Alpha Release is here!" Ashai Linux. March 18, 2022. Accessed June 17, 2023. https://asahilinux.org/2022/03/asahi-linux-alpha-release/
