Processors
==========

.. contents:: Table of Contents

Simultaneous Multithreading (SMT)
---------------------------------

SMT, also known as Hyper-Threading Technology (HTT) on Intel processors, allows each processor to act as two logical processors. For example, a proccessor with 4 physical cores will have a total of 8 logical threads. A processor with SMT enabled will have around a 30% increase in performance. [1]

Recommended Number of Cores
---------------------------

Depending on the use-case, these are the recommended total number of processor cores to have.

Gaming [2]:

.. csv-table::
   :header: Use-case, Cores
   :widths: 20, 20

   Very old games, 2
   Old games, 4
   Modern games, 6

Video editing [3][4]:

.. csv-table::
   :header: Resolution, Cores
   :widths: 20, 20

   720p, 4
   1080p, 6
   4K, 8
   8K, 10

Machine learning (ML) [5]:

.. csv-table::
   :header: ML Workload, Cores
   :widths: 20, 20

   Minimum, 16
   Recommended, 32
   Maximum, 64

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/processors.rst>`__

Bibliography
------------

1. "How to Determine the Effectiveness of Hyper-Threading Technology with an Application." Intel Development Topics & Technologies. April 28, 2011. Accessed September 2, 2020. https://software.intel.com/content/www/us/en/develop/articles/how-to-determine-the-effectiveness-of-hyper-threading-technology-with-an-application.html
2. "How Many CPU Cores Do I Need For Gaming?" GamingScan. January 10, 2022. Accessed September 29, 2022. https://www.gamingscan.com/how-many-cores-for-gaming/
3. "How to choose the right computer for video editing: 4 key specs to check." Videomaker. Accessed September 29, 2022. https://www.videomaker.com/buyers-guide/how-to-choose-the-right-video-editing-workstation/
4. "How many processing cores do you need in a video editing computer?" ProMAX. September 26, 2019. Accessed September 29, 2022. https://www.promax.com/blog/how-many-processing-cores-do-you-need-in-a-video-editing-computer
5. "Hardware Recommendations for Machine Learning & AI." Puget Systems. Accessed September 29, 2022. https://www.pugetsystems.com/recommended/Recommended-Systems-for-Machine-Learning-AI-174/Hardware-Recommendations
