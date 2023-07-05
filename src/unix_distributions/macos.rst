macOS
=====

.. contents:: Table of Contents

Window Positioning
------------------

ShiftIt
~~~~~~~

`ShiftIt <https://github.com/fikovnik/ShiftIt>`__ is one of the few free window positioning/tiling software for macOS. Once started, it will appear in the menu bar. A drop list is provided of the default shortcuts.

Activate ShiftIt:

-  Mac: ``CONTROL`` + ``OPTION`` + ``COMMAND``
-  Windows: ``CTRL`` + ``ALT`` + ``WINDOWS``

Immediately after that, press additional keys for the desired usage:

-  ``1``, ``2``, ``3``, or ``4`` = Move a window to the desired quadrant.
-  ``UP_ARROW``, ``DOWN_ARROW``, ``LEFT_ARROW``, or ``RIGHT_ARROW`` = Move a window to align with the specified part of the screen.
-  ``p`` (previous) or ``n`` (next) = Move a window to the next monitor.
-  ``=`` or ``-`` = Increase or decrease the size of a window.
-  ``c`` = Center the window.
-  ``m`` = Maximize a window.
-  ``f`` - Fullscreen a window.

Rosetta
-------

Rosetta 1
~~~~~~~~~

Rosetta 1 was used to run PowerPC programs on Intel. It was provided in MacOS X 10.4 Tiger through 10.6 Snow Leopard. [3]

Rosetta 2
~~~~~~~~~

Rosetta 2 is used to run Intel programs on Arm. It was first added to macOS 11 Big Sur. [4] When an Intel program is executed, macOS will prompt the end-user to install Rosetta 2 if it is not installed already. [5]

Manually install Rosetta 2:

.. code-block:: sh

   $ softwareupdate --install-rosetta

Enter an Intel-compatible shell on the CLI [6]:

.. code-block:: sh

   $ arch-x86_64 zsh

Xcode
-----

Xcode Developer Tools is a suite of different utilities for doing development on macOS. It can be installed from the App Store.

Common utilities [1]:

-  Command Line Tools = awk, git, make, sed, ssh, svc, tar, zip, and more.
-  SwiftUI = A user interface designer for Swift programs.
-  Terminal 2 = An advanced Termanial app that supports more colors, additional tabs, and full Unicode support.
-  Xcode IDE = A custom IDE tailored for development of apps on Apple products.

Homebrew
--------

Homebrew is an unofficial package manager for macOS.

-  Install: ``/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"``
-  Search for a program to see if it can be installed: ``brew search <PACKAGE>``
-  Update cached repository metadata: ``brew update``
-  Install a CLI utility: ``brew install <APP>``
-  Install a GUI app: ``brew install --cask <APP>``
-  Upgrade a package: ``brew upgrade <PACKAGE>``
-  Upgrade all packages: ``brew upgrade``
-  View all programs, and their dependencies, installed by Homebrew: ``brew list``
-  View only the programs, not their dependencies, that were installed by Homebrew: ``brew leaves``

[2]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/macos.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/macs.rst>`__

Bibliography
------------

1. "Xcode - Features." Apple Developer. Accessed January 12, 2021. https://developer.apple.com/xcode/features/
2. "Homebrew The Missing Package Manager for macOS (or Linux)." Homebrew. Accessed January 13, 2021. https://brew.sh/
3. "ARCHIVED: In Mac OS X, how do I run PowerPC applications with Rosetta?" University Information Technology Services. January 18, 2018. Accessed July 5, 2023. https://kb.iu.edu/d/azjd
4. "Apple ARM Macs: What you need to know now." July 15, 2020. Accessed July 5, 2023. https://www.computerworld.com/article/3566912/apple-arm-macs-what-you-need-to-know-now.html
5. "If you need to install Rosetta on your Mac." Apple Support. June 26, 2023. Accessed July 5, 2023. https://support.apple.com/en-us/HT211861
6. "How to Install x86_64 Homebrew Packages on Apple M1 MacBook." Medium. July 26, 2021. Accessed July 5, 2023. https://medium.com/mkdir-awesome/how-to-install-x86-64-homebrew-packages-on-apple-m1-macbook-54ba295230f
