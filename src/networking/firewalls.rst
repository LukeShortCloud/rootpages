Firewalls
=========

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

Uncomplicated Firewall (UFW)
----------------------------

UFW is designed to be easy to use and it is the default firewall for Debian.

-  Quick start. For getting started, it is recommended to set the default rules to allow outgoing traffic and deny incoming traffic. Be sure to keep the SSH port 22 open if necessary.

   .. code-block:: sh

      $ sudo systemctl enable --now ufw
      $ sudo ufw default allow outgoing
      $ sudo ufw default deny incoming
      $ sudo ufw allow 22
      $ sudo ufw show added
      $ sudo ufw enable
      $ sudo ufw status verbose

-  View the status and rules that are enabled.

   .. code-block:: sh

      $ sudo ufw status
      $ sudo ufw status numbered

-  View the status including the logging level, default rules, and profiles.

   .. code-block:: sh

      $ sudo ufw status verbose

-  View all of the rules including ones which are not enabled yet.

   .. code-block:: sh

      $ sudo ufw show added

-  Enable the firewall rules.

   .. code-block:: sh

      $ sudo ufw enable

   -  If another firewall on the system is enabled, such as Firewalld, UFW will refuse to start on boot and remain in an "inactive" state. Ensure that all other firewalls are disabled. [4]

      .. code-block:: sh

         $ sudo systemctl disable firewalld

-  Disable the firewall rules.

   .. code-block:: sh

      $ sudo ufw disable

-  Configure default rules.

   .. code-block:: sh

      $ sudo ufw default [allow|deny] [incoming|outgoing]

-  Open a port (for both TCP and UDP and both IPv4 and IPv6).

   .. code-block:: sh

      $ sudo ufw allow <PORT>

-  Open a port using a specific protocol.

   .. code-block:: sh

      $ sudo ufw allow <PORT>/tcp
      $ sudo ufw allow <PORT>/udp

-  Open a port for IPv4 or IPv6 only. [3]

   .. code-block:: sh

      $ sudo ufw allow proto <PROTOCOL> to 0.0.0.0/0 port <PORT>
      $ sudo ufw allow proto <PROTOCOL> to ::/0 port <PORT>

-  Open a range of ports.

   .. code-block:: sh

      $ sudo ufw allow <PORT_RANGE_START>:<PORT_RANGE_END>

-  Open a port for a specific IP address or CIDR range.

   .. code-block:: sh

      $ sudo ufw allow from <IP_ADDRESS> to any port <PORT> proto <PROTOCOL>
      $ sudo ufw allow from <IP_ADDRESS>/<CIDR> to any port <PORT> proto <PROTOCOL>

-  Block a port.

   .. code-block:: sh

      $ sudo ufw deny <PORT>

-  Delete a rule by using the arguments to add the rule.

   -  Syntax:

      .. code-block:: sh

         $ sudo ufw delete <RULE_ARGUMENTS>

   -  Example:

      .. code-block:: sh

         $ sudo ufw allow 80
         $ sudo ufw delete allow 80

-  Delete a rule by using a number from ``ufw status numbered``.

   .. code-block:: sh

      $ sudo ufw delete <RULE_NUMBER>

-  Reset the rules.

   .. code-block:: sh

      $ sudo ufw reset

[2]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/networking/firewalls.rst>`__

Bibliography
------------

1. "How to install Fail2Ban on CentOS 7." HowtoForge. Accessed June 10, 2018. https://www.howtoforge.com/tutorial/how-to-install-fail2ban-on-centos/
2. "Uncomplicated Firewall (ufw)." Debian Wiki. October 15, 2021. Accessed October 19, 2021.
3. "How do I use ufw to open ports on ipv4 only?" Server Fault. September 24, 2020. Accessed October 19, 2021. https://serverfault.com/questions/809643/how-do-i-use-ufw-to-open-ports-on-ipv4-only
4. "How can I enable ufw automatically on boot?" Stack Exchange Network - Unix & Linux. September 12, 2021. Accessed October 20, 2021. https://unix.stackexchange.com/questions/182959/how-can-i-enable-ufw-automatically-on-boot
