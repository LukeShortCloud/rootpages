Linux Commands
==============

-  `Hardware <#hardware>`__

   -  `North Bridge <#hardware---north-bridge>`__
   -  IPMI
   -  Graphics
   -  Audio

Hardware
--------

Hardware - North Bridge
~~~~~~~~~~~~~~~~~~~~~~~

See also: Administrative, Drives, Virtualization

+----------+--------+-----------+---------------+----------+-----------+
| Command  | Usage  | Examples  | Explaination  | Package  | Sources   |
+==========+========+===========+===============+==========+===========+
| lscpu    |        |           | view          | util-lin |           |
|          |        |           | processor     | ux       |           |
|          |        |           | information   |          |           |
+----------+--------+-----------+---------------+----------+-----------+
| lspci    | -k     |           | view PCI      | pciutils |           |
|          | [show  |           | device        |          |           |
|          | kernel |           | information   |          |           |
|          | module |           |               |          |           |
|          | s      |           |               |          |           |
|          | using  |           |               |          |           |
|          | the    |           |               |          |           |
|          | PCI    |           |               |          |           |
|          | device |           |               |          |           |
|          | ]      |           |               |          |           |
+----------+--------+-----------+---------------+----------+-----------+
| lsusb    |        |           | view USB      | usbutils |           |
|          |        |           | device        |          |           |
|          |        |           | information   |          |           |
+----------+--------+-----------+---------------+----------+-----------+
| sensors- |        |           | automatically | lm\_sens |           |
| detect   |        |           | detect        | ors      |           |
|          |        |           | available     |          |           |
|          |        |           | power and/or  |          |           |
|          |        |           | tempature     |          |           |
|          |        |           | sensors on    |          |           |
|          |        |           | the           |          |           |
|          |        |           | motherboard   |          |           |
+----------+--------+-----------+---------------+----------+-----------+
| sensors  |        |           | view the read | lm\_sens |           |
|          |        |           | out of the    | ors      |           |
|          |        |           | motherboard   |          |           |
|          |        |           | sensors       |          |           |
+----------+--------+-----------+---------------+----------+-----------+

\| stress \|

.. raw:: html

   <li>

-c, --cpu [spawn CPU workers]

.. raw:: html

   <li>

-i, --io [spawn I/O workers in RAM and HDDs]

.. raw:: html

   <li>

-m,--vm [spawns RAM workers]

.. raw:: html

   <li>

--vm-bytes [specify bytes to write to RAM]

.. raw:: html

   <li>

-d, --hdd [spawn I/O workers on the actual drive]

.. raw:: html

   <li>

-t [timeout time]

.. raw:: html

   <li>

-v [verbose] \| \| run a stress test on CPU, RAM, and/or a storage
device \| EPEL: stress \| \|
