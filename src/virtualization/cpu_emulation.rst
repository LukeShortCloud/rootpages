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

         $ export BOX64_BUILD_OPTS="-D SDORYON1 -D CMAKE_C_COMPILER=gcc -D ARM_DYNAREC=ON"

   -  GCC 13 and older:

      .. code-block:: sh

         $ export BOX64_BUILD_OPTS="-D SD8G2 -D CMAKE_C_COMPILER=gcc -D ARM_DYNAREC=ON"

-  Raspberry Pi 5:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D RPI5ARM64=1 -D ARM_DYNAREC=ON"

-  Termux PRoot:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D ARM64=1 -D CMAKE_C_COMPILER=gcc -D BAD_SIGNAL=ON -D ARM_DYNAREC=ON"

-  Windows Subsystem for Linux (WSL) 2:

   .. code-block:: sh

      $ export BOX64_BUILD_OPTS="-D ARM64=1 -D CMAKE_C_COMPILER=gcc -D ARM_DYNAREC=ON"

Build Box64 with Box32 support.

.. code-block:: sh

   $ cmake .. ${BOX64_BUILD_OPTS[*]} -D BOX32=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo
   $ make -j $(nproc)

Install Box64. [2]

.. code-block:: sh

   $ sudo make install
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

Bibliography
------------

1. "Box86 / Box64." Box86 / Box64. Accessed October 16, 2024. https://box86.org/
2. "Compiling/Installing." GitHub pitSeb/box64. August 26, 2024. Accessed October 16, 2024. https://github.com/ptitSeb/box64/blob/main/docs/COMPILE.md
3. "box64-git.git." AUR Package Repositories. January 8, 2024. Accessed October 16, 2024. https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=box64-git
4. "Running Bash with Box86 & Box64." Box86 / Box64. September 13, 2022. Accessed October 17, 2024. https://box86.org/2022/09/running-bash-with-box86-box64/
5. "A deep dive into library wrapping." Box86 / Box64. August 22, 2021. Accessed October 21, 2024. https://box86.org/2021/08/a-deep-dive-into-library-wrapping/
