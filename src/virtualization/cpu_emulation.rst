CPU Emulation
=============

.. contents:: Table of Contents

Box64
-----

Introduction
~~~~~~~~~~~~

Supported hardware [1]:

-  Box64

   -  x86 (AMD/Intel) = For debugging purposes.
   -  Arm
   -  LoongArch
   -  PowerPC
   -  RISC-V

-  Box86

   -  x86
   -  Arm
   -  PowerPC

Projects:

-  `Box64 <https://github.com/ptitSeb/box64>`__ = Translates 64-bit applications from x86_64 to another CPU architecture.

     -  Box32 = Included with the Box64 project. Translates 32-bit x86 applications to 64-bit and to another CPU architecture. Useful for architectures that no longer support 32-bit.

-  `Box86 <https://github.com/ptitSeb/box86>`__ = Translates 32-bit applications from x86 to another CPU architecture.

For running applications that require both 32-bit and 64-bit support, such as Steam, either (1) both Box64 and Box86 need to be installed or (2) Box64 needs to be installed with Box32 support. A list of compatible programs can be found `here <https://box86.org/app/>`__.

Dynamic recompliation (dynarec), a just-in-time (JIT) compiler, provides a large speed advantage. There is a common backend but some architectures have more optimizations than others. Here are the top optimized platforms:

-  Box64

   1.  Arm
   2.  RISC-V
   3.  LoongArch

-  Box86

  1.  Arm

These platforms do not have dynarec support yet:

-  Box64 and Box86

   -  x86
   -  PowerPC

Box64 and Box86 will attempt to load libraries in the following order:

1.  **Native or wrapped library** = Box has some built-in libraries that are wrapped either for accuracy, compatibility, and/or performance reasons. Most functions use a simple wrapping. Other functions that have callbacks or other unique requirements need more code to do advanced wrapping. [5] Here are a list of wrapped libraries for each project:

   -  `Box64 <https://github.com/ptitSeb/box64/blob/main/src/library_list.h>`__
   -  `Box32 <https://github.com/ptitSeb/box64/blob/main/src/library_list_32.h>`__ = There are less libraries wrapped for Box32 because it is newer and more complex to do wrapping.
   -  `Box86 <https://github.com/ptitSeb/box86/blob/master/src/library_list.h>`__

2.  **Emulated library** = If a library is not wrapped, Box will attempt to use the non-native library files. Box64 requires x86_64 library files. Box32 and Box86 require x86_32 library files. Use the environment variable ``BOX64_LD_LIBRARY_PATH`` (recommended) or ``LD_LIBRARY_PATH`` to configure the path to those files. Box64 provides a few of these libraries by default from Debian.

Installation
~~~~~~~~~~~~

Prepare the source code.

.. code-block:: sh

   $ git clone https://github.com/ptitSeb/box64
   $ cd box64
   $ mkdir build
   $ cd build

Configure build options.

-  x86_64 [3]:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D LD80BITS=1 -D NOALIGN=1"

-  Apple Silicon (Asahi Linux) with 16K page size:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D M1=1 -D ARM_DYNAREC=ON"

-  Qualcomm Snapdragon X Elite:

   -  GCC 14 and newer:

      .. code-block:: sh

         $ export BOX64_BUILD_OPTS="-D SDORYON1=1 -D CMAKE_C_COMPILER=gcc -D ARM_DYNAREC=ON"

   -  GCC 13 and older:

      .. code-block:: sh

         $ export BOX64_BUILD_OPTS="-D SD8G2=1 -D CMAKE_C_COMPILER=gcc -D ARM_DYNAREC=ON"

-  Raspberry Pi 5:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D RPI5ARM64=1 -D ARM_DYNAREC=ON"

-  Termux PRoot:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D ARM64=1 -D CMAKE_C_COMPILER=gcc -D BAD_SIGNAL=ON -D ARM_DYNAREC=ON"

-  Windows Subsystem for Linux (WSL) 2:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D ARM64=1 -D CMAKE_C_COMPILER=gcc -D ARM_DYNAREC=ON"

Build Box64. Optionally build it with Box32 support.

.. code-block:: sh

   $ cmake .. ${BOX64_BUILD_OPTS[*]} -D CMAKE_BUILD_TYPE=RelWithDebInfo
   $ make -j $(nproc)

.. code-block:: sh

   $ cmake .. ${BOX64_BUILD_OPTS[*]} -D BOX32=1 -D BOX32_BINFMT=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo
   $ make -j $(nproc)

Install Box64. [2]

.. code-block:: sh

   $ sudo make install
   $ sudo systemctl restart systemd-binfmt

For new builds, uninstall and delete the old build first.

.. code-block:: sh

   $ sudo make uninstall
   $ cd ..
   $ rm -r -f build

If FEX is installed, it will conflict with Box64 and Box86 for running x86_64 and x86_32 applications. Remove those entries.

