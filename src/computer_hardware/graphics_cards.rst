Graphics Cards
==============

.. contents:: Table of Contents

Linux Support
-------------

Here are various rankings for each major graphics cards vendor on Linux.

Stable drivers:

1. Intel
2. NVIDIA
3. AMD

Linux performance:

1. AMD
2. NVIDIA
3. Intel

Open source and native Linux support:

1. Intel
2. AMD
3. NVIDIA

Hybrid graphics support on laptops:

1. NVIDIA
2. AMD

Day 1 Linux support for new hardware:

1. Intel
2. NVIDIA
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
