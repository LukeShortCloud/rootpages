Graphics Drivers
================

.. contents:: Table of Contents

Mesa
----

List of Drivers
~~~~~~~~~~~~~~~

Mesa is a library that provides a unified collection of open source graphics drivers for UNIX-like operating systems.

**Vulkan**

.. csv-table::
   :header: Vendor, Driver, Minimum Hardware, Vulkan Version, Android Support, Official
   :widths: 20, 20, 20, 20, 20, 20

   AMD, radv, GCN, 1.4, No, No
   Intel, anv, Gen 7, 1.4, No, Yes
   NVIDIA [19], nvk, Turing, 1.4, No, No
   Apple [20], honeykrisp, M1, 1.4, No, No
   Broadcom, v3dv, VC5, 1.3 [28], No, Yes
   Mali, panvk, Valhall [16], 1.1\*\* [30], No [29], No
   Qualcomm, tu (Turnip), Adreno 6XX\*, 1.4, Yes, No

-  \* Adreno 650 and newer GPUs provide the best Vulkan support. The Turnip driver will run on older Adreno 6XX series hardware but their support is incomplete. [14][15]
-  \*\*Mali Valhall v10 and newer is required for Vulkan 1.1 support. Partial Vulkan 1.0 support is provided for older GPUs. [17]

**OpenGL**

.. csv-table::
   :header: Vendor, Driver, Minimum Hardware, OpenGL Version, OpenGL ES Version, Official
   :widths: 20, 20, 20, 20, 20, 20

   AMD, radeonsi, Southern Island, 4.6, 3.2, Yes
   Intel, i965, Gen 8, 4.6, 3.2, Yes
   NVIDIA, nouveau/nv<NUMBER>, Riva TNT, 4.5, 3.1, No
   Apple, agx, M1, 4.6, 3.2 [18], No
   Broadcom, v3d, VC5, (None), 3.1, Yes
   Mali, panfrost, Midgard v4, 3.1, 3.1, No
   Qualcomm, freedreno, Adreno A2XX, 4.5, 3.2, No

[11][12][13]

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

Open Source
^^^^^^^^^^^

Block Proprietary Drivers
'''''''''''''''''''''''''

By blocking the proprietary NVIDIA graphics drivers, the open source Linux kernel modules should be loaded instead. [24]

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/modprobe.d/nvidia-blacklist.conf
   blacklist nvidia
   blacklist nvidiafb
   blacklist nvidia_drm
   # NVIDIA USB-C driver.
   blacklist i2c_nvidia_gpu

Proprietary
^^^^^^^^^^^

Introduction
''''''''''''

These are all of the kernel modules provided by the NVIDIA proprietary driver:

-  /lib/modules/<LINUX_KERNEL_VERSION>/extra/nvidia{,-open}/nvidia-drm.ko
-  /lib/modules/<LINUX_KERNEL_VERSION>/extra/nvidia{,-open}/nvidia-modeset.ko
-  /lib/modules/<LINUX_KERNEL_VERSION>/extra/nvidia{,-open}/nvidia-peermem.ko
-  /lib/modules/<LINUX_KERNEL_VERSION>/extra/nvidia{,-open}/nvidia-uvm.ko
-  /lib/modules/<LINUX_KERNEL_VERSION>/extra/nvidia{,-open}/nvidia.ko

Redistribution
''''''''''''''

As of NVIDIA proprietary driver version 535.43.02, both the Linux kernel driver and the GSP firmware binary are allowed to be redistributed by anyone. Before this, operating system maintainers required explicit written permission from NVIDIA to distribute these files. [21][22] The GSP firmware will also allow the open source drivers to perform better. They will have the ability to support newer hardware and run them at higher clock speeds while gaming or lower clock speeds while idle. [23]

Install NVIDIA GPU firmware:

-  Arch Linux

   .. code-block:: sh

      $ sudo pacman -S linux-firmware

-  Debian (requires the non-free-firmware repository to be enabled) [26]

   .. code-block:: sh

      $ sudo apt-get install firmware-misc-nonfree

-  Fedora [27]

   .. code-block:: sh

      $ sudo dnf install nvidia-gpu-firmware

Services
''''''''

As of NVIDIA driver version 550, these services need to be enabled to prevent crashes on a laptop. [25]

