Phones
======

.. contents:: Table of Contents

Android
-------

adb
~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   devices, show connected devices that are fully booted
   reboot, reboot into the normal Android operating system
   reboot bootloader, reboot into the bootloader
   reboot recovery, reboot into the recovery mode
   reboot fastboot, reboot into the fastboot mode
   push, upload a file to the device
   pull, download a file from the device

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   push recovery.img /sdcard/, upload an image file to the internal sdcard storage of the phone

fastboot
~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   devices, show connected Android devices in the boot or recovery mode
   boot <RECOVERY_IMAGE>.img, temporarily boot into a recovery image that is stored on the local computer
   flash recovery <RECOVERY_IMAGE>.img, install a new recovery utility (such as TWRP)
   flash <PARTITION> <IMAGE>.img, flash the image to a specific partition (it will only flash to A on A/B systems)
   flash --slot all <PARTITION> <IMAGE>.img, "flash the image to a specific A/B partition (bootloader, radio, or vendor) on Oreo and newer devices"

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/commands/phones.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/main/src/linux_commands/phones.rst>`__
