Graphics
========

.. contents:: Table of Contents

Drivers
-------

AMD
~~~

AMD provides an open-source driver that is part of the Linux kernel. For the best experience, use the latest stable Linux kernel.

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

`History <https://github.com/ekultails/rootpages/commits/master/src/graphics.rst>`__
------------------------------------------------------------------------------------

Bibliography
------------

1. "Howto NVIDIA." RPM Fusion. May 28, 2018. Accessed October 7, 2018. https://rpmfusion.org/Howto/NVIDIA
2. "New third-party repositories - easily install Chrome & Steam on Fedora." Fedora Magazine. April 27, 2018. Accessed October 7, 2018. https://fedoramagazine.org/third-party-repositories-fedora/
3. "Nvidia-xrun." Arch Linux Wiki. Accessed November 4, 2018. September 11, 2018. https://wiki.archlinux.org/index.php/Nvidia-xrun
4. "DesktopEnvironment." Debian Wiki. June 7, 2018. Accessed November 26, 2018. https://wiki.debian.org/DesktopEnvironment
5. "NVIDIA Optimus." ArchWiki. October 28, 2019. Accessed November 20, 2019. https://wiki.archlinux.org/index.php/NVIDIA_Optimus#Using_optimus-manager
6. "Manjaro Gaming with Nvidia Offloading & D3 Power Managment." Reddit r/linux_gaming. September 28, 2019. Accessed November 20, 2019. https://www.reddit.com/r/linux_gaming/comments/dac4bc/manjaro_gaming_with_nvidia_offloading_d3_power/
