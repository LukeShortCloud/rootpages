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

-  Check for issues with the profile:

   .. code-block:: sh

      $ sudo apparmor_parser --preprocess /etc/apparmor.d/<PROFILE>

-  Add a new profile:

   .. code-block:: sh

      $ sudo apparmor_parser --replace /etc/apparmor.d/<PROFILE>

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
      $ sudo apparmor_parser --remove /etc/apparmor.d/<PROFILE>

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

SELinux
-------

Logs
~~~~

View temporary logs with ``dmesg`` (lost on reboot) or enable persistent SELinux logs at ``/var/log/audit/audit.log``. [5]

.. code-block:: sh

   $ sudo dmesg | grep -e type=1300 -e type=1400

.. code-block:: sh

   $ sudo dnf install audit
   $ sudo systemctl start auditd
   # Logs from the last 10 minutes.
   $ sudo ausearch -m AVC,USER_AVC,SELINUX_ERR,USER_SELINUX_ERR -ts recent
   # Logs since midnight.
   $ sudo ausearch -m AVC,USER_AVC,SELINUX_ERR,USER_SELINUX_ERR -ts today
   # All logs that are also human-readable logs
   $ sudo audit2allow -w -a

Additionally check journald logs which will contain different log entries.

.. code-block:: sh

   $ sudo journalctl -t setroubleshoot

Some verbose logs are disabled by default. Disable ``dontaudit`` rules, view the logs, then re-enable it.

.. code-block:: sh

   $ sudo semodule -B -D

.. code-block:: sh

   $ sudo semodule -B

View more details about a specific violation. [6]

.. code-block:: sh

   $ sudo sealert -l <VIOLATION_UUID>

Profiles
~~~~~~~~

Automatically create, view, and install a profile based on violations in ``/var/log/audi/audit.log``. [5]

.. code-block:: sh

   $ sudo audit2allow -a -M <MODULE>
   $ cat <MODULE>.pp
   $ sudo semodule -i <MODULE>.pp

Disable
~~~~~~~

Temporarily switch between permissive and enforcing mode.

.. code-block:: sh

   $ getenforce
   Permissive
   $ sudo setenforce 1
   $ getenforce
   Enforcing

.. code-block:: sh

   $ getenforce
   Enforcing
   $ sudo setenforce 0
   $ getenforce
   Permissive

Permanently switch between permissive, enforcing, or disabled modes. A reboot is required.

.. code-block:: sh

   $ sudo vim /etc/selinux/config
   SELINUX=permissive

.. code-block:: sh

   $ sudo vim /etc/selinux/config
   SELINUX=enforcing

.. code-block:: sh

   $ sudo vim /etc/selinux/config
   SELINUX=disabled

If SELinux was fully disabled with ``SELINUX=disabled`` and has been enabled again, then all files need to be relabeled to prevent issues on the next boot. [5][7]

-  If switching from disabled to permissive mode:

   .. code-block:: sh

      $ sudo touch /.autorelabel
      $ sudo reboot

-  If switching from disabled to enforcing mode:

   .. code-block:: sh

      $ sudo fixfiles -F onboot
      $ sudo reboot

-  bootc = No changes are needed. bootc will automatically fix label issues.

Most operating systems use targeted type for SELinux since it is less restrictive. Multi-Level Security (MLS) was created for more strict policies to compile with military standards.

Change the SELinux type. It is also recommended to first set ``SELINUX=permissive`` before using ``SELINUX=enforcing`` to help troubleshoot any issues. [8]

.. code-block:: sh

   $ sudo vim /etc/selinux/config
   SELINUXTYPE=targeted

.. code-block:: sh

   $ sudo vim /etc/selinux/config
   SELINUXTYPE=mls

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/security/mandatory_access_control.rst>`__

Bibliography
------------

1. "AppArmor." Arch Wiki. September 15, 2021. Accessed October 3, 2021. https://wiki.archlinux.org/title/AppArmor
2. "AppArmor." Ubuntu Community Help Wiki. July 5, 2020. https://help.ubuntu.com/community/AppArmor
3. "Building Profiles from the Command Line." openSUSE Security Guide. 2018. Accessed October 3, 2021. https://doc.opensuse.org/documentation/leap/archive/42.3/security/html/book.security/cha.apparmor.commandline.html
4. "AppArmor HowToUse." Debian Wiki. February 28, 2025. Accessed June 23, 2025. https://wiki.debian.org/AppArmor/HowToUse
5. "Everything you wanted to know about SELinux but were afraid to run." Open Source Watch. May 14, 2024. Accessed July 3, 2025. https://opensourcewatch.beehiiv.com/p/everything-wanted-know-selinux-afraid-run
6. "Troubleshooting Problems Related to SELinux." Fedora Quick Docs. June 18, 2023. Accessed July 3, 2025. https://docs.fedoraproject.org/en-US/quick-docs/selinux-troubleshooting/
7. "A sysadmin's guide to SELinux: 42 answers to the big questions." Opensource.com July 12, 2018. Accessed July 3, 2025. https://opensource.com/article/18/7/sysadmin-guide-selinux
8. "Chapter 6. Using Multi-Level Security (MLS)." Red Hat Documentation. Accessed July 3, 2025. https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/using_selinux/using-multi-level-security-mls
