`Wine <#wine>`__
================

.. contents:: Table of Contents

Introduction
------------

Wine Is Not an Emulator (Wine) is a compatibility layer that translates Windows systems calls into native POSIX system calls. This provides a fast way to run Windows programs natively on UNIX-like systems. [1]

The ReactOS project is a free and open source operating system built from scratch. The main goal is to mirror the Windows NT operating systems. Work on recreating Windows libraries (DLLs) from Wine is imported and re-used in ReactOS. [2]

Both ReactOS [9] and Wine are clean-room reversed engineered to prevent legal issues. However, the Wine project recommends not to use ReactOS source code. [3]

Installation
------------

Binary Packages
~~~~~~~~~~~~~~~

Here is how to install both the 32-bit and 64-bit libraries for Wine. This includes recommended dependencies such as Mono (open source .NET Framework) and Gecko (open source Internet Explorer based on Firefox).

-  Arch Linux [10]:

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/pacman.conf
      [multilib]
      Include = /etc/pacman.d/mirrorlist
      $ sudo pacman -S -y -y
      $ sudo pacman -S wine wine-mono wine-gecko

-  Debian [11]:

   .. code-block:: sh

      $ sudo dpkg --add-architecture i386
      $ sudo apt update
      $ sudo apt install wine wine32 wine64 libwine libwine:i386 fonts-wine

-  Fedora [12]:

   .. code-block:: sh

      $ sudo dnf install wine

Compile From Source Code
~~~~~~~~~~~~~~~~~~~~~~~~

Compiling Wine from source code allows testing out new versions and features sooner. The build can also be highly configured.

-  Install 64-bit build dependencies.

   -  Fedora [13][14][15][16]:

      .. code-block:: sh

         $ sudo dnf install \
             audiofile-devel \
             autoconf \
             bison \
             ccache \
             chrpath \
             clang \
             cups-devel \
             dbus-devel \
             dbus-libs \
             desktop-file-utils \
             flex \
             fontconfig-devel \
             fontforge \
             fontpackages-devel \
             freeglut-devel \
             freetype-devel \
             freetype-devel \
             gcc \
             gettext-devel \
             giflib-devel \
             git \
             glibc-devel.i686 \
             gnutls-devel \
             gsm-devel \
             gstreamer1-devel \
             gstreamer1-plugins-base-devel \
             krb5-devel \
             libappstream-glib \
             libattr-devel \
             libgphoto2-devel \
             libieee1284-devel \
             libpcap-devel \
             librsvg2 \
             librsvg2-devel \
             libstdc++-devel \
             libunwind-devel \
             libusb1-devel \
             libusbx-devel \
             libv4l-devel \
             libva-devel \
             libX11-devel \
             libXcomposite-devel \
             libXcursor-devel \
             libXext-devel \
             libXfixes-devel \
             libXi-devel \
             libXinerama-devel \
             libXmu-devel \
             libXrandr-devel \
             libXrender-devel \
             libXxf86dga-devel \
             libXxf86vm-devel \
             lld \
             make \
             mesa-libGL-devel \
             mesa-libGLU-devel \
             mesa-libOSMesa-devel \
             mingw32-FAudio \
             mingw32-gcc \
             mingw32-lcms2 \
             mingw32-libpng \
             mingw32-libtiff \
             mingw32-libxml2 \
             mingw32-libxslt \
             mingw32-vkd3d \
             mingw32-vulkan-headers \
             mingw32-zlib \
             mingw64-FAudio \
             mingw64-gcc \
             mingw64-lcms2 \
             mingw64-libpng \
             mingw64-libtiff \
             mingw64-libxml2 \
             mingw64-libxslt \
             mingw64-vkd3d \
             mingw64-vulkan-headers \
             mingw64-zlib \
             mpg123-devel \
             ocl-icd-devel \
             opencl-headers \
             openldap-devel \
             perl-generators \
             pulseaudio-libs-devel \
             samba-devel \
             sane-backends-devel \
             SDL2-devel \
             systemd-devel \
             unixODBC-devel \
             vulkan-devel \
             vulkan-headers

