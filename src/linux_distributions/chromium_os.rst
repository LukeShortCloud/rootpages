Chromium OS
===========

.. contents:: Table of Contents

Support
-------

Chromebooks receive anywhere between 5 and 8 years of Chrome OS updates [14]. When it becomes end-of-life, the operating system will continue to work but will also become vulnerable to unpatched security flaws. A list of every Chromebooks' update expiration date can be found `here <https://support.google.com/chrome/a/answer/6220366?hl=en>`__.

Update Channels
~~~~~~~~~~~~~~~

There are three update channels to choose from for Chrome OS updates. This can be changed by going to: ``Settings`` > ``About Chrome OS`` > ``Additional details`` > ``Channel`` > ``Change channel`` [15].

-  Chrome OS >= 94

   -  Stable (default) = Major upgrades every 4 weeks.
   -  Extended stable (enterprise only) = Major upgrades every 8 weeks.
   -  Beta = Major upgrades every 4 weeks. This upgrade rolls out 2 weeks before the next stable release.
   -  Developer = Updates twice a week. Those updates can be minor or major and usually contain new experimental features. This is not to be confused with ``Developer Mode`` which is different.
   -  Canary = Updates almost every day. This is an extremely experimental update channel that can only be enabled on the CLI.

-  Chrome OS < 94

   -  Stable (default) = Minor updates every 3 weeks. Major upgrades every 6 weeks.
   -  Beta = Minor updates every week. Major upgrades every 6 weeks.
   -  Developer
   -  Canary

[30]

Check `here <https://chromereleases.googleblog.com/search/label/Chrome%20OS>`__ for information on the latest channel updates for Chrome OS.

Keyboard Shortcuts
------------------

Chromebooks come with modified keyboards that do not include the traditional layout of keys. These are shortcuts that replace some of those dedicated keys and also improve the experience of using Chrome OS. Note that the ``<SEARCH>`` key is located where the ``<CAPS_LOCK>`` key normally is.

-  (View keyboard shortcuts): ``CTRL`` + ``ALT`` + (``?`` OR ``/``)
-  Page Up: ``<SEARCH>`` + ``<UP_ARROW>``
-  Page Down: ``<SEARCH>`` + ``<DOWN_ARROW>``
-  Home (start of line): ``<SEARCH>`` + ``<LEFT_ARROW>``
-  End (end of line): ``<SEARCH>`` + ``<RIGHT_ARROW>``
-  Delete (backspace in reverse): ``<SEARCH>`` + ``backspace``
-  Caps Lock: ``<SEARCH>`` + ``<ALT>``
-  Function keys 1 through 12: ``<SEARCH>`` + (``1`` THROUGH ``=``)
-  (Move to the next word): ``SHIFT`` + ``CTRL`` + (``<LEFT_ARROW>`` OR ``<RIGHT_ARROW>``)
-  (Dock a window to the left or right): ``ALT`` + (``[`` OR ``]``)
-  (Dock a window to the top or bottom)*: ``ALT`` + ``SHIFT`` + (``<UP_ARROW>`` OR ``<DOWN_ARROW>``)
-  (Adjust the keyboard backlight): ``ALT`` + (``<BRIGHTNESS_DOWN>`` OR ``<BRIGHTNESS_UP>``)
-  (View all windows and virtual desks): ``[]||``
-  (Create a new virtual desk): ``SHIFT`` + ``<SEARCH>`` + ``+``
-  (Close a virtual desk. All windows will be moved to the next available virtual desk): ``SHIFT`` + ``<SEARCH>`` + ``-``
-  (Move to the next virtual desk): ``<SEARCH>`` + (``[`` OR ``]``)
-  (Move to the next word): ``CTRL`` + (``<LEFT_ARROW>`` OR ``<RIGHT_ARROW>``)

[4]

\*Requires the `Windows Manager for Google Chrome <https://chrome.google.com/webstore/detail/windows-manager-for-googl/gophpkegccafhjahoijdembdkbjpiflb>`__ extension.

Powerwash
---------

A Powerwash is a factory reset of the Chrome OS operating system. This will delete all local files on the device.

From a Chromebook that is powered on and logged in:

1. Settings > Advanced > Privacy & Security > Powerwash

From a Chromebook that is powered on and logged out [39]:

1. Press ``CTRL``, ``ALT``, ``SHIFT``, and ``r``.
2. Select "Powerwash".

From a Chromebook that is powered off [40]:

0. Visit the `Chrome OS recovery page <https://google.com/chromeos/recovery>`__ to download a recovery image and setup a >= 8 GB flash drive.
1. Press ``ESC``, ``F2`` (the refresh key), and the power button.
2. Let go of the power button.
3. Select "Recovery using external storage" and follow the on-screen instructions.

Developer Mode
--------------

Chromebooks have an optional Developer Mode that unlocks additional features of Chrome OS. It allows the usage of a shell, ``root`` user access, writing to the root file system,  and the ability to boot and install other operating systems. [5][6][8] Debugging features can also be enabled to install additional tools. If debugging features are not enabled immediately, all of those tools and features are still available through Developer Mode. [46]

Enable Developer Mode
~~~~~~~~~~~~~~~~~~~~~

Enabling this mode will Powerwash (reset) the device. All local data will be lost.

1.  Start the Chromebook in Recovery mode by pressing ``ESC``, ``F2`` (refresh), and ``<POWER>``.
2.  Enter Developer Mode:

   2a.  New Chrome OS devices:

      -  Advanced options > Enable developer Mode > Confirm

   2b.  Old Chrome OS devices:

      -  Once booted, press ``CTRL`` + ``d`` to boot into Developer Mode.

3.  Optionally select to enable debugging features. This will install additional tools

Use the command ``chromeos-setdevpasswd`` to enable the sudo password for the ``chronos`` user in the ``Secure Shell App``. Use the password that was set when enabling debugging features to access the ``root`` account.

-  Using ``Secure Shell App`` by pressing ``CTRL`` + ``ALT`` + ``t``:

   ::

      crosh> shell
      chronos@localhost / $ ssh -l root 127.0.0.1
      localhost ~ # chromeos-setdevpasswd

-  Using the tty2 console by pressing ``CTRL`` + ``ALT`` + ``-->``:

   ::

      localhost login: root
      Password:
      localhost ~ # chromeos-setdevpasswd

Boot
~~~~

When booting a Chromebook in Developer Mode, there are a few options to choose from. By default, a screen will appear for 30 seconds saying ``OS verification is OFF``. It will beep and continue to boot into local storage if no boot option is specified via keyboard shortcuts. Pressing the ``<SPACE>`` bar will powerwash the Chromebook.

-  Internal storage = ``CTRL`` + ``d``.
-  External storage = ``CTRL`` + ``u``.
-  Legacy bootloader (SeaBIOS) = ``CTRL`` + ``l`` (L).

   -  This is not installed by default. Refer to the `Bootloaders <#bootloaders>`__ section on how to set it up.

[7]

Bootloaders
~~~~~~~~~~~

The `MrChromebox/scripts <https://github.com/MrChromebox/scripts>`__ project provides a useful utility for modifying the bootloader firmware on Chromebooks. All Chromebooks can run a legacy SeaBIOS bootloader to allow USB-booting. Some Chromebooks support the full UEFI Tianocore bootloader so that it can install a different operating system such as Linux, mac OS, or Windows. A full list of what devices are compatible can be found `here <https://mrchromebox.tech/#devices>`__. [22]

Enable USB UEFI booting in Chrome OS. [24]

.. code-block:: sh

   crosh> shell
   chronos@localhost / $ sudo crossystem dev_boot_usb=1

Optionally enable USB legacy BIOS booting in Chrome OS.

.. code-block:: sh

   chronos@localhost / $ sudo crossystem dev_boot_legacy=1

Then download and run the interactive script.

.. code-block:: sh

   chronos@localhost / $ cd ~
   chronos@localhost ~ $ curl -LO mrchromebox.tech/firmware-util.sh && sudo bash ./firmware-util.sh

The white Chrome OS ``OS verification is OFF`` screen that starts with 100% brightness can be replaced by a black screen by selecting the ``Remove ChromeOS Bitmaps`` option.

Terminal
~~~~~~~~

The ``Secure Shell App`` is the official way to access a shell terminal from within Chrome OS. With the Google Chrome web browser open, press ``CTRL`` + ``ALT`` + ``t`` to open the app. It will start in ``crosh`` (the Chrome Shell).

View all of the available commands in ``crosh`` and their help descriptions.

::

   crosh> help
   crosh> help_advanced

Open a full shell terminal in Developer Mode to access more commands.

::

   crosh> shell

The app will beep if a command or file cannot be auto-completed. This can be disabled. Open preferences: ``CTRL`` + ``SHIFT`` + ``p``. Go to ``Sounds`` > ``Alert bell sound (URI)`` and then remove the string.

SSH Server
~~~~~~~~~~

Start the openssh-server and open port 22.

.. code-block:: sh

   chronos@localhost / $ sudo /usr/sbin/sshd
   chronos@localhost / $ sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

Add authorized SSH public keys to the ``chronos`` account.

.. code-block:: sh

   chronos@localhost / $ vim /home/chronos/user/.ssh/authorized_keys
   chronos@localhost / $ chmod 0600 /home/chronos/user/.ssh/authorized_keys

