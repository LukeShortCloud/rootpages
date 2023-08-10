Storage Devices
===============

.. contents:: Table of Contents

Types and Speed
---------------

Hard disk drives (HDDs):

.. csv-table::
   :header: Rotations Per Minute (RPM), Max Speed (MB/s), Connector
   :widths: 20, 20, 20

   5400, 110, IDE or SATA
   7200, 145, IDE or SATA
   10000, 200, SATA or SAS
   15000, 300, SATA or SAS

Solid state drives (SSDs):

.. csv-table::
   :header: Name, Max Speed (MB/s), Connector
   :widths: 20, 20, 20

   SSD, 500, SATA or SAS
   NVMe, 3000, M.2 SATA
   NVMe (PCIe 4.0), 5000, M.2 SATA (PCIe 4.0)

Secure Digital (SD) cards [3]:

.. csv-table::
   :header: Name, Max Speed (MB/s)
   :widths: 20, 20

   Default Speed, 12.5
   High Speed, 25
   UHS-I, 100
   UHS-II, 300
   UHS-III, 600
   SD Express, 4000

Average Size
------------

Here are the average storage drive sizes for each era of Windows operating systems by the time the next Windows release came out.

.. csv-table::
   :header: Windows, Size (GB)
   :widths: 20, 20

   Windows XP (2007), 100 [4]
   Windows 7 (2012), 700 [5]
   Windows 10 (2021), 1000 [6]

HDD Magnetic Recording
----------------------

Magnetic hard drives use one of two different technologies for writing data: Conventional Magnetic Recording (CMR) or Shingled Magnetic Recording (SMR). CMR provides lower storage space but significantly faster write speeds. This is ideal for most use cases. SMR provides higher storage space but significantly slower write speeds. It should only be used for long-term storage. It is known to be extremely slow for RAID and NAS usage. [1]

NAND Flash Types
----------------

All SSDs (including NVMe) use a specific type of NAND flash: single-level cell (SLC), multi-level cell (MLC), triple-level (TLC), quad-level cell (QLC), or penta-level cell (PLC). These describe how many bits are stored in each cell. A higher amount of bits leads to higher storage capacity, lower the reliability (if a cell dies then more bits are lost), lower life span (more writes happen on each cell), and slower speed (more bits need to be written to store data). The most common type in 2019 is TLC. [2]

Power Loss Protection (PLP)
---------------------------

PLP is a feature found in enterprise-grade drives. [7] It prevents file system corruption due to a power outage. There are two types of PLP [8]:

-  Firmware = The DRAM cache stores the mapping table and will finish writing data once the drive has been turned on again.
-  Hardware = Capacitors on the drive keep it running so DRAM cache can safely finish writing to the drive before turning the drive off.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/storage_devices.rst>`__

Bibliography
------------

1. "Buyer beware—that 2TB-6TB “NAS” drive you’ve been eyeing might be SMR." Ars Technica. April 17, 2020. Accessed August 12, 2020. https://arstechnica.com/gadgets/2020/04/caveat-emptor-smr-disks-are-being-submarined-into-unexpected-channels/
2. "Multi-Layer SSDs: What Are SLC, MLC, TLC, QLC, and PLC?." How-To Geek. October 28, 2019. Accessed August 12, 2020. https://www.howtogeek.com/444787/multi-layer-ssds-what-are-slc-mlc-tlc-qlc-and-mlc/
3. "Bus Speed (Default Speed/High Speed/UHS/SD Express)." SD Assocation. Accessed August 2, 2021. https://www.sdcard.org/developers/sd-standard-overview/bus-speed-default-speed-high-speed-uhs-sd-express/
4. "2007 HDD Rundown: Can High Capacities Meet High Performance?" Tom's Hardware. January 16, 2007. Accessed August 7, 2023. https://www.tomshardware.com/reviews/2007-hdd-rundown,1522.html
5. "Average capacity of Seagate and Western Digital hard disk drives (HDDs) worldwide from 3rd quarter 2011 to 1st quarter 2016." Statista. May 12, 2016. Accessed August 7, 2023. https://www.statista.com/statistics/751847/worldwide-seagate-western-digital-average-hard-drive-capacity/
6. "Client SSDs: Samsung Retains No.1 Spot, SSDs Outsell HDDs by 2.6x." Tom's Hardware. August 20, 2021. Accessed August 7, 2023. https://www.tomshardware.com/news/client-ssds-outsell-client-hdds-by-2-6-times-in-q2
7. "Power loss protection (PLP)." Samsung_SSD_845DC_05_Power_loss_protection_PLP.pdf. 2014. Accessed August 9, 2023. https://www.kingston.com/en/blog/servers-and-data-centers/ssd-power-loss-protection
8. "A Closer Look At SSD Power Loss Protection." Kingston Blog. March, 2019. Accessed August 9, 2023. https://download.semiconductor.samsung.com/resources/others/Samsung_SSD_845DC_05_Power_loss_protection_PLP.pdf
