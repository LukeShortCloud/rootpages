Graphics Drivers
================

.. contents:: Table of Contents

AMD
---

AMD provides an open source driver that is part of the Linux kernel. For the best experience, use the latest development versions of the Linux kernel, Mesa, and LLVM. Compared to the open source driver, the AMDGPU-Pro proprietary driver provides a more stable interface with full OpenGL and Vulkan capabilities.

Installation
~~~~~~~~~~~~

Proprietary (AMDGPU-Pro)
^^^^^^^^^^^^^^^^^^^^^^^^

Supported operating systems:

-  CentOS 8
-  RHEL 8
-  Ubuntu 18.04
-  SLED/SLES 15

[7]

SUSE Linux Enterprise
'''''''''''''''''''''

The Enterprise Desktop, Enterprise Server, and openSUSE Leap variants are all supported.

-  Enable the `stable kernel repository <https://download.opensuse.org/repositories/Kernel:/stable/standard/>`__. Install Linux >= 5.4 and latest ``linux-firmware`` for the best stability with Navi cards. Linux 5.5 is required for overclocking support on Navi cards. [9]
-  Download the latest driver for the graphics card by putting in the product details `here <https://www.amd.com/en/support>`__.
-  Extract the driver archive and run the ``amdgpu-pro-install`` script to install a local repository of the RPMs.
-  Install the required packages: ``zypper install amdgpu-pro libgl-amdgpu-pro vulkan-amdgpu-pro``.
-  Reboot.

[8]

NVIDIA
------

Installation
~~~~~~~~~~~~

Proprietary
^^^^^^^^^^^

Fedora
''''''

If the official NVIDIA installer was originally used then those libraries need to be cleaned up.

.. code-block:: sh

   $ sudo rm -f /usr/lib{,64}/libGL.so.* /usr/lib{,64}/libEGL.so.*
   $ sudo rm -f /usr/lib{,64}/xorg/modules/extensions/libglx.so
   $ sudo dnf reinstall xorg-x11-server-Xorg mesa-libGL mesa-libEGL libglvnd\*
   $ sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.saved

The the unofficial NVIDIA driver RPMs can be installed. Starting with Fedora 27 [2], the RPMFusion repository can be officially enabled and used to manage the driver.

.. code-block:: sh

   $ sudo dnf install fedora-workstation-repositories
   $ sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
   $ sudo dnf install xorg-x11-drv-nvidia akmod-nvidia vdpauinfo libva-vdpau-driver libva-utils vulkan

[1][2]

Block Open Source Drivers
'''''''''''''''''''''''''

The proprietary drivers provide the best performance. It is possible for the open source drivers to load up first. That would prevent the proprietary driver from being able to load and bind to the NVIDIA graphics card. Block the open source driver from being able to load. [3]

.. code-block:: sh

   $ sudo vim /etc/modprobe.d/nouveau-blacklist.conf
   blacklist nouveau
   blacklist rivafb
   blacklist nvidiafb
   blacklist rivatv
   blacklist nv
   blacklist uvcvideo

nvidia-xrun
~~~~~~~~~~~

This is an unofficial utility for running an application or window manager on a different TTY that uses the dedicated NVIDIA graphics card. This is useful for laptops as it removes the need to deal with NVIDIA Optimus technology, provides a way to run games that require the Vulkan library, and fields better performance.

Install the NVIDIA graphics driver, Bumblebee, OpenBox (``openbox`` and ``obmenu`` packages), and `nvidia-xrun <https://github.com/Witko/nvidia-xrun>`__. Bumblebee is optionally used to turn the graphics card off and on. OpenBox is the most common window manager to use.

Configure `bbswitch` kernel module from Bumblebee to handle power management of the NVIDIA card. File: ``/etc/modprobe.d/bbswitch.conf``.

::

   bbswitch
   options bbswitch load_state=0 unload_state=1

Set nvidia-xrun to launch OpenBox.

.. code-block:: sh

   $ echo "openbox-session" >> ~/.nvidia-xinitrc

Switch to a free TTY. This is normally done in Linux by pressing ``CTRL`` + ``ALT`` + ``F2``. Log in and then run ``nvidia-xrun``. OpenBox will now be running with full access to the NVIDIA graphics card.

[4][10]

optimus-manager (Arch Linux and Manjaro Linux)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``optimus-manager`` provides an easy way to change the graphics card in use on a laptop.

.. code-block:: sh

   $ yay -S optimus-manager
   $ sudo systemctl start optimus-manager

Temporarily switch the primary graphics card mode (this will restart the Xorg session):

.. code-block:: sh

   $ optimus-manager --switch [intel|nvidia|hybrid]

Or change it on the next boot (this way is more reliable):

.. code-block:: sh

   $ optimus-manager --set-startup [intel|nvidia|hybrid]

For using a HDMI port, the laptop must be in the ``nvidia`` mode.

[5]

With NVIDIA version >= 435 drivers and Xorg >= 1.20.6, the ``hybrid`` mode supports GPU offloading. This means the integrated Intel graphics can be used for power efficiency until the dedicated NVIDIA GPU is required for gaming or productivity. The example below offloads graphical power to the NVIDIA GPU for Vulkan and OpenGL while running Steam. [6]

.. code-block:: sh

   $ __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia steam

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics/drivers.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/graphics.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics.rst>`__

Bibliography
------------

1. "Howto NVIDIA." RPM Fusion. May 28, 2018. Accessed October 7, 2018. https://rpmfusion.org/Howto/NVIDIA
2. "New third-party repositories - easily install Chrome & Steam on Fedora." Fedora Magazine. April 27, 2018. Accessed October 7, 2018. https://fedoramagazine.org/third-party-repositories-fedora/
3. "blacklisting nouveau driver." Arch Linux Forums. March 20, 2021. Accessed February 16, 2023. https://bbs.archlinux.org/viewtopic.php?id=213042
4. "DesktopEnvironment." Debian Wiki. June 7, 2018. Accessed November 26, 2018. https://wiki.debian.org/DesktopEnvironment
5. "NVIDIA Optimus." ArchWiki. October 28, 2019. Accessed November 20, 2019. https://wiki.archlinux.org/index.php/NVIDIA_Optimus#Using_optimus-manager
6. "Manjaro Gaming with Nvidia Offloading & D3 Power Managment." Reddit r/linux_gaming. September 28, 2019. Accessed November 20, 2019. https://www.reddit.com/r/linux_gaming/comments/dac4bc/manjaro_gaming_with_nvidia_offloading_d3_power/
7. "Radeo Software for Linux 19.30 Release Notes." AMD. November 5, 2019. Accessed December 10, 2019. https://www.amd.com/en/support/kb/release-notes/rn-rad-lin-19-30-unified
8. "SDB:AMDGPU-PRO." openSUSE Wiki. July 17, 2019. Accessed December 10, 2019. https://en.opensuse.org/SDB:AMDGPU-PRO
9. "AMD OverDrive Overclocking To Finally Work For Radeon Navi GPUs With Linux 5.5 Kernel." Phoronix. November 16, 2019. Accessed December 10, 2019. https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-AMD-Navi-Overclocking
10. “nvidia-xrun.” Arch Linux Wiki. Accessed November 4, 2018. September 11, 2018. https://wiki.archlinux.org/index.php/nvidia-xrun
