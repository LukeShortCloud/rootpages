Raspberry Pi OS
===============

.. contents:: Table of Contents

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
