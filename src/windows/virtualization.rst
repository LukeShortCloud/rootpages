Windows Virtualization
======================

.. contents:: Table of Contents

Windows Subsystem for Linux (WSL)
---------------------------------

WSL 1 translated Linux system calls to Windows. This is essentially the opposite of the Wine project that is used to translate Windows system calls to Linux. Due to performance, stability, and compatibility concerns, WSL 1 is no longer used. WSL 2 is used by default. It creates a Hyper-V virtual machine instead. WSL is supported on Windows 10 and 11.

Open a Command Prompt as the Administrator user. Run this command to view the list of Linux distributions that can be installed.

::

   C:\Windows\system32>wsl --list --online

This is the list of officially supported Linux distributions:

- Debian
- Kali Linux
- Oracle Linux
- SUSE Linux Enterprise Server (SLES)
- Ubuntu

Select the operating system to install. By default, if no Linux distribution is provided to the command, Ubuntu will be installed.

::

   C:\Windows\system32>wsl --install -d <LINUX_DISTRO_NAME>

Reboot to finish the installation. Then open a Command Prompt and run either ``bash`` or ``wsl`` to open a Linux terminal. [1]

On Windows 11, there is a false-positive report from the control flow guard (CFG) protection that prevents WSL 2 from starting. Disable it to be able to use WSL 2. [2]

-  Windows Security > App & browser control > Exploit protection settings > Control flow guard (CFG): Off by default

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/virtualization.rst>`__

Bibliography
------------

1. "Install Linux on Windows with WSL." Microsoft Learn Technical documentation. January 12, 2023. Accessed February 6, 2023. https://learn.microsoft.com/en-us/windows/wsl/install
2. "The operation could not be started because a required feature is not installed #4951." GitHub microsoft/WSL. May 23, 2022. Accessed February 6, 2023. https://github.com/microsoft/WSL/issues/4951