Authorized SSH public keys can be added to the ``root`` account if the `root file system is writable <#writable-and-executable-file-systems>`_.

.. code-block:: sh

   chronos@localhost / $ sudo mount -o remount,rw /
   chronos@localhost / $ sudo mkdir /root/.ssh/
   chronos@localhost / $ sudo chmod 0750 /root/.ssh
   chronos@localhost / $ sudo vim /root/.ssh/authorized_keys
   chronos@localhost / $ sudo chmod 0600 /root/.ssh/authorized_keys

Updates
~~~~~~~

Change Update Channel
^^^^^^^^^^^^^^^^^^^^^

Channels can be changed on any Chromebook not in Developer Mode by going to ``Settings > About Chrome OS > Additional Details > Channel > Change channel`` and selecting ``Stable``, ``Beta``, or ``Developer - unstable``. However, this will require a Powerwash which will factory reset the Chromebook and does not expose the ``Canary`` channel.

With Developer Mode enabled, it is possible to change channels on the CLI without a Powerwash. If going from a newer channel to an older one (Dev to Beta, Dev to Stable, or Beta to Stable), Chrome OS will automatically update when that channel catches up to your version.

Syntax:

.. code-block:: sh

   chronos@localhost / $ update_engine_client --nopowerwash --channel={stable,beta,dev,canary}-channel

Example:

.. code-block:: sh

   chronos@localhost / $ update_engine_client --nopowerwash --channel=stable-channel
   chronos@localhost / $ update_engine_client --show_channel
   [0304/220556.325714:INFO:update_engine_client.cc(447)] Current Channel: beta-channel
   [0304/220556.325824:INFO:update_engine_client.cc(450)] Target Channel (pending update): stable-channel

Rollback to an Older Version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Rollback to the last update that was installed. This will change the A/B partition mounts on the next boot.

.. code-block:: sh

   chronos@localhost / $ update_engine_client --rollback --nopowerwash

Alternatively, switch to a different update channel and download/install the update immediately.

.. code-block:: sh

   chronos@localhost / $ update_engine_client --update --nopowerwash --channel={stable,beta,dev,canary}-channel

Package Managers
~~~~~~~~~~~~~~~~

Chromebrew
^^^^^^^^^^

Chromebrew is an unofficial package manager for Chromium OS written in Ruby. It works on all processor architectures that Chromium OS supports. It requires ``Developer Mode`` to be enabled and that Chrome OS is on the ``Stable`` channel.

Install:

.. code-block:: sh

   $ curl -Ls git.io/vddgY | bash

Usage:

.. code-block:: sh

   $ crew {build,const,download,files,help,install,list,postinstall,reinstall,remove,search,update,upgrade,whatprovides}
   $ crew help <ARGUMENT>

Find and install a package. The `full list of packages <https://github.com/skycocker/chromebrew/tree/master/packages>`__ is listed in it's GitHub repository. Over one thousand packages are available.

.. code-block:: sh

   $ crew search <PACKAGE>
   $ crew install [--build-from-source] <PACKAGE>

Installing a package will remove other packages that are already installed. Use the ``--keep`` argument to prevent uninstalling them:

.. code-block:: sh

   $ crew install --keep <INSTALLED_PACKAGE> <NEW_PACKAGE>

[19]

emerge
^^^^^^

``emerge`` is the official package manager for Gentoo and, by extension, Chrome OS. Installing emerge, along with a few other developer packages, will first delete everything in ``/usr/local/``. For a more useful package manager, use `Chromebrew <#chromebrew>`_.

Install:

.. code-block:: sh

   chronos@localhost / $ dev_install

Reinstall:

.. code-block:: sh

   chronos@localhost / $ dev_install --reinstall

Uninstall:

.. code-block:: sh

   chronos@localhost / $ dev_install --uninstall

[29]

By default, only a few local packages can be installed.

.. code-block:: sh

   chronos@localhost / $ sudo find /usr/local/portage/packages/ | grep tbz2
   /usr/local/portage/packages/dev-lang/python-exec-2.0.1-r1.tbz2
   /usr/local/portage/packages/dev-lang/python-3.6.5-r5.tbz2
   /usr/local/portage/packages/dev-lang/python-2.7.15-r5.tbz2
   /usr/local/portage/packages/dev-python/pyblake2-1.1.2-r1.tbz2
   /usr/local/portage/packages/dev-python/pyxattr-0.6.0-r1.tbz2
   /usr/local/portage/packages/sys-libs/gdbm-1.11.tbz2
   /usr/local/portage/packages/net-misc/rsync-3.1.3.tbz2
   /usr/local/portage/packages/app-misc/mime-types-9.tbz2
   /usr/local/portage/packages/app-misc/pax-utils-1.2.3.tbz2
   /usr/local/portage/packages/sys-apps/install-xattr-0.5.tbz2
   /usr/local/portage/packages/sys-apps/portage-2.3.75-r56.tbz2
   /usr/local/portage/packages/sys-apps/less-487.tbz2
   /usr/local/portage/packages/sys-apps/sandbox-2.11-r6.tbz2
   /usr/local/portage/packages/app-eselect/eselect-python-20140125-r1.tbz2

View the packages that are installed:

.. code-block:: sh

   chronos@localhost / $ ls -1 /usr/local/var/db/pkg/sys-apps/

Writable and Executable File Systems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, the root file system is not writable and both the stateful_partition and user directory do not support executable permissions. These can be modified to allow experimentation with the Chrome OS operating system.

-  Remove the root file system verification on both partitions 2 and 4. Depending on the last A/B system update that was applied and in use, the current root file system could be either be on partition 2 or 4.

   .. code-block:: sh

      chronos@localhost / $ sudo /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification --partitions "2 4"

-  Remove the boot verification. Then reboot Chrome OS.

   .. code-block:: sh

      chronos@localhost / $ sudo crossystem dev_boot_signed_only=0

-  Remount all of the locked down Chrome OS partitions with full read, write, and execute (rwx) permissions.

   .. code-block:: sh

      chronos@localhost / $ sudo mount -o remount,rw /
      chronos@localhost / $ sudo mount -o remount,exec /mnt/stateful_partition
      chronos@localhost / $ sudo mount -o remount,exec remount,exec /home/chronos/user

[25][26]

Disable Updates
^^^^^^^^^^^^^^^

Remove the executable permissions from the ``update_engine`` binary.

.. code-block:: sh

   chronos@localhost / $ sudo chmod -x /usr/sbin/update_engine

Then either reboot the Chromebook or kill the running ``update_enigne`` process to stop Chrome OS from updating.

Re-enable updates by deleting the old log file so it will be recreated, make the ``update_engine`` binary executable again, and then start the update daemon.

.. code-block:: sh

   chronos@localhost / $ sudo rm /var/log/update_engine.log
   chronos@localhost / $ sudo chmod +x /usr/sbin/update_engine
   chronos@localhost / $ sudo /usr/sbin/update_engine

Disable SELinux
^^^^^^^^^^^^^^^

Change the SELinux mode from ``enforcing`` to ``permissive``. Do **NOT** change it to ``disabled`` as this will cause Chrome OS to no longer boot. [41]

.. code-block:: sh

   chronos@localhost / $ sudo getenforce
   Enforcing
   chronos@localhost / $ sudo vim /etc/selinux/config
   SELINUX=permissive
   SELINUXTYPE=arc
   chronos@localhost / $ sudo setenforce permissive
   chronos@localhost / $ sudo getenforce
   Permissive

Chromium OS Development
-----------------------

Development Environment
~~~~~~~~~~~~~~~~~~~~~~~

It is recommended to build Chromium OS packages on a separate computer as the official development environment is large and takes a long time to setup. This can take up to 100 GiB of storage space and 3 hours or more to complete but it guarantees compatibility.

Create and use a working directory.

.. code-block:: sh

   $ mkdir chromiumos
   $ cd chromiumos

Download and load-up the ``repo`` command. This can later be loaded up from the ``./src/chromium/depot_tools/`` directory instead.

.. code-block:: sh

   $ git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
   $ export PATH="$(pwd)/depot_tools/:$PATH"

Use the ``repo`` command to download all of the > 200 git repositories for Chromium OS. Use the argument ``-j 8`` for the initial repo sync to download 8 repositories at a time. After the first time, it can be ran with ``-j 16``. By default, the ``main`` branch is pulled down. Another branch can be specified if targetting a specific release. [31]

.. code-block:: sh

   $ repo init -u https://chromium.googlesource.com/chromiumos/manifest.git -b main
   $ repo sync -j 8

Setup the Chromium OS SDK. Once complete, this will change the prompt as it changes into a chroot of Gentoo. In the future, use this command to re-enter the chroot.

.. code-block:: sh

   $ export PATH="$(pwd)/chromite/bin/:$PATH"
   $ cros_sdk
   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $

Find the board name for the Chromebook from `here <https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices>`__. Alternatively, visit ``chrome://version`` on the Chromebook and look for "Platform:". The board name is the last word on that line. Use it to setup the Gentoo packages that mirror what is being used by the latest version of that Chromebook. If using a generic Chromium OS image, it is possible to target ``BOARD=amd64-generic``.

.. code-block:: sh

   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ export BOARD=<CHROMEBOOK_BOARD_NAME>
   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ setup_board --board=${BOARD}
   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ ./build_packages --board=${BOARD}

