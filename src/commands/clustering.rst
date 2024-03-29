Clustering
==========

.. contents:: Table of Contents

See also: Administrative, Firewalls, Networking

IPVS
----

Linux Virtual Server provides a way to load balance TCP and UDP connections.

ipvsadm
~~~~~~~

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "-A", "add a load balancer", ""
   "-a", "add a node to distribute connections", ""
   "-t <IP>", "TCP service", ""
   "-u <IP>", "UDP service", ""
   "-s {rr|lc|dh}", "set the scheduling method (i.e. round robin, least connections or destination IP/hash)", ""
   "-l", "list the current configuration", ""
   "-S, --save", "print the configuration to stdout", ""
   "-R, --restore", "restore the configuration from a file", ""
   "-C", "clear the current configuration", ""

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/commands/clustering.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_commands/clustering.rst>`__