-  Install 32-bit build dependencies.

   -  Fedora:

      .. code-block:: sh

         $ sudo dnf install \
             audiofile-devel.i686 \
             autoconf \
             ccache \
             clang.i686 \
             cups-devel.i686 \
             dbus-devel.i686 \
             dbus-libs.i686 \
             fontconfig-devel.i686 \
             fontforge.i686 \
             freeglut-devel.i686 \
             freetype-devel.i686 \
             freetype-devel.i686 \
             gcc \
             gettext-devel.i686 \
             giflib-devel.i686 \
             git \
             glibc-devel.i686 \
             gnutls-devel.i686 \
             gsm-devel.i686 \
             gstreamer1-devel.i686 \
             gstreamer1-plugins-base-devel.i686 \
             krb5-devel.i686 \
             libappstream-glib.i686 \
             libattr-devel.i686 \
             libgphoto2-devel.i686 \
             libieee1284-devel.i686 \
             libpcap-devel.i686 \
             librsvg2.i686 \
             librsvg2-devel.i686 \
             libstdc++-devel.i686 \
             libunwind-devel.i686 \
             libusb1-devel.i686 \
             libv4l-devel.i686 \
             libva-devel.i686 \
             libX11-devel.i686 \
             libXcomposite-devel.i686 \
             libXcursor-devel.i686 \
             libXext-devel.i686 \
             libXfixes-devel.i686 \
             libXi-devel.i686 \
             libXinerama-devel.i686 \
             libXmu-devel.i686 \
             libXrandr-devel.i686 \
             libXrender-devel.i686 \
             libXxf86dga-devel.i686 \
             libXxf86vm-devel.i686 \
             lld.i686 \
             make \
             mesa-libGL-devel.i686 \
             mesa-libGLU-devel.i686 \
             mesa-libOSMesa-devel.i686 \
             mingw32-FAudio \
             mingw32-gcc \
             mingw32-lcms2 \
             mingw32-libpng \
             mingw32-libtiff \
             mingw32-libxml2 \
             mingw32-libxslt \
             mingw32-vkd3d \
             mingw32-vulkan-headers \
             mingw32-zlib \
             mingw64-FAudio \
             mingw64-gcc \
             mingw64-lcms2 \
             mingw64-libpng \
             mingw64-libtiff \
             mingw64-libxml2 \
             mingw64-libxslt \
             mingw64-vkd3d \
             mingw64-vulkan-headers \
             mingw64-zlib \
             ocl-icd-devel.i686 \
             opencl-headers \
             openldap-devel.i686 \
             perl-generators \
             pulseaudio-libs-devel.i686 \
             samba-devel.i686 \
             sane-backends-devel.i686 \
             SDL2-devel.i686 \
             systemd-devel.i686 \
             vulkan-headers \
             vulkan-loader-devel.i686

-  Download the official Wine git repository.

   .. code-block:: sh

      $ git clone https://gitlab.winehq.org/wine/wine.git
      $ cd wine

Common ``./configure`` arguments [13]:

-  ``--enable-win64`` = Build 64-bit Wine. By default, 32-bit Wine is built.
-  ``--with-wine64 <DIRECTORY>`` = Build 32-bit Wine with support for 64-bit by referencing the directory where 64-bit Wine was built.
-  ``--enable-archs=i386,x86_64`` = Build Wine with WoW64 support. This only requires 64-bit dependencies but still allows 32-bit Windows programs to work.
-  ``CC="ccache gcc" CROSSCC="ccache x86_64-w64-mingw32-gcc" --enable-win64`` = Use ``ccache`` to speed up rebulding 64-bit Wine. [17]
-  ``CC="ccache gcc" CROSSCC="ccache i686-w64-mingw32-gcc" --with-wine64 <DIRECTORY>`` = Use ``ccache`` to speed rebuilding 32-bit Wine.

Example configure usage:

-  Configure the use of Fedora's non-standard location of the FreeType2 source files. [19]

   .. code-block:: sh

      $ ./configure CFLAGS="-I/usr/include/freetype2"

Example builds:

-  Build 32-bit only Wine. [13]

   .. code-block:: sh

      $ ./configure CC="ccache gcc" CROSSCC="ccache i686-w64-mingw32-gcc"
      $ make -j $(nproc)

