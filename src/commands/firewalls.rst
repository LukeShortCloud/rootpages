Firewalls
=========

.. contents:: Table of Contents

See also: Networking, Security

iptables
--------

iptables
~~~~~~~~

Package: iptables-services

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "-L", "list firewall rules", ""
   "-L <CHAIN>", "list firewall rules for a specific chain name", ""
   "-F", "remove all firewall rules", ""
   "-i", "specify an interface", ""
   "-A {INPUT|OUTPUT}", "append to this chain", ""
   "-t, --table {filter|nat|mangle|raw|security}", "edit a specific table", ""
   "-p {tcp|udp|any}", "the protocol to manipulate", ""
   "{--dport|--sport}", "destination or source port", ""
   "{-d|-s}", "destination or source IP", ""
   "-j {ACCEPT|DENY|REJECT|DROP}", "action for any matches"
   "!", "exclude options", "! -s 192.168.0.0/24"
   "-m state --state {NEW|ESTABLISHED|RELATED|INVALID}", "allow new, established, related, and/or invalid packets", ""

iptables (example)
~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "-A OUTPUT", "append the output rules...", ""
   "-p tcp", "...using the tcp protocol...", ""
   "--dport 80", "...to the destination port 80", ""
   "-j ACCEPT", "...and accept the connection.", ""

Example of setting up a network address translation for all connections from eth1 and forward requests to/from eth0.

.. code-block:: sh

   # Append to the POSTROUTING chain to allow NAT/masquerad'ing on the output interface eth0
   $ iptables -t nat -A POSTROUTING -o eth0 -j MAS
   # Append the FORWARD chain to allow requests from eth1 to eth0
   $ iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
   # Allow return requests back from eth1 to eth0 that are related to the outgoing packets
   $ iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables --policy
~~~~~~~~~~~~~~~~~

Modify the default policy for the firewall.

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "{INPUT|OUTPUT|FORWARD}", "", ""
   "{ACCEPT|REJECT|DROP}", "", ""

iptables-save
~~~~~~~~~~~~~

Save the iptables rules.

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "iptables-save > /etc/sysconfig/iptables", "save the iptables rules on RHEL/Fedora", ""

Firewalld
---------

The default firewall for RHEL >= 7.

firewall-cmd
~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "--get-default-zone", "shows the default loaded zone", ""
   "--get-active-zones", "shows loaded zone profiles", ""
   "--get-services", "show valid services", ""
   "--list-services", "show allowed services", ""
   "--list-rich-rules", "show the defined rich rules", ""
   "--add-service=<SERVICE>", "allow a service", ""
   "--add-source=<IP>", "allow an IP or CIDR range through the firewall", ""
   "--zone=<ZONE>", "modify a specified firewalld zone", ""
   "--list-all", "show the open ports", ""
   "--add-port=<PORT>/{tcp|udp} --permanent", "open a port, requires a reloading firewalld", ""
   "--add-masquerade", "enable IP and port forwarding", ""
   "--reload", "activate any permanent changes", ""

firewall-cmd --add-rich-rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add more complicated firewalld rules that are similar in syntax to iptables.

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "firewall-cmd --add-rich-rule='<RULE>'", "add a new rule within single quotes", ""
   "rule family=""ipv[4|6]""", "start a new using IPv4 or IPv6...", ""
   "[source|destination][address|port]", "...using a source/destination address/port...", ""
   "[accept|reject|drop]", "...accept the connection, reject the connection with a message, or do not do anything with the packet.", ""
   "rule family=""ipv4"" source address=""<IPADDRESS>"" accept", "allow an IP address", ""

firewall-config
~~~~~~~~~~~~~~~

A GUI for managing the firewalld configuration.

Uncomplicated Firewall
----------------------

This is the default Ubuntu firewall.

ufw
~~~

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "status", "shows loaded rules", ""
   "enable", "start ufw", ""
   "disable", "stop ufw", ""
   "allow <PORT>", "allow all UDP and TCP connections to a port", ""
   "allow <PORT>/<PROTOCOL>", "allow only specific protocols on a port", ""
   "deny <PORT>", "deny all traffic to this port", ""
   "--dry-run", "do not make changes; only show what iptables rules will be made", ""

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/commands/firewalls.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/firewalls.rst>`__
