Firewalls
========

.. contents:: Table of Contents

Fail2Ban
--------

Fail2Ban uses regular expression to search log files to failed login attempts to various services. Those filters are created for common services such as ``sshd``. They can be configured in "jail" sections that define what additional settings to use with that filter.

After installation, the main configuration file for enabled filters and bans should be copied to a local file. This file will override the main configuration. Additional configurations can also be stored in ``/etc/fail2ban/jail.d/``.

.. code-block:: sh

    $ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

Common options:

-  DEFAULT

   -  bantime = The amount of time, in seconds, an IP address should be banned.
   -  findtime = The amount of time, in seconds, for which the maxretry checks for failures.
   -  ignoreip = This is a list of IP addresses and/or CIDR ranges that are whitelisted. Fail2Ban will not block these addresses.
   -  maxretry = The number of times a failure is detected before banning the address.

Each jail section in the configuration file manages a different filter. The values from the ``DEFAULT`` section can be overridden for individual jails. Set ``enabled = true`` in each filter that is desired to be enabled.

::

    [sshd]
    enabled = true

Enable and start the service.

.. code-block:: sh

    $ sudo systemctl enable --now fail2ban

View Fail2Ban's status and which jail filters are enabled.

.. code-block:: sh

    $ fail2ban-client status

Unblock a legitimate IP address:

.. code-block:: sh

    $ sudo fail2ban-client set sshd unbanip <IP_ADDRESS>

[1]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/networking/firewalls.rst>`__

Bibliography
------------

1. "How to install Fail2Ban on CentOS 7." HowtoForge. Accessed June 10, 2018. https://www.howtoforge.com/tutorial/how-to-install-fail2ban-on-centos/
