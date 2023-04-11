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

App Stores
----------

Google Play
~~~~~~~~~~~

Google Apps (GApps) provide a collection of applications including Gmail, Google Calender, Google Maps, Google Play Services, Google Play Store, and more. Only officially licensed Android phones have these. The Google Play Services adds additional APIs to help update the functionality of Android without a full operating system update. [3][4]

Devices without this can still sideload the Google Play Store and related dependencies. Download and install these applications in order from first to last [5]:

-  `Google Account Manager (com.google.gsf.login) <https://www.apkmirror.com/apk/google-inc/google-account-manager/google-account-manager-7-1-2-release/google-account-manager-7-1-2-android-apk-download/>`__ = Download the latest version.
-  `Google Services Framework (com.google.android.gsf) <https://www.apkmirror.com/apk/google-inc/google-services-framework/>`__ = Download the version that matches the Android version of the ROM.
-  `Google Play Services (com.google.android.gms) <https://www.apkmirror.com/apk/google-inc/google-play-services/>`__ = Download the latest version for the CPU architecture of the device.
-  `Google Play Store (com.android.vending) <https://www.apkmirror.com/apk/google-inc/google-play-store/variant-%7B%22arches_slug%22:%5B%22armeabi%22,%22armeabi-v7a%22,%22mips%22,%22mips64%22,%22x86%22,%22x86_64%22%5D,%22dpis_slug%22:%5B%22nodpi%22%5D%7D/>`__ = Download the latest version.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/android.rst>`__

Bibliography
------------

1. "How to install ADB on Windows, macOS, and Linux." XDA Portal & Forums. March 25, 2023. Accessed April 10, 2023. https://www.xda-developers.com/install-adb-windows-macos-linux/
2. "How To Install and Setup ADB Tools on Linux." ByteXD. April 5, 2022. Accessed April 10, 2023. https://bytexd.com/how-to-install-and-setup-adb-tools-on-linux/
3. "Google apps." LineageOS Wiki. April 9, 2023. Accessed April 10, 2023. https://wiki.lineageos.org/gapps
4. "What are Google Apps (GApps)? Why do we need them?" RootMyGalaxy. September 5, 2020. Accessed April 10, 2023. https://rootmygalaxy.net/google-apps-gapps-need/
5. "How to install the Google Play Store on any Android device." Android Police. March 29, 2023. Accessed April 10, 2023. https://www.androidpolice.com/install-google-play-store-any-android-device/
