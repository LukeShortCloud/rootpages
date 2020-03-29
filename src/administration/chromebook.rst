Chromebook
==========

.. contents:: Table of Contents

Support
-------

Chromebooks recieve anywhere between 5 and 8 years of Chrome OS updates [14]. When it becomes end-of-life, the operating system will continue to work but will also become vulnerable to unpatched security flaws. A list of every Chromebooks' update expiration date can be found `here <https://support.google.com/chrome/a/answer/6220366?hl=en>`__.

There are three update channels to choose from for Chrome OS updates. This can be changed by going to: ``Settings`` > ``About Chrome OS`` > ``Additional details`` > ``Channel`` > ``Change channel`` [15].

-  Stable (default) = Minor updates every 3 weeks. Major upgrades every 6 weeks.
-  Beta = Minor updates every week. Major upgrades every 6 weeks.
-  Developer = Updates twice a week. Those updates can be minor or major and usually contain new experimental features. This is not to be confused with ``Developer Mode`` which is different.

Keyboard Shortcuts
------------------

Chromebooks come with modified keyboards that do not include the traditional layout of keys. These are shortcuts that replace some of those dedicated keys and also improve the experience of using ChromeOS. Note that the ``<SEARCH>`` key is located where the ``<CAPS_LOCK>`` key normally is.

-  (View keyboard shortcuts): ``CTRL`` + ``ALT`` + (``?`` OR ``/``)
-  Page Up: ``<SEARCH>`` + ``<UP_ARROW>``
-  Page Down: ``<SEARCH>`` + ``<DOWN_ARROW>``
-  Home (start of line): ``<SEARCH>`` + ``<LEFT_ARROW>``
-  End (end of line): ``<SEARCH>`` + ``<RIGHT_ARROW>``
-  Delete (backspace in reverse): ``<SEARCH>`` + ``backspace``
-  Caps Lock: ``<SEARCH>`` + ``<ALT>``
-  Function keys 1 through 12: ``<SEARCH>`` + (``1`` THROUGH ``=``)
-  (Move to the next word): ``SHIFT`` + ``CTRL`` + (``<LEFT_ARROW>`` OR ``<RIGHT_ARROW>``)
-  (Dock a window to the left or right): ``ALT`` + (``[`` OR ``]``)
-  (Dock a window to the top or bottom)*: ``ALT`` + ``SHIFT`` + (``<UP_ARROW>`` OR ``<DOWN_ARROW>``)
-  (Adjust the keyboard backlight): ``ALT`` + (``<BRIGHTNESS_DOWN>`` OR ``<BRIGHTNESS_UP>``)
-  (View all windows and virtual desks): ``[]||``
-  (Create a new virtual desk): ``SHIFT`` + ``<SEARCH>`` + ``+``
-  (Close a virtual desk. All windows will be moved to the next available virtual desk): ``SHIFT`` + ``<SEARCH>`` + ``-``
-  (Move to the next virtual desk): ``<SEARCH>`` + (``[`` OR ``]``)
-  (Move to the next word): ``CTRL`` + (``<LEFT_ARROW>`` OR ``<RIGHT_ARROW>``)

[4]

\*Requires the `Windows Manager for Google Chrome <https://chrome.google.com/webstore/detail/windows-manager-for-googl/gophpkegccafhjahoijdembdkbjpiflb>`__ extension.

Developer Mode
--------------

Chromebooks have an optional developer mode that unlocks additional features of Chrome OS. It allows the usage of a shell, ``root`` user access, and the ability to install and boot custom operating systems. [5]

Enabling this mode will powerwash (reset) the device. Start the Chromebook in Recovery mode by pressing ``ESC`` + ``<REFRESH>`` + ``<POWER>``. Once booted, press ``CTRL`` + ``d`` to boot into developer mode. Optionally select to enable debugging features to allow writing to the root file system, booting to external storage devices, and changing the root password. [6][8] After compeletion, whenever booting up the Chromebook, use ``CTRL`` + ``d`` to boot Chrome OS.

