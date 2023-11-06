SteamOS 3
=========

.. contents:: Table of Contents

Game Mode
---------

Introduction
~~~~~~~~~~~~

Game Mode is the name of the default mode that Steam OS and the Steam Deck boots into. It is limited to only accessing games from the Steam library. This is not to be confused with Feral Interactive's `GameMode <https://github.com/FeralInteractive/gamemode>`__.

Supported Controllers
~~~~~~~~~~~~~~~~~~~~~

These are controllers that are officially supported on SteamOS [4][5]:

-  Nintendo Joy-Con controllers
-  Nintendo Online classic controllers
-  PlayStation Dualshock 4
-  PlayStation Dualsense 5
-  Steam Controller
-  Xbox 360 controller
-  Xbox One controller
-  Xbox Series controller
-  DirectInput controllers
-  Generic XInput controllers

Decky Loader
~~~~~~~~~~~~

Introduction
^^^^^^^^^^^^

Decky Loader provides a standardized way to install and launch plugins for the Steam Deck in Game Mode.

Installation:

-  `Enable and enter Destkop Mode <#enable-desktop-mode>`__.
-  `Configure a user password to be able to use "sudo" commands <#default-user-account>`__.
-  `Download <https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/decky_installer.desktop>`__ the Decky Loader desktop shortcut for the installer.

   -  Ensure that the file extension is ``.desktop``.

-  Use the "Dolphin" file manager to move the file from the Downloads folder to the Desktop folder.
-  Double-click on the "decky_installer.desktop" file to execute it.
-  Enter the "sudo" password when prompted.

Usage:

-  `Return to Game Mode <#enable-desktop-mode>`__.
-  ... (also known as the Quick Access Menu [QAM]) > (move down to the bottom and select the new power plug icon) > (move to the right and select the shop icon to install plugins)

[12][13]

AutoFlatpaks
^^^^^^^^^^^^

This plugin can update all or specific Flatpaks. It can also uninstall Flatpaks. By default, updates are manual. Automatic updates can be scheduled to run on a specific interval of days, hours, and/or minutes. [16]

Enable automatic updates:

-  SETTINGS > Unattended Upgrades: Yes

Disable notifications:

-  NOTIFICATIONS

   -  Toast: No
   -  Sound: No

DeckMTP
^^^^^^^

Media Transfer Protocol (MTP) is typically used to connect an Android phone to a PC via a USB cable to manage the storage. [14] DeckMTP provides a way to allow a USB-C cable to plug into a Steam Deck and a PC to transfer files. This feature requires turning on Dual-Role Device (DRD) support in the BIOS.

Known issues when DRD is enabled [15]:

-  USB boot does not work.
-  USB support in Windows (if installed on the Steam Deck) does not work.

Enabling DRD:

-  Boot the Steam Deck by holding the "volume up" button and the "power" button.
-  After hearing the beep, release the "power" button (but keep holding "volume up"). Eventually, the BIOS will appear.
-  Setup Utility > Advanced > USB Configuration > USB Dual Role Device: DRD

   -  By default, this is set to "XHCI".

-  Exit > Exit Saving Changes > Yes

DeckMTP is disabled by default. Open the plugin to enable it.

Desktop Mode
------------

Enable Developer Mode
~~~~~~~~~~~~~~~~~~~~~

Developer Mode adds a "Developer" tab to Settings. Here, game developers can enable the SteamOS Devkit Service to pair with a PC that is running the SteamOS Devkit Client Tool. Games can easily be transferred over to the Steam Deck with optional settings to profile CPU and GPU performance of those games. [17]

Developer Mode is not required to access the desktop or to modify the file system. [18]

Enable Developer Mode:

-  STEAM > Settings > System > SYSTEM SETTINGS > Enable Developer Mode: Yes

Enter Desktop Mode
~~~~~~~~~~~~~~~~~~

Enter Desktop Mode using one of these two methods:

-  STEAM > Power > Switch to Desktop
-  (Hold the power button for 2 seconds) > Switch to Desktop

Leave Desktop Mode and return to Game Mode using one of these two methods:

-  Double-click on the "Steam Deck" desktop shortcut.
-  Start Menu > (select the left arrow to the right of the "Shut Down" button) > Log Out > OK

Permanently boot into Desktop Mode by default:

-  Xorg (recommended):

   .. code-block:: sh

      $ steamos-session-select plasma-x11-persistent

-  Wayland (not recommended):

   .. code-block:: sh

      $ steamos-session-select plasma-wayland-persistent

Restore the default of booting into Game Mode by default [23]:

.. code-block:: sh

   $ steamos-session-select gamescope

Default User Account
~~~~~~~~~~~~~~~~~~~~

By default, on the Steam Deck, the user and group ``deck`` (UID and GID ``1000``) is used. It is also part of the ``wheel`` group (GID ``998``) which provides it access to running commands as the ``root`` user with the ``sudo`` command.

There is no password by default. For running ``sudo`` commands, a password needs to be set.

-  GUI: System Settings > Personalization > Users > Your Account > Steam Deck User > Change Password
-  CLI:

   .. code-block:: sh

      $ passwd

Move Shader Cache
~~~~~~~~~~~~~~~~~

The Steam client will automatically download shader cache for each game. This will include (1) Vulkan shader cache and (2) converted multimedia formats. This cache takes up a lot of space and can be an issue for the 64 GB model of the Steam Deck as it is only stored on the internal drive. As a workaround, the shader cache can be moved to a microSD card. [21]

Automatically:

-  `Install and open CryoUtilities <#increase-swap-size-and-vram>`__.
-  Storage > Sync Game Data > Sync > Submit > Confirm > OK

This moves the shader cache of games on the microSD card to ``/run/media/mmcblk0p1/cryoutilities_steam_data/shadercache/`` by creating a symlink for each game.

Manually:

-  Close and exit the Steam client completely to ensure it is not creating or downloading shader cache.
-  Create a shader cache directory on the microSD card.

   .. code-block:: sh

      $ mkdir /run/media/mmcblk0p1/steamapps/shadercache/

