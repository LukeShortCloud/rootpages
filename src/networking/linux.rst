Linux Networking
================

.. contents:: Table of Contents

Generic
-------

The generic section will cover networking utilities that are platform
agnostic.

systemd
~~~~~~~

The systemd init suite provides both "systemd-networkd" and
systemd-resolved" to control networking devices. These services have
been included in systemd since version 210. [1]

All systemd network settings should be configured in the directory
"/etc/systemd/network/." Network files should have the ".network"
extension and NetDev files will use ".netdev." Common options are listed
below. [2][3]

Network Settings:

-  [Match] = Select the device to use.

   -  Name = The device name.
   -  MACAddress = The MAC address for the device.

-  [Network] = Network settings.

   -  DHCP = Use DHCP.

      -  yes, no, ipv4, or ipv6

   -  DHCPServer = Become a DHCP server.

      -  yes, no

   -  Address = The IP address to use on the interface.
   -  Gateway = The default gateway.
   -  DNS = A list of DNS servers.
   -  NTP = A list of NTP servers.
   -  IPForward = Allow IP addresses to be routed based on the netfilter
      routing table.

      -  yes, no, ipv4, ipv6

   -  IPMasquerade = Allow IPv4 addresses to be set up for source
      network address translation (SNAT).

      -  yes, no, ipv4

   -  Bond = The name of the bond interface to use.
   -  VLAN = The name of the VLAN interface to use.
   -  VXLAN = The name of the VXLAN interface to use.
   -  Tunnel = The name of the tunnel interface to use.

-  [Link]

   -  MACAddress = Override the MAC address with a custom address.
   -  MTUBytes = The MTU size for packets.

-  [DHCPServer] = Configure DHCP server settings.

   -  PoolOffset = The offset count (not including network or broadcast
      addresses) to start the IP allocation pool from.
   -  PoolSize = The number of IP addresses that can be allocated.
   -  DNS = A list of DNS servers to provide.
   -  EmitRouter = The default gateway to provide.
   -  NTP = The NTP server to provide.
   -  Timezone = The timezone to provide. [2]

NetDev settings:

-  [NetDev] = Virtual network devices.

   -  Name = Create a name for the device.
   -  MACAddress = Create a MAC address for the device. A randomly
      generated address will be created if this option is not specified.
   -  MTUBytes = The MTU size for packets.
   -  Kind = The type of virtual network device.

      -  bond = A combination of multiple NICs.
      -  bridge = Allow guests to have full passthrough access to the
         NIC.
      -  dummy = Drop all packets.
      -  gretap = GRE layer 2 tunnel.
      -  gre = GRE layer 3 tunnel.
      -  tap = Layer 2 tunnel.
      -  tun = Layer 3 tunnel.
      -  vlan = VLAN tagging.
      -  vxlan = VXLAN tunnel.

-  [Bond]

   -  Mode = The bond mode to use for clustering NICs.

      -  balance-rr
      -  active-backup
      -  balance-xor
      -  broadcast
      -  802.3ad
      -  balance-tlb
      -  balance-alb

-  [Tunnel] = Tunnel configurations

   -  Local = The static IP address that should already be configured on
      another NIC. This is used to connect to the remote tunnel IP
      address.
   -  Remote = The remote IP address to create a tunnel connection
      between.

-  [VLAN]

   -  Id = The VLAN ID.

-  [VLAN]

   -  Id = The VXLAN ID. [3]

Static networking syntax:

.. code-block:: ini

    [Match]
    name=<NIC>

    [Network]
    Address=<IP_ADDRESS>/<CIDR>
    Gateway=<GATEWAY_IP_ADDRESS>
    DNS=<DNS_SERVER_IP_ADDRESS>

Static networking example:

.. code-block:: ini

    [Match]
    name=eth0

    [Network]
    Address=192.168.1.10/24
    Address=10.0.0.2/30
    Gateway=192.168.1.1
    DNS=8.8.4.4

[2]

A Network configuration can be created for a WiFi interface. Using the
"wpa\_supplicant" service, the WiFi password can be securely saved in a
different file and will automatically be used by systemd-network.

WiFi syntax:

