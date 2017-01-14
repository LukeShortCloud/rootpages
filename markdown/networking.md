# Networking

* [Generic](#generic)
    * iproute2
    * Network Manager
    * [systemd](#generic---systemd)
* [Operating System Specific](#operating-system-specific)
    * Arch
    * Debian
    * [RHEL](#operating-system-specific---rhel)
        * [Bridging](#operating-system-specific---rhel---bridging)
        * [Bonding](#operating-system-specific---rhel---bonding)


# Generic

The generic section will cover networking utilies that are platform agnostic.


## Generic - systemd

The systemd init suite provides both "systemd-networkd" and systemd-resolved" to control networking devices. These services have been included in systemd since version 210. [1]

All systemd network settings should be configured in the directory "/etc/systemd/network/." Network files should have the ".network" extension and NetDev files will use ".netdev." Common options are listed below. [2][3]

Network Settings:

* [Match] = Select the device to use.
    * Name = The device name.
    * MACAddress = The MAC address for the device.
* [Network] = Network settings.
    * DHCP = Use DHCP.
        * yes, no, ipv4, or ipv6
    * DHCPServer = Become a DHCP server.
        * yes, no
    * Address = The IP address to use on the interface.
    * Gateway = The default gateway.
    * DNS = A list of DNS servers.
    * NTP = A list of NTP servers.
    * IPForward = Allow IP addresses to be routed based on the netfilter routing table.
        * yes, no, ipv4, ipv6
    * IPMasquerade = Allow IPv4 addresses to be set up for source network address translation (SNAT).
        * yes, no, ipv4
    * Bond = The name of the bond interface to use.
    * VLAN = The name of the VLAN interface to use.
    * VXLAN = The name of the VXLAN interface to use.
    * Tunnel = The name of the tunnel interface to use.
* [Link]
    * MACAddress = Override the MAC address with a custom address.
    * MTUBytes = The MTU size for packets.
* [DHCPServer] = Configure DHCP server settings.
    * PoolOffset = The offset count (not including network or broadcsat addresses) to start the IP allocation pool from.
    * PoolSize = The number of IP addresses that can be allocated.
    * DNS = A list of DNS servers to provide.
    * EmitRouter = The default gateway to provide.
    * NTP = The NTP server to provide.
    * Timezone = The timezone to provide. [2]

NetDev settings:

* [NetDev] = Virtual network devices.
    * Name = Create a name for the device.
    * MACAddress = Create a MAC address for the device. A randomly generated address will be created if this option is not specified.
    * MTUBytes = The MTU size for packets.
    * Kind = The type of virtual network device.
        * bond = A combination of multiple NICs.
        * bridge = Allow guests to have full passthrough access to the NIC.
        * dummy = Drop all packets.
        * gretap = GRE layer 2 tunnel.
        * gre = GRE layer 3 tunnel.
        * tap = Layer 2 tunnel.
        * tun = Layer 3 tunnel.
        * vlan = VLAN tagging.
        * vxlan = VXLAN tunnel.
* [Bond]
    * Mode = The bond mode to use for clustering NICs.
        * balance-rr
        * active-backup
        * balance-xor
        * broadcast
        * 802.3ad
        * balance-tlb
        * balance-alb
* [Tunnel] = Tunnel configurations
    * Local = The static IP address that should already be configured on another NIC. This is used to connecto to the remote tunnel IP address.
    * Remote = The remote IP address to create a tunnel connection between.
* [VLAN]
    * Id = The VLAN ID.
* [VLAN]
    * Id = The VXLAN ID. [3]

Static networking syntax:
```
[Match]
name=<NIC>

[Network]
Address=<IP_ADDRESS>/<CIDR>
Gateway=<GATEWAY_IP_ADDRESS>
DNS=<DNS_SERVER_IP_ADDRESS>
```

Static networking example:
```
[Match]
name=eth0

[Network]
Address=192.168.1.10/24
Address=10.0.0.2/30
Gateway=192.168.1.1
DNS=8.8.4.4
```
[2]

A Network configuration can be created for a WiFi interface. Using the "wpa_supplicant" service, the WiFi password can be securely saved in a different file and will automatically be used by systemd-network.

WiFi syntax:
```
# wpa_passphrase <SSID> <PASSWORD> > /etc/wpa_supplicant/wpa_supplicant-<NIC>.conf
# systemctl enable wpa_supplicant@<NIC>.conf
# systemctl start wpa_supplicant@<NIC>.conf
```

WiFi example:
```
# wpa_passphrase Guest5G password123 > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
# systemctl enable wpa_supplicant@wlan0.conf
# systemctl start wpa_supplicant@wlan0.conf
```

[4]

Sources:

1. "How to switch from NetworkManager to systemd-networkd on Linux." Xmodulo. August 31, 2015. Accessed November 27, 2016. http://xmodulo.com/switch-from-networkmanager-to-systemd-networkd.html
2. "systemd.network — Network configuration." freedesktop.org. Accessed November 27, 2016. https://www.freedesktop.org/software/systemd/man/systemd.network.html
3. "systemd.netdev — Virtual Network Device configuration." freedesktop.org. Accessed November 27, 2016. https://www.freedesktop.org/software/systemd/man/systemd.netdev.html
4. "Managing WPA wireless with systemd-networkd ?" Arch Linux Wiki - Networking, Server, and Protection. March 13, 2014. Accessed November 27, 2016. https://bbs.archlinux.org/viewtopic.php?id=178625


# Operating System Specific


## Operating System Specific - RHEL

Red Hat Enterprise Linux uses their own "network" service. Although Network Manager has started taking it's place, the network service is less intrusive and better supported by most programs that rely on managing network settings.

There are two udev modules that manage new device naming schemes: "net.ifnames" and "biosdevname." Only "net.ifnames" is installed by default on RHEL. Set these both to 0 in the kernel/boot options to revert back to eth* and wlan* naming. Otherwise, devices will benamed based on their physical location and connection to the motherboard. [1]

Network configurations are saved in `/etc/sysconfig/network-scripts/`. The ethernet device names start with "ifcfg-eth" when ifnames is disabled or "ifcfg-e" if not.

Options:

* {NAME|DEVICE} = The name of the network interface. The first device is generally "eth0" for ethernet or "wlan0" for wireless devices.
* ONBOOT = {yes|no}. Enable or disable this interface on startup of the system.
* HWADDR = The MAC address of the device.
* BOOTPROTO = The boot protocol to use for obtainng an IP address.
    * {none|static} = Static IP addressing. Do not use any protocol.
    * dhcp = Dynamic IP addressing. Use DHCP to obtain IP addressing information.
    * bootp = Dynamic IP addressing. Use BOOTP to obtain IP addressing information.
* DHCP_HOSTNAME = If a DHCP server requires a hostname, specify the hostname for the system.
* DHCPV6C = {yes|no}. Enable or disable the abillity to obtain an IPv6 address via DHCP.
* DHCPV6C = Specify DHCP options for IPv6.
    * -P = Prefix delegation.
    * -S = Obtain a stateless address.
    * -N = Revert to normal operation after using -P or -T.
    * -T = Temporarily obtain an IPv6 address.
    * -D = Specify a new value for the DHCP Unique Identifier (DUID).
* IPV6_AUTOCONF = {yes|no}. Enable or disable autoconf configuration.
* DNS{1,2} = The DNS nameservers to use for /etc/resolv.conf.
* PEERDNS = {yes|no}. Enable or disable the ability to get DNS information for /etc/resolv.conf from DHCP or IPCP.
* ETHTOOL_OPTS = Provide special ethtool options for the interface.
* IPADDR = An IPv4 address. This option's name can have a number appended to it (starting at 0) to specify multiple IP addresses.
* NETMASK = The IPv4 address's netmask.
* PREFIX = Instead of specifying a netmask, the CIDR prefix can be used.
* GATEWAY = The IPv4 default gateway to use. All IPv4 traffic will route out to this IP.
* MTU = The size of packets to use, in bytes. The default is 1500 and the maximum is 9000.
* IPV6INIT = {yes|no}. Enable or disable IPv6 on this interface.
* IPV6ADDR6 = An IPv6 address with it's CIDR prefix.
* IPV6ADDR_SECONDARIES = Other IPv6 addresses, comma separated, to add tot his interface.
* IPV6_PRIVACY=rfc3041 = Use the RFC 3041 standard to create a stateless IPv6 address using the interface's MAC address. By default, if this option is not defined, it is turned off for security concerns.
* IP6MTU = The size of packets to use, in bytes.
* MASTER = The master device for bonds.
* BONDING_OPTS = Additional bonding driver options.
* HOTPLUG = Default: yes. Activate his device if it is hot plugged into the system.
* LINKDELAY = The number of seconds to wait before loading up the network interface's configuration.
* SRCADDR = The primary source address for outgoing traffic.
* USERCTL = Enable or disable the ability to allow non-privileged users to manage the interface.
* NM_CONTROLLED = {yes|no}. Enable or disable Network Manager control over this interface.

[2]


Sources:

1. "Disable consistent network device naming in RHEL7." Red Hat Community Discussions. June 11, 2014. Accessed January 7, 2016. https://access.redhat.com/discussions/916973
2. "Interface Configuration Files." Accessed January 7, 2016. https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s1-networkscripts-interfaces.html


### Operating System Specific - RHEL - Bridging

Various bridge configurations can be made. It is common to use a normal bridge for allow virtual machines to have full access to the network or use an OpenVSwitch bridge for OpenStack's software defined networking (SDN).

OpenVSwitch bridge syntax (CLI):
```
# ovs-vsctl add-port <OVS_BRIDGE> <NIC>
# ovs-vsctl add-br <OVS_BRIDGE>
```
[1]

OpenVSwitch bridge syntax (configuraiton file):
```
# vim ifcfg-<NIC>
DEVICE="<NIC>"
TYPE="OVSPort"
DEVICETYPE="ovs"
OVS_BRIDGE="<OVS_BRIDGE>"
```
```
# vim ifcfg-<OVS_BRIDGE>
DEVICE="<OVS_BRIDGE>"
TYPE="OVSBridge"
DEVICETYPE="ovs"
```

OpenVSwitch bridge example (configuration file):
```
# vim ifcfg-eth1
DEVICE="eth1"
TYPE="OVSPort"
DEVICETYPE="ovs"
OVS_BRIDGE="br0-ovs"
BOOTPROTO="none"
ONBOOT="yes"
```
```
# vim ifcfg-br0-ovs
DEVICE="br0-ovs"
TYPE="OVSBridge"
DEVICETYPE="ovs"
IPADDR0=10.10.10.201
PREFIX0=24
GATEWAY=10.10.10.1
BOOTPROTO="none"
ONBOOT="yes"
```

[2]

Sources:

1. Configuring Libvirt guests with an Open vSwitch bridge." Kashyap Chamarthy. July 13, 2013. Accessed November 27, 2016. https://kashyapc.com/2013/07/13/configuring-libvirt-guests-with-an-open-vswitch-bridge/
2. "Configure Fedora Server with Open vSwitch and Libvirt." GitHub Gist - jdoss. October 31, 2015. Accessed November 27, 2016. https://gist.github.com/jdoss/64ecd24b74792efaa794


### Operating System Specific - RHEL - Bonding

Bonding allows for multiple devices to be used as a single virtual device. The physical NICs need to be configured as bond slaves. Then a new bond configuration can be created for the bond device.

Bond master syntax:
```
DEVICE=<BOND_DEVICE>
BONDING_MASTER=yes
BONDING_OPTS="mode=<BONDING_MODE>"
```

Bond master exmaple:
```
DEVICE=bond0
BONDING_MASTER=yes
BONDING_OPTS="mode=balance-alb"
```

Bond slave syntax:
```
MASTER=<BOND_DEVICE>
SLAVE=yes
```

Bond slave example:
```
NAME=eth0
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
```

[1]

A full list of bonding driver options for "bonding_opts" can be found here: [https://wiki.linuxfoundation.org/networking/bonding#bonding-driver-options](https://wiki.linuxfoundation.org/networking/bonding#bonding-driver-options).

Common bonding_opts options:

* mode = The bonding method to use.
    * {0|balance-rr} = Load balance using round robin. Every other request goes to/from a different interface.
    * {1|active-backup} = Only one interface is used. If it fails, then a slave device will take over.
    * {2|balancer-xor} = Load balance requests based on the source and destinatinon MAC addresses.
    * {3|broadcast} = All traffic is sent out through all of the network interfaces.
    * {4|802.3ad} = All of the network devices use the same speed and duplex configuration to follow the 802.3ad bonding standard. This requires that the network interfaces are also connected to a switch that supports IEEE 802.3ad Dynamic link aggregation. That switch must be configured to use it for it's own switch ports.
    * {5|balance-tlb} = Adaptive transmit load balancing. Load balance outgoing requests based on the slave usage.
    * {6|balance-alb} = Adaptive load balancing. Load balance incoming and outgoing requests based on slave usage.

[2]

Sources:

1. "RHEL: Linux Bond / Team Multiple Network Interfaces (NIC) Into a Single Interface." nixCraft. March 27, 2016. Accessed January 7, 2016. https://www.cyberciti.biz/tips/linux-bond-or-team-multiple-network-interfaces-nic-into-single-interface.html
2. "Bonding Interfaces." CentOS Tips and Tricks. January 22, 2013. Accessed January 7, 2016. https://wiki.centos.org/TipsAndTricks/BondingInterfaces

