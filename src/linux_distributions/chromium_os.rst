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

Developer Mode
--------------

Chromebooks have an optional developer mode that unlocks additional features of Chrome OS. It allows the usage of a shell, ``root`` user access, and the ability to install and boot custom operating systems. [5]

Enabling this mode will powerwash (reset) the device. Start the Chromebook in Recovery mode by pressing ``ESC`` + ``<REFRESH>`` + ``<POWER>``. Once booted, press ``CTRL`` + ``d`` to boot into developer mode. Optionally select to enable debugging features to allow writing to the root file system, booting to external storage devices, and changing the root password. [6][8] After completion, whenever booting up the Chromebook, use ``CTRL`` + ``d`` to boot Chrome OS.

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

When booting a Chromebook in developer mode, there are a few options to choose from. By default, a screen will appear for 30 seconds saying ``OS verification is OFF``. It will beep and continue to boot into local storage if no boot option is specified via keyboard shortcuts. Pressing the ``<SPACE>`` bar will powerwash the Chromebook.

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

Open a full shell terminal in developer mode to access more commands.

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

Channels can be changed on any Chromebook not in developer mode by going to ``Settings > About Chrome OS > Additional Details > Channel > Change channel`` and selecting ``Stable``, ``Beta``, or ``Developer - unstable``. However, this will require a Powerwash which will factory reset the Chromebook and does not expose the ``Canary`` channel.

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

Finding the Release Branch Name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, ``repo init`` will set git repositories to pull from the ``main`` branch. This may not be desired if the goal is to build a specific version of Chromium OS packages.

On the Chromebook, take note of the major "Google Chrome:" version and the major "Platform:" version in ``chrome://version``.

::

   Google Chrome: 91.0.4472.102 (Official Build) (64-bit)
   Platform: 13904.55.0 (Official Build) stable-channel samus

Do a search for the branch that relates to the versions.

.. code-block:: sh

   $ cros_sdk
   (cr) ((<COMMIT>...)) <USER>@<HOTSNAME> ~/trunk/src/scripts $ git branch -a | grep release-R91
     remotes/cros/release-R91-13904.B

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

Install base system packages into a new chroot created at ``/boot/${BOARD}``. Everytime this command is ran it also runs ``update_chroot`` to ensure it has the latest updates. Optionally add the ``--force`` argument to delete and recreate the chroot for the board.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ setup_board --board=${BOARD}

Configure the password for the ``chronos`` user.

.. code-block:: sh

   (cr) ((<COMMIT>...)) <USER>@<HOSTNAME> ~/trunk/src/scripts $ ./set_shared_user_password.sh
   Enter password for shared user account: Password set in /etc/shared_user_passwd.txt

Install all the packages. Similar to the ``setup_board`` command, everytime this command is ran it also runs ``update_chroot`` to ensure it has the latest updates. Specify the ``--nowithdebug`` argument to not compile packages with debug mode enabled. The configuration for Portage/emerge that is used is saved to the file ``../../chroot/build/${BOARD}/packages/Packages``.

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

         USE="${USE} kvm_host crosvm-gpu virtio_gpu"

   -  Enable Borealis (Steam).

      ::

         USE="${USE} has-borealis vm_borealis <BOARD>-borealis"

   -  Enable crosvm Vulkan pass-through support (not currently working).

      ::

         USE="${USE} crosvm_virtio_video crosvm_wl_dmabuf vulkan"

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

Linux Kernel Modules
~~~~~~~~~~~~~~~~~~~~

Building
^^^^^^^^

The kernel and/or modules can be compiled regardless of the CPU architecture required.

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

Installing
^^^^^^^^^^

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

Linux
-----

Crostini
~~~~~~~~

Crostini is an official set of technologies used to securely run Linux on Chrome OS in an isolated environment. It creates a minimal Chrome OS virtual machine (VM) called ``termina`` that then starts a LXC container named ``penguin``.  By default, the ``penguin`` container uses Debian 10 Buster as of Chrome OS 80. [3] It does not require developer mode.