.. code-block:: sh

    $ sudo wpa_passphrase <SSID> <PASSWORD> > /etc/wpa_supplicant/wpa_supplicant-<NIC>.conf
    $ sudo systemctl enable wpa_supplicant@<NIC>.conf
    $ sudo systemctl start wpa_supplicant@<NIC>.conf

WiFi example:

.. code-block:: sh

    $ sudo wpa_passphrase Guest5G password123 > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
    $ sudo systemctl enable wpa_supplicant@wlan0.conf
    $ sudo systemctl start wpa_supplicant@wlan0.conf

[4]

Open vSwitch
~~~~~~~~~~~~

Bridging
^^^^^^^^

Any physical network interface can be turned into a bridge. This allows
multiple devices to be able to utilize the bridge for straight
connectivity to the physical network. In this example, ``eth0`` is
converted into the ``br0`` bridge.

Example:

.. code-block:: sh

    $ sudo ovs-vsctl add-br br0
    $ sudo ovs-vsctl add-port br0 eth0

Syntax:

.. code-block:: sh

    $ sudo ovs-vsctl add-br <NEW_BRIDGE>
    $ sudo ovs-vsctl add-port <NEW_BRIDGE> <PHYSICAL_INTERFACE>

It is possible to create multiple bridges from one physical interface.
This official example from the Open vSwitch documentation shows how to
use the physical interface ``eth0`` to create the virtual bridges
``br0`` and ``br1``. Patch ports are used to connect the tap interfaces.

Example:

.. code-block:: sh

    $ sudo ovs-vsctl add-br br0
    $ sudo ovs-vsctl add-port br0 eth0
    $ sudo ovs-vsctl add-port br0 tap0
    $ sudo ovs-vsctl add-br br1
    $ sudo ovs-vsctl add-port br1 tap1
    $ sudo ovs-vsctl \
           -- add-port br0 patch0 \
           -- set interface patch0 type=patch options:peer=patch1 \
           -- add-port br1 patch1 \
           -- set interface patch1 type=patch options:peer=patch0

Open vSwitch uses virtual ``tap`` interfaces to connect virtual machines
to a bridge instead of providing straight access to a bridge device.
This makes it easier to manage interfaces for many virtual machines and
it helps to isolate and track down traffic. Tools such as ``tcpdump``
can be used to analyze specific ``tap`` traffic. [5]

Example:

.. code-block:: sh

    $ sudo ovs-vsctl add-br br0
    $ sudo ovs-vsctl add-port br0 eth0
    $ sudo ovs-vsctl add-port br0 tap0
    $ sudo ovs-vsctl add-port br0 tap1
    $ sudo ovs-vsctl add-port br0 tap2

Syntax:

.. code-block:: sh

    $ sudo ovs-vsctl add-br <NEW_BRIDGE>
    $ sudo ovs-vsctl add-port <NEW_BRIDGE> <PHYSICAL_INTERFACE>
    $ sudo ovs-vsctl add-port <NEW_BRIDGE> <NEW_TAP_INTERFACE>

Operating System Specific
-------------------------

Debian
~~~~~~

The Debian network configuration file is located at
``/etc/networks/interfaces``. Run ``ifup`` or ``ifdown`` to add or
remove the IP address configurations for a particular interface

Static example:

File: /etc/network/interfaces

::

    auto eth0
    iface eth0 inet static
        address 192.168.1.11
        netmask 255.255.255.0
        gateway 192.168.1.1
        dns-nameservers 192.168.3.45 192.168.8.10
    iface eth0 inet static
        address 10.0.0.200
        netmask 255.255.0.0

.. code-block:: sh

    $ sudo ifup eth0

DHCP example:

File:  /etc/network/interfaces

::

    auto eth0
    iface eth0 inet dhcp

.. code-block:: sh

    $ sudo ifup eth0

Common:

-  auto ``<INTERFACE>`` = Start the interface on boot.
-  iface ``<INTERFACE>`` inet ``{static|dhcp}`` = Specify if the IP
   address should be static or dynamic. Define this again for every IP
   address that will be used.

   -  address = The IP address to add.
   -  netmask = The subnet mask for the IP address.
   -  gateway = The default gateway.
   -  dns-nameservers = A list of DNS resolvers to use, separated by a
      space.

