Windows Backup and Recovery
============================

Troubleshooting
---------------

Errors
~~~~~~

When booting into Safe Mode on Windows XP, it is stuck after loading the "Mup.sys" driver.

::

   multi(0)disk(0)rdisk(0)partition(1)\WINDOWS\System32\Drivers\Mup.sys

Solution:

-  Wait for Windows XP to finish booting. It first runs ``chkdsk /r`` to repair possible corruption on the file system. This can take a long time. If the PC has a drive activity light, make sure that it is flashing. [1]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/template.rst>`__

Bibliography
------------

1. "SAFE mode bootup halting at Mup.sys." Microsoft Learn. January 28, 2015. Accessed March 21, 2026. https://learn.microsoft.com/en-us/answers/questions/2665852/safe-mode-bootup-halting-at-mup-sys
