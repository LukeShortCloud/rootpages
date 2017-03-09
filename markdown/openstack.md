# OpenStack

* [Introduction](#introduction)
* [Overview](#overview)
* [Installation](#installation)
    * [PackStack](#installation---packstack)
    * [OpenStack Ansible](#installation---openstack-ansible)
    * [TripleO](#installation---tripleo)
        * [Quick](#installation---tripleo---quick)
        * [Full](#installation---tripleo---full)
* [Configurations](#configurations)
    * [Common](#configurations---common)
        * [Database](#configurations---common---database)
        * [Messaging](#configurations---common---messaging)
    * [Keystone](#configurations---keystone)
        * [Token Provider](#configurations---keystone---token-provider)
        * [API v3](#configurations---keystone---api-v3)
    * [Nova](#configurations---nova)
        * [Hypervisors](#configurations---nova---hypervisors)
        * [CPU Pinning](#configurations---nova---cpu-pinning)
    * [Neutron](#configurations---neutron)
        * [DNS](#configurations---neutron---dns)
        * [Metadata](#configurations---neutron---metadata)
        * [Load-Balancing-as-a-Service](#configurations---neutron---load-balancing-as-a-service)
        * [Quality of Service](#configurations---neutron---quality-of-service)
        * [Distributed Virtual Routing](#configurations---neutron---distributed-virtual-routing)
        * [High Availability](#configurations---neutron---high-availability)
    * [Cinder](#configurations---cinder)
        * [Ceph](#configurations---cinder---ceph)
        * [Encryption](#configurations---cinder---encryption)
* [Neutron Troubleshooting](#neutron-troubleshooting)
    * [Open vSwitch](#neutron-troubleshooting---open-vswitch)
        * Network connections
        * [Floating IPs](#neutron-troubleshooting---open-vswitch---floating-ips)
* [Upgrades](#upgrades)
* [Command Line Interface Utilities](#command-line-interface-utilities)
* [Automation](#automation)
    * [Heat](#automation---heat)
        * [Resources](#automation---heat---resources)
        * [Parameters](#automation---heat---parameters)
    * [Vagrant](#automation---vagrant)
* [Testing](#testing)
    * [Tempest](#testing---tempest)
* [Performance](#performance)


# Introduction

This guide is aimed to help guide System Administrators through deploying, managing, and upgrading OpenStack. Specficially, almost everything here assumes that the cloud will be running on:

* OpenStack Newton
* Red Hat Enterprise Linux (RHEL) or CentOS 7

Most topics mentioned in this guide can be applied to similar environments.


# Overview

OpenStack has a large range of services that manage different different components in a modular way.

Core services:

* Keystone = Authentication
* Nova = Compute
* Neutron = Networking

Extra services:

* Horizon = Dashboard
* Swift = Object Storage
* Cinder = Block Storage
* Glance = Image
* Ceilometer = Telemtry
* Heat = Orchestration
* Trove = Database
* Sahara = Elastic Map Reduce
* Ironic = Bare-Metal Provisioning
* Zaqar = Messaging Service
* Manila = Shared Filesystems
* Designate = DNS Service
* Barbican = Key Management
* Magnum = Containers
* Murano = Application Catalog
* Congress = Governance

[1]

Source:

1. "Project Navigator." OpenStack. Accessed January 15, 2017. https://www.openstack.org/software/project-navigator/


# Installation

It is possible to easily install OpenStack as an all-in-one (AIO) server or onto a full cluster of servers. Various tools exist for deploying and managing OpenStack.


## Installation - PackStack

Supported operating systems: RHEL 7

PackStack (sometimes refered to as RDO) provides a simple all-in-one development. Thisis aimed towards developers needing to test new features with the latest code.

```
# yum install https://repos.fedorapeople.org/repos/openstack/openstack-newton/rdo-release-newton-4.noarch.rpm
# yum install packstack
# packstack --gen-answer-file <FILE>
# packstack --answer-file <FILE>
```

[1]

Source:

1. "OpenStack packages." OpenStack Installation Guide for Red Hat Enterprise Linux and CentOS. http://docs.openstack.org/mitaka/install-guide-rdo/environment-packages.html


## Installation - OpenStack Ansible

Supported operating systems: RHEL 7, Ubuntu 14.04 or 16.04

OpenStack Ansible uses Ansible for automating the deployment of Ubuntu inside of Docker containers that run the OpenStack services. This was created by RackSpace as an official tool for deploying and managing production environments.

```
# apt-get install git
# git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
# cd /opt/openstack-ansible/
# git checkout stable/newton
# scripts/bootstrap-ansible.sh
# scripts/bootstrap-aio.sh
```

[1]

Source:

1. "Quick Start." OpenStack Ansible Developer Documentation. January 10, 2016. Accessed January 10, 2016. http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html


## Installation - TripleO

Supported operating systems: RHEL 7, Fedora >= 22

TripleO means "OpenStack on OpenStack." The Undercloud is first deployed in a small, usually all-in-one, environment. This server is then used to create and manage a full Overcloud cluster. Virtual machines or physical servers can be used. The minimum requirement of RAM for the host node is 16GB to run all of the OpenStack services. [1]

Source:

1. "tripleo-quickstart." TripleO Quickstart GitHub. January 10, 2017. Accessed January 15, 2017. https://github.com/openstack/tripleo-quickstart


### Installation - TripleO - Quick

The "TripleO-Quickstart" project was created to use Ansible to automate deploying TripleO as fast as possible.

```
$ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh
$ bash quickstart.sh --release mitaka <VIRTUAL_MACHINE_IP>
```

[1]

Source:

1. "TripleO quickstart." RDO Project. Accessed January 8, 2016. https://www.rdoproject.org/tripleo/


### Installation - TripleO - Full

* Install the EPEL for extra packages that will be required.
```
# yum install epel-release
```
* Install the Undercloud environment deployment tools.
```
# yum install instack-undercloud
```
* Deploy the Undercloud virtual machine.
```
# instack–virt–setup
```
* Log into the virtual machine with the provided credentials from the previous command.
```
# ssh root@<VIRTUAL_MACHINE_IP>
```
* Install TripleO from the RDO Delorean repository.
```
# yum install python-tripleoclient
```
* Deploy an all-in-one Undercloud on the virtual machine.
```
# openstack undercloud install
```

[1]

Source:

1. "How To Install OpenStack Using TripleO." Platform9 Blog. June 27, 2016. Accessed January 8, 2017. https://platform9.com/blog/install-openstack-using-tripleo/


# Configurations

This section will focus on important settings for each service's configuration files.


## Configurations - Common

These are general configuration options that apply to most OpenStack configuration files.


### Configurations - Common - Database

Different database backends can be used by the API services on the controller nodes.

* MariaDB/MySQL. Requires the "PyMySQL" Python library. Starting with Liberty, this is prefered over using "mysql://" as the latest OpenStack libraries are written for PyMySQL connections (not to be confused with "MySQL-python"). [1]
```
[ database ] connection = mysql+pymysql://<USER>:<PASSWORD>@<MYSQL_HOST>:<MYSQL_PORT>/<DATABASE>
```
* PostgreSQL. Requires the "psycopg2" Python library. [2]
```
[ database ] connection = postgresql://<USER>:<PASSWORD>@<POSTGRESQL_HOST>:<POSTGRESQL_PORT>/<DATABASE>
```
* SQLite.
```
[ database ] connection = sqlite:///<DATABASE>.sqlite
```
* MongoDB is generally only used for Ceilometer. [3]
```
[ database ] mongodb://<USER>:<PASSWORD>@<MONGODB_HOST>:<MONGODB_PORT>/<DATABASE>
```


Sources:

1. "DevStack switching from MySQL-python to PyMySQL." OpenStack nimeyo. Jun 9, 2015. Accessed October 15, 2016. https://openstack.nimeyo.com/48230/openstack-all-devstack-switching-from-mysql-python-pymysql
2. "Using PostgreSQL with OpenStack." FREE AND OPEN SOURCE SOFTWARE KNOWLEDGE BASE. June 06, 2014. Accessed October 15, 2016. https://fosskb.in/2014/06/06/using-postgresql-with-openstack/
3. "Add the Telemetry service - Install and configure." OpenStack Documentation. December 24, 2016. Accessed February 18, 2017. https://docs.openstack.org/liberty/install-guide-rdo/ceilometer-install.html


### Configurations - Common - Messaging

For high availability and scalability, servers should be configured with a messaging agent. This allows a client's request to correctly be handled by the messaging queue and sent to one node to process that request.

The configuration has been consolidated into the `transport_url` option. Multiple messaging hosts can be defined by using a comma before naming a virtual host.

```
transport_url = <TRANSPORT>://<USER1>:<PASS1>@<HOST1>:<PORT1>,<USER2>:<PASS2>@<HOST2>:<PORT2>/<VIRTUAL_HOST>
```

#### Scenario #1 - RabbitMQ

On the controller nodes, RabbitMQ needs to be installed. Then a user must be created with full privileges.

```
# rabbitmqctl add_user <RABBIT_USER> <RABBIT_PASSWORD>
# rabbitmqctl set_permissions openstack ".*" ".*" ".*"
```

In the configuraiton file for every service, set the transport_url options for RabbitMQ. A virtual host is not required. By default it will use `/`.
```
[ DEFAULT ] transport_url = rabbit://<RABBIT_USER>:<RABBIT_PASSWORD>@<RABBIT_HOST>/<VIRTUAL_HOST>
```

[1]

#### Scenario #2 - ZeroMQ

This provides the best performance and stability. Scalability becomes a concern only when getting into hundreds of nodes. Instead of relying on a messaing queue, OpenStack services talk directly to each other using the ZeroMQ library. Redis is reuqired to be running and installed for acting as a message storage back-end for all of the servers. [1][2]

```
[ DEFAULT ] transport_url = "zmq+redis://<REDIS_HOST>:6379"
```
```
[ oslo_messaging_zmq ] rpc_zmq_bind_address = <IP>
[ oslo_messaging_zmq ] rpc_zmq_bind_matchmaker = redis
[ oslo_messaging_zmq ] rpc_zmq_host = <FQDN_OR_IP>
```

Alternatively, for high availability, use Redis Sentinel servers for the `transport_url`.

```
[ DEFAULT ] transport_url = "zmq+redis://<REDIS_SENTINEL_HOST1>:26379,<REDI_SENTINEL_HOST2>:26379"
```

For all-in-one deployments, the minimum requirement is to specify that ZeroMQ should be used.

```
[ DEFAULT ] transport_url = "zmq://"
```

Sources:

1. "Message queue." OpenStack Documentation. February 16, 2017. Accessed February 18, 2017. https://docs.openstack.org/newton/install-guide-rdo/environment-messaging.html
2. "RPC messaging configurations." OpenStack Documentation. February 16, 2017. Accessed February 18, 2017. https://docs.openstack.org/newton/config-reference/common-configurations/rpc.html
3. "ZeroMQ Driver Deployment Guide." OpenStack Documentation. February 16, 2017. Accessed February 18, 2017. https://docs.openstack.org/developer/oslo.messaging/zmq_driver.html


## Configurations - Keystone


### Configurations - Keystone - API v3

In Newton, the Keystone v2.0 API has been completely deprecated. It will be removed entirely from OpenStack in the "Q" release. [1] It is possible to run both v2.0 and v3 at the same time but it's desirable to move towards the v3 standard. If both have to be enabled, services should be configured to use v2.0 or else problems can occur with v3's domain scoping. For disabling v2.0 entirely, Keystone's API paste configuration needs to have these lines removed (or commented out) and then the web server should be restarted.

* /etc/keystone/keystone-paste.ini
    * [pipeline:public_api] pipeline = cors sizelimit url_normalize request_id admin_token_auth build_auth_context token_auth json_body ec2_extension public_service
    * [pipeline:admin_api] pipeline = cors sizelimit url_normalize request_id admin_token_auth build_auth_context token_auth json_body ec2_extension s3_extension admin_service
    * [composite:main] /v2.0 = public_api
    * [composite:admin] /v2.0 = admin_api

[2]

Sources:

1. "Newton Series Release Notes." Accessed February 18, 2017. http://docs.openstack.org/releasenotes/keystone/newton.html
2. "Setting up an RDO deployment to be Identity V3 Only." Young Logic. May 8, 2015. Accessed October 16, 2016. https://adam.younglogic.com/2015/05/rdo-v3-only/


### Configurations - Keystone - Token Provider

The token provider is used to create and delete tokens for authentication. Different providers can be used as the backend.

#### Scenario #1 - UUID (default)

* /etc/keystone/keystone.conf
    * [ token ] provider = uuid

#### Scenario #2 - PKI

PKI tokens are deprecated and will be removed in the Ocata release. [3]

* /etc/keystone/keystone.conf
    * [ token ] provider = pki
* Create the certificates. A new directory "/etc/keystone/ssl/" will be used to store these files.
```
# keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
```

#### Scenario #3 - Fernet (fastest token creation)

A public and private key wil need to be created for Fernet and the related Credential authentication.

* /etc/keystone/keystone.conf
    * [ token ] provider = fernet
    * [ fernet_tokens ] key_repository = /etc/keystone/fernet-keys/
    * [ credential ] provider = fernet
    * [ credential ] key_repository = /etc/keystone/credential-keys/
    * [ token ] provider = fernet
* Create the required keys:
```
# mkdir /etc/keystone/fernet-keys/
# chmod 750 /etc/keystone/fernet-keys/
# chown keystone.keystone /etc/keystone/fernet-keys/
# keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
```
```
# mkdir /etc/keystone/credential-keys/
# chmod 750 /etc/keystone/credential-keys/
# chown keystone.keystone /etc/keystone/credential-keys/
# keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
```

[2][4]

Sources:

1. "Configuring Keystone." OpenStack Documentation. Accessed October 16, 2016. http://docs.openstack.org/developer/keystone/configuration.html
2. "OpenStack Keystone Fernet tokens." Dolph Mathews. Accessed August 27th, 2016. http://dolphm.com/openstack-keystone-fernet-tokens/
3. "Newton Series Release Notes." OpenStack Documentation. Accessed January 15, 2016. http://docs.openstack.org/releasenotes/keystone/newton.html
4. "Install and configure [Keystone]." OpenStack Documentation. March 3, 2017. Accessed March 7, 2017. https://docs.openstack.org/newton/install-guide-rdo/keystone-install.html


## Configurations - Nova

* /etc/nova/nova.conf
    * [ libvirt ] inject_key = false
	    * Do not inject SSH keys via Nova. This should be handled by the Nova's metadata service. This will either be "openstack-nova-api" or "openstack-nova-metadata-api" depending on your setup.
    * [ DEFAULT ] enabled_apis = osapi_compute,metadata
	    * Enable support for the Nova API and Nova's metadata API. If "metedata" is specified here, then the "openstack-nova-api" handles the metadata and not "openstack-nova-metadata-api."
    * [ api_database ] connection = connection=mysql://nova:password@10.1.1.1/nova_api
    * [ database ] connection = mysql://nova:password@10.1.1.1/nova
	    * For the controller nodes, specify the connection SQL connection string. In this example it uses MySQL, the MySQL user "nova" with a password called "password", it connects to the IP address "10.1.1.1" and it is using the database "nova."


### Configurations - Nova - Hypervisors

Nova supports a wide range of virtualization technologies. Full hardware virtualization, paravirtualization, or containers can be used. Even Windows' Hyper-V is supported. [1]


#### Scenario #1 - KVM

* /etc/nova/nova.conf
    * [DEFAULT] compute_driver = libvirt.LibvirtDriver
    * [libvirt] virt_type = kvm

[2]


#### Scenario #2 - Xen

* /etc/nova/nova.conf
    * [DEFAULT] compute_driver = libvirt.LibvirtDriver
    * [libvirt] virt_type = xen

[3]


#### Scenario #3 - LXC

* /etc/nova/nova.conf
    * [DEFAULT] compute_driver = libvirt.LibvirtDriver
    * [libvirt] virt_type = lxc

[4]


#### Scenario #4 - Docker

Docker is not available by default in OpenStack because it is technically not a virtualization technology. It uses LXC for virtualization. Docker is used to help faciliate resources in an easier way. First it must be installed before configuring it in Nova.
```
# git clone https://github.com/openstack/nova-docker.git
# cd nova-docker/
# pip install -r requirements.txt
# python setup.py install
```

* [DEFAULT] compute_driver = novadocker.virt.docker.DockerDriver

[5]

Sources:

1. "Hypervisors." OpenStack Configuration Reference - Liberty. Accessed August 28th, 2016. http://docs.openstack.org/liberty/config-reference/content/section_compute-hypervisors.html
2. "KVM." OpenStack Configuration Reference - Liberty. Accessed August 28th, 2016. http://docs.openstack.org/liberty/config-reference/content/kvm.html
3. "Xen." OpenStack Configuration Reference - Liberty. Accessed August 28th, 2016. http://docs.openstack.org/liberty/config-reference/content/xen_libvirt.html
4. "LXC." OpenStack Configuration Reference - Liberty. Accessed August 28th, 2016. http://docs.openstack.org/liberty/config-reference/content/lxc.html
5. "nova-docker." GitHub.com. December, 2015. Accessed August 28th, 2016. https://github.com/openstack/nova-docker


### Configurations - Nova - CPU Pinning

Verify that the processor(s) has hardware support for non-uniform memory access (NUMA). If it does, NUMA may still need to be turned on in the BIOS. NUMA nodes are the physical processors. These processors are then mapped to specific sectors of RAM. [1]

```
# lscpu | grep NUMA
NUMA node(s):          2
NUMA node0 CPU(s):     0-9,20-29
NUMA node1 CPU(s):     10-19,30-39
```
```
# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 20 21 22 23 24 25 26 27 28 29
node 0 size: 49046 MB
node 0 free: 31090 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 30 31 32 33 34 35 36 37 38 39
node 1 size: 49152 MB
node 1 free: 31066 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10
```
```
# virsh nodeinfo | grep NUMA
NUMA cell(s):        2
```

[1][3]


#### Configuration

* Append the two NUMA filters.
```
# vim /etc/nova/nova.conf
[ DEFAULT ] scheduler_default_filters = RetryFilter,AvailabilityZoneFilter,RamFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImageProp
ertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,NUMATopologyFilter,AggregateInstanceExtraSpecsFilter
```

* Restart the Nova scheduler service on the controller node(s).
```
# systemctl restart openstack-nova-scheduler
```

* Set the aggregate/availability zone to allow pinning.
```
# nova aggregate-set-metadata <AGGREGATE_ZONE> pinned=true
```

* Modify a flavor to provide dedicated CPU pinning.
```
# nova flavor-key <FLAVOR_ID> set hw:cpu_policy=dedicated
```

[1][2][3]

Sources:

1. http://redhatstackblog.redhat.com/2015/05/05/cpu-pinning-and-numa-topology-awareness-in-openstack-compute/
2. http://docs.openstack.org/admin-guide/compute-flavors.html
3. http://www.stratoscale.com/blog/openstack/cpu-pinning-and-numa-awareness/


## Configurations - Neutron


### Configurations - Neutron - DNS

By default, Neutron does not provide any DNS resolvers. This means that DNS will not work. It is possible to either provide a default list of name servers or configure Neutron to refer to the relevant /etc/resolv.conf file on the server.

#### Scenario #1 - Define default resolvers (recommended)

* /etc/neutron/dhcp_agent.ini
    * [ DEFAULT ] dnsmasq_dns_servers = 8.8.8.8,8.8.4.4

#### Scenario #2 - Leave resolvers to be configured by the subnet details

* Nothing needs to be configured.

#### Scenario #3 - Do not provide resolvers

* /etc/neutron/dhcp_agent.ini
    * [ DEFAULT ] dnsmasq_local_resolv = True

[1]

Source:

1. "Name resolution for instances." OpenStack Documentation. August 09, 2016. Accessed August 13th, 2016. http://docs.openstack.org/mitaka/networking-guide/config-dns-resolution.html


### Configurations - Neutron - Metadata

The metadata service provides useful information about the instance from the IP address 169.254.169.254/32. This service is also used to communicate with "cloud-init" on the instance to configure SSH keys and other post-boot tasks.

Assuming authentication is already configured, set these options for the OpenStack environment. These are the basics needed before the metadata service can be used correctly. Then you can choose to use DHCP namespaces (layer 2) or router namespaces (layer 3) for delievering/receiving requests.

* /etc/neutron/metadata_agent.ini
    * [ DEFAULT ] nova_metadata_ip = CONTROLLER_IP
    * [ DEFAULT ] metadata_proxy_shared_secret = SECRET_KEY
* /etc/nova/nova.conf
    * [ DEFAULT ] enabled_apis = osapi_compute,metadata
    * [ neutron ] service_metadata_proxy = True
    * [ neutron ] metadata_proxy_shared_secret = SECRET_KEY

#### Scenario #1 - DHCP Namespace (recommended for DVR)

* /etc/neutron/dhcp_agent.ini
    * [ DEFAULT ] force_metadata = True
    * [ DEFAULT ] enable_isolated_metadata = True
    * [ DEFAULT ] enable_metadata_network = True
* /etc/neutron
    * [ DEFAULT ] enable_metadata_proxy = False

#### Scenario #2 - Router Namespace

* /etc/neutron/dhcp_agent.ini
    * [ DEFAULT ] force_metadata = False
    * [ DEFAULT ] enable_isolated_metadata = True
    * [ DEFAULT ] enable_metadata_network = False
* /etc/neutron/l3_agent.ini
    * [ DEFAULT ] enable_metadata_proxy = True

[1]

Source:

1. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/


### Configurations - Neutron - Load-Balancing-as-a-Service

Load-Balancing-as-a-Service version 2 (LBaaSv2) has been stable since Liberty. It can be configured with either the HAProxy or Octavia back-end.

* /etc/neutron/neutron.conf
    * [ DEFAULT ] service_plugins = `<PLUGINS>`, neutron_lbaas.services.loadbalancer.plugin.LoadBalancerPluginv2
        * Append the LBaaSv2 service plugin.
*   /etc/neutron/lbaas_agent.ini
    * [ DEFAULT ] interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
        * This is for Neutron with the OpenVSwitch backend only.
    * [ DEFAULT ] interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver
        * This is for Neutron with the Linux Bridge backend only.

#### Scenario #1 - HAProxy (recommended for it's maturity)

* /etc/neutron/neutron_lbaas.conf
    * [ service_providers ] service_provider = LOADBALANCERV2:Haproxy:neutron_lbaas.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default
* /etc/neutron/lbaas_agent.ini
    * [ DEFAULT ] device_driver = neutron_lbaas.drivers.haproxy.namespace_driver.HaproxyNSDriver
    * [ haproxy ] user_group = haproxy
        * Specify the group that HAProxy runs as. In RHEL, it's "haproxy."

#### Scenario #2 - Octavia

* /etc/neutron/neutron_lbaas.conf
    * [ service_providers ] service_provider = LOADBALANCERV2:Octavia:neutron_lbaas.drivers.octavia.driver.OctaviaDriver:default

[1]

Source:

1. http://docs.openstack.org/draft/networking-guide/config-lbaas.html


### Configurations - Neutron - Quality of Service

The Quality of Service (QoS) plugin can be used to rate limit the amount of bandwidth that is allowed through a network port.

* /etc/neutron/neutron.conf
    * [ DEFAULT ] service_plugins = neutron.services.qos.qos_plugin.QoSPlugin
        * Append the QoS plugin to the list of service_plugins.
* /etc/neutron/plugins/ml2/openvswitch_agent.ini
    * [ml2] extension_drivers = qos
        * Append the QoS driver with the modular layer 2 plugin provider. Alternatively to OpenVSwitch, LinuxBridge and SR-IOV are also supported for quality of service.
* /etc/neutron/plugins/ml2/ml2_conf.ini
    * [agent] extensions = qos
        * Lastly, append the QoS extension to the modular layer 2 configuration.

[1]

Source:

1. "Quality of Service (QoS)." OpenStack Documentation. October 10, 2016. Accessed October 16, 2016. http://docs.openstack.org/draft/networking-guide/config-qos.html


### Configurations - Neutron - Distributed Virtual Routing

Distributed virtual routing (DVR) is a concept that involves deploying routers to both the compute and network nodes to spread out resource usage. All layer 2 traffic will be equally spread out among the servers. Public floating IPs will still need to go through the SNAT process via the routers on the network nodes. This is only supported when the Open vSwitch agent is used. [1]

* /etc/neutron/neutron.conf
    * [ DEFAULT ] router_distributed = true
* /etc/neutron/l3_agent.ini (compute)
    * [ DEFAULT ] agent_mode = dvr
* /etc/neutron/l3_agent.ini (network or all-in-one)
    * [ DEFAULT ] agent_mode = dvr_snat
* /etc/neutron/plugins/ml2/ml2_conf.ini
    * [ ml2 ] mechanism_drivers = openvswitch, l2population
* /etc/neutron/plugins/ml2/openvswitch_agent.ini
    * [ agent ] l2_population = true
    * [ agent ] enable_distributed_routing = true

Source:

1. "Neutron/DVR/HowTo" OpenStack Wiki. January 5, 2017. Accessed March 7, 2017.  https://wiki.openstack.org/wiki/Neutron/DVR/HowTo


### Configurations - Neutron - High Availability

High availability (HA) in Neutron allows for routers to failover to another duplicate router if one fails or is no longer present. All new routers will be highly available.

* /etc/neutron/neutron.conf
    * [ DEFAULT ] l3_ha = true
    * [ DEFAULT ] max_l3_agents_per_router = 2
    * [ DEFAULT ] allow_automatic_l3agent_failover = true


[1]

Source:

1. "Distributed Virtual Routing with VRRP." OpenStack Documentation. March 6, 2017. Accessed March 7, 2017. https://docs.openstack.org/newton/networking-guide/config-dvr-ha-snat.html


## Configurations - Cinder

The Cinder service provides block devices for instances.


### Configurations - Cinder - Ceph

Ceph has become the most popular backend to Cinder due to it's high availability and scalability.

* /etc/cinder/cinder.conf
    * [ DEFAULT ] enabled_backends = ceph
        * Use the "[ ceph ]" section for the backend configuration. The new "[ ceph ]" section can be named anything but the same name must be used here.
    * [ DEFAULT ] volume_backend_name = volumes
    * [ DEFAULT ] rados_connect_timeout = -1
    * [ ceph ] volume_driver = cinder.volume.drivers.rbd.RBDDriver
        * Use Cinder's RBD Python library.
    * [ ceph ] rbd_pool = volumes
        * This is the RBD pool to use for volumes.
    * [ ceph ] rbd_ceph_conf = /etc/ceph/ceph.conf
    * [ ceph ] rbd_flatten_volume_from_snapshot = false
        * Ceph supports efficent thin provisioned snapshots.
    * [ ceph ] rbd_max_clone_depth = 5
    * [ ceph ] rbd_store_chunk_size = 4
    * [ ceph ] rados_connect_timeout = -1
    * [ ceph ] glance_api_version = 2

[1]


Source:

1. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. http://docs.ceph.com/docs/master/rbd/rbd-openstack


### Configurations - Cinder - Encryption

Cinder volumes support the Linux LUKS encryption. The only requirement is that the compute nodes have the "cryptsetup" package installed. [1]

```
$ openstack volume type create LUKS
$ cinder encryption-type-create --cipher aes-xts-plain64 --key_size 512 --control_location front-end LUKS nova.volume.encryptors.luks.LuksEncryptor
```

Encrypted volumes can now be created.

~~~
$ openstack volume create --size <SIZE_IN_GB> --type LUKS <VOLUME_NAME>
~~~

Source:

1. "Volume encryption supported by the key manager" Openstack Documentation. February 16 2017. Accessed February 18, 2017. https://docs.openstack.org/newton/config-reference/block-storage/volume-encryption.html


# Neutron Troubleshooting

Neutron is one of the most complicated services offered by OpenStack. Due to it's wide range of configurations and technologies that it handles, it can be difficult to troubleshoot problems. This section aims to clearly layout common techniques to track down and fix issues with Neutron.


## Neutron Troubleshooting - Open vSwitch


### Neutron Troubleshooting - Open vSwitch - Floating IPs

Floating IPs can be manually added to the namespace. Depending on the environment, these rules either need to be added to the `snat-<ROUTER_ID>` namespace if it exists or the `qrouter-<ROUTER_ID>` namespace. All floating IPs need to be added with the /32 CIDR, not the CIDR that represents it's true subnet mask.

~~~
# ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-OUTPUT -d <FLOATING_IP>/32 -j DNAT --to-destination <LOCAL_IP>
# ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-PREROUTING -d <FLOATING_IP>/32 -j DNAT --to-destination <LOCAL_IP>
# ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-float-snat -s <LOCAL_IP>/32 -j SNAT --to-source <FLOATING_IP>
# ip netns exec snat-<ROUTER_ID> ip address add <FLOATING_IP>/32 brd <FLOATING_IP> dev qg-b2e3c286-b2
~~~

With no floating IPs allocated, the iptables NAT table in the SNAT namespace should look similar to this.

~~~
# ip netns exec snat-<ROUTER_ID> iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-N neutron-l3-agent-OUTPUT
-N neutron-l3-agent-POSTROUTING
-N neutron-l3-agent-PREROUTING
-N neutron-l3-agent-float-snat
-N neutron-l3-agent-snat
-N neutron-postrouting-bottom
-A PREROUTING -j neutron-l3-agent-PREROUTING
-A OUTPUT -j neutron-l3-agent-OUTPUT
-A POSTROUTING -j neutron-l3-agent-POSTROUTING
-A POSTROUTING -j neutron-postrouting-bottom
-A neutron-l3-agent-POSTROUTING ! -i qg-<NIC_ID> ! -o qg-<NIC_ID> -m conntrack ! --ctstate DNAT -j ACCEPT
-A neutron-l3-agent-snat -o qg-<NIC_ID> -j SNAT --to-source <PUBLIC_ROUTER_IP>
-A neutron-l3-agent-snat -m mark ! --mark 0x2/0xffff -m conntrack --ctstate DNAT -j SNAT --to-source <PUBLIC_ROUTER_IP>
-A neutron-postrouting-bottom -m comment --comment "Perform source NAT on outgoing traffic." -j neutron-l3-agent-snat
~~~

[1][2]

Sources:

1. "Adding additional NAT rule on neutron-l3-agent." Ask OpenStack. February 15, 2015. Accessed February 23, 2017. https://ask.openstack.org/en/question/60829/adding-additional-nat-rule-on-neutron-l3-agent/
2. "Networking in too much detail." RDO Project. January 9, 2017. Accessed February 23, 2017. https://www.rdoproject.org/networking/networking-in-too-much-detail/


# Upgrades

Upgrading a production OpenStack environment requires a lot of planning. It is recommended to test an upgrade of the environment virtually before rolling it out to production. Automation tools generally have their own guides but most of these guidelines should still apply to manual deployment upgrades. The entire steps include to:

* Backup configuration files and databases.
* Review the release notes of the OpenStack services that will be upgraded. These will contain details of deprecations and new configuration changes. [https://releases.openstack.org/](https://releases.openstack.org/)
* Update configuration files. Sample configurations can be found at `http://docs.openstack.org/<RELEASE>/config-reference/`.
* If not already, consider using an automation tool such as Ansible to deploy new service configurations.
* Remove the old package repository for OpenStack.
* Add the new package repository for OpenStack.
* Update all of the packages.
* Restart the services. `openstack-service restart`

[1]

Source:

1. "Upgrades." OpenStack Documentation. January 15, 2017. Accessed January 15, 2017. http://docs.openstack.org/ops-guide/ops-upgrades.html


# Command Line Interface Utilities

The OpenStack CLI resources used to be handled by separate commands. These have all been modified and are managed by the universal "openstack" command. The various options and arguments are explained in Root Pages' OpenStack section [Linux Commands excel sheet](https://raw.githubusercontent.com/ekultails/rootpages/master/linux_commands.xlsx).

For the CLI utilities to work, the environment variables need to be set for the project and user. This way the commands can automatically authenticate.

* Add the credentials to a text file This is generally ends with the ".sh" extension to signify it's a shell file. A few default variables are filled in below.
  * Keystone v2.0
```
# unset any variables used
unset OS_PROJECT_ID
unset OS_PROJECT_NAME
unset OS_PROJECT_DOMAIN_ID
unset OS_PROJECT_DOMAIN_NAME
unset OS_USER_ID
unset OS_USER_NAME
unset OS_USER_DOMAIN_ID
unset OS_USER_DOMAIN_NAME
unset OS_REGION_ID
unset OS_REGION_NAME
# fill in the project, user, and endpoint details
export PROJECT_ID=
export PROJECT_NAME=
export OS_USERNAME=
export OS_PASSWORD=
export OS_REGION_NAME="RegionOne"
export OS_AUTH_URL="http://controller1:5000/v2.0"
export OS_AUTH_VERSION="2.0"
```
  * Keystone v3
```
# unset any variables used
unset OS_PROJECT_ID
unset OS_PROJECT_NAME
unset OS_PROJECT_DOMAIN_ID
unset OS_PROJECT_DOMAIN_NAME
unset OS_USER_ID
unset OS_USER_NAME
unset OS_USER_DOMAIN_ID
unset OS_USER_DOMAIN_NAME
unset OS_REGION_ID
unset OS_REGION_NAME
# fill in the project, user, and endpoint details
export OS_PROJECT_ID=
export OS_PROJECT_NAME=
export OS_PROJECT_DOMAIN_NAME="default"
export OS_USERID=
export OS_USERNAME=
export OS_PASSWORD=
export OS_USER_DOMAIN_NAME="default"
export OS_REGION_NAME="RegionOne"
export OS_AUTH_URL="http://controller1:5000/v3"
export OS_AUTH_VERSION="3"
```

* Source the credential file to load it into the shell environment:
```
$ source <USER_CREDENTIALS_FILE>.sh
```

* View the available command line options.
```
$ openstack help
```
```
$ openstack help <OPTION>
```

[1]

Source:

1. "OpenStack Command Line." OpenStack Documentation. Accessed October 16, 2016. http://docs.openstack.org/developer/python-openstackclient/man/openstack.html


# Automation

Automating deployments can be accomplished in a few ways. The built-in OpenStack way is via Orhcestration as a Service (OaaS), typically handled by Heat. It is also possible to use Ansible or Vagrant to automate OpenStack deploys.


## Automation - Heat

Heat is used to orchestrate the deployment of multiple OpenStack components at once. It can also install and configure software on newly built instances.


## Automation - Heat - Resources

Heat templates are made of multiple resources. All of the different resource types are listed here [http://docs.openstack.org/developer/heat/template_guide/openstack.html](http://docs.openstack.org/developer/heat/template_guide/openstack.html). Resources use properties to create a component. If no name is specified (for example, a network name), a random string will be used. Most properties also accept either an exact ID of a resource or a reference to a dynamically generated resource (which will provide it's ID once it has been created).

This section will go over examples of the more common modules.

Syntax:
```
<DESCRIPTIVE_OBJECT_NAME>:
    type: <HEAT_RESOURCE_TYPE>
    properties:
        <PROPERTY_1>: <VALUE_1>
        <PROPERTY_2>: <VALUE_2>
```

For referencing created resources (for example, creating a subnet in a created network) the "get_resource" function should be used.
```
{ get_resource: <OBJECT_NAME> }
```

* Create a network, assigned to the "internal_network" object.
```
internal_network: {type: 'OS::Neutron::Net'}
```

* Create a subnet for the created network. Required properties: network name or ID.
```
internal_subnet:
    type: OS::Neutron::Subnet
    properties:
      ip_version: 4
      cidr: 10.0.0.0/24
      dns_nameservers: [8.8.4.4, 8.8.8.8]
      network_id: {get_resource: internal_network}
```

* Create a port. This object can be used during the instance creation. Required properties: network name or ID.
```
subnet_port:
    type: OS::Neutron::Port
    properties:
        fixed_ips:
            - subnet_id: {get_resource: internal_subnet}
        network: {get_resource: internal_network}
```

* Create a router associated with the public "ext-net" network.
```
external_router:
    type: OS::Neutron::Router
    properties:
        external_gateway_info: [ network: ext-net ]
```

* Attach a port from the network to the router.
```
external_router_interface:
    type: OS::Neutron::RouterInterface
    properties:
        router: {get_resource: external_router}
        subnet: {get_resource: internal_subnet}
```

* Create a key pair called "HeatKeyPair." Required property: name.
```
ssh_keys:
    type: OS::Nova::KeyPair
    properties:
        name: HeatKeyPair
        public_key: HeatKeyPair
        save_private_key: true
```

* Create an instance using the "m1.small" flavor, "centos7" image, assign the subnet port creaetd by "subnet_port" and use the "default" security group.
```
instance_creation:
  type: OS::Nova::Server
  properties:
    flavor: m1.small
    image: centos7
    networks:
        - port: {get_resource: subnet_port}
    security_groups: {default}
```

* Allocate an IP from the "ext-net" floating IP pool.
```
floating_ip:
    type: OS::Neutron::FloatingIP
    properties: {floating_network: ext-net}
```

* Allocate a a floating IP to the created instance from a "instance_creation" function. Alternatively, a specific instance's ID can be defined here.
```
floating_ip_association:
    type: OS::Nova::FloatingIPAssociation
    properties:
	    floating_ip: {get_resource: floating_ip}
		server_id: {get_resource: instance_creation}
```

Source:

1. "OpenStack Orchestration In Depth, Part I: Introduction to Heat." Accessed September 24, 2016. November 7, 2014. https://developer.rackspace.com/blog/openstack-orchestration-in-depth-part-1-introduction-to-heat/


## Automation - Heat - Parameters

Parameters allow users to input custom variables for Heat templates.

Options:
* type = The input type. This can be a string, number, JSON, a comma separated list or a boolean.
* label = String. The text presented to the end-user for the fillable entry.
* description = String. Detailed information about the parameter.
* default = A default value for the parameter.
* constraints = A parameter has to match a specified constrant. Any number of constraints can be used from the available ones below.
  * length = How long a string can be.
  * range = How big a number can be.
  * allowed_values = Allow only one of these specific values to be used.
  * allowed_pattern = Allow only a value matching a regular expression.
  * custom_constraint = A full list of custom service constraints can be found at [http://docs.openstack.org/developer/heat/template_guide/hot_spec.html#custom-constraint](#http://docs.openstack.org/developer/heat/template_guide/hot_spec.html#custom-constraint).
* hidden = Boolean. Specify if the text entered should be hidden or not. Default: false.
* immutable = Boolean. Specify whether this variable can be changed. Default: false.

Syntax:
```
parameters:
	<CUSTOM_NAME>:
    	type: string
        label: <LABEL>
        description: <DESCRIPTION>
        default: <DEFAULT_VALUE>
        constraints:
        	- length: { min: <MINIMUM_NUMBER>, max: <MAXIMUM_NUMBER> }
        	- range: { min: <MINIMUM_NUMBER>, max: <MAXIMUM_NUMBER> }
        	- allowed_values: [ <VALUE1>, <VALUE2>, <VALUE3> ]
        	- allowed_pattern: <REGULAR_EXPRESSION>
        	- custom_constrant: <CONSTRAINT>
		hidden: <BOOLEAN>
        immutable: <BOOLEAN>
```

For referencing this parameter elsewhere in the Heat template, use this syntax for the variable:
```
{ get_param: <CUSTOM_NAME> }
```

[1]

Source:

1. "Heat Orchestration Template (HOT) specification." OpenStack Developer Documentation. October 21, 2016. Accessed October 22, 2016. http://docs.openstack.org/developer/heat/template_guide/hot_spec.html


## Automation - Vagrant

Vagrant is a tool to automate the deployment of virtual machines. A "Vagrantfile" file is used to initalize the instance. An example is provided below. Note that Vagrant currently does not support Keystone's v3 API.

```
require 'vagrant-openstack-provider'

Vagrant.configure('2') do |config|

  config.vm.box       = 'vagrant-openstack'
  config.ssh.username = 'cloud-user'

  config.vm.provider :openstack do |os|
    os.openstack_auth_url = 'http://controller1/v2.0/tokens'
    os.username           = 'openstackUser'
    os.password           = 'openstackPassword'
    os.tenant_name        = 'myTenant'
    os.flavor             = 'm1.small'
    os.image              = 'centos'
    os.networks           = "vagrant-net"
    os.floating_ip_pool   = 'publicNetwork'
    os.keypair_name       = "private_key"
  end
end
```

Once those settings are configured for the end user's cloud environment, it can be created by running:

```
$ vagrant up --provider=openstack
```

[1]

Source:

1. "Vagrant OpenStack Cloud Provider." GitHub - ggiamarchi. Accessed September 24, 2016. April 30, 2016. https://github.com/ggiamarchi/vagrant-openstack-provider


# Testing


## Testing - Tempest

Tempest is used to query all of the different APIs in use. This helps to validate the functionality of OpenStack. This software is a rolling release aimed towards verifying the latest OpenStack release in development but it should also work for older versions as well.

The sample configuration flie "/etc/tempest/tempest.conf.sample" should be copied to "/etc/tempest/tempest.conf" and then modified. If it is not available then the latest configuration file can be downloaded from one of these sources:
* http://docs.openstack.org/developer/tempest/sampleconf.html
* http://docs.openstack.org/developer/tempest/_static/tempest.conf.sample


* Provide credentials to a user with the "admin" role.
```
[auth]
admin_username
admin_password
admin_project_name
admin_domain_name
default_credentials_domain_name = Default
```

* Specify the Keystone version to use. Valid options are "v2" and "v3."
```
[identity]
auth_version
```

* Provide the admin Keystone endpoint for v2 (uri) or v3 (uri_v3).
```
[identity]
uri
uri_v3
```

* Two different size flavor IDs should be given.
```
[compute]
flavor_ref
flavor_ref_alt
```

* Two different image IDs should be given.
```
[compute]
image_ref
image_ref_alt
```

* Define what services should be tested for the specific cloud.
```
[service_available]
cinder = true
neutron = true
glance = true
swift = false
nova = true
heat = false
sahara = false
ironic = false
```

[1]

Source:

1. "Tempest Configuration Guide." Sep 14th, 2016. http://docs.openstack.org/developer/tempest/configuration.html


# Performance

A few general tips for getting the fastest OpenStack performance.

* KeyStone
  * Switch to Fernet keys.
    * Creation of tokens is significantly faster.
    * Refer to [Configurations - Keystone - Token Provider](#configurations---keystone---token-provider).
* Neutron
  * Use distributed virtual routing (DVR).
    * This offloads a lot of networking resources onto the compute nodes.
* General
  * Utilize /etc/hosts.
    * Ensure that all of your domain names (including the public domains) are listed in the /etc/hosts. This avoids a performance hit from DNS lookups. Alternatively, consider setting up a recursive DNS server on the controller nodes.
  * Use memcache.
    * This is generally configured by an option called "memcache_servers" in the configuration files for most services. Consider using "CouchBase" for its ease of clustering and redundancy support.