[6]

RHEL
~~~~~

Red Hat Enterprise Linux uses their own "network" service. Although
Network Manager has started taking it's place, the network service is
less intrusive and better supported by most programs that rely on
managing network settings.

There are two udev modules that manage new device naming schemes:
"net.ifnames" and "biosdevname." Only "net.ifnames" is installed by
default on RHEL. Set these both to 0 in the kernel/boot options to
revert back to eth\* and wlan\* naming. Otherwise, devices will be named
based on their physical location and connection to the motherboard. [7]

Network configurations are saved in ``/etc/sysconfig/network-scripts/``.
The Ethernet device names start with "ifcfg-eth" when ifnames is
disabled or "ifcfg-e" if not.

Options:

-  {NAME\|DEVICE} = The name of the network interface. The first device
   is generally "eth0" for Ethernet or "wlan0" for wireless devices.
-  ONBOOT = {yes\|no}. Enable or disable this interface on startup of
   the system.
-  HWADDR = The MAC address of the device.
-  BOOTPROTO = The boot protocol to use for obtaining an IP address.

   -  {none\|static} = Static IP addressing. Do not use any protocol.
   -  dhcp = Dynamic IP addressing. Use DHCP to obtain IP addressing
      information.
   -  bootp = Dynamic IP addressing. Use BOOTP to obtain IP addressing
      information.

-  DHCP\_HOSTNAME = If a DHCP server requires a hostname, specify the
   hostname for the system.
-  DHCPV6C = {yes\|no}. Enable or disable the ability to obtain an IPv6
   address via DHCP.
-  DHCPV6C = Specify DHCP options for IPv6.

   -  -P = Prefix delegation.
   -  -S = Obtain a stateless address.
   -  -N = Revert to normal operation after using -P or -T.
   -  -T = Temporarily obtain an IPv6 address.
   -  -D = Specify a new value for the DHCP Unique Identifier (DUID).

-  IPV6\_AUTOCONF = {yes\|no}. Enable or disable autoconf configuration.
-  DNS{1,2} = The DNS nameservers to use for /etc/resolv.conf.
-  PEERDNS = {yes\|no}. Enable or disable the ability to get DNS
   information for /etc/resolv.conf from DHCP or IPCP.
-  ETHTOOL\_OPTS = Provide special ethtool options for the interface.
-  IPADDR = An IPv4 address. This option's name can have a number
   appended to it (starting at 0) to specify multiple IP addresses.
-  NETMASK = The IPv4 address's netmask.
-  PREFIX = Instead of specifying a netmask, the CIDR prefix can be
   used.
-  GATEWAY = The IPv4 default gateway to use. All IPv4 traffic will
   route out to this IP.
-  MTU = The size of packets to use, in bytes. The default is 1500 and
   the maximum is 9000.
-  IPV6INIT = {yes\|no}. Enable or disable IPv6 on this interface.
-  IPV6ADDR6 = An IPv6 address with it's CIDR prefix.
-  IPV6ADDR\_SECONDARIES = Other IPv6 addresses, comma separated, to add
   tot his interface.
-  IPV6\_PRIVACY=rfc3041 = Use the RFC 3041 standard to create a
   stateless IPv6 address using the interface's MAC address. By default,
   if this option is not defined, it is turned off for security
   concerns.
-  IP6MTU = The size of packets to use, in bytes.
-  MASTER = The master device for bonds.
-  BONDING\_OPTS = Additional bonding driver options.
-  HOTPLUG = Default: yes. Activate his device if it is hot plugged into
   the system.
-  LINKDELAY = The number of seconds to wait before loading up the
   network interface's configuration.
-  SRCADDR = The primary source address for outgoing traffic.
-  USERCTL = Enable or disable the ability to allow non-privileged users
   to manage the interface.
-  NM\_CONTROLLED = {yes\|no}. Enable or disable Network Manager control
   over this interface.

[8]

Routes
^^^^^^

In RHEL 7, static routes now use the ``iproute2`` syntax. A new
``route-<INTERFACE>`` file defines the route. Only one default
``GATEWAY`` can be set in the original ``ifcfg-`` configuration files.

