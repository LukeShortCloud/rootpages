Hardware
========

.. contents:: Table of Contents

See also: Administrative, Drives, Virtualization

North Bridge
------------

dmidecode
~~~~~~~~~

View information about the motherboard and BIOS.

lspci
~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-m", "lists PCI hardware"

lscpu
~~~~~

Display information about the current system's processors.

lsusb
~~~~~

Display attached USB devices.

sensors-detect
~~~~~~~~~~~~~~

Package: lm_sensors

Automatically find sensors on your motherboard. This generates a configuration file to be used with the "sensors" command.

sensors
~~~~~~~

Displays the current temperature of your devices.

stress
~~~~~~

Package: stress

A utility for stress testing the processor, RAM, and/or storage.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-c, --cpu", "spawn CPU workers"
   "-i, --io", "spawn I/O workers in RAM and storage devices"
   "-m,--vm", "spawns RAM workers"
   "--vm-bytes", "specify bytes to write to RAM"
   "-d, --hdd", "spawn I/O workers on the actual drive"
   "-t", "timeout time"
   "-v", "verbose"

stress-ng
~~~~~~~~~

Package: stress-ng

An updated "next generation" stress utility.

netio
~~~~~

Stress test utility for networks.

Audio
-----

alsamixer
~~~~~~~~~

Package: alsa-utils

A CLI utiliy for volume control of the speakers.

speaker-test
~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-c 2", "test audio output on stero speakers"
   "-D hw:<DEVICE>", "test a specific audio device; you can get this information from /proc/asound/pcm"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-D hw:0,0", "test the 0,0 speakers"

Graphics
--------

intel-gpu-tools
~~~~~~~~~~~~~~~

Monitor utility for Intel integrated graphics.

nvidia-smi
~~~~~~~~~~

Monitor utility for Nvidia cards. This only works with the proprietary "nvidia" driver.

aticonfig
~~~~~~~~~

Monitor utility for AMD cards. This only works with the proprietary "fglrx" driver.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-odgc -odgt", ""

radeontop
~~~~~~~~~

Monitor utility for AMD cards. This works with both the "fglrx" and open-source "radeon" driver.

xrandr
~~~~~~

Configure different display settings.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--output <DISPLAY> --primary", "change the primary monitor"

glxinfo
~~~~~~~

Displays information about the GPU driver and related libraries.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "glxinfo | grep ""OpenGL version""", "find the maximum supported OpenGL version"

obmenu-generator
~~~~~~~~~~~~~~~~

Generate menu items for the Openbox window manager.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -i, find and use icons for application
   -p, create a menu that will always search for the latest installed applications
   -s, create a menu once with the currently installed applications

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -p -i, create a dynamic menu that contains icons for each application

mhwd
~~~~

The Manjaro Hardware Detection utility is used to install hardware drivers on Manjaro Linux.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -a pci {free|nonfree} 0300, install the graphics drivers automatically based on the hardware found
   -l -d {--pci}, view available drivers that can be installed (optionally only for PCI devices)
   -li -d {--pci|--usb|}, list installed drivers
   -i pci <DRIVER>, manually install a new driver
   -f -i pci <DRIVER>, force a re-install of a driver
   -r <DRIVER>, remove a hardware driver

IPMI
----

ipmitool
~~~~~~~~

Package: OpenIPMI-tools

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-I lanplus -H <IPADDR> -U <USER> -P <PASSWORD> {chassis|power} status", "remotely connect to IPMI to check the status of a particular component"
   "-A MD5", "use MD5 encryption for authentication"
   "user list 1", "show all users"
   "-I lanplus -H <IPADDR> -U <USER> -P <PASSWORD> user set password 2 <NEWPASS>", "reset password for a user"

ipmitool lan
~~~~~~~~~~~~

Manage the network connection for the IPMI device.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "print 1", "display the network settings"
   "set 1 ipsrc {static|dhcp}", "change the network mode"
   "set 1 ipaddr", "set the IP address"
   "set 1 netmask", "set the subnet mask"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "set 1 ipsrc static", "use static IP addressing"
   "set 1 ipaddr 192.168.1.101", "set the IP address"
   "set 1 netmask 255.255.255.0", "set the subnet mask"

ipmicfg
^^^^^^^

Configure IPMI.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-raw 0x30 0x70 0x0c 0", "view the LAN mode (dedicated, shared, or failover)"
   "-raw 0x30 0x70 0x0c 1 0", "set the LAN mode to dedicated"
   "-raw 0x30 0x70 0x0c 1 1", "set the LAN mode to shared"
   "-raw 0x30 0x70 0x0c 1 2", "set the LAN mode to failover"

lUpdate
^^^^^^^

IPMI firmware update utility.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-i kcs -f", "update IPMI's firmware"

`History <https://github.com/ekultails/rootpages/commits/master/src/commands/hardware.rst>`__
---------------------------------------------------------------------------------------------