Use the command ``chromeos-setdevpasswd`` to enable the sudo password for the ``chronos`` user in the ``Secure Shell App``. Use the password that was set when enabling debugging features to access the ``root`` account.

-  Using ``Secure Shell App`` by pressing ``CTRL`` + ``ALT`` + ``t``:

::

   crosh> shell
   crosh> ssh -l root 127.0.0.1
   chronos@loclahost / $ chromeos-setdevpasswd

-  Using the tty2 console by pressing ``CTRL`` + ``ALT`` + ``-->``:

::

   localhost login: root
   Password:
   localhost ~ # chromeos-setdevpasswd

Boot
~~~~

When booting a Chromebook in developer mode, there are a few options to choose from. By default, a screen will appear for 30 seconds saying ``OS verification is OFF``. It will beep and continue to boot into local storage if no boot option is specified via keyboard shortcuts. Pressing the ``<SPACE>`` bar will powerwash the Chromebook.

-  Internal storage = ``CTRL`` + ``d``.
-  External storage = ``CTRL`` + ``u``.
-  Legacy boot loader (SeaBIOS) = ``CTRL`` + ``l`` (L).

[7]

Terminal
~~~~~~~~

The ``Secure Shell App`` is the official way to access a shell terminal from within Chrome OS. With the Google Chrome web browser open, press ``CTRL`` + ``ALT`` + ``t`` to open the app. It will start in ``crosh`` (the Chrome Shell).

View all of the available commands in ``crosh`` and their help descriptions.

::

   crosh> help
   crosh> help_advanced

Open a full shell terminal in developer mode to access more commands.

::

   crosh> shell

The app will beep if a command or file cannot be auto-completed. This can be disabled. Open preferences: ``CTRL`` + ``SHIFT`` + ``p``. Go to ``Sounds`` > ``Alert bell sound (URI)`` and then remove the string.

Chromebrew
----------

Chromebrew is an unofficial package manager for Chromium OS written in Ruby. It works on all processor architectures that Chromium OS supports. It requires ``Developer Mode`` to be enabled.

Install:

.. code-block:: sh

   $ curl -Ls git.io/vddgY | bash

Usage:

.. code-block:: sh

   $ crew {build,const,download,files,help,install,list,postinstall,reinstall,remove,search,update,upgrade,whatprovides}
   $ crew help <ARGUMENT>

Find and install a package. The `full list of packages <https://github.com/skycocker/chromebrew/tree/master/packages>`__ is listed in it's GitHub repository. Over one thousand packages are available.

.. code-block:: sh

   $ crew search <PACKAGE>
   $ crew install [--build-from-source] <PACKAGE>

Installing a package will remove other packages that are already installed. Use the ``--keep`` argument to prevent uninstalling them:

.. code-block:: sh

   $ crew install --keep <INSTALLED_PACKAGE> <NEW_PACKAGE>

[19]

Linux
-----

Crostini
~~~~~~~~

Crostini is an official set of technologies used to securely run Linux on ChromeOS in an isolated environment. It creates a minimal Chrome OS virtual machine (VM) called ``termina`` that then starts a LXC container named ``penguin``.  By default, the ``penguin`` container uses Debian 10 Buster as of ChromeOS 80. [3] It does not require developer mode. Enable it by going into ChromeOS settings and selecting ``Linux (Beta)``. [1]

Container Management
^^^^^^^^^^^^^^^^^^^^

With developer mode enabled, the ``termina`` VM can be manually edited with the ``vmc`` command. It can enable GPU acceleration, enable audio capture, export/save the VM, share files, and attach USB devices. New containers can also be created.

-  Manually start and connect to the ``termina`` VM.

::

   crosh> vmc start termina
   (termina) chronos@localhost ~ $

-  Manually connect to an already running ``termina`` VM.