-  Build standard Wine with support for both 32-bit and 64-bit Windows programs. [13][18]

   .. code-block:: sh

      $ mkdir win64
      $ cd win64
      $ ../configure CC="ccache gcc" CROSSCC="ccache x86_64-w64-mingw32-gcc" --enable-win64
      $ make -j $(nproc)
      $ cd ..
      $ mkdir win32
      $ cd win32
      $ ../configure CC="ccache gcc" CROSSCC="ccache i686-w64-mingw32-gcc" --with-wine64=../win64
      $ make -j $(nproc)
      $ cd ..

   -  Once built, use ``tools/winewrapper`` to run 32-bit or 64-bit Windows programs. This script looks for the correct library and binary locations for Wine and sets temporary environment variables for the local installation to work.

-  Build Wine with WoW64 support. [20] It is recommended to use a special branch from a CodeWeavers employee that has extra WoW64 patches applied on-top of the latest Wine release.

   .. code-block:: sh

      $ git clone --branch wow https://gitlab.winehq.org/jacek/wine.git
      $ cd wine
      $ ./configure CC="ccache gcc" CROSSCC="ccache x86_64-w64-mingw32-gcc" --enable-archs=i386,x86_64
      $ make -j $(nproc)

   -  Verify that WoW64 support was built successfully by ensuring that the 32-bit Wine executable file is actually a 64-bit Linux binary.

      .. code-block:: sh

         $ file ./loader/wine
         loader/wine: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=6f687b3c6288a675b9fb777dccf1c585caed7acb, for GNU/Linux 3.2.0, with debug_info, not stripped

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
   "WINE_D3D_CONFIG=""renderer=<RENDERER>""", ``gl``, "The WineD3D back-end engine to use. Valid options are ""gl"" (OpenGL), ""vulkan"", or ""no3d"" (disable rendering). [20][21]"

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

Introduction
~~~~~~~~~~~~

These are useful graphics translation layers for running Windows games using Wine and alternative back-end drivers. In some scenarios, a combination of these are required to get games working.

-  `dgVoodoo 2 <http://dege.freeweb.hu/>`__ = Glide (Voodoo) and DirectX <= 9 to DirectX 11.
-  `D8VK <https://github.com/AlpyneDreams/d8vk>`__ = DirectX 8 to Vulkan.

    -  This project also has experimental support for `DirectX 7 to Vulkan <https://github.com/AlpyneDreams/d8vk/tree/d3d7>`__.

-  `D9VK <https://github.com/Joshua-Ashton/d9vk>`__ = This has been merged directly into DXVK. DirectX 9 to Vulkan.
-  `DXVK <https://github.com/doitsujin/dxvk>`__ = DirectX 9, 10, and 11 to Vulkan.
-  `MoltenVK (mac OS) <https://moltengl.com/moltenvk/>`__ = Vulkan to Metal.
-  `WineD3D <https://www.winehq.org/>`__ = DirectX 8 through 11 to `OpenGL 4.4 <https://source.winehq.org/git/wine.git/commitdiff/0db4d1c251d293333e2721a78d6156008a90ff6f>`__. [23] Older versions of OpenGL will still work but will not expose as many working features of DirectX.

   -  The newer back-end engine Damavand for WineD3D provides Vulkan to DirectX 10 and 11. [22]

-  `Vkd3d <https://wiki.winehq.org/Vkd3d>`__ = DirectX 12 to Vulkan.

   -  `VKD3D-Proton <https://github.com/HansKristian-Work/vkd3d-proton>`__ = A fork of Vkd3d that is focused on gaming. Valve only tests this project on AMD and NVIDIA GPUs (not Intel).

D8VK
~~~~

Releases
^^^^^^^^

Release highlights:

-  `1.0.0 <https://github.com/AlpyneDreams/d8vk/releases/tag/d8vk-v1.0>`__

   -  The first stable release.
   -  Most Direct3D 8 games work now.
   -  Supports being built with Microsoft Visual Studio (instead of only MinGW-w32).
   -  Performance was benchmarked to be up to 4x faster than WineD3D.

-  `0.10.0 <https://github.com/AlpyneDreams/d8vk/releases/tag/d8vk-v0.10>`__

   -  The first relese to support Linux.
   -  Rebased on DXVK 2.0.

        -  Now requires Vulkan 1.3 because of this.

   -  A handful of games work.

-  `0.1.0 <https://github.com/AlpyneDreams/d8vk/releases/tag/v0.1.0>`__

   -  The first ever release of DXVK. It primarily only supports basic game demos.
   -  This build only works on Windows.

