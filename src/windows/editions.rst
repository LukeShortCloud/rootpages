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

Previously known as the long-term servicing branch (LTSB) in older releases of Windows, LTSC provides a stripped down version of Windows Enterprise. It removes pre-installed applications including [3]:

-  Cortana
-  Edge web browser
-  Microsoft Store
-  OneDrive
-  OneNote
-  Skype

During the supported lifecycle, no features or hardware support are added. Only security and bug fixes are provided.

.. csv-table::
   :header: Name, Years of Support
   :widths: 20, 20

   Windows 10 Enterprise LTSB 2015, 10
   Windows 10 Enterprise LTSB 2016, 10
   Windows 10 Enterprise LTSC 2019, 10
   Windows 10 Enterprise LTSC 2021, 5
   Windows 11 Enterprise LTSC 2024, 5

[5][6]

An installation of Windows Enterprise LTSC can switch to the traditional "current" update channel which recieves two major feature updates every year. This essentially turns it into Windows Enterprise. However, downgrading Windows Enterprise to Windows Enterprise LTSC is not supported. [4]

Windows Enterprise LTSC can only be upgraded to a new major release by manually running the "setup.exe" installer from a new ISO image. This can be done with a virtually mounted ISO image as the installation/upgrade files are copied locally to the ``C:\`` drive. Windows Update will not provide upgrades to newer major versions. [8]

Downloads
---------

Windows can be freely and legally downloaded directly from Microsoft:

-  `Windows 10 Home and Pro <https://www.microsoft.com/en-us/software-download/windows10ISO>`__ = Limited features are enabled until a license key is provided. There is no expiration time for this trial. [7]
-  `Windows 10 Enterprise and Enterprise LTSC <https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise>`__ = A 90 day full trial. License keys can only be purchased in volume by a company and not an individual.

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/windows/editions.rst>`__

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
