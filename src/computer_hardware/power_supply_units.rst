Power Supply Units (PSUs)
=========================

.. contents:: Table of Contents

Cables
------

Every cable a PSU provides is rated to provide a maximum amount of wattage.

.. csv-table::
   :header: Power Source, Wattage
   :widths: 20, 20

   4-pin CPU, 168
   8-pin CPU, 336 [1]
   6-pin PCIe cable, 75
   8-pin PCIe cable, 150 [2]
   12VHPWR PCIe cable, 600 [3]
   SATA, 54
   Molex, 156 [4]

Adapters
~~~~~~~~

Here are a list of safe adapters to use. Providing lower wattage than what is expected can lead to a fire.

-  2x Molex to 1x 4-pin CPU.
-  2x SATA to 1x 6-pin GPU.
-  1x Molex to 1x 6-pin GPU.
-  1x Molex to 1x 8-pin GPU.
-  1x 8-pin GPU to 1x 6-pin GPU.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/power_supply_units.rst>`__

Bibliography
------------

1. "Why Your Motherboard Has CPU Power 1 and CPU Power 2." MakeUseOf. April 20, 2023. Accessed August 8, 2023. https://www.makeuseof.com/why-your-motherboard-has-cpu-power-1-cpu-power-2/
2. "PCI-E 3.0 Slot Power." Overclock.net. August 2, 2013. Accessed August 8, 2023. https://www.overclock.net/threads/pci-e-3-0-slot-power.1414801/
3. "PCIe Gen5 "12VHPWR" Connector to Deliver Up to 600 Watts of Power for Next-Generation Graphics Cards." TechPowerUp. October 11, 2021. Accessed August 8, 2023. https://www.techpowerup.com/287682/pcie-gen5-12vhpwr-connector-to-deliver-up-to-600-watts-of-power-for-next-generation-graphics-cards
4. "Maximum Safe Wattage of PSU Cables." GPU Mining Resources. March 15, 2019. https://www.gpuminingresources.com/p/psu-cables.html
