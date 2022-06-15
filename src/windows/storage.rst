Windows Storage
================

.. contents:: Table of Contents

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

NFS
---

Windows Vista Professional or better is required for the NFS client and server features. For older versions of Windows, the Windows Services for UNIX (SFU) software package provides many client utilities including a NFS client.

**Installation:**

-  Install the NFS client services:

   -  GUI: Control Panel > Programs > Programs and Features > Turn Windows features on or off > Services for NFS > OK
   -  CLI:

      - Check if the NFS client feature is available. If so, install it.

          ::

             C:\> Get-WindowsFeature -Name NFS*
             C:\> Install-WindowsFeature -Name NFS-Client

-  Stop the NFS client.

   ::

      C:\> nfsadmin client stop

-  Configure the anonymous UID and GID to be ``0`` (root) from the Windows NFS client side. Open the "Registry Editor" and navigate to: ``HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default``.

   -  Edit > New > DWORD (32-bit Value) > Name: AnonymousUID

      -  (right-click on the AnonymousUID) > Modify... > Value data: 0 > Base: Decimal > OK

   -  Edit > New > DWORD (32-bit Value) > Name: AnonymousGID

      -  (right-click on the AnonymousGID) > Modify... > Value data: 0 > Base: Decimal > OK

-  Start the NFS client to load the new changes.

   ::

      C:\> nfsadmin client start

-  Configure the NFS client to allow files to be executable, readable, and writable.

   ::

      C:\> nfsadmin client localhost config fileaccess=755 SecFlavors=+sys -krb5 -krb5i

-  As a non-Administrator account, mount a NFS share. This way, it will show up in File Explorer as a normal unprivileged user. [2]

  -  Syntax:

     ::

        C:\Users\<USER>> mount -o anon \\<NFS_SERVER_ADDRESS>\<NFS_PATH> <DRIVE_LETTER>:

  -  Example:

     ::

        C:\Users\winuser> mount -o anon \\192.168.1.123\exports\foobar N:

-  Verify that the mount was created.

   ::

      C:\Users\winuser> mount

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

      C:\Users\winuser> umount N:

      Disconnecting           N:      \\192.168.1.123\exports\foobar

-  For configuring a Linux NFS server for a Windows NFS client to connect to, refer to `here <../storage/file_systems.html#windows-client>`__.

[1]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/storage.rst>`__

Bibliography
------------

1. "Mounting NFS share from Linux to Windows server." techbeatly. June 12, 2019. Accessed December 20, 2021. https://www.techbeatly.com/mounting-nfs-share-from-linux-to-windows-server/
2. "NFS Mount not showing in Windows Explorer." Super User. September 10, 2021. Accessed December 20, 2021. https://superuser.com/questions/599641/nfs-mount-not-showing-in-windows-explorer/696913
3. "What is System Restore?" Microsoft Support. Accessed June 15, 2022. https://support.microsoft.com/en-us/topic/what-is-system-restore-a9d1b33f-1df9-e0f2-8aa3-d904cd940ee4
4. "Create a system restore point." Microsoft Support. Accessed June 15, 2022. https://support.microsoft.com/en-us/windows/create-a-system-restore-point-77e02e2a-3298-c869-9974-ef5658ea3be9
