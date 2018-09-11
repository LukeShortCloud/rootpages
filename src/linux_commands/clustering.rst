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

`Errata <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/clustering.rst>`__
----------------------------------------------------------------------------------------------------

Bibliography
------------

-  IPVS

   -  ipvsadm

      -  http://kaivanov.blogspot.com/2013/01/building-load-balancer-with-lvs-linux.html
      -  https://www.server-world.info/en/note?os=CentOS_6&p=lvs