DXVK
~~~~

Releases
^^^^^^^^

Release highlights:

-  `2.1 <https://github.com/doitsujin/dxvk/releases/tag/v2.1>`__
    - Supports HDR10.
-  `2.0 <https://github.com/doitsujin/dxvk/releases/tag/v2.0>`__
    - Requires Vulkan 1.3.
-  `1.5.2 <https://github.com/doitsujin/dxvk/releases/tag/v1.5.2>`__
    - Requires Vulkan 1.1.
-  `1.5 <https://github.com/doitsujin/dxvk/releases/tag/v1.5>`__
    - Translates DirectX 9 to Vulkan through the use of the merged-in `D9VK <https://github.com/Joshua-Ashton/d9vk>`__ project.
-  `0.7.0 <https://github.com/doitsujin/dxvk/releases/tag/v0.70>`__
    - Translates DirectX 10 to Vulkan.
-  `0.20 <https://github.com/doitsujin/dxvk/releases/tag/v0.20>`__
    - The first ever release of DXVK. It only supports one game.
    - Translates DirectX 11 to Vulkan.
    - Requires Vulkan 1.0.

Build
^^^^^

-  Install the build dependencies for DXVK.

   -  Fedora [24]:

      .. code-block:: sh

         $ sudo dnf install \
             gcc \
             gcc-c++ \
             glslang \
             meson \
             mingw64-binutils \
             mingw64-cpp \
             mingw64-filesystem \
             mingw64-gcc \
             mingw64-gcc-c++ \
             mingw64-headers \
             mingw64-winpthreads-static \
             mingw32-binutils \
             mingw32-cpp \
             mingw32-filesystem \
             mingw32-gcc \
             mingw32-gcc-c++ \
             mingw32-headers \
             mingw32-winpthreads-static \
             wine-devel

-  Download the DXVK source code.

   .. code-block:: sh

      $ export DXVK_VER="2.2"
      $ git clone --depth 1 --branch "v${DXVK_VER}" https://github.com/doitsujin/dxvk.git
      $ cd dxvk
      $ git submodule update --init --recursive

-  Compile DXVK. [25]

   .. code-block:: sh

      $ meson setup --cross-file build-win32.txt --buildtype release build.w32
      $ cd build.w32
      $ ninja
      $ cd ..
      $ meson setup --cross-file build-win64.txt --buildtype release build.w64
      $ cd build.w64
      $ ninja
      $ cd ..

-  The DLL files will be located at:

   -  build.[w32|w64]/src/d3d9/d3d9.dll
   -  build.[w32|w64]/src/d3d10/d3d10core.dll
   -  build.[w32|w64]/src/d3d11/d3d11.dll
   -  build.[w32|w64]/src/dxgi/dxgi.dll

-  Copy these files to the Wine prefix (``~/.wine/`` by default).

   .. code-block:: sh

      $ cp ./build.w32/src/*/*.dll ${WINE_PREFIX}/drive_c/windows/syswow64/
      $ cp ./build.w64/src/*/*.dll ${WINE_PREFIX}/drive_c/windows/system32/

Installation
^^^^^^^^^^^^

Automatic:

-  With ``winetricks``.

   -  Update ``winetricks``, view all of the available versions that can be installed, and then install the latest version.

      .. code-block:: sh

         $ sudo winetricks --self-update
         $ winetricks list-all | grep dxvk
         $ winetrick dxvk

-  With a package manager.

   -  Arch Linux:

      .. code-block:: sh

         $ yay -S dxvk-bin

   -  Debian [26]:

      .. code-block:: sh

         $ sudo apt-get update
         $ sudo apt-get install dxvk-wine32-development dxvk-wine64-development

   -  Fedora:

      .. code-block:: sh

         $ sudo dnf install wine-dxvk.i686 wine-dxvk.x86_64

Manual:

-  Either `build <#build>`__ or `download <https://github.com/doitsujin/dxvk/releases>`__ a DXVK release.

   -  Download:

      .. code-block:: sh

         $ export DXVK_VER=2.2
         $ wget "https://github.com/doitsujin/dxvk/releases/download/v${DXVK_VER}/dxvk-${DXVK_VER}.tar.gz"
         $ tar -x -v -f dxvk-${DXVK_VER}.tar.gz