::

   crosh> vsh termina
   (termina) chronos@localhost ~ $

-  View all of the created containers. By default, there should only be the ``penguin`` container.

::

   (termina) chronos@localhost ~ $ lxc ls

-  A list of all LXC images can be found `here <https://us.images.linuxcontainers.org/>`__ or by running:

::

   (termina) chronos@localhost ~ $ lxc image list images:

-  Create new containers:

::

   (termina) chronos@localhost ~ $ lxc launch images:<IMAGE_NAME>/<IMAGE_VERSION>/amd64 <CONTAINER_NAME>

::

   (termina) chronos@localhost ~ $ lxc launch images:centos/8/amd64 centos8

-  Enter a container [9]:

::

   (termina) chronos@localhost ~ $ lxc exec <CONTAINER_NAME> /bin/bash
   [root@<CONTAINER_NAME> ~]# cat /etc/os-release

-  The VM can be reset by stopping, deleting, and then starting it again. If the ``termina`` VM does not exist, ``vmc`` will create it. [10]

::

   crosh> vmc stop termina
   crosh> vmc destroy termina
   crosh> vmc start termina

File Sharing
^^^^^^^^^^^^

The ``Files`` app will list ``Linux files``. That will load the visible contents of the ``/home/$USER/`` directory in the container. Directories from the ChromeOS hypervisor, such as ``Downloads``, can also be shared with the container. In the ``Files`` app, right-click on the directory and select ``Share with Linux``. It will be available in the container at ``/mnt/chromeos/MyFiles/``. [2]

GPU Acceleration
^^^^^^^^^^^^^^^^

Crostini supports OpenGL graphics hardware acceleration via the use of `Virgil 3d <https://virgil3d.github.io/>`__. This allows the passthrough of OpenGL calls from the virtual machine ``termina`` to the host system. Vulkan passthrough support is planned to be released in 2020. [11] For gaming, it is recommended to enable these flags:

-  chrome://flags#crostini-gpu-support = Enable Virgil 3d support. It is enabled by default as of Chrome OS 80 [12].
-  chrome://flags#scheduler-configuration = Enable hyper-threading on Chrome OS (if available on the processor). This will help improve the performance of games by allowing the virtual machine to use more processing power.
-  chrome://flags#exo-pointer-lock = Lock the mouse pointer to any application running in Crostini. Games that use the mouse for movement require this.

Verify that the processor count has doubled.

::

   user@penguin:~$ grep -c ^processor /proc/cpuinfo
   4

Verify that Virgil 3d is being recognized by OpenGL.

::

   user@penguin:~$ sudo apt-get install mesa-utils
   user@penguin:~$ glxinfo | grep "OpenGL renderer"
   OpenGL renderer string: virgl

