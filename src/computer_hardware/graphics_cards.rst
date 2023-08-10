Graphics Cards
==============

.. contents:: Table of Contents

Linux Support
-------------

Here are various rankings for each major graphics cards vendor on Linux.

Ease of driver installation and updates:

1. AMD and Intel
2. NVIDIA

Stable driver in gameplay:

1. AMD
2. NVIDIA
3. Intel

Linux performance:

1. AMD
2. NVIDIA
3. Intel

Open source and native Linux support:

1. AMD
2. Intel
3. NVIDIA

Hybrid graphics support on laptops:

1. NVIDIA
2. AMD
3. Intel

Day 1 Linux support for new hardware:

1. AMD
2. Intel
3. NVIDIA

Machine learning support:

1. NVIDIA
2. Intel
3. AMD

Recommended VRAM Size
---------------------

Depending on the use case, these are the recommended minimum size of VRAM to have on the graphics card.

Gaming [1][2]:

.. csv-table::
   :header: Game Resolution, VRAM (GB)
   :widths: 20, 20

   720p, 2
   1080p, 4
   1440p, 6
   4K, 8

Video editing [2][3]:

.. csv-table::
   :header: Video Resolution, VRAM (GB)
   :widths: 20, 20

   1080p, 4
   4K, 6
   6K, 8
   8K, 10

Machine learning (ML) [4][5]:

.. csv-table::
   :header: ML Workload, VRAM (GB)
   :widths: 20, 20

   Minimum, 8
   Recommended, 24
   Maximum, 48

-  The amount of VRAM differs based on the type of ML model. Language models use the most amount of VRAM compared to image models which are more CPU-bound rather than GPU-bound. [5]

Integrated GPUs (iGPUs) can use up to half of the available system RAM. [6] Since RAM is slower than VRAM, it is recommended to use the fastest RAM available. [7]

Best Legacy Cards
-----------------

32-bit
~~~~~~

32-bit operating systems, such as Windows XP, only support graphics cards with 3 GB of VRAM. There are sometimes driver limitations, too. [8]

Windows XP:

- Best performance = NVIDIA GTX 780 Ti [9]
- Best NVIDIA card for the era = NVIDIA 8800 GT [9]
- Best AMD cards = AMD Radeon 7970 [10][11] and AMD Radeon R9 280X [12]

Power Cables
------------

Graphics cards have a specific wattage requirement. They draw power from the PCIe slot and often require more power. That can be supplied through additional cables from the power supply.

.. csv-table::
   :header: Power Source, Wattage
   :widths: 20, 20

   PCIe x1 slot, 10
   PCIe x4 slot, 25
   PCIe x8 slot, 25 [13]
   PCIe x16 slot, 75
   6-pin PCIe cable, 75
   8-pin PCIe cable, 150 [14]
   12VHPWR PCIe cable, 600 [15]

All versions of PCIe (currently 1.0 through 5.0) support the same wattage output. [14][16]

It is not recommended to use a single SATA to 6-pin adapter due to the fire hazard risk if the GPU draws excessive power. [17] SATA power cables only provide 54 watts. [18][20] Molex power cables provide 156 watts. [21] For 75 watts, use one Molex or two SATA cables to convert to one 6-pin. [19] For 150 watts, use one Molex or three SATA cables to convert to one 8-pin adapter. [20]

PCIe Power Only
~~~~~~~~~~~~~~~

These are the best graphics cards that are (1) low-profile and (2) do not require a 6-pin or 8-pin power PCIe power cable. They can be fully powered by the PCIe slot and are suitable for desktops with limited space and/or power supplies that have a low wattage.

-  AMD:

   -  1. AMD Radeon RX 6400 [22]
   -  2. AMD Radeon RX 560 [23]

