# OpenStack Ocata

* [Introduction](#introduction)
    * [Versions](#introduction---versions)
        * [Red Hat OpenStack Platform](#introduction---versions---red-hat-openstack-platform)
    * [Services](#introduction---services)
* [Overview](#overview)
* [Automation](#automation)
    * [PackStack](#automation---packstack)
    * [OpenStack-Ansible](#automation---openstack-ansible)
        * [Quick](#automation---openstack-ansible---quick)
            * [Operations](#automation---openstack-ansible---quick---operations)
        * [Full](#automation---openstack-ansible---full)
            * [Configurations](#automation---openstack-ansible---full---configurations)
                * [Nova](#automation---openstack-ansible---full---configurations---nova)
                * [Ceph](#automation---openstack-ansible---full---configurations---ceph)
            * [Operations](#automation---openstack-ansible---full---operations)
                * [OpenStack Utilities](#automation---openstack-ansible---full---operations---openstack-utilities)
                * [Ansible Inventory](#automation---openstack-ansible---full---operations---ansible-inventory)
                * [Add a Infrastructure Container](#automation---openstack-ansible---full---operations---add-a-infrastructure-container)
                * [Add a Compute Container](#automation---openstack-ansible---full---operations---add-a-compute-container)
            * [Upgrades](#automation---openstack-ansible---full---upgrades)
                * [Minor](#automation---openstack-ansible---full---upgrades---minor)
                * [Major](#automation---openstack-ansible---full---upgrades---major)
    * [TripleO](#automation---tripleo)
        * [Quick](#automation---tripleo---quick)
        * [Full](#automation---tripleo---full)
            * [Undercloud](#automation---tripleo---full---undercloud)
            * Overcloud
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
        * [Ceph](#configurations---nova---ceph)
    * [Neutron](#configurations---neutron)
        * [Network Types](#configurations---neutron---network-types)
            * Provider Networks
                * Open vSwitch
                * Linux Bridge
            * [Self-Service Networks](#configurations---neutron---network-types---self-service-networks)
                * [Open vSwitch](#configurations---neutron---network-types---self-service-networks---open-vswitch)
                * Linux Bridge
        * [DNS](#configurations---neutron---dns)
        * [Metadata](#configurations---neutron---metadata)
        * [Load-Balancing-as-a-Service](#configurations---neutron---load-balancing-as-a-service)
        * [Quality of Service](#configurations---neutron---quality-of-service)
        * [Distributed Virtual Routing](#configurations---neutron---distributed-virtual-routing)
        * [High Availability](#configurations---neutron---high-availability)
    * [Ceph](#configurations---ceph)
    * [Cinder](#configurations---cinder)
        * [Ceph](#configurations---cinder---ceph)
        * [Encryption](#configurations---cinder---encryption)
    * [Glance](#configurations---glance)
        * [Ceph](#configurations---glance---ceph)
* [Neutron Troubleshooting](#neutron-troubleshooting)
    * [Open vSwitch](#neutron-troubleshooting---open-vswitch)
        * Network connections
        * [Floating IPs](#neutron-troubleshooting---open-vswitch---floating-ips)
* [Upgrades](#upgrades)
* [Command Line Interface Utilities](#command-line-interface-utilities)
* [Orchestration](#orchestration)
    * [Heat](#orchestration---heat)
        * [Resources](#orchestration---heat---resources)
        * [Parameters](#orchestration---heat---parameters)
    * [Vagrant](#orchestration---vagrant)
* [Testing](#testing)
    * [Tempest](#testing---tempest)
* [Performance](#performance)


# Introduction

This guide is aimed to help guide Cloud Administrators through deploying, managing, and upgrading OpenStack. Most topics mentioned in this guide can be applied to similar environments and/or versions.


# Introduction - Versions

Each OpenStack release starts with a letter, chronologically starting with A. These are usually named after the city where one of the recent development conferences were held. The major version number of OpenStack represents the major version number of each software in that release. For example, Ocata software is versioned as `15.X.X`. A new release comes out about every 6 months and is supported for 1 year.

Releases:

1. Austin
2. Bexar
3. Cactus
4. Diablo
5. Essex
6. Folsom
7. Grizzly
8. Havana
9. Icehouse
10. Juno
11. Kilo
12. Liberty
13. Mitaka
    * End-of-life (EOL): 2017-04-10
14. Newton
    * EOL: 2017-10-11
15. Ocata
    * EOL: 2018-02-26 [1]
    * Goals:
        1. Stability. This release included features that are mainly related to reliability, scaling, and performance enhancements. This came out 5 months after Newton, instead of the usual 6, due to the minimal amount of major changes. [2]
        2. Remove old OpenStack libraries that were built into some services. Instead, services should rely on the proper up-to-date dependencies provided by external packagse. [3]
16. Pike
    * Currently in development. The expected release date is in September of 2017. [1]
    * Goals:
        1.  Convert all of the OpenStack code from Python 2 into Python 3. This is because Python 2 will become EOL in 2020.
        2.  Make all APIs into WSGI applications. This will allow web servers to scale out and run faster with tuning compared to running as a standalone Python daemon. [4]
17. Queens
    * On the roadmap. [1]

Sources:

1. "OpenStack Releases." OpenStack Releases. April 3, 2017. Accessed April 3, 2017. https://releases.openstack.org/
2. "New OpenStack Ocata stabilizes popular open-source cloud." February 22, 2017. Accessed April 10, 2017. http://www.zdnet.com/article/new-openstack-ocata-stabilizes-popular-open-source-cloud/
3. "Ocata [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/ocata/index.html
4. "Pike [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/pike/index.html


### Introduction - Versions - Red Hat OpenStack Platform

Red Hat OpenStack Platform (RHOSP) is a solution by Red Hat that takes the upstream OpenStack source code and makes it enterprise quality by hardening the security and increasing it's stability. Normal releases are supported for 3 years. Long-life releases were introduced with RHOSP 10 where it will recieve up to 5 years of support. Every 3rd release of RHOSP will have LTS support. Rolling major upgrades are supported from one version to the next sequential version.

Releases:

* RHOSP 3 (Grizzly)
* RHOSP 4 (Havana)
* RHOSP 5 (Icehouse)
    * EOL: 2017-06-30
* RHOSP 6 (Juno)
    * EOL: 2018-02-17
* RHOSP 7 (Kilo)
    * EOL: 2018-08-05
* RHOSP 8 (Liberty)
    * EOL: 2019-04-20
* RHOSP 9 (Mitaka)
    * EOL: 2017-08-24
* RHOSP 10 LTS (Newton)
    * EOL: 2021-12-16
* RHOSP 11 (Ocata)
    * EOL: 2018-05-18

[1]

Source:

1. "Red Hat OpenStack Platform Life Cycle." Red Hat Support. Accessed September 12, 2017. https://access.redhat.com/support/policy/updates/openstack/platform


## Introduction - Services

OpenStack has a large range of services that manage different different components in a modular way.

Most popular services (50% or more of OpenStack cloud operators have adopted):

* Ceilometer = Telemetry
* Cinder = Block Storage
* Glance = Image
* Heat = Orchestration
* Horizon = Dashboard
* Keystone = Authentication
* Neutron = Networking
* Nova = Compute
* Swift = Object Storage


Other services:

* Aodh = Telemetry alarming
* Barbican = Key Management
* CloudKitty = Billing
* Congress = Governance
* Designate = DNS
* Freezer = Backup and recovery
* Ironic = Bare-Metal Provisioning
* Karbor = Data protection
* Magnum = Containers
* Manila = Shared Filesystems
* Mistral = OpenStack Workflow
* Monasca = Monitoring
* Murano = Application Catalog
* Octavia = Load Balancing
* Sahara = Elastic Map Reduce
* Searchlight = Indexing
* Trove = Database
* Zaqar = Messaging
* Zun = Containers

[1]

Source:

1. "Project Navigator." OpenStack. Accessed May 14, 2017. https://www.openstack.org/software/project-navigator/


# Automation

It is possible to easily install OpenStack as an all-in-one (AIO) server or onto a cluster of servers. Various tools exist for automating the deployment and management of OpenStack.


## Automation - PackStack

Supported operating system: RHEL 7

PackStack (sometimes refered to as RDO) provides a simple all-in-one development. Thisis aimed towards developers needing to test new features with the latest code.

First, install the OpenStack repository.

RHEL:
```
# yum install https://www.rdoproject.org/repos/rdo-release.rpm
```

CentOS:
```
# yum install centos-release-openstack-ocata
```

Then install PackStack and generate a configuration file refered to as the "answer" file. This can optionally be customized. Then install OpenStack using the answer file.

```
# yum install openstack-packstack
# packstack --gen-answer-file <FILE>
# packstack --answer-file <FILE>
```

[1]

Source:

1. "All-in-one quickstart: Proof of concept for single node." RDO Project. Accessed April 3, 2017. https://www.rdoproject.org/install/quickstart/


## Automation - OpenStack Ansible

Supported operating systems: RHEL 7, Ubuntu 16.04, openSUSE Leap 42, SUSE Linux Enterprise 12

OpenStack Ansible uses Ansible for automating the deployment of Ubuntu inside of LXC containers that run the OpenStack services. This was created by RackSpace as an official tool for deploying and managing production environments.

It offers key features that include:

* Full LXC containerization of services.
* HAProxy load balancing for clustering containers.
* Scaling for MariaDB Galera, RabbitMQ, compute nodes, and more.
* Central logging with rsyslog.
* OpenStack package repository caching.
* Automated upgrades.

[1]

Source:

1. "OpenStack-Ansible." GitHub. March 30, 2017. Accessed August 25, 2017. https://github.com/openstack/openstack-ansible


### Automation - OpenStack Ansible - Quick

Minimum requirements:

* 8 CPU cores
* 50GB storage
* 8GB RAM (16GB recommended)

This quick installation guide covers how to install an all-in-one environment. It is recommended to deploy this inside of a virtual machine (with nested virtualization enabled) as many system configurations are changed.

Setup the OpenStack-Ansible project.

```
# git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
# cd /opt/openstack-ansible/
# git checkout stable/ocata
```

There are two all-in-one scenarios that will run different Ansible Playbooks. The default is "aio" but this can be changed to the second scenario by setting the `SCENARIO` shell variable to "ceph." Alternatively, the roles to run can be manaully modified in `/opt/openstack-ansible/tests/bootstrap-aio.yml` Playbook.

`# export SCENARIO="ceph"`

* aio
    * cinder.yml.aio
    * designate.yml.aio
    * glance.yml.aio
    * heat.yml.aio
    * horizon.yml.aio
    * keystone.yml.aio
    * neutron.yml.aio
    * nova.yml.aio
    * swift.yml.aio
* ceph:
    * ceph.yml.aio
    * cinder.yml.aio
    * glance.yml.aio
    * heat.yml.aio
    * horizon.yml.aio
    * keystone.yml.aio
    * neutron.yml.aio
    * nova.yml.aio

Extra Playbooks can be added by copying them from `/opt/openstack-ansible/etc/openstack_deploy/conf.d/` to `/etc/openstack_deploy/conf.d/`. The file extensions should be changed from `.yml.aio` to `.yml` to be correctly parsed.

Then OpenStack-Ansible project can now setup and deploy the LXC containers to run OpenStack.

```
# scripts/bootstrap-ansible.sh
# scripts/bootstrap-aio.sh
# scripts/run-playbooks.sh
```

If the installation fails, it is recommended to reinstall the operating system to truly clear out all of the custom configurations that OpenStack-Ansible creates. Running the `scripts/run-playbooks.sh` script will not work again until the existing LXC containers and configurations have been removed. However, this official Bash script can be used to clean up most of the OpenStack-Ansible installation. Use at your own risk.

```
# # Move to the playbooks directory.
cd /opt/openstack-ansible/playbooks

# # Destroy all of the running containers.
openstack-ansible lxc-containers-destroy.yml

# # On the host stop all of the services that run locally and not
# #  within a container.
for i in \
       $(ls /etc/init \
         | grep -e "nova\|swift\|neutron\|cinder" \
         | awk -F'.' '{print $1}'); do \
    service $i stop; \
  done

# # Uninstall the core services that were installed.
for i in $(pip freeze | grep -e "nova\|neutron\|keystone\|swift\|cinder"); do \
    pip uninstall -y $i; done

# # Remove crusty directories.
rm -rf /openstack /etc/{neutron,nova,swift,cinder} \
         /var/log/{neutron,nova,swift,cinder}

# # Remove the pip configuration files on the host
rm -rf /root/.pip

# # Remove the apt package manager proxy
rm /etc/apt/apt.conf.d/00apt-cacher-proxy
```

[1]

Source:

1. "Quick Start." OpenStack Ansible Developer Documentation. March 29, 2017. Accessed March 30, 2017. http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html


#### Automation - OpenStack Ansible - Quick - Operations

A new node can be added at any time to an existing all-in-one deployment. Copy the configuration file for an all-in-one instance.

```
# cd /opt/openstack-ansible/
# cp etc/openstack_deploy/conf.d/<PLAYBOOK_INSTANCE_CONFIGURATION>.yml.aio /etc/openstack_deploy/conf.d/<PLAYBOOK_INSTANCE_CONFIGURATION>.yml
```

Add the new container to the list of inventory servers.

```
# /opt/openstack-ansible/scripts/inventory-manage.py > /dev/null
```

Update the repository server to include the new packages required.

```
# cd playbooks/
# openstack-ansible repo-install.yml
```

Deploy the new contianer and then run the Playbook.

```
# openstack-ansible setup-everything.yml --limit <NEW_CONTAINER_NAME>
# openstack-ansible <PLAYBOOK> --limit <NEW_CONTAINER_NAME>
```

[1]

Source:

1. "Quick Start." OpenStack Ansible Developer Documentation. March 30, 2017. Accessed March 31, 2017. http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html


### Automation - OpenStack Ansible - Full

Minimum requirements:

* 3 infrastructure nodes
* 2 compute nodes
* 1 log node

It is also required to have 4 different network bridges.

* `br-mgmt` = All the nodes should have this network. This is the management network where all nodes can be accessed and managed by.
* `br-storage` = This is the only optional interface. It is recommended to use this to separate the "storage" nodes traffic. This should exist on the "storage" (when using bare-metal) and "compute" nodes.
* `br-vlan` = This should exist on the "network" (when using bare-metal) and "compute" nodes. It is used for self-service networks.
* `br-vxlan` = This should exist on the "network" and "compute" nodes. It is used for self-service networks.

Download and install the latest stable OpenStack Ansible suite from GitHub.

```
# apt-get install git
# git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
# cd /opt/openstack-ansible/
# git checkout stable/ocata
# cp -a -r -v /opt/openstack-ansible/etc/openstack_deploy/ /etc/
```

Then copy over and modify the main configuration file.

```
# cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml
```

[1]

Source:

1. "[OpenStack-Ansible Project Deploy Guide] Overview." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/project-deploy-guide/openstack-ansible/ocata/overview.html


#### Automation - OpenStack Ansible - Full - Configurations

View the `/etc/openstack_deploy/openstack_user_config.yml.prod.example` for a real production example and reference.

Configure the networks that are used in the environment.

* `cider_networks`
    * `container` = The network range that the LXC containers will use an IP address from. This is the management network that is on "br-mgmt."
    * `tunnel` = The network range for accessing network services between the "compute" and "network" nodes over the VXLAN or GRE tunnel interface. The tunnel network should be on "br-vxlan."
    * `storage` = The network range for accessing storage. This is the network that is on "br-storage."
* `used_ips` = Lists of IP addressess that are already in use and should not be used for the container networks.
* `global_overrides`
    * `tunnel_bridge` = The interface to use for tunneling VXLAN traffic. This is typically "br-vxlan."
    * `management_bridge` = The interface to use for management access. This is typically `br-mgmt`.
    * external_lb_vip_address = The public IP address to load balance for API endpoints.
    * `provider_networks`
        * `network` = Different networks can be defined. At least one is required.
            * `type` = The type of network that the "container_bridge" device should be used.
                * flat
                * vlan
                * vxlan
            * `container_bridge` = The bridge device that will be used to connect the container to the network. The recommended deployment scheme recommends setting up a "br-mgmt", "br-storage", "br-vlan", and "br-vlan." Any valid bridge device on the host node can be specified here.
            * `container_type` = veth
            * `ip_from_q` = Specify the "cider_networks" that will be used to allocate IP addresses from.
            * range = The optional VXLAN that the bridge interface should use.
            * `container_interface` = The interface that the LXC container should use. This is typically "eth1."

The syntax for defining which host(s) a service will be installed onto follow this format below. Controller node services are specified with the keyword `-infra` in their name. Each `infra#` entry contains the IP address of the physical server to provision the containers to.

* `<SERVICE_TYPE>`_hosts:
    * infra1:
        * ip: `<HOST1_IP_ADDRESS>`
    * infra2:
        * ip: `<HOST2_IP_ADDRESS>`
    * infra3:
        * ip: `<HOST3_IP_ADDRESS>`


The valid service types are:

* shared-infra = Galera, memcache, RabbitMQ, and other utilities.
* repo-infra_hosts = Hosts that will handle storing and retrieving packages.
* metrics = Gnocchi.
* metering-alartm_hosts = Aodh.
* storage-infra = Cinder.
* image = Glance.
* identity = Keystone.
* haproxy = Load balancers.
* log = Central rsyslog servers
    * `log<#>` = Instead of `infra<#>`, log_hosts uses this variable for defining the host IP address.
* metering-infra = Ceilometer.
* metering-alarm = Aodh.
* metering-compute = Ceilometer for the compute nodes.
* compute-infra = Nova API nodes.
* orchestration = Heat.
* dashboard = Horizon.
* network = Neutron network nodes
* compute = Nova hypervisor nodes.
* storage = Cinder.
* storage-infra
* swift = Swift stores.
* swift-proxy = Swift proxies.
* trove-infra = Trove.
* ceph-mon = Ceph monitors.
* ceph-osd = Ceph OSDs.
* dnsaas = Designate.
* unbound = Caching DNS server nodes.
* magnum-infra = Magnum.
* sahra-infra = Sahara.

[1]

Source:

1. "[OpenStack-Ansible Project Deploy Guide] Overview." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/project-deploy-guide/openstack-ansible/ocata/overview.html


##### Automation - OpenStack Ansible - Full - Configurations - Nova

The default variables for Nova are listed at https://docs.openstack.org/developer/openstack-ansible-os_nova/ocata/. These can be overriden.

Common variables:

* nova_virt_type = The virtualization technology to use for deploying instances with OpenStack. By default, OpenStack-Ansible will guess what should be used based on what is installed on the hypervisor. Valid options are: `qemu`, `kvm`, `lxd`, `ironic`, or `powervm`.

[1]

Source:

1. "Nova role for OpenStack-Ansible." OpenStack Documentation. April 7, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-os_nova/ocata/


##### Automation - OpenStack Ansible - Full - Configurations - Ceph

Ceph can be customized to be deployed differently from the default configuration or to use an existing Ceph cluster.

These settings can be adjusted to use different Ceph users, pools, and/or monitor nodes.

```
# File: /etc/openstack_deploy/user_variables.yml
glance_default_store: rbd
glance_ceph_client: <GLANCE_CEPH_USER>
glance_rbd_store_pool: <GLANCE_CEPH_POOL>
glance_rbd_store_chunk_size: 8
cinder_ceph_client: <CINDER_CEPH_USER>
nova_ceph_client: {{ cinder_ceph_client }}
nova_libvirt_images_rbd_pool: <CINDER_CEPH_POOL>
cephx: true
ceph_mons:
  - <MONITOR1_IP>
  - <MONITOR2_IP>
  - <MONITOR3_IP>
```

By default, OpenStack-Ansible will generate the ceph.conf configuration file by connecting to the Ceph monitor hosts and obtaining the information from there. Extra configuration options can be specified or overriden using the "ceph_extra"confs" dictionary.

```
ceph_extra_confs:
-  src: "<PATH_TO_LOCAL_CEPH_CONFIGURATION>"
   dest: "/etc/ceph/ceph.conf"
   mon_host: <MONITOR_IP>
   client_name: <CEPH_CLIENT>
   keyring_src: <PATH_TO_LOCAL_CEPH_CLIENT_KEYRING_FILE>
   keyring_dest: /etc/ceph/ceph.client.<CEPH_CLIENT>.keyring
   secret_uuid: '{{ cinder_ceph_client_<CEPH_CLIENT> }}'
```

Alternatively, the entire configuration file can be defined as a variable using proper YAML syntax. [2]

```
ceph_conf_file: |
  [global]
  fsid = 00000000-1111-2222-3333-444444444444
  mon_initial_members = mon1.example.local,mon2.example.local,mon3.example.local
  mon_host = {{ ceph_mons|join(',') }}
  auth_cluster_required = cephx
  auth_service_required = cephx
```

A new custom deployment of Ceph can be configured. It is recommended to use at least 3 hosts for high availability and quorum. [1]

```
# File: /etc/openstack_deploy/openstack_user_config.yml
storage_hosts:
  infra<#>:
    ip: <CINDER_HOST1_IP>
    container_vars:
      cinder_backends:
        limit_container_types: cinder_volume
        rbd:
          volume_group: <LVM_BLOCK_STORAGE>
          volume_driver: cinder.volume.drivers.rbd.RBDDriver
          volume_backend_name: rbd
          rbd_pool: <CINDER_CEPH_POOL>
          rbd_ceph_conf: /etc/ceph/ceph.conf
          rbd_user: <CINDER_CEPH_USER>
```

[1]


Sources:

1. "openstack ansible ceph." OpenStack FAQ. April 9, 2017. Accessed April 9, 2017. https://www.openstackfaq.com/openstack-ansible-ceph/
2. "Configuring the Ceph client (optional)." OpenStack Documentation. April 5, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-ceph_client/configure-ceph.html


#### Automation - OpenStack Ansible - Full - Operations


##### Automation - OpenStack Ansible - Full - Operations - OpenStack Utilities

Once OpenStack-Ansible is installed, it can be used immediately. The primary container to use is the `utility` container.

```
# lxc-ls -1 | grep utility
# lxc-attach -n <UTILITY_CONTAINER_NAME>
```

The file `/root/openrc` should exist on the container with the administrator credentials. Source this file to use them.

```
# source /root/openrc
```

Verify that all of the correct services and endpoints exist.

```
# openstack service list
# openstack endpoint list
```

[1]

Source:

1. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017.
https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html


##### Automation - OpenStack Ansible - Full - Operations - Ansible Inventory

Ansible's inventory contains all of the connection and variable details about the hosts (in this case, LXC containers) and which group they are a part of. This section covers finding and using these inventory values for management and troubleshooting.

* Change into the OpenStack-Ansible directory.
```
# cd /opt/openstack-ansible/
```

* Show all of the groups and the hosts that are a part of it.
```
# ./scripts/inventory-manage.py -G
```

* Show all of the hosts and the groups they are a part of.
```
# ./scripts/inventory-manage.py -g
```

* List hosts that a Playbook will run against.
```
# openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP> --list-hosts
```

* List all the Ansible tasks that will be executed on a group or host.
```
# openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP_OR_HOST> --list-tasks
```

[1]

Source:

1. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. May 31, 2017. Accessed May 31, 2017. https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/index.html


##### Automation - OpenStack Ansible - Full - Operations - Add a Infrastructure Container

Add the new host to the `infra_hosts` section in `/etc/openstack_deploy/openstack_user_config.yml`. Then the inventory can be updated which will generate a new unique node name that the OpenStack-Ansible Playbooks can run against. The `--limit` options are important because they will ensure that it will only run on the new infrastructure node.

```
# cd /opt/openstack-ansible/playbooks
# /opt/openstack-ansible/playbooks/inventory/dynamic_inventory.py > /dev/null
# /opt/openstack-ansible/scripts/inventory-manage.py -l |awk '/<NEW_INFRA_HOST>/ {print $2}' | sort -u | tee /root/add_host.limit
# openstack-ansible setup-everything.yml --limit @/root/add_host.limit
# openstack-ansible --tags=openstack-host-hostfile setup-hosts.yml
```

[1]

Source:

1. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017.
https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html


##### Automation - OpenStack Ansible - Full - Operations - Add a Compute Container

Add the new host to the `compute_hosts` section in `/etc/openstack_deploy/openstack_user_config.yml`. Then the OpenStack-Ansible deployment Playbooks can be run again.

```
# cd /opt/openstack-ansible/playbooks
# openstack-ansible setup-hosts.yml --limit <NEW_COMPUTE_HOST_NAME>
# openstack-ansible setup-openstack.yml --skip-tags nova-key-distribute --limit <NEW_COMPUTE_HOST_NAME>
# openstack-ansible setup-openstack.yml --tags nova-key --limit compute_hosts
```
[1]

Source:

1. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017.
https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html


##### Automation - OpenStack Ansible - Full - Operations - Remove a Compute Container

Stop the services on the compute container and then use the `openstack-ansible-ops` project's Playbook `remote_compute_node.yml` to fully it. Be sure to also remove the host from the `/etc/openstack_deploy/openstack_user_config.yml` configuration when done.

```
# lxc-ls -1 | grep compute
# lxc-attach -n <COMPUTE_CONTAINER_TO_REMOVE>
# stop nova-compute
# stop neutron-linuxbridge-agent
# exit
# git clone https://git.openstack.org/openstack/openstack-ansible-ops /opt/openstack-ansible-ops
# cd /opt/openstack-ansible-ops/ansible_tools/playbooks
# openstack-ansible remove_compute_node.yml -e node_to_be_removed="<COMPUTE_CONTAINER_TO_REMOVE>"
```

[1]

Source:

1. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017.
https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html


#### Automation - OpenStack Ansible - Full - Upgrades


##### Automation - OpenStack Ansible - Full - Upgrades - Minor

This is for upgrading OpenStack from one minor version to another in the same major release. An example would be going from 15.0.0 to 15.1.1.

* Change the OpenStack-Ansible version to a new minor tag release. If a branch for a OpenStack release name is being used already, pull the latest branch commits down from GitHub.
```
# cd /opt/openstack-ansible/
# git fetch --all
# git checkout <TAG>
```

* Update:

    * **All services.**
```
# ./scripts/bootstrap-ansible.sh
# cd ./playbooks/
# openstack-ansible setup-hosts.yml
# openstack-ansible -e rabbitmq_upgrade=true setup-infrastructure.yml
# openstack-ansible setup-openstack.yml
```
    * **Specific services.**
        * Update the cached package repository.
```
# cd ./playbooks/
# openstack-ansible repo-install.yml
```
        * A single service can be upgraded now.
```
# openstack-ansible <COMPONENT>-install.yml --limit <GROUP_OR_HOST>
```

        * Some services, such as MariaDB and RabbitMQ, require special variables to be set to force an upgrade.
```
# openstack-ansible galera-install.yml -e 'galera_upgrade=true'
```
```
# openstack-ansible rabbitmq-install.yml -e 'rabbitmq_upgrade=true'
```


[1]

Source:

1. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. May 31, 2017. Accessed May 31, 2017. https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/index.html


##### Automation - OpenStack Ansible - Full - Upgrades - Major

OpenStack-Ansible has scripts capable of fully upgrading OpenStack from one major release to the next. It is recommended to do a manual upgrade by following the official guide: https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/manual-upgrade.html. Below outlines how to do this automatically. [1]

* Move into the OpenStack-Ansible project.
```
# cd /opt/openstack-ansible
```

* View the available OpenStack releases and choose which one to use.
```
# git branch -a
# git tag
```
```
# git checkout <BRANCH_OR_TAG>
```

* Run the upgrade script.
```
# ./scripts/run-upgrade.sh
```

Source:

1. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. April 21, 2017. Accessed April 23, 2017. https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/index.html


## Automation - TripleO

Supported operating systems: RHEL 7, Fedora >= 22

TripleO means "OpenStack on OpenStack." The Undercloud is first deployed in a small, usually all-in-one, environment. This server is then used to create and manage a full Overcloud cluster. Virtual machines or physical servers can be used. [1]

Source:

1. "tripleo-quickstart." TripleO Quickstart GitHub. January 10, 2017. Accessed January 15, 2017. https://github.com/openstack/tripleo-quickstart


### Automation - TripleO - Quick

The "TripleO-Quickstart" project was created to use Ansible to automate deploying TripleO as fast as possible. [1]

The minimum requirement for an all-in-one deployment is a hypervisor with 8 processor cores and 16GB of RAM (preferably 32GB). 3 virtual machines will be created to meet the minimum cloud requirements: (1) an Undercloud to deploy a (2) controller and (3) computer node. [2] For truly isolated environments, a KVM virtual machine with nested virtualization can be used.

* Download tripleo-quickstart script or clone the entire repository from GitHub.
```
$ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh
```
```
$ git clone https://github.com/openstack/tripleo-quickstart.git
$ cd tripleo-quickstart
```

* Installl dependencies for the quickstart script.
```
$ bash quickstart.sh --install-deps
```

* Run the quickstart script to install TripleO. Use "127.0.0.2" as the localhost IP address if TripleO will be installed on the same system that the quickstart commmand is running on. `--clean` will recreate the Python dependencies and `--teardown all` will remove any lingering files from a previous tripleo-quickstart deployment.
```
$ bash quickstart.sh -v --clean --teardown all --release trunk/ocata <HYPERVISOR_IP>
```

* Note that all of the available releases can be found in the GitHub project in the `config/release/` directory. Use "trunk/`<RELEASE_NAME>`" for the development version and "stable/`<RELEASE_NAME>`" for the stable version.

[1]

Sources:

1. "TripleO quickstart." RDO Project. Accessed August 16, 2017. https://www.rdoproject.org/tripleo/
2. "[TripleO] Minimum System Requirements." TripleO Documentation. Accessed August 16, 2017. https://images.rdoproject.org/docs/baremetal/requirements.html


### Automation - TripleO - Full


## Automation - TripleO - Full - Undercloud

* **Hypervisor**
    * Install the EPEL for extra packages that will be required.
```
# yum install epel-release
```
    * Install the Undercloud environment deployment tools.
```
# yum install instack-undercloud
```
    * Deploy a new virtual machine to be used for the Undercloud.
```
# instack–virt–setup
```
    * Log into the virtual machine with the provided credentials from the previous command.
```
# ssh root@<VIRTUAL_MACHINE_IP>
```

* **Undercloud virtual machine**
    * Install the stable RDO Delorean repositories.
```
# curl -L -o /etc/yum.repos.d/delorean-ocata.repo https://trunk.rdoproject.org/centos7-ocata/current/delorean.repo
# curl -L -o /etc/yum.repos.d/delorean-deps-newton.repo https://trunk.rdoproject.org/centos7-newton/delorean-deps.repo
```
    * Install TripleO.
```
# yum install python-tripleoclient
```
    * It is recommended to create a user named "stack" with sudo privileges to manage the Undercloud.
    * Copy the sample configuration to use as a base template.
```
$ cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf
```
    * At the very least the "local_ip" and "local_interface" variables need to be defined in the "DEFAULT" section.
    * Deploy an all-in-one Undercloud on the virtual machine.
```
$ openstack undercloud install
```
    * The installation will be logged to `$HOME/.instack/install-undercloud.log`.
    * After the installation, OpenStack user credentials will be saved to `$HOME/stackrc`. Source this file before running OpenStack commands to verify that the Undercloud is operational.
```
$ source ~/stackrc
$ openstack catalog list
```
    * All OpenStack service passwords will be saved to `$HOME/undercloud-passwords.conf`.

[1]

Source:

1. "TripleO Documentation." OpenStack Documentation. Accessed September 12, 2017. https://docs.openstack.org/tripleo-docs/latest/


# Configurations

This section will focus on important settings for each service's configuration files.


## Configurations - Common

These are general configuration options that apply to most OpenStack configuration files.


### Configurations - Common - Database

Different database backends can be used by the API services on the controller nodes.

* MariaDB/MySQL. Requires the "PyMySQL" Python library. Starting with Liberty, this is prefered on Ubuntu over using "`mysql://`" as the latest OpenStack libraries are written for PyMySQL connections (not to be confused with "MySQL-python"). [1] RHEL still requires the use of the legacy "`mysql://`" connector. [4]
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
* MongoDB is generally only used for Ceilometer when it is not using the Gnocchi back-end. [3]
```
[ database ] mongodb://<USER>:<PASSWORD>@<MONGODB_HOST>:<MONGODB_PORT>/<DATABASE>
```

Sources:

1. "DevStack switching from MySQL-python to PyMySQL." OpenStack nimeyo. Jun 9, 2015. Accessed October 15, 2016. https://openstack.nimeyo.com/48230/openstack-all-devstack-switching-from-mysql-python-pymysql
2. "Using PostgreSQL with OpenStack." FREE AND OPEN SOURCE SOFTWARE KNOWLEDGE BASE. June 06, 2014. Accessed October 15, 2016. https://fosskb.in/2014/06/06/using-postgresql-with-openstack/
3. "Install and configure [Ceilometer] for Red Hat Enterprise Linux and CentOS." OpenStack Documentation. March 24, 2017. Accessed April 3, 2017. https://docs.openstack.org/project-install-guide/telemetry/ocata/install-base-rdo.html
4. "Liberty install guide RHEL, keystone DB population unsuccessful: Module pymysql not found." OpenStack Manuals Bugs. March 24, 2017. Accessed April 3, 2017. https://bugs.launchpad.net/openstack-manuals/+bug/1501991


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

1. "Message queue." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/environment-messaging.html
2. "RPC messaging configurations." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/common-configurations/rpc.html
3. "ZeroMQ Driver Deployment Guide." OpenStack Documentation. February 16, 2017. Accessed February 18, 2017. https://docs.openstack.org/developer/oslo.messaging/zmq_driver.html


## Configurations - Keystone


### Configurations - Keystone - API v3

In Newton, the Keystone v2.0 API has been completely deprecated. It will be removed entirely from OpenStack in the `Queens` release. [1] It is possible to run both v2.0 and v3 at the same time but it's desirable to move towards the v3 standard. If both have to be enabled, services should be configured to use v2.0 or else problems can occur with v3's domain scoping. For disabling v2.0 entirely, Keystone's API paste configuration needs to have these lines removed (or commented out) and then the web server should be restarted.

* /etc/keystone/keystone-paste.ini
    * [pipeline:public_api]
        * pipeline = cors sizelimit url_normalize request_id admin_token_auth build_auth_context token_auth json_body ec2_extension public_service
    * [pipeline:admin_api]
        * pipeline = cors sizelimit url_normalize request_id admin_token_auth build_auth_context token_auth json_body ec2_extension s3_extension admin_service
    * [composite:main]
        * /v2.0 = public_api
    * [composite:admin]
        * /v2.0 = admin_api

[2]

Sources:

1. "Newton Series Release Notes." Accessed February 18, 2017. http://docs.openstack.org/releasenotes/keystone/newton.html
2. "Setting up an RDO deployment to be Identity V3 Only." Young Logic. May 8, 2015. Accessed October 16, 2016. https://adam.younglogic.com/2015/05/rdo-v3-only/


### Configurations - Keystone - Token Provider

The token provider is used to create and delete tokens for authentication. Different providers can be used as the backend.

#### Scenario #1 - UUID (default)

* /etc/keystone/keystone.conf
    * [token]
        * provider = uuid

#### Scenario #2 - PKI

PKI tokens have been removed since the Ocata release. [3]

* /etc/keystone/keystone.conf
    * [token]
        * provider = pki
* Create the certificates. A new directory "/etc/keystone/ssl/" will be used to store these files.
```
# keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
```

#### Scenario #3 - Fernet (fastest token creation)

A public and private key wil need to be created for Fernet and the related Credential authentication.

* /etc/keystone/keystone.conf
    * [token]
        * provider = fernet
    * [fernet_tokens]
        * key_repository = /etc/keystone/fernet-keys/
    * [credential]
        * provider = fernet
        * key_repository = /etc/keystone/credential-keys/
    * [token]
        * provider = fernet
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
3. "Ocata Series [Keystone] Release Notes." OpenStack Documentation. Accessed April 3, 2017. https://docs.openstack.org/releasenotes/keystone/ocata.html
4. "Install and configure [Keystone]." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/keystone-install.html


## Configurations - Nova

* /etc/nova/nova.conf
    * [libvirt]
        * inject_key = false
	        * Do not inject SSH keys via Nova. This should be handled by the Nova's metadata service. This will either be "openstack-nova-api" or "openstack-nova-metadata-api" depending on your setup.
    * [DEFAULT]
        * enabled_apis = osapi_compute,metadata
	        * Enable support for the Nova API and Nova's metadata API. If "metedata" is specified here, then the "openstack-nova-api" handles the metadata and not "openstack-nova-metadata-api."
    * [api_database]
        * connection = connection=mysql://nova:password@10.1.1.1/nova_api
    * [database]
        * connection = mysql://nova:password@10.1.1.1/nova
	        * For the controller nodes, specify the connection SQL connection string. In this example it uses MySQL, the MySQL user "nova" with a password called "password", it connects to the IP address "10.1.1.1" and it is using the database "nova."


### Configurations - Nova - Hypervisors

Nova supports a wide range of virtualization technologies. Full hardware virtualization, paravirtualization, or containers can be used. Even Windows' Hyper-V is supported. [1]


#### Scenario #1 - KVM

* /etc/nova/nova.conf
    * [DEFAULT]
        * compute_driver = libvirt.LibvirtDriver
    * [libvirt]
        * virt_type = kvm

[2]


#### Scenario #2 - Xen

* /etc/nova/nova.conf
    * [DEFAULT]
        * compute_driver = libvirt.LibvirtDriver
    * [libvirt]
        * virt_type = xen

[3]


#### Scenario #3 - LXC

* /etc/nova/nova.conf
    * [DEFAULT]
        * compute_driver = libvirt.LibvirtDriver
    * [libvirt]
        * virt_type = lxc

[4]

Sources:

1. "Hypervisors." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisors.html
2. "KVM." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisor-kvm.html
3. "Xen." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisor-xen-libvirt.html
4. "LXC (Linux containers)." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisor-lxc.html


### Configurations - Nova - CPU Pinning

* Verify that the processor(s) has hardware support for non-uniform memory access (NUMA). If it does, NUMA may still need to be turned on in the BIOS. NUMA nodes are the physical processors. These processors are then mapped to specific sectors of RAM.
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

* Append the two NUMA filters `NUMATopologyFilter` and `AggregateInstanceExtraSpecsFilter` to the Nova `scheduler_default_filters`. [1]
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
# openstack aggregate create <AGGREGATE_ZONE>
# openstack aggregate set --property pinned=true <AGGREGATE_ZONE>
```

* Add the compute hosts to the new aggregate zone.
```
# openstack host list | grep compute
# openstack aggregate host add <AGGREGATE_ZONE> <COMPUTE_HOST>
```

* Modify a flavor to provide dedicated CPU pinning.
```
# openstack flavor set <FLAVOR_ID> --property hw:cpu_policy=dedicated --property hw:cpu_thread_policy=prefer
```

* Optionally, force images to only work with CPU pinned flavors. [2]
```
# openstack image set <IMAGE_ID> --property hw_cpu_policy=dedicated --property hw_cpu_thread_policy=isolate
```

Sources:

1. "Driving in the Fast Lane – CPU Pinning and NUMA Topology Awareness in OpenStack Compute." Red Hat Stack. Mary 5, 2015. Accessed April 13, 2017. http://redhatstackblog.redhat.com/2015/05/05/cpu-pinning-and-numa-topology-awareness-in-openstack-compute/
2. "OpenStack Administrator Guide SUSE OpenStack Cloud 7." SUSE Documentation. February 22, 2017. Accessed April 13, 2017. https://www.suse.com/documentation/suse-openstack-cloud-7/pdfdoc/book_cloud_admin/book_cloud_admin.pdf


### Configurations - Nova - Ceph

Nova can be configured to use Ceph as the storage provider for the instance. This works with any QEMU based hypervisor.

* /etc/nova/nova.conf
    * [libvirt]
        * images_type = rbd
        * images_rbd_pool = `<CEPH_VOLUME_POOL>`
        * images_rbd_ceph_conf = /etc/ceph/ceph.conf
        * rbd_user = `<CEPHX_USER>`
        * rbd_secret_uuid = `<LIBVIRT_SECRET_UUID>`

[1]

Source:

1. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack


## Configurations - Neutron


### Configurations - Neutron - Network Types

In OpenStack, there are two common scenarios for networks.

The first is known as `self-service` networks. This is a simpler approach to providing virtual machines direct access to a bridge device. A public IP address can be assigned for the instance to have direct Internet access.

The second approach is known as `provider` networks. These are more complex but allow full customization of private networks that can also be used with network address translation (NAT) for Internet access. With Open vSwitch, private networks can be created with VLAN, VXLAN, and/or GRE tagging to create isolated networks.

[1]

Source:

1. "[RDO Installation] Overview." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/overview.html


#### Configurations - Neutron - Network Types - Self-Service Networks


##### Configurations - Neutron - Network Types - Self-Service Networks - Open vSwitch

One device is required, but it is recommended to separate traffic onto two different network interfaces. There is `br-vlan` (sometimes also referred to as `br-provider`) for internal tagged traffic and `br-ex` for external connectivity.

```
# ovs-vsctl add-br br-vlan
# ovs-vsctl add-port br-vlan <VLAN_INTERFACE>
# ovs-vsctl add-br br-ex
# ovs-vsctl add-port br-ex <EXTERNAL_INTERFACE>
```

* /etc/neutron/neutron.conf
    * [DEFAULT]
        * core_plugin = ml2
        * service_plugins = router
        * allow_overlapping_ips = True
* /etc/neutron/plugins/ml2/ml2_conf.ini
    * [ml2]
        * type_drivers = flat,vlan,vxlan
        * tenant_network_types = vxlan
        * mechanism_drivers = linuxbridge,l2population
        * ml2_type_vxlan = `<START_NUMBER>`,`<END_NUMBER>`
* /etc/neutron/plugins/ml2/openvswitch_agent.ini
    * [ovs]
        * bridge_mappings = `<LABEL>`:br-vlan
            * The `<LABEL>` can be any unique name. It is used as an alias for the interface name.
        * local_ip = `<IP_ADDRESS>`
            * This IP address should be accesible on the `br-vlan` interface.
    * [agent]
        * tunnel_types = vxlan
        * l2_population = True
    * [securitygroup]
        * firewall_driver = iptables_hybrid
* /etc/neutron/l3_agent.ini
    * [DEFAULT]
        * interface_driver = openvswitch
        * external_network_bridge =
            * This value should be left defined but blank.

[1]

On the controller node, restart the Nova API service and then start the required Neutron services.

```
# systemctl restart openstack-nova-api
# systemctl enable neutron-server neutron-openvswitch-agent neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent
# systemctl start neutron-server neutron-openvswitch-agent neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent
```

Finally, on the compute nodes, restart the compute service and then start the Open vSwitch agent.

```
# systemctl restart openstack-nova-compute
# systemctl enable neutron-openvswitch-agent
# systemctl start neutron-openvswitch-agent
```

[2]

Sources:

1. "Open vSwitch: Self-service networks." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/networking-guide/deploy-ovs-selfservice.html
2. "[Installing the] Networking service." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/neutron.html


### Configurations - Neutron - DNS

By default, Neutron does not provide any DNS resolvers. This means that DNS will not work. It is possible to either provide a default list of name servers or configure Neutron to refer to the relevant /etc/resolv.conf file on the server.

#### Scenario #1 - Define default resolvers (recommended)

* /etc/neutron/dhcp_agent.ini
    * [DEFAULT]
        * dnsmasq_dns_servers = 8.8.8.8,8.8.4.4

#### Scenario #2 - Leave resolvers to be configured by the subnet details

* Nothing needs to be configured. This is the default setting.

#### Scenario #3 - Do not provide resolvers

* /etc/neutron/dhcp_agent.ini
    * [DEFAULT]
        * dnsmasq_local_resolv = True

[1]

Source:

1. "Name resolution for instances." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/networking-guide/config-dns-res.html


### Configurations - Neutron - Metadata

The metadata service provides useful information about the instance from the IP address 169.254.169.254/32. This service is also used to communicate with "cloud-init" on the instance to configure SSH keys and other post-boot tasks.

Assuming authentication is already configured, set these options for the OpenStack environment. These are the basics needed before the metadata service can be used correctly. Then you can choose to use DHCP namespaces (layer 2) or router namespaces (layer 3) for delievering/receiving requests.

* /etc/neutron/metadata_agent.ini
    * [DEFAULT]
        * nova_metadata_ip = CONTROLLER_IP
        * metadata_proxy_shared_secret = `<SECRET_KEY>`
* /etc/nova/nova.conf
    * [DEFAULT]
        * enabled_apis = osapi_compute,metadata
    * [neutron]
        * service_metadata_proxy = True
        * metadata_proxy_shared_secret = `<SECRET_KEY>`

#### Scenario #1 - DHCP Namespace (recommended for DVR)

* /etc/neutron/dhcp_agent.ini
    * [DEFAULT]
        * force_metadata = True
        * enable_isolated_metadata = True
        * enable_metadata_network = True
* /etc/neutron/l3_agent.ini
    * [DEFAULT]
        * enable_metadata_proxy = False

#### Scenario #2 - Router Namespace

* /etc/neutron/dhcp_agent.ini
    * [DEFAULT]
        * force_metadata = False
        * enable_isolated_metadata = True
        * enable_metadata_network = False
* /etc/neutron/l3_agent.ini
    * [DEFAULT]
        * enable_metadata_proxy = True

[1]

Source:

1. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/


### Configurations - Neutron - Load-Balancing-as-a-Service

Load-Balancing-as-a-Service version 2 (LBaaSv2) has been stable since Liberty. It can be configured with either the HAProxy or Octavia back-end.

* /etc/neutron/neutron.conf
    * [DEFAULT]
        * service_plugins = `<EXISTING_PLUGINS>`, neutron_lbaas.services.loadbalancer.plugin.LoadBalancerPluginv2
            * Append the LBaaSv2 service plugin.
*   /etc/neutron/lbaas_agent.ini
    * [DEFAULT]
        * interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
            * This is for Neutron with the Open vSwitch backend only.
        * interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver
            * This is for Neutron with the Linux Bridge backend only.

#### Scenario #1 - HAProxy (recommended for it's maturity)

* /etc/neutron/neutron_lbaas.conf
    * [service_providers]
        * service_provider = LOADBALANCERV2:Haproxy:neutron_lbaas.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default
* /etc/neutron/lbaas_agent.ini
    * [DEFAULT]
        * device_driver = neutron_lbaas.drivers.haproxy.namespace_driver.HaproxyNSDriver
    * [haproxy]
        * user_group = haproxy
            * Specify the group that HAProxy runs as. In RHEL, it's `haproxy`.

#### Scenario #2 - Octavia

* /etc/neutron/neutron_lbaas.conf
    * [service_providers]
        * service_provider = LOADBALANCERV2:Octavia:neutron_lbaas.drivers.octavia.driver.OctaviaDriver:default

[1]

Source:

1. "Load Balancer as a Service (LBaaS)." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. http://docs.openstack.org/draft/networking-guide/config-lbaas.html


### Configurations - Neutron - Quality of Service

The Quality of Service (QoS) plugin can be used to rate limit the amount of bandwidth that is allowed through a network port.

* /etc/neutron/neutron.conf
    * [DEFAULT]
        * service_plugins = neutron.services.qos.qos_plugin.QoSPlugin
            * Append the QoS plugin to the list of service_plugins.
* /etc/neutron/plugins/ml2/openvswitch_agent.ini
    * [ml2]
        * extension_drivers = qos
            * Append the QoS driver with the modular layer 2 plugin provider. In this example it is added to Open vSwitch. LinuxBridge and SR-IOV also support the quality of service extension.
* /etc/neutron/plugins/ml2/ml2_conf.ini
    * [agent]
        * extensions = qos
            * Append the QoS extension to the modular layer 2 configuration.

[1]

Source:

1. "Quality of Service (QoS)." OpenStack Documentation. October 10, 2016. Accessed October 16, 2016. http://docs.openstack.org/draft/networking-guide/config-qos.html


### Configurations - Neutron - Distributed Virtual Routing

Distributed virtual routing (DVR) is a concept that involves deploying routers to both the compute and network nodes to spread out resource usage. All layer 2 traffic will be equally spread out among the servers. Public floating IPs will still need to go through the SNAT process via the routers on the network nodes. This is only supported when the Open vSwitch agent is used. [1]

* /etc/neutron/neutron.conf
    * [DEFAULT]
        * router_distributed = true
* /etc/neutron/l3_agent.ini (compute)
    * [DEFAULT]
        * agent_mode = dvr
* /etc/neutron/l3_agent.ini (network or all-in-one)
    * [DEFAULT]
        * agent_mode = dvr_snat
* /etc/neutron/plugins/ml2/ml2_conf.ini
    * [ml2]
        * mechanism_drivers = openvswitch, l2population
* /etc/neutron/plugins/ml2/openvswitch_agent.ini
    * [agent]
        * l2_population = true
    * [agent]
        * enable_distributed_routing = true

Source:

1. "Neutron/DVR/HowTo" OpenStack Wiki. January 5, 2017. Accessed March 7, 2017.  https://wiki.openstack.org/wiki/Neutron/DVR/HowTo


### Configurations - Neutron - High Availability

High availability (HA) in Neutron allows for routers to failover to another duplicate router if one fails or is no longer present. All new routers will be highly available.

* /etc/neutron/neutron.conf
    * [DEFAULT]
        * l3_ha = true
        * max_l3_agents_per_router = 2
        * allow_automatic_l3agent_failover = true


[1]

Source:

1. "Distributed Virtual Routing with VRRP." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/networking-guide/config-dvr-ha-snat.html


## Configurations - Ceph

For Cinder and/or Glance to work with Ceph, the Ceph configuration needs to exist on each controller and compute node. This can be copied over from the Ceph nodes. An example is provided below.

```
[global]
fsid = <UNIQUE_ID>
mon_initial_members = <CEPH_MONITOR1_HOSTNAME>
mon_host = <CEPH_MONITOR1_IP_ADDRESS>
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx
osd_pool_default_size = 2
public_network = <CEPH_NETWORK_CIDR>

[mon]
mon_host = <CEPH_MONITOR1_HOSTNAME>, <CEPH_MONITOR2_HOSTNAME>, <CEPH_MONITOR3_HOSTNAME>
mon_addr = <CEPH_MONITOR1_IP_ADDRESS>:6789, <CEPH_MONITOR2_IP_ADDRESS>:6789, <CEPH_MONITOR3_IP_ADDRESS>:6789

[mon.a]
host = <CEPH_MONITOR1_HOSTNAME>
mon_addr = <CEPH_MONITOR1_IP_ADDRESS>:6789

[mon.b]
host = <CEPH_MONITOR2_HOSTNAME>
mon_addr = <CEPH_MONITOR2_IP_ADDRESS>:6789

[mon.c]
host = <CEPH_MONITOR3_HOSTNAME>
mon_addr = <CEPH_MONITOR3_IP_ADDRESS>:6789
```

It is recommended to create a separate pool and related user for both the Glance and Cinder service.

```
# ceph osd pool create glance <PG_NUM> <PGP_NUM>
# ceph osd pool create cinder <PG_NUM> <PGP_NUM>
# ceph auth get-or-create client.cinder mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=volumes'
# ceph auth get-or-create client.glance mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=images'
```

If Cephx is turned on to utilize authentication, then a client keyring file should be created on the controller and compute nodes. This will allow the services to communicate to Ceph as a specific user. The usernames should match the client users that were just created. [1]

```
# vim /etc/ceph/ceph.client.<USERNAME>.keyring
[client.<USERNAME>]
        key = <KEY>
```

On the controller and compute nodes the Nova, Cinder, and Glance services require permission to read the `/etc/ceph/ceph.conf` and client configurations at `/etc/ceph/ceph.client.<USERNAME>.keyring`. The service users should be added to a common group to help securely share these settings.

```
# for openstack_service in "cinder glance nova"; do usermod -a -G ceph ${openstack_service}; done
# chmod -R 640 /etc/ceph/
# chown -R ceph.ceph /etc/ceph/
```

For the services to work, the relevant Python libraries for accessing Ceph need to be installed. These can be installed by the operating system's package manager. [2]

RHEL:
```
python-ceph-compat
python-rbd
```

Debian:
```
python-ceph
```


Sources:

1. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
2. "[Glance] Basic Configuration." OpenStack Documentation. April 5, 2017. Accessed April 5, 2017. https://docs.openstack.org/developer/glance/configuring.html


## Configurations - Cinder

The Cinder service provides block devices for instances.


### Configurations - Cinder - Ceph

Ceph has become the most popular backend to Cinder due to it's high availability and scalability.

* /etc/cinder/cinder.conf
    * [DEFAULT]
        * enabled_backends = ceph
            * Use the `[ceph]` section for the backend configuration. This new section can actually be named anything but the same name must be used here.
        * volume_backend_name = volumes
        * rados_connect_timeout = -1
    * [ceph]
        * volume_driver = cinder.volume.drivers.rbd.RBDDriver
            * Use Cinder's RBD Python library.
        * rbd_pool = volumes
            * This is the RBD pool to use for volumes.
        * rbd_ceph_conf = /etc/ceph/ceph.conf
        * rbd_flatten_volume_from_snapshot = false
            * Ceph supports efficent thin provisioned snapshots.
        * rbd_max_clone_depth = 5
        * rbd_store_chunk_size = 4
        * rados_connect_timeout = -1
        * glance_api_version = 2
* /etc/nova/nova.conf
    * [libvirt]
        * images_type = rbd
        * images_rbd_pool = volumes
        * images_rbd_ceph_conf = /etc/ceph/ceph.conf
        * rbd_user = cinder
        * rbd_secret_uuid = `<LIBVIRT_SECRET_UUID>`
            * This is the Libvirt secret UUID that allows for authentication with Cephx. It is configured with the `virsh` secret commands. Refer to the Root Page's `Virtualization` guide for more information.
```
# virsh --help | grep secret
```

[1]

Source:

1. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack


### Configurations - Cinder - Encryption

Cinder volumes support the Linux LUKS encryption. The only requirement is that the compute nodes have the "cryptsetup" package installed. [1]

```
$ openstack volume type create LUKS
$ cinder encryption-type-create --cipher aes-xts-plain64 --key_size 512 --control_location front-end LUKS nova.volume.encryptors.luks.LuksEncryptor
```

Encrypted volumes can now be created.

```
$ openstack volume create --size <SIZE_IN_GB> --type LUKS <VOLUME_NAME>
```

Source:

1. "Volume encryption supported by the key manager" Openstack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/block-storage/volume-encryption.html


## Configurations - Glance

Glance is used to store and manage images for instance deployment.


### Configurations - Glance - Ceph

Ceph can be used to store images.

* /etc/glance/glance-api.conf
    * [DEFAULT]
        * show_image_direct_url = True
            * This will allow copy-on-write (CoW) operations for efficent usage of storage for instances. Instead of cloning the entire image, CoW will be used to store changes between the instance and the original image. This assumes that Cinder is also configured to use Ceph.
            * The back-end Ceph addressing will be viewable by the public Glance API. It is important to make sure that Ceph is not publicly accessible.
    * [glance_store]
        * stores = rbd
        * default_store = rbd
        * rbd_store_pool = `<RBD_POOL>`
        * rbd_store_user = `<RBD_USER>`
        * rbd_store_ceph_conf = /etc/ceph/ceph.conf
        * rbd_store_chunk_size = 8

[1]

Source:

1. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack/


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


# Orchestration

Automating deployments can be accomplished in a few ways. The built-in OpenStack way is via Orhcestration as a Service (OaaS), typically handled by Heat. It is also possible to use Ansible or Vagrant to automate OpenStack deploys.


## Orchestration - Heat

Heat is used to orchestrate the deployment of multiple OpenStack components at once. It can also install and configure software on newly built instances.


### Orchestration - Heat - Resources

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


### Orchestration - Heat - Parameters

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


## Orchestration - Vagrant

Vagrant is a tool to automate the deployment of virtual machines. A "Vagrantfile" file is used to initalize the instance. An example is provided below.

```
require 'vagrant-openstack-provider'

Vagrant.configure('2') do |config|

  config.vm.box       = 'vagrant-openstack'
  config.ssh.username = 'cloud-user'

  config.vm.provider :openstack do |os|
    identity_api_version  = '3'
    os.openstack_auth_url = 'http://controller1/v3/auth/tokens'
    os.domain             = 'default'
    os.username           = 'openstackUser'
    os.password           = 'openstackPassword'
    os.project_name       = 'myProject'
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

1. "Vagrant OpenStack Cloud Provider." GitHub - ggiamarchi. January 30, 2017. Accessed April 3, 2017. https://github.com/ggiamarchi/vagrant-openstack-provider


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
