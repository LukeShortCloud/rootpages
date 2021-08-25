Raspberry Pi OS
===============

.. contents:: Table of Contents

Downloads
---------

There are three official images provided for Raspberry Pi OS. [2] These are the main features of each: [3]

.. csv-table::
   :header: Image Name, Minimum SD Card Size, Desktop Environment, Office Suite
   :widths: 20, 20, 20, 20

   Raspberry Pi OS with desktop and recommended software, 16 GB, LXDE, LibreOffice
   Raspberry Pi OS with desktop, 8 GB, LXDE, None
   Raspberry Pi OS Lite, 4 GB, None, None

SSH
---

By default, SSH is disabled. Enable it to allow SSH access:

- GUI = Raspberry Pi Configuration > Preferences > Interfaces> SSH: Enabled
- CLI = ``sudo raspi-config`` > Interfacing Options > SSH: Yes > Ok > Finish
- CLI headless = Mount the ``/boot/`` partition and then create an empty directory called ``ssh`` in it. On the next boot, SSH will be enabled and started.

Log into the IP address of the Raspberry Pi using the username ``pi`` and password ``raspberry``. [1]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/linux_distributions/raspberry_pi_os.rst>`__

Bibliography
------------

1. "Remote Access." Raspberry Pi Documentation. August 22, 2021. Accessed August 24, 2021. https://www.raspberrypi.org/documentation/computers/remote-access.html
2. "Operating system images." Raspberry Pi. Accessed August 24, 2021. https://www.raspberrypi.org/software/operating-systems/
3. "Hands on with the new Raspberry Pi OS release: Here's what you need to know." ZDNet. December 10, 2020. Accessed August 24, 2021.
