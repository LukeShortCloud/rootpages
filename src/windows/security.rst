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

-  Windows 10

   -  Real-time protection = Settings > Update & Security > Windows Security > Virus & threat protection > Manage settings > Real-time protection: Off
   -  Scheduled tasks = Task Scheduler > Task Scheduler (Local) > Task Scheduler Library > Microsoft > Windows > Windows Defender

      -  Select each task and either `Disable` or `Delete` them: `Windows Defender Cache Maintenance`, `Windows Defender Cleanup`, `Windows Defender Scheduled Scan`, and `Windows Defender Verification`. [2]

**Automatically**

-  Windows 10

   -  Download and extract `Debloat Windows 10 scripts <https://github.com/W4RH4WK/Debloat-Windows-10>`__.

      ::

         PS> Invoke-WebRequest -Uri https://github.com/W4RH4WK/Debloat-Windows-10/archive/master.zip -OutFile Debloat-Windows-10.zip
         PS> Expand-Archive Debloat-Windows-10.zip
         PS> cd .\Debloat-Windows-10\Debloat-Windows-10-master\scripts\

   -  Allow the PowerShell scripts to be executable.

      ::

         PS> Set-ExecutionPolicy Unrestricted -Scope CurrentUser
         PS> ls -Recurse *.ps*1 | Unblock-File

   -  Disable Windows Defender.

      ::

         PS> .\disable-windows-defender.ps1

User Account Control (UAC)
--------------------------

UAC ensures that all applications are run as a normal user account with no escalated privileges. When an application tries to run as Administrator, UAC will prompt the user and ask if they want to run with Administrator privileges. [3] This feature was first introduced in Windows Vista. [4]

Disable
~~~~~~~

For users who often need to use the Administrator account, it may be desired to disable UAC entirely.

-  Control Panel > User Accounts > User Accounts > Change User Account Control settings > Never notify

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/security.rst>`__

Bibliography
------------

1. "I already have Windows Defender – why do I need another antimalware tool?" Panda Security Mediacenter. July 15, 2021. Accessed August 18, 2021. https://www.pandasecurity.com/en/mediacenter/tips/defender-antimalware-tool/
2. "how to cancel windows defender automatic scans?" Windows 10 Help Forums. June 8, 2016. Accessed August 18, 2021. https://www.tenforums.com/antivirus-firewalls-system-security/52486-how-cancel-windows-defender-automatic-scans.html
3. "User Account Control." Microsoft Docs. December 3, 2021. Accessed April 7, 2022. https://docs.microsoft.com/en-us/windows/security/identity-protection/user-account-control/user-account-control-overview
4. "User Account Control." Fandom Microsoft Wiki. June 13, 2017. Accessed April 7, 2022. https://microsoft.fandom.com/wiki/User_Account_Control
