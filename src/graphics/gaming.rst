Gaming
======

.. contents:: Table of Contents

Steam
-----

Runtime
~~~~~~~

Steam provides a runtime that is a chroot of pre-installed Linux libraries required for Steam to work. Sometimes these libraries may not work as expected. There are different ways to configure how Steam will or will not use its own runtime.

-  Use the Steam runtime libraries.

   .. code-block:: sh

      $ STEAM_RUNTIME=1 steam

-  Use the system libraries and fall-back to Steam runtime libraries if they are missing on the system.

   .. code-block:: sh

      $ STEAM_RUNTIME=1 STEAM_RUNTIME_PREFER_HOST_LIBRARIES=1 steam

-  Use the system libraries.

   .. code-block:: sh

      $ STEAM_RUNTIME=0 steam

[3]

Flatpak
~~~~~~~

The Flatpak for Steam can mount external devices into the isolated environment. Mount points are not exposed in the Flatpak by default. [1]

.. code-block:: sh

   $ flatpak override --user --filesystem=<STEAM_LIBRARY_PATH> com.valvesoftware.Steam

Proton (Steam Play)
~~~~~~~~~~~~~~~~~~~

Proton allows Windows games to run on Linux. A full list of games that are officially whitelisted and guaranteed to work can be found `here <https://steamdb.info/app/891390/>`__. Proton can be enabled for all games by going to ``Settings > Steam Play > Enable Steam Play for all other titles``. Compatibility will vary. [2]

Troubleshooting
---------------

Error Messages
~~~~~~~~~~~~~~

Missing libraries when starting the Steam runtime:

.. code-block:: sh

   $ steam-runtime
   Error: You are missing the following 32-bit libraries, and Steam may not run: <LIBRARY_FILE>

Solution:

-  Run ``steam-runtime --reset`` to redownload the runtime libraries.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics/gaming.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/graphics.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/graphics.rst>`__

Bibliography
------------

1. "Frequently asked questions." flathub/com.valvesoftware.Steam. April 12, 2020. Accessed July 3, 2020. https://github.com/flathub/com.valvesoftware.Steam/wiki/Frequently-asked-questions
2. "A simple guide to Steam Play, Valve's technology for playing Windows games on Linux." GamingOnLinux. July 12, 2019. Accessed July 3, 2020. https://www.gamingonlinux.com/articles/14552
3. "Steam/Client troubleshooting." Gentoo Wiki. February 15, 2021. Accessed May 20, 2021. https://wiki.gentoo.org/wiki/Steam/Client_troubleshooting
