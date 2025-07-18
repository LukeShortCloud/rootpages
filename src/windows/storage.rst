Windows Storage
================

.. contents:: Table of Contents

Invalid Characters
------------------

These are invalid characters to use for any file or directory name [14]:

-  ``*``
-  ``\``
-  ``/``
-  ``:``
-  ``<``
-  ``>``
-  ``|``
-  ``"``
-  ``?``

System Restore Point
--------------------

A system restore point is a backup of important Windows files and the registry. This backup can be restored at any time in case these are issues with the system. [3]

Create a system restore point:

::

   System Properties (sysdm.cpl) > System Protection > Create...

Restore the backup:

::

   System Properties (sysdm.cpl) > System Protection > System Restore...

[4]

Page (Swap) File
----------------

The page file in Windows is the same as a swap file in Linux. It helps to offload RAM by using local storage instead. By default, Windows will not create a page file that is larger than 4 GB. [12] For gaming, it is `recommended <../storage/file_systems.html#swap>`__ to set the page file size to be large enough that the total temporary page file and RAM size combined is 24 GB for a dGPU or 32 GB for an iGPU.

Increase the page file size [13]:

::

   System Properties (sysdm.cpl) > Advanced > Performance > Settings... > Advanced > Virtual memory > Change... > (uncheck "Automatically manage paging file size for all drives") > (check "Custom size:") > (set the "Initial size (MB):" and "Maximum size (MB):" to the desired values) > OK

BitLocker
---------

BitLocker is a drive encryption tool for Windows. It requires UEFI and TPM >= 1.2 to work. It will not work with legacy BIOS boot. [5] Secure Boot is not a requirement but strongly recommended as an additional layer of security. BitLocker will detect if Secure Boot was turned on or off. In either case, it will ask for a recovery key. [6]

As of Windows 8, if a Windows account is made using a Microsoft account, Windows will automatically upload BitLocker recovery keys online. They can be accessed `here <https://account.microsoft.com/devices/recoverykey>`__. [7]

Enable BitLocker encryption [8]:

-  Windows 11:

   -  Settings (ms-settings:) > Privacy & security > Device encryption: On

-  Windows 10:

   -  Settings (ms-settings:) > Update & Security > Device encryption: On

Linux File Systems
-------------------

NFS
~~~

Windows Vista Professional or better is required for the NFS client and server features. For older versions of Windows, the Windows Services for UNIX (SFU) software package provides many client utilities including a NFS client.

**Installation:**

-  Install the NFS client services:

   -  GUI: Control Panel (Control Panel) > Programs > Programs and Features > Turn Windows features on or off > Services for NFS > OK
   -  CLI:

      - Check if the NFS client feature is available. If so, install it.

          ::

             C:\Windows\System32>Get-WindowsFeature -Name NFS*
             C:\Windows\System32>Install-WindowsFeature -Name NFS-Client

-  Stop the NFS client.

   ::

      C:\Windows\System32>nfsadmin client stop

-  Configure the anonymous UID and GID to be ``0`` (root) from the Windows NFS client side. Alternatively, if the NFS server is using a different UID and GID, use those IDs instead. Open the "Registry Editor" and navigate to: ``HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default``.

   -  Edit > New > DWORD (32-bit Value) > Name: AnonymousUID

      -  (right-click on the AnonymousUID) > Modify... > Base: Decimal > Value data: 0 > OK

   -  Edit > New > DWORD (32-bit Value) > Name: AnonymousGID

      -  (right-click on the AnonymousGID) > Modify... > Base: Decimal > Value data: 0 > OK

-  Start the NFS client to load the new changes.

   ::

      C:\Windows\System32>nfsadmin client start

-  Configure the NFS client to allow files to be executable, readable, and writable.

   ::

      C:\Windows\System32>nfsadmin client localhost config fileaccess=755 SecFlavors=+sys -krb5 -krb5i

-  As a non-Administrator account, mount a NFS share. This way, it will show up in File Explorer as a normal unprivileged user. [2]

  -  Syntax:

     ::

        C:\Users\<USER>>mount -o anon \\<NFS_SERVER_ADDRESS>\<NFS_PATH> <DRIVE_LETTER>:

  -  Example:

     ::

        C:\Users\<USER>>mount -o anon \\192.168.1.123\exports\foobar N:

