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

Creating a Unit File
~~~~~~~~~~~~~~~~~~~~

All unit files are ini configuration files that use this layout:

.. code-block:: ini

   [Unit]
   Description=<DESCRIPTION_ABOUT_UNIT>

   [<UNIT_TYPE>]
   <UNIT_CONFIG_KEY>=<UNIT_CONFIG_VALUE>

   [Install]
   WantedBy=<SYSTEMD_TARGET>

Configuration options for unit files:

-  Run a unit during a normal boot.

   .. code-block:: ini

      [Install]
      WantedBy=multi-user.target

-  Log standard output and/or standard error of a service to a file.

   .. code-block:: ini

      [Service]
      StandardOutput=<PATH_TO_FILE>
      StandardError=<PATH_TO_FILE>

-  Create a service that runs exactly once.

   .. code-block:: ini

      [Service]
      Type=oneshot
      ExecStart=<PATH_TO_EXECTUABLE>
      ExecStart=/bin/systemctl --no-reload disable %n

-  Run the unit file if the file or directory does not exist.

   .. code-block:: ini

      [Unit]
      ConditionPathExists=!<PATH_TO_FILE>

-  Do not timeout while starting a service.

   .. code-block:: ini

      [Service]
      TimeoutSec=infinity

-  Start a service after a specified amount of time.

   .. code-block:: ini

      [Service]
      ExecStartPre=/bin/sleep 0.5
      ExecStart=/usr/bin/foobar

-  Automatically restart a service if it fails. [5]

   .. code-block:: ini

      [Service]
      ExecStart=/usr/bin/foobar
      Restart=on-failure
      RestartSec=0.1s

-  Run two or more commands. systemd will run one command at a time starting from top to bottom.

   .. code-block:: ini

      [Service]
      Type=oneshot
      ExecStart=/bin/sh -c "echo foo"
      ExecStart=/bin/sh -c "echo bar"
      RemainAfterExit=yes
      TimeoutSec=0

-  Start a unit after the networking service is online. If there is no network interface on the computer, then systemd will consider the networking services to be online.

   .. code-block:: ini

      [Unit]
      After=network-online.target
      Wants=network-online.target

   -  Depending on the networking service used, enable it to wait to be online. [6]

      .. code-block:: sh

         $ sudo systemctl enable NetworkManager-wait-online.service

      .. code-block:: sh

         $ sudo systemctl enable systemd-networkd-wait-online.service

-  Configure environment variables in the systemd unit file or source them from an external file. [8]

   .. code-block:: ini

      [Service]
      Environment=foo=bar
      EnvironmentFile=/app/env

   .. code-block:: sh

      $ cat /app/env
      app_host=127.0.0.1
      app_address=80

Preset Files
~~~~~~~~~~~~

System packages can define if a unit should be enabled or disabled by default. [7]

-  Create a file called ``/usr/lib/systemd/system-preset/<UNIT>.<UNIT_TYPE>``.
-  Edit the file with the contents of ``enable <UNIT>.<UNIT_TYPE>`` or ``disable <UNIT.<UNIT_TYPE>``.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/init.rst>`__

Bibliography
------------

1. "What is an init system?" Fedora Magazine. October 31, 2015. Accessed May 11, 2023. https://fedoramagazine.org/what-is-an-init-system/
2. "init." ArchWiki. March 12, 2023. Accessed May 11, 2023. https://wiki.archlinux.org/title/init
3. "Understanding Systemd Units and Unit Files." DigitalOcean Tutorials. February 17, 2015. Accessed May 11, 2023. https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
4. "Where do I put my systemd unit file?" Unix & Linux Stack Exchange. March 10, 2023. Accessed May 11, 2023. https://unix.stackexchange.com/questions/224992/where-do-i-put-my-systemd-unit-file
5. "Auto-restart a crashed service in systemd." Mattias Geniar. January 13, 2020. Accessed May 11, 2023. https://ma.ttias.be/auto-restart-crashed-service-systemd/
6. "Network Configuration Synchronization Points." systemd.io. 2022. Accessed May 11, 2023. https://systemd.io/NETWORK_ONLINE/
7. "systemd.preset." systemd. Accessed May 16, 2023. https://www.freedesktop.org/software/systemd/man/systemd.preset.html
8. "Using environment variables in systemd units." Flatcar Container Linux. Accessed August 29, 2023. https://www.flatcar.org/docs/latest/setup/systemd/environment-variables/