-  NVIDIA:

   -  1. NVIDIA RTX 4000 SFF Ada Generation

      -  This is a 2-slot card.
      -  The performance of this card is similar to the 3070 but it is as fast as the 3090 Ti in some scenarios. [25]

   -  2. NVIDIA GeForce GTX 1650
   -  3. NVIDIA GeForce GTX 1050 Ti [23][24]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/graphics_cards.rst>`__

Bibliography
------------

1. "How Much VRAM Do You Need For Gaming?" GPU Mag. November 2, 2021. Accessed September 5, 2022. https://www.gpumag.com/how-much-vram-gaming/
2. "How much VRAM do you need? Professional and Gaming Workloads explored." CG Director. May 9, 2022. Accessed September 5, 2022. https://www.cgdirector.com/how-much-vram-do-you-need/
3. "Hardware Recommendations for Premiere Pro." Puget Systems. Accessed September 5, 2022. https://www.pugetsystems.com/recommended/Recommended-Systems-for-Adobe-Premiere-Pro-143/Hardware-Recommendations
4. "Hardware Recommendations for Machine Learning & AI." Puget Systems. Accessed September 7, 2022. https://www.pugetsystems.com/recommended/Recommended-Systems-for-Machine-Learning-AI-174/Hardware-Recommendations
5. "Choosing the Best GPU for Deep Learning in 2020." The Lambda Deep Learning Blog. February 18, 2022. Accessed September 7, 2022. https://lambdalabs.com/blog/choosing-a-gpu-for-deep-learning/
6. "What is VRAM and how much do I have?" LEVVVEL. March 6, 2023. Accessed May 16, 2023. https://levvvel.com/what-is-vram-and-how-much-do-i-have/
7. "VRAM vs. RAM: What’s the Difference?" History-Computer. December 7, 2022. Accessed May 16, 2023. https://history-computer.com/vram-vs-ram/
8. "Radeon R9 290x on Windows XP 32bit. Was anybody able to install it?" Reddit r/windowsxp. April 28, 2023. Accessed July 11, 2023. https://www.reddit.com/r/windowsxp/comments/10qn8lk/radeon_r9_290x_on_windows_xp_32bit_was_anybody/
9. "Best WinXP Video Card." VOGONS. February 16, 2018. Accessed July 11, 2023. https://www.vogons.org/viewtopic.php?t=47815&start=80
10. "WinXP retro gaming PC." Linus Tech Tips. August 11, 2022. Accessed July 11, 2023. https://linustechtips.com/topic/1408436-winxp-retro-gaming-pc/
11. "HD7990 in WinXP?" VOGONS. April 24, 2022. Accessed July 11, 2023. https://www.vogons.org/viewtopic.php?t=79494
12. "What would be the fastest XP Setup with XP Era Hardware?" VOGONS. June 22, 2019. Accessed July 11, 2023. https://www.vogons.org/viewtopic.php?t=66873&start=60
13. "Without attaching additional power cables, how much can a PCIe x16 graphics card draw from the motherboard's slot?" TechSpot. Accessed August 3, 2023. https://www.techspot.com/trivia/27-without-attaching-additional-power-cables-how-much-can/
14. "PCI-E 3.0 Slot Power." Overclock.net. August 2, 2013. Accessed August 3, 2023. https://www.overclock.net/threads/pci-e-3-0-slot-power.1414801/
15. "PCIe Gen5 "12VHPWR" Connector to Deliver Up to 600 Watts of Power for Next-Generation Graphics Cards." TechPowerUp. October 11, 2021. Accessed August 3, 2023. https://www.techpowerup.com/287682/pcie-gen5-12vhpwr-connector-to-deliver-up-to-600-watts-of-power-for-next-generation-graphics-cards
16. "What's the PCIe power specs allowed for each 1.0 , 1.1a , 2.0 , 2.1 and 3.0 rated slot?" EVGA. September 24, 2011. Accessed August 3, 2023. https://forums.evga.com/What39s-the-PCIe-power-specs-allowed-for-each-10-11a-20-21-and-30-rated-slot-m1238513.aspx
17. "[SOLVED] Molex vs SATA to PCIE wattage." Tom's Hardware. April 2, 2019. Accessed August 3, 2023. https://forums.tomshardware.com/threads/molex-vs-sata-to-pcie-wattage.3466610/#post-20958258
18. "Can’t afford a Gaming PC? This one's $169." YouTube Linus Tech Tips. October 15, 2022. Accessed August 3, 2023. https://www.youtube.com/watch?v=YLC9rZ2e0Ms
19. "GPU power from molex." Tom's Hardware. February 19, 2014. Accessed August 3, 2023. https://forums.tomshardware.com/threads/gpu-power-from-molex.1709339/
20. "2 Molex to 8 Pin Adapter GPU | Everything You Need to Know." Hardware Centric. May 14, 2023. Accessed August 3, 2023. https://www.hardwarecentric.com/2-molex-to-8-pin-adapter/
21. "Maximum Safe Wattage of PSU Cables." GPU Mining Resources. March 15, 2019. https://www.gpuminingresources.com/p/psu-cables.html
22. "Best GPU without power pin?" Linus Tech Tips Forums. July 31, 2022. Accessed August 8, 2023. https://linustechtips.com/topic/1446662-best-gpu-without-power-pin/
23. "How many low profile graphics cards are there?" Quora. May 11, 2023. Accessed August 8, 2023. https://www.quora.com/How-many-low-profile-graphics-cards-are-there
24. "Graphics card compatible with HP Z230." Reddit r/PcMasterRaceBuilds. October 23, 2023. Accessed August 8, 2023. https://www.reddit.com/r/PcMasterRaceBuilds/comments/jgqtsg/graphics_card_compatible_with_hp_z230/?rdt=59793
25. "Nvidia's Tiny RTX 4000 SFF 20GB Offers RTX 3070 Performance at 70W." Tom's Hardware. March 22, 2023. Accessed August 9, 2023. https://www.tomshardware.com/news/nvidia-tiny-rtx-4000-sff-launched
