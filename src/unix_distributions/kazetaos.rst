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

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/kazetaos.rst>`__

Bibliography
------------

1. "Connect to network automatically if ethernet cable is connected." GitHub kazetaos/kazeta. January 11, 2026. Accessed February 16, 2026. https://github.com/kazetaos/kazeta/commit/1dc334c0d0066114b73f42f760fe42b22d028c11
2. "Technical Details." GitHub kazetaos/kazeta. August 20, 2025. Accessed Feburary 16, 2026. https://github.com/kazetaos/kazeta/wiki/Technical-Details
3. "Development." GitHub ChimeraOS/chimeraos. August 5, 2024. Accessed February 16, 2026. https://github.com/ChimeraOS/chimeraos/wiki/Development
4. "Releases." GitHub kazetaos/kazeta. January 13, 2026. Accessed February 16, 2026. https://github.com/kazetaos/kazeta/releases
