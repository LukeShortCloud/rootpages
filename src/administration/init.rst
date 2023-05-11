init
=====

.. contents:: Table of Contents

Introduction
------------

init is the first process started by the Linux kernel once booted. It has the process ID (PID) of 1. This init process is in charge of starting services on boot and shutting them down when turning the computer off. systemd is the preferred init system of modern Linux distributions that has succeeded SysVinit. [1][2]

systemd
-------

File Locations
~~~~~~~~~~~~~~

systemd unit files can be created and used in any of these locations [3]:

-  ``/usr/lib/systemd/system/`` = Global systemd unit files installed by the system package manager.
-  ``/run/systemd/system/`` = Unit files that were created automatically by a program.
-  ``/etc/systemd/system/`` = User-created unit files. These override all other locations if a unit file exists with the same name.
-  ``~/.config/systemd/user/`` = User-created unit files that are managed locally by a user. These services only run while the user is logged in. These are managed with the command ``systemctl --user`` instead of the typical ``systemctl`` command.

When adding new unit files, it is required to run this command to update the systemd cache about available unit files [4]:

.. code-block:: sh

   $ sudo systemctl daemon-reload

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/init.rst>`__

Bibliography
------------

1. "What is an init system?" Fedora Magazine. October 31, 2015. Accessed May 11, 2023. https://fedoramagazine.org/what-is-an-init-system/
2. "init." ArchWiki. March 12, 2023. Accessed May 11, 2023. https://wiki.archlinux.org/title/init
3. "Understanding Systemd Units and Unit Files." DigitalOcean Tutorials. February 17, 2015. Accessed May 11, 2023. https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
4. "Where do I put my systemd unit file?" Unix & Linux Stack Exchange. March 10, 2023. Accessed May 11, 2023. https://unix.stackexchange.com/questions/224992/where-do-i-put-my-systemd-unit-file