-  Verify that the mount was created.

   ::

      C:\Users\<USER>>mount

      Local    Remote                         Properties
      --------------------------------------------------------------------
      N:       \\192.168.1.123\exports\foobar UID=0, GID=0
                                              rsize=1048576, wsize=1048576
                                              mount=soft, timeout=0.8
                                              retry=1, locking=yes
                                              fileaccess=755, lang=ANSI
                                              casesensitive=no
                                              sec=sys

-  Optionally remove the mount when done using it.

   ::

      C:\Users\<USER>>umount N:

      Disconnecting           N:      \\192.168.1.123\exports\foobar

-  For configuring a Linux NFS server for a Windows NFS client to connect to, refer to `here <../storage/file_systems.html#windows-client>`__.

[1]

Zone Identifier Files
~~~~~~~~~~~~~~~~~~~~~

When accessing Windows Subsystem for Linux (WSL) or Network File System (NFS) files, Windows >=10 will creates a file called ``<FILE_NAME>:Zone.Identifier`` for every file ``<FILE_NAME>``. WSL uses CIFS/SMB to share files between the virtual machine and the host. All network files have a zone identifiter to configure the security of what these network files can do. [9] This feature can be disabled to prevent these extra zone identifier files from being created [10]:

-  Local Group Policy Editor (gpedit.msc) > User Configuration > Administrative Templates > Windows Components > Attachment Manager > Do not preserve zone information in file attachments > Enabled > OK

Bootloader
----------

If dual-booting with different versions of Windows, it is possible to delete the boot entries for the other operating systems to help remove those different versions from the drive. [11]

-  >= Windows XP:

   -  System Configuration (msconfig) > Boot > ("Delete" all the entries except for the "Default OS") > OK

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/storage.rst>`__

Bibliography
------------

1. "Mounting NFS share from Linux to Windows server." techbeatly. June 12, 2019. Accessed December 20, 2021. https://www.techbeatly.com/mounting-nfs-share-from-linux-to-windows-server/
2. "NFS Mount not showing in Windows Explorer." Super User. September 10, 2021. Accessed December 20, 2021. https://superuser.com/questions/599641/nfs-mount-not-showing-in-windows-explorer/696913
3. "What is System Restore?" Microsoft Support. Accessed June 15, 2022. https://support.microsoft.com/en-us/topic/what-is-system-restore-a9d1b33f-1df9-e0f2-8aa3-d904cd940ee4
4. "Create a system restore point." Microsoft Support. Accessed June 15, 2022. https://support.microsoft.com/en-us/windows/create-a-system-restore-point-77e02e2a-3298-c869-9974-ef5658ea3be9
5. "BitLocker Overview and Requirements FAQ." Microsoft Learn. Accessed June 21, 2023. https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/bitlocker-overview-and-requirements-faq
6. "Secure Boot and Bitlocker." Windows 10 Forums. August 11, 2017. Accessed June 21, 2023. https://www.tenforums.com/antivirus-firewalls-system-security/90970-secure-boot-bitlocker.html
7. "BitLocker Recovery - Unlock a Drive in Windows 8." Windows 8 Help Forums. July 27, 2016. Accessed June 21, 2023. https://www.eightforums.com/threads/bitlocker-recovery-unlock-a-drive-in-windows-8.21433/
8. "Turn on device encryption." Microsoft Support. Accessed June 21, 2023. https://support.microsoft.com/en-us/windows/turn-on-device-encryption-0c453637-bc88-5f74-5105-741561aae838
9. "About URL Security Zones." Microsoft Learn. August 15, 2017. Accessed July 26, 2023. https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms537183(v=vs.85)
10. "Zone.Identifier Files when copying from Windows to WSL filestructure #4609." GitHub microsoft/WSL. July 15, 2023. Accessed July 26, 2023. https://github.com/microsoft/WSL/issues/4609#issuecomment-1079657697
11. "How to Delete Old Boot Menu Options on Windows 10." MakeUseOf. November 8, 2022. Accessed August 9, 2023. https://www.makeuseof.com/tag/delete-boot-menu-options-windows/
12. "Introduction to page files." Microsoft Learn. March 20, 2023. Accessed October 24, 2023. https://learn.microsoft.com/en-us/troubleshoot/windows-client/performance/introduction-to-the-page-file
13. "What is a swap file (swap space or page file)?" TechTarget. Accessed October 24, 2023. https://www.techtarget.com/searchwindowsserver/definition/swap-file-swap-space-or-pagefile
14. "Naming Files, Paths, and Namespaces." Microsoft Learn. August 28, 2024. Accessed July 6, 2025.  https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file
