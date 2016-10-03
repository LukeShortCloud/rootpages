# OpenStack

* [Introduction](#introduction)
* [Overview](#overview)
* [Configurations](#configurations)
  * [Keystone](#configurations---keystone)
    * [Token Provider](#configurations---keystone---token-provider)
  * [Nova](#configurations---nova)
    * [Hypervisors](#configurations---nova---hypervisors)
    * [CPU Pinning](#configurations---nova---cpu-pinning)
  * [Neutron](#configurations---neutron)
    * [DNS](#configurations---neutron---dns)
    * [Metadata](#configurations---neutron---metadata)
* [Automation](#automation)
  * [Heat](#automation---heat)
    * [Resources](#automation---heat---resources)
  * [Vagrant](#automation---vagrant)
* [Testing](#testing)
  * [Tempest](#testing---tempest)
* [Performance](#performance)



# Introduction

This guide is aimed to help guide System Administrators through OpenStack. It is assumed that the cloud is using these industry standard software:

* OpenStack Mitaka
* CentOS 7 (Linux)

Most things mentioned here should be able to be applied to other similar environments.

# Overview

OpenStack has a large range of services. The essential ones required for a basic cloud are:

* Keystone
  * Authentication
* Nova
  * Compute
* Neutron
  * Networking

# Configurations

This section will focus on important settings for each service's configuration files.

## Configurations - Keystone

### Configurations - Keystone - Token Provider

The token provider is used to create and delete tokens for authentication. Different providers can be used as the backend. These are configured in the /etc/keystone/keystone.conf file.

#### Scenario #1 - UUID (default)

* [ token ] provider = uuid

#### Scenario #2 - PKI

* [ token ] provider = pki
* Create the certificates. A new directory "/etc/keystone/ssl/" will be used to store these files.
```
# keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
```

#### Scenario #3 - Fernet (fastest token creation)

* [ token ] provider = fernet
* [ fernet_tokens ] key_repository = /etc/keystone/fernet-keys/
* Create the Fernet keys:
```
# mkdir /etc/keystone/fernet-keys/
# chmod 750 /etc/keystone/fernet-keys/
# keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
```

[2]

Sources:

1. http://docs.openstack.org/developer/keystone/configuration.html
2. "OpenStack Keystone Fernet tokens." Dolph Mathews. Accessed August 27th, 2016. http://dolphm.com/openstack-keystone-fernet-tokens/

## Configurations - Nova

* /etc/nova/nova.conf
	* [ libvirt ] inject_key = false
	  * Do not inject SSH keys via Nova. This should be handled by the Nova's metadata service. This will either be "openstack-nova-api" or "openstack-nova-metadata-api" depending on your setup.
	* [ DEFAULT ] enabled_apis = osapi_compute,metadata
	  * Enable support for the Nova API, and Nova's metadata API. If "metedata" is specified here, then the "openstack-nova-api" handles the metadata and not "openstack-nova-metadata-api."
	* [ api_database ] connection = connection=mysql://nova:password@10.1.1.1/nova_api
	* [ database ] connection = mysql://nova:password@10.1.1.1/nova
	  * For the controller nodes, specify the connection SQL connection string. In this example it uses MySQL, the MySQL user "nova" with a password called "password", it connects to the IP address "10.1.1.1" and it is using the database "nova."

### Configurations - Nova - Hypervisors

Nova supports a wide range of virtualization technologies. Full hardware virtulization, paravirutlization, or containers can be used. Even Windows' Hyper-V is supported. This is configured in the /etc/nova/nova.conf file. [1]

#### Scenario #1 - KVM

* [DEFAULT] compute_driver = libvirt.LibvirtDriver
* [libvirt] virt_type = kvm

[2]

#### Scenario #2 - Xen

* [DEFAULT] compute_driver = libvirt.LibvirtDriver
* [libvirt] virt_type = xen

[3]

#### Scenario #3 - LXC

* [DEFAULT] compute_driver = libvirt.LibvirtDriver
* [libvirt] virt_type = lxc

[4]

#### Scenario #4 - Docker

Docker is not available by default in OpenStack. First it must be installed before configuring it in Nova.
```
# git clone https://github.com/openstack/nova-docker.git
# cd nova-docker/
# pip install -r requirements.txt
# python setup.py install
```

* [DEFAULT] compute_driver=novadocker.virt.docker.DockerDriver

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

* /etc/neutron/dhcp_agent.ini
  * [ DEFAULT ] force_metadata = False
  * [ DEFAULT ] enable_isolated_metadata = True
  * [ DEFAULT ] enable_metadata_network = False
* /etc/neutron/l3_agent.ini
  * [ DEFAULT ] enable_metadata_proxy = True

[1]

Source:

1. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/

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

* Create a network, assigned to the "internal_network" object.
```
internal_network: {type: 'OS::Neutron::Net'}
```

* Create a subnet for the created network.
```
internal_subnet:
    type: OS::Neutron::Subnet
    properties:
      ip_version: 4
      cidr: 10.0.0.0/24
      dns_nameservers: [8.8.4.4, 8.8.8.8]
      network_id: {get_resource: internal_network}
```

* Create a port. This object can be used during the instance creation.
```
subnet_port:
    type: OS::Neutron::Port
    properties:
        fixed_ips:
            - subnet_id: {get_resource: internal_subnet}
        network: {get_resource: internal_network}
```

* Create a key pair called "HeatKeyPair."
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
    properties: {pool: ext-net}
```

* Allocate a a floating IP to the created instance from a "instance_creation" function. Alternatively, a specific instance's ID can be defined here.
```
floating_ip_association:
    type: OS::Nova::FloatingIPAssociation
    properties:
	    floating_ip: {get_resource: floating_ip}
		server_id: {get_resource: instance_creation}
```

Sources:

1. "OpenStack Orchestration In Depth, Part I: Introduction to Heat." Accessed September 24, 2016. November 7, 2014. https://developer.rackspace.com/blog/openstack-orchestration-in-depth-part-1-introduction-to-heat/


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

Sources:

1. "Vagrant OpenStack Cloud Provider." GitHub - ggiamarchi. Accessed September 24, 2016. April 30, 2016. https://github.com/ggiamarchi/vagrant-openstack-provider

# Testing

## Testing - Tempest

Tempest is used to query all of the different APIs in use. This helps to validate the functionality of OpenStack. This software is a rolling release aimed towards verifying the latest OpenStack release in development but it should also work for older versions as well.

The sample configuration flie "/etc/tempest/tempest.conf.sample" should be copied to "/etc/tempest/tempest.conf" and then modified. If it is not available then the latest configuration file can be downloaded from one of thes sources:
* http://docs.openstack.org/developer/tempest/sampleconf.html
* http://docs.openstack.org/developer/tempest/_static/tempest.conf.sample


* Provide credentials to a user with the "admin" role.
```
admin_username
admin_password
admin_project_name
admin_domain_name
```

* Specify the Keystone version to use. Valid options are "v2" and "v3."
```
auth_version
```

* Provide the Keystone endpoint for v2 (uri) or v3 (uri_v3).
```
uri
uri_v3
```

* Two different size flavor IDs should be given.
```
flavor_ref
flavor_ref_alt
```

* Two different image IDs should be given.
```
image_ref
image_ref_alt
```

[1]

Sources:

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
    * Ensure that all of your domain names (including the public IP) are listed in the /etc/hosts. This avoids a performance hit from DNS lookups. Altneratively, consider setting up a recursive DNS server on the controller nodes.
  * Use memcache.
    * This is generally configured by an option called "memcache_servers" in the configuration files for most services. Consider using "CouchBase" for its ease of clustering and redudancy support.
