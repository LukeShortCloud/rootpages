Graphics
========

.. contents:: Table of Contents

Drivers
-------

AMD
~~~

AMD provides an open source driver that is part of the Linux kernel. For the best experience, use the latest development versions of the Linux kernel, Mesa, and LLVM. Compared to the open source driver, the AMDGPU-Pro proprietary driver provides a more stable interface with full OpenGL and Vulkan capabilities.

Installation (AMDGPU-Pro)
^^^^^^^^^^^^^^^^^^^^^^^^^

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

Nvidia
~~~~~~

Installation
^^^^^^^^^^^^

Fedora
''''''

If the official Nvidia installer was originally used then those libraries need to be cleaned up.

.. code-block:: sh

   $ sudo rm -f /usr/lib{,64}/libGL.so.* /usr/lib{,64}/libEGL.so.*
   $ sudo rm -f /usr/lib{,64}/xorg/modules/extensions/libglx.so
   $ sudo dnf reinstall xorg-x11-server-Xorg mesa-libGL mesa-libEGL libglvnd\*
   $ sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.saved

The the unofficial Nvidia driver RPMs can be installed. Starting with Fedora 27 [2], the RPMFusion repository can be officially enabled and used to manage the driver.

.. code-block:: sh

   $ sudo dnf install fedora-workstation-repositories
   $ sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
   $ sudo dnf install xorg-x11-drv-nvidia akmod-nvidia vdpauinfo libva-vdpau-driver libva-utils vulkan

[1][2]

Block Open Source Drivers
'''''''''''''''''''''''''

The proprietary drivers provide the best performance. It is possible for the open source drivers to load up first. That would prevent the proprietary driver from being able to load and bind to the NVIDIA graphics card. Block the open source driver from being able to load. [15]

.. code-block:: sh

   $ sudo vim /etc/modprobe.d/nouveau-blacklist.conf
   blacklist nouveau
   blacklist rivafb
   blacklist nvidiafb
   blacklist rivatv
   blacklist nv
   blacklist uvcvideo

nvidia-xrun
^^^^^^^^^^^

This is an unofficial utility for running an application or window manager on a different TTY that uses the dedicated Nvidia graphics card. This is useful for laptops as it removes the need to deal with Nvidia Optimus technology, provides a way to run games that require the Vulkan library, and fields better performance.

Install the Nvidia graphics driver, Bumblebee, OpenBox (``openbox`` and ``obmenu`` packages), and `nvidia-xrun <https://github.com/Witko/nvidia-xrun>`__. Bumblebee is optionally used to turn the graphics card off and on. OpenBox is the most common window manager to use.

Configure `bbswitch` kernel module from Bumblebee to handle power management of the Nvidia card. File: ``/etc/modprobe.d/bbswitch.conf``.

::

   bbswitch
   options bbswitch load_state=0 unload_state=1

Set nvidia-xrun to launch OpenBox.

.. code-block:: sh

   $ echo "openbox-session" >> ~/.nvidia-xinitrc

Switch to a free TTY. This is normally done in Linux by pressing ``CTRL`` + ``ALT`` + ``F2``. Log in and then run ``nvidia-xrun``. OpenBox will now be running with full access to the Nvidia graphics card.

[4]

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

With Nvidia version >= 435 drivers and Xorg >= 1.20.6, the ``hybrid`` mode supports GPU offloading. This means the integrated Intel graphics can be used for power efficiency until the dedicated Nvidia GPU is required for gaming or productivity. The example below offloads graphical power to the Nvidia GPU for Vulkan and OpenGL while running Steam. [6]

.. code-block:: sh

   $ __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia steam

Window Managers
---------------

Window managers (WMs) control the look and feel of windows.

-  Compiz
-  FluxBox
-  Kwin
-  Muffin
-  Mutter
-  Openbox
-  Xfwm

Tiled window managers specialize in splitting up windows into tiles/boxes that can be modified with keyboard shortcuts.

-  Awesome
-  Dwm
-  i3
-  Wmii

[4]

Desktop Environments
--------------------

Desktop environments (DEs) are built on top of windows managers. They provide the full functionality of a graphical desktop by bundling applications for managing media, files, and network connections. Some DEs have created their own custom window managers as well. [4]

.. csv-table::
   :header: DE Name, Graphical Toolkit, WM, Resource Usage
   :widths: 20, 20, 20, 20

   Cinnamon, GTK, Muffin, Medium
   GNOME, GTK, Mutter, Medium
   KDE, Qt, Kwin, High
   Xfce, GTK, Xfwm, Low

Cinnamon
~~~~~~~~

Installation:

-  Arch Linux: ``$ sudo pacman -S cinnamon``
-  Debian (manual): ``$ sudo apt-get install cinnamon``
-  Debian (automatic): ``$ sudo apt-get install task-cinnamon-desktop``
-  Fedora: ``$ sudo dnf groupinstall "Cinnamon Desktop"``

