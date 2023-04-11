Android
=======

.. contents:: Table of Contents

Android Debug Bridge (ADB)
--------------------------

``adb`` is a client tool that can be used to copy files to and from an Android device, sideload apps, and flash custom ROMs. When the client is used, the ``adbd`` daemon will start automatically on the computer to faciliate sending commands to an Android device which will also be running a server.

Installation:

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S android-tools

-  Debian:

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install android-tools-adb

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install android-tools

On the Android device, enable developer options.

-  Settings > About phone > (tap "Build number" 7 times to enable Developer options)

Then enable debugging mode.

-  Settings > Additional settings > Developer options > USB debugging: on
-  Settings > Additional settings > Developer options > Wireless debugging: on

Verify that ADB is working.

.. code-block:: sh

   $ sudo adb devices
   List of devices attached
   <UUID>    device

[1][2]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/android.rst>`__

Bibliography
------------

1. "How to install ADB on Windows, macOS, and Linux." XDA Portal & Forums. March 25, 2023. Accessed April 10, 2023. https://www.xda-developers.com/install-adb-windows-macos-linux/
2. "How To Install and Setup ADB Tools on Linux." ByteXD. April 5, 2022. Accessed April 10, 2023. https://bytexd.com/how-to-install-and-setup-adb-tools-on-linux/