Syntax:

.. code-block:: sh

    $ sudo vim /etc/sysconfig/network-scripts/route-<INTERFACE>
    <DESTINATION_NETWORK_CIDR> via <SOURCE_IP> dev <INTERFACE>

Example:

.. code-block:: sh

    $ sudo vim /etc/sysconfig/network-scripts/route-eth0
    192.168.100.0/24 via 10.0.0.1 dev eth0

[9][10]

Bridging
^^^^^^^^

A simple bridge using the Linux kernel can be configured using this
basic template. The physical network interface should reference a bridge
interface. The bridge interface will then contain the IP addressing
information.

File:  ``ifcfg-<NIC>``

::

    DEVICE="<NIC>"
    TYPE=Ethernet
    NM_CONTROLLED=no
    BRIDGE=<BRIDGE>

File: ``ifcfg-<BRIDGE>``

::

    DEVICE="<BRIDGE>"
    TYPE=Bridge
    ONBOOT=yes
    NM_CONTROLLED=no

[11]

Open vSwitch
^^^^^^^^^^^^

Various bridge configurations can be made. It is common to use a normal
bridge for allow virtual machines to have full access to the network or
use an Open vSwitch bridge for OpenStack's software defined networking
(SDN).

Open vSwitch bridge syntax (CLI):

.. code-block:: sh

    $ sudo ovs-vsctl add-port <OVS_BRIDGE> <NIC>
    $ sudo ovs-vsctl add-br <OVS_BRIDGE>

[12]

Open vSwitch bridge syntax (configuration file):

File:  ``ifcfg-<NIC>``

::

    DEVICE="<NIC>"
    TYPE="OVSPort"
    DEVICETYPE="ovs"
    OVS_BRIDGE="<OVS_BRIDGE>"

File: ``ifcfg-<OVS_BRIDGE>``

::

    DEVICE="<OVS_BRIDGE>"
    TYPE="OVSBridge"
    DEVICETYPE="ovs"

Open vSwitch bridge example (configuration file):

File: ifcfg-eth1

::

    DEVICE="eth1"
    TYPE="OVSPort"
    DEVICETYPE="ovs"
    OVS_BRIDGE="br0-ovs"
    BOOTPROTO="none"
    ONBOOT="yes"

File:  ifcfg-br0-ovs

::

    DEVICE="br0-ovs"
    TYPE="OVSBridge"
    DEVICETYPE="ovs"
    IPADDR0=10.10.10.201
    PREFIX0=24
    GATEWAY=10.10.10.1
    BOOTPROTO="none"
    ONBOOT="yes"

[13]

Bonding
^^^^^^^

Bonding allows for multiple devices to be used as a single virtual
device. The physical NICs need to be configured as bond slaves. Then a
new bond configuration can be created for the bond device.

Bond master syntax:

::

    DEVICE=<BOND_DEVICE>
    BONDING_MASTER=yes
    BONDING_OPTS="mode=<BONDING_MODE>"

Bond master example:

::

    DEVICE=bond0
    BONDING_MASTER=yes
    BONDING_OPTS="mode=balance-alb"

Bond slave syntax:

::

    MASTER=<BOND_DEVICE>
    SLAVE=yes

Bond slave example:

::

    NAME=eth0
    BOOTPROTO=none
    MASTER=bond0
    SLAVE=yes

[14]

A full list of bonding driver options for "bonding\_opts" can be found
here:
https://wiki.linuxfoundation.org/networking/bonding#bonding-driver-options.

Common bonding\_opts options:

-  mode = The bonding method to use.

   -  {0\|balance-rr} = Load balance using round robin. Every other
      request goes to/from a different interface.
   -  {1\|active-backup} = Only one interface is used. If it fails, then
      a slave device will take over.
   -  {2\|balancer-xor} = Load balance requests based on the source and
      destination MAC addresses.
   -  {3\|broadcast} = All traffic is sent out through all of the
      network interfaces.
   -  {4\|802.3ad} = All of the network devices use the same speed and
      duplex configuration to follow the 802.3ad bonding standard. This
      requires that the network interfaces are also connected to a
      switch that supports the IEEE 802.3ad Link Aggregation Control Protocol (LACP) standard. The
      switch must have LACP enabled on the relevant ports.
   -  {5\|balance-tlb} = Adaptive transmit load balancing. Load balance
      outgoing requests based on the slave usage.
   -  {6\|balance-alb} = Adaptive load balancing. Load balance incoming
      and outgoing requests based on slave usage.

