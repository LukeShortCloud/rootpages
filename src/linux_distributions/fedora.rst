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

Disable Automatic System Updates
--------------------------------

Fedora will, at least, download package metadata by default and, at most, automatically install new packages. Updates can be disabled and handled manually instead.

-  Fedora (all):

   -  Disable GNOME Software Center from checking for updates and applying updates.

      .. code-block:: sh

         $ dconf write /org/gnome/software/allow-updates false
         $ dconf write /org/gnome/software/download-updates false

   -  Optionally also disable GNOME Software Center from starting on boot. [8]

      .. code-block:: sh

         $ sudo rm -f /etc/xdg/autostart/org.gnome.Software.desktop

-  Fedora Workstation [9]:

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/dnf/dnf.conf
      metadata_timer_sync=0
      $ sudo systemctl disable dnf-makecache.timer
      $ sudo systemctl disable dnf-automatic.timer

-  Fedora Silverblue [10]:

   .. code-block:: sh

      $ sudo vim /etc/rpm-ostreed.conf
      [Daemon]
      AutomaticUpdatePolicy=none
      $ sudo rpm-ostree reload
      $ sudo systemctl disable rpm-ostreed-automatic.timer

Fedora Silverblue
-----------------

Dual Booting
~~~~~~~~~~~~

Fedora Silverblue does not support customized partitions or sharing a drive with a different operating system. It is recommended to use the automated installer to install it onto its own storage device. [11]

Through the use of ``os-prober`` (which is part of a default installation), a GRUB menu will be generated with all of the detected operating systems on each drive. This allows for partial dual-boot support.

Two installations of Fedora Silverblue on the same system are also not supported and will lead to issues. [12]

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
8. "How to disable Gnome Software autostart." Reddit r/gnome. October 22, 2022. Accessed February 18, 2023. https://www.reddit.com/r/gnome/comments/gn8rs4/how_to_disable_gnome_software_autostart/
9. "How can I disable automatic updates CHECKING?" Reddit r/Fedora. January 26, 2023. Accessed February 18, 2023. https://www.reddit.com/r/Fedora/comments/p10a5o/how_can_i_disable_automatic_updates_checking/
10. "How to enable automatic system updates in Fedora Silverblue." barnix. May 26, 2020. Accessed February 18, 2023. https://barnix.io/how-to-enable-automatic-update-staging-in-fedora-silverblue/
11. "Installing Fedora Silverblue." Fedora Documentation. September 3, 2022. Accessed February 18, 2023. https://docs.fedoraproject.org/en-US/fedora-silverblue/installation/#known-limitations
12. "Installing Silverblue, side-by-side." Fedora People asamalik. April 13, 2019. Accessed February 18, 2023. https://asamalik.fedorapeople.org/fedora-docs-translations/en-US/fedora-silverblue/installation-dual-boot/
