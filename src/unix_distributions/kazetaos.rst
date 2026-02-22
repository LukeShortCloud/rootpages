KazetaOS
========

.. contents:: Table of Contents

User Access
-----------

Access the console by pressing ``CTRL``, ``ALT``, and ``F3``. Go back to the Kazeta app by pressing ``CTRL``, ``ALT``, and ``F1``.

The default username and password are both ``gamer``. The password cannot be changed because ``/etc/`` is part of the read-only file system. The ``/home/`` directory is also read-only. [2]

There is no official support for SSH.

Networking
----------

In the original KazetaOS 2025.0 release, an ``ethernet-connect`` command is provided to configure DHCP networking via the first Ethernet port. It does not work due to a bug and requires the following commands to workaround it.

.. code-block:: sh

    $ sudo frzr-unlock
    $ sudo ethernet-connect
    $ sudo systemctl daemon-reload
    $ sudo systemctl restart systemd-networkd

In newer versions of KazetaOS, DHCP is automatically configured on all Ethernet ports. [1]

There is no official support for Wi-Fi.

Updates
-------

Update to the latest stable version. [2]

.. code-block:: sh

   $ sudo frzr-deploy
   $ sudo reboot

Update to the latest development version from GitHub. [3][4]

.. code-block:: sh

   $ sudo frzr-deploy kazetaos/kazeta:unstable
   $ sudo reboot

Cartridges
----------

Most games require a SD card with a minimum speed of C10 (also known as U1). Some newer games require an external SSD.

Format external storage to be ext4 (without the ``-O casefolding`` option). [5]

.. code-block:: sh

   $ sudo mkfs -t ext4 /dev/<DEVICE><PARTITION>

Create a Kazeta Info (KZI) file for the game. The extension name must be ``.kzi``. [6]

-  ``Name=`` = Humain friendly name of the game.
-  ``Id=`` = A unique name for the game. Spaces and special characters are not allowed. It is recommended to use the ``kabob-case`` style. This will be used to store and track the save game data.
-  ``Exec=`` = Path to the executable for the game. It is recommended to store the game files in a directory called ``content``. However, some games will only work if placed in the top-level directory.
-  ``Icon=`` = Path to a 32x32 PNG icon. In the Kazeta menu, this will be used to represent the save data of the game. It is recommended to call this ``icon.png``.

   -  Use `SteamGridDB <https://www.steamgriddb.com/>`__ to browse for an icon. Once found, use ImageMagick to convert it to the correct size.

      .. code-block:: sh

         $ magick <ORIGINAL_ICON>.png -resize 32x32 <NEW_ICON>.png

-  ``Runtime=`` = The runtime name. All `official runtimes <https://github.com/kazetaos/kazeta/wiki/Runtimes>`__ [7]:

   -  PC

      -  ``linux``
      -  ``none`` = Do not use a runtime. Use the system libraries from KazetaOS instead. [8]
      -  ``windows``

   -  Nintendo

      -  ``nes``
      -  ``snes``
      -  ``nintendo64``

   -  Sega

      -  ``megadrive``

-  ``GamescopeOptions=`` = Optional `Gamescope arguments <https://github.com/ValveSoftware/gamescope?tab=readme-ov-file#options>`__.

Example KZI file:

.. code-block:: sh

   $ cat star-wars-game.kzi
   Name=Star Wars Game
   Id=star-wars-game
   Icon=icon.png
   Runtime=windows
   Exec=star-wars-game.exe

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/kazetaos.rst>`__

Bibliography
------------

1. "Connect to network automatically if ethernet cable is connected." GitHub kazetaos/kazeta. January 11, 2026. Accessed February 16, 2026. https://github.com/kazetaos/kazeta/commit/1dc334c0d0066114b73f42f760fe42b22d028c11
2. "Technical Details." GitHub kazetaos/kazeta. August 20, 2025. Accessed Feburary 16, 2026. https://github.com/kazetaos/kazeta/wiki/Technical-Details
3. "Development." GitHub ChimeraOS/chimeraos. August 5, 2024. Accessed February 16, 2026. https://github.com/ChimeraOS/chimeraos/wiki/Development
4. "Releases." GitHub kazetaos/kazeta. January 13, 2026. Accessed February 16, 2026. https://github.com/kazetaos/kazeta/releases
5. "Creating Carts." GitHub kazetaos/kazeta. February 10, 2026. Accessed February 22, 2026. https://github.com/kazetaos/kazeta/wiki/Creating-Carts
6. "Kazeta Info (KZI) File Reference." GitHub kazetaos/kazeta. February 14, 2026. Accessed February 22, 2026. https://github.com/kazetaos/kazeta/wiki/Kazeta-Info-(KZI)-File-Reference
7. "Runtimes." GitHub kazetaos/kazeta. September 26, 2026. Accessed February 22, 2026. https://github.com/kazetaos/kazeta/wiki/Runtimes
8. "Technical Details." GitHub kazetaos/kazeta. August 20, 2025. Accessed February 22, 2026. https://github.com/kazetaos/kazeta/wiki/Technical-Details