Steam
'''''

Steam requires a handful of dependencies. Enable the proprietary repository to install Steam, enable 32-bit packages, and install recommended dependencies for Wine. These will be required to run native Linux games or Windows games running with Proton (Valve's forked version of Wine) [13].

::

   user@penguin~$ sudo usermod -a -G video,audio $USER
   user@penguin~$ sudo nano /etc/apt/sources.list.d/non-free.list
   deb http://deb.debian.org/debian buster main contrib non-free
   deb http://security.debian.org/ buster/updates main contrib non-free
   user@penguin~$ sudo dpkg --add-architecture i386
   user@penguin~$ sudo apt-get install --install-recommends wine
   user@penguin~$ sudo apt-get install libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libglapi-mesa:i386 steam

Proton uses DXVK to translate DirectX 9, 10, and 11 to Vulkan. Because there is currently no Vulkan hardware acceleration, start Steam and have it use the WineD3D translation layer for DirectX 9, 10, 11 to OpenGL.

::

   user@penguin:~$ PROTON_USE_WINED3D=1 steam

Change the Default Operating System
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The default Linux container ``penguin`` can be changed to use a different operating system other than Debian. The container requires `cros-container-guest-tools <https://chromium.googlesource.com/chromiumos/containers/cros-container-guest-tools/>`__ which provides a set of tools and services for Crostini integration. Wayland is optionally required to run graphical applications.

**All**

Stop and rename the original container.

::

   crosh> vsh termina
   (termina) chronos@localhost ~ $ lxc stop penguin
   (termina) chronos@localhost ~ $ lxc rename penguin penguin-original
   (termina) chronos@localhost ~ $ lxc launch images:<IMAGE_NAME>/<IMAGE_VERSION> penguin

Create a user using the same username as the Chrome OS user (which is normally the first part of the e-mail address used to log in: ``<CHROME_OS_USER>@gmail.com``). This user should have privileged access via the use of ``sudo``.

::

   (termina) chronos@localhost ~ $ lxc exec penguin /bin/bash
   [root@penguin ~]# useradd <CHROME_OS_USER>
   [root@penguin ~]# mkdir /etc/sudoers.d/
   [root@penguin ~]# echo '<CHROME_OS_USER> ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/<CHROME_OS_USER>
   [root@penguin ~]# chmod 0440 /etc/sudoers.d/<CHROME_OS_USER>

**archlinux/current**

First install a package manager such as `yay <https://github.com/Jguer/yay>`__. This is required to install packages from the Arch Linux User Repository (AUR).

::

   [root@penguin ~]# yay -S cros-container-guest-tools-git
   [root@penguin ~]# pacman -S sudo wayland xorg-server-xwayland

[16]

**centos/8**

::

   [root@penguin ~]# dnf install epel-release sudo xorg-x11-server-Xwayland
   [root@penguin ~]# dnf install cros-guest-tools --enablerepo=epel-testing

[17]

**fedora/31**

::

   [root@penguin ~]# dnf install sudo xorg-x11-server-Xwayland
   [root@penguin ~]# dnf install cros-guest-tools sudo --enablerepo=updates-testing

[18]

**All**

Enable the required services and then restart the virtual machine to load the new ``penguin`` container integration.

::

   [root@penguin ~]# systemctl enable cros-sftp
   [root@penguin ~]# su - <CHROME_OS_USER>
   [<CHROME_OS_USER>@penguin ~]$ systemctl --user enable sommelier@0 sommelier-x@0 sommlier@1 sommelier-x@1 cros-garcon cros-pulse-config

::

   crosh> vmc stop termina
   crosh> vmc start termina

Crouton
~~~~~~~

Crouton allows installing Debian based operating systems into a chroot directory. It supports better integration with Chrome OS via the `crouton integration extenstion <https://chrome.google.com/webstore/detail/crouton-integration/gcpneefbbnfalgjniomfjknbcgkbijom>`__.

Advantages of Crouton over Crostini:

-  Complete OpenGL and Vulkan hardware-accelerated support.

    -  Virgil, used by Crostini for OpenGL acceleration, is `limited to OpenGL 4.3 <https://lwn.net/Articles/767970/>`__ and older versions. OpenGL 4.6 is the current latest version. Virgil also lacks Vulkan support.

-  Lower disk space usage.
-  No virtualization overhead.
-  Optional installation to an external storage device.
-  Chroot Linux installations can be encrypted.
-  Support for all processor architectures. Crostini only works on 64-bit Chrome OS devices.

Cons:

-  Insecure compared to Crostini. Resources are not isolated from the Chrome OS operating system.
-  Requires ``Developer Mode`` to be enabled.
-  Installs an old operating system by default (Ubuntu 16.04).

Download and install the ``crouton`` script to a location found in ``$PATH``. Alternatively, it can be executed from any user directory.

::

   crosh> shell
   chronos@localhost / $ cd ~/Downloads/
   chronos@localhost ~/Downloads $ wget https://goo.gl/fd3zc -O crouton
   chronos@localhost ~/Downloads $ sudo install -Dt /usr/local/bin -m 755 ~/Downloads/crouton

Chroot Management
^^^^^^^^^^^^^^^^^

Supported configurations:

-  Desktop environments:

   -  gnome
   -  kde
   -  lxde
   -  unity
   -  xfce

-  Operating systems:

   -  Debian
   -  Kali Linux
   -  Ubuntu

View available operating system versions that can be installed along with the types of packages than can be automatically configured. By default, Ubuntu 16.04 is installed with the XFCE desktop environment.

::

   chronos@localhost / $ crouton -r list
   chronos@localhost / $ crouton -t list

Example of creating a minimal chroot.

::

   chronos@localhost / $ sudo crouton -t core

Example of installing Debian Sid, with common features enabled, encrypting the chroot, and naming the chroot "debian_sid_crouton".

::

   chronos@localhost / $ sudo crouton -r sid -t core,audio,touch,keyboard,extension,xorg,xfce -e -n debian_sid_crouton

[20]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/administration/chromebook.rst>`__

Bibliography
------------

1. "Running Custom Containers Under Chrome OS." Chromium OS Docs. Accessed March 2, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/containers_and_vms.md
2. "Issue 878324: Share Downloads with crostini container." Chromium Bugs. May 6, 2019. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=878324
3. "Issue 930901: crostini: support buster as the default container." Chromium Bugs. February 7, 2020. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=930901
4. "Chromebook keyboard shortcuts." Chromebook Help. Accessed March 2, 2020. https://support.google.com/chromebook/answer/183101?hl=en
5. "Developer Mode." Chromium OS Docs. Accessed March 4, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/developer_mode.md
6. "Turn on debugging features." Chromebook Help. Accessed March 4, 2020. https://support.google.com/chromebook/answer/6204310?hl=en
7. "Debug Button Shortcuts." Chromium OS Docs. Accessed March 4, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/debug_buttons.md
8. "Debugging Features." Chromium OS. Accessed March 4, 2020. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/debugging-features
9. "LXD Getting started - command line." Linux containers. Accessed March 7, 2020. https://linuxcontainers.org/lxd/getting-started-cli/
10. "Crostini Setup Guide." Reddit r/Crostini. December 27, 2018. Accessed March 7, 2020. https://www.reddit.com/r/Crostini/wiki/getstarted/crostini-setup-guide
11. "Issue 996591: Vulkan does not appear to be working in Crostini." Chromium Bugs. February 12, 2020. Accessed March 11, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=996591
12. "CHROME OS 80 MAKES GRAPHIC INTENSIVE LINUX APPS SO MUCH BETTER." Chrome Unboxed. March 10, 2020. Accessed March 11, 2020. https://chromeunboxed.com/chrome-os-80-gpu-linux-apps-enabled/
13. "How to install Steam." Reddit r/Crostini. November 2, 2018. Accessed March 11, 2020. https://www.reddit.com/r/Crostini/wiki/howto/install-steam
14. "Auto Update Policy." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chrome/a/answer/6220366?hl=en
15. "Switch between stable, beta & dev software." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chromebook/answer/1086915?hl=en
16. "Chrome OS devices/Crostini." Arch Linux Wiki. February 17, 2020. Accessed March 14, 2020. https://wiki.archlinux.org/index.php/Chrome_OS_devices/Crostini
17. "How to run CentOS instead of Debian." Reddit r/Crostini. October 16, 2019. Accessed March 14, 2020. https://www.reddit.com/r/Crostini/wiki/howto/run-centos-linux
18. "How to run Fedora instead of Debian." Reddit r/Crostini. December 21, 2019. Accessed March 14, 2020. https://www.reddit.com/r/Crostini/wiki/howto/run-fedora-linux
19. "skycocker/chromebrew." GitHub. March 28, 2020. Accessed March 28, 2020. https://github.com/skycocker/chromebrew
20. "dnschneid/crouton." GitHub. January 17, 2020. Accessed March 29, 2020. https://github.com/dnschneid/crouton
