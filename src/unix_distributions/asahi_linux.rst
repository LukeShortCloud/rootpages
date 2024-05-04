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

Uninstallation
--------------

**Manual (RECOMMENDED)**

The manual process for uninstalling Asahi Linux is less likely to corrupt the macOS installation.

-  Find and delete the EFI partition for Asahi Linux.

   .. code-block:: sh

      $ diskutil list | grep ASAHI
      $ diskutil eraseVolume JHFS+ drive /dev/<DEVICE>

-  Delete the other Asahi Linux partitions using Disk Utility. This will automatically resize the macOS partition to use all available space again.

   -  Disk Utility > Partition > (delete only these 3 partitions: (1) "drive" or "driver" which is 500 MB, (2) Asahi Linux which is 2.5 GB, and (3) the large partition that is NOT "Macintosh HD") > Apply > Partition > Done

-  Reboot macOS. If Asahi Linux was configured to boot by default instead of macOS, the boot process will fail saying "Custom kernel failed to boot." Configure the Mac to use macOS by default [2]:

   -  Startup Disk... > Macintosh HD > Restart...

**Automatic (NOT recommended)**

The automatic process for uninstalling Asahi Linux is more likely to corrupt the macOS installation. [3]

.. code-block:: sh

   $ curl -L https://alx.sh/wipe-linux | sudo sh

Boot
----

On macOS, to get to the boot menu [4]:

-  Hold the power button. It will say "Continue holding for startup options...".
-  Release the power button when it says "Loading startup options...".
-  Select either "Macintosh HD", "Asahi Linux", or "Fedora Linux".

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/asahi_linux.rst>`__

Bibliography
------------

1. "The first Asahi Linux Alpha Release is here!" Ashai Linux. March 18, 2022. Accessed June 17, 2023. https://asahilinux.org/2022/03/asahi-linux-alpha-release/
2. "How to Uninstall Asahi Linux on M1 Mac - Remove all Partitions & Volumes." YouTube Mr. Macintosh. March 24, 2022. Accessed August 2, 2023. https://www.youtube.com/watch?v=nMnWTq2H-N0
3. "How to uninstall?" Reddit r/AsahiLinux. July 23, 2023. Accessed August 2, 2023. https://www.reddit.com/r/AsahiLinux/comments/vs4qp1/how_to_uninstall/
4. "Installing the Asahi Linux Alpha on my M1 Mac mini." Jeff Geerling. March 25, 2022. Accessed May 3, 2024. https://www.jeffgeerling.com/blog/2022/installing-asahi-linux-alpha-on-my-m1-mac-mini