Enable it by going into Chrome OS settings and selecting ``Linux (Beta)``. [1] A new ``Terminal`` app will appear to access the terminal of the container. Alternatively, the Chrome web browser can be used to access the terminal by going to ``chrome-untrusted://terminal/html/terminal.html``.

Container Management
^^^^^^^^^^^^^^^^^^^^

With developer mode enabled, the ``termina`` VM can be manually edited with the ``vmc`` command. It can enable GPU acceleration, enable audio capture, export/save the VM, share files, and attach USB devices. New containers can also be created.

-  Manually start and connect to the ``termina`` VM.

::

   crosh> vmc start termina
   (termina) chronos@localhost ~ $

-  Manually connect to an already running ``termina`` VM.

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

Crostini supports OpenGL graphics hardware acceleration via the use of `Virgil 3d <https://virgil3d.github.io/>`__. This allows the passthrough of OpenGL calls from the virtual machine ``termina`` to the host system. Vulkan passthrough support is planned to be released in 2020. [11] For gaming, it is recommended to enable these flags:

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

Create a user using the same username as the Chrome OS user (which is normally the first part of the e-mail address used to log in: ``<CHROME_OS_USER>@gmail.com``). This user should have privileged access via the use of ``sudo``.

::

   (termina) chronos@localhost ~ $ lxc exec penguin /bin/bash
   [root@penguin ~]# useradd <CHROME_OS_USER>
   [root@penguin ~]# mkdir /etc/sudoers.d/
   [root@penguin ~]# echo '<CHROME_OS_USER> ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/<CHROME_OS_USER>
   [root@penguin ~]# chmod 0440 /etc/sudoers.d/<CHROME_OS_USER>

**archlinux/current**

First install a package manager such as `yay <https://github.com/Jguer/yay>`__. This is required to install packages from the Arch Linux User Repository (AUR).

::

   [root@penguin ~]# yay -S cros-container-guest-tools-git
   [root@penguin ~]# pacman -S sudo wayland xorg-server-xwayland

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

Enable the required services and then restart the virtual machine to load the new ``penguin`` container integration.

::

   [root@penguin ~]# systemctl enable cros-sftp
   [root@penguin ~]# su - <CHROME_OS_USER>
   [<CHROME_OS_USER>@penguin ~]$ systemctl --user enable sommelier@0 sommelier-x@0 sommlier@1 sommelier-x@1 cros-garcon cros-pulse-config

::

   crosh> vmc stop termina
   crosh> vmc start termina

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

Untrusted virtual machines (only available in developer mode) can use external storage devices. [23]

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

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/linux_distributions/chromium_os.rst>`__
-  `< 2021.07.01 <https://github.com/ekultails/rootpages/commits/master/src/administration/chromebook.rst>`__

Bibliography
------------

