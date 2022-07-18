Windows Editions
================

.. contents:: Table of Contents

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
   Windows 11 Enterprise LTSC 2024, 5, 10, ""

[5][6][12]

An installation of Windows Enterprise LTSC can switch to the traditional "current" update channel which recieves two major feature updates every year. This essentially turns it into Windows Enterprise. However, downgrading Windows Enterprise to Windows Enterprise LTSC is not supported. [4]

Windows Enterprise LTSC can only be upgraded to a new major release by manually running the "setup.exe" installer from a new ISO image. This can be done with a virtually mounted ISO image as the installation/upgrade files are copied locally to the ``C:\`` drive. Windows Update will not provide upgrades to newer major versions. [8]

Microsoft Store
^^^^^^^^^^^^^^^

By default, the Microsoft Store is not installed on Windows Enterprise LTSC editions. As a workaround, all editions of Windows support manually downloading and installing APPX programs that are typically only available on the Microsoft Store. [10] This includes the Microsoft Store itself. The `LTSC-Add-MicrosoftStore <https://github.com/kkkgo/LTSC-Add-MicrosoftStore>`__ project on GitHub provides all of the required packages. Even though these packages are old, they will install on all versions of Windows Enterprise LTSC >= 2019. After the initial installation of the Microsoft Store, these can all be updated through the Microsoft Store itself.

.. code-block:: powershell

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
-  Windows Settings > Apps > Default apps > Photo viewer > + Choose a default > Windows Photo Viewer

[9]

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
12. "Windows for IoT Lifecycle pages." Microsoft Docs. May 2, 2022. Accessed July 18, 2022. https://docs.microsoft.com/en-us/windows/iot/product-family/product-lifecycle
