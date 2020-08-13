Storage Devices
===============

Types and Speed
---------------

.. csv-table::
   :header: Name, Max Speed (MB/s), Connector
   :widths: 20, 20, 20

   HDD (5400 RPM), 110, IDE or SATA
   HDD (7200 RPM), 145, IDE or SATA
   HDD (10000 RPM), 200, SATA or SAS
   HDD (15000 RPM), 300, SATA or SAS
   SSD, 500, SATA or SAS
   NVMe, 3000, M.2 SATA
   NVMe (PCIe 4.0), 5000, M.2 SATA (PCIe 4.0)

HDD Magnetic Recording
----------------------

Magnetic hard drives use one of two different technologies for writing data: Conventional Magnetic Recording (CMR) or Shingled Magnetic Recording (SMR). CMR provides lower storage space but signifcantly faster write speeds. This is ideal for most use cases. SMR provides higher storage space but signifcantly slower write speeds. It should only be used for long-term storage. It is known to be extremely slow for RAID and NAS usage. [1]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/computer_hardware/storage_devices.rst>`__

Bibliography
------------

1. "Buyer beware—that 2TB-6TB “NAS” drive you’ve been eyeing might be SMR." Ars Technica. April 17, 2020. Accessed August 12, 2020. https://arstechnica.com/gadgets/2020/04/caveat-emptor-smr-disks-are-being-submarined-into-unexpected-channels/
