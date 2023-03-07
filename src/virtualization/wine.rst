`Wine <#wine>`__
================

.. contents:: Table of Contents

Introduction
------------

Wine Is Not an Emulator (Wine) is a compatibility layer that translates Windows systems calls into native POSIX system calls. This provides a fast way to run Windows programs natively on UNIX-like systems. [1]

The ReactOS project is a free and open source operating system built from scratch. The main goal is to mirror the Windows NT operating systems. Work on recreating Windows libraries (DLLs) from Wine is imported and re-used in ReactOS. [2]

Both ReactOS [9] and Wine are clean-room reversed engineered to prevent legal issues. However, the Wine project recommends not to use ReactOS source code. [3]

Environment Variables
---------------------

Environment variables can be set by using the "export" Linux shell
command or specifying the variables before a Wine command.

Examples:

.. code-block:: sh

    $ export WINEPREFIX="/home/user/wine_prefix"
    $ winecfg

.. code-block:: sh

    $ WINEPATH="c:/program_dir" wine setup.exe

.. csv-table::
   :header: Name, Default, Description
   :widths: 20, 20, 20

   WINEPREFIX, ``$HOME/.wine``, A directory where Wine should create and use an isolated Windows environment.
   WINESERVER, ``/usr/bin/wineserver``, The "wineserver" binary to use.
   WINELOADER, ``/usr/bin/wine``, The "wine" binary to use for launching new Windows processes.
   WINEDEBUG, "", The debug options to use for logging.
   WINEDLLPATH, ``/usr/lib64/wine``, The directory to load builtin Wine DLLs.
   WINEDLLOVERRIDES, "", "A list of Wine DLLs that should be overridden. If a DLL fails to load it will attempt to load another DLL (if applicable). By default, all operating system DLLs will only use Wine's built-in DLLs."
   WINEPATH, "", Additional paths to append to the Windows PATH variable
   WINEARCH, ``win64``, The Windows architecture to use. Valid options are "win32" or "win64."
   DISPLAY, "", The X11 display to run Windows programs in.
   AUDIODEV, ``/dev/dsp``, The audio device to use.
   MIXERDEV, ``/dev/mixer``, The device to use for mixer controls.
   WINE, ``/usr/bin/wine``, This variable is only used for Winetricks. The full path to the Wine binary to use.

[4]

WINEDEBUG can be configured to log, or not log, specific information.
Specify the log level class, if it should be added "+" or removed "-",
and the channel to use.

Syntax:

.. code-block:: sh

    WINEDEBUG=<CLASS1>[+|-]<CHANNEL1>,<CLASS2>[+|-]<CHANNEL2>

Example:

.. code-block:: sh

    WINEDEBUG=warn+all

Classes:

-  err
-  warn
-  fixme
-  trace

Common channels:

-  all = All debug information.
-  heap = All memory access activity.
-  loaddll = Every time a DLL is loaded.
-  message = Windows Event Log messages.
-  msgbox = Whenever a message box is displayed.
-  olerelay = DCOM specific calls.
-  relay = Calls between builtin or native DLLs.
-  seh = Windows exceptions (Structured Exception Handling).
-  server = RPC communication to wineserver.
-  snoop = Calls between native DLLS.
-  synchronous = Use X11's synchronous mode.
-  tid = Provides the process ID from where each call came from.
-  timestamp = Provides a timestamp for each log.

The full list of debug channels can be found at
https://wiki.winehq.org/Debug\_Channels.

WINEDLLOVERRIDES can be configured to use DLLs provided by Wine and/or
Windows DLLs. There are two different types of DLLs in Wine:

-  b = Builtin Wine DLLs.
-  n = Native Windows DLLs.

Syntax:

.. code-block:: sh

    WINEDLLOVERRIDES="<DLL1_OR_PATH_TO_DLL1>=[n|b],[b|n];<DLL2_OR_PATH_TO_DLL2>=[n|b],[b|n]"

Example:

.. code-block:: sh

    WINEDLLOVERRIDES="shell32=n,b"

The override can set to only run native, native then builtin, or builtin
then native DLLs.

[5]

Graphics Translations
---------------------

These are useful graphics translation layers for running Windows games using Wine and alternative back-end drivers. In some scenarios, a combination of these are required to get games working.

