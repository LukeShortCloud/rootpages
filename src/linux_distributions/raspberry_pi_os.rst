Raspberry Pi OS
===============

.. contents:: Table of Contents

Downloads
---------

Official
~~~~~~~~

There are three official images provided for Raspberry Pi OS by the Raspberry Pi Foundation. [2] All of these are based on Debian. These are the main features of each: [3]

.. csv-table::
   :header: Image Name, Minimum SD Card Size, Desktop Environment, Office Suite
   :widths: 20, 20, 20, 20

   Raspberry Pi OS with desktop and recommended software, 16 GB, LXDE, LibreOffice
   Raspberry Pi OS with desktop, 8 GB, LXDE, None
   Raspberry Pi OS Lite, 4 GB, None, None

Unofficial
~~~~~~~~~~

These are third-party images that are not from the Raspberry Pi foundation:

-  `Arch Linux <https://archlinuxarm.org/>`__

   -  `Raspberry Pi 4 <https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4>`__

-  `Debian (upstream) <https://raspi.debian.net/tested-images/>`__
-  `Fedora <https://fedoraproject.org/wiki/Architectures/ARM/Raspberry_Pi>`__
-  `Manjaro <https://manjaro.org/download/#ARM>`__
-  openSUSE

    -  `Raspberry Pi 4 <https://en.opensuse.org/HCL:Raspberry_Pi4>`__

-  [Red Hat] Enterprise Linux

   -  `AlmaLinux <https://github.com/AlmaLinux/raspberry-pi>`__

-  `Ubuntu <https://ubuntu.com/download/raspberry-pi>`__

SSH
---

By default, SSH is disabled. Enable it to allow SSH access:

- GUI = Raspberry Pi Configuration > Preferences > Interfaces> SSH: Enabled
- CLI = ``sudo raspi-config`` > Interfacing Options > SSH: Yes > Ok > Finish
- CLI headless = Mount the ``/boot/`` (first) partition and then create an empty directory called ``ssh`` in it. On the next boot, SSH will be enabled and started.

Log into the IP address of the Raspberry Pi using the username ``pi`` and password ``raspberry``. [1]

Wi-Fi
-----

Starting with the release of the Raspberry Pi 3 Model B, the Raspberry Pi includes built-in Wi-Fi hardware. Connect to a Wi-Fi network using one of these methods:

- GUI = Select the Wi-Fi icon in the top-right of the desktop.
- CLI = ``sudo raspi-config`` > Network Options > Wi-fi
- CLI headless =  Mount the ``/boot/`` (first) partition of Raspberry Pi OS. Then create a file called ``wpa_supplicant.conf`` in that directory with these contents below. Configure the country, SSID (Wi-FI username), and PSK (Wi-Fi password). Upon the next boot, this file will be moved to the correct location and the WiFi service will be enabled and started automatically.

   ::

      country=<TWO_LETTER_COUNTRY_CODE>
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
      network={
          ssid="<WIFI_USERNAME>"
          psk="<WIFI_PASSWORD>"
          key_mgmt=WPA-PSK
      }

[4]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/raspberry_pi_os.rst>`__

Bibliography
------------

1. "Remote Access." Raspberry Pi Documentation. August 22, 2021. Accessed August 24, 2021. https://www.raspberrypi.org/documentation/computers/remote-access.html
2. "Operating system images." Raspberry Pi. Accessed August 24, 2021. https://www.raspberrypi.org/software/operating-systems/
3. "Hands on with the new Raspberry Pi OS release: Here's what you need to know." ZDNet. December 10, 2020. Accessed August 24, 2021.
4. "How To Configure WiFi on Raspberry Pi: Step By Step Tutorial." Latest Open Tech From Seed. 2021. Accessed May 12, 2022. https://www.seeedstudio.com/blog/2021/01/25/three-methods-to-configure-raspberry-pi-wifi