-  Copy the 32-bit DLLs to ``${WINE_PREFIX}/drive_c/windows/syswow64/``.
-  Copy the 64-bit DLLs to ``${WINE_PREFIX}/drive_c/windows/system32/``.
-  Use Wine with overrides for those DLLs to use the native versions instead of Wine's built-in DLLs.

   -  For the CLI, this can be set via the ``WINEDLLOVERRIDES`` enviornment variable.

      .. code-block:: sh

         $ WINEDLLOVERRIDES="dxgi=n;d3d9=n;d3d10core=n;d3d11=n" wine

   -  For the GUI, this can be set via the Wine configuration tool by going to the "Libraries" tab and adding overrides for ``dxgi``, ``d3d9``, ``d3d10core``, and ``d3d11``. [25]

      .. code-block:: sh

         $ winecfg

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
10. "How to Install Wine on Arch Linux." Installing Wine on Linux. December 14, 2022. Accessed March 7, 2023. https://wine.htmlvalidator.com/install-wine-on-arch-linux.html
11. "Wine." Debian Wiki. January 3, 2023. Accessed March 7, 2023. https://wiki.debian.org/Wine
12. "Wine." Fedora Docs. March 7, 2023. Accessed March 7, 2023. https://docs.fedoraproject.org/en-US/quick-docs/wine/
13. "Building Wine." WineHQ Wiki. December 2, 2022. Accessed March 7, 2023. https://wiki.winehq.org/Building_Wine
14. "Help Building Wine For Fedora and Updating Build Instructions." WineHQ Forums. January 30, 2020. Accessed March 7, 2023. https://forum.winehq.org/viewtopic.php?t=33373
15. "F19: can't find libudev." FedoraForum.org. October 7, 2013. Accessed March 7, 2023. https://forums.fedoraforum.org/showthread.php?292206-F19-can-t-find-libudev
16. "wine.spec." Fedora Source Packages rpms/wine f38. February 22, 2023. Accessed March 7, 2023. https://src.fedoraproject.org/rpms/wine/blob/f38/f/wine.spec
17. "Building a MinGW WoW64 Wine with a custom vkd3d build." WineHQ Wiki. June 2, 2022. Accessed March 7, 2023. https://wiki.winehq.org/Building_a_MinGW_WoW64_Wine_with_a_custom_vkd3d_build
18. "Working on Wine Part 2 - Wine's Build Process." CodeWeavers Blog. January 8, 2019. Accessed March 7, 2023. https://www.codeweavers.com/blog/aeikum/2019/1/8/working-on-wine-part-2-wines-build-process
19. "configure: error: FreeType 32-bit development files not found." FedoraForum.org. January 3, 2023. Accessed March 7, 2023. https://forums.fedoraforum.org/showthread.php?329486-configure-error-FreeType-32-bit-development-files-not-found
20. "Wine [8.0] Announcement." WineHQ. Accessed March 7, 2023. https://www.winehq.org/announce/8.0
21. "wine/dlls/wined3d/wined3d_main.c." GitLab wine/wine. December 3, 2022. Accessed March 7, 2023. https://gitlab.winehq.org/wine/wine/-/blob/wine-8.0/dlls/wined3d/wined3d_main.c#L447-L464
22. "wine/dlls/wined3d/adapter_vk.c." GitLab wine/wine. December 4, 2022. Accessed March 7, 2023. https://gitlab.winehq.org/wine/wine/-/blob/wine-8.0/dlls/wined3d/adapter_vk.c#L2092
23. "Wrappers." Emulation General Wiki. May 10, 2023. Accessed May 10, 2023. https://emulation.gametechwiki.com/index.php/Wrappers
24. "wine-dxvk." Fedora Package Sources rpms/wine-dxvk. January 21, 2023. Accessed May 19, 2023. https://src.fedoraproject.org/rpms/wine-dxvk/blob/rawhide/f/wine-dxvk.spec
25. "DXVK." GitHub doitsujin/dxvk. May 19, 2023. Accessed May 19, 2023. https://github.com/doitsujin/dxvk
26. "Package: dxvk (2.1-1)." Debian -- Packages. Accessed May 26, 2023. https://packages.debian.org/sid/utils/dxvk
