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

These images can be downloaded from `here <https://www.raspberrypi.com/software/operating-systems/>`__.

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

Projects
--------

LightShow Pi
~~~~~~~~~~~~

This projects creates a light show using GPU-accelerated mathematical equations to automatically figure out when to turn lights on and off. It processes the frequency of any given audio file to help determine that. It is commonly used for holiday house light shows.

Installation
^^^^^^^^^^^^

Requirements:

-  Raspberry Pi OS based on Debian 10 Buster

    -  Raspberry Pi OS based on Deiban 11 Bullseye is not supported because the WiringPi Python project it relies on has been deprecated and does not work on newer versions of Debian.

-  Raspberry Pi 3 Model B+

    -  The Raspberry Pi 4 is only partially supported because it does not support GPU acceleration for the NumPy library it uses.

Install LightShow Pi as the ``pi`` user [5]:

.. code-block:: sh

   $ cd ~
   $ git clone https://togiles@bitbucket.org/togiles/lightshowpi.git
   $ cd lightshowpi
   $ git checkout stable
   $ sudo ./install.sh
   $ echo 'export SYNCHRONIZED_LIGHTS_HOME=/home/pi/lightshowpi' >> ~/.bashrc
   $ sudo reboot

Usage
^^^^^

First, move to the LightShow Pi directory:

.. code-block:: sh

   $ cd ~/lightshowpi/

Verify that LightShow Pi can turn on and off all of the lights [6]:

.. code-block:: sh

   $ sudo python py/hardware_controller.py --state=flash
   $ sudo python py/hardware_controller.py --state=fade

Play one of the included sample songs to ensure the audio output is working [7]:

.. code-block:: sh

   $ sudo python py/synchronized_lights.py --file=/home/pi/lightshowpi/music/sample/ovenrake_deck-the-halls.mp3

Play any song:

.. code-block:: sh

   $ sudo python py/synchronized_lights.py --file=<PATH_TO_AUDIO_FILE>

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/raspberry_pi_os.rst>`__

Bibliography
------------

1. "Remote Access." Raspberry Pi Documentation. August 22, 2021. Accessed August 24, 2021. https://www.raspberrypi.org/documentation/computers/remote-access.html
2. "Operating system images." Raspberry Pi. Accessed August 24, 2021. https://www.raspberrypi.org/software/operating-systems/
3. "Hands on with the new Raspberry Pi OS release: Here's what you need to know." ZDNet. December 10, 2020. Accessed August 24, 2021.
4. "How To Configure WiFi on Raspberry Pi: Step By Step Tutorial." Latest Open Tech From Seed. 2021. Accessed May 12, 2022. https://www.seeedstudio.com/blog/2021/01/25/three-methods-to-configure-raspberry-pi-wifi
5. "Download and Install." LightShow Pi. Accessed May 12, 2022. https://www.lightshowpi.org/download-and-install/
6. "Configuring and Testing Your Hardware." Accessed May 12, 2022. https://www.lightshowpi.org/configuring-and-testing-your-hardware/
7. "Play Music." LightShow Pi. Accessed May 12, 2022. https://www.lightshowpi.org/configuring-and-testing-your-hardware/