-  `dgVoodoo 2 <http://dege.freeweb.hu/>`__ = Glide (Voodoo) and DirectX <= 9 to DirectX 11.
-  `D9VK <https://github.com/Joshua-Ashton/d9vk>`__ = This has been merged directly into DXVK. DirectX 9 to Vulkan.
-  `DXVK <https://github.com/doitsujin/dxvk>`__ = DirectX 9, 10, and 11 to Vulkan.
-  `MoltenVK (mac OS) <https://moltengl.com/moltenvk/>`__ = Vulkan to Metal.
-  `WineD3D <https://www.winehq.org/>`__ = DirectX <= 11 to `OpenGL 4.4 <https://source.winehq.org/git/wine.git/commitdiff/0db4d1c251d293333e2721a78d6156008a90ff6f>`__. Older versions of OpenGL will still work but will not expose as many working features of DirectX.
-  `Vkd3d <https://wiki.winehq.org/Vkd3d>`__ = DirectX 12 to Vulkan.

Forks
-----

Many forks of the upstream Wine project exist.

-  `CrossOver <https://www.codeweavers.com/products/more-information/source>`__ = The commercial product of Wine made by CodeWeavers which employees the primary Wine developers.
-  `Lutris <https://github.com/lutris/lutris/wiki/Wine-Builds>`__ = A combination of patches from Proton, Proton GE, and TKG.
-  `Proton <https://github.com/ValveSoftware/Proton>`__ = Officially developed by CodeWeavers and funded by Valve, it aims to provide better compatibility and performance for gaming. It bundles DXVK, Vkd3d, Mono, FAudio, fsync, missing fonts, and OpenVR.
-  `Proton-tkg <https://github.com/Tk-Glitch/PKGBUILDS/tree/master/proton-tkg>`__ = A highly configurable set of scripts for building Wine with Proton patches.
-  `Proton GE <https://github.com/GloriousEggroll/proton-ge-custom/releases>`__ = The latest development version of Wine with Staging and Proton patches. It also uses `protonfixes <https://github.com/simons-public/protonfixes>`__ to apply workarounds for certain games.
-  `Staging <https://github.com/wine-staging/wine-staging>`__ = Experimental patches that are either too large/complex, lack tests, or are hacky workarounds for specific applications. The goal is to provide a place to test patches as they continue to be worked on to be merged into upstream Wine.

Frameworks
----------

Various different frameworks exist for helping to install Windows applications on UNIX-like systems. These normally use a combination of Wine, winetricks, and scripts to modify settings and configurations for specific Windows applications to work.

-  `Lutris <https://lutris.net/>`__ = An open source gaming platform that helps with installing emulators and Windows applications. It uses JSON and YAML structures to define how to install applications using Python helper functions.
-  `PlayOnLinux 4 <https://www.playonlinux.com/>`__ (PoL 4) = Uses bash scripts to help with installing Windows applications.
-  `Phoenicis <https://github.com/PhoenicisOrg/phoenicis>`__ = This is the official successor to PlayOnLinux, unofficially known as PlayOnLinux 5. It uses a JSON structure to define dependencies and uses Java helper functions to assist with installing applications.
-  `Steam Play <https://steamcommunity.com/games/221410/announcements/detail/1696055855739350561>`__ = Uses Proton, a forked version of Wine, to natively run Windows games on Linux using the Steam gaming platform.
-  `Winepak <https://www.winepak.org/>`__ = Uses flatpak to package the required dependencies for different Windows applications.

PlayOnLinux 4
~~~~~~~~~~~~~

PlayOnLinux (PoL) uses Python helper functions inside of BASH scripts to define how to install an application. Windows applications are installed into their own separate Wine prefixes so dependencies from one application does not interfere with those from another. All of the data that PoL handles is stored in ``$HOME/.PlayOnLinux/``.

Important directories:

* ``wine/linux-{amd64|x86}/<WINE_VERSION>/`` = Different versions of Wine are stored here.
* ``wineprefix/`` = Isolated Wine prefixes for each game are stored here.