GNOME
~~~~~

Installation:

-  Arch Linux: ``$ sudo pacman -S gnome gnome-extras``
-  Debian (manual): ``$ sudo apt-get install gnome``
-  Debian (automatic): ``$ sudo apt-get install task-gnome-desktop``
-  Fedora: ``$ sudo dnf groupinstall "GNOME Desktop Environment"``

The `gnome-tweaks <https://gitlab.gnome.org/GNOME/gnome-tweaks>`__ package provides access to useful advanced settings of the GNOME desktop environment via the ``Tweaks`` application.

Suggested tweaks:

-  Extensions > Applications menu > On
-  Keyboard & Mouse > Mouse > Pointer Location > On
-  Top Bar > Battery Percentage > On
-  Window Titlebars > Titlebar Buttons > [Maximize|Minimize] > On

KDE
~~~

Installation:

-  Arch Linux: ``$ sudo pacman -S plasma kde-applications``
-  Debian (manual): ``$ sudo apt-get install kde-standard``
-  Debian (automatic): ``$ sudo apt-get install task-kde-desktop``
-  Fedora: ``$ sudo dnf groupinstall "KDE Plasma Workspaces"``

Xfce
~~~~

Installation:

-  Arch Linux: ``$ sudo pacman -S xfce4 xfce4-goodies``
-  Debian (manual): ``$ sudo apt-get install xfce4``
-  Debian (automatic): ``$ sudo apt-get install task-xfce-desktop``
-  Fedora: ``$ sudo dnf groupinstall "Xfce Desktop"``

Display Usage
-------------

Rotate Screen
~~~~~~~~~~~~~

When using Xorg, ``xrandr`` can rotate the screen. This needs to use a graphics driver that supports modesetting. Legacy drivers such as ``xf86-video-amdgpu``, ``xf86-video-intel``, ``xf86-video-nouveau``, or ``xf86-video-vmware`` will not work.

-  View the list of displays. Rotate it in a specified direction.

   .. code-block:: sh

      $ xrandr
      $ xrandr --output <DISPLAY> --rotate [left|right|normal|inverted]

-  If this error occurs, then a legacy Xorg driver is installed that does not support modesetting. [16]

   ::

      xrandr: output eDP1 cannot use rotation "right" reflection "none"

Gaming
------

Steam
~~~~~

Runtime
^^^^^^^

Steam provides a runtime that is a chroot of pre-installed Linux libraries required for Steam to work. Sometimes these libraries may not work as expected. There are different ways to configure how Steam will or will not use its own runtime.

-  Use the Steam runtime libraries.

   .. code-block:: sh

      $ STEAM_RUNTIME=1 steam

-  Use the system libraries and fall-back to Steam runtime libraries if they are missing on the system.

   .. code-block:: sh

      $ STEAM_RUNTIME=1 STEAM_RUNTIME_PREFER_HOST_LIBRARIES=1 steam

-  Use the system libraries.

   .. code-block:: sh

      $ STEAM_RUNTIME=0 steam

[12]

Flatpak
^^^^^^^

The Flatpak for Steam can mount external devices into the isolated environment. Mount points are not exposed in the Flatpak by default. [10]

.. code-block:: sh

   $ flatpak override --user --filesystem=<STEAM_LIBRARY_PATH> com.valvesoftware.Steam

Proton (Steam Play)
^^^^^^^^^^^^^^^^^^^

Proton allows Windows games to run on Linux. A full list of games that are officially whitelisted and guaranteed to work can be found `here <https://steamdb.info/app/891390/>`__. Proton can be enabled for all games by going to ``Settings > Steam Play > Enable Steam Play for all other titles``. Compatibility will vary. [11]

Remote Access
-------------

Parsec
~~~~~~

Parsec is a tool that can be used to remotely access macOS and Windows hosts. It supports Linux, macOS, and Windows hosts.

Virtual Monitors
^^^^^^^^^^^^^^^^

Parsec requires a physical monitor to be plugged into the computer and turned on. There are a few ways to create virtual monitors so that a physical monitor is no longer required. [13]

-  Paid versions of Parsec Teams and Enterprise provide support for creating virtual monitors.
-  Hardware HDMI dummy plugs exist to fake having a monitor plugged in.
-  On Windows hosts, use the `Amyuni Virtual Display Driver (usbmmid) <https://www.amyuni.com/forum/viewtopic.php?t=3030>`__.

   -  This virtual display is not persistent on reboots. Create a scheduled task to start it as the Administrator on boot.

      ::

         Task Scheduler (taskschd.msc) > Create Basic Task... > Name: Virtual Monitor > Next > When do you want the task to start? When the computer starts > Next > Start a program > Next > Program/script: (select the "usbmidd.bat" file) > Next > Finish
         Task Scheduler (taskschd.msc) > Task Scheduler (Local) > Task Scheduler Library > Virtual Monitor > Properties > (select "Run whether user is logged in or not" and "Run with highest privileges") > OK

