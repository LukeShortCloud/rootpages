Fedora
======

.. contents:: Table of Contents

Red Hat Enterprise Linux (RHEL)
-------------------------------

RHEL is a downstream distribution, based on Fedora, aimed at servers.

.. csv-table::
   :header: FEATURE, RHEL, Oracle Linux, AlmaLinux, Rocky Linux
   :widths: 20, 20, 20, 20, 20

   Years of support, >= 12 [1], 10, 10, 10
   Organization type, Profit, Profit, Non-profit [2], Profit
   Price, Free up to 16 servers [3], Free, Free, Free
   Optional paid support, Yes, Yes, Yes, Yes
   Btrfs support, No, Yes [4], No, No

Set root Password
-----------------

As of Fedora 28, the ``root`` user password is disabled for security reasons. This means that traditional emergency mode will not work and instead result in this error [7]:

::

   Cannot open access to console, the root account is locked.
   See sulogin(8) man page for more details.
   
   Press Enter to continue.

Set the ``root`` password to be able to enter emergency mode if ever needed:

.. code-block:: sh

   $ sudo passwd root

If the password is not set and emergency mode needs to be accessed, Fedora provides a `guide <https://docs.fedoraproject.org/en-US/quick-docs/bootloading-with-grub2/#restoring-bootloader-using-live-disk>`__ on how to ``chroot`` into the file system from a recovery media. Then the password can be changed from there.

Remove Flathub Filter
---------------------

Starting with Fedora 38, the Flathub repository (used for installing community Flatpak packages) is no longer filtered to only be Fedora approved packages. [5] On Fedora 37 and older, the filter prevented installing popular packages such as Google Chrome. This filter can be removed. [6]

.. code-block:: sh

   $ flatpak remote-list
   Name    Options
   fedora  system,oci
   flathub system,filtered
   $ sudo flatpak remote-modify flathub --no-filter
   $ flatpak remote-list
   Name    Options
   fedora  system,oci
   flathub system

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/fedora.rst>`__

Bibliography
------------

1. "Red Hat Enterprise Linux Life Cycle." Red Hat Customer Portal. Accessed July 14, 2022. https://access.redhat.com/support/policy/updates/errata
2. "The AlmaLinux OS Foundation." AlmaLinux Wiki. Accessed July 14, 2022. https://wiki.almalinux.org/Transparency.html#we-strive-to-be-transparent
3. "No-cost Red Hat Enterprise Linux Individual Developer Subscription: FAQs." Red Hat Developer. February 5, 2021. Accessed July 14, 2022. https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux
4. "Get Started With the Btrfs File System on Oracle Linux." Oracle Help Center. Accessed July 14, 2022. https://docs.oracle.com/en/learn/btrfs-ol8/index.html
5. "Fedora 38 To Get Rid Of Its Flathub Filtering, Allowing Many More Apps On Fedora." Phoronix. February 6, 2023. Accessed February 6, 2023. https://www.phoronix.com/news/Fedora-38-Unfiltered-Flathub
6. "What "filter" was in place for flathub?" Reddit r/Fedora. May 1, 2022. Accessed February 6, 2023. https://www.reddit.com/r/Fedora/comments/rv43uv/what_filter_was_in_place_for_flathub/
7. "Cannot open access to console, the root account is locked in emergency mode (dracut emergency shell)." Ask Fedora. November 21, 2021. Accessed February 18, 2023. https://ask.fedoraproject.org/t/cannot-open-access-to-console-the-root-account-is-locked-in-emergency-mode-dracut-emergency-shell/2010