-  Move the shader cache from the internal drive to the microSD card. This can take a long time.

   .. code-block:: sh

      $ mv /home/deck/.steam/steam/steamapps/shadercache/* /run/media/mmcblk0p1/steamapps/shadercache/

-  Delete the shader cache folder on the internal drive.

   .. code-block:: sh

      $ rm -r -f /home/deck/.steam/steam/steamapps/shadercache

-  Create a symlink to the microSD card.

   .. code-block:: sh

      $ ln -s /run/media/mmcblk0p1/steamapps/shadercache /home/deck/.steam/steam/steamapps/shadercache

Transfer Files with SFTP
~~~~~~~~~~~~~~~~~~~~~~~~

SFTP provides FTP over the SSH protocol. This can be used to move files to and from the Steam Deck.

-  Ensure that a password has been set for the ``deck`` user.

   .. code-block:: sh

      $ passwd

-  Enable the SSH daemon.

   .. code-block:: sh

      $ sudo systemctl enable --now sshd

-  Find the current IP address.

   .. code-block:: sh

      $ ip address

-  Use an SFTP client, such as FileZilla, from a different computer to connect to the Steam Deck.

   -  Host: <STEAM_DECK_IP_ADDRESS>
   -  Username: deck
   -  Port: 22

[1]

Remote Desktop
~~~~~~~~~~~~~~

Users can share their SteamOS screen for collaborating and/or troubleshooting. This requires being in `Desktop Mode <#enable-desktop-mode>`__.

Solutions that work on SteamOS:

-  `AnyDesk <../graphics/desktop.html#anydesk>`__ = The most reliable solution.
-  Steam Remote Play [11] = This can be buggy. Requires minimizing the selected program once a Remote Play connection is working.

   -  Games > Add a Non-Steam Game to My Library... > Konsole > Add Selected Programs

Solutions that do NOT work on SteamOS:

-  Chrome Remote Desktop = Requires installing and using a DEB package.
-  KDE Remote Desktop Connection (KRDC) = Requires installing and using ``krfb`` on SteamOS. Only works on local networks.

Enable TPM
~~~~~~~~~~

The original Steam Deck BIOS had TPM support disabled. It was eventually enabled to allow Windows 11 to be installed onto the device. [6] However, SteamOS never re-enabled TPM support. Here is how to re-enable it [7]:

-  Edit the GRUB configuration file: ``/etc/default/grub``.
-  Go to the ``GRUB_CMDLINE_LINUX_DEFAULT=`` line and remove ``module_blacklist=tpm``.
-  Update the GRUB boot menu.

   .. code-block:: sh

      $ sudo update-grub

-  Reboot.
-  Verify that TPM is working by seeing if the Linux device files exist.

   .. code-block:: sh

      $ find /dev -name "tmp*"
      /dev/tpmrm0
      /dev/tpm0

Disable SteamOS Updates
~~~~~~~~~~~~~~~~~~~~~~~

An upgrade of the SteamOS operating system is only forced during the first-time setup. [22] After that, upgrades can be manually applied by going to: STEAM > Settings > System > Check For Updates. If there is an upgrade availabe, select "Apply" to reboot and install it.

It is possible to force disable SteamOS operating system updates from the Desktop Mode to be extra safe.

-  Disable updates:

   .. code-block:: sh

      $ sudo steamos-readonly disable
      $ sudo systemd-sysext unmerge
      $ sudo chmod -x /usr/bin/steamos-atomupd-client
      $ sudo chmod -x /usr/bin/steamos-atomupd-mkmanifest
      $ sudo chmod -x /usr/bin/steamos-update
      $ sudo chmod -x /usr/bin/steamos-update-os
      $ sudo systemd-sysext merge
      $ sudo steamos-readonly enable

-  Re-enable updates:

   .. code-block:: sh

      $ sudo steamos-readonly disable
      $ sudo systemd-sysext unmerge
      $ sudo chmod +x /usr/bin/steamos-atomupd-client
      $ sudo chmod +x /usr/bin/steamos-atomupd-mkmanifest
      $ sudo chmod +x /usr/bin/steamos-update
      $ sudo chmod +x /usr/bin/steamos-update-os
      $ sudo systemd-sysext merge
      $ sudo steamos-readonly enable

Disable Steam Client Updates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Steam client updates are required and forced. [22] They will not be applied until a user restarts the Steam Deck or manually applies the update in Settings. However, it is possible to disable them.

-  Disable the read-only file system to make it writable.

   .. code-block:: sh

      $ sudo steamos-readonly disable
      $ sudo systemd-sysext unmerge

-  Edit the ``/usr/bin/gamescope-session`` file.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /usr/bin/gamescope-session

   -  Before:

      .. code-block:: sh

         steamargs=("-steamos3" "-steampal" "-steamdeck" "-gamepadui")

   -  After:

      .. code-block:: sh

         steamargs=("-steamos3" "-steampal" "-steamdeck" "-gamepadui" "-noverifyfiles" "-nobootstrapupdate" "-skipinitialbootstrap" "-norepairfiles" "-overridepackageurl")

-  Edit the ``/usr/bin/steam-jupiter`` file.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /usr/bin/steam-jupiter

   -  Before:

      .. code-block:: sh

         exec /usr/lib/steam/steam -steamdeck "$@"

   -  After:

      .. code-block:: sh

         exec /usr/lib/steam/steam -steamdeck -noverifyfiles -nobootstrapupdate -skipinitialbootstrap -norepairfiles -overridepackageurl "$@"

-  Edit the ``/usr/share/applications/steam.desktop`` file.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /usr/share/applications/steam.desktop

   -  Before:

      .. code-block:: ini

         Exec=/usr/bin/steam %U

   -  After:

      .. code-block:: ini

         Exec=/usr/bin/steam -noverifyfiles -nobootstrapupdate -skipinitialbootstrap -norepairfiles -overridepackageurl %U

-  Re-enable the read-only file system:

   .. code-block:: sh

      $ sudo systemd-sysext merge
      $ sudo steamos-readonly enable

Enable the Pacman Package Manager
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pacman can be used to install additional operating system packages. Installed packages will be removed whenever there is an operating system update. [8]

-  Allow the ``/`` and ``/usr/`` directories to be writable.

   .. code-block:: sh

      $ sudo steamos-readonly disable
      $ sudo systemd-sysext unmerge

-  Populate the GPG keys used to verify Pacman packages.

   .. code-block:: sh

      $ sudo pacman-key --init
      $ sudo pacman-key --populate
      $ sudo pacman-key --refresh-keys

-  Pacman can now be used to install packages.

   .. code-block:: sh

      $ sudo pacman -S <PACKAGE>

-  When done, re-enable the read-only file systems. [9][10]

   .. code-block:: sh

      $ sudo systemd-sysext merge
      $ sudo steamos-readonly enable

Steam Deck BIOS
---------------

Boot into External Storage
~~~~~~~~~~~~~~~~~~~~~~~~~~

One time only:

-  Boot the Steam Deck by holding the "volume down" button and the "power" button.
-  After hearing the beep, release the "power" button (but keep holding "volume down"). Eventually, the manual BIOS boot menu will appear.

Always:

-  Boot the Steam Deck by holding the "volume up" button and the "power" button.
-  After hearing the beep, release the "power" button (but keep holding "volume up"). Eventually, the BIOS will appear.
-  Setup Utility > Boot

   -  Add Boot Options: First
   -  USB Boot: Enabled

-  Exit > Exit Saving Changes > Yes

In a situation where a USB-C dock is used that has (1) no USB storage device plugged in and (2) an Ethernet port, it will attempt to do a network PXE boot first before booting into the internal drive. This will take a long time to timeout.

Disable network PXE boot:

-  Boot the Steam Deck by holding the "volume up" button and the "power" button.
-  After hearing the beep, release the "power" button (but keep holding "volume up"). Eventually, the BIOS will appear.
-  Setup Utility > Boot

   -  Network Stack: Disabled

-  Exit > Exit Saving Changes > Yes

Increase Swap Size and VRAM
~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, SteamOS uses a 1 GiB swapfile at ``/home/swapfile``. Combined with the Steam Deck's 16 GB of RAM, it provides a total of 17 GB of temporary storage that is shared between the CPU and iGPU. The swappiness is set to 100% so Linux will always be writing as much temporary storage to the swap file as possible.

.. code-block:: sh

   $ cat /proc/swaps
   Filename				Type		Size		Used		Priority
   /home/swapfile                          file		1048572		0		-2
   $ sysctl --values vm.swappiness
   100

It is recommended to increase the swap size to 16 GB on Steam Deck models that have more than 64 GB of storage. The 256 GB and 512 GB models have more storage and are faster NVMe drives. An increased amount of swap frees up RAM for use as VRAM. Decreasing the swappiness down to 1% will increase the lifespan of the internal storage. These changes can result in up to 24% more FPS in more demanding games.

CryoUtilities provides a streamlined way to increase the swap file size, decrease swappiness, and make other performance improvements.

.. code-block:: sh

   $ cd ~/Downloads/
   $ wget https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/InstallCryoUtilities.desktop
   $ chmod +x InstallCryoUtilities.desktop

Select the "InstallCryoUtilities.desktop" shortcut to install the tools. Configure a 16 GB swap file and set the swappiness to 0.5% (the minimum).


-  GUI:

   -  Double-click on the "CryoUtilities" desktop shortcut to open it.
   -  Swap > Swap File > Resize > 16 > Resize Swap File > OK
   -  Swap > Swappiness > Change > 1 > Change Swappiness > OK

-  CLI:

   .. code-block:: sh

      $ sudo ~/.cryo_utilities/cryo_utilities swap 16
      $ sudo ~/.cryo_utilities/cryo_utilities swappiness 1

Verify that the changes have been made.

.. code-block:: sh

   $ cat /proc/swaps
   Filename				Type		Size		Used		Priority
   /home/swapfile                          file		16777212	0		-2
   $ sysctl --values vm.swappiness
   1

VRAM is the amount of system RAM that is used for the iGPU instead of the CPU. The Steam Deck can use up to 8 GB of RAM as VRAM. In the BIOS, it is possible to set the minimum amount of VRAM the iGPU can use to 4 GB (up from 1 GB).

- Press the "volume up" and "power" buttons to enter the BIOS > Setup Utility > Advanced > UMA Frame buffer Size: 4G > Exit > Exit Saving Changes

Verify that the changes have been made:

.. code-block:: sh

   $ glxinfo | grep -i "dedicated video memory:"
      Dedicated video memory: 4096 MB

[2][3]

Undervolting
~~~~~~~~~~~~

As of SteamOS 3.5 and BIOS version 118, the Steam Deck officially supports undervolting. [19] This can be used to improve battery life or to help out with overclocking.

Adjust the voltage in increments of -10 going from 0 mV (no offset) to -50 mV (maximum offset):

- Press the "volume up" and "power" buttons to enter the BIOS > Setup Utility > Advanced > [CPU|GPU|SOC] voltage offset > Exit > Exit Saving Changes

Most Steam Decks will work with an offset of -20 mV for each component. [20]

If there are any major stability issues, increase the offset by +10 mV. In a worst-case scenario where the Steam Deck cannot boot or get into the BIOS, reset the CMOS settings by pressing the "volume down", "..." (quick access menu), and "power" buttons at the same time until the power LED starts to blink. [19]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/steamos.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/steamos.rst>`__

Bibliography
------------

1. "Transferring files from PC to Steam Deck with FileZilla FTP." GamingOnLinux. September 29, 2022. Accessed November 3, 2022. https://www.gamingonlinux.com/2022/09/transferring-files-from-pc-to-steam-deck-with-ftp/
2. "OLD | EASY Performance Boosts for Steam Deck!" YouTube CryoByte33. October 14, 2022. Accessed November 20, 2022. https://www.youtube.com/watch?v=3iivwka513Y
3. "EASY & SAFE Health & Performance Boosts | Steam Deck." YouTube CryoByte33. November 4, 2022. Accessed November 20, 2022. https://www.youtube.com/watch?v=od9_a1QQQns
4. "How to use an external controller on Steam Deck." PCGamesN. June, 2022. Accessed February 16, 2023. https://www.pcgamesn.com/steam-deck/external-controller
5. "Steam Client Beta - August 4." Steam Community. August 4, 2022. Accessed February 16, 2023. https://steamcommunity.com/groups/SteamClientBeta/announcements/detail/3387288790681635164
6. "Steam Deck adds Windows 11 support and BIOS fixes with beta update." XDA Portal & Forums. April 1, 2022. Accessed February 17, 2023. https://www.xda-developers.com/steam-deck-windows-11-bios-beta/
7. "How to use the TPM on Steam Deck in SteamOS." jiankun.lu. November 14, 2022. Accessed February 17, 2023. https://jiankun.lu/blog/how-to-use-the-tpm-on-steam-deck-in-steamos.html
8. "Why does updating SteamOS wipe all installed Pacman packages?" Steam Deck General Discussions. March 26, 2022. Accessed August 13, 2023. https://steamcommunity.com/app/1675200/discussions/0/3181237058689666854/
9. "How I set up a VPN connection." Reddit r/SteamDeck. July 9, 2023. Accessed August 13, 2023. https://www.reddit.com/r/SteamDeck/comments/wsvyfw/how_i_set_up_a_vpn_connection/?utm_source=share&utm_medium=android_app&utm_name=androidcss&utm_term=1&utm_content=1
10. "Unlock Steam Deck." Chris Titus Tech. July 27, 2022. Accessed August 13, 2023. https://christitus.com/unlock-steam-deck/
11. "Tutorial: A quick and easy way to control the Deck remotely." Reddit r/SteamDeck. December 14, 2022. Accessed October 4, 2023. https://www.reddit.com/r/SteamDeck/comments/tfjjhx/tutorial_a_quick_and_easy_way_to_control_the_deck/
12. "Decky Loader README.md." GitHub SteamDeckHomebrew/decky-loader. August 25, 2023. Accessed October 8, 2023. https://github.com/SteamDeckHomebrew/decky-loader
13. "Steam Deck: How To Install Decky Loader." Game Rant. May 6, 2023. Accessed October 8, 2023. https://gamerant.com/steam-deck-how-install-decky-loader-guide/
14. "What is MTP?" Garmin Customer Support. Accessed October 9, 2023. https://support.garmin.com/en-US/?faq=ycfanFPMus028WBG13MEOA
15. "DeckMTP README.md." GitHub dafta/DeckMTP. May 4, 2023. Accessed October 9, 2023. https://github.com/dafta/DeckMTP
16. "Decky-AutoFlatpaks Plugin README.md." GitHub jurassicplayer/decky-autoflatpaks. March 27, 2023. Accessed October 10, 2023. https://github.com/jurassicplayer/decky-autoflatpaks
17. "How to load and run games on Steam Deck." Steamworks Documentation. Accessed October 11, 2023. https://partner.steamgames.com/doc/steamdeck/loadgames
18. "Everyone's got the wrong idea about Dev Mode on the Steam Deck." ViewSink. April 3, 2022. Accessed October 11, 2023. https://viewsink.com/you-probably-have-no-idea-what-dev-mode-does-on-the-steam-deck/
19. "Steam Deck Gets Easy Undervolting Controls With Firmware 118." Tom's Hardware. October 15, 2023. Accessed October 16, 2023. https://www.tomshardware.com/news/steam-deck-gets-easy-undervolting-controls-with-firmware-118
20. "How's everyone's undervolt going?" Reddit r/SteamDeck. October 13, 2023. Accessed October 16, 2023. https://www.reddit.com/r/SteamDeck/comments/12ihaga/hows_everyones_undervolt_going/
21. "Is Shader Cache and compatdata filling your 64GB internal SSD? Here's the fix!" Reddit r/SteamDeck. July 2, 2022. Accessed November 1, 2023. https://www.reddit.com/r/SteamDeck/comments/tz9rza/is_shader_cache_and_compatdata_filling_your_64gb/
22. "How to avoid SteamOS 3.3 update." Reddit r/SteamDeck. August 7, 2022. Accessed November 2, 2023. https://www.reddit.com/r/SteamDeck/comments/wie6lc/how_to_avoid_steamos_33_update/
23. "Is there a way to always start Steam deck in desktop mode?" Reddit r/SteamDeck. August 25, 2023. Accessed November 5, 2023. https://www.reddit.com/r/SteamDeck/comments/wirkk7/is_there_a_way_to_always_start_steam_deck_in/
