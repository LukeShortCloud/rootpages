Desktop
========

.. contents:: Table of Contents

Display Managers
----------------

Introduction
~~~~~~~~~~~~

The display manager (DM) is responsible for authenticating a user and launching a desktop environment. Here are a few popular DMs available on Linux distributions [6][7]:

-  GNOME Display Manager (GDM) = Specific to the GNOME desktop environment.
-  Light Display Manager (LightDM) = Generic DM used to launch any desktop environment (including GNOME).

Automatically Login User
~~~~~~~~~~~~~~~~~~~~~~~~

Here is how to automatically login a user after a given timeout. A reboot is required for these changes to take affect.

-  GDM [5]:

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/gdm/custom.conf

   .. code-block:: ini

      [daemon]
      AutomaticLoginEnbable=true
      AutomaticLogin=<USER>
      TimedLoginEnable=true
      TimedLogin=<USER>
      TimedLoginDelay=<SECONDS>

-  LightDM [6]:

   .. code-block:: sh

      $ sudo groupadd --system autologin
      $ gpasswd -a <USER> autologin
      $ sudo -E ${EDITOR} /etc/lightdm/lightdm.conf

   .. code-block:: ini

      [SeatDefaults]
      autologin-guest = false
      autlogin-user = <USER>
      autologin-user-timeout = <SECONDS>

Default Session
~~~~~~~~~~~~~~~

List available desktop environment sessions:

.. code-block:: sh

   # Xorg
   $ ls -1 /usr/share/xsessions/
   # Wayland
   $ ls -1 /usr/share/wayland-sessions/

Set one of the sessions (use the name without the ``.desktop`` extension) to be the default session for a specified user by creating the file ``/var/lib/AccountsService/users/${USER}``. [13][14]

.. code-block:: ini

   [User]
   Language=
   # Xorg
   #XSession=<XORG_SESSION>
   # Wayland
   Session=<WAYLAND_SESSION>

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

[1]

Desktop Environments
--------------------

Introduction
~~~~~~~~~~~~

Desktop environments (DEs) are built on top of windows managers. They provide the full functionality of a graphical desktop by bundling applications for managing media, files, and network connections. Some DEs have created their own custom window managers as well. [1]

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

-  If this error occurs, then a legacy Xorg driver is installed that does not support modesetting. [4]

   ::

      xrandr: output eDP1 cannot use rotation "right" reflection "none"

For the TTY, configure the ``fbcon``. The Linux kernel must be compiled with ``CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y``. Verify that it is by running:

.. code-block:: sh

   $ zgrep CONFIG_FRAMEBUFFER_CONSOLE_ROTATION /proc/config.gz

All of the available options are:

-  ``0`` = Default orientation.
-  ``1`` = Clockwise.
-  ``2`` = Inverted.
-  ``3`` = Counter-clockwise.

Temporary change:

.. code-block:: sh

   $ echo <ROTATION_OPTION> | sudo tee /sys/class/graphics/fbcon/rotate_all

Permanent change [12]:

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/default/grub
   GRUB_CMDLINE_LINUX="fbcon=rotate:<ROTATION_OPTION>"
   $ sudo grub-mkconfig -o /boot/grub/grub.cfg

Remote Access
-------------

Comparison
~~~~~~~~~~

Use case:

-  AnyDesk = Free and no account required.
-  Parsec = Best desktop streaming service for gaming but requires a free account.

AnyDesk
~~~~~~~

AnyDesk is proprietary, does not require an account, and offers online remote desktop sharing with essential features such as copy and paste.

Benefits of a paid account:

-  Privacy mode to disable the physical remote monitor. [8]
-  Support for more than on monitor. [9]
-  Ability to connect to more than 3 devices.
-  Recording.
-  Tech support.
-  User management.
-  Wake-on-LAN. [10]

Installation:

.. code-block:: sh

   $ flatpak install com.anydesk.Anydesk

Usage:

-  Open "AnyDesk" on two different computers.

   .. code-block:: sh

      $ flatpak run com.anydesk.Anydesk

-  Select the "New Session" tab.
-  Note the "Your Address" from the remote computer. Enter that unique AnyDesk address on the client computer in the "Remote Desk" field and then select "Connect".

Parsec
~~~~~~

Parsec is a tool that can be used to remotely access macOS and Windows hosts. It supports Linux, macOS, and Windows as clients. Hosting support for Linux is not currently in development but may come in 2024 or 2025. [11]

Virtual Monitors
^^^^^^^^^^^^^^^^

Parsec requires a physical monitor to be plugged into the computer and turned on. There are a few ways to create virtual monitors so that a physical monitor is no longer required. [2]

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
-  On macOS and Windows hosts, use the `VB-CABLE virtual audio device <https://vb-audio.com/Cable/>`__. [3]

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

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics/desktop.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/graphics.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics.rst>`__

Bibliography
------------

1. "DesktopEnvironment." Debian Wiki. June 7, 2018. Accessed November 26, 2018. https://wiki.debian.org/DesktopEnvironment
2. "Remote Streaming Without a Display." r/ParsecGaming. June 29, 2022. Accessed August 27, 2022. https://www.reddit.com/r/ParsecGaming/comments/kbzbhg/remote_streaming_without_a_display/
3. "Unable To Hear The Game You're Playing." Parsec. Accessed September 6, 2022. https://support.parsec.app/hc/en-us/articles/115002700892-Unable-To-Hear-The-Game-You-re-Playing
4. "xrandr cannot use rotation "normal" reflection "none"." Unix & Linux Stack Exchange. August 16, 2021. Accessed February 16, 2023. https://unix.stackexchange.com/questions/636886/xrandr-cannot-use-rotation-normal-reflection-none
5. "Configure automatic login." GNOME Library. Accessed April 9, 2023. https://help.gnome.org/admin/system-admin-guide/stable/login-automatic.html.en
6. "How to Login Automatically to Linux [most distros support]." FOSTips. September 2, 2022. Accessed April 9, 2023. https://fostips.com/login-automatically-linux/
7. "Display manager." ArchWiki. April 7, 2023. Accessed April 9, 2023. https://wiki.archlinux.org/title/display_manager
8. "Screen Privacy." AnyDesk Help Center. Accessed October 4, 2023. https://support.anydesk.com/knowledge/screen-privacy
9. "what is the deal with free vs paid." Reddit r/AnyDesk. March 24, 2020. Accessed October 4, 2023. https://www.reddit.com/r/AnyDesk/comments/fo51wn/what_is_the_deal_with_free_vs_paid/?rdt=50890
10. "AnyDesk Free vs Paid - How They Compare." Splashtop. September 12, 2023. Accessed October 4, 2023. https://www.splashtop.com/blog/anydesk-free-vs-paid
11. "Hosting on Linux." Reddit r/ParsecGaming. January 4, 2023. Accessed October 4, 2023. https://www.reddit.com/r/ParsecGaming/comments/102svaf/hosting_on_linux/
12. "How do I rotate my display when not using an X Server?" Ask Ubuntu. June 6, 2014. Accessed March 5, 2024. https://askubuntu.com/questions/237963/how-do-i-rotate-my-display-when-not-using-an-x-server
13. "Configure a user default session." GNOME Library. Accessed March 30, 2024. https://help.gnome.org/admin/system-admin-guide/stable/session-user.html.en
14. "Chapter 8. Setting a default desktop session for all users." Red Hat Customer Portal. Accessed March 30, 2024. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/administering_the_system_using_the_gnome_desktop_environment/proc_setting-a-default-desktop-session-for-all-users_administering-the-system-using-the-gnome-desktop-environment
