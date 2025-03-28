Windows Editions
================

.. contents:: Table of Contents

Updates
-------

End-of-Life Dates
~~~~~~~~~~~~~~~~~

Here is a list of each Windows version and the year that they stopped getting updates.

.. csv-table::
   :header: Windows Version, Consumer Updates, Extended Security Updates (ESUs)
   :widths: 20, 20, 20

   XP [13], 2009, 2014
   Vista [14], 2012, 2017
   7 [15], 2020, 2023
   8 [15], 2023, 2023
   10, 2025 [16], 2032 [12]

Disable Updates
~~~~~~~~~~~~~~~

Windows 10 and 11 Home edition does not have an easy way to disable updates. However, all Windows editions can have their updates disabled by using the registry. [17]

::

   Registry Editor (regedit) > HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU

-  For Windows Home edition, the "WindowsUpdate" and "AU" keys will be missing. These need to be manually created.
-  Edit > New > DWORD (32-bit Value) > Name: NoAutoUpdate

   -  (right-click on "NoAutoUpdate") > Modify… > Base: Decimal > Value data: 1 > OK

Optionally, a major target version can be set for Windows Updates. It will never update beyond that version as long as it is supported. [18]

::

   Registry Editor (regedit) > HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate

-  For Windows Home edition, the "ProductVersion" value will be missing. This needs to be manually created.

   -  Edit > New > String Value > Name: ProductVersion

      -  (right-click on "ProductVersion") > Modify… > Value data: "Windows 11" (or "Windows 10") > OK

-  Edit > New > DWORD (32-bit Value) > Name: TargetReleaseVersion

   -  (right-click on "TargetReleaseVersion") > Modify… > Base: Decimal > Value data: 1 > OK

-  Edit > New > String Value > Name: TargetReleaseVersionInfo

   -  (right-click on "TargetReleaseVersionInfo") > Modify… > Value data: 22H2 (or any desired major version) > OK

NT 10 (Windows 10 and 11)
-------------------------

Feature comparison:

.. csv-table::
   :header: Edition, Windows Defender, Encryption, Domain Join, Group Policy Management, Remote Desktop, Hyper-V, NFS Client, ReFS, LTSC Updates
   :widths: 20, 20, 20, 20, 20, 20, 20, 20, 20, 20

   Home, Yes, Yes, No, No, No, No, No, No, No
   Pro, Yes, Yes, Yes, Yes, Yes, Yes, Yes, No, No
   Enterprise/Education, Yes, Yes, Yes, Yes, Yes, Yes, Yes, Yes, Yes

[1][2]