.. code-block:: sh

   $ sudo mkdir /root/usr-lib-binfmt.d/
   $ sudo mkdir /root/usr-share-binfmts/
   $ sudo mkdir /root/var-lib-binfmts/
   $ sudo mv /usr/lib/binfmt.d/FEX* /root/usr-lib-binfmt.d/
   $ sudo mv /usr/share/binfmts/FEX* /root/usr-share-binfmts/
   $ sudo mv /var/lib/binfmts/FEX* /root/var-lib-binfmts/
   $ sudo systemctl restart systemd-binfmt

Usage
~~~~~

The ``systemd-binfmt`` service automatically detects the CPU architecture of a binary and will have it run using the related emulator. Alternatively, a user can manually run the command ``box64`` and then provide the binary or path to the executable to emulate.

Bash is installed by default but another binary can be specified. [4]

.. code-block:: sh

   $ export BOX64_BASH=/usr/local/bin/bash-x86_64

Configure custom library paths to use non-native libraries that will be emulated.

.. code-block:: sh

   $ export BOX64_LD_LIBRARY_PATH="/usr/local/lib-x86_64:/usr/local/lib-x86_32"

Configure a custom path for looking up binaries.

.. code-block:: sh

   $ export BOX64_PATH="/usr/local/bin-x86_64"

Steam
~~~~~

Steam is a hybrid application that uses both x86_64 and x86_32 libraries on Linux. Most legacy games are also only 32-bit. Both Box64 and Box86 need to be installed for Steam to work. It currently does not work with Box32.

Install Steam using the script that Box64 provides. This is similar to the manual steps that FEX recommends.

.. code-block:: sh

   $ git clone https://github.com/ptitSeb/box64
   $ cd box64
   $ ./install_steam.sh

Verify that Steam works with Box. [8]

.. code-block:: sh

   $ steam

Troubleshooting
~~~~~~~~~~~~~~~

Error:

::

   Error loading needed lib <LIBRARY_FILE>

::

   Error loading needed lib libcurl.so

Solutions:

-  Box does not wrap the library and it is missing a required library file.

   1.  Use a package manager to see what package needs to be installed if a library is missing.

      -  Arch Linux

         .. code-block:: sh

            $ sudo pacman -F -y
            $ sudo pacman -F <LIBRARY_FILE>
            $ sudo pacman -S -y
            $ sudo pacman -S <LIBRARY_PACKAGE>

      -  Debian

         .. code-block:: sh

            $ sudo apt-file update
            $ sudo apt-file search <LIBRARY_FILE>
            $ sudo apt-get update
            $ sudo apt-get install <LIBRARY_PACKAGE>

      -  Fedora

         .. code-block:: sh

            $ sudo dnf provides <LIBRARY_FILE>
            $ sudo dnf install <LIBRARY_PACKAGE>

   2.  Use non-native library files. Use the environment variable ``BOX64_LD_LIBRARY_PATH`` to configure the path to those files.

----

Error:

::

   Error: PltResolver: Symbol  <FUNCTION>(ver 1: <FUNCTION>) not found, cannot apply R_X86_64_JUMP_SLOT <HEXADECIMAL> (<HEXADECIMAL>) in <LIBRARY_FILE>

::

   Error: PltResolver: Symbol  gtk_key_snooper_install(ver 1: gtk_key_snooper_install) not found, cannot apply R_X86_64_JUMP_SLOT 0x84e088 (0x414116) in /usr/share/wattconfig-eco/wattconfigecolaz (local_maplib=(nil), global maplib=0x5c8511c0, deepbind=0)

Solution:

-  Open a `GitHub Issue <https://github.com/ptitSeb/box64/issues/new>`__ with Box64 to wrap the x86_64 function.

----

Error:

::

   Error: PltResolver32: Symbol  <FUNCTION>(ver 1: <FUNCTION>) not found, cannot apply R_386_JUMP_SLOT <HEXADECIMAL> (<HEXADECIMAL>) in <LIBRARY_FILE>

::

   Error: PltResolver32: Symbol  SDL_LoadObject(ver 0: SDL_LoadObject) not found, cannot apply R_386_JUMP_SLOT 0x40016090 (0x40001866) in /home/user/GOG Games/PixelJunk Shooter/game/l32bin/libSDL2_image-2.0.so.0

Solution:

-  Open a `GitHub Issue <https://github.com/ptitSeb/box64/issues/new>`__ with Box64 to wrap the x86_32 function for Box32.

FEX
---

Introduction
~~~~~~~~~~~~

Supported hardware:

-  Arm 64-bit

FEX emulates both x86_64 and x86_32. Arm 32-bit systems are not supported. [1]

Installation
~~~~~~~~~~~~

-  Arch Linux

   .. code-block:: sh

      $ yay -S fex-emu

-  Ubuntu >= 22.04

   .. code-block:: sh

      $ sudo apt install curl squashfs-tools
      $ curl --silent https://raw.githubusercontent.com/FEX-Emu/FEX/main/Scripts/InstallFEX.py --output /tmp/InstallFEX.py && python3 /tmp/InstallFEX.py && rm /tmp/InstallFEX.py

Run FEX-Emu at least once to download a required x86_64 root file system. It is about 1 GiB in size and will be installed to ``${HOME}/.fex-emu/RootFS/<OS_NAME>_<OS_VERSION>.sqsh``. Select the operating system that is most similar to one being used. When asked to extract it or to use the SquashFS image as-is, select to extract as it is more likely to work. [7]

