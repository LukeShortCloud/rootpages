SteamOS 3
=========

.. contents:: Table of Contents

Desktop Mode
------------

Default User Account
~~~~~~~~~~~~~~~~~~~~

By default, on the Steam Deck, the user and group ``deck`` (UID and GID ``1000``) is used. It is also part of the ``wheel`` group (GID ``998``) which provides it access to running commands as the ``root`` user with the ``sudo`` command.

There is no password by default. For running ``sudo`` commands, a password needs to be set.

-  GUI: System Settings > Personalization > Users > Your Account > Steam Deck User > Change Password
-  CLI:

   .. code-block:: sh

      $ passwd

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/steamos.rst>`__

Bibliography
------------
