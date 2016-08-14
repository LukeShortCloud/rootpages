# OpenStack
* [Introduction](#introduction)
* [Overview](#overview)
* [Configurations](#configurations)
  * [Nova](#configurations---nova)
  * [Neutron](#configurations---neutron)
    * [DNS](#configurations---neutron---dns)
    * [Metadata](#configurations---neutron---metadata)
* [Performance](#performance)


# Inroduction

This guide is aimed to help guide System Administrators through OpenStack. It is assumed that the cloud is using these industry standard software:

* OpenStack Liberty
* CentOS 7 (Linux)
* KVM/Qemu Virtualization

Most things mentioned here should be able to be applied to other similar environments.

# Overview

OpenStack has a large range of services. The essential ones required for a basic cloud are:

* Keystone
  * Authentication
* Nova
  * Virtualization
* Neutron
  * Networking

# Configurations

This section will focus on important settings for each configuration file.

## Configurations - Nova

* /etc/nova/nova.conf
	* [ DEFAULT ] compute_driver = libvirt.LibvirtDriver
	* [ libvirt ] virt_type = kvm
	  * Use KVM for virtualization.
	* [ libvirt ] inject_key = false
	  * Do not inject SSH keys via Nova. This should be handled by the Nova's metadata service. This will either be "openstack-nova-api" or "openstack-nova-metadata-api."
	* [ DEFAULT ] enabled_apis = ec2,osapi_compute,metadata
	  * Enable support for Amazon EC2, the Nova API, and Nova's metadata API. If "metedata" is specified here, then the "openstack-nova-api" handles the metadata and not "openstack-nova-metadata-api."
	* [ api_database ] connection = connection=mysql://nova:password@10.1.1.1/nova
	* [ database ] connection = mysql://nova:password@10.1.1.1/nova
	  * For the controller nodes, specify the connection SQL connection string. In this example it uses MySQL, the MySQL user "nova" with a password called "password", it connects to the IP address "10.1.1.1" and it is using the database "nova."

## Configurations - Neutron

### Configurations - Neutron - DNS

By default, Neutron does not provide any DNS resolvers. This means that DNS will not work. It is possible to either provide a default list of name servers or configure Neutron to refer to the relevant /etc/resolv.conf file on the server.

#### Scenario #1 - Define default resolvers (recommended)

* /etc/neutron/dhcp_agent.ini
  * [ DEFAULT ] dnsmasq_dns_servers = 8.8.8.8,8.8.4.4

#### Scenario #2 - Leave resolvers to be configured by the subnet details

* Nothing needs to be configured.

#### Scenario #2 - Do not provide resolvers

* /etc/neutron/dhcp_agent.ini
  * [ DEFAULT ] dnsmasq_local_resolv = True

[1]

Sources:

1. "Name resolution for instances." OpenStack Documentation. August 09, 2016. Accessed August 13th, 2016. http://docs.openstack.org/mitaka/networking-guide/config-dns-resolution.html

### Configurations - Neutron - Metadata

The metadata service provides useful information about the instance from the IP address 169.254.169.254/32. This service is also used to communicate with "cloud-init" on the instance to configure SSH keys and other post-boot tasks.

Assuming authentication is already configured, set these options for the OpenStack environment. These are the basics needed before the metadata service can be used correctly. Then you can choose to use DHCP namespaces (layer 2) or router namespaces (layer 3) for delievering/recieving requests.

* /etc/neutron/metadata_agent.ini
  * [ DEFAULT ] nova_metadata_ip = CONTROLLER_IP
  * [ DEFAULT ] metadata_proxy_shared_secret = SECRET_KEY
* /etc/nova/nova.conf
  * [ DEFAULT ] enabled_apis = ec2,osapi_compute,metadata
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

* /etc/neutron//dhcp_agent.ini
  * [ DEFAULT ] force_metadata = False
  * [ DEFAULT ] enable_isolated_metadata = True
  * [ DEFAULT ] enable_metadata_network = False
* /etc/neutron/l3_agent.ini
  * [ DEFAULT ] enable_metadata_proxy = True

[1]

Source:

1. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/

# Performance

A few general tips for getting the fastest OpenStack performance.

* KeyStone
  * Switch to Fernet keys.
    * Creation of tokens is significantly faster.
    * [ fernet_tokens ] key_repository = /etc/keystone/fernet-keys/
	* [ token ] provider = fernet
* Neutron
  * Use distributed virtual routing (DVR).
    * This offloads a lot of networking resources onto the compute nodes.
* General
  * Utilize /etc/hosts.
    * Ensure that all of your domain names (including the public IP) are listed in the /etc/hosts. This avoids a performance hit from DNS lookups. Altneratively, consider setting up a recursive DNS server on the controller nodes.
  * Use memcache.
    * This is generally configured by an option called "memcache_servers" in the configuration files for most services. Consider using "CouchBase" for its ease of clustering and redudancy support.
