SteamOS 3
=========

.. contents:: Table of Contents

Desktop Mode
------------

Enable Desktop Mode
~~~~~~~~~~~~~~~~~~~

By default, the Steam Deck only works in Game Mode. Developer Mode must be enabled to access Desktop Mode.

-  STEAM > Settings > System > SYSTEM SETTINGS > Enable Developer Mode: Yes

Default User Account
~~~~~~~~~~~~~~~~~~~~

By default, on the Steam Deck, the user and group ``deck`` (UID and GID ``1000``) is used. It is also part of the ``wheel`` group (GID ``998``) which provides it access to running commands as the ``root`` user with the ``sudo`` command.

There is no password by default. For running ``sudo`` commands, a password needs to be set.

-  GUI: System Settings > Personalization > Users > Your Account > Steam Deck User > Change Password
-  CLI:

   .. code-block:: sh

      $ passwd

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

Select the "InstallCryoUtilities.desktop" shortcut to install the tools. Then select the new "CryoUtilities" desktop shortcut. This will have prompts to walk through setting up the 16 GB swap file and 1% swappiness level.

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

Disable SteamOS Updates
~~~~~~~~~~~~~~~~~~~~~~~

SteamOS operating system updates can only be disabled from the Desktop Mode.

-  Disable updates:

   .. code-block:: sh

      $ sudo steamos-readonly disable
      $ sudo chmod -x /usr/bin/steamos-atomupd-client
      $ sudo chmod -x /usr/bin/steamos-atomupd-mkmanifest
      $ sudo chmod -x /usr/bin/steamos-update
      $ sudo chmod -x /usr/bin/steamos-update-os
      $ sudo steamos-readonly enable

-  Re-enable updates:

   .. code-block:: sh

      $ sudo steamos-readonly disable
      $ sudo chmod +x /usr/bin/steamos-atomupd-client
      $ sudo chmod +x /usr/bin/steamos-atomupd-mkmanifest
      $ sudo chmod +x /usr/bin/steamos-update
      $ sudo chmod +x /usr/bin/steamos-update-os
      $ sudo steamos-readonly enable

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/steamos.rst>`__

Bibliography
------------

1. "Transferring files from PC to Steam Deck with FileZilla FTP." GamingOnLinux. September 29, 2022. Accessed November 3, 2022. https://www.gamingonlinux.com/2022/09/transferring-files-from-pc-to-steam-deck-with-ftp/
2. "OLD | EASY Performance Boosts for Steam Deck!" YouTube CryoByte33. October 14, 2022. Accessed November 20, 2022. https://www.youtube.com/watch?v=3iivwka513Y
3. "EASY & SAFE Health & Performance Boosts | Steam Deck." YouTube CryoByte33. November 4, 2022. Accessed November 20, 2022. https://www.youtube.com/watch?v=od9_a1QQQns
