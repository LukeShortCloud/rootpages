Windows Security
================

.. contents:: Table of Contents

Antivirus
----------

Microsoft Defender Antivirus
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This antivirus is free and available for all versions of Windows starting with Windows XP. It was previously named Windows Defender Antivirus and Windows Defender. As of Windows 8.1, it is installed and enabled by default. [1]

Disable
^^^^^^^

If using another antivirus program or if required for testing, it may be desired to disable Windows Defender.

**Manually**

-  Real-time protection

   -  Windows 11

      -  Settings (ms-settings:) > Privacy & security > Windows Security > Virus & threat protection > Manage settings > Real-time protection: Off, Cloud-delivered protection: Off, Automatic sample submission: Off, and Tamper Protection: Off

   -  Windows 10

      -  Settings (ms-settings:) > Update & Security > Windows Security > Virus & threat protection > Manage settings > Real-time protection: Off

-  Scheduled tasks

   -  Windows 11 and 10

      -  Task Scheduler (taskschd.msc) > Task Scheduler (Local) > Task Scheduler Library > Microsoft > Windows > Windows Defender

         -  Select each task and either `Disable` or `Delete` them: `Windows Defender Cache Maintenance`, `Windows Defender Cleanup`, `Windows Defender Scheduled Scan`, and `Windows Defender Verification`. [2]

**Automatically**

-  Windows 10

   -  Download and extract `Debloat Windows 10 scripts <https://github.com/W4RH4WK/Debloat-Windows-10>`__.

      ::

         PS C:\Windows\system32> Invoke-WebRequest -Uri https://github.com/W4RH4WK/Debloat-Windows-10/archive/master.zip -OutFile Debloat-Windows-10.zip
         PS C:\Windows\system32> Expand-Archive Debloat-Windows-10.zip
         PS C:\Windows\system32> cd .\Debloat-Windows-10\Debloat-Windows-10-master\scripts\

   -  Allow the PowerShell scripts to be executable.

      ::

         PS C:\Windows\system32> Set-ExecutionPolicy Unrestricted -Scope CurrentUser
         PS C:\Windows\system32> ls -Recurse *.ps*1 | Unblock-File

   -  Disable Windows Defender.

      ::

         PS C:\Windows\system32> .\disable-windows-defender.ps1

User Account Control (UAC)
--------------------------

UAC ensures that all applications are run as a normal user account with no escalated privileges. When an application tries to run as Administrator, UAC will prompt the user and ask if they want to run with Administrator privileges. [3] This feature was first introduced in Windows Vista. [4]

Disable
~~~~~~~

For users who often need to use the Administrator account, it may be desired to disable UAC entirely.

-  Windows 11 and 10

   -  Control Panel (Control Panel) > User Accounts > User Accounts > Change User Account Control settings > Never notify

Process Monitor
---------------

Usage
~~~~~

Process Monitor is an official tool from Microsoft. It is useful to see what a process is doing for security or troubleshooting purposes. Newer versions also support Linux.

-  Download and extract `Process Monitor <https://learn.microsoft.com/en-us/sysinternals/downloads/procmon>`__.
-  Run ``Procmon64.exe``.
-  By default, it captures all events immediately. Clear this before managing filters.

    -  File > Capture Events
    -  Edit > Clear Display

-  Add one or more filters using the `example filters <#example-filters>`__ as a starting point.
-  Press the Capture button (an arrow facing right). Inside the icon, a sub-icon will change from a pause icon (two bars) to a recording icon (red dot).
-  When done, press the Capture button again to pause the montioring.
-  Save the output in a common text file format for easier parsing.

   -  File > Save... > Format: Comma-Separated Values (CSV)  > OK

Example Filters
~~~~~~~~~~~~~~~

Add filter for certain registry file changes (if you know what to look for).

-  Filter > Filter...

    -  Path, Contains, (enter text to look for), then: Include > Add
    -  Apply

Add a filter for all registry writes. Ignore common Windows services that access the registry.

-  Filter > Filter...

    -  Operation, is, RegCreateKey, then: Include > Add
    -  Operation, is, RegSetValue, then: Include > Add
    -  Process Name, is, FMService64.exe > then > Exclude
    -  Process Name, is, svchost.exe > then > Exclude
    -  Process Name, is, wermgr.exe > then > Exclude
    -  Process Name, is, Widgets.exe > then > Exclude
    -  Apply

Add a filter for all registry access.

-  Filter > Filter...

    -  Operation, begins with, Reg, then: Include > Add
    -  Apply

Add a filter for all file writes.

-  Filter > Filter...

    -  Operation, is, CreateFile, then: Include > Add
    -  Operation, is, WriteFile, then: Include > Add
    -  Apply

Add a filter to see everything a process is doing.

    -  Filter > Filter...

        -  Process Name, is, (the EXE name), then: Include > Add
        -  Apply

    -  Options > Select Columns... > Event Details > (check "Sequence Number") > OK

Add a filter to see everything a MSI installer is doing.

-  Filter > Filter...

    -  Process Name, is, msiexec.exe, then: Include > Add
    -  Apply

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/security.rst>`__

Bibliography
------------

1. "I already have Windows Defender – why do I need another antimalware tool?" Panda Security Mediacenter. July 15, 2021. Accessed August 18, 2021. https://www.pandasecurity.com/en/mediacenter/tips/defender-antimalware-tool/
2. "how to cancel windows defender automatic scans?" Windows 10 Help Forums. June 8, 2016. Accessed August 18, 2021. https://www.tenforums.com/antivirus-firewalls-system-security/52486-how-cancel-windows-defender-automatic-scans.html
3. "User Account Control." Microsoft Docs. December 3, 2021. Accessed April 7, 2022. https://docs.microsoft.com/en-us/windows/security/identity-protection/user-account-control/user-account-control-overview
4. "User Account Control." Fandom Microsoft Wiki. June 13, 2017. Accessed April 7, 2022. https://microsoft.fandom.com/wiki/User_Account_Control