**Update:**

Update all of the git repositories by running the ``repo sync`` command again.

.. code-block:: sh

   $ repo sync -j 16

**Clean Up:**

If the development environment is no longer required, clean it up using these commands:

.. code-block:: sh

   $ cros_sdk --delete
   $ rm -rf chromiumos

Finding the Stable Branch or Tag
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, ``repo init`` will set git repositories to pull from the latest ``main`` branch. This may not be desired if the goal is to build a specific version of Chromium OS packages. Tags are not provided for non-stable releases.

Update channels:

-  Stable = Uses the ``release-R<CHROME_MAJOR>-<PLATFORM_MAJOR>.B`` branch.

   -  Each stable release has a released tag of ``stabilize-<PLATFORM_MAJOR>.<PLATFORM_MINOR>.B``.

-  Beta = Uses the ``release-R<CHROME_MAJOR>-<PLATFORM_MAJOR>.B`` branch.
-  Dev = Follows the ``main`` branch slowly (once a week).
-  Canary = Follows the ``main`` branch quickly (every six hours). [36]

On the Chromebook, take note of the major "Google Chrome:" version and the major "Platform:" version in ``chrome://version``. [36]

::

   Google Chrome: <CHROME_MAJOR>.<CHROME_MINOR>.<CHROME_BUILD>.<CHROME_PATCH> (Official Build) (64-bit)
   Platform: <PLATFORM_MAJOR>.<PLATFORM_MINOR>.<PLATFORM_PATCH> (Official Build) <UPDATE_CHANNEL>-channel <BOARD>

::

   Google Chrome: 91.0.4472.102 (Official Build) (64-bit)
   Platform: 13904.55.0 (Official Build) stable-channel samus

With these two pieces of information, the exact release branch and tag can be pieced together.

-  Branch = Use this to track the latest updates to the stable release.

   -  Syntax: ``release-R<CHROME_MAJOR>-<PLATFORM_MAJOR>.B``
   -  Example: ``release-R91-13904.B``

-  Tag = Use this to pin the version to a specified stable release.

   -  Syntax: ``stabilize-<PLATFORM_MAJOR>.<PLATFORM_MINOR>.B``
   -  Example: ``stabilize-13904.55.B``

Do a search to ensure that the relevant branch or tag exists.

