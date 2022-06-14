Windows Performance Tuning
==========================

.. contents:: Table of Contents

Power Plans
-----------

Power plans determine how much power a computer can use. The lower the power usage, the lower the performance. These are the power plans available on Windows:

- Power Saver
- Balanced (default)
- High Performance
- Ultimate Performance (hidden)

It is recommended to switch from the default power plan of Balanced to High Performance instead.

::

   Settings (ms-settings:) > System > Power & sleep > Power mode: Best performance

Starting with Windows 10, it is also possible to use Ultimate Performance mode which will run the processor at its top clock speed at all times. This is very inefficient and not recommended. [1]

-  Run Windows PowerShell as Administrator and then execute this command to show the hidden Ultimate Performance power plan.

   .. code-block:: powershell

      PS C:\Windows\system32> powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
      Power Scheme GUID: 662d10a0-f646-4056-be5f-c104a4642c76  (Ultimate Performance)

-  Enable the Ultimate Performance power plan.

   ::

      Settings (ms-settings:) > System > Power & sleep > Related settings > Additional power settings > Show additional plans > Ultimate Performance

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/performance_tuning.rst>`__

Bibliography
------------

1. "How to Enable the Ultimate Performance Power Plan in Windows 10." MakeUseOf (MUO). October 28, 2021. Accessed July 13, 2022. https://www.makeuseof.com/how-to-enable-ultimate-performance-power-plan/
