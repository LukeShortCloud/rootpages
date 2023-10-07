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

Steam Client Performance Tuning
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Various settings can be configured to make the Steam client use less system resources.

-  Steam > Settings

   -  Friends & Chat

      -  Sign in to friends whem Steam Client starts: No
      -  Enable Animated Avatars & Animated Avatar Frames in your Friends List and Chat: No
      -  Remember my open chats: No

   -  Interface

      -  Start Up Location: Library

   -  Library

      -  Low Bandwidth Mode: Yes
      -  Low Performance Mode: Yes
      -  Disable Community Content: Yes
      -  Show game icons in the left column: No

   -  Downloads

      -  Enable Shader Pre-caching: No

         -  Only disable this on devices that are not the Steam Deck running the official SteamOS. Valve provides pre-compiled shaders for it.
         -  The graphics driver needs to support graphics pipeline library (GPL) for faster shader compilation that does not require pre-caching.

            -  AMD = `Mesa 23.1.0 <https://lists.freedesktop.org/archives/mesa-announce/2023-May/000720.html>`__
            -  Intel = `Mesa 23.2.0 <https://cgit.freedesktop.org/mesa/mesa/commit/?id=c97b1eb08a971f72e8b1319c39379832616f9733>`__
            -  NVIDIA = `NVIDIA 515.49.10 <https://github.com/doitsujin/dxvk/issues/2798>`__

   -  In Game

      -  Enable the Steam Overlay while in-game: Off

Launch arguments for Steam:

.. code-block:: sh

   $ steam -no-browser -nochatui -nofriendsui

[4][5]

Disable Steam Client Updates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Launch Steam with the following arguments to completely disable updates [6]:

.. code-block:: sh

   $ steam -noverifyfiles -nobootstrapupdate -skipinitialbootstrap -norepairfiles -overridepackageurl

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
4. "Why is steam using 27% CPU, and how can I stop it from using so much?" Reddit r/Steam. September 22, 2020. Accessed August 16, 2023. https://www.reddit.com/r/Steam/comments/ixi9ed/why_is_steam_using_27_cpu_and_how_can_i_stop_it/
5. "How To Optimize Steam for Competitive Gaming." Forgeary. April 8, 2023. Accessed August 16, 2023. https://forgeary.com/optimize-steam/
6. "Disabling Steam client auto-updates." Steam Help and Tips. December 15, 2019. Accessed October 6, 2023. https://steamcommunity.com/discussions/forum/1/1639788130289877816/