.. code-block:: sh

   $ cros_sdk
   (cr) ((<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ git branch -a | grep release-R91
     remotes/cros/release-R91-13904.B

.. code-block:: sh

   $ cros_sdk
   (cr) ((<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ git tag | grep stabilize-13904.55.B
     remotes/cros/stabilize-13904.55.B

Resync the repositories to use the specified branch.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ exit
   $ repo init -u https://chromium.googlesource.com/chromiumos/manifest.git -b release-R91-13904.B
   $ repo sync -j 16
   $ cros_sdk

[31]

Installation and Recovery Image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Set the environment variable for the board that will be used.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ export BOARD=<BOARD_NAME>

Optionally configure additional ``USE`` flags for by Portage/emerge while building packages. Flags that are specific to Chromium/Chrome OS but disabled by default are listed in the ``_IUSE`` array in the `platform2.py <https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/common-mk/platform2.py#32>`__ file. [32]

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ vim ../overlays/overlay-${BOARD}/profiles/base/make.defaults
   USE="${USE} <USE_FLAG_1> <USE_FLAG_2>"

Install base system packages into a new chroot created at ``/boot/${BOARD}``. Every time this command is ran it also runs ``update_chroot`` to ensure it has the latest updates. Optionally add the ``--force`` argument to delete and recreate the chroot for the board.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ setup_board --board=${BOARD}

Configure the password for the ``chronos`` user.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ ./set_shared_user_password.sh
   Enter password for shared user account: Password set in /etc/shared_user_passwd.txt

Install all the packages. Similar to the ``setup_board`` command, every time this command is ran it also runs ``update_chroot`` to ensure it has the latest updates. Specify the ``--nowithdebug`` argument to not compile packages with debug mode enabled. The configuration for Portage/emerge that is used is saved to the file ``../../chroot/build/${BOARD}/packages/Packages``.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ ./build_packages --nowithdebug --board=${BOARD}

Build an image using one or more of the specified image types below. Specify the ``--noenable_rootfs_verification`` argument to make the root file system writable by default.

-  base = A production image.
-  dev (default) = Install developer packages.
-  test = Install developer and testing packages.
-  factory_install = Installs factory tests used for the manufacturing of Chromebooks.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ ./build_image --board=${BOARD} --noenable_rootfs_verification <IMAGE_TYPE>

The resulting image will be saved to ``~/trunk/src/build/images/${BOARD}/latest/chromiumos_image.bin`` and will be almost 8 GiB in size. Either (1) convert the raw image into a virtual machine image, (2) copy the image to a flash drive, or (3) use SSH to copy over and flash the image directly onto a Chromebook.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ ./image_to_vm.sh --from=../build/images/${BOARD}/latest --board=${BOARD}

[31]

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ cros flash usb:///dev/<DEVICE> ${BOARD}/latest

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ cros flash ssh://<CHROMEBOOK_IP>:22 ${BOARD}/latest

[33]

For new and future builds where a major package will be changed (such as the Linux kernel) or where many packages will change, the build chroot should be deleted. This will cause the build to start from scratch and avoid package conflicts.

.. code-block:: sh

   $ sudo rm -rf /build/${BOARD}

Built images will take up a lot of space and may optionally be deleted.

.. code-block:: sh

   $ rm -rf /mnt/host/source/src/build/images/${BOARD}

Board Overlays
^^^^^^^^^^^^^^

A Chromium OS build requires an "overlay" to be specified. It is set as the ``${BOARD}`` variable. This overlay provides additional device-specific configurations on-top of a minimal "baseboard" (motherboard) configuration. The baseboard is referred to as the "parent" of the overlay. Only a single overlay can be used (an overlay cannot be nested under a second/different overlay). A list of all baseboards and overlays can be found `here <https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/refs/heads/main>`__.

Select an existing overlay to use. Here are recommended boards based on the processor that the build is targeting:

-  AMD or Intel

   -  amd64-generic = A 64-bit overlay with a set of generic defaults that have a wide range of hardware support.

-  AMD [35]

   -  grunt = AMD Stoney Ridge and Bristol Ridge.
   -  zork = AMD Ryzen.

-  Intel [35]

   -  samus = Intel 1st to 3rd generation.
   -  rammus = Intel 4th to 9th generation.
   -  volteer = Intel >= 10th generation.

-  Arm

   -  arm-generic = Arm 32-bit.
   -  arm64-generic = Arm 64-bit.

Build Flags
^^^^^^^^^^^

USE and IUSE flags are used by the Gentoo and, by extension, Chromium OS package manager Portage/emerge. These are respectively used to enable and disable features. Those, along with other flags, can be used to customize the Chromium OS build. Every build overlay has at least a base profile configuration located at ``/mnt/host/source/src/overlays/overlay-${BOARD}/profiles/base/make.defaults``. These contain the default options. Either modify the flags there or create a new profile.

If any of the flags are changed, it is required to run ``setup_board --force`` or completely delete the build directory at ``/build/${BOARD}``.

Here are a list of common features that can be enabled for a Chromium OS build:

-  Linux

   -  Enable the latest stable Linux kernel with Chrome OS patches applied. This mirrors the logic of ``~/trunk/src/third_party/chromiumos-overlay/profiles/features/kernel/deselect-all-kernels/make.defaults`` by explicitly disabling all other kernels.

      ::

         USE="-kernel-3_18 -kernel-4_4 -kernel-4_14 -kernel-4_19 -kernel-5_4 -kernel-5_10 -kernel-experimental -kernel-next -kernel-upstream-mainline -kernel-upstream-next"
         USE="${USE} kernel-upstream direncription_allow_v2"

   -  Enable a LTS Linux kernel >= 5.4 (for example, 5.10).

      ::

         USE="-kernel-3_18 -kernel-4_4 -kernel-4_14 -kernel-4_19 -kernel-5_4 -kernel-experimental -kernel-next -kernel-upstream-mainline -kernel-upstream-next -kernel-upstream"
         USE="${USE} kernel-5_10 direncription_allow_v2"

   -  Enable a LTS Linux kernel < 5.4 (for example, 4.19).

      ::

         USE="-kernel-3_18 -kernel-4_4 -kernel-4_14 -kernel-5_4 -kernel-5_10 -kernel-experimental -kernel-next -kernel-upstream-mainline -kernel-upstream-next -kernel-upstream -direncription_allow_v2"
         USE="${USE} kernel-4_19"

-  Graphics

   -  Enable the base graphics libraries:

      ::

         USE="${USE} egl fonts opengl opengles X"

   -  Enable all graphics drivers:

      ::

         VIDEO_CARDS="intel llvmpipe nouveau radeon"

   -  Enable AMD graphics drivers:

      ::

         VIDEO_CARDS="-* radeon amdgpu"
         USE="${USE} llvm"

   -  Enable Intel graphics driver:

      ::

         VIDEO_CARDS="intel"

   -  Enable the open source NVIDIA graphics driver. This is not supported on Chrome OS, provides bad performance, and do not support the latest NVIDIA cards.

      ::

         VIDEO_CARDS="nouveau"

   -  Enable CPU-only graphics (for automated testing):

      ::

         VIDEO_CARDS="llvmpipe"

-  Hardware

   -  Enable all Intel wireless firmware.

      ::

         LINUX_FIRMWARE="iwlwifi-all"

   -  Enable NVMe storage support:

      ::

         USE="${USE} nvme"

   -  Enable touchscreen devices:

      ::

         USE="${USE} touchview"

   -  Enable USB type-C support:

      ::

         USE="${USE} typecd"

   -  Enable audio support:

      ::

         USE="${USE} alsa cras"

   -  Enable printer and scanner support:

      ::

         USE="${USE} cups scanner"

-  Virtualization

   -  Enable crosvm support with OpenGL acceleration:

      ::

         USE="${USE} dlc kvm_host crosvm-gpu virtio_gpu"

   -  Enable Borealis (Steam).

      ::

         USE="${USE} dlc has-borealis vm_borealis <BOARD>-borealis"

   -  Enable crosvm Vulkan pass-through support (not currently working).

      ::

         USE="${USE} dlc crosvm_virtio_video crosvm_wl_dmabuf vulkan"

-  Enable CIFS (Windows network file share) support:

   ::

      USE="${USE} drivefs samba smbprovider"

-  Enable all optional features.

   ::

      USE="${USE} buffet"

Custom Linux Kernel
^^^^^^^^^^^^^^^^^^^

It is not recommended to use an unmodified upstream Linux kernel. Chromium OS provides lots of customized patches on-top of LTS Linux kernels. However, it is still possible to build any vanilla or custom kernel.

-  For a vanilla kernel, find a git tag for a related Linux kernel version from `here <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/refs/>`__. Use that to clone the git repository.

   .. code-block:: sh

      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ cd ~/trunk/src/third_party/kernel/
      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/third_party/kernel $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git --depth=1 -b <LINUX_KERNEL_GIT_TAG> experimental
      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/third_party/kernel $ cd -

-  Configure the board to build experimental kernel.

   ::

      USE="${USE} kernel-experimental"

-  Setup a new board build as normal. After that, use the special ``cros-workon`` command to specify that the ``chromeos-kernel-experimental`` package should be built from the locally downloaded kernel in ``~/trunk/src/third_party/kernel/experimental/``.

   -  Otherwise, by default, the ``build_packages`` script will use a known-good commit which is commonly used by the Chromium OS LTS Linux kernels. That does not exist for the ``chromeos-kernel-experimental`` package as Chromium OS has no idea about the custom Linux kernel.

   .. code-block:: sh

      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ export BOARD=<BOARD>
      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ setup_board --board ${BOARD}
      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ cros-workon --board ${BOARD} start chromeos-kernel-experimental

-  The custom Linux kernel is now setup to be built. Continue on with the build as normal.

   .. code-block:: sh

      (cr) ((<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ ./build_packages --board=${BOARD}
      (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ ./build_image --board=${BOARD} --noenable_rootfs_verification <IMAGE_TYPE>

[34]

Linux Kernel
~~~~~~~~~~~~

Kernel
^^^^^^

Building
''''''''

Google uses a fork of upstream Linux kernel. It trackes the long-term support (LTS) releases. Visit `here <https://chromium.googlesource.com/chromiumos/third_party/kernel/+refs>`__ for the full list of branches and tags that can be built.

Here are the currently supported and updated kernel branches according to the `"chromiumos-overlay" source code <https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/main/sys-kernel/>`__:

-  chromeos-5.15
-  chromeos-5.10
-  chromeos-5.4
-  chromeos-4.19
-  chromeos-4.14
-  chromeos-4.4

Other useful branches:

-  ``merge/continuous/chromeos-kernelupstream-<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>`` = The specified `mainline <https://www.kernel.org/>`__ Linux kernel with Chromium OS patches.

   -  ``merge/continuous/chromeos-kernelupstream-<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>-rc<KERNEL_VERSION_RELEASE_CANDIDATE>``

-  ``merge/upstream-kernel`` = The latest mainline Linux kernel with Chromium OS patches.
-  ``stable-merge/linux/v<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>.<KERNEL_VERSION_PATCH>`` = The specified `stable <https://mirrors.edge.kernel.org/pub/linux/kernel/>`__ Linux kernel.

.. code-block:: sh

   $ export KERNEL_CHROMEOS="chromeos-5.15"
   $ git clone --depth 1 https://chromium.googlesource.com/chromiumos/third_party/kernel --branch ${KERNEL_CHROMEOS} ${KERNEL_CHROMEOS}
   $ cd ${KERNEL_CHROMEOS}
   $ ls -1 arch/x86/configs/ | grep chromiumos
   chromiumos-borealis-vm-x86_64_defconfig
   chromiumos-container-vm-x86_64_defconfig
   chromiumos-jail-vm-x86_64_defconfig
   $ make chromiumos-container-vm-x86_64_defconfig
   $ make -j $(nproc) bzImage

[42]

Modules
^^^^^^^

Building
''''''''

Modules can be built for specific Chrome OS kernels. The kernel and/or modules can be compiled regardless of the CPU architecture required when using the cros_sdk environment.

On the Chromebook, find the major ``X.Y`` kernel version.

.. code-block:: sh

   chronos@localhost / $ uname -a

On the Chromebook, save the current kernel build configuration. [27]

.. code-block:: sh

   chronos@localhost / $ sudo modprobe configs
   chronos@localhost / $ cat /proc/config.gz | gunzip > ~/Downloads/config

Copy the configuration to the computer that is building the Linux kernel and into the correct kernel version directory. Edit it to adjust the kernel and/or module build.

.. code-block:: sh

   $ cp config chromiumos/src/third_party/kernel/v<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>/

In the ``cros_sdk`` chroot, change into the directory of the kernel source code.

.. code-block:: sh

   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ cd ~/trunk/src/third_party/kernel/v<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>/

On the Chromebook, take note of the ``chrome://version`` "Platform:" details.

::

   Platform: 13729.41.0 (Official Build) beta-channel samus

Using the major release number (13729 in this example), the kernel version, and optionally the Chrome OS release, it is possible to track down the exact kernel source code branch for the running kernel on the Chromebook. This is important to match because building generic kernel modules will not work. The versions have to match exactly. Even if the intent is to replace the running kernel with a customized one, this branch will contain backports specific to the Chromebook board.

.. code-block:: sh

   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/third_party/kernel/v4.14/ $ git branch -a | egrep "release-.*13729.*-chromeos-4.14"
   remotes/cros/release-R89-13729.B-chromeos-4.14
   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/third_party/kernel/v4.14/ $ git checkout cros/release-R89-13729.B-chromeos-4.14

Build the kernel or just the modules.

.. code-block:: sh

   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/third_party/kernel/v<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>/ $ make

.. code-block:: sh

   (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/third_party/kernel/v<KERNEL_VERSION_MAJOR>.<KERNEL_VERSION_MINOR>/ $ make modules

[28]

Manual Install
''''''''''''''

Mount the root file system as writable, copy the kernel module, and then load it to ensure it works.

Example of installing the ``cifs`` module after building it:

.. code-block:: sh

   chronos@localhost / $ sudo mount -o remount,rw /
   chronos@localhost / $ sudo mkdir /lib/modules/4.14.214-17103-g887e64348b2b/kernel/fs/cifs/
   chronos@localhost / $ sudo cp ~/Downloads/cifs.ko /lib/modules/4.14.214-17103-g887e64348b2b/kernel/fs/cifs/
   chronos@localhost / $ sudo depmod
   chronos@localhost / $ sudo modprobe cifs

If the module fails to load with this error, it is possible that it was compiled for the wrong kernel or CPU architecture. It needs to be built against the exact kernel that is currently installed on the system.

.. code-block:: sh

   chronos@localhost / $ sudo modprobe <KERNEL_MODULE>
   modprobe: ERROR: could not insert '<KERNEL_MODULE>': Exec format error

Brunch
~~~~~~

`Brunch <https://github.com/sebanc/brunch>`__ is a framework that allows installing the official Chrome OS operating system on any computer with all of the features available such as Android support. It takes a custom build of Chromium OS image and injects the boot loader settings into an official Chrome OS recovery image so that any device can be booted up with it (not just the Chromebook/Chromebox that the recovery image was designed for). Brunch installs these modifications into the unused "C" file system partitions. The Brunch project is a spiritual successor to `Project Croissant (also known as Chromefy) <https://github.com/imperador/chromefy>`__. [37]

Building
^^^^^^^^

-  Load up the Chromium OS developer chroot. This will include the binary ``cgpt`` which is required to build Brunch.

   .. code-block:: sh

      $ cd chromiumos
      $ export PATH="$(pwd)/chromite/bin/:$PATH"
      $ cros_sdk
      (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $

-  Download a Chrome OS recovery image from `cros.tech <https://cros.tech/>`__ depending on the processor of the device that Chrome OS will be installed onto. Unzip the archive that was downloaded.

   -  Intel 1st to 9th generation = `board: rammus <https://cros.tech/device/rammus>`__ = ASUS Chromebook Flip C434
   -  Intel 10th and newer generation = `board: volteer <https://cros.tech/device/volteer>`__ = Acer Chromebook Spin 713 (CP713-3W)
   -  AMD Stoney Ridge and Bristol Ridge = `board: grunt <https://cros.tech/device/grunt>`__ = Acer Chromebook 311 (C721)
   -  AMD Ryzen = `board: zork <https://cros.tech/device/zork>`__ = ASUS Chromebook Flip CM5

-  Download the latest `stable release of Brunch <https://github.com/sebanc/brunch/releases>`__. For the best results, this should be the same major version as the Chrome OS recovery image that was downloaded. Alternatively, download the latest `unstable release of Brunch <https://github.com/sebanc/brunch-unstable/releases>`__.

   .. code-block:: sh

      (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ mkdir ~/brunch/
      (cr) (main/(<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ cd ~/brunch/
      (cr) <USER>@<HOTSNAME> ~/brunch $ wget https://github.com/sebanc/brunch/releases/download/r<CHROME_OS_RELEASE>-stable-<DATE>/brunch_r<CHROME_OS_RELEASE>_stable_<DATE>.tar.gz
      (cr) <USER>@<HOTSNAME> ~/brunch $ tar -x -f brunch_r<CHROME_OS_RELEASE>_stable_<DATE>.tar.gz

-  Create a Brunch installer image for Chrome OS. This wil be 14 GB in size.

   .. code-block:: sh

      (cr) <USER>@<HOTSNAME> ~/brunch $ sudo ./chromeos-install.sh -src <CHROME_OS_RECOVERY_IMAGE>.bin -dst brunch.bin

-  Flash the installer image to an external drive.

   .. code-block:: sh

      (cr) <USER>@<HOTSNAME> ~/brunch $ sudo dd if="/home/${USER}/brunch/brunch.bin" of=/dev/<DEVICE>

[37]

Linux
-----

Crostini
~~~~~~~~

Crostini is an official set of technologies used to securely run Linux on Chrome OS in an isolated environment. It creates a minimal Chrome OS virtual machine (VM) called ``termina`` that then starts a LXC container named ``penguin``.  By default, the ``penguin`` container uses Debian 10 Buster as of Chrome OS 80. [3] It does not require Developer Mode.

Enable it by going into Chrome OS settings and selecting ``Linux (Beta)``. [1] A new ``Terminal`` app will appear to access the terminal of the container. Alternatively, the Chrome web browser can be used to access the terminal by going to ``chrome-untrusted://terminal/html/terminal.html``.

Virtual Machine Management (crosvm)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Chrome OS Virtual Machine Monitor, also known as "crosvm", is a virtual machine monitor similar to QEMU. It is designed to work with the KVM hypervisor and uses VirtIO paravirtualization. [44]

Custom Virtual Machine
''''''''''''''''''''''

Build
&&&&&

The default ``termina`` virtual machine is based on Chrome OS. However, a custom virtual machine can be created and used via crosvm.

-  Google recommends creating two separate virtual storage devices for a virtual machine: one containing the root file system and a second for storing additional data. However, it is possible to run a crosvm virtual machine with just one.

   -  Raw disks:

      .. code-block:: sh

         $ truncate -s 5G root.img
         $ mkfs.ext4 ./root.img
         $ mkdir rootfs
         $ sudo mount root.img rootfs/
         $ fallocate --length 10G storage.img
         $ mkfs.ext4 ./storage.img

   -  Virtual disks:

      .. code-block:: sh

         $ qemu-img create -f qcow2 -o size=5G root.qcow2
         $ virt-format --filesystem=ext4 --add root.qcow2
         $ sudo guestmount --add root.qcow2 --mount /dev/sda1 ./rootfs/
         $ qemu-img create -f qcow2 -o size=10G storage.qcow2
         $ virt-format --filesystem=ext4 --add storage.qcow2

-  Install the base packages for a desired Linux distribution.

   -  Arch Linux:

      .. code-block:: sh

         $ sudo pacstrap -i ./rootfs/ base

   -  Debian:

      .. code-block:: sh

         $ sudo debootstrap stable ./rootfs/ http://deb.debian.org/debian/

-  Configure the basic Linux file system mounts:

   .. code-block:: sh

      $ echo "tmpfs /tmp tmpfs defaults 0 0" | sudo tee -a ./rootfs/etc/fstab
      $ echo "tmpfs /var/log tmpfs defaults 0 0" | sudo tee -a ./rootfs/etc/fstab
      $ echo "tmpfs /root tmpfs defaults 0 0" | sudo tee -a ./rootfs/etc/fstab
      $ echo "sysfs /sys sysfs defaults 0 0" | sudo tee -a ./rootfs/etc/fstab
      $ echo "proc /proc proc defaults 0 0" | sudo tee -a ./rootfs/etc/fstab

-  Set a root password:

   ::

      $ sudo chroot ./rootfs/
      [root@localhost /]# passwd root

-  For optional additional configuration, mount ``sysfs`` to allow more Linux utilities to work.

   ::

      [root@localhost /]# mount sysfs -t sysfs /sys

-  Exit the chroot:

   ::

      [root@localhost /]# exit

-  Unmount the root file system.

   -  Raw disks:

      .. code-block:: sh

         $ umount ./rootfs/

   -  Virtual disks:

      .. code-block:: sh

         $ sudo guestunmount ./rootfs/

-  Build the Chromium OS kernel that is optimized for use with virtual machines:

   .. code-block:: sh

      $ git clone --depth 1 -b chromeos-5.15 https://chromium.googlesource.com/chromiumos/third_party/kernel kernel-chromeos-5.15
      $ cd kernel-chromeos-5.15
      $ make chromiumos-container-vm-x86_64_defconfig
      $ make -j $(nproc) bzImage
      $ cp arch/x86/boot/bzImage ../bzImage-chromeos-5.15
      $ cd ../

   -  These are the minimum requirements for the Linux kernel configuration [43]:

      ::

         CONFIG_VT=y
         CONFIG_INPUT=y
         CONFIG_VIRTIO_INPUT=y
         CONFIG_INPUT_EVDEV=y

-  Start the virtual machine.

   -  At a minimum, a virtual machine requires a root disk.

      -  Raw disks (``--rwroot`` implies ``-p root=/dev/vda -p rw``):

         .. code-block:: sh

            $ crosvm run --disable-sandbox --rwroot "$(pwd)/root.img" -p init=/bin/bash bzImage-chromeos-5.15

      -  Virtual disks:

         .. code-block:: sh

            $ crosvm run --disable-sandbox --rwroot "$(pwd)/root.qcow2" -p root=/dev/vda1 -p init=/bin/bash bzImage-chromeos-5.15

   -  At most, a virtual machine can specify a root disk and any number of additional disks for storage.

      -  Raw disks:

         .. code-block:: sh

            $ crosvm run --disable-sandbox --rwroot "$(pwd)/root.img" --rwdisk "$(pwd)/storage.img" -p init=/bin/bash bzImage-chromeos-5.15

      -  Virtual disks:

         .. code-block:: sh

            $ crosvm run --disable-sandbox --rwroot "$(pwd)/root.qcow2" --rwdisk "$(pwd)/storage.qcow2" -p root=/dev/vda1 -p init=/bin/bash bzImage-chromeos-5.15

[42]

Networking
&&&&&&&&&&

By default, a crosvm virtual machine does not have any networking configured. Networking requires either root access or that the ``crosvm`` process has the CAP_NET_ADMIN Linux capability. [45] Use the arguments ``--host_ip``, ``--netmask``, and ``--mac`` to enable networking. [43] This will create a network tap device on the hypervisor called ``vmtap<NUMBER>``. That tap device should automatically have the host IP, subnet mask, and MAC address configured.

.. code-block:: sh

   $ sudo crosvm run --disable-sandbox --rwroot "$(pwd)/root.img" --host_ip=10.0.0.1 --netmask=255.255.255.0 --mac="AA:BB:CC:00:00:10" bzImage-chromeos-5.15

-  Find the ``vmtap<NUMBER>`` number by running ``ip link`` and looking for the MAC address. On Chrome OS, it may be a higher number because Android, Borealis, and Linux run as virtual machines and also use tap devices. On other Linux distributions, this will start with ``vmtap0``.

   .. code-block:: sh

      $ ip link | grep -B 1 "aa:bb:cc:00:00:10"
      17: vmtap6: <BROADCAST,ALLMULTI,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
          link/ether aa:bb:cc:00:00:10 brd ff:ff:ff:ff:ff:ff

-  Networking types:

   -  **Bridge** = The tap can be added to a bridge to give it direct access to the LAN.

      .. code-block:: sh

         $ sudo brctl addif br0 vmtap6
         $ sudo ip link set vmtap6 master br0

      -  In the virtual machine, setup IP addressing for the LAN.

         .. code-block:: sh

            $ sudo ip address add 192.168.1.123/24 dev enp0s4
            $ sudo ip link set enp0s4 up
            $ sudo ping -c 4 192.168.1.1
            $ sudo ip route add default via 192.168.1.1
            $ sudo ping -c 4 8.8.8.8

   -  **NAT** = On Chrome OS, a bridge device will not be available by default. Instead, a NAT can be created between the tap interface and the wireless ``wlan0`` or wired ``eth0`` interface. [43]

      .. code-block:: sh

         $ sudo sysctl net.ipv4.ip_forward=1
         $ sudo iptables -t nat  -A POSTROUTING -o wlan0 -j MASQUERADE
         $ sudo iptables -A FORWARD -i wlan0 -o vmtap6 -m state --state RELATED,ESTABLISHED -j ACCEPT
         $ sudo iptables -A FORWARD -o wlan0 -i vmtap6 -j ACCEPT

      -  In the virtual machine, setup IP addressing so that it can route through the hypervisor IP that is setup with NAT.

         .. code-block:: sh

            $ sudo ip address add 10.0.0.2/24 dev enp0s4
            $ sudo ip link set enp0s4 up
            $ sudo ping -c 4 10.0.0.1
            $ sudo ip route add default via 10.0.0.1
            $ sudo ping -c 4 8.8.8.8

-  Troubleshooting = On Chrome OS, crosvm may setup restrictive firewall rules.

   -  Check to see if any rules exist in the iptables NAT table.

      .. code-block:: sh

         $ iptables -t nat -S | grep vmtap6

   -  Delete any that exist.

      .. code-block:: sh

         # Ingress rules.
         $ sudo iptables -t nat -D ingress_default_forwarding -i vmtap6 -m socket --nowildcard -j ACCEPT
         $ sudo iptables -t nat -D ingress_default_forwarding -i vmtap6 -p tcp -j DNAT --to-destination 100.115.92.6
         $ sudo iptables -t nat -D ingress_default_forwarding -i vmtap6 -p udp -j DNAT --to-destination 100.115.92.6
         # DNS rules.
         $ sudo iptables -t nat -D redirect_default_dns -i vmtap6 -p tcp -m tcp --dport 53 -j DNAT --to-destination 100.115.92
         $ sudo iptables -t nat -D redirect_default_dns -i vmtap6 -p udp -m udp --dport 53 -j DNAT --to-destination 100.115.92.13

Container Management (LXC)
^^^^^^^^^^^^^^^^^^^^^^^^^^

With Developer Mode enabled, the ``termina`` VM can be manually edited with the ``vmc`` command. It can enable GPU acceleration, enable audio capture, export/save the VM, share files, and attach USB devices. New containers can also be created.

-  Manually start the ``termina`` virtual machine with graphics acceleration and then automatically SSH into it.

::

   crosh> vmc start --enable-gpu --enable-vulkan termina
   (termina) chronos@localhost ~ $

-  Manually connect via SSH to an already running ``termina`` VM.

::

   crosh> vsh termina
   (termina) chronos@localhost ~ $

-  View all of the created containers. By default, there should only be the ``penguin`` container.

::

   (termina) chronos@localhost ~ $ lxc ls

-  A list of all LXC images can be found `here <https://us.images.linuxcontainers.org/>`__ or by running:

::

   (termina) chronos@localhost ~ $ lxc image list images:

-  Create new containers:

::

   (termina) chronos@localhost ~ $ lxc launch images:<IMAGE_NAME>/<IMAGE_VERSION>/amd64 <CONTAINER_NAME>

::

   (termina) chronos@localhost ~ $ lxc launch images:centos/8/amd64 centos8

-  Enter a container [9]:

::

   (termina) chronos@localhost ~ $ lxc exec <CONTAINER_NAME> /bin/bash
   [root@<CONTAINER_NAME> ~]# cat /etc/os-release

-  The VM can be reset by stopping, deleting, and then starting it again. If the ``termina`` VM does not exist, ``vmc`` will create it. [10]

::

   crosh> vmc stop termina
   crosh> vmc destroy termina
   crosh> vmc start termina

File Sharing
^^^^^^^^^^^^

The ``Files`` app will list ``Linux files``. That will load the visible contents of the ``/home/$USER/`` directory in the container. Directories from the Chrome OS hypervisor, such as ``Downloads``, can also be shared with the container. In the ``Files`` app, right-click on the directory and select ``Share with Linux``. It will be available in the container at ``/mnt/chromeos/MyFiles/``. [2]

GPU Acceleration
^^^^^^^^^^^^^^^^

Crostini supports OpenGL graphics hardware acceleration via the use of `Virgil 3d <https://virgil3d.github.io/>`__. This allows the passthrough of OpenGL calls from the virtual machine ``termina`` to the host system. Vulkan passthrough support is planned to be fully supported in 2021. [11] For gaming, it is recommended to enable these flags:

-  chrome://flags#crostini-gpu-support = Enable Virgil 3d support. It is enabled by default as of Chrome OS 80 [12].
-  chrome://flags#scheduler-configuration = Enable hyper-threading on Chrome OS (if available on the processor). This will help improve the performance of games by allowing the virtual machine to use more processing power.
-  chrome://flags#exo-pointer-lock = Lock the mouse pointer to any application running in Crostini. Games that use the mouse for movement require this.

Verify that the processor count has doubled.

::

   user@penguin:~$ grep -c ^processor /proc/cpuinfo
   4

Verify that Virgil 3d is being recognized by OpenGL.

::

   user@penguin:~$ sudo apt-get install mesa-utils
   user@penguin:~$ glxinfo | grep "OpenGL renderer"
   OpenGL renderer string: virgl

Steam
'''''

Steam requires a handful of dependencies. Enable the proprietary repository to install Steam, enable 32-bit packages, and install recommended dependencies for Wine. These will be required to run native Linux games or Windows games running with Proton (Valve's forked version of Wine) [13].

::

   user@penguin~$ sudo nano /etc/apt/sources.list.d/non-free.list
   deb http://deb.debian.org/debian buster main contrib non-free
   deb http://security.debian.org/ buster/updates main contrib non-free
   user@penguin~$ sudo dpkg --add-architecture i386
   user@penguin~$ sudo apt-get update
   user@penguin~$ sudo apt-get install --install-recommends wine
   user@penguin~$ sudo apt-get install libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libglapi-mesa:i386 steam

Proton uses DXVK to translate DirectX 9, 10, and 11 to Vulkan. Because there is currently no Vulkan hardware acceleration, start Steam and have it use the WineD3D translation layer for DirectX 9, 10, 11 to OpenGL.

::

   user@penguin:~$ PROTON_USE_WINED3D=1 steam

Change the Default Operating System
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The default Linux container ``penguin`` can be changed to use a different operating system other than Debian. The container requires `cros-container-guest-tools <https://chromium.googlesource.com/chromiumos/containers/cros-container-guest-tools/>`__ which provides a set of tools and services for Crostini integration. Wayland is optionally required to run graphical applications.

**All**

Stop and rename the original container.

::

   crosh> vsh termina
   (termina) chronos@localhost ~ $ lxc stop penguin
   (termina) chronos@localhost ~ $ lxc rename penguin penguin-original
   (termina) chronos@localhost ~ $ lxc launch images:<IMAGE_NAME>/<IMAGE_VERSION> penguin

Create a user and related group with the UID and GID of 1000. The name can be anything. Typically this is named using the same username as the Chrome OS user (which is the first part of the e-mail address used to log in: ``<CHROME_OS_USER>@gmail.com``). This user should have privileged access via the use of ``sudo``.

::

   (termina) chronos@localhost ~ $ lxc exec penguin /bin/bash
   [root@penguin ~]# useradd --create-home <CHROME_OS_USER>
   [root@penguin ~]# mkdir /etc/sudoers.d/
   [root@penguin ~]# echo '<CHROME_OS_USER> ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/<CHROME_OS_USER>
   [root@penguin ~]# chmod 0440 /etc/sudoers.d/<CHROME_OS_USER>

For the extra functionality of being able to console into a LXC container from the virtual machine, set a password for the account.

::

   [root@penguin ~]# passwd <CHROME_OS_USER>

**archlinux/current**

First enable the `32-bit multilib libraries <https://wiki.archlinux.org/title/official_repositories#Enabling_multilib>`__ and install a package manager such as `yay <https://github.com/Jguer/yay>`__. This is required to install packages from the Arch Linux User Repository (AUR).

::

   [root@penguin ~]# pacman -S sudo wayland xorg-xwayland
   [root@penguin ~]# pacman -S base-devel git
   [root@penguin ~]# su - <CHROME_OS_USER>
   [<CHROME_OS_USER>@penguin ~]$ yay -S cros-container-guest-tools-git
   [<CHROME_OS_USER>@penguin ~]$ cp -r /etc/skel/.config/pulse ~/.config

[16]

**centos/8**

::

   [root@penguin ~]# dnf install epel-release sudo xorg-x11-server-Xwayland
   [root@penguin ~]# dnf install cros-guest-tools --enablerepo=epel-testing

[17]

**fedora/31**

::

   [root@penguin ~]# dnf install sudo xorg-x11-server-Xwayland
   [root@penguin ~]# dnf install cros-guest-tools sudo --enablerepo=updates-testing

[18]

**All**

Restart the virtual machine (optionally with GPU acceleration enabled).

::

   crosh> vmc stop termina
   crosh> vmc start --enable-gpu --enable-vulkan termina

If using a different container that is not replacing ``penguin``, console into it to be able to use systemd. Log in as the user account. Press ``CTRL`` + ``a`` then ``q`` to exit the console session.

::

   crosh> vsh termina
   (termina) chronos@localhost ~ $ lxc console <CONTAINER_NAME>

Enable the required services and then restart the virtual machine to load the new ``penguin`` container integration.

::

   [root@penguin ~]# systemctl enable --now cros-sftp
   [root@penguin ~]# su - <CHROME_OS_USER>
   [<CHROME_OS_USER>@penguin ~]$ systemctl --user enable sommelier@0 sommelier-x@0 sommelier@1 sommelier-x@1 cros-garcon

Set the display. Use ``:0`` for the native resolution or ``:1`` for a scaled resolution. These are handled by the ``sommelier`` services.

::

   [<CHROME_OS_USER>@penguin ~]$ export DISPLAY=:0
   [<CHROME_OS_USER>@penguin ~]$ echo "DISPLAY=:0" | sudo tee -a /etc/environment

Vulkan Support
''''''''''''''

Vulkan passthrough support requires at least Chrome OS 92. For the best results, use the latest version from the Developer update channel. This currently only works using the latest open source Mesa graphics library. Arch Linux is the easiest Linux distribution for installing the latest source code.

-  Install the latest builds of both the 64-bit and 32-bit variants of Mesa from the Arch Linux User Repository (AUR). This will download and compile them with the required ``virtio-experimental`` Vulkan driver.

   ::

      [<CHROME_OS_USER>@penguin ~]$ yay -S mesa-git lib32-mesa-git

-  Enable Vulkan passthrough by using the VirtIO-GPU Venus driver. The first command enables it temporarily. The next command enables it permanently.

   ::

      [<CHROME_OS_USER>@penguin ~]$ export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/virtio_icd.i686.json:/usr/share/vulkan/icd.d/virtio_icd.x86_64.json
      [<CHROME_OS_USER>@penguin ~]$ echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/virtio_icd.i686.json:/usr/share/vulkan/icd.d/virtio_icd.x86_64.json' | sudo tee -a /etc/environment

-  Verify that Vulkan works by checking that the Venus driver is being used and that a basic 3D cube can be rendered.

   ::

      [<CHROME_OS_USER>@penguin ~]$ sudo pacman -S vulkan-tools
      [<CHROME_OS_USER>@penguin ~]$ vulkaninfo | grep driverName
              driverName         = venus
        driverName                                           = venus
      [<CHROME_OS_USER>@penguin ~]$ vkcube

[38]

Nested Virtualization
^^^^^^^^^^^^^^^^^^^^^

As of Chrome OS 81, nested virtualization is supported in Crostini. This means that KVM accelerated QEMU virtual machines can be created. [21]

Verify that the ``termina`` virtual machine supports nested virtualization.

.. code-block:: sh

   [<CHROME_OS_USER>@penguin ~]$ cat /sys/module/kvm_intel/parameters/nested
   Y

Install the ``virt-manager`` GUI application:

.. code-block:: sh

   [<CHROME_OS_USER>@penguin ~]$ apt-get install virt-manager

The local user needs to be in the ``libvirt`` group to be able to access and manage system level virtual machines. By default, ``virt-manager`` connections through ``qemu:///system`` to provide the best performance.

.. code-block:: sh

   [<CHROME_OS_USER>@penguin ~]$ sudo usermod -a -G libvirt $(whoami)

Launch the program and then create virtual machines.

.. code-block:: sh

   [<CHROME_OS_USER>@penguin ~]$ virt-manager

Virtual Machine External Storage
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Untrusted virtual machines (only available in Developer Mode) can use external storage devices. [23]

View the available devices that can be used for external storage. These are the same that will appear in the ``Files`` app.

.. code-block:: sh

   chronos@localhost / $ ls -1 /media/removable/

Create a new data image for the virtual machine.

.. code-block:: sh

   crosh> vmc create-extra-disk --size=<SIZE>G --removable-media "USB Drive/<IMAGE_NAME>.img"

Start the Crostini virtual machine with the new data image. It will be available within the virtual machine as a Btrfs file system mounted at ``/mnt/external/0/``.

.. code-block:: sh

   crosh> vmc start --untrusted --extra-disk "/media/removable/USB Drive/<IMAGE_NAME>.img termina"

Crouton
~~~~~~~

Crouton allows installing Debian based operating systems into a chroot directory. It supports better integration with Chrome OS via the `crouton integration extension <https://chrome.google.com/webstore/detail/crouton-integration/gcpneefbbnfalgjniomfjknbcgkbijom>`__.

Advantages of Crouton over Crostini:

-  Complete OpenGL and Vulkan hardware-accelerated support.

    -  Virgil, used by Crostini for OpenGL acceleration, is `limited to OpenGL 4.3 <https://lwn.net/Articles/767970/>`__ and older versions. OpenGL 4.6 is the current latest version. Virgil also lacks Vulkan support.

-  Lower disk space usage.
-  No virtualization overhead.
-  Optional installation to an external storage device.
-  Chroot Linux installations can be encrypted.
-  Support for all processor architectures. Crostini only works on 64-bit Chrome OS devices.

Cons:

-  Insecure compared to Crostini. Resources are not isolated from the Chrome OS operating system.
-  Requires ``Developer Mode`` to be enabled.
-  Installs an old operating system by default (Ubuntu 16.04).

Download and install the ``crouton`` script to a location found in ``$PATH``. Alternatively, it can be executed from any user directory.

::

   crosh> shell
   chronos@localhost / $ cd ~/Downloads/
   chronos@localhost ~/Downloads $ wget https://goo.gl/fd3zc -O crouton
   chronos@localhost ~/Downloads $ sudo install -Dt /usr/local/bin -m 755 ~/Downloads/crouton

Chroot Management
^^^^^^^^^^^^^^^^^

Supported configurations:

-  Desktop environments:

   -  gnome
   -  kde
   -  lxde
   -  unity
   -  xfce

-  Operating systems:

   -  Debian
   -  Kali Linux
   -  Ubuntu

View available operating system versions that can be installed along with the types of packages than can be automatically configured. By default, Ubuntu 16.04 is installed with the XFCE desktop environment.

::

   chronos@localhost / $ crouton -r list
   chronos@localhost / $ crouton -t list

Example of creating a minimal chroot.

::

   chronos@localhost / $ sudo crouton -t core

Example of installing Debian Sid, with common features enabled, encrypting the chroot, and naming the chroot "debian_sid_crouton".

::

   chronos@localhost / $ sudo crouton -r sid -t core,audio,touch,keyboard,extension,xorg,xfce -e -n debian_sid_crouton

[20]

Features
--------

Chrome OS versions:

-  91

   -  `Linux has been promoted to stable is no longer considered a beta. <https://chromeunboxed.com/linux-leaving-beta-in-next-chrome-os-update-and-thats-a-big-deal/>`__

-  89

   -  `"Phone Hub" provides tight integration between an Android device and a Chromebook. <https://chromeunboxed.com/chrome-os-89-arrives-10th-birthday-new-features#screen-capture>`__
   -  `"Screen capture" is a new app added to the settings menu that allows taking screenshots and screen recordings natively. <https://chromeunboxed.com/chrome-os-89-arrives-10th-birthday-new-features#screen-capture>`__
   -  `"Trash" in the Files app for recovering deleted files. <https://www.aboutchromebooks.com/news/chrome-os-89-adds-media-annotations-photo-filters-and-a-working-trash-can-for-chromebooks/>`__

-  88

   -  `Crostini on removable storage devices. <https://bugs.chromium.org/p/chromium/issues/detail?id=827705>`__

-  87

   -  `The PDF viewer has been completely redesigned with more features. <https://www.androidpolice.com/2020/11/18/chrome-87/>`__

-  86

   -  `HDR photo and video playback support. <https://www.aboutchromebooks.com/news/chrome-os-86-stable-channel-arrives-on-chromebooks-what-you-need-to-know/>`__

-  85

   -  `Windows virtual machine integration provided by Parallels. <https://www.parallels.com/products/desktop/chrome/>`__

-  84

   -  `Port forwarding to access network ports in Crostini from Chrome OS. <https://chromeos.dev/en/web-environment/port-forwarding>`__

-  81

   -  `Nested virtualization support inside of Crostini. <https://bugs.chromium.org/p/chromium/issues/detail?id=993253>`__

-  76

   -  `OpenGL passthrough to Crostini via Virgl. <https://www.xda-developers.com/chrome-os-76-gpu-support-linux-apps/>`__

-  75

   - `USB device passthrough of any device to Crostini. <https://www.aboutchromebooks.com/news/chrome-os-75-adds-usb-device-adb-android-support-linux-project-crostini/>`__

-  73

   -  `Initial USB device passthrough of select supported devices to Crostini. <https://www.aboutchromebooks.com/news/chrome-os-73-dev-channel-adds-google-drive-play-files-mount-in-linux-usb-device-management-and-crostini-backup-flag/>`__

-  72

   -  `USB storage passthrough to Crostini. <https://www.aboutchromebooks.com/news/chrome-os-72-dev-channel-usb-sd-card-support-project-crostini-chromebooks-android-9-pie/>`__

-  66

   -  `Linux support via Crostini. <https://www.xda-developers.com/linux-apps-chrome-os-overview-crostini/>`__

-  59

   -  `Native printer support via CUPS. <https://www.engadget.com/2017-06-10-chrome-os-native-print.html>`__

Upcoming Features
-----------------

-  `Official Steam support via a framework called Borealis. It will automatically set up an Ubuntu virtual machine tuned for gaming. <https://chromeunboxed.com/steam-games-chrome-os-chromebooks-web-install-app-manager>`__
-  `Vulkan support in Crostini. <https://bugs.chromium.org/p/chromium/issues/detail?id=996591>`__

Troubleshooting
---------------

Errors
~~~~~~

"**Failed to install DLC: termina-dlc**" when trying to manually start the Termina virtual machine from the CLI.

.. code-block:: sh

   crosh> vmc start termina
   2021-12-20T04:29:10.439301Z ERROR dlcservice_util: [dlc_service_util.cc(212)] Failed to install DLC: termina-dlc with error code: org.chromium.DlcServiceInterface.INTERNAL

Solutions:

1.  Enable the DLC flag for Crostini by going to ``chrome://flags#crostini-use-dlc``. Reboot the Chrome OS device.
2.  Install the Termina DLC.

   .. code-block:: sh

      crosh> shell
      chronos@localhost / $ sudo dlcservice_util --id=termina-dlc --install

3.  Start Termina without the DLC by setting the undocumented argument ``--dlc-id`` to an empty string with the use of double quotes.

   .. code-block:: sh

      crosh> vmc start --dlc-id="" termina

----

"**board overlay not found**" when building Chromium OS.

::

    (cr) ((ca80eae...)) <USER>@<HOSTNAME> ~/chromiumos/src/scripts $ setup_board --board=${BOARD}
    <OMITTED>
      File "/mnt/host/source/chromite/lib/portage_util.py", line 191, in _ListOverlays
        raise MissingOverlayError('board overlay not found: %s' % board)
    chromite.lib.portage_util.MissingOverlayError: board overlay not found: overlay-cuos-amd64
    10:35:56.669: ERROR: Error occurred while updating the chroot. See the logs for more information.

Solution:

-  This happens because every overlay `requires <https://chromium.googlesource.com/chromiumos/chromite/+/main/lib/portage_util.py>`__ a ``metadata/layout.conf`` file (the relevant code is shown below). This can be copied from an existing layout and modified as needed.

   ::

      try:
      --
        | masters = key_value_store.LoadFile(
        | os.path.join(GetOverlayRoot(overlay), 'metadata',
        | 'layout.conf'))['masters'].split()

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/chromium_os.rst>`__
-  `< 2021.07.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/chromebook.rst>`__

Bibliography
------------

1. "Running Custom Containers Under Chrome OS." Chromium OS Docs. Accessed March 2, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/containers_and_vms.md
2. "Issue 878324: Share Downloads with crostini container." Chromium Bugs. May 6, 2019. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=878324
3. "Issue 930901: crostini: support buster as the default container." Chromium Bugs. February 7, 2020. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=930901
4. "Chromebook keyboard shortcuts." Chromebook Help. Accessed March 2, 2020. https://support.google.com/chromebook/answer/183101?hl=en
5. "Developer Mode." Chromium OS Docs. Accessed January 1, 2022. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/developer_guide.md
6. "Turn on debugging features." Chromebook Help. Accessed January 1, 2022. https://support.google.com/chromebook/answer/6204310?hl=en
7. "Debug Button Shortcuts." Chromium OS Docs. Accessed March 4, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/debug_buttons.md
8. "Debugging Features." Chromium OS. Accessed January 1, 2022.. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/debugging-features
9. "LXD Getting started - command line." Linux containers. Accessed March 7, 2020. https://linuxcontainers.org/lxd/getting-started-cli/
10. "Crostini Setup Guide." Reddit r/Crostini. December 27, 2018. Accessed March 7, 2020. https://www.reddit.com/r/Crostini/wiki/getstarted/crostini-setup-guide
11. "Issue 996591: Vulkan does not appear to be working in Crostini." Chromium Bugs. April 10, 2021. Accessed August 17, 2021. https://bugs.chromium.org/p/chromium/issues/detail?id=996591
12. "CHROME OS 80 MAKES GRAPHIC INTENSIVE LINUX APPS SO MUCH BETTER." Chrome Unboxed. March 10, 2020. Accessed March 11, 2020. https://chromeunboxed.com/chrome-os-80-gpu-linux-apps-enabled/
13. "How to install Steam." Reddit r/Crostini. November 2, 2018. Accessed March 11, 2020. https://www.reddit.com/r/Crostini/wiki/howto/install-steam
14. "Auto Update Policy." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chrome/a/answer/6220366?hl=en
15. "Switch between stable, beta & dev software." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chromebook/answer/1086915?hl=en
16. "Chrome OS devices/Crostini." Arch Linux Wiki. December 8, 2021. Accessed December 19, 2021. https://wiki.archlinux.org/index.php/Chrome_OS_devices/Crostini
17. "How to run CentOS instead of Debian." Reddit r/Crostini. October 16, 2019. Accessed March 14, 2020. https://www.reddit.com/r/Crostini/wiki/howto/run-centos-linux
18. "How to run Fedora instead of Debian." Reddit r/Crostini. December 21, 2019. Accessed March 14, 2020. https://www.reddit.com/r/Crostini/wiki/howto/run-fedora-linux
19. "skycocker/chromebrew." GitHub. March 28, 2020. Accessed March 28, 2020. https://github.com/skycocker/chromebrew
20. "dnschneid/crouton." GitHub. January 17, 2020. Accessed March 29, 2020. https://github.com/dnschneid/crouton
21. "Issue 993253: Support untrusted VMs." Chromium Bugs. January 27, 2020. Accessed May 29, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=993253
22. "ChromeOS Firmware Utility Script." MrChromebox.tech. Accessed September 5, 2020. https://mrchromebox.tech/#fwscript
23. "service.cc" vm_tools - chromiumos/platform2 - Git at Google. November 14, 2020. Accessed December 5, 2020. https://chromium.googlesource.com/chromiumos/platform2/+/master/vm_tools/concierge/service.cc
24. "How to Enable USB Booting on Chromebook." wikiHow. November 30, 2020. Accessed February 25, 2021. https://www.wikihow.com/Enable-USB-Booting-on-Chromebook
25. "Remove RootFS Verification & make Read/Write." Cr-48ite. January 4, 2012. Accessed February 28, 2021. https://sites.google.com/site/cr48ite/getting-technical/remove-rootfs-verification-make-read-write
26. "Chromebook writable root." Way of the nix's - Computer Security & Full Stack Development. Accessed February 28, 2021. https://xn--1ca.se/chromebook-writable-root/
27. "Build chrome os kernel and kernel modules." GitHub dnschneid/crouton. March 22, 2018. Accessed March 15, 2021. https://github.com/dnschneid/crouton/wiki/Build-chrome-os-kernel-and-kernel-modules
28. "Custom Kernel Modules for Chromebook." The Critically Cognitive. April 17, 2017. Accessed March 15, 2021. https://criticallycognitive.wordpress.com/2017/04/16/custom-kernel-modules-for-chromebook/
29. "Dev-Install: Installing Developer and Test packages onto a Chrome OS device." Chromium OS How Tos and Troubleshooting. Accessed March 16, 2021. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/install-software-on-base-images
30. "Chrome Release Cycle." chromium - Git at Google. Accessed June 20, 2021. https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/process/release_cycle_new.md
31. "Chromium OS Developer Guide." Chromium OS Docs. Accessed June 20, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/developer_guide.md
32. "Chromium OS Board Porting Guide." Chromium OS How Tos and Troubleshooting. Accessed June 20, 2021. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/chromiumos-board-porting-guide
33. "Cros Flash." Chromium OS Docs. Accessed June 20, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/cros_flash.md
34. "Kernel Development." Chromium OS Docs. Accessed June 25, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development.md
35. "Brunch framework." GitHub sebanc/brunch. June 20, 2021. Accessed July 8, 2021. https://github.com/sebanc/brunch
36. "Version Numbers." The Chromium Projects. Accessed July 8, 2021. https://www.chromium.org/developers/version-numbers
37. "Brunch framework." GitHub sebanc/brunch. June 20, 2021. Accessed July 28, 2021. https://github.com/sebanc/brunch
38. "Virtio-GPU Venus." The Mesa 3D Graphics Library latest documentation. Accessed August 17, 2021. https://docs.mesa3d.org/drivers/venus.html
39. "Reset your Chromebook to factory settings." Chromebook Help. Accessed December 30, 2021. https://support.google.com/chromebook/answer/183084?hl=en
40. "Recover your Chromebook." Chromebook Help. Accessed December 30, 2021. https://support.google.com/chromebook/answer/1080595
41. "SELinux in Chrome OS." Chromium OS Docs. Accessed December 31, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/security/selinux.md
42. "Basic Usage." Book of crosvm. Accessed January 15, 2022. https://google.github.io/crosvm/running_crosvm/basic_usage.html
43. "Example Usage (Outdated)." Book of crosvm. Accessed January 19, 2022. https://google.github.io/crosvm/appendix/example_usage.html
44. "crosvm - The Chrome OS Virtual Machine Monitor." chromiumos/platform/crosvm - Git at Google. January 13, 2022. Accessed January 15, 2022. https://chromium.googlesource.com/chromiumos/platform/crosvm/
45. "System Requirements." Book of crosvm. Accessed January 19, 2022. https://google.github.io/crosvm/running_crosvm/requirements.html
46. "Can't enable debugging features in Developer Mode (No Link)." Chromebook Help. May 12, 2021. Accessed January 1, 2022. https://support.google.com/chromebook/thread/109479412/can-t-enable-debugging-features-in-developer-mode-no-link?hl=en
