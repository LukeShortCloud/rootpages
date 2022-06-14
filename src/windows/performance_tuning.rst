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

Replace Microsoft Defender
--------------------------

Microsoft Defender is the default antivirus for Windows. It is the second worst antivirus for causing a computer to be slow. It is recommended to `disable it <./security.html#microsoft-defender-antivirus>`__ and use a lightweight program such as `K7 Antivirus Premium <https://www.k7computing.com/us/home-users/antivirus-premium>`__, `Panda Free Antivirus <https://www.pandasecurity.com/en/homeusers/free-antivirus/>`__, or `ESET NOD32 Antivirus <https://www.eset.com/us/home/antivirus/>`__ instead. [2]

Disable Startup Applications
----------------------------

Some applications will enable themselves to startup upon login. These take up system resources and users may not want them running automatically. View the resource impact and disable all or some applications from automatically starting up by using the System Configuration utility. [3]

::

   System Configuration (msconfig.exe) > Startup > Disable all

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/performance_tuning.rst>`__

Bibliography
------------

1. "How to Enable the Ultimate Performance Power Plan in Windows 10." MakeUseOf (MUO). October 28, 2021. Accessed July 13, 2022. https://www.makeuseof.com/how-to-enable-ultimate-performance-power-plan/
2. "AV-Comparatives: Microsoft Defender has a large impact on system performance." gHacks. May 4, 2022. Accessed July 13, 2022. https://www.ghacks.net/2022/05/04/av-comparatives-microsoft-defender-has-a-large-impact-on-system-performance/
3. "How to Disable Startup Programs in Windows." How-To Geek. May 11, 2018. Accessed July 13, 2022. https://www.howtogeek.com/74523/how-to-disable-startup-programs-in-windows/
