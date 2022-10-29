Networking
==========

.. contents:: Table of Contents

Networking hardware commonly includes switches, routers, wireless access points, and/or firewalls.

WiFi
----

Brands
~~~~~~

These are WiFi chipset manufacturers from order of best to worst Linux support [2]:

1.  Mediatek
2.  Qualcomm
3.  Intel
4.  (Other brands)
5.  Realtek

`morrownr <https://github.com/morrownr>`__ created a `USB WiFi guide <https://github.com/morrownr/USB-WiFi/blob/main/home/USB_WiFi_Adapters_that_are_supported_with_Linux_in-kernel_drivers.md>`__ that showcases consumer WiFi devices that use chipsets that are natively supported by the Linux kernel.

Speed
~~~~~

These are the maximum speeds for each WiFi standard [3][4]:

.. csv-table::
   :header: Consumer Name, IEEE Name, Specification Speed (Mbps), Real-World Speed (Mbps), Real-World Speed (MBps)
   :widths: 20, 20, 20, 20, 20

    WiFi 1, 802.11b, 11, 5.5, 0.7
    WiFi 2, 802.11a, 54, 20, 2.5
    WiFi 3, 802.11g, 54, 20, 2.5
    WiFi 4, 802.11n, 600, 100, 12.5
    WiFi 5, 802.11ac, 1300, 740, 92.5
    WiFi 6, 802.11ax (5 GHz), 10000, 1150, 143.8
    WiFi 6E, 802.11ax (6 GHz), 10000, 1800, 225.0

Virtualization
--------------

GNS3
~~~~

The Graphical Network Simulator 3 (GNS3) is a free and open source software for setting up virtual lab environments consisting of switches and routers. Virtual images are provided by most of the major network manufacturers that can be used with GNS3. [1]

-  `Arista's vEOS <https://eos.arista.com/veos-running-eos-in-a-vm/#Download_vEOS>`__
-  `Cisco IOS <https://software.cisco.com/download/release.html?mdfid=286312239&softwareid=282088129&release=7.0(3)I5(1)&flowid=81422>`__
-  `Junos vQFX <https://app.vagrantup.com/juniper>`__
-  `VyOS <http://0.bg.mirrors.vyos.net/iso/release/>`__

   -  `VyOS GNS3 Guide <https://wiki.vyos.net/wiki/VyOS_on_GNS3>`__

The `GNS3 Marketplace <https://www.gns3.com/marketplace/appliances>`__ provides many templates that mirror configurations and hardware that production devices use.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/networking.rst>`__
-  `< 2022.10.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/networking/networking_hardware.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/networking_hardware.rst>`__

Bibliography
------------

1. "[GNS3] Frequently Asked Questions." GNS3. Accessed May 7, 2018. https://gns3.com/software/faq
2. "Need Your Help: We need to let Comfast know what we think about multi-state adapters... #70." GitHub morrownr/USB-WiFi. July 27, 2022. Accessed September 27, 2022. https://github.com/morrownr/USB-WiFi/issues/70#issuecomment-1196277552
3. "How Fast Is a Wi-Fi Network?" Lifewire. June 16, 2021. Accessed September 27, 2022. https://www.lifewire.com/how-fast-is-a-wifi-network-816543
4. "Wi-Fi 6 vs Wi-Fi 6e: What's the difference?" Tom's Guide. September 19, 2022. Accessed October 29, 2022. https://www.tomsguide.com/face-off/wi-fi-6-vs-wi-fi-6e-whats-the-difference
