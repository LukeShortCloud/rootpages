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

Amazon Appstore
~~~~~~~~~~~~~~~

The `Amazon Appstore <https://www.amazon.com/gp/mas/get/android>`__ is found on Kindle devices and can be sideloaded on other phones as well. It is the second largest Android app store behind Google Play. [13] It hosts free and paid apps.

APKUpdater
~~~~~~~~~~

`APKUpdater <https://github.com/rumboalla/apkupdater/releases>`__ is not an app store but provides functionality to update local apps. It checks other app stores for updates that it can download. Those app stores include: APKMirror, Aptoide, F-Droid, and Google Play. [14]

Aptoide
~~~~~~~

`Aptoide <https://en.aptoide.com/download?package_uname=aptoide>`__ is a community-driven app store. All apps on this platform are free but not necessarily open source.

F-Droid
~~~~~~~

`F-Droid <https://f-droid.org/en/>`__ provides a collection of free and open source apps.

Google Play
~~~~~~~~~~~

Google Apps (GApps) provide a collection of applications including Gmail, Google Calender, Google Maps, Google Play Services, Google Play Store, and more. Only officially licensed Android phones have these. The Google Play Services adds additional APIs to help update the functionality of Android without a full operating system update. [3][4]

Devices without this can still sideload the Google Play Store and related dependencies. Download and install these applications in order from first to last [5]:

-  `Google Account Manager (com.google.gsf.login) <https://www.apkmirror.com/apk/google-inc/google-account-manager/google-account-manager-7-1-2-release/google-account-manager-7-1-2-android-apk-download/>`__ = Download the latest version.
-  `Google Services Framework (com.google.android.gsf) <https://www.apkmirror.com/apk/google-inc/google-services-framework/>`__ = Download the version that matches the Android version of the ROM.
-  `Google Play Services (com.google.android.gms) <https://www.apkmirror.com/apk/google-inc/google-play-services/>`__ = Download the latest version for the CPU architecture of the device.
-  `Google Play Store (com.android.vending) <https://www.apkmirror.com/apk/google-inc/google-play-store/variant-%7B%22arches_slug%22:%5B%22armeabi%22,%22armeabi-v7a%22,%22mips%22,%22mips64%22,%22x86%22,%22x86_64%22%5D,%22dpis_slug%22:%5B%22nodpi%22%5D%7D/>`__ = Download the latest version.

Apps
----

GCam
~~~~

The Google Camera (GCam) app is exclusive to Google Pixel phones. It offers better picture quality over the stock Android camera app.

GCam can be installed on any Android device that supports the Camera2 API.

-  Use can app such as "Camera2 API Probe", "Camera2 Info", or "- Camera2 Test -" to verify the hardware support for the Camera2 API. The device must have either "FULL" or "LEVEL_3" hardware support.
-  Install the "Google Photos" app as this is required to preview photos in the GCam app.
-  Download and install GCam for the relevant Android version of the device from `here <https://www.celsoazevedo.com/files/android/google-camera/dev-suggested/>`__.

[16][17]

Google Meet
~~~~~~~~~~~

Google Meet can be used for audio and/or video calls. The audio codec used is Lyra which is very data efficient. [9][10] That codec uses a low birate when uploading from the sender. On the receiver side, it uses artificial intelligence to enhance the audio quality. Lyra 2 came out in 2022 which can use a minimum bitrate of 56 kbps. [11] The codec is automatically used when low bandwidth is detected. [12]

Linux
-----

Termux (PRroot)
~~~~~~~~~~~~~~~

Termux is an app that is available from F-Droid. The app hosted on the Google Play Store is no longer recommended as it is very outdated and unmaintained. [20] Termux provides a CLI tool known as `PRoot Distro <https://github.com/termux/proot-distro>`__. PRoot allows a non-root user to access and use a chroot environment. It supports setting up the following Linux distributions:

-  Alpine Linux
-  Arch Linux
-  Debian
-  Fedora
-  Manjaro
-  OpenSUSE
-  Pardus
-  Ubuntu
-  Void Linux

Usage:

-  View the current list of supported Linux distributions:

   .. code-block:: sh

      $ proot-distro list

-  Install the ``proot-distro`` CLI tool.

   .. code-block:: sh

      $ pkg install proot-distro

