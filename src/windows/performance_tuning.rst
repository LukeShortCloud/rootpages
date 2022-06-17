Windows Performance Tuning
==========================

.. contents:: Table of Contents

Introduction
------------

This guide has steps to increase the performance of Windows starting with the most impactful to the least. Before doing anything, it is recommended to `create a system restore point <storage.html#system-restore-point>`__ first.

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

Disable Virtualization-Based Security (Windows >= 11)
-----------------------------------------------------

Virtualization-based security (VBS) isolates RAM allocations of every application. That way, a malicious application cannot access the memory of other applications on the system. VBS is reported to cause anywhere between a 5-25% slowdown of a computer. [5]

::

      Settings (ms-settings:) > Update & Security > Windows Security > Device security > Memory integrity: Off

Disable Startup Applications
----------------------------

Some applications will enable themselves to startup upon login. These take up system resources and users may not want them running automatically. View the resource impact and disable all or some applications from automatically starting up by using the System Configuration utility. [3]

::

   Task Manager (taskmgr.exe) > Startup > (select an application) > Disable

Disable Background Applications (Windows >= 10)
-----------------------------------------------

Background applications are allowed to launch silently and not appear in the taskbar. These applications can easily run without a user knowing. Disable some or all of the background applications [4]:

::

   Settings (ms-settings:) > Privacy > App Permissions > Background apps > Let apps run in the background: Off

Disable Scheduled Tasks
-----------------------

Some applications start themselves by using scheduled tasks. Look at the current tasks and see if there are any that should be disabled.

::

   Task Scheduler (taskschd.msc) > Task Scheduler (Local) > Task Scheduler Library > (select an existing task) > Actions > Disable

Uninstall Programs
------------------

If there are programs installed that will never be used again, then uninstall them. Otherwise, they take up storage space and may be running in the background.

::

   Settings (ms-settings:) > Apps > Apps & features > (select an application)> Uninstall

Scan for Viruses
----------------

Viruses typically slow down a computer. They run in the background to hijack processes, encrypt files, mine cryptocurrency, or do other malicious acts. Use one of the top 3 most efficient antiviruses to run an antivirus scan: `K7 Antivirus Premium <https://www.k7computing.com/us/home-users/antivirus-premium>`__, `Panda Free Antivirus <https://www.pandasecurity.com/en/homeusers/free-antivirus/>`__, or `ESET NOD32 Antivirus <https://www.eset.com/us/home/antivirus/>`__. [2]

Defragment HDDs
---------------

Traditional spinning disk drives (HDDs) are faster and more efficient when all of the data for a file is in the same area. Otherwise, it has to seek to different regions of the disk which is a slow process. Manually defragment a HDD:

-  Windows >= 8

   ::

      Optimize Drives (dfrgui.exe) > (select a drive) > Optimize

-  Windows <= 7

   ::

      Disk Defragmenter (dfrgui.exe) > (select a drive) > Defragment disk

This process takes a long time and a lot of system resources. A consumer HDD only needs to be defragmented once every 3 months. [6] By default, Windows will automatically defragment drives every week. It also tries to optimize SSD drives with is not necessary and will not improve their performance. Here is how to disable the scheduled optimization:

-  Windows >= 8

   ::

      Optimize Drives (dfrgui.exe) > Scheduled optimization > Change settings > uncheck "Run on a schedule (recommended)" > OK

-  Windows <= 7

   ::

      Disk Defragmenter (dfrgui.exe) > Schedule: > Configure schedule... > uncheck "Run on a schedule (recommended)" > OK

Windows Updates
---------------

Check for Updates
~~~~~~~~~~~~~~~~~

Windows occasionally has updates to the operating system itself, other applications, and drivers that include performance improvements. It is recommended to be on the latest version of these.

::

   Settings (ms-settings:) > Update & Security > Windows Update > Check for updates

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/performance_tuning.rst>`__

Bibliography
------------

1. "How to Enable the Ultimate Performance Power Plan in Windows 10." MakeUseOf (MUO). October 28, 2021. Accessed July 13, 2022. https://www.makeuseof.com/how-to-enable-ultimate-performance-power-plan/
2. "AV-Comparatives: Microsoft Defender has a large impact on system performance." gHacks. May 4, 2022. Accessed July 13, 2022. https://www.ghacks.net/2022/05/04/av-comparatives-microsoft-defender-has-a-large-impact-on-system-performance/
3. "How to Disable Startup Programs in Windows." How-To Geek. May 11, 2018. Accessed July 13, 2022. https://www.howtogeek.com/74523/how-to-disable-startup-programs-in-windows/
4. "How to disable background apps in Windows 10." TechEngage. May 3, 2022. Accessed June 15, 2022. https://techengage.com/how-to-disable-background-apps-in-windows-10/
5. "How to Disable VBS and Speed Up Windows 11." Tom's Hardware. October 6, 2021. Accessed June 16, 2022. https://www.tomshardware.com/how-to/disable-vbs-windows-11
6. "How Often Should I Defrag My HDD?" AOMEI Partition Assistant. March 4, 2022. Accessed June 17, 2022. https://www.diskpart.com/articles/how-often-should-I-defrag-my-hdd-0725.html
