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
