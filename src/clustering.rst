Clustering and High Availability
================================

.. contents:: Table of Contents

Introduction
------------

Clustering is the concept of using a load balancer to distribute
connections to multiple destinations. Three of the most common load
balancing methods used in clustering are:

-  Round robin = Send each request to the next server in the pool.
-  Least connections = Send requests to the server with the least amount
   of connections.
-  Source IP = Send requests from a source to the same destination
   server.

Ideally, high availability of services should also be of high importance
to keep services working 100% of the time. [1]

IP Virtual Server
-----------------

The IP Virtual Server (IPVS) service utilizes the Linux kernel directly
for load balancing. It is designed to be a simple load balancer for
internal/private networks. [2]

The only prerequisite for IPVS is that it requires the Linux system to
be configured as a router (masquerading). This is an example of using
the internal network 10.0.0.0/24 on the interface eth1 and forward
requests to/from the public interface eth0.

.. code-block:: sh

    $ sudo iptables -F
    $ sudo iptables -t nat -F
    $ sudo iptables -P INPUT ACCEPT
    $ sudo iptables -P OUTPUT ACCEPT
    $ sudo iptables -P FORWARD ACCEPT
    $ sudo iptables -A FORWARD -i eth1 -s 10.0.0.0/255.255.255.0 -j ACCEPT
    $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

IPVS is easily managed via the "ipvsadm" command.

-  View the current configuration.

   ::

       $ sudo ipvsadm -l

-  View more verbose information about current connections. [3]

   ::

       $ sudo ipvsadm -l -n --stats

-  Define the public IP address of the IPVS server (ex., 192.168.1.10),
   port (ex., :80 for HTTP), and then the type of load balancing (ex.,
   "rr").

   ::

       $ sudo ipvsadm -A -t <BALANCERIP>:<PORT> -s <SCHEDULER>

   ::

       $ sudo ipvsadm -A -t 192.168.1.10:80 -s rr

   -  Types of clustering schedulers for "-s":

      -  rr = Round robin.
      -  lc = Least connections.
      -  sh = Source hash (source IP address).

-  Add a back-end server (-a), serving TCP connections (-t), using the
   specified public balancer IP and port, sending requests to the real
   back-end server's IP address (-r), and masquerade/NAT the requests
   (-m).

   ::

       $ sudo ipvsadm -a -t <BALANCERIP>:<PORT> -r <DESTINATIONIP> -m

   ::

       $ sudo ipvsadm -a -t 192.168.1.10:80 -r 10.0.0.11 -m
       $ sudo ipvsadm -a -t 192.168.1.10:80 -r 10.0.0.12 -m

-  The configuration rules are automatically saved, but they can viewed
   in standard output. These rules can then be migrated or restored to
   an IPVS server.

   ::

       $ sudo ipvsadm {-S|--save}

   ::

       $ sudo ipvsadm {-R|--restore}

-  The entire configuration can be cleared at any time. [2]

   ::

       $ sudo ipvsadm {-C|--clear}

`Errata <https://github.com/ekultails/rootpages/commits/master/src/clustering.rst>`__
-------------------------------------------------------------------------------------

Bibliography
------------

1. "Nginx Load Balancing." Nginx. Accessed July 9, 2016. https://www.nginx.com/resources/admin-guide/load-balancer/
2. "LVS-mini-HOWTO." Austintek. March, 2012. Accessed July 9, 2016. http://www.austintek.com/LVS/LVS-HOWTO/mini-HOWTO/LVS-mini-HOWTO.html
3. "Building a Load Balancer with LVS - Linux Virtual Server." Linux Admins. January, 2013. Accessed July 9, 2016. http://www.linux-admins.net/2013/01/building-load-balancer-with-lvs-linux.html
