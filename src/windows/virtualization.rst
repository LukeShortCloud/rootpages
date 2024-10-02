Windows Virtualization
======================

.. contents:: Table of Contents

Windows Subsystem for Linux (WSL)
---------------------------------

WSL 1 translated Linux system calls to Windows. This is essentially the opposite of the Wine project that is used to translate Windows system calls to Linux. Due to performance, stability, and compatibility concerns, WSL 1 is no longer used. WSL 2 is used by default. It creates a Hyper-V virtual machine instead. WSL is supported on Windows 10 and 11.

Open a Command Prompt as the Administrator user and then install WSL. This will enable the feature and install Ubuntu.

::

   C:\Windows\System32>wsl --install

Run this command to view the list of Linux distributions that can be installed.

::

   C:\Windows\System32>wsl --list --online

This is the list of officially supported Linux distributions:

- Debian
- Kali Linux
- Oracle Linux
- SUSE Linux Enterprise Server (SLES)
- Ubuntu

Optionally, select another operating system to install.

::

   C:\Windows\System32>wsl --install -d <LINUX_DISTRO_NAME>

Reboot to finish the installation.

Then open a Command Prompt and run either ``bash`` or ``wsl`` to open a Linux terminal. [1] Alternatively, there will also be drop-down box in the Command Prompt that will add an "Ubuntu" option to open it up using the UI. If there are any errors on the first try, close the window and then try to launch WSL again.

On Windows 11, there is a false-positive report from the control flow guard (CFG) protection that prevents WSL 2 from starting. Disable it to be able to use WSL 2. [2]

-  Windows Security (windowsdefender:) > App & browser control > Exploit protection settings > Control flow guard (CFG): Off by default

Fedora
~~~~~~

There are no official images of Fedora for WSL.

Automatic Set Up
^^^^^^^^^^^^^^^^

- Install and open the unofficial `Fedora WSL <https://apps.microsoft.com/store/detail/fedora-wsl/9NPCP8DRCHSN>`__ image from the Microsoft Store. The source code can be found `here <https://github.com/VSWSL/Fedora-WSL>`__. [3]

Manual Set Up
^^^^^^^^^^^^^

It is possible to use a container image for the root file system of Fedora and then import it into WSL 2. [4]

Run a Fedora container and then save the root file system.

::

   C:\Users\<USER> docker run --name fedora40 fedora:40
   C:\Users\<USER> docker export -o fedora-40-rootfs.tar fedora40

Import the root file system.

::

   C:\Users\<USER>> mkdir $HOME\wsl\fedora
   C:\Users\<USER>> wsl --import fedora $HOME\wsl\fedora $HOME\Downloads\fedora-40-rootfs.tar
   C:\Users\<USER>> wsl -d fedora

Configure DNS resolvers.

::

   [root@<HOSTNAME> fedora]# echo -e "[network]\ngenerateResolvConf = false" > /etc/wsl.conf
   [root@<HOSTNAME> fedora]# exit
   C:\Users\<USER>> wsl -t fedora
   C:\Users\<USER>> wsl -d fedora
   [root@<HOSTNAME> fedora]# unlink /etc/resolv.conf
   [root@<HOSTNAME> fedora]# echo nameserver 1.1.1.1 > /etc/resolv.conf

Upgrade Fedora.

::

   [root@<HOSTNAME> fedora]# dnf upgrade

Install the minimum packages required for user accounts and WSL mounts to work.

::

   [root@<HOSTNAME> fedora]# dnf install cracklib-dicts passwd util-linux

Configure a new user.

::

   [root@<HOSTNAME> fedora]# useradd -G wheel <USER>
   [root@<HOSTNAME> fedora]# passwd <USER>
   [root@<HOSTNAME> fedora]# printf "\n[user]\ndefault = <USER>\n" | sudo tee -a /etc/wsl.conf
   [root@<HOSTNAME> fedora]# exit
   C:\Users\<USER>> wsl -t fedora

Verify that the new user works.

::

   C:\Users\<USER>> wsl -d fedora -u <USER>
   [<USER>@<HOSTNAME> fedora]$ whoami
   <USER>
   [<USER>@<HOSTNAME> fedora]$ sudo whoami
   root

In PowerShell, configure the WSL distribution name and the user ID.

::

   C:\Users\<USER>> Get-ItemProperty Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\*\ DistributionName | Where-Object -Property DistributionName -eq fedora  | Set-ItemProperty -Name DefaultUid -Value 1000

Fix permission issues related to user accounts.

::

   [<USER>@<HOSTNAME> fedora]$ sudo dnf reinstall shadow-utils

Enable ping support.

-  Fedora:

   ::

      [<USER>@<HOSTNAME> fedora]$ sudo dnf install procps-ng iputils
      [<USER>@<HOSTNAME> fedora]$ sudo sysctl -w net.ipv4.ping_group_range="0 2000"

-  Windows:

   ::

      C:\Users\<USER>> echo [wsl2] >> .wslconfig
      C:\Users\<USER>> echo kernelCommandLine = sysctl.net.ipv4.ping_group_range=\"0 2000\" >> .wslconfig

Enable manual pages for new package installations.

::

   [<USER>@<HOSTNAME> fedora]$ grep -v nodocs /etc/dnf/dnf.conf | sudo tee /etc/dnf/dnf.conf
   [<USER>@<HOSTNAME> fedora]$ sudo dnf install man man-pages

Optionally re-install existing packages to install their manual pages.

::

   [<USER>@<HOSTNAME> fedora]$ for pkg in $(dnf repoquery --installed --qf "%{name}"); do sudo dnf reinstall -qy $pkg; done

Optionally export the fully configured WSL file system.

::

   [<USER>@<HOSTNAME> fedora]$ sudo dnf clean all
   [<USER>@<HOSTNAME> fedora]$ exit
   C:\Users\<USER>> wsl --export fedora C:\Users\<USER>\Downloads\fedora-40-wsl.tar

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/virtualization.rst>`__

Bibliography
------------

1. "Install Linux on Windows with WSL." Microsoft Learn Technical documentation. January 12, 2023. Accessed February 6, 2023. https://learn.microsoft.com/en-us/windows/wsl/install
2. "The operation could not be started because a required feature is not installed #4951." GitHub microsoft/WSL. May 23, 2022. Accessed February 6, 2023. https://github.com/microsoft/WSL/issues/4951
3. "How to install Fedora on WSL for Windows 10 and Windows 11." Windows Central. July 8, 2023. Accessed April 21, 2024. https://www.windowscentral.com/software-apps/how-to-install-fedora-on-wsl-for-windows-10-and-windows-11
4. "Install Fedora 37 or earlier on Windows Subsystem for Linux (WSL)." DEV Community Jonathan Bowman. October 29, 2022. Accessed April 21, 2024. https://dev.to/bowmanjd/install-fedora-on-windows-subsystem-for-linux-wsl-4b26