Long-Term Servicing Channel (LTSC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Previously known as the long-term servicing branch (LTSB) in older releases of Windows, LTSC provides a stripped down version of Windows Enterprise that receives updates for many years. It removes pre-installed applications including [3]:

-  Cortana
-  Microsoft Store
-  OneDrive
-  OneNote
-  Skype

During the supported lifecycle, no features or hardware support are added. Only security and bug fixes are provided.

Modern versions of Windows 10 Enterprise LTSC are only supported for 5 years compared to the previous 10 years it used to support. Windows 10 IoT Enterprise LTSC still provides 10 years of support and is binary-compatible. The only difference between the two is how licensing is handled. [11]

.. csv-table::
   :header: Name, Years of Support, Years of Support (IoT), Version Feature Set is Based On
   :widths: 20, 20, 20, 20

   Windows 10 Enterprise LTSB 2015, 10, 10, `Windows 10 Version 1507 <https://docs.microsoft.com/en-us/windows/whats-new/ltsc/whats-new-windows-10-2015>`__
   Windows 10 Enterprise LTSB 2016, 10, 10, `Windows 10 Version 1607 <https://docs.microsoft.com/en-us/windows/whats-new/ltsc/whats-new-windows-10-2016>`__
   Windows 10 Enterprise LTSC 2019, 10, 10, `Windows 10 Version 1809 <https://docs.microsoft.com/en-us/windows/whats-new/ltsc/whats-new-windows-10-2019>`__
   Windows 10 Enterprise LTSC 2021, 5, 10, `Windows 10 Version 21H2 <https://docs.microsoft.com/en-us/windows/whats-new/ltsc/whats-new-windows-10-2021>`__
   Windows 11 Enterprise LTSC 2024, 5, 10, `Windows 11 Version 22H2 <https://techcommunity.microsoft.com/t5/windows-it-pro-blog/windows-client-roadmap-update/ba-p/3805227>`__

[5][6][12]

An installation of Windows Enterprise LTSC can switch to the traditional "current" update channel which receives two major feature updates every year. This essentially turns it into Windows Enterprise. However, downgrading Windows Enterprise to Windows Enterprise LTSC is not supported. [4]

Windows Enterprise LTSC can only be upgraded to a new major release by manually running the "setup.exe" installer from a new ISO image. This can be done with a virtually mounted ISO image as the installation/upgrade files are copied locally to the ``C:\`` drive. Windows Update will not provide upgrades to newer major versions. [8]

Microsoft Store
^^^^^^^^^^^^^^^

By default, the Microsoft Store is not installed on Windows Enterprise LTSC editions. As a workaround, all editions of Windows support manually downloading and installing APPX programs that are typically only available on the Microsoft Store. [10] This includes the Microsoft Store itself. The `LTSC-Add-MicrosoftStore <https://github.com/kkkgo/LTSC-Add-MicrosoftStore>`__ project on GitHub provides all of the required packages. Even though these packages are old, they will install on all versions of Windows Enterprise LTSC >= 2019. After the initial installation of the Microsoft Store, these can all be updated through the Microsoft Store itself.

::

   PS C:\Windows\system32> cd $env:tmp
   PS C:\Users\<USER>\AppData\Local\Temp> Invoke-WebRequest -Uri https://github.com/lixuy/LTSC-Add-MicrosoftStore/archive/2019.zip -OutFile LTSC-Add-MicrosoftStore-2019.zip
   PS C:\Users\<USER>\AppData\Local\Temp> Expand-Archive -Path .\LTSC-Add-MicrosoftStore-2019.zip -DestinationPath $env:tmp
   PS C:\Users\<USER>\AppData\Local\Temp> cd LTSC-Add-MicrosoftStore-2019\
   PS C:\Users\<USER>\AppData\Local\Temp\LTSC-Add-MicrosoftStore-2019> Add-Store.cmd

Windows Photo Viewer
^^^^^^^^^^^^^^^^^^^^

By default, Windows Photo Viewer is installed but not enabled in Windows LTSC editions. There is no default application set for viewing photos. Here are the steps to re-enable it as the default:

-  Download the `Restore_Windows_Photo_Viewer_ALL_USERS_with_Sort_order_fix.reg <https://www.tenforums.com/attachments/tutorials/198321d1533487488-restore-windows-photo-viewer-windows-10-a-restore_windows_photo_viewer_all_users_with_sort_order_fix.reg>`__ fix.
-  Right-click on the downloaded file and select "Open with > Registry Editor".
-  Settings (ms-settings:) > Apps > Default apps > Photo viewer > + Choose a default > Windows Photo Viewer

[9]

DirectX End-User Runtime
^^^^^^^^^^^^^^^^^^^^^^^^

The DirectX 9 end-user runtime is not installed by default on Windows LTSC editions. This includes many gaming libraries required by older games such as the older DirectX SDK, Managed DirectX, XACT, XAudio, and XInput. Download and install "DirectX End-User Runtimes (June 2010)" from `here <https://www.microsoft.com/en-us/download/details.aspx?id=8109>`__.

Gaming Features
---------------

Here are all of the changes to gaming features in Windows.

-  Windows 11

   -  No 32-bit edition of Windows 11. Only 32-bit editions of Windows had support for 16-bit DOS applications via NTVDM. [19]

-  Windows 10

   -  DirectX has been updated to major version 12.

-  Windows 8

   -  Removed 16-bit color screen mode. [20]
   -  DirectDraw, which is available in DirectX 10 and older, now uses software emulation and is slow. [21]

-  Windows 7

   -  DirectX has been updated to major version 11.

-  Windows Vista

   -  DirectSound is now software emulated which causes various issues because the library is sensitive to latency. [22]
   -  16-bit DOS applications via NTVDM are limited to only 32 MB of RAM. [23]
   -  First operating system that launched with a 64-bit edition.
   -  DirectX has been updated to major version 10.

-  Windows XP

   -  This is the first release of Windows to not be based on MS-DOS. 16-bit DOS applications cannot be run natively and now use NTVDM instead. [24]
   -  DirectX has been updated to major version 9. [25]

Downloads
---------

Windows can be freely and legally downloaded directly from Microsoft:

-  `Windows 10 Home and Pro <https://www.microsoft.com/en-us/software-download/windows10ISO>`__ = Limited features are enabled until a license key is provided. There is no expiration time for this trial. [7]
-  `Windows 10 Enterprise and Enterprise LTSC <https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise>`__ = A 90 day full trial. There is no way to activate a production license during or after the trial period. License keys and production Windows installation ISO images can only be purchased in volume by a company and not an individual.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/windows/editions.rst>`__

Bibliography
------------

1. "Compare Windows 10 editions." Microsoft. Accessed May 9, 2021 https://www.microsoft.com/en-us/WindowsForBusiness/Compare
2. "Windows 10 editions comparison with features." Whatvwant. October 16, 2020. Accessed May 9, 2021. https://whatvwant.com/windows-10-editions-comparison-with-features/
3. "LTSC: What is it, and when should it be used?" Windows IT Pro Blog. July 15, 2019. Accessed August 31, 2021. https://techcommunity.microsoft.com/t5/windows-it-pro-blog/ltsc-what-is-it-and-when-should-it-be-used/ba-p/293181
4. "Windows 10 edition upgrade." Microsoft Docs. March 25, 2021. Accessed May 9, 2021. https://docs.microsoft.com/en-us/windows/deployment/upgrade/windows-10-edition-upgrades
5. "Microsoft is cutting Windows 10 Enterprise LTSC support from ten years to five." ZDNet. February 18, 2021. Accessed August 31, 2021. https://www.zdnet.com/article/microsoft-is-cutting-windows-10-enterprise-ltsc-support-from-ten-years-to-five/
6. "Microsoft says that there will be a Windows 11 LTSC release, but it's a few years out." Neowin. July 21, 2021. Accessed August 31, 2021. https://www.neowin.net/news/microsoft-says-that-there-will-be-a-windows-11-ltsc-release-but-its-a-few-years-out/
7. "Question About Windows 10 Trial." Microsoft Community. January 1, 2017. Accessed August 31, 2021. https://answers.microsoft.com/en-us/windows/forum/all/question-about-windows-10-trial/fd9b4d3a-f44c-4a38-ae89-12b4692c744e
8. "Upgrading Windows 10 2016 LTSB to Windows 10 2019 LTSC." Roberto Viola. July 28, 2020. Accessed August 31, 2021. https://robertoviola.cloud/2020/07/28/upgrading-windows-10-2016-ltsb-to-windows-10-2019-ltsc/
9. "How to Restore Windows Photo Viewer in Windows 10." Windows 10 Help Forums. October 30, 2020. Accessed January 15, 2022. https://www.tenforums.com/tutorials/14312-restore-windows-photo-viewer-windows-10-a.html
10. "How to Download APPX file of Any App from Windows Store." WindowsLoop. Accessed April 8, 2022. https://windowsloop.com/how-to-download-appx-file-of-any-app-from-windows-store/
11. "The next Windows 10 Long Term Servicing Channel (LTSC) release." Microsoft Windows IT Pro Blog. February 18, 2021. Accessed July 19, 2022. https://techcommunity.microsoft.com/t5/windows-it-pro-blog/the-next-windows-10-long-term-servicing-channel-ltsc-release/ba-p/2147232
12. "Windows for IoT Lifecycle pages." Microsoft Docs. May 2, 2022. Accessed January 11, 2023. https://docs.microsoft.com/en-us/windows/iot/product-family/product-lifecycle
13. "Windows XP - Microsoft Lifecycle." Microsoft Learn. Accessed January 11, 2023. https://learn.microsoft.com/en-us/lifecycle/products/windows-xp
14. "Windows Vista - Microsoft Lifecycle." Microsoft Learn. Accessed January 11, 2023. https://learn.microsoft.com/en-us/lifecycle/products/windows-vista
15. "This is the end, Windows 7 and 8 friends: Microsoft drops support this week." The Register. January 9, 2023. Accessed January 11, 2023. https://www.theregister.com/2023/01/09/microsoft_windows_7_8_support_ends/
16. "Windows 10 Home and Pro - Microsoft Lifecycle." Microsoft Learn. Accessed January 11, 2023. https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro
17. "How to Stop Windows 11 Automatic Updates – 5 Ways." MiniTool Software. May 18, 2023. Accessed October 24, 2023. https://www.minitool.com/data-recovery/how-to-stop-windows-11-update.html
18. "Specify Target Feature Update Version in Windows 11." Windows 11 Forum. January 31, 2022. Accessed October 24, 2023. https://www.elevenforum.com/t/specify-target-feature-update-version-in-windows-11.3811/
19. "Is Windows 11 All it’s Cracked up to be?" Steeves and Associates. October 18, 2021. Accessed March 10, 2025. https://www.steeves.net/news/is-windows-11-all-its-cracked-up-to-be/
20. "WineD3D For Windows." Federico Dossena. 2025. Accessed March 10, 2025. https://fdossena.com/?p=wined3d/index.frag
21. "DirectDraw Emulation Is Broken In Windows 8/8.1." Microsoft Community. May 29, 2014. Accessed March 10, 2025. https://answers.microsoft.com/en-us/windows/forum/windows_8-gaming/directdraw-emulation-is-broken-in-windows-881/4edfc685-72b2-4688-95ed-c745ddd38825
22. "DirectSound." Microsoft Wiki Fandom. Accessed March 10, 2025. https://microsoft.fandom.com/wiki/DirectSound
23. "Windows Vista restricts non-Win32 apps to 32 MB of memory." Thomas R. Nicely. February 26, 2008. Accessed March 10, 2025. https://web.archive.org/web/20080228231933/http://www.trnicely.net/misc/vista.html
24. "Does Windows still rely on MS-DOS?" Super User. December 4, 2021. Accessed March 10, 2025. https://superuser.com/questions/319056/does-windows-still-rely-on-ms-dos
25. "DirectX." Microsoft Wiki Fandom. Accessed March 10, 2025. https://microsoft.fandom.com/wiki/DirectX
