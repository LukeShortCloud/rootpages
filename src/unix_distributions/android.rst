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

Bootloader Unlock
~~~~~~~~~~~~~~~~~

An unlocked bootloader is required to install a custom ROM. It will do a factory reset of the device so back up any data before proceeding.

-  Allow the bootloader to be modified.

   -  Settings > Additional settings > Developer options > OEM unlocking: On > Enable

-  Reboot into the bootloader and then verify that it can be accessed via ADB.

   .. code-block:: sh

      $ sudo adb reboot bootloader
      $ sudo fastboot devices
      <UUID>    fastboot

-  Unlock the bootloader.

   .. code-block:: sh

      $ sudo fastboot oem unlock

-  Setup the phone again and then re-enable ADB debugging support.

[6][7]

Custom Recovery Image
~~~~~~~~~~~~~~~~~~~~~

A custom recovery image is required to be setup to allow installing custom ROMs.

-  The latest Android devices use A/B partition schemes this is not compatible with most ROMs such as LineageOS. Additional partitions need to be `downloaded <https://wiki.lineageos.org/devices/>`__ and flashed.

   .. code-block:: sh

      $ sudo fastboot flash dtbo dtbo.img
      $ sudo fastboot flash vendor_boot vendor_boot.img

-  Flash a custom recovery image and then reboot to load up the new partition(s).

   .. code-block:: sh

      $ sudo fastboot flash boot boot.img
      $ sudo fastboot reboot

-  Go to the "Recovery mode" of the device and then format all of the data.

   -  Factory reset > Format data/factory reset > Format data

Custom ROM
~~~~~~~~~~

A custom ROM can finally be installed after the bootloader has been unlocked and a custom recovery image has been flashed.

-  Flash a custom ROM. `LineageOS <https://wiki.lineageos.org/devices/>`__ provides the most stable ROMs due to their focus on being close to upstream Android and strict working hardware requirements. [8]

   -  Apply update > Apply from ADB

      .. code-block:: sh

         $ sudo adb sideload <ROM>.zip

-  If the Google Play store will be installed, it has to be installed now and cannot be added later. It is part of the initial setup of the device. The device needs to first exit and re-enter the recovery mode to load up the new ROM changes.

   -  Advanced > Reboot to recovery
   -  Apply update > Apply from ADB

-  Download `MindTheGapps <https://wiki.lineageos.org/gapps#downloads>`__ for the relevant version of Android.

   .. code-block:: sh

      $ sudo adb sideload MindTheGapps-<VERSION>-<ARCHITECTURE>-<BUILD_DATE>-<BUILD_NUMBER>.zip

-  Finally, select "Reboot system now" to boot into the ROM.

[7]

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
6. "Beginner's guide to installing Lineage OS on your Android device." Anroid Authority. March 9, 2023. Accessed April 11, 2023. https://www.androidauthority.com/lineageos-install-guide-893303/
7. "Install LineageOS on lemonadep." LineageOS Wiki. April 11, 2023. Accessed April 11, 2023. https://wiki.lineageos.org/devices/lemonadep/install
8. "Hardware Support." GitHub LineageOS/charter. April 10, 2023. Accessed April 11, 2023. https://github.com/LineageOS/charter/blob/master/device-support-requirements.md#hardware-support
