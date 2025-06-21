Mandatory Access Control (MAC)
==============================

.. contents:: Table of Contents

AppArmor
--------

Install
~~~~~~~

-  Install the ``apparmor`` package.
-  Add AppArmor to the Linux secuirty modules that will be used on boot along with the dependencies that should be loaded beforehand. This is normally done through GRUB.

   ::

      lsm=landlock,lockdown,yama,apparmor,bpf

-  Enable the service.

   .. code-block:: sh

      $ sudo systemctl enable apparmor

-  Reboot the computer to complete the installation.
-  Verify that it is enabled and running.

   .. code-block:: sh

      $ sudo aa-enabled
      $ sudo aa-status

[1]

Profiles
~~~~~~~~

-  View loaded profiles:

   .. code-block:: sh

      $ sudo aa-status

-  List other example profiles (included with the ``apparmor-profiles`` package):

   .. code-block:: sh

      $ ls /usr/share/apparmor/extra-profiles/

-  Copy an example profile. All profiles that will be enabled have to be in the ``/etc/apparmor.d/`` directory [4]:

   .. code-block:: sh

      $ sudo cp /usr/share/apparmor/extra-profiles/<PROFILE> /etc/apparmor.d/

-  Add a new profile:

   .. code-block:: sh

      $ sudo apparmor_enforce -r /etc/apparmor.d/<PROFILE>

-  Find the actual name of a profile (it is not always the file name):

   .. code-block:: sh

      $ grep -P ^profile /etc/apparmor.d/<PROFILE>

-  Enable a profile:

   .. code-block:: sh

      $ sudo aa-enforce <PROFILE>

-  Disable a profile but keep logging enabled:

   .. code-block:: sh

      $ sudo aa-complain <PROFILE>

-  Disable a profile completely:

   .. code-block:: sh

      $ sudo ln -s /etc/apparmor.d/<PROFILE> /etc/apparmor.d/disable/
      $ sudo apparmor_parser -R /etc/apparmor.d/<PROFILE>

[2]

-  Delete a profile [3]:

   .. code-block:: sh

      $ sudo rm -f /etc/apparmor.d/<PROFILE>
      $ sudo systemctl reload apparmor

Disable
~~~~~~~

For testing purposes, AppArmor can be temporarily disabled. Set the Linux kernel boot arguments to disable AppArmor.

::

   apparmor=0

Alternatively, use a different MAC such as SELinux. Only one MAC implementation can be used on Linux at a time. [2]

::

   security=selinux

[2]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/security/mandatory_access_control.rst>`__

Bibliography
------------

1. "AppArmor." Arch Wiki. September 15, 2021. Accessed October 3, 2021. https://wiki.archlinux.org/title/AppArmor
2. "AppArmor." Ubuntu Community Help Wiki. July 5, 2020. https://help.ubuntu.com/community/AppArmor
3. "Building Profiles from the Command Line." openSUSE Security Guide. 2018. Accessed October 3, 2021. https://doc.opensuse.org/documentation/leap/archive/42.3/security/html/book.security/cha.apparmor.commandline.html
4. "AppArmor HowToUse." Debian Wiki. February 28, 2025. Accessed June 23, 2025. https://wiki.debian.org/AppArmor/HowToUse