.. code-block:: sh

   sudo systemctl enable nvidia-hibernate nvidia-persistenced nvidia-powerd nvidia-resume nvidia-suspend

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

   $ sudo -E ${EDITOR} /etc/modprobe.d/nouveau-blacklist.conf
   blacklist nova
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
11. "Home." The Mesa 3D Graphics Library. Accessed March 14, 2023. https://www.mesa3d.org/
12. "Platforms and Drivers." The Mesa 3D Graphics Library latest documentation. Accessed March 14, 2023. https://docs.mesa3d.org/systems.html
13. "Mesamatrix." The Mesa drivers matrix. January 2, 2025. Accessed January 5, 2025. https://mesamatrix.net/
14. "How To Guide Getting Freedreno Turnip (Mesa Vulkan Driver) on a Poco F3." XDA Forums. February 15, 2022. Accessed March 14, 2023. https://forum.xda-developers.com/t/getting-freedreno-turnip-mesa-vulkan-driver-on-a-poco-f3.4323871/page-3#post-86420275
15. "Mesa's Turnip Now Advertises Vulkan 1.3 Support." Phoronix Forums. September 22, 2022. Accessed March 14, 2023. https://www.phoronix.com/forums/forum/linux-graphics-x-org-drivers/vulkan/1347399-mesa-s-turnip-now-advertises-vulkan-1-3-support?p=1347507#post1347507
16. "panvk: Drop support for Midgard." GitLab Mesa/mesa. February 20, 2023. Accessed March 14, 2023. https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/16915
17. "panvk: Stop advertising Vulkan 1.1." freedesktop.org git repository browser. March 14, 2022. Accessed March 14, 2023. https://cgit.freedesktop.org/mesa/mesa/commit/?id=a35e721162bb7dad087e75fd07fec08bc635dc96
18. "Conformant OpenGL 4.6 on the M1." Rosenzweig. February 14, 2024. Accessed February 12, 2025. https://rosenzweig.io/blog/conformant-gl46-on-the-m1.html
19. "Introducing NVK." Collabora News & Blog. October 4, 2022. Accessed March 29, 2023. https://www.collabora.com/news-and-blog/news-and-events/introducing-nvk.html
20. "Vulkan 1.3 on the M1 in 1 month." Rosenzweig. June 5, 2024. Accessed June 5, 2024. https://rosenzweig.io/blog/vk13-on-the-m1-in-1-month.html
21. "NVIDIA Cleans Up GSP Firmware Binary License." Phoronix. May 31, 2023. Accessed July 31, 2023. https://www.phoronix.com/news/NVIDIA-GSP-Firmware-License
22. "License For Customer Use of NVIDIA Software." NVIDIA. Accessed July 31, 2023. https://www.nvidia.com/content/DriverDownloads/licence.php?lang=us
23. "NVK update: Enabling new extensions, conformance status & more." Collabora. June 26, 2023. Accessed July 31, 2023. https://www.collabora.com/news-and-blog/news-and-events/nvk-update-enabling-new-extensions-conformance-status-more.html
24. "Problem with GPU Passthrough." Proxmox Support Forum. January 29, 2023. Accessed May 2, 2024. https://forum.proxmox.com/threads/problem-with-gpu-passthrough.55918/page-4
25. "You may want to avoid NVIDIA driver 550 if you're on a laptop." GamingOnLinux. June 11, 2024. Accessed September 23, 2024. https://www.gamingonlinux.com/2024/06/you-may-want-to-avoid-nvidia-driver-550-if-youre-on-a-laptop/page=1/#r264670
26. "NVIDIA Proprietary Driver." Debian Wiki. September 19, 2024. Accessed September 23, 2024. https://wiki.debian.org/NvidiaGraphicsDrivers
27. "How to Install nVidia drivers in Fedora." Linux.org. February 12, 2024. Accessed September 23, 2024. https://www.linux.org/threads/how-to-install-nvidia-drivers-in-fedora.48635/
28. "v3dv: expose Vulkan 1.3." GitLab Mesa/mesa. August 13, 2024. Accessed January 5, 2025. https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29476
29. "panvk: Make support of Android Surfaceflinger Backend." GitLab Mesa/mesa. January 2, 2025. Accessed January 5, 2025. https://gitlab.freedesktop.org/mesa/mesa/-/issues/12350
30. "panvk: expose vk1.1 on v10 hardware." GitLab Mesa/mesa. January 22, 2025. Accessed January 27, 2025. https://gitlab.freedesktop.org/mesa/mesa/-/commit/1a81bff6aa431b3fc6a2900bde96ea3e74543433