.. code-block:: sh

   $ FEXInterpreter /usr/bin/uname -a

::

   RootFS not found. Running FEXRootFSFetcher to get rootfs
   RootFS not found. Do you want to try and download one?
   Response {y,yes,1} or {n,no,0}
   y
   RootFS list selection
   Options:
   	0: Cancel
   	1: Fedora 40 (SquashFS)
   	2: Fedora 38 (SquashFS)
   	3: ArchLinux (SquashFS)
   	4: Ubuntu 24.04 (SquashFS)
   	5: Ubuntu 23.10 (SquashFS)
   	6: Ubuntu 23.04 (SquashFS)
   	7: Ubuntu 22.10 (SquashFS)
   	8: Ubuntu 22.04 (SquashFS)
   	9: Ubuntu 20.04 (SquashFS)
   	
     Response {1-9} or 0 to cancel

::

   Do you wish to extract the squashfs file or use it as-is?
   Options:
   	0: Cancel
   	1: Extract
   	2: As-Is
   
   Response {1-2} or 0 to cancel
   1

If Box64 and/or Box86 is installed, it will conflict with FEX for running x86_64 and x86_32 applications. Remove those entries. [7]

.. code-block:: sh

   $ sudo mkdir /root/etc-binfmt.d/
   $ sudo mv /etc/binfmt.d/box* /root/etc-binfmt.d/
   $ sudo systemctl restart systemd-binfmt

Steam
~~~~~

Disable mandatory access control on Linux first. Otherwise, Steam will run into a permission issue when starting bubblewrap which is required for it to work.

   ::

      bwrap: setting up uid map: Permission denied

   -  Debian = turn off AppArmor. Stopping the service is not enough.

      .. code-block:: sh

         $ sudo -E ${EDITOR} /etc/default/grub
         GRUB_CMDLINE_LINUX_DEFAULT="quiet splash apparmor=0"
         $ sudo grub-mkconfig -o /boot/grub/grub.cfg

   -  Fedora = set SELinux to permissive mode.

      .. code-block:: sh

         $ sudo setenforce 0

Download and extract the official DEB package used for Steam. All other packages are simply repackaged variants of this.

.. code-block:: sh

   $ mkdir "${HOME}/steam-x86"
   $ cd "${HOME}/steam-x86"
   $ wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
   $ ar x steam.deb
   $ tar --verbose --extract --file data.tar.*

Steam uses a Bash script as a wrapper for launching Steam. Configure the environment variables to avoid broken checks in the script so it can be used to launch Steam successfully. [8]

.. code-block:: sh

   $ export STEAMOS=1
   $ export STEAM_RUNTIME=1
   $ export DBUS_FATAL_WARNINGS=0

Verify that Steam works with FEX.

.. code-block:: sh

   $ FEXBash ./usr/bin/steam

It is common for ``steamwebhelper`` to crash. If this happens, remove these libraries from the Steam runtime. [9]

.. code-block:: sh

   $ rm -f \
     ~/.local/share/Steam/ubuntu12_32/steam-runtime/lib/x86_64-linux-gnu/libz.so* \
     ~/.local/share/Steam/ubuntu12_32/steam-runtime/lib/x86_64-linux-gnu/libfreetype.so.6* \
     ~/.local/share/Steam/ubuntu12_32/steam-runtime/lib/x86_64-linux-gnu/libfontconfig.so.1* \
     ~/.local/share/Steam/ubuntu12_32/steam-runtime/lib/x86_64-linux-gnu/libdbus-1.so*

Bibliography
------------

1. "Box86 / Box64." Box86 / Box64. Accessed October 16, 2024. https://box86.org/
2. "Compiling/Installing." GitHub pitSeb/box64. August 26, 2024. Accessed October 16, 2024. https://github.com/ptitSeb/box64/blob/main/docs/COMPILE.md
3. "box64-git.git." AUR Package Repositories. January 8, 2024. Accessed October 16, 2024. https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=box64-git
4. "Running Bash with Box86 & Box64." Box86 / Box64. September 13, 2022. Accessed October 17, 2024. https://box86.org/2022/09/running-bash-with-box86-box64/
5. "A deep dive into library wrapping." Box86 / Box64. August 22, 2021. Accessed October 21, 2024. https://box86.org/2021/08/a-deep-dive-into-library-wrapping/
6. "FEX - Fast x86 emulation frontend." GitHub FEX-Emu/FEX. October 29, 2024. Accessed October 29, 2024. https://github.com/FEX-Emu/FEX
7. "Steam in FEX." postmarketOS Wiki. October 25, 2024. Accessed October 29, 2024. https://wiki.postmarketos.org/wiki/Steam_in_FEX
8. "box86." GitHub ptitSeb/box86. October 29, 2024. Accessed October 29, 2024. https://github.com/ptitSeb/box86
9. "Steam." FEX-Emu Wiki. July 7, 2023. Accessed October 29, 2024. https://wiki.fex-emu.com/index.php/Steam