`Versions of Wine from Lutris <https://lutris.net/files/runners/>`__ can be downloaded and extracted into the ``wine/linux-<ARCHITECTURE>/`` directory. These will become available for use in PlayOnLinux. Lutris builds stable, development, staging, and custom patched versions of Wine. [6]

Steam Play
~~~~~~~~~~

Linux Sales
^^^^^^^^^^^

Steam reports the operating system in use for each sale of a developer's game. For counting as a Linux purchase, it can be bought on the Steam client for Linux and not played. Alternatively, it has to be played on Linux (even with Proton/Steam Play) more than any other platform in the first two weeks. The operating system reported after the end of the two weeks is final and will never change. [7]

Manual Proton
^^^^^^^^^^^^^

Games can be run with Proton manually outside of Steam. This requires both the ``STEAM_COMPAT_DATA_PATH`` and ``WINEPREFIX`` variables to be set. Other executables from the game can also be ran this way. [8] It is not recommended to use Proton to run non-Steam games due to runtime compatibility issues.

.. code-block:: sh

   STEAM_COMPAT_DATA_PATH="$HOME/.steam/steam/steamapps/compatdata/<STEAM_GAME_ID>" WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/<STEAM_GAME_ID>/pfx" "$HOME/.steam/root/compatibilitytools.d/<PROTON_VERSION>/proton" run "$HOME/steam/steamapps/common/<GAME_NAME>/<GAME_EXE>"

Game Bans
---------

Some video games will ban players if they are using Wine due to false-positive reports from their anti-cheat software. Here are a few lists of games that have been known to ban players who use Wine on Linux.

Bans still being created:

-  `Battlefield V <https://www.gamingonlinux.com/articles/15706>`__
-  `Destiny 2 <https://www.bungie.net/en/Forums/Post/249217461>`__

Previous bans that have now been addressed:

-  `Diablo III <https://www.cinemablend.com/games/Blizzard-Admits-Linux-User-Was-Wrongly-Banned-Offers-Refund-49339.html>`__
-  `Overwatch <https://www.reddit.com/r/linux_gaming/comments/9fkuq9/overwatch_avoid_async_option_for_dxvk_banned_for/>`__

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization/wine.rst>`__
-  `< 2019.04.01 (Virtualization) <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/wine.rst>`__
-  `< 2019.01.01 (Virtualization) <https://github.com/LukeShortCloud/rootpages/commits/main/src/wine.rst>`__
-  `< 2018.01.01 (Virtualization) <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/wine.md>`__

Bibliography
------------

1. "WineHQ." WineHQ. October 20, 2017. Accessed October 29, 2017. https://www.winehq.org/
2. "Wine." ReactOS Wiki. April 28, 2017. Accessed October 29, 2017. https://www.reactos.org/wiki/WINE
3. "Clean Room Guidelines." WineHQ. July 6, 2022. Accessed March 7, 2023. https://wiki.winehq.org/Clean\_Room\_Guidelines
4. "Wine User's Guide." WineHQ. September 15, 2017. Accessed October 29, 2017. https://wiki.winehq.org/Wine\_User%27s\_Guide
5. "Debug Channels." WineHQ. November 13, 2016. Accessed October 29, 2017. https://wiki.winehq.org/Debug\_Channels
6. "Lutris Wine Versions." PlayOnLinux Forum. April 3, 2018. Accessed June 16, 2018. https://www.playonlinux.com/en/topic-15838-Lutris\_Wine\_Versions.html
7. "Valve officially confirm a new version of 'Steam Play' which includes a modified version of Wine." GamingOnLinux. August 21, 2018. Accessed March 8, 2020. https://www.gamingonlinux.com/articles/valve-officially-confirm-a-new-version-of-steam-play-which-includes-a-modified-version-of-wine.12400
8. "How to run another .exe in an existing proton wine prefix." GitHub michaelbutler/Steam_Proton_Exe.md. September 11, 2020. Accessed March 12, 2021. https://gist.github.com/michaelbutler/f364276f4030c5f449252f2c4d960bd2
9. "RESET, REBOOT, RESTART, LEGAL ISSUES AND THE LONG ROAD TO 0.3." ReactOS Project. January 27, 2006. Accessed March 7, 2023. https://reactos.org/project-news/reset-reboot-restart-legal-issues-and-long-road-03/
