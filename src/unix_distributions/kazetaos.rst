KazetaOS
========

.. contents:: Table of Contents

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

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/kazetaos.rst>`__

Bibliography
------------

1. "Connect to network automatically if ethernet cable is connected." GitHub kazetaos/kazeta. January 11, 2026. Accessed February 16, 2026. https://github.com/kazetaos/kazeta/commit/1dc334c0d0066114b73f42f760fe42b22d028c11