-  Install a Linux distrubtion. By default, it will use an alias that is the same name as the Linux distribution. That alias can be changed during install or renamed later.

   .. code-block:: sh

      $ proot-distro install <LINUX_DISTRO>

   .. code-block:: sh

      $ proot-distro install --override-alias <ALIAS> <LINUX_DiSTRO>

   .. code-block:: sh

      $ proot-distro rename <OLD_ALIAS> <NEW_ALIAS>

-  Login to the proot.

   .. code-block:: sh

      $ proot-distro login <ALIAS>

-  Delete the proot.

   .. code-block:: sh

      $ proot-distro remove <ALIAS>

[18][19]

Termux:X11
''''''''''

Termux:X11 is an experimental app that provides a Xwayland display server to work in a Termux proot environment. This runs locally so a desktop environment or a single graphical application can be seen on the Android device.

Known issues:

-  Termux:X11 only works with Debian 11. It is confirmed to not work with newer Linux distributions such as Arch Linux and Ubuntu 22.04. [21]
-  Mouse events are not fully captured making gaming difficult. [22]
-  Wayland is not fully supported. Only legacy Xorg applications are fully supported.
-  Stability issues. This project is still very experimental.


Desktop Environment
&&&&&&&&&&&&&&&&&&&

Install and configure a Linux proot with a desktop environment. This can be accessed via the Termux:X11 once it is fully set up.

-  Download ande sideload the latest GitHub Actions build artifact that is from the "master" branch from `here <https://github.com/termux/termux-x11/actions/workflows/debug_build.yml>`__. It is required to be logged into GitHub to be able to download it.
-  Unzip the archive.

   .. code-block:: sh

      $ unzip termux-x11.zip
      Archive:  termux-x11.zip
        inflating: app-debug.apk
        inflating: output-metadata.json
        inflating: termux-x11-<VERSION>-all.deb
        inflating: termux-x11-<VERSION>-any.pkg.tar.xz

-  Install the ``app-debug.apk`` on the Android device.
-  In Termux, update all packages.

   .. code-block:: sh

      (termux)$ pkg update

-  Install dependencies for Termux:X11. This includes launching a PulseAudio server when the Termux app starts for sound support.

   .. code-block:: sh

      (termux)$ pkg install pulseaudio
      (termux)$ nano ~/.profile
      pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
      pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
      (termux)$ pkg install x11-repo
      (termux)$ pkg install xwayland xorg-server-xvfb

-  Install the Debian package for Termux:X11 in Termux. This first requires giving Termux access to the Android file system.

   .. code-block:: sh

      (termux)$ termux-setup-storage
      (termux)$ dpkg -i storage/shared/Download/termux-x11/termux-x11-<VERSION>-all.deb

-  Allow Termux:X11 to run commands within the Termux app.

   .. code-block:: sh

      (termux)$ nano ~/.termux/termux.properties
      allow-external-apps = yes

-  Force stop and then re-open the Termux app to load up the new properties that were just configured.
-  Open the Termux:X11 app and leave it open in the background.
-  Switch to the Termux app. Install and use either Arch Linux or Debian (recommended). A non-root user is required.

   -  Arch Linux:

      .. code-block:: sh

         (termux)$ proot-distro install archlinux
         (termux)$ proot-distro login archlinux
         (archlinux)$ pacman -Syyu
         (archlinux)$ nano /etc/locale.gen
         en_US.UTF-8 UTF-8
         (archlinux)$ echo 'LANG=en_US.UTF-8' > /etc/locale.conf
         (archlinux)$ locale-gen
         (archlinux)$ ln -s /usr/share/zoneinfo/<COUNTRY>/<CITY> /etc/localtime
         (archlinux)$ passwd root
         (archlinux)$ useradd -m -g users -G wheel,audio,video,storage -s /bin/bash <USER>
         (archlinux)$ passwd <USER>
         (archlinux)$ pacman -S sudo
         (archlinux)$ echo '<USER> ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/<USER>
         (archlinux)$ chmod 0440 /etc/sudoers.d/<USER>
         (archlinux)$ su - <USER>
         (archlinux)$ nano ~/.profile
         export PULSE_SERVER=127.0.0.1
         pulseaudio --start --disable-shm=1 --exit-idle-time=-1
         (archlinux)$ sudo pacman -S firefox networkmanager pulseaudio xfce4 xfce4-goodies xorg xorg-server
         (archlinux)$ sudo pacman -S --needed base-devel git && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

   -  Debian:

      .. code-block:: sh

         (termux)$ proot-distro install debian
         (termux)$ proot-distro login debian
         (debian)$ apt-get update
         (debian)$ apt-get upgrade
         (debian)$ apt-get install locales
         (debian)$ nano /etc/locale.gen
         en_US.UTF-8 UTF-8
         (debian)$ echo 'LANG=en_US.UTF-8' > /etc/locale.conf
         (debian)$ locale-gen
         (debian)$ rm -f /etc/localtime
         (debian)$ ln -s /usr/share/zoneinfo/<COUNTRY>/<CITY> /etc/localtime
         (debian)$ passwd root
         (debian)$ groupadd storage
         (debian)$ groupadd wheel
         (debian)$ useradd -m -g users -G wheel,audio,video,storage -s /bin/bash <USER>
         (debian)$ passwd <USER>
         (debian)$ apt-get install sudo
         (debian)$ echo '<USER> ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/<USER>
         (debian)$ chmod 0440 /etc/sudoers.d/<USER>
         (debian)$ su - <USER>
         (debian)$ nano ~/.profile
         export PULSE_SERVER=127.0.0.1
         pulseaudio --start --disable-shm=1 --exit-idle-time=-1
         (debian)$ sudo pacman -S firefox-esr network-manager pulseaudio xfce4 xfce4-goodies xorg xserver-xorg-core

-  Optionally configure and start a VNC server. This can only be accessed from a VNC viewer app on the Android device itself. VNC is also a slower desktop streaming protocol so gaming is not possible. Termux:X11 is recommended instead because it provides direct access to the display server.

   -  Install a VNC server.

      -  Arch Linux:

         .. code-block:: sh

            (archlinux)$ sudo pacman -S tigervnc

      -   Debian [28]:

         .. code-block:: sh

            (debian)$ sudo apt-get install tigervnc-standalone-server tigervnc-common tightvncserver

   -  Configure and start a VNC server.

      .. code-block:: sh

         (archlinux)$ vncpasswd
         (archlinux)$ nano ~/.vnc/config
         session=xfce4
         geometry=1920x1080
         localhost
         (archlinux)$ nano ~/.vnc/xstartup
         #!/bin/bash
         unset SESSION_MANAGER
         unset DBUS_SESSION_BUS_ADDRESS
         export PULSE_SERVER=127.0.0.1
         pulseaudio --start --disable-shm=1 --exit-idle-time=-1
         dbus-launch --exit-with-session xfce4-session
         (archlinux)$ vncserver :1

-  Start the display server in Termux (not the proot).

   .. code-block:: sh

      (debian)$ exit
      (termux)$ XDG_RUNTIME_DIR="${TMPDIR}" termux-x11 :1 &

-  Enter the proot. The temporary directory must be shared to access information about the Xorg display server that Xwayland is emulating.

   .. code-block:: sh

      (termux)$ proot-distro login --user <USER> --shared-tmp debian

-  Launch the XFCE desktop environment. [23]

   .. code-block:: sh

      (debian)$ export DISPLAY=:1 XDG_RUNTIME_DIR="${TMPDIR}"
      (debian)$ dbus-launch --exit-with-session xfce4-session &

[24][25][26][27]

Raspberry Pi
------------

For the Raspberry Pi single-board computers, it is recommended to use custom LineageOS ROMs from `KonstaKANG.com <https://konstakang.com/devices/rpi4/>`__. They provide both a tablet ROM and an Android TV ROM. [15]

Troubleshooting
---------------

Errors
~~~~~~

Error when starting Xwayland using Termux:X11.

::

   (termux)$ DISPLAY=:0 termux-x11
   Starting Xwayland
   _XSERVTransSocketUNIXCreateListener: ...SocketCreateListener() failed
   _XSERVTransMakeAllCOTSServerListeners: server already running
   (EE)
   Fatal server error:
   (EE) Cannot establish any listening sockets - Make sure an X server isn't already running(EE)

Solutions:

-  If Xwayland is already running, either kill off the related processes or reboot the Android device. [29]

   .. code-block:: sh

      (termux)$ killall xwayland

-  If Xwayland is not running, clean the temporary directory as it may contain various X11 lock files. [30]

   .. code-block:: sh

      (termux)$ rm -rf ${TMPDIR}/*
      (termux)$ rm -rf ${TMPDIR}/.*

-  There used to be a known bug about a related issue. Update to the latest version of Termux:X11. [29]

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
9. "Google Lyra will enable voice calls for another billion users." Tech Xplore. April 7, 2021. Accessed April 11, 2023. https://techxplore.com/news/2021-04-google-lyra-enable-voice-billion.html
10. "Google Duo is Google Meet." Google Workspace Admin Help. Accessed April 11, 2023. https://support.google.com/a/answer/12206824?hl=en
11. "Lyra V2 - a better, faster, and more versatile speech codec." Google Open Source Blog. September 30, 2022. Accessed April 11, 2023. https://opensource.googleblog.com/2022/09/lyra-v2-a-better-faster-and-more-versatile-speech-codec.html
12. "Lyra, Satin and the future of voice codecs in WebRTC." BlogGeek.Me. April 19, 2021. Accessed April 11, 2023. https://bloggeek.me/lyra-satin-webrtc-voice-codecs/
13. "Google Play Store Vs. Amazon App Store: The Clash of The App Store Players." Mobile App Daily. March 14, 2023. Accessed April 11, 2023. https://www.mobileappdaily.com/google-play-store-vs-amazon-app-store
14. "APKUpdater." GitHub rumboalla/apkupdater. March 14, 2023. Accessed April 11, 2023. https://github.com/rumboalla/apkupdater
15. "Installing Android on Raspberry Pi 4 with Play Store." RaspberryTips. August 14, 2022. Accessed April 11, 2023. https://raspberrytips.com/android-raspberry-pi-4/
16. "How to Install GCam on Non-Google Pixel Phones." Geekflare Articles. November 22, 2022. Accessed April 12, 2023. https://geekflare.com/install-gcam-on-non-pixel-phones/
17. "How To Install and Use GCam." Google Camera Port. Accessed April 12, 2023. https://www.celsoazevedo.com/files/android/google-camera/how-to/
18. "PRoot." Termux Wiki. Accessed April 13, 2023. https://wiki.termux.com/wiki/PRoot
19. "PRoot Distro." GitHub termux/proot-distro. April 6, 2023. Accessed April 12, 2023. https://github.com/termux/proot-distro
20. "Do not install Termux from Play Store!" Reddit r/termux. December 24, 2022. Accessed April 12, 2023. https://www.reddit.com/r/termux/comments/zu8ets/do_not_install_termux_from_play_store/
21. "Unable to get Termux:X11 working in a proot-distro #299." GitHub termux/termux-x11. April 15, 2023. Accessed May 5, 2023. https://github.com/termux/termux-x11/issues/299
22. "Mouse capture #223." GitHub termux/termux-x11. February 21, 2023. Accessed May 5, 2023. https://github.com/termux/termux-x11/issues/223
23. "xfce4-session stays just black #205." GitHub termux/termux-x11. March 17, 2023. Accessed May 5, 2023. https://github.com/termux/termux-x11/issues/205
24. "How to install Arch Linux ARM on Android phone (Termux Proot-distro)." Ivon's Blog. August 7, 2022. Accessed May 5, 2023. https://ivonblog.com/en-us/posts/termux-proot-distro-archlinux/
25. "How to use Termux X11 - The X server on Android phone." Ivon's Blog. March 8, 2023. Accessed May 5, 2023. https://ivonblog.com/en-us/posts/termux-x11/
26. "setting up termux-x11." udroid wiki. April 22, 2023. Accessed May 5, 2023. https://udroid-rc.gitbook.io/udroid-wiki/udroid-landing/setting-up-gui/termux-x11
27. "Graphical Environment." Termux Wiki. Accessed May 5, 2023. https://wiki.termux.com/wiki/Graphical_Environment
28. "Install and Configure TigerVNC VNC Server on Debian 11/10." ComputingForGeeks. February 16, 2023. Accessed May 5, 2023. https://computingforgeeks.com/install-and-configure-tigervnc-vnc-server-on-debian/
29. "running termux-x11 fails #222." GitHub termux/termux-x11. March 3, 2023. Accessed May 5, 2023. https://github.com/termux/termux-x11/issues/222
30. "unable to start termux x11 #151." GitHub termux/termux-x11. February 5, 2023. Accessed May 5, 2023. https://github.com/termux/termux-x11/issues/151