1. "Running Custom Containers Under Chrome OS." Chromium OS Docs. Accessed March 2, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/containers_and_vms.md
2. "Issue 878324: Share Downloads with crostini container." Chromium Bugs. May 6, 2019. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=878324
3. "Issue 930901: crostini: support buster as the default container." Chromium Bugs. February 7, 2020. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=930901
4. "Chromebook keyboard shortcuts." Chromebook Help. Accessed March 2, 2020. https://support.google.com/chromebook/answer/183101?hl=en
5. "Developer Mode." Chromium OS Docs. Accessed March 4, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/developer_mode.md
6. "Turn on debugging features." Chromebook Help. Accessed March 4, 2020. https://support.google.com/chromebook/answer/6204310?hl=en
7. "Debug Button Shortcuts." Chromium OS Docs. Accessed March 4, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/debug_buttons.md
8. "Debugging Features." Chromium OS. Accessed March 4, 2020. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/debugging-features
9. "LXD Getting started - command line." Linux containers. Accessed March 7, 2020. https://linuxcontainers.org/lxd/getting-started-cli/
10. "Crostini Setup Guide." Reddit r/Crostini. December 27, 2018. Accessed March 7, 2020. https://www.reddit.com/r/Crostini/wiki/getstarted/crostini-setup-guide
11. "Issue 996591: Vulkan does not appear to be working in Crostini." Chromium Bugs. February 12, 2020. Accessed March 11, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=996591
12. "CHROME OS 80 MAKES GRAPHIC INTENSIVE LINUX APPS SO MUCH BETTER." Chrome Unboxed. March 10, 2020. Accessed March 11, 2020. https://chromeunboxed.com/chrome-os-80-gpu-linux-apps-enabled/
13. "How to install Steam." Reddit r/Crostini. November 2, 2018. Accessed March 11, 2020. https://www.reddit.com/r/Crostini/wiki/howto/install-steam
14. "Auto Update Policy." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chrome/a/answer/6220366?hl=en
15. "Switch between stable, beta & dev software." Google Chrome Enterprise Help. Accessed March 13, 2020. https://support.google.com/chromebook/answer/1086915?hl=en
16. "Chrome OS devices/Crostini." Arch Linux Wiki. February 17, 2020. Accessed March 14, 2020. https://wiki.archlinux.org/index.php/Chrome_OS_devices/Crostini
17. "How to run CentOS instead of Debian." Reddit r/Crostini. October 16, 2019. Accessed March 14, 2020. https://www.reddit.com/r/Crostini/wiki/howto/run-centos-linux
18. "How to run Fedora instead of Debian." Reddit r/Crostini. December 21, 2019. Accessed March 14, 2020. https://www.reddit.com/r/Crostini/wiki/howto/run-fedora-linux
19. "skycocker/chromebrew." GitHub. March 28, 2020. Accessed March 28, 2020. https://github.com/skycocker/chromebrew
20. "dnschneid/crouton." GitHub. January 17, 2020. Accessed March 29, 2020. https://github.com/dnschneid/crouton
21. "Issue 993253: Support untrusted VMs." Chromium Bugs. January 27, 2020. Accessed May 29, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=993253
22. "ChromeOS Firmware Utility Script." MrChromebox.tech. Accessed September 5, 2020. https://mrchromebox.tech/#fwscript
23. "service.cc" vm_tools - chromiumos/platform2 - Git at Google. November 14, 2020. Accessed December 5, 2020. https://chromium.googlesource.com/chromiumos/platform2/+/master/vm_tools/concierge/service.cc
24. "How to Enable USB Booting on Chromebook." wikiHow. November 30, 2020. Accessed February 25, 2021. https://www.wikihow.com/Enable-USB-Booting-on-Chromebook
25. "Remove RootFS Verification & make Read/Write." Cr-48ite. January 4, 2012. Accessed Feburary 28, 2021. https://sites.google.com/site/cr48ite/getting-technical/remove-rootfs-verification-make-read-write
26. "Chromebook writable root." Way of the nix's - Computer Security & Full Stack Development. Accessed February 28, 2021. https://xn--1ca.se/chromebook-writable-root/
27. "Build chrome os kernel and kernel modules." GitHub dnschneid/crouton. March 22, 2018. Accessed March 15, 2021. https://github.com/dnschneid/crouton/wiki/Build-chrome-os-kernel-and-kernel-modules
28. "Custom Kernel Modules for Chromebook." The Critically Cognitive. April 17, 2017. Accessed March 15, 2021. https://criticallycognitive.wordpress.com/2017/04/16/custom-kernel-modules-for-chromebook/
29. "Dev-Install: Installing Developer and Test packages onto a Chrome OS device." Chromium OS How Tos and Troubleshooting. Accessed March 16, 2021. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/install-software-on-base-images
30. "Chrome Release Cycle." chromium - Git at Google. Accessed June 20, 2021. https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/process/release_cycle_new.md
31. "Chromium OS Developer Guide." Chromium OS Docs. Accessed June 20, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/developer_guide.md
32. "Chromium OS Board Porting Guide." Chromium OS How Tos and Troubleshooting. Accessed June 20, 2021. https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/chromiumos-board-porting-guide
33. "Cros Flash." Chromium OS Docs. Accessed June 20, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/cros_flash.md
34. "Kernel Development." Chromium OS Docs. Accessed June 25, 2021. https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development.md
