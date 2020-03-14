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
-  Caps Lock: ``<SEARCH>`` + ``<ALT>``
-  Function keys 1 through 12: ``<SEARCH>`` + (``1`` THROUGH ``=``)
-  (Move to the next word): ``SHIFT`` + ``CTRL`` + (``<LEFT_ARROW>`` OR ``<RIGHT_ARROW>``)
-  (Dock a window to the left or right): ``<SEARCH>`` + (``[`` OR ``]``)
-  (Adjust the keyboard backlight): ``ALT`` + (``<BRIGHTNESS_DOWN>`` OR ``<BRIGHTNESS_UP>``)

[4]

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
13. "How to install Steam." r/Crostini Reddit. November 2, 2018. Accessed March 11, 2020. https://www.reddit.com/r/Crostini/wiki/howto/install-steam
14. "Auto Update Policy." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chrome/a/answer/6220366?hl=en
15. "Switch between stable, beta & dev software." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chromebook/answer/1086915?hl=en