[15]

Firewalls
---------

Fail2Ban
~~~~~~~~

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

[16]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/networking/linux.rst>`__
-  `< 2020.10.01 <https://github.com/ekultails/rootpages/commits/master/src/networking/networking_software.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/networking_software.rst>`__
-  `< 2018.07.01 <https://github.com/ekultails/rootpages/commits/master/src/networking.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/networking.md>`__

----------------------------------------------------------------------------------------------------------

Bibliography
------------

1. "How to switch from NetworkManager to systemd-networkd on Linux." Xmodulo. August 31, 2015. Accessed November 27, 2016. http://xmodulo.com/switch-from-networkmanager-to-systemd-networkd.html
2. "systemd.network — Network configuration." freedesktop.org. Accessed November 27, 2016. https://www.freedesktop.org/software/systemd/man/systemd.network.html
3. "systemd.netdev — Virtual Network Device configuration." freedesktop.org. Accessed November 27, 2016. https://www.freedesktop.org/software/systemd/man/systemd.netdev.html
4. "Managing WPA wireless with systemd-networkd ?" Arch Linux Wiki - Networking, Server, and Protection. March 13, 2014. Accessed November 27, 2016. https://bbs.archlinux.org/viewtopic.php?id=178625
5. "Frequently Asked Questions Open vSwitch." Open vSwitch Support. March 30, 2017. April 9, 2017. http://openvswitch.org/support/dist-docs-2.5/FAQ.md.html
6. "[Ubuntu 16.04] Network Configuration." Ubuntu Documentation. June 23, 2017. Accessed July 2, 2017. https://help.ubuntu.com/lts/serverguide/network-configuration.html
7. "Disable consistent network device naming in RHEL7." Red Hat Community Discussions. June 11, 2014. Accessed January 7, 2016. https://access.redhat.com/discussions/916973
8. "Interface Configuration Files." Accessed January 7, 2016. https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux/6/html/Deployment\_Guide/s1-networkscripts-interfaces.html
9. "How to add a new static route on RHEL7 Linux." Linux Config. March 17, 2015. Accessed April 9, 2017. https://linuxconfig.org/how-to-add-new-static-route-on-rhel7-linux
10. "Static Routes and the Default Gateway." Red Hat Documentation. March 15, 2017. Accessed April 9, 2017. https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux/6/html/Deployment\_Guide/s1-networkscripts-static-routes.html
11. "Network Bridge." Red Hat Documentation. May 29, 2016. Accessed February 24, 2017. https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux/6/html/Deployment\_Guide/s2-networkscripts-interfaces\_network-bridge.html
12. Configuring Libvirt guests with an Open vSwitch bridge." Kashyap Chamarthy. July 13, 2013. Accessed November 27, 2016. https://kashyapc.com/2013/07/13/configuring-libvirt-guests-with-an-open-vswitch-bridge/
13. "Configure Fedora Server with Open vSwitch and Libvirt." GitHub Gist - jdoss. October 31, 2015. Accessed November 27, 2016. https://gist.github.com/jdoss/64ecd24b74792efaa794
14. "RHEL: Linux Bond / Team Multiple Network Interfaces (NIC) Into a Single Interface." nixCraft. March 27, 2016. Accessed January 7, 2016. https://www.cyberciti.biz/tips/linux-bond-or-team-multiple-network-interfaces-nic-into-single-interface.html
15. "Bonding Interfaces." CentOS Tips and Tricks. January 22, 2013. Accessed January 7, 2016. https://wiki.centos.org/TipsAndTricks/BondingInterfaces
16. "How to install Fail2Ban on CentOS 7." HowtoForge. Accessed June 10, 2018. https://www.howtoforge.com/tutorial/how-to-install-fail2ban-on-centos/