Virtual Audio
^^^^^^^^^^^^^

Parsec does not create any virtual audio devices. Instead, it forwards connected hardware audio from the Parsec host to the client. There are a few ways around this for a headless setup.

-  Plug in and forward an audio device to the virtual machine.
-  On macOS and Windows hosts, use the `VB-CABLE virtual audio device <https://vb-audio.com/Cable/>`__. [14]

Image Processing
----------------

-  Remove all metadata from an image.

   .. code-block:: sh

      $ mogrify -strip <IMAGE_FILE_NAME>

-  Compress an image to a specified size.

   .. code-block:: sh

      $ [jpegoptim|optipng] --size=500K <IMAGE_FILE_NAME>

-  Resize an image.

   .. code-block:: sh

      $ convert <IMAGE_ORIGINAL> -resize <PERCENTAGE>% <IMAGE_NEW>
      $ convert <IMAGE_ORIGINAL> -resize <PIXELS_LENGTH>x<PIXELS_WIDTH> <IMAGE_NEW>

-  Rotate an image.

   .. code-block:: sh

      $ convert <IMAGE_ORIGINAL> -rotate <DEGRESS> <IMAGE_NEW>

Troubleshooting
---------------

Error Messages
~~~~~~~~~~~~~~

Missing libraries when starting the Steam runtime:

.. code-block:: sh

   $ steam-runtime
   Error: You are missing the following 32-bit libraries, and Steam may not run: <LIBRARY_FILE>

Solution:

-  Run ``steam-runtime --reset`` to redownload the runtime libraries.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/graphics.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics.rst>`__

Bibliography
------------

1. "Howto NVIDIA." RPM Fusion. May 28, 2018. Accessed October 7, 2018. https://rpmfusion.org/Howto/NVIDIA
2. "New third-party repositories - easily install Chrome & Steam on Fedora." Fedora Magazine. April 27, 2018. Accessed October 7, 2018. https://fedoramagazine.org/third-party-repositories-fedora/
3. "Nvidia-xrun." Arch Linux Wiki. Accessed November 4, 2018. September 11, 2018. https://wiki.archlinux.org/index.php/Nvidia-xrun
4. "DesktopEnvironment." Debian Wiki. June 7, 2018. Accessed November 26, 2018. https://wiki.debian.org/DesktopEnvironment
5. "NVIDIA Optimus." ArchWiki. October 28, 2019. Accessed November 20, 2019. https://wiki.archlinux.org/index.php/NVIDIA_Optimus#Using_optimus-manager
6. "Manjaro Gaming with Nvidia Offloading & D3 Power Managment." Reddit r/linux_gaming. September 28, 2019. Accessed November 20, 2019. https://www.reddit.com/r/linux_gaming/comments/dac4bc/manjaro_gaming_with_nvidia_offloading_d3_power/
7. "Radeo Software for Linux 19.30 Release Notes." AMD. November 5, 2019. Accessed December 10, 2019. https://www.amd.com/en/support/kb/release-notes/rn-rad-lin-19-30-unified
8. "SDB:AMDGPU-PRO." openSUSE Wiki. July 17, 2019. Accessed December 10, 2019. https://en.opensuse.org/SDB:AMDGPU-PRO
9. "AMD OverDrive Overclocking To Finally Work For Radeon Navi GPUs With Linux 5.5 Kernel." Phoronix. November 16, 2019. Accessed December 10, 2019. https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-AMD-Navi-Overclocking
10. "Frequently asked questions." flathub/com.valvesoftware.Steam. April 12, 2020. Accessed July 3, 2020. https://github.com/flathub/com.valvesoftware.Steam/wiki/Frequently-asked-questions
11. "A simple guide to Steam Play, Valve's technology for playing Windows games on Linux." GamingOnLinux. July 12, 2019. Accessed July 3, 2020. https://www.gamingonlinux.com/articles/14552
12. "Steam/Client troubleshooting." Gentoo Wiki. February 15, 2021. Accessed May 20, 2021. https://wiki.gentoo.org/wiki/Steam/Client_troubleshooting
13. "Remote Streaming Without a Display." r/ParsecGaming. June 29, 2022. Accessed August 27, 2022. https://www.reddit.com/r/ParsecGaming/comments/kbzbhg/remote_streaming_without_a_display/
14. "Unable To Hear The Game You're Playing." Parsec. Accessed September 6, 2022. https://support.parsec.app/hc/en-us/articles/115002700892-Unable-To-Hear-The-Game-You-re-Playing
15. "blacklisting nouveau driver." Arch Linux Forums. March 20, 2021. Accessed February 16, 2023. https://bbs.archlinux.org/viewtopic.php?id=213042
16. "xrandr cannot use rotation "normal" reflection "none"." Unix & Linux Stack Exchange. August 16, 2021. Accessed February 16, 2023. https://unix.stackexchange.com/questions/636886/xrandr-cannot-use-rotation-normal-reflection-none
