Chromebook
==========

.. contents:: Table of Contents

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

-  Using ``Secure Shell App``:

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

Linux
-----

Crostini
~~~~~~~~

Crostini is an official set of technologies used to securely run Linux (using a LXC container) on ChromeOS. By default, it runs Debian 10 Buster as of ChromeOS 80. [3] It does not require developer mode. Enable it by going into ChromeOS settings and selecting ``Linux (Beta)``. [1]

File Sharing
^^^^^^^^^^^^

The ``Files`` app will list ``Linux files``. That will load the visible contents of the ``/home/$USER/`` directory in the container. Directories from the ChromeOS hypervisor, such as ``Downloads``, can also be shared with the container. In the ``Files`` app, right-click on the directory and select ``Share with Linux``. It will be available in the container at ``/mnt/chromeos/MyFiles/``. [2]

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
