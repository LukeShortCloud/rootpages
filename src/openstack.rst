OpenStack Queens
================

.. contents:: Table of Contents

Introduction
------------

This guide is aimed to help Cloud Administrators through deploying, managing, and upgrading OpenStack.

Versions
~~~~~~~~

Each OpenStack release starts with a letter, chronologically starting with A. These are usually named after the city where one of the recent development conferences were held. The major version number of OpenStack represents the major version number of each software in that release. For example, Ocata software is versioned as ``15.X.X``. A new release comes out after about 6 months of development. After a release, phase 1 of support provides bug fixes for 6 months. Then phase 2 starts for the next 6-12 months that will only provide major bug fixes. Phase 3 only provides security patches for the now end-of-life (EOL) release. Each release is typically supported for 1 year before becoming EOL. [69]

Releases:

1.  Austin
2.  Bexar
3.  Cactus
4.  Diablo
5.  Essex
6.  Folsom
7.  Grizzly
8.  Havana
9.  Icehouse
10. Juno
11. Kilo
12. Liberty
13. Mitaka
14. Newton

    -  Release: 2016-10-06
    -  EOL: 2017-10-11

15. Ocata

    -  Release: 2017-02-22
    -  EOL: 2018-02-26 [1]
    -  Goals:

       -  Stability. This release included features that are mainly related to reliability, scaling, and performance enhancements. This came out 5 months after Newton, instead of the usual 6, due to the minimal amount of major changes. [2]
       -  Remove old OpenStack libraries that were built into some services. Instead, services should rely on the proper up-to-date dependencies provided by external packages. [3]

    - `New Features <https://www.openstack.org/news/view/302/openstack-ocata-strengthens-core-infrastructure-services-and-container-integration-with-15th-release-of-cloud-computing-software>`__

16. Pike

    -  Release: 2017-08-30
    -  EOL: 2018-09-03 [1]
    -  Goals:

       -  Convert all of the OpenStack code to be compatible with Python 3. This is because Python 2 will become EOL in 2020.
       -  Make all APIs into WSGI applications. This will allow web servers to scale out and run faster with tuning compared to running as a standalone Python daemon. [4]

    -  `New Features <https://www.openstack.org/news/view/340/openstack-pike-delivers-composable-infrastructure-services-and-improved-lifecycle-management>`__

17. Queens

    -  Release: 2018-02-28
    -  EOL: 2019-02-25
    -  Goals:

       -  Remove the need for the access control list "policy" files by having default values defined in the source code.
       -  Tempest will be split up into different projects for maintaining individual service unit tests. This contrasts with the old model that had all Tempest tests maintained in one central repository. [5]

    -  `New Features <https://www.openstack.org/news/view/371/openstack-queens-release-expands-support-for-gpus-and-containers-to-meet-edge-nfv-and-machine-learning-workload-demands>`__

18. Rocky

    -  Expected release: 2018-08-30 [1]

Red Hat OpenStack Platform
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Red Hat provides most of the development to the core OpenStack services.
The RPM Distribution of OpenStack (RDO) project is a community project
lead by Red Hat to use the latest upstream code from OpenStack and
package it to work and be distributable on Red Hat Enterprise Linux and
Fedora based operating systems. [7]

The Red Hat OpenStack Platform (RHOSP) is a solution by Red Hat that
takes the upstream OpenStack source code and makes it enterprise quality
by hardening the security and increasing it's stability. Normal releases
are supported for 3 years. Long-life (LL) releases were introduced with
RHOSP 10 where it will receive up to 5 years of support. Every 3rd
release of RHOSP will have LL support. Rolling major upgrades are
supported from one version to the next sequential version, starting with
RHOSP 8.

Releases:

-  RHOSP 3 (Grizzly)

   -  Release: 2013-07-10
   -  EOL: 2014-07-31

-  RHOSP 4 (Havana)

   -  Release: 2013-12-19
   -  EOL: 2015-06-19

-  RHOSP 5 (Icehouse)

   -  Release: 2014-06-30
   -  EOL: 2017-06-30

-  RHOSP 6 (Juno)

   - Release: 2015-02-09
   -  EOL: 2018-02-17

-  RHOSP 7 (Kilo)

   - Release: 2015-08-05
   -  EOL: 2018-08-05

-  RHOSP 8 (Liberty)

   -  Release: 2016-04-20
   -  EOL: 2019-04-20

-  RHOSP 9 (Mitaka)

   -  Release: 2016-08-24
   -  EOL: 2017-08-24

-  **RHOSP 10 LL (Newton)**

   -  Release: 2016-12-15
   -  EOL: 2021-12-16

-  RHOSP 11 (Ocata)

   -  Release: 2017-05-18
   -  EOL: 2018-05-18

-  RHOSP 12 (Pike)

   -  Release: 2017-12-13
   -  EOL: 2018-12-13

[6]

RHOSP 10 supports these 4 hypervisors [9]:

-  Kernel-based Virtual Machine (QEMU with KVM acceleration)
-  Red Hat Enterprise Virtualization (RHEV)
-  Microsoft Hyper-V
-  VMWare ESX and ESXi

The version of RHOSP in use can be found on the Undercloud by viewing
the "/etc/rhosp-release" file.

.. code-block:: sh

    $ cat /etc/rhosp-release
    Red Hat OpenStack Platform release 10.0 (Newton)

On other nodes, the version can be found by checking the "version" and
"release" of the RPM packages. The version consists of the year and
month of the upstream OpenStack release. The last number in the version
is the bugfix release for this specific package. The release section is
the minor version of the RHOSP. In the example below, the upstream
OpenStack release is Newton that was released on the 10th month of 2016.
The corresponding major RHOSP version is 10 for Newton. This is the 2nd
bugfix release for the package "openstack-nova-common." The minor
release is 8. The full RHOSP version is referenced as "10z8." [8]

.. code-block:: sh

    $ rpm -qi openstack-nova-common
    Name        : openstack-nova-common
    Version     : 2016.10.2
    Release     : 8.el7ost
    ...

Services
~~~~~~~~

OpenStack has a large range of services that manage different different
components in a modular way.

Most popular services (50% or more of OpenStack cloud operators have
adopted):

-  Ceilometer = Telemetry
-  Cinder = Block Storage
-  Glance = Image
-  Heat = Orchestration
-  Horizon = Dashboard
-  Keystone = Authentication
-  Neutron = Networking
-  Nova = Compute
-  Swift = Object Storage

Other services:

-  Aodh = Telemetry Alarming
-  Barbican = Key Management
-  CloudKitty = Billing
-  Congress = Governance
-  Designate = DNS
-  Freezer = Backup and Recovery
-  Ironic = Bare-Metal Provisioning
-  Karbor = Data protection
-  Kuryr = Container plugin
-  Magnum = Container Orchestration Engine Provisioning
-  Manila = Shared File Systems
-  Mistral = OpenStack Workflow
-  Monasca = Monitoring
-  Murano = Application Catalog
-  Octavia = Load Balancing
-  Rally = Benchmark
-  Sahara = Big Data Processing Framework Provisioning
-  Senlin = Clustering
-  Solum = Software Development Lifecycle Automation
-  Searchlight = Indexing
-  Tacker = NFV Orchestration
-  Tricircle = Multi-Region Networking Automation
-  TripleO = Deployment
-  Trove = Database
-  Vitrage = Root Cause Analysis
-  Watcher = Optimization
-  Zaqar = Messaging
-  Zun = Containers

[10]

Deployment
----------

OpenStack can be installed as an all-in-one (AIO) server or onto a cluster of servers. Various tools exist for automating the deployment and management of OpenStack for day 0, 1, and 2 operations.

Packstack
~~~~~~~~~

Supported operating system: RHEL/CentOS 7, Fedora

Packstack is part of Red Hat's RDO project. It's purpose is for
providing small and simple demonstrations of OpenStack. This tool does
not handle any upgrades of the OpenStack services.

Hardware requirements [25]:

-  16GB RAM

Install
^^^^^^^

First, install the required repositories for OpenStack.

RHEL:

.. code-block:: sh

    $ sudo yum install https://repos.fedorapeople.org/repos/openstack/openstack-queens/rdo-release-queens-1.noarch.rpm
    $ sudo subscription-manager repos --enable rhel-7-server-optional-rpms --enable rhel-7-server-extras-rpms

CentOS:

.. code-block:: sh

    $ sudo yum install centos-release-openstack-queens

Finally, install the Packstack utility.

.. code-block:: sh

    $ sudo yum -y install openstack-packstack

There are two network scenarios that Packstack can deploy. The default
is to have an isolated network (1). Floating IPs will not be able to
access the network on the public interface. For lab environments,
Packstack can also configure Neutron to expose the network instead to
allow instances with floating IPs to access other IP addresses on the
network (2).

``1.`` Isolated Network Install

Generate a configuration file referred to as the "answer" file. This can
optionally be customized. Then install OpenStack using the answer file.
By default, the network will be entirely isolated. [11]

.. code-block:: sh

    $ sudo packstack --gen-answer-file <FILE>
    $ sudo packstack --answer-file <FILE>

Packstack logs are stored in /var/tmp/packstack/. The administrator and
demo user credentials will be saved to the user's home directory.

.. code-block:: sh

    $ source ~/keystonerc_admin
    $ source ~/keystonerc_demo

Although the network will not be exposed by default, it can still be
configured later. The primary interface to the lab's network, typically
``eth0``, will need to be configured as a Open vSwitch bridge to allow
this. Be sure to replace the "IPADDR", "PREFIX", and "GATEWAY" with the
server's correct settings. Neutron will also need to be configured to
allow "flat" networks.

File: /etc/sysconfig/network-scripts/ifcfg-eth0

::

    DEVICE=eth0
    ONBOOT=yes
    DEVICETYPE=ovs
    TYPE=OVSPort
    OVS_BRIDGE=br-ex
    BOOTPROTO=none
    NM_CONTROLLED=no

File: /etc/sysconfig/network-scripts/ifcfg-br-ex

::

    DEVICE=br-ex
    ONBOOT=yes
    DEVICETYPE=ovs
    TYPE=OVSBridge
    DEFROUTE=yes
    IPADDR=192.168.1.200
    PREFIX=24
    GATEWAY=192.168.1.1
    PEERDNS=no
    BOOTPROTO=none
    NM_CONTROLLED=no

``2.`` Exposed Network Install

It is also possible to deploy OpenStack where Neutron can have access to
the public network. Run the Packstack installation with the command
below and replace "eth0" with the public interface name.

.. code-block:: sh

    $ sudo packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:eth0 --os-neutron-ml2-type-drivers=vxlan,flat

Alternatively, use these configuration options in the answer file.

.. code-block:: ini

    CONFIG_NEUTRON_ML2_TYPE_DRIVERS=vxlan,flat
    CONFIG_NEUTRON_OVS_BRIDGE_MAPPINGS=extnet:br-ex
    CONFIG_NEUTRON_OVS_BRIDGE_IFACES=br-ex:eth0
    CONFIG_PROVISION_DEMO=n

.. code-block:: sh

    $ sudo packstack --answer-file <ANSWER_FILE>

After the installation is finished, create the necessary network in
Neutron as the admin user. In this example, the network will
automatically allocate IP addresses between 192.168.1.201 and
192.168.1.254. The IP 192.168.1.1 is the router / default gateway.

.. code-block:: sh

    $ . keystonerc_admin
    $ neutron net-create external_network --provider:network_type flat --provider:physical_network extnet --router:external
    $ neutron subnet-create --name public_subnet --enable_dhcp=False --allocation-pool=start=192.168.1.201,end=192.168.1.254 --gateway=192.168.1.1 external_network 192.168.1.0/24

The "external\_network" can now be associated with a router in user
accounts.

[12]

Answer File
'''''''''''

The "answer" configuration file defines how OpenStack should be setup
and installed. Using a answer file can provide a more customizable
deployment.

Common options:

-  CONFIG\_DEFAULT\_PASSWORD = Any blank passwords in the answer file
   will be set to this value.
-  CONFIG\_KEYSTONE\_ADMIN\_TOKEN = The administrator authentication
   token.
-  CONFIG\_KEYSTONE\_ADMIN\_PW = The administrator password.
-  CONFIG\_MARIADB\_PW = The MariaDB root user's password.
-  CONFIG\_HORIZON\_SSL = Configure an SSL for the Horizon dashboard.
   This requires that SSLs be generated manually and then defined in the
   configuration file [13]:

   ::

       $ for cert in selfcert ssl_dashboard ssl_vnc; do sudo openssl req -x509 -sha256 -newkey rsa:2048 -keyout /etc/pki/tls/private/${cert}.key -out /etc/pki/tls/certs/${cert}.crt -days 365 -nodes; done

   -  CONFIG\_SSL\_CACERT\_FILE=/etc/pki/tls/certs/selfcert.crt
   -  CONFIG\_SSL\_CACERT\_KEY\_FILE=/etc/pki/tls/private/selfkey.key
   -  CONFIG\_VNC\_SSL\_CERT=/etc/pki/tls/certs/ssl\_vnc.crt
   -  CONFIG\_VNC\_SSL\_KEY=/etc/pki/tls/private/ssl\_vnc.key
   -  CONFIG\_HORIZON\_SSL\_CERT=/etc/pki/tls/certs/ssl\_dashboard.crt
   -  CONFIG\_HORIZON\_SSL\_KEY=/etc/pki/tls/private/ssl\_dashboard.key
   -  CONFIG\_HORIZON\_SSL\_CACERT=/etc/pki/tls/certs/selfcert.crt

-  ``CONFIG_<SERVICE>_INSTALL`` = Install a specific OpenStack service.
-  ``CONFIG_<NODE>_HOST`` = The host to setup the relevant services on.
-  ``CONFIG_<NODE>_HOSTS`` = A list of hosts to setup the relevant
   services on. This currently only exists for "COMPUTE" and "NETWORK."
   New hosts can be added and Packstack re-run to have them added to the
   OpenStack cluster.
-  CONFIG\_PROVISION\_DEMO = Setup a demo project and user account with
   an image and network configured.

Uninstall
^^^^^^^^^

For uninstalling everything that is installed by Packstack, run `this Bash script <https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux\_OpenStack\_Platform/6/html/Deploying\_OpenStack\_Proof\_of\_Concept\_Environments/chap-Removing\_Packstack\_Deployments.html>`__ on all of the OpenStack nodes. Use at your own risk.

OpenStack-Ansible
~~~~~~~~~~~~~~~~~

Supported operating systems: RHEL/CentOS 7, Ubuntu 16.04, openSUSE Leap 42

OpenStack-Ansible uses Ansible for automating the deployment of Ubuntu
inside of LXC containers that run the OpenStack services. This was
created by RackSpace as an official tool for deploying and managing
production environments.

It offers key features that include:

-  Full LXC containerization of services.
-  HAProxy load balancing for clustering containers.
-  Scaling for MariaDB Galera, RabbitMQ, compute nodes, and more.
-  Central logging with rsyslog.
-  OpenStack package repository caching.
-  Automated upgrades.

[14]

Quick
^^^^^

Install
'''''''

Minimum requirements:

-  8 CPU cores
-  50GB storage (80GB recommended)
-  8GB RAM (16GB recommended)

This quick installation guide covers how to install an all-in-one
environment. It is recommended to deploy this inside of a virtual
machine (with nested virtualization enabled) as many system
configurations are changed.

Setup the OpenStack-Ansible project.

.. code-block:: sh

    $ sudo git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
    $ cd /opt/openstack-ansible/
    $ sudo git checkout stable/queens

There are two all-in-one scenarios that will run different Ansible
Playbooks. The default is "aio" but this can be changed to the second
scenario by setting the ``SCENARIO`` shell variable to "ceph."
Alternatively, the roles to run can be manually modified in
``/opt/openstack-ansible/tests/bootstrap-aio.yml`` Playbook.

``$ export SCENARIO="ceph"``

-  aio

   -  cinder.yml.aio
   -  designate.yml.aio
   -  glance.yml.aio
   -  heat.yml.aio
   -  horizon.yml.aio
   -  keystone.yml.aio
   -  neutron.yml.aio
   -  nova.yml.aio
   -  swift.yml.aio

-  ceph:

   -  ceph.yml.aio
   -  cinder.yml.aio
   -  glance.yml.aio
   -  heat.yml.aio
   -  horizon.yml.aio
   -  keystone.yml.aio
   -  neutron.yml.aio
   -  nova.yml.aio

Extra Playbooks can be added by copying them from
``/opt/openstack-ansible/etc/openstack_deploy/conf.d/`` to
``/etc/openstack_deploy/conf.d/``. The file extensions should be changed
from ``.yml.aio`` to ``.yml`` to be correctly parsed.

Then OpenStack-Ansible project can now setup and deploy the LXC containers along with the OpenStack services.

.. code-block:: sh

    $ sudo scripts/bootstrap-ansible.sh
    $ sudo scripts/bootstrap-aio.sh
    $ cd /opt/openstack-ansible/playbooks
    $ sudo openstack-ansible setup-hosts.yml
    $ sudo openstack-ansible setup-infrastructure.yml
    $ sudo openstack-ansible setup-openstack.yml

If the installation fails, it is recommended to reinstall the operating
system to completely clear out all of the custom configurations that
OpenStack-Ansible creates. Running the ``scripts/run-playbooks.sh``
script will not work again until the existing LXC containers and
configurations have been removed. [15]

Uninstall
'''''''''

`This Bash script <https://docs.openstack.org/openstack-ansible/queens/contributor/quickstart-aio.html#rebuilding-an-aio>`__ can be used to clean up and uninstall most of the
OpenStack-Ansible installation. Use at your own risk. The recommended
way to uninstall OpenStack-Ansible is to reinstall the operating system. [15]

Full
^^^^

Minimum requirements:

-  3 infrastructure nodes
-  2 compute nodes
-  1 log node

It is also required to have 4 different network bridges.

-  ``br-mgmt`` = All the nodes should have this network. This is the
   management network where all nodes can be accessed and managed by.
-  ``br-storage`` = This is the only optional interface. It is
   recommended to use this to separate the "storage" nodes traffic. This
   should exist on the "storage" (when using bare-metal) and "compute"
   nodes.
-  ``br-vlan`` = This should exist on the "network" (when using
   bare-metal) and "compute" nodes. It is used for self-service
   networks.
-  ``br-vxlan`` = This should exist on the "network" and "compute"
   nodes. It is used for self-service networks.

[16]

Configurations
''''''''''''''

View the
``/etc/openstack_deploy/openstack_user_config.yml.prod.example`` for a
real production example and reference.

Configure the networks that are used in the environment.

-  ``cider_networks``

   -  ``container`` = The network range that the LXC containers will use
      an IP address from. This is the management network that is on
      "br-mgmt."
   -  ``tunnel`` = The network range for accessing network services
      between the "compute" and "network" nodes over the VXLAN or GRE
      tunnel interface. The tunnel network should be on "br-vxlan."
   -  ``storage`` = The network range for accessing storage. This is the
      network that is on "br-storage."

-  ``used_ips`` = Lists of IP addresses that are already in use and
   should not be used for the container networks.
-  ``global_overrides``

   -  ``tunnel_bridge`` = The interface to use for tunneling VXLAN
      traffic. This is typically "br-vxlan."
   -  ``management_bridge`` = The interface to use for management
      access. This is typically ``br-mgmt``.
   -  external\_lb\_vip\_address = The public IP address to load balance
      for API endpoints.
   -  ``provider_networks``

      -  ``network`` = Different networks can be defined. At least one
         is required.

         -  ``type`` = The type of network that the "container\_bridge"
            device should be used.

            -  flat
            -  vlan
            -  vxlan

         -  ``container_bridge`` = The bridge device that will be used
            to connect the container to the network. The recommended
            deployment scheme recommends setting up a "br-mgmt",
            "br-storage", "br-vlan", and "br-vlan." Any valid bridge
            device on the host node can be specified here.
         -  ``container_type`` = veth
         -  ``ip_from_q`` = Specify the "cider\_networks" that will be
            used to allocate IP addresses from.
         -  range = The optional VXLAN that the bridge interface should
            use.
         -  ``container_interface`` = The interface that the LXC
            container should use. This is typically "eth1."

The syntax for defining which host(s) a service will be installed onto
follow this format below. Controller node services are specified with
the keyword ``-infra`` in their name. Each ``infra#`` entry contains the
IP address of the physical server to provision the containers to.

-  ``<SERVICE_TYPE>``\ \_hosts:

   -  infra1:

      -  ip: ``<HOST1_IP_ADDRESS>``

   -  infra2:

      -  ip: ``<HOST2_IP_ADDRESS>``

   -  infra3:

      -  ip: ``<HOST3_IP_ADDRESS>``

The valid service types are:

-  shared-infra = Galera, memcache, RabbitMQ, and other utilities.
-  repo-infra\_hosts = Hosts that will handle storing and retrieving
   packages.
-  metrics = Gnocchi.
-  metering-alartm\_hosts = Aodh.
-  storage-infra = Cinder.
-  image = Glance.
-  identity = Keystone.
-  haproxy = Load balancers.
-  log = Central rsyslog servers

   -  ``log<#>`` = Instead of ``infra<#>``, log\_hosts uses this
      variable for defining the host IP address.

-  metering-infra = Ceilometer.
-  metering-alarm = Aodh.
-  metering-compute = Ceilometer for the compute nodes.
-  compute-infra = Nova API nodes.
-  orchestration = Heat.
-  dashboard = Horizon.
-  network = Neutron network nodes
-  compute = Nova hypervisor nodes.
-  storage = Cinder.
-  storage-infra
-  swift = Swift stores.
-  swift-proxy = Swift proxies.
-  trove-infra = Trove.
-  ceph-mon = Ceph monitors.
-  ceph-osd = Ceph OSDs.
-  dnsaas = Designate.
-  unbound = Caching DNS server nodes.
-  magnum-infra = Magnum.
-  sahra-infra = Sahara.

[16]

Nova
&&&&

Common variables:

-  nova\_virt\_type = The virtualization technology to use for deploying
   instances with OpenStack. By default, OpenStack-Ansible will guess
   what should be used based on what is installed on the hypervisor.
   Valid options are: ``qemu``, ``kvm``, ``lxd``, ``ironic``, or
   ``powervm``.

[17]

Ceph
&&&&

Ceph can be customized to be deployed differently from the default
configuration or to use an existing Ceph cluster.

These settings can be adjusted to use different Ceph users, pools,
and/or monitor nodes.

File: /etc/openstack_deploy/user_variables.yml

.. code-block:: yaml

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

By default, OpenStack-Ansible will generate the ceph.conf configuration
file by connecting to the Ceph monitor hosts and obtaining the
information from there. Extra configuration options can be specified or
overriden using the "ceph\_extra"confs" dictionary.

.. code-block:: yaml

    ceph_extra_confs:
    -  src: "<PATH_TO_LOCAL_CEPH_CONFIGURATION>"
       dest: "/etc/ceph/ceph.conf"
       mon_host: <MONITOR_IP>
       client_name: <CEPH_CLIENT>
       keyring_src: <PATH_TO_LOCAL_CEPH_CLIENT_KEYRING_FILE>
       keyring_dest: /etc/ceph/ceph.client.<CEPH_CLIENT>.keyring
       secret_uuid: '{{ cinder_ceph_client_<CEPH_CLIENT> }}'

Alternatively, the entire configuration file can be defined as a
variable using proper YAML syntax. [19]

.. code-block:: yaml

    ceph_conf_file: |
      [global]
      fsid = 00000000-1111-2222-3333-444444444444
      mon_initial_members = mon1.example.local,mon2.example.local,mon3.example.local
      mon_host = {{ ceph_mons|join(',') }}
      auth_cluster_required = cephx
      auth_service_required = cephx

A new custom deployment of Ceph can be configured. It is recommended to
use at least 3 hosts for high availability and quorum. [18]

File: /etc/openstack_deploy/openstack_user_config.yml

.. code-block:: yaml

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
              rbd_user: <CINDER_CEPHX_USER>

[18]

Another real-world example of deploying and managing Ceph as part of
OpenStack-Ansible can be found here:
https://github.com/openstack/openstack-ansible/commit/057bb30547ef753b4559a689902be711b83fd76f

Install
'''''''

Download and install the latest stable OpenStack-Ansible suite from
GitHub.

.. code-block:: sh

    $ sudo git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
    $ cd /opt/openstack-ansible/
    $ sudo git checkout stable/queens
    $ sudo cp -a -r -v /opt/openstack-ansible/etc/openstack_deploy/ /etc/

Install Ansible and the related OpenStack Roles.

.. code-block:: sh

    $ sudo /opt/openstack-ansible/scripts/bootstrap-ansible.sh

Generate random passwords for the services.

.. code-block:: sh

    $ sudo /opt/openstack-ansible/scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml

- Configure OSA and verify that the configuration syntax is correct.

.. code-block:: sh

    $ sudo cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml
    $ sudo vim /etc/openstack_deploy/openstack_user_config.yml
    $ sudo openstack-ansible setup-infrastructure.yml --syntax-check

-  Prepare the hosts.

.. code-block:: sh

    $ sudo openstack-ansible setup-hosts.yml

- Setup the LXC containers.

.. code-block:: sh

    $ sudo openstack-ansible setup-infrastructure.yml

-  Install the OpenStack services.

.. code-block:: sh

    $ sudo openstack-ansible setup-openstack.yml

[16]

Operations
''''''''''

OpenStack Utilities
&&&&&&&&&&&&&&&&&&&

Once OpenStack-Ansible is installed, it can be used immediately. The
primary container to use is the ``utility`` container.

.. code-block:: sh

    $ sudo lxc-ls -1 | grep utility
    $ sudo lxc-attach -n <UTILITY_CONTAINER_NAME>

The file ``/root/openrc`` should exist on the container with the
administrator credentials. Source this file to use them.

.. code-block:: sh

    $ source /root/openrc

Verify that all of the correct services and endpoints exist.

.. code-block:: sh

    $ openstack service list
    $ openstack endpoint list

[20]

Ansible Inventory
&&&&&&&&&&&&&&&&&

Ansible's inventory contains all of the connection and variable details
about the hosts (in this case, LXC containers) and which group they are
a part of. This section covers finding and using these inventory values
for management and troubleshooting.

-  Change into the OpenStack-Ansible directory.

   .. code-block:: sh

       $ cd /opt/openstack-ansible/

-  Show all of the groups and the hosts that are a part of it.

   .. code-block:: sh

       $ sudo ./scripts/inventory-manage.py -G

-  Show all of the hosts and the groups they are a part of.

   .. code-block:: sh

       $ sudo ./scripts/inventory-manage.py -g

-  List hosts that a Playbook will run against.

   .. code-block:: sh

       $ sudo openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP> --list-hosts

-  List all the Ansible tasks that will be executed on a group or host.

   .. code-block:: sh

       $ sudo openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP_OR_HOST> --list-tasks

[21]

Add a Infrastructure Node
&&&&&&&&&&&&&&&&&&&&&&&&&

Add the new host to the ``infra_hosts`` section in
``/etc/openstack_deploy/openstack_user_config.yml``. Then the inventory
can be updated which will generate a new unique node name that the
OpenStack-Ansible Playbooks can run against. The ``--limit`` options are
important because they will ensure that it will only run on the new
infrastructure node.

.. code-block:: sh

    $ cd /opt/openstack-ansible/playbooks
    $ sudo /opt/openstack-ansible/playbooks/inventory/dynamic_inventory.py > /dev/null
    $ sudo /opt/openstack-ansible/scripts/inventory-manage.py -l |awk '/<NEW_INFRA_HOST>/ {print $2}' | sort -u | tee /root/add_host.limit
    $ sudo openstack-ansible setup-everything.yml --limit @/root/add_host.limit
    $ sudo openstack-ansible --tags=openstack-host-hostfile setup-hosts.yml

[20]

Add a Compute Node
&&&&&&&&&&&&&&&&&&

Add the new host to the ``compute_hosts`` section in
``/etc/openstack_deploy/openstack_user_config.yml``. Then the
OpenStack-Ansible deployment Playbooks can be run again. If Ceilometer is in use then the `` /etc/openstack_deploy/conf.d/ceilometer.yml`` configuration will also have to be updated.

.. code-block:: sh

    $ cd /opt/openstack-ansible/playbooks
    $ sudo openstack-ansible setup-hosts.yml --limit localhost,<NEW_COMPUTE_HOST>
    $ sudo ansible nova_all -m setup -a 'filter=ansible_local gather_subset="!all"'
    $ sudo openstack-ansible setup-openstack.yml --skip-tags nova-key-distribute --limit localhost,<NEW_COMPUTE_HOST>
    $ sudo openstack-ansible setup-openstack.yml --tags nova-key --limit compute_hosts

[20]

Remove a Compute Node
&&&&&&&&&&&&&&&&&&&&&

Stop the services on the compute container and then use the
``openstack-ansible-ops`` project's Playbook ``remote_compute_node.yml``
to fully it. The host must also be removed from the
``/etc/openstack_deploy/openstack_user_config.yml`` configuration when
done.

.. code-block:: sh

    $ sudo lxc-ls -1 | grep compute
    $ sudo lxc-attach -n <COMPUTE_CONTAINER_TO_REMOVE>
    $ sudo stop nova-compute
    $ sudo stop neutron-linuxbridge-agent
    $ exit
    $ sudo git clone https://git.openstack.org/openstack/openstack-ansible-ops /opt/openstack-ansible-ops
    $ cd /opt/openstack-ansible-ops/ansible_tools/playbooks
    $ sudo openstack-ansible remove_compute_node.yml -e node_to_be_removed="<COMPUTE_CONTAINER_TO_REMOVE>"

[20]

Upgrades
''''''''

Minor
&&&&&

This is for upgrading OpenStack from one minor version to another in the
same major release. An example would be going from 17.0.0 to 17.1.1.

-  Change the OpenStack-Ansible version to a new minor tag release. If a
   branch for a OpenStack release name is being used already, pull the
   latest branch commits down from GitHub.

   .. code-block:: sh

       $ cd /opt/openstack-ansible/
       $ sudo git fetch --all
       $ sudo git checkout <TAG>

-  Update:

   -  **All services.**

      .. code-block:: sh

          $ sudo ./scripts/bootstrap-ansible.sh
          $ cd ./playbooks/
          $ sudo openstack-ansible setup-hosts.yml
          $ sudo openstack-ansible -e rabbitmq_upgrade=true setup-infrastructure.yml
          $ sudo openstack-ansible setup-openstack.yml

   -  **Specific services.**

      -  Update the cached package repository.

         .. code-block:: sh

             $ cd ./playbooks/
             $ sudo openstack-ansible repo-install.yml

      -  A single service can be upgraded now.

         .. code-block:: sh

             $ sudo openstack-ansible <COMPONENT>-install.yml --limit <GROUP_OR_HOST>

      -  Some services, such as MariaDB and RabbitMQ, require special
         variables to be set to force an upgrade.

         .. code-block:: sh

             $ sudo openstack-ansible galera-install.yml -e 'galera_upgrade=true'

         .. code-block:: sh

             $ sudo openstack-ansible rabbitmq-install.yml -e 'rabbitmq_upgrade=true'

[22]

Major
&&&&&

OpenStack-Ansible has scripts capable of fully upgrading OpenStack from
one major release to the next. It is recommended to do a manual upgrade
by following the `official guide <https://docs.openstack.org/openstack-ansible/queens/user/manual-upgrade.html>`__
Below outlines how to do this automatically. [22]

-  Move into the OpenStack-Ansible project.

   .. code-block:: sh

       $ cd /opt/openstack-ansible

-  View the available OpenStack releases and choose which one to use.

   .. code-block:: sh

       $ sudo git branch -a
       $ sudo git tag
       $ sudo git checkout <BRANCH_OR_TAG>

-  Run the upgrade script.

   .. code-block:: sh

       $ sudo ./scripts/run-upgrade.sh

TripleO
~~~~~~~

Supported operating systems: RHEL 7, Fedora >= 22

TripleO means "OpenStack on OpenStack." The Undercloud is first deployed in a small, usually all-in-one, environment. This server is then used to create and manage a full Overcloud cluster.

In Pike, most of the Overcloud can be deployed into docker containers built by Kolla. The most notable service that lacked container support was Neutron due to it's complexity. Starting in Queens, all of the Overcloud services can now be installed as docker containers. There is also experimental support for running the Undercloud services in containers. [81]

Hardware requirements [24]:

-  Undercloud node:

   -  4 CPU cores
   -  16GB RAM
   -  60GB storage

-  Overcloud nodes:

   -  4 CPU cores
   -  8GB RAM
   -  80GB storage

Quick
^^^^^

The "TripleO-Quickstart" project was created to use Ansible to automate
deploying TripleO as fast and easily as possible. [23]

Install
'''''''

TripleO-Quickstart recommends a minimum of 32GB RAM and 120GB of disk
space when deploying with the default settings. [25] This deployment has
to use a baremetal hypervisor. Deploying TripleO within a virtual
machine that uses nested virtualization is not supported. [26]

-  Download the tripleo-quickstart script or clone the entire repository
   from GitHub.

   .. code-block:: sh

       $ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh

   OR

   .. code-block:: sh

       $ git clone https://github.com/openstack/tripleo-quickstart.git
       $ cd tripleo-quickstart

-  Install dependencies for the quickstart script.

   .. code-block:: sh

       $ bash quickstart.sh --install-deps

TripleO can now be installed automatically with the default setup of 3
virtual machines. This will be created to meet the minimum TripleO cloud
requirements: (1) an Undercloud to deploy a (2) controller and (3)
compute node. [24] . Otherwise, a different node configuration from
"config/nodes/" can be specified or created.

Common node variables:

-  {block\|ceph\|compute\|control\|default\|objectstorage\|undercloud}\_{memory\|vcpu}
   = Define the amount of processor cores or RAM (in megabytes) to
   allocate to the respective virtual machine type. Use "default" to
   apply to all nodes that are not explicitly defined.

Further customizations should be configured now before deploying the
TripleO environment. Refer to the `Undercloud Deploy role's
documentation <https://github.com/openstack/tripleo-quickstart-extras/blob/master/roles/undercloud-deploy/README.md>`__
on all of the Ansible variables for the Undercloud. Add any override
variables to a YAML file and then add the arguments
``-e @<VARIABLE_FILE>.yaml`` to the "quickstart.sh" commands.

``1.`` Automatic

-  Run the quickstart script to install TripleO. Use "127.0.0.2" for the
   localhost IP address if TripleO will be installed on the same system
   that the quickstart command is running on.

.. code-block:: sh

    $ bash quickstart.sh --release trunk/queens --tags all <REMOTE_HYPERVISOR_IP>

[23]

``2.`` Manual

-  Common quickstart.sh options:

   -  ``--clean`` = Remove previously created files from the working
      directory on the start of TripleO-Quickstart.
   -  ``--no-clone`` = Use the current working directory for
      TripleO-Quickstart. This should only be if the entire repository
      has been cloned.
   -  ``--nodes config/nodes/<CONFIGURATION>.yml`` = Specify the
      configuration that determines how many Overcloud nodes should be
      deployed.
   -  ``-p`` = Specify a Playbook to run.
   -  ``--release`` = The OpenStack release to use. All of the available
      releases can be found in the GitHub project in the
      "config/release/" directory. Use "trunk/``<RELEASE_NAME>``" for
      the development version and "stable/``<RELEASE_NAME>``" for the
      stable version.
   -  ``--retain-inventory`` = Use the existing inventory. This is
      useful for managing an existing TripleO-Quickstart infrastructure.
   -  ``--teardown {all|nodes|none|virthost}`` = Delete everything
      related to TripleO (all), only the virtual machines (nodes),
      nothing (none), or the virtual machines and settings on the
      hypervisor (virthost).
   -  ``--tags all`` = Deploy a complete all-in-one TripleO installation
      automatically. If a Playbook is specified via ``-p``, then
      everything in that Playbook will run.
   -  ``-v`` = Show verbose output from the Ansible Playbooks.
   -  ``--config=~/.quickstart/config/general_config/containers_minimal.yml`` = Deploy the Overcloud from Kolla docker containers. [81]

--------------

-  Setup the Undercloud virtual machine.

   .. code-block:: sh

       $ bash quickstart.sh --release trunk/queens --clean --teardown all --tags all --playbook quickstart.yml <REMOTE_HYPERVISOR_IP>

-  Install the Undercloud services.

   .. code-block:: sh

       $ bash quickstart.sh --release trunk/queens --teardown none --no-clone --tags all --retain-inventory --playbook quickstart-extras-undercloud.yml <REMOTE_HYPERVISOR_IP>

-  Setup the Overcloud virtual machines.

   .. code-block:: sh

       $ bash quickstart.sh --release trunk/queens --teardown none --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml --retain-inventory --playbook quickstart-extras-overcloud-prep.yml <REMOTE_HYPERVISOR_IP>

-  Install the Overcloud services.

   .. code-block:: sh

       $ bash quickstart.sh --release trunk/queens --teardown none --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml --retain-inventory --playbook quickstart-extras-overcloud.yml <REMOTE_HYPERVISOR_IP>

-  Validate the installation.

   .. code-block:: sh

       $ bash quickstart.sh --release trunk/queens --teardown none --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml --retain-inventory  --playbook quickstart-extras-validate.yml <REMOTE_HYPERVISOR_IP>

[27]

Full
^^^^

Install
'''''''

Undercloud
&&&&&&&&&&

The Undercloud can be installed onto a bare metal server or a virtual
machine. Follow the "hypervisor" section to assist with automatically
creating an Undercloud virtual machine.

-  **Hypervisor** (optional)

   -  Install the RDO Trunk / Delorean repositories.

      .. code-block:: sh

          $ sudo curl -L -o /etc/yum.repos.d/delorean-queens.repo https://trunk.rdoproject.org/centos7-queens/current/delorean.repo
          $ sudo curl -L -o /etc/yum.repos.d/delorean-deps-queens.repo https://trunk.rdoproject.org/centos7-queens/delorean-deps.repo

   -  Install the Undercloud environment deployment tools.

      .. code-block:: sh

          $ sudo yum install instack-undercloud

   -  Deploy a new virtual machine to be used for the Undercloud.

      .. code-block:: sh

          $ instack–virt–setup

   -  Alternatively, use the TripleO-Quickstart project to deploy the
      Undercloud virtual machine. Leave the overcloud\_nodes variable
      blank to only deploy the Undercloud. Otherwise, provide a number
      of virtual machines that should be created for use in the
      Overcloud.

      .. code-block:: sh

          $ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh
          $ bash quickstart.sh --tags all --playbook quickstart.yml -e overcloud_nodes="" $VIRTHOST

   -  Log into the virtual machine once TripleO-Quickstart has completed
      setting up the environment.

      .. code-block:: sh

          $ ssh -F ~/.quickstart/ssh.config.ansible undercloud

-  **Undercloud**

   -  It is recommended to create a user named "stack" with sudo
      privileges to manage the Undercloud.

      .. code-block:: sh

          $ sudo useradd stack
          $ sudo passwd stack
          $ sudo echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack
          $ sudo chmod 0440 /etc/sudoers.d/stack
          $ sudo su - stack

   -  Install the RDO Trunk repositories.
   -  Install TripleO.

      .. code-block:: sh

          $ sudo yum install python-tripleoclient

   -  Copy the sample configuration to use as a base template.

      .. code-block:: sh

          $ cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf

   -  Common Undercloud configuration options:

      -  enable\_\* = Enable or disable non-essential OpenStack services
         on the Undercloud.
      -  dhcp\_{start\|end} = The range of IP addresses to temporarily
         use for provisioning Overcloud nodes. This range is a limiting
         factor in how many nodes can be provisioned at once.
      -  local\_interface = The network interface to use for
         provisioning new Overcloud nodes. This will be configured as an
         Open vSwitch bridge.
      -  local\_mtu = The MTU size to use for the local interface.
      -  network\_cidr = The CIDR range of IP addresses to temporarily
         use for provisioning.
      -  masquerade\_network = The network CIDR that will be used for
         masquerading external network connections.
      -  network\_gateway = The default gateway to use for external
         connectivity to the Internet during provisioning.
      -  undercloud\_admin\_vip = The IP address to listen on for admin
         API endpoints.
      -  undercloud\_hostname = The fully qualified hostname to use for
         the Undercloud.
      -  undercloud\_public\_vip = The IP address to listen on for
         public API endpoints.

   -  At the very least the "local\_ip" and "local\_interface" variables
      need to be defined in the "DEFAULT" section.
   -  Deploy an all-in-one Undercloud on the virtual machine.

      .. code-block:: sh

          $ openstack undercloud install

   -  The installation will be logged to
      ``$HOME/.instack/install-undercloud.log``.
   -  After the installation, OpenStack user credentials will be saved
      to ``$HOME/stackrc``. Source this file before running OpenStack
      commands to verify that the Undercloud is operational.

      .. code-block:: sh

          $ source ~/stackrc
          $ openstack catalog list

   -  All OpenStack service passwords will be saved to
      ``$HOME/undercloud-passwords.conf``.

[28]

Overcloud
&&&&&&&&&

-  Download the prebuilt Overcloud image files from
   https://images.rdoproject.org/

   -  ironic-python-agent.initramfs
   -  ironic-python-agent.kernel
   -  overcloud-full.initrd
   -  overcloud-full.qcow2
   -  overcloud-full.vmlinuz

-  Upload those images.

   .. code-block:: sh

       $ openstack overcloud image upload

-  Create a "instackenv.json" file that describes the physical infrastructure of the Overcloud as `outlined here <https://docs.openstack.org/tripleo-docs/latest/install/environments/baremetal.html#instackenv>`__. By default Ironic manages rebooting machines using the IPMI "pxe_ipmitool" driver. [75]

    -  Virtual lab environment notes:

        -  The "pxe_fake" driver can be used. This will require the end-user to manually reboot the managed nodes.
        -  Alternatively, VirtualBMC can be used to emulate IPMI with Libvirt. [76]

.. code-block:: sh

  $ sudo yum install -y python-virtualbmc
  $ vbmc add <VM_NAME> --port <IPMI_PORT> --username admin --password password
  $ vbmc start <VM_NAME>
  $ echo "Verifying that IPMI now works."
  $ ipmitool -I lanplus -U admin -P password -H 127.0.0.1 -p <IPMI_PORT> power on

-  Import the configuration that defines the Overcloud infrastructure
   and have it introspected so it can be deployed:

   .. code-block:: sh

       $ openstack overcloud node import --introspect --provide instackenv.json

   -  Alternatively, automatically discover the available servers by
      scanning IPMI devices via a CIDR range and using different IPMI
      logins.

      .. code-block:: sh

          $ openstack overcloud node discover --range <CIDR> \
          --credentials <USER1>:<PASSWORD1> --credentials <USER2>:<PASSWORD2>

-  Deploy the Overcloud with any custom Heat configurations. [29] Starting with the Pike release, most services are deployed as containers by default. For preventing the use of containers, remove the "docker.yaml" and "docker-ha.yaml" files from `/usr/share/openstack-tripleo-heat-templates/environments/`. [30]

   .. code-block:: sh

       $ openstack help overcloud deploy

-  Optionally for container support, configure the upstream RDO Docker Hub repository to download containers from. Then reference the docker, docker-ha, and docker_registry templates. The "environments/puppet-pacemaker.yaml" template should also be removed to avoid conflicts.

   .. code-block:: sh

     $ openstack overcloud container image prepare --namespace docker.io/tripleomaster --tag current-tripleo --tag-from-label rdo_version --output-env-file ~/docker_registry.yaml
     $ openstack overcloud deploy <DEPLOY_OPTIONS> -e /usr/share/openstack-tripleo-heat-templates/environments/docker.yaml -e ~/docker_registry.yaml -e /usr/share/openstack-tripleo-heat-templates/environments/docker-ha.yaml

-  Verify that the Overcloud was deployed.

   .. code-block:: sh

       $ openstack stack list
       $ openstack stack show <OVERCLOUD_STACK_ID>

-  Source the Overcloud credentials to manage it.

   .. code-block:: sh

       $ source ~/overcloudrc

[29]

Operations
''''''''''

Add a Compute Node
&&&&&&&&&&&&&&&&&&

-  From the Undercloud, create a `instackenv.json` file describing the new node. Import the file using Ironic.

.. code-block:: sh

    $ source ~/stackrc
    $ openstack baremetal import --json instackenv.json

-  Automatically configure it to use the existing kernel and ramdisk for PXE booting.

.. code-block:: sh

    $ openstack baremetal configure boot

-  Set the new node to the "manageable" state. Then introspect the new node so Ironic can automatically determine it's resources and hardware information.

.. code-block:: sh

    $ openstack baremetal node manage <NODE_UUID>
    $ openstack overcloud node introspect <NODE_UUID> --provided

-  Configure the node to be a compute node.

.. code-block:: sh

    $ openstack baremetal node set --property capabilities='profile:compute,boot_option:local' <NODE_UUID>

-  Redeploy the Overcloud while specifying the number of compute nodes that should exist in total after it is complete. The `ComputeCount` parameter in the Heat templates should also be increased to reflect it's new value.

.. code-block:: sh

    $ openstack overcloud deploy <DEPLOY_OPTIONS> --templates --compute-scale <NEW_TOTAL_NUMBER_OF_ALL_COMPUTE_NODES>

[77]

Configurations
--------------

This section will focus on important settings for each service's
configuration files.

Common
~~~~~~

These are general configuration options that apply to most OpenStack
configuration files.

Database
^^^^^^^^

Different database servers can be used by the API services on the
controller nodes.

-  MariaDB/MySQL. The original "``mysql://``" connector can be used for the MySQL-Python library. Starting with Liberty, the newer PyMySQL library was added for Python 3 support. [31] CentOS first added the required ``python2-PyMySQL`` package to support it in the Pike release. [34][79]

   .. code-block:: ini

       [database]
       connection = mysql+pymysql://<USER>:<PASSWORD>@<MYSQL_HOST>:<MYSQL_PORT>/<DATABASE>

-  PostgreSQL. Requires the "psycopg2" Python library. [32]

   .. code-block:: ini

       [database]
       connection = postgresql://<USER>:<PASSWORD>@<POSTGRESQL_HOST>:<POSTGRESQL_PORT>/<DATABASE>

-  SQLite.

   .. code-block:: ini

       [database]
       connection = sqlite:///<DATABASE>.sqlite

-  MongoDB is generally only used for Ceilometer when it is not using
   the Gnocchi back-end. [33]

   .. code-block:: ini

       [database]
       mongodb://<USER>:<PASSWORD>@<MONGODB_HOST>:<MONGODB_PORT>/<DATABASE>

Messaging
^^^^^^^^^

For high availability and scalability, servers should be configured with
a messaging agent. This allows a client's request to correctly be
handled by the messaging queue and sent to one node to process that
request.

The configuration has been consolidated into the ``transport_url``
option. Multiple messaging hosts can be defined by using a comma before
naming a virtual host.

.. code-block:: ini

    transport_url = <TRANSPORT>://<USER1>:<PASS1>@<HOST1>:<PORT1>,<USER2>:<PASS2>@<HOST2>:<PORT2>/<VIRTUAL_HOST>

Scenario #1 - RabbitMQ

On the controller nodes, RabbitMQ needs to be installed. Then a user
must be created with full privileges.

.. code-block:: sh

    $ sudo rabbitmqctl add_user <RABBIT_USER> <RABBIT_PASSWORD>
    $ sudo rabbitmqctl set_permissions openstack ".*" ".*" ".*"

In the configuration file for every service, set the transport\_url
options for RabbitMQ. A virtual host is not required. By default it will
use ``/``.

.. code-block:: ini

    [DEFAULT]
    transport_url = rabbit://<RABBIT_USER>:<RABBIT_PASSWORD>@<RABBIT_HOST>/<VIRTUAL_HOST>

[35]

Scenario #2 - ZeroMQ

This provides the best performance and stability. Scalability becomes a
concern only when getting into hundreds of nodes. Instead of relying on
a messaging queue, OpenStack services talk directly to each other using
the ZeroMQ library. Redis is required to be running and installed for
acting as a message storage back-end for all of the servers. [35][36]

.. code-block:: ini

    [DEFAULT]
    transport_url = "zmq+redis://<REDIS_HOST>:6379"

.. code-block:: ini

    [oslo_messaging_zmq]
    rpc_zmq_bind_address = <IP_ADDRESS>
    rpc_zmq_host = <FQDN_OR_IP_ADDRESS>

Alternatively, for high availability, use Redis Sentinel servers in ``transport_url``.

.. code-block:: ini

    [DEFAULT]
    transport_url = "zmq+sentinel://<REDIS_SENTINEL_HOST1>:26379,<REDI_SENTINEL_HOST2>:26379"

For all-in-one deployments, the minimum requirement is to specify that ZeroMQ should be used. This will use the "MatchmakerDummy" driver that will send messages to itself.

.. code-block:: ini

    [DEFAULT]
    transport_url = "zmq://"

[37]

Ironic
~~~~~~

Drivers
^^^^^^^

Ironic supports different ways of managing power cycling of managed nodes. The default enabled driver is IPMITool.

File: /etc/ironic/ironic.conf

.. code-block:: ini

    [DEFAULT]
    enabled_drivers = <DRIVER1>, <DRIVER2>, DRIVER3>

Supported Drivers:

-  CIMC: Cisco UCS servers (C series only).
-  iDRAC.
-  iLO: HPE ProLiant servers.
-  HP OneView.
-  IPMITool.
-  iRMC: FUJITSU PRIMERGY servers.
-  SNMP power racks.
-  UCS: Cisco UCS servers (B and C series).

Each driver has different dependencies and configurations as outlined `here <https://docs.openstack.org/ironic/queens/admin/drivers.html>`__.

Unsupported `Ironic Staging Drivers <http://ironic-staging-drivers.readthedocs.io/>`__:

- AMT
- iBoot
- Wake-On-Lan

Unsupported Drivers:

-  MSFT OCS
-  SeaMicro
-  VirtualBox

[75]

Keystone
~~~~~~~~

API v3
^^^^^^

In Mitaka, the Keystone v2.0 API has been deprecated. It will be removed entirely from OpenStack in the ``T`` release. [38] It is possible to run both v2.0 and v3 at the same time but it's desirable to move towards the v3 standard. If both have to be enabled, services should be configured to use v2.0 or else problems can occur with v3's domain scoping. For disabling v2.0 entirely, Keystone's API paste configuration needs to have these lines removed (or commented out) and then the web server should be restarted.

File: /etc/keystone/keystone-paste.ini

.. code-block:: ini

    [pipeline:public_api]
    pipeline = cors sizelimit url_normalize request_id admin_token_auth build_auth_context token_auth json_body ec2_extension public_service

    [pipeline:admin_api]
    pipeline = cors sizelimit url_normalize request_id admin_token_auth build_auth_context token_auth json_body ec2_extension s3_extension admin_service

    [composite:main]
    /v2.0 = public_api

    [composite:admin]
    /v2.0 = admin_api

[39]

Token Provider
^^^^^^^^^^^^^^

The token provider is used to create and delete tokens for
authentication. Different providers can be configured.

File: /etc/keystone/keystone.conf

Scenario #1 - UUID (default)

.. code-block:: ini

    [token]
    provider = uuid

Scenario #2 - Fernet (recommended)

This provides the fastest token creation and validation. A public and private key will need to be created for Fernet and the
related Credential authentication.

.. code-block:: ini

    [token]
    provider = fernet

    [fernet_tokens]
    key_repository = /etc/keystone/fernet-keys/

    [credential]
    provider = fernet
    key_repository = /etc/keystone/credential-keys/

-  Create the required keys:

   .. code-block:: sh

       $ sudo mkdir /etc/keystone/fernet-keys/
       $ sudo chmod 750 /etc/keystone/fernet-keys/
       $ sudo chown keystone.keystone /etc/keystone/fernet-keys/
       $ sudo keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

   .. code-block:: sh

       $ sudo mkdir /etc/keystone/credential-keys/
       $ sudo chmod 750 /etc/keystone/credential-keys/
       $ sudo chown keystone.keystone /etc/keystone/credential-keys/
       $ sudo keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

[40][41]

Scenario #3 - PKI

PKI tokens have been removed since the Ocata release. [42]

.. code-block:: ini

    [token]
    provider = pki

-  Create the certificates. A new directory "/etc/keystone/ssl/" will be used to store these files.

   .. code-block:: sh

       $ sudo keystone-manage pki_setup --keystone-user keystone --keystone-group keystone

Nova
~~~~

File: /etc/nova/nova.conf

-  For the controller nodes, specify the connection database connection strings for both the "nova" and "nova_api" databases.

.. code-block:: ini

    [api_database]
    connection = <DB_PROVIDER>//<DB_USER>:<DB_PASS>@<DB_HOST>/nova_api
    [database]
    connection = <DB_PROVIDER>//<DB_USER>:<DB_PASS>@<DB_HOST>/nova

-  Enable support for the Nova API and Nova's metadata API. If "metedata" is specified here, then the "openstack-nova-api" will handle the metadata and not "openstack-nova-metadata-api."

.. code-block:: ini

    [DEFAULT]
    enabled_apis = osapi_compute,metadata

-  Do not inject passwords, SSH keys, or partitions via Nova. This is recommended for Ceph storage back-ends. [46] This should be handled by the Nova's metadata service that will use cloud-init instead of Nova itself. This will either be "openstack-nova-api" or "openstack-nova-metadata-api" depending on the configuration.

.. code-block:: ini

    [libvirt]
    inject_password = False
    inject_key = False
    inject_partition = -2

Hypervisors
^^^^^^^^^^^

Nova supports a wide range of virtualization technologies. Full hardware
virtualization, paravirtualization, or containers can be used. Even
Windows' Hyper-V is supported.

File:

Scenario #1 - KVM

.. code-block:: ini

    [DEFAULT]
    compute_driver = libvirt.LibvirtDriver
    [libvirt]
    virt_type = kvm

Scenario #2 - Xen

.. code-block:: ini

    [DEFAULT]
    compute_driver = libvirt.LibvirtDriver
    [libvirt]
    virt_type = xen

Scenario #3 - LXC

.. code-block:: ini

    [DEFAULT]
    compute_driver = libvirt.LibvirtDriver
    [libvirt]
    virt_type = lxc

[43]

CPU Pinning
^^^^^^^^^^^

-  Verify that the processor(s) has hardware support for non-uniform
   memory access (NUMA). If it does, NUMA may still need to be turned on
   in the BIOS. NUMA nodes are the physical processors. These processors
   are then mapped to specific sectors of RAM.

   .. code-block:: sh

       $ sudo lscpu | grep NUMA
       NUMA node(s):          2
       NUMA node0 CPU(s):     0-9,20-29
       NUMA node1 CPU(s):     10-19,30-39

   .. code-block:: sh

       $ sudo numactl --hardware
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

   .. code-block:: sh

       $ sudo virsh nodeinfo | grep NUMA
       NUMA cell(s):        2

[44]

-  Append the NUMA filter "NUMATopologyFilter" to the Nova ``scheduler_default_filters`` key.

File: /etc/nova/nova.conf

   .. code-block:: ini

       [DEFAULT]
       scheduler_default_filters = <EXISTING_FILTERS>,NUMATopologyFilter

-  Restart the Nova scheduler service on the controller node(s).

   .. code-block:: sh

       $ sudo systemctl restart openstack-nova-scheduler

-  Set the aggregate/availability zone to allow pinning.

   .. code-block:: sh

       $ openstack aggregate create <AGGREGATE_ZONE>
       $ openstack aggregate set --property pinned=true <AGGREGATE_ZONE>

-  Add the compute hosts to the new aggregate zone.

   .. code-block:: sh

       $ openstack host list | grep compute
       $ openstack aggregate host add <AGGREGATE_ZONE> <COMPUTE_HOST>

-  Modify a flavor to provide dedicated CPU pinning. There are three supported policies to use:

    -  isolate = Use cores on the same physical processor. Do not allocate any threads.
    -  prefer (default) = Cores and threads should be on the same physical processor. Fallback to using mixed cores and threads across different processors if there are not enough resources available.
    -  require = Cores and threads must be on the same physical processor.

       .. code-block:: sh

           $ openstack flavor set <FLAVOR_ID> --property hw:cpu_policy=dedicated --property hw:cpu_thread_policy=<POLICY>

-  Alternatively, set the CPU pinning properties on an image.

   .. code-block:: sh

       $ openstack image set <IMAGE_ID> --property hw_cpu_policy=dedicated --property hw_cpu_thread_policy=<POLICY>

[45]

Ceph
^^^^

Nova can be configured to use Ceph as the storage provider for the instance. This works with any QEMU and Libvirt based hypervisor.

File: /etc/nova/nova.conf

.. code-block:: ini

    [libvirt]
    images_type = rbd
    images_rbd_pool = <CEPH_VOLUME_POOL>
    images_rbd_ceph_conf = /etc/ceph/ceph.conf
    rbd_user = <CEPHX_USER>
    rbd_secret_uuid = <LIBVIRT_SECRET_UUID>
    disk_cachemodes="network=writeback"

[46]

Nested Virtualization
^^^^^^^^^^^^^^^^^^^^^

Nested virtualization allows virtual machines to run virtual machines
inside of them.

The kernel module must be stopped, the nested setting enabled, and then
the module must be started again.

Intel:

.. code-block:: sh

    $ sudo rmmod kvm_intel
    $ echo “options kvm_intel nested=1” | sudo tee -a /etc/modprobe.d/kvm_intel.conf
    $ sudo modprobe kvm_intel

AMD:

.. code-block:: sh

    $ sudo rmmod kvm_amd
    $ echo “options kvm_amd nested=1” | sudo tee -a /etc/modprobe.d/kvm_amd.conf
    $ sudo modprobe kvm_amd

-  Use a hypervisor technology that supports nested virtualization such as KVM.

File: /etc/nova/nova.conf

.. code-block:: ini

    [libvirt]
    virt_type = kvm
    cpu_mode = host-passthrough

[47]

Neutron
~~~~~~~

Network Types
^^^^^^^^^^^^^

In OpenStack, there are two common scenarios for networks: "provider"
and "self-service."

Provider is is a simpler approach. It gives virtual machines direct
access to a bridge device.

Self-service networks are more complex due to the added bridge and
tunnel devices. This complexity allows for more advanced features such
as isolated private networks, load-balancing-as-a-service (LBaaS),
Firewall-as-a-Service (FWaaS), and more. [48]

Provider Networks
'''''''''''''''''

Linux Bridge
&&&&&&&&&&&&

https://docs.openstack.org/neutron/queens/admin/deploy-lb-provider.html

Open vSwitch
&&&&&&&&&&&&

https://docs.openstack.org/neutron/queens/admin/deploy-ovs-provider.html

Self-Service Networks
'''''''''''''''''''''

Linux Bridge
&&&&&&&&&&&&

https://docs.openstack.org/neutron/queens/admin/deploy-lb-selfservice.html

Open vSwitch
&&&&&&&&&&&&

One device is required, but it is recommended to separate traffic onto
two different network interfaces. There is ``br-vlan`` (sometimes also
referred to as ``br-provider``) for internal tagged traffic and
``br-ex`` for external connectivity.

.. code-block:: sh

    $ sudo ovs-vsctl add-br br-vlan
    $ sudo ovs-vsctl add-port br-vlan <VLAN_INTERFACE>
    $ sudo ovs-vsctl add-br br-ex
    $ sudo ovs-vsctl add-port br-ex <EXTERNAL_INTERFACE>

File: /etc/neutron/neutron.conf

.. code-block:: ini

    [DEFAULT]
    core_plugin = ml2
    service_plugins = router
    allow_overlapping_ips = True

File: /etc/neutron/plugins/ml2/ml2\_conf.ini

.. code-block:: ini

    [ml2]
    type_drivers = flat,vlan,vxlan
    tenant_network_types = vxlan
    mechanism_drivers = openvswitch,l2population
    [ml2_type_vxlan]
    vni_ranges = <START_NUMBER>,<END_NUMBER>

-  The ``<LABEL>`` can be any unique name. It is used as an alias for the interface name. The "local_ip" address should be accessible on the ``br-vlan`` interface.

File: /etc/neutron/plugins/ml2/openvswitch\_agent.ini

.. code-block:: ini

    [ovs]
    bridge_mappings = <LABEL>:br-vlan
    local_ip = <IP_ADDRESS>
    [agent]
    tunnel_types = vxlan
    l2_population = True
    [securitygroup]
    firewall_driver = iptables_hybrid

-  The "external_network_bridge" key should be left defined with no value.

File: /etc/neutron/l3\_agent.ini

.. code-block:: ini

    [DEFAULT]
    interface_driver = openvswitch
    external_network_bridge =

[49]

On the controller node, restart the Nova API service and then start the
required Neutron services.

.. code-block:: sh

    $ sudo systemctl restart openstack-nova-api
    $ sudo systemctl enable neutron-server neutron-openvswitch-agent neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent
    $ sudo systemctl start neutron-server neutron-openvswitch-agent neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent

Finally, on the compute nodes, restart the compute service and then
start the Open vSwitch agent.

.. code-block:: sh

    $ sudo systemctl restart openstack-nova-compute
    $ sudo systemctl enable neutron-openvswitch-agent
    $ sudo systemctl start neutron-openvswitch-agent

[50]

DNS
^^^

By default, Neutron does not provide any DNS resolvers. This means that
DNS will not work. It is possible to either provide a default list of
name servers or configure Neutron to refer to the relevant
/etc/resolv.conf file on the server.

File: /etc/neutron/dhcp\_agent.ini

Scenario #1 - Define a list of default resolvers (recommended)

.. code-block:: ini

    [DEFAULT]
    dnsmasq_dns_servers = 8.8.8.8,8.8.4.4

Scenario #2 - Leave resolvers to be configured by the subnet details

-  Nothing needs to be configured. This is the default setting.

Scenario #3 - Do not provide resolvers, use the ones provided in the image

.. code-block:: ini

    [DEFAULT]
    dnsmasq_local_resolv = True

[51]

Metadata
^^^^^^^^

The metadata service provides useful information about the instance from
the IP address 169.254.169.254/32. This service is also used to
communicate with "cloud-init" on the instance to configure SSH keys and
other post-boot tasks.

Assuming authentication is already configured, set these options for the
OpenStack environment. These are the basics needed before the metadata
service can be used correctly. Then it can also be configured to use DHCP
namespaces (layer 2) or router namespaces (layer 3) for
delivering/receiving requests.

File: /etc/neutron/metadata\_agent.ini

.. code-block:: ini

    [DEFAULT]
    nova_metadata_ip = <CONTROLLER_IP>
    metadata_proxy_shared_secret = <SECRET_KEY>

File: /etc/nova/nova.conf

.. code-block:: ini

    [DEFAULT]
    enabled\_apis = osapi\_compute,metadata
    [neutron]
    service_metadata_proxy = True
    metadata_proxy_shared_secret = <SECRET_KEY>

Scenario #1 - DHCP Namespace (recommended for DVR)

File: /etc/neutron/dhcp\_agent.ini

.. code-block:: ini

    [DEFAULT]
    force_metadata = True
    enable_isolated_metadata = True
    enable_metadata_network = True

File: /etc/neutron/l3\_agent.ini

.. code-block:: ini

    [DEFAULT]
    enable_metadata_proxy = False

Scenario #2 - Router Namespace

File: /etc/neutron/dhcp\_agent.ini

.. code-block:: ini

    [DEFAULT]
    force_metadata = False
    enable_isolated_metadata = True
    enable_metadata_network = False

File: /etc/neutron/l3\_agent.ini

.. code-block:: ini

    [DEFAULT]
    enable_metadata_proxy = True

[52]

Load-Balancing-as-a-Service
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Load-Balancing-as-a-Service version 2 (LBaaS v2) has been stable since
Liberty. It can be configured with either the HAProxy or Octavia
back-end. LBaaS v1 has been removed since the Newton release.


-  Append the LBaaSv2 service plugin.

File: /etc/neutron/neutron.conf

.. code-block:: ini

    [DEFAULT]
    service_plugins = <EXISTING_PLUGINS>,neutron_lbaas.services.loadbalancer.plugin.LoadBalancerPluginv2

-  Specify the ``<INTERFACE_DRIVER>`` as either ``linuxbridge`` or ``openvswitch``.

File: /etc/neutron/lbaas\_agent.ini

.. code-block:: ini

    [DEFAULT]
    interface_driver = <INTERFACE_DRIVER>

Scenario #1 - HAProxy

File: /etc/neutron/neutron\_lbaas.conf

.. code-block:: ini

    [service_providers]
    service_provider = LOADBALANCERV2:Haproxy:neutron_lbaas.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default

-  Specify the HAProxy driver and the group that HAProxy runs as. In RHEL, it is ``haproxy``.

File: /etc/neutron/lbaas\_agent.ini

.. code-block:: ini

    [DEFAULT]
    device_driver = neutron_lbaas.drivers.haproxy.namespace_driver.HaproxyNSDriver
    [haproxy]
    user_group = haproxy

Scenario #2 - Octavia

File: /etc/neutron/neutron\_lbaas.conf

.. code-block:: ini

    [service_providers]
    service_provider = LOADBALANCERV2:Octavia:neutron_lbaas.drivers.octavia.driver.OctaviaDriver:default

[53]

Quality of Service
^^^^^^^^^^^^^^^^^^

The Quality of Service (QoS) plugin can be used to rate limit the amount
of bandwidth that is allowed through a network port.

-  Append the QoS plugin to the list of service\_plugins.

File: /etc/neutron/neutron.conf

.. code-block:: ini

    [DEFAULT]
    service_plugins = <EXISTING_PLGUINS>,neutron.services.qos.qos_plugin.QoSPlugin

Layer 2 QoS

-  Append the QoS driver to the modular layer 2 (ML2) extension drivers.

File: /etc/neutron/plugins/ml2/ml2_conf.ini

.. code-block:: ini

    [ml2]
    extension_drivers = qos

-  Also append the QoS extension directly to the modular layer 2 configuration. The three supported agents for QoS are: Linux Bridge, Open vSwitch, and SR-IOV.

File: /etc/neutron/plugins/ml2/<AGENT>\_agent.ini

.. code-block:: ini

    [agent]
    extensions = <EXISTING_EXTENSIONS>,qos

Layer 3 QoS

-  Append the "fip_qos" extension in the neutron-l3-agent's configuration file.

File: /etc/neutron/l3_agent.ini

.. code-block:: ini

    [agent]
    extensions = <EXISTING_EXTENSIONS>,fip_qos

-  For Open vSwitch only, this workaround is required to limit the bandwidth usage on routers.

.. code-block:: ini

    [DEFAULT]
    ovs_use_veth = True

[54]

Distributed Virtual Routing
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Distributed virtual routing (DVR) is a concept that involves deploying
routers to both the compute and network nodes to spread out resource
usage. All layer 2 traffic will be equally spread out among the servers.
Public floating IPs will still need to go through the SNAT process via
the routers on the controller or network nodes. This is only supported when the Open
vSwitch agent is used. [55]

File: /etc/neutron/neutron.conf

.. code-block:: ini

    [DEFAULT]
    router_distributed = True

File (compute node):  /etc/neutron/l3\_agent.ini

.. code-block:: ini

    [DEFAULT]
    agent_mode = dvr

File (network node): /etc/neutron/l3\_agent.ini

.. code-block:: ini

    [DEFAULT]
    agent_mode = dvr_snat

File: /etc/neutron/plugins/ml2/ml2\_conf.ini

.. code-block:: ini

    [ml2]
    mechanism_drivers = openvswitch,l2population

File: /etc/neutron/plugins/ml2/openvswitch\_agent.ini

.. code-block:: ini

    [agent]
    l2_population = True
    enable_distributed_routing = True

[56]

High Availability
^^^^^^^^^^^^^^^^^

High availability (HA) in Neutron allows for routers to fail-over to
another duplicate router if one fails or is no longer present. All new
routers will be highly available.

File: /etc/neutron/neutron.conf

.. code-block:: ini

    [DEFAULT]
    l3_ha = True
    max_l3_agents_per_router = 2
    allow_automatic_l3agent_failover = True

[55]

Ceph
~~~~

For Cinder and/or Glance to work with Ceph, the Ceph configuration needs
to exist on each controller and compute node. This can be copied over
from the Ceph nodes. An example is provided below.

.. code-block:: ini

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

It is recommended to create a separate pool and related user for both
the Glance and Cinder service.

.. code-block:: sh

    $ sudo ceph osd pool create glance <PG_NUM> <PGP_NUM>
    $ sudo ceph osd pool create cinder <PG_NUM> <PGP_NUM>
    $ sudo ceph auth get-or-create client.cinder mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=volumes'
    $ sudo ceph auth get-or-create client.glance mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=images'

If Cephx is turned on to utilize authentication, then a client keyring
file should be created on the controller and compute nodes. This will
allow the services to communicate to Ceph as a specific user. The
usernames should match the client users that were just created. [57]

File: ``/etc/ceph/ceph.client.<USERNAME>.keyring``

.. code-block:: ini

    [client.<USERNAME>]
            key = <KEY>

On the controller and compute nodes the Nova, Cinder, and Glance
services require permission to read the ``/etc/ceph/ceph.conf`` and
client configurations at ``/etc/ceph/ceph.client.<USERNAME>.keyring``.
The service users should be added to a common group to help securely
share these settings.

.. code-block:: sh

    $ sudo for openstack_service in "cinder glance nova"; do usermod -a -G ceph ${openstack_service}; done
    $ sudo chmod -R 640 /etc/ceph/
    $ sudo chown -R ceph.ceph /etc/ceph/

For the services to work, the relevant Python libraries for accessing
Ceph need to be installed. These can be installed by the operating
system's package manager. [57]

Fedora:

-  python-ceph-compat
-  python-rbd

Debian:

-  python-ceph

Cinder
~~~~~~

The Cinder service provides block devices for instances.

Ceph
^^^^

Ceph has become the most popular back-end to Cinder due to it's high
availability and scalability.

-  Create a new ``[ceph]`` section for the back-end configuration. The name of this new section must reflect what is set in "enabled_backends."

File: /etc/cinder/cinder.conf

.. code-block:: ini

    [DEFAULT]
    enabled_backends = ceph
    volume_backend_name = volumes
    rados_connect_timeout = -1
    [ceph]
    volume_driver = cinder.volume.drivers.rbd.RBDDriver
    rbd_pool = <RBD_VOLUME_POOL>
    rbd_ceph_conf = /etc/ceph/ceph.conf
    #Ceph supports efficient thin provisioned snapshots when this is set to "False."
    rbd_flatten_volume_from_snapshot = False
    #Only clone an image up to 5 times before creating a new copy of the image.
    rbd_max_clone_depth = 5
    rbd_store_chunk_size = 4
    #Do not timeout when trying to connect to RADOS.
    rados_connect_timeout = -1
    glance_api_version = 2

File: /etc/nova/nova.conf

.. code-block:: ini

    [libvirt]
    images_type = rbd
    images_rbd_pool = <RBD_VOLUME_POOL>
    images_rbd_ceph_conf = /etc/ceph/ceph.conf
    rbd_user = <CEPHX_USER>
    #This is the Libvirt secret UUID used for Cephx authentication.
    rbd_secret_uuid = <LIBVIRT_SECRET_UUID>

[57]

Encryption
^^^^^^^^^^

Cinder volumes support the Linux LUKS encryption. The only requirement
is that the compute nodes have the "cryptsetup" package installed. [58]

.. code-block:: sh

    $ openstack volume type create LUKS
    $ cinder encryption-type-create --cipher aes-xts-plain64 --key_size 512 --control_location front-end LUKS nova.volume.encryptors.luks.LuksEncryptor

Encrypted volumes can now be created.

.. code-block:: sh

    $ openstack volume create --size <SIZE_IN_GB> --type LUKS <VOLUME_NAME>

Glance
~~~~~~

Glance is used to store and manage images for instance deployment.

Ceph
^^^^

Ceph can be used to store images.

File: /etc/glance/glance-api.conf

-  First configure "show_image_direct_url" to allow copy-on-write (CoW) operations for efficient usage of storage for instances. Instead of cloning the entire image, CoW will be used to store changes between the instance and the original image. This assumes that Cinder is also configured to use Ceph.
-  The back-end Ceph IP addressing will be viewable by the public Glance API. For security purposes, ensure that Ceph is not publicly accessible.

.. code-block:: ini

    [DEFAULT]
    show_image_direct_url = True

.. code-block:: ini

    [glance_store]
    stores = rbd
    default_store = rbd
    rbd_store_pool = <RBD_IMAGES_POOL>
    rbd_store_user = <CEPHX_USER>
    rbd_store_ceph_conf = /etc/ceph/ceph.conf
    rbd_store_chunk_size = 8

[59][80]

Neutron Troubleshooting
-----------------------

Neutron is one of the most complicated services offered by OpenStack.
Due to it's wide range of configurations and technologies that it
handles, it can be difficult to troubleshoot problems. This section aims
to clearly layout common techniques to track down and fix issues with
Neutron.

Open vSwitch
~~~~~~~~~~~~

Floating IPs
^^^^^^^^^^^^

Floating IPs can be manually added to the namespace. Depending on the
environment, these rules either need to be added to the
``snat-<ROUTER_ID>`` namespace if it exists or the
``qrouter-<ROUTER_ID>`` namespace. All floating IPs need to be added
with the /32 CIDR, not the CIDR that represents it's true subnet mask.

.. code-block:: sh

    $ sudo ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-OUTPUT -d <FLOATING_IP>/32 -j DNAT --to-destination <LOCAL_IP>
    $ sudo ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-PREROUTING -d <FLOATING_IP>/32 -j DNAT --to-destination <LOCAL_IP>
    $ sudo ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-float-snat -s <LOCAL_IP>/32 -j SNAT --to-source <FLOATING_IP>
    $ sudo ip netns exec snat-<ROUTER_ID> ip address add <FLOATING_IP>/32 brd <FLOATING_IP> dev qg-b2e3c286-b2

With no floating IPs allocated, the iptables NAT table in the SNAT
namespace should look similar to this.

.. code-block:: sh

    $ sudo ip netns exec snat-<ROUTER_ID> iptables -t nat -S
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

[60][61]

Upgrades
--------

Upgrading a production OpenStack environment requires a lot of planning.
It is recommended to test an upgrade of the environment virtually before
rolling it out to production. Automation tools generally have their own
guides but most of these guidelines should still apply to manual
deployment upgrades. The entire steps include to:

-  Backup configuration files and databases.
-  Review the release notes of the OpenStack services that will be
   upgraded. These will contain details of deprecations and new
   configuration changes. https://releases.openstack.org/
-  Update configuration files. Sample configurations can be found at
   ``http://docs.openstack.org/<RELEASE>/config-reference/``.
-  If not already, consider using an automation tool such as Ansible to
   deploy new service configurations.
-  Remove the old package repository for OpenStack.
-  Add the new package repository for OpenStack.
-  Update all of the packages.
-  Restart the services. ``openstack-service restart``

[62]

Command Line Interface Utilities
--------------------------------

The OpenStack command line interface (CLI) resources used to be handled
by separate commands. These have all been modified and are managed by
the universal "openstack" command. The various options and arguments are
explained in Root Pages' OpenStack section `Linux Commands excel
sheet <https://raw.githubusercontent.com/ekultails/rootpages/master/linux_commands.xlsx>`__.

For the CLI utilities to work, the environment variables need to be set
for the project and user. This way the commands can automatically
authenticate.

-  Add the credentials to a text file. Use the ".sh" extension to signify it's a shell script. A few default variables are filled in below.
-  Keystone v2.0

   .. code-block:: sh

       #unset any variables used
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
       #fill in the project, user, and endpoint details
       export PROJECT_ID=
       export PROJECT_NAME=
       export OS_USERNAME=
       export OS_PASSWORD=
       export OS_REGION_NAME="RegionOne"
       export OS_AUTH_URL="http://controller1:5000/v2.0"
       export OS_AUTH_VERSION="2.0"

-  Keystone v3

   .. code-block:: sh

       #unset any variables used
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
       #fill in the project, user, and endpoint details
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

-  Source the credential file to load it into the shell environment:

   .. code-block:: sh

       $ source <USER_CREDENTIALS_FILE>.sh

-  View the available command line options.

   .. code-block:: sh

       $ openstack help

   .. code-block:: sh

       $ openstack help <OPTION>

[63]

Orchestration
-------------

Automating resource management can be accomplished in a few ways.
OpenStack provides Orchestration as a Service (OaaS) via Heat. It is
also possible to use Ansible or Vagrant to automate creating, reading,
updating, and deleting resources in an OpenStack cloud.

Heat
~~~~

Heat is used to orchestrate the deployment of multiple OpenStack
components at once. It can also install and configure software on newly
built instances.

Resources
^^^^^^^^^

Heat templates use YAML formatting and are made of multiple resources.
All of the different resource types are listed here:
https://docs.openstack.org/heat/latest/template\_guide/openstack.html.
Resources use properties to create a component. If no name is specified
(for example, a network name), a random string will be used. Most
properties also accept either an exact ID of a resource or a reference
to a dynamically generated resource (which will provide it's ID once it
has been created). [64]

All Heat templates must began with defining the version of OpenStack is
was designed for (using the release date as the version) and enclose all
resources in a "resources" dictionary. The version indicates that all
features up until that specific release are used. This is for backwards
compatibility reasons.

.. code-block:: yaml

    ---
    heat_template_version: 2017-02-24

    resources:

Valid Heat template versions include [65]:

-  2018-03-02 (Queens)
-  2017-09-01 (Pike)
-  2017-02-24 (Ocata)
-  2016-10-14 (Newton)
-  2016-04-08 (Mitaka)
-  2015-10-15 (Liberty)
-  2015-04-30 (Kilo)
-  2014-10-16 (Juno)
-  2013-05-23 (Icehouse)

This section will go over examples of the more common modules. Each
resource must be nested under the single "resources" section.

Syntax:

.. code-block:: yaml

      <DESCRIPTIVE_OBJECT_NAME>:
        type: <HEAT_RESOURCE_TYPE>
        properties:
          <PROPERTY_1>: <VALUE_1>
          <PROPERTY_2>:
            - <LIST_VALUE_1>
            - <LIST_VALUE_2>
          <PROPERTY_3>:
            <DICTIONARY_KEY_1>: <DICTIONARY_VALUE_1>
            <DICTIONARY_KEY_2>: <DICTIONARY_VALUE_2>

For referencing created resources (for example, creating a subnet in a
created network) the "get\_resource" function should be used.

.. code-block:: yaml

    { get_resource: <OBJECT_NAME> }

Official examples of Heat templates can be found here:
https://github.com/openstack/heat-templates/tree/master/hot. Below is a
demonstration on how to create a virtual machine with public networking.

-  Create a network, assigned to the "internal\_network" object.

.. code-block:: yaml

      internal_network:
        type: OS::Neutron::Net

-  Create a subnet for the created network. Required properties: network
   name or ID.

.. code-block:: yaml

      internal_subnet:
        type: OS::Neutron::Subnet
        properties:
          network: { get_resource: internal_network }
          cidr: 10.0.0.0/24
          dns_nameservers:
            - 8.8.4.4
            - 8.8.8.8

-  Create a port. This object can be used during the instance creation.
   Required properties: network name or ID.

.. code-block:: yaml

      subnet_port:
        type: OS::Neutron::Port
        properties:
          network: { get_resource: internal_network }
          fixed_ips:
            - subnet_id: { get_resource: internal_subnet }
          security_groups:
            - basic_allow

-  Create a router associated with the public "ext-net" network.

.. code-block:: yaml

      external_router:
        type: OS::Neutron::Router
        properties:
          external_gateway_info:
            network: ext-net

-  Attach a port from the network to the router.

.. code-block:: yaml

      external_router_interface:
        type: OS::Neutron::RouterInterface
        properties:
          router: { get_resource: external_router }
          subnet: { get_resource: internal_subnet }

-  Create a key pair called "HeatKeyPair." Required property: name.

.. code-block:: yaml

      ssh_keys:
        type: OS::Nova::KeyPair
        properties:
          name: HeatKeyPair
          public_key: HeatKeyPair
          save_private_key: true

-  Create an instance using the "m1.small" flavor, "RHEL7" image, and
   assign the subnet port created by "OS::Neutron::Port."

.. code-block:: yaml

      instance_creation:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: RHEL7
          networks:
            - port: { get_resource: subnet_port }

-  Allocate an IP from the "ext-net" floating IP pool.

.. code-block:: yaml

      floating_ip:
        type: OS::Neutron::FloatingIP
        properties:
          floating_network: ext-net

-  Allocate a a floating IP to the created instance from a
   "instance\_creation" function. Alternatively, a specific instance's
   ID can be defined here.

.. code-block:: yaml

      floating_ip_association:
        type: OS::Nova::FloatingIPAssociation
        properties:
          floating_ip: { get_resource: floating_ip }
          server_id: { get_resource: instance_creation }

Parameters
^^^^^^^^^^

Parameters allow users to input custom variables for Heat templates.

Common options:

-  type = The input type. This can be a string, number, JSON, a comma
   separated list or a boolean.
-  label = String. The text presented to the end-user for the fillable
   entry.
-  description = String. Detailed information about the parameter.
-  default = A default value for the parameter.
-  constraints = A parameter has to match a specified constraint. Any
   number of constraints can be used from the available ones below.

   -  length = How long a string can be.
   -  range = How big a number can be.
   -  allowed\_values = Allow only one of these specific values to be
      used.
   -  allowed\_pattern = Allow only a value matching a regular
      expression.
   -  custom\_constraint = A full list of custom service constraints can
      be found at
      `http://docs.openstack.org/developer/heat/template\_guide/hot\_spec.html#custom-constraint <#http://docs.openstack.org/developer/heat/template_guide/hot_spec.html#custom-constraint>`__.

-  hidden = Boolean. Specify if the text entered should be hidden or
   not. Default: false.
-  immutable = Boolean. Specify whether this variable can be changed.
   Default: false.

Syntax:

.. code-block:: yaml

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

For referencing this parameter elsewhere in the Heat template, use this
syntax for the variable:

.. code-block:: yaml

    { get_param: <CUSTOM_NAME> }

[66]

Vagrant
~~~~~~~

Vagrant is a tool to automate the deployment of virtual machines. A
"Vagrantfile" file is used to initalize the instance. An example is
provided below.

.. code-block:: ruby

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

Once those settings are configured for the end user's cloud environment,
it can be created by running:

.. code-block:: sh

    $ vagrant up --provider=openstack

[67]

Testing
-------

Tempest
~~~~~~~

Tempest is used to query all of the different APIs in use. This helps to
validate the functionality of OpenStack. This software is a rolling
release aimed towards verifying the latest OpenStack release in
development but it should also work for older versions as well.

The sample configuration file "/etc/tempest/tempest.conf.sample" should be copied to "/etc/tempest/tempest.conf" and then modified. If it is not available then the latest configuration file can be downloaded from one of these sources: https://docs.openstack.org/tempest/latest/sampleconf.html and https://docs.openstack.org/tempest/latest/_static/tempest.conf.sample.

-  Provide credentials to a user with the "admin" role.

   .. code-block:: ini

       [auth]
       admin_username
       admin_password
       admin_project_name
       admin_domain_name
       default_credentials_domain_name = Default

-  Specify the Keystone version to use. Valid options are "v2" and "v3."

   .. code-block:: ini

       [identity]
       auth_version

-  Provide the admin Keystone endpoint for v2 (uri) or v3 (uri\_v3).

   .. code-block:: ini

       [identity]
       uri
       uri_v3

-  Two different size flavor IDs should be given.

   .. code-block:: ini

       [compute]
       flavor_ref
       flavor_ref_alt

-  Two different image IDs should be given.

   .. code-block:: ini

       [compute]
       image_ref
       image_ref_alt

-  Define what services should be tested for the specific cloud.

   .. code-block:: ini

       [service_available]
       cinder = true
       neutron = true
       glance = true
       swift = false
       nova = true
       heat = false
       sahara = false
       ironic = false

[68]

Rally
~~~~~

Rally is the benchmark-as-a-service (BaaS) that tests the OpenStack APIs for both functionality and for helping with performance tuning. This tool has support for using different verifier plugins. It is primarily built to be a wrapper for Tempest that is easier to configure and saves the results to a database so it can generate reports.

Installation
^^^^^^^^^^^^

Install Rally on RHEL. A specific GitHub branch or tag can be specified. Otherwise, the default "master" branch will be used. A target virtual environment directory can also be specified to isolate the installation.

RHEL:

.. code-block:: sh

    $ curl -L -o ~/install_rally.sh https://raw.githubusercontent.com/openstack/rally/0.10.1/install_rally.sh
    $ sudo yum install gcc gmp-devel libffi-devel libxml2-devel libxslt-devel openssl-devel postgresql-devel python-devel python-pip redhat-lsb-core redhat-rpm-config wget
    $ bash ~/install_rally.sh --branch 0.10.1 --target ~/rally-venv

Rally can now be used by activating the Python virtual environment.

.. code-block:: sh

    $ . ~/rally-venv/bin/activate

Finish the installation by initializing a SQLite database for Rally. Alternatively, a MariaDB or PostgreSQL database connection can be configured in ``~/rally-venv/etc/rally/rally.conf``.

.. code-block:: sh

    (rally-venv)$ rally db recreate

If Rally is ever upgraded to the latest version, the database schema also needs to be upgraded.

.. code-block:: sh

    (rally-venv)$ rally db revision
    (rally-venv)$ rally db upgrade

[70]

Registering
^^^^^^^^^^^

Rally requires a configuration, that defines the OpenStack credentials to test with, is registered. It is recommended to use an account with the "admin" role so that all features of the cloud can be tested and benchmarked. The "admin" user is no longer required in Rally version >= 0.10.0. [73]

View registered deployments:

.. code-block:: sh

    (rally-venv)$ rally deployment list
    (rally-venv)$ rally deployment show <DEPLOYMENT_NAME>

`1.` Automatic

The fastest way to create this configuration is by referencing the OpenStack credential's shell environment variables.

.. code-block:: sh

    (rally-venv)$ . <OPENSTACK_RC_FILE>
    (rally-venv)$ rally deployment create --fromenv --name=existing

`2.` Manual

A JSON file can be created to define the OpenStack credentials that Rally will be using. Example files can be found at `~/rally-venv/samples/deployments/`.

.. code-block:: sh

    (rally-venv)$ cp ~/rally-venv/samples/deployments/existing.json ~/existing.json

.. code-block:: json

    {
        "devstack": {
            "auth_url": "https://<KEYSTONE_ENDPOINT_HOST>:5000/v3/",
            "region_name": "RegionOne",
            "endpoint_type": "public",
            "admin": {
                "username": "admin",
                "password": "<PASSWORD>",
                "user_domain_name": "admin",
                "project_name": "admin",
                "project_domain_name": "admin"
            },
            "https_insecure": false,
            "https_cacert": "<PATH_TO_CA_CERT>"
        }
    }

For only using non-privileged OpenStack users, omit the "admin" dictionary. [72]

.. code-block:: json

    {
        "openstack": {
            "auth_url": "https://<KEYSTONE_ENDPOINT_HOST>:5000/v3",
            "region_name": "RegionOne",
            "endpoint_type": "public",
            "users": [
                {
                    "username": "<USER_NAME>",
                    "password": "<PASSWORD>",
                    "user_domain_name": "Default"
                    "project_name": "<PROJECT_NAME>"
                    "project_domain_name": "Default"
                }
            ]
        }
    }

.. code-block:: sh

    (rally-venv)$ rally deployment create --file=~/existing.json --name=<DEPLOYMENT_NAME>

[71]

Scenarios
^^^^^^^^^

Scenarios define the tests that will be ran. Variables can be tweaked to customize them. All Rally scenario files are Jinja2 templates and can be in JSON or YAML format. Multiple scenarios can be setup in a single file for Rally to test them all.

Example scenarios:

.. code-block:: sh

    (rally-venv)$ ls -1 ~/rally-venv/samples/tasks/scenarios/*

Each scenario can be configured using similar options.

-  args = Override default values for a task.
-  context = Defines the resources that need to be created before a task runs.
-  runner [74]

    -  concurrency (constant types) = The number of tasks to run at the same time (as different threads).
    -  duration (constant_for_duration type) = The number of seconds to run a scenario before finishing.
    -  max_concurrent (rps type) = The maximum number of threads that should spawn.
    -  rps (rps type) = The number of seconds to wait before starting a task in a new thread.
    -  times = The number of times the scenario should run.
    -  type

        -  constant =  The number of *times* a scenario should run. Optionally run in parallel by setting the *concurrency*.
        -  constant_for_duration = Run the scenario for a specified amount of time, in seconds, as defined by *duration*.
        -  rps = Runs per second. Every *rps* amount of seconds a task is ran as a new thread.
        -  serial = Specify the number of *times* to run a single task (without any concurrency support).

-  sla = "Service level agreement." This defines when to mark a scenario as being failed.

    -  failure_rate

        -  max = The number of times a task can fail before the scenario is marked as a failure.

    -  max_seconds_per_iteration = The amount of seconds before a task is considered failed.

After creating a scenario, it can be run from the CLI:

.. code-block:: sh

    (rally-venv)$ rally task start <SCENARIO_FILE>.<JSON_OR_YAML>

[71]

Reports
^^^^^^^

All tasks that Rally runs are permanently stored in the database. The same detailed report that is sent to the standard output can also be viewed at any time after tasks are done running.

.. code-block:: sh

    (rally-venv)$ rally task list
    (rally-venv)$ rally task status <TASK_UUID>
    (rally-venv)$ rally task detailed <TASK_UUID>

Reports can be generated in a "html" or "json" format. Multiple tasks can also be added to a single report.

.. code-block:: sh

    (rally-venv)$ rally task report <TASK_UUID_1> <TASK_UUID_2> <TASK_UUID_3> --<FORMAT>

The JUnit XML (a Java unit test library) format can also be used. This library is not installed by default.

.. code-block:: sh

    (rally-venv)$ pip install junit-xml
    (rally-venv)$ rally task export <TASK_UUID> --type junit

[78]

Performance
-----------

OpenStack can be tuned to use less load and run faster.

-  KeyStone

    -  Switch to Fernet keys.

        -  Creation of tokens is significantly faster because it does not rely on storing them in a database.

-  Neutron

    -  Use distributed virtual routing (DVR).

        -  This offloads a lot of networking resources onto the compute nodes.

-  General

    -  Utilize local DNS.

        -  Ensure that all of the domain names in use are either available via a local recursive DNS server or on each server in the /etc/hosts file. This avoids a performance hit from external DNS lookups.

    -  Use memcache.

        -  This is configured by an option called "memcache\_servers" in the configuration files for most services. Consider using "CouchBase" for it's ease of clustering and redundancy support.

`Errata <https://github.com/ekultails/rootpages/commits/master/src/openstack.rst>`__
------------------------------------------------------------------------------------

Bibliography
------------

1. "OpenStack Releases." OpenStack Releases. March 15, 2018. Accessed March 15, 2018. https://releases.openstack.org/
2. "New OpenStack Ocata stabilizes popular open-source cloud." February 22, 2017. Accessed April 10, 2017. http://www.zdnet.com/article/new-openstack-ocata-stabilizes-popular-open-source-cloud/
3. "Ocata [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/ocata/index.html
4. "Pike [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/pike/index.html
5. "Queens [Goals]." OpenStack Documentation. September 26, 2017. Accessed October 4, 2017. https://governance.openstack.org/tc/goals/pike/index.html
6. "Red Hat OpenStack Platform Life Cycle." Red Hat Support. January 24, 2018. https://access.redhat.com/support/policy/updates/openstack/platform
7. "Frequently Asked Questions." RDO Project. Accessed December 21, 2017. https://www.rdoproject.org/rdo/faq/
8. "How can I determine which version of Red Hat Enterprise Linux - Openstack Platform (RHEL-OSP) I am using?" Red Hat Articles. May 20, 2016. Accessed December 19, 2017. https://access.redhat.com/articles/1250803
9. "Director Installation and Usage." Red Hat OpenStack Platform 10 Documentation. November 23, 2017. Accessed December 22, 2017. https://access.redhat.com/documentation/en-us/red\_hat\_openstack\_platform/10/pdf/director\_installation\_and\_usage/Red\_Hat\_OpenStack\_Platform-10-Director\_Installation\_and\_Usage-en-US.pdf
10. "Project Navigator." OpenStack. Accessed March 15, 2018. https://www.openstack.org/software/project-navigator/
11. "Packstack: Create a proof of concept cloud." RDO Project. Accessed March 19, 2018. https://www.rdoproject.org/install/packstack/
12. "Neutron with existing external network. RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/networking/neutron-with-existing-external-network/
13. "Error while installing openstack 'newton' using rdo packstack." Ask OpenStack. October 25, 2016. Accessed September 28, 2017. https://ask.openstack.org/en/question/97645/error-while-installing-openstack-newton-using-rdo-packstack/
14. "OpenStack-Ansible." GitHub. March 2, 2018. Accessed March 19, 2018. https://github.com/openstack/openstack-ansible
15. "[OpenStack-Ansible] Quickstart: AIO." OpenStack  Documentation. March 26, 2018. Accessed March 26, 2018. https://docs.openstack.org/openstack-ansible/queens/user/aio/quickstart.html
16. "OpenStack-Ansible Deployment Guide." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/project-deploy-guide/openstack-ansible/queens/
17. "Nova role for OpenStack-Ansible." OpenStack Documentation. March 15, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible-os\_nova/queens/
18. "openstack ansible ceph." OpenStack FAQ. April 9, 2017. Accessed April 9, 2017. https://www.openstackfaq.com/openstack-ansible-ceph/
19. "Configuring the Ceph client (optional)." OpenStack Documentation. April 5, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-ceph\_client/configure-ceph.html
20. "[OpenStack-Ansible] Operations Guide." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible/queens/admin/index.html
21. "Developer Documentation." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible/latest/contributor/index.html
22. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible/queens/user/index.html
23. "TripleO quickstart." RDO Project. Accessed March 26, 2018. https://www.rdoproject.org/tripleo/
24. "[TripleO] Minimum System Requirements." TripleO Documentation. September 7, 2016. Accessed March 26, 2018. https://images.rdoproject.org/docs/baremetal/requirements.html
25. [RDO] Recommended hardware." RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/hardware/recommended/
26. "[TripleO] Virtual Environment." TripleO Documentation. Accessed September 28, 2017. http://tripleo-docs.readthedocs.io/en/latest/environments/virtual.html
27. "Getting started with TripleO-Quickstart." OpenStack Documentation. Accessed December 20, 2017. https://docs.openstack.org/tripleo-quickstart/latest/getting-started.html
28. "TripleO Documentation." OpenStack Documentation. Accessed September 12, 2017. https://docs.openstack.org/tripleo-docs/latest/
29. "Basic Deployment (CLI)." OpenStack Documentation. Accessed November 9, 2017. https://docs.openstack.org/tripleo-docs/latest/install/basic\_deployment/basic\_deployment\_cli.html
30. "Bug 1466744 - Include docker.yaml and docker-ha.yaml environment files by default." Red Hat Bugzilla. December 13, 2017. Accessed January 12, 2018. https://bugzilla.redhat.com/show\_bug.cgi?id=1466744
31. "DevStack switching from MySQL-python to PyMySQL." OpenStack nimeyo. June 9, 2015. Accessed October 15, 2016. https://openstack.nimeyo.com/48230/openstack-all-devstack-switching-from-mysql-python-pymysql
32. "Using PostgreSQL with OpenStack." FREE AND OPEN SOURCE SOFTWARE KNOWLEDGE BASE. June 06, 2014. Accessed October 15, 2016. https://fosskb.in/2014/06/06/using-postgresql-with-openstack/
33. "[Ceilometer] Installation Guide." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/ceilometer/queens/install/
34. "Liberty install guide RHEL, keystone DB population unsuccessful: Module pymysql not found." OpenStack Manuals Bugs. March 24, 2017. Accessed April 3, 2017. https://bugs.launchpad.net/openstack-manuals/+bug/1501991
35. "Message queue." OpenStack Documentation. March 18, 2018. Accessed March 19, 2018. https://docs.openstack.org/install-guide/environment-messaging.html
36. "[oslo.messaging] Configurations." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/oslo.messaging/queens/configuration/
37. "ZeroMQ Driver Deployment Guide." OpenStack Documentation. March 1, 2018. Accessed March 15, 2018. https://docs.openstack.org/oslo.messaging/latest/admin/zmq\_driver.html
38. "[Keystone] Pike Series Release Notes." OpenStack Documentation. Accessed March 15, 2018. https://docs.openstack.org/releasenotes/keystone/pike.html
39. "Setting up an RDO deployment to be Identity V3 Only." Young Logic. May 8, 2015. Accessed October 16, 2016. https://adam.younglogic.com/2015/05/rdo-v3-only/
40. "Install and configure [Keystone on RDO]." OpenStack Documentation. March 13, 2018. Accessed March 15, 2018. https://docs.openstack.org/keystone/queens/install/keystone-install-rdo.html
41. "OpenStack Keystone Fernet tokens." Dolph Mathews. Accessed August 27th, 2016. http://dolphm.com/openstack-keystone-fernet-tokens/
42. "Ocata Series [Keystone] Release Notes." OpenStack Documentation. Accessed April 3, 2017. https://docs.openstack.org/releasenotes/keystone/ocata.html
43. "Hypervisors." OpenStack Documentation. March 8, 2018. Accessed March 18, 2018. https://docs.openstack.org/nova/queens/admin/configuration/hypervisors.html
44. “Driving in the Fast Lane – CPU Pinning and NUMA Topology Awareness in OpenStack Compute.” Red Hat Stack. Mary 5, 2015. Accessed April 13, 2017. http://redhatstackblog.redhat.com/2015/05/05/cpu-pinning-and-numa-topology-awareness-in-openstack-compute/
45. "CPU topologies." OpenStack Documentation. March 8, 2018. Accessed March 18, 2018. https://docs.openstack.org/nova/queens/admin/cpu-topologies.html
46. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. Accessed March 18, 2018. http://docs.ceph.com/docs/master/rbd/rbd-openstack
47. "Nested Virtualization in OpenStack, Part 2." Stratoscale. June 28, 2016. Accessed November 9, 2017. https://www.stratoscale.com/blog/openstack/nested-virtualization-openstack-part-2/
48. "[Compute service] Overview." OpenStack Documentation. March 8, 2018. Accessed March 19, 2018. https://docs.openstack.org/nova/queens/install/overview.html
49. "Open vSwitch: Self-service networks." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/deploy-ovs-selfservice.html
50. "Neutron Installation Guide." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/install/index.html
51. "DNS resolution for instances." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-dns-res.html
52. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/
53. "Load Balancer as a Service (LBaaS)." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-lbaas.html
54. "Quality of Service (QoS)." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-qos.html
55. "Neutron/DVR/HowTo" OpenStack Wiki. January 5, 2017. Accessed March 7, 2017. https://wiki.openstack.org/wiki/Neutron/DVR/HowTo
56. "Distributed Virtual Routing with VRRP." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-dvr-ha-snat.html
57. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. Accessed March 26, 2018. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
58. "Volume encryption supported by the key manager." Openstack Documentation. March 18, 2018. Accessed March 19, 2018. https://docs.openstack.org/cinder/queens/configuration/block-storage/volume-encryption.html
59. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
60. "Adding additional NAT rule on neutron-l3-agent." Ask OpenStack. February 15, 2015. Accessed February 23, 2017. https://ask.openstack.org/en/question/60829/adding-additional-nat-rule-on-neutron-l3-agent/
61. "Networking in too much detail." RDO Project. January 9, 2017. Accessed February 23, 2017. https://www.rdoproject.org/networking/networking-in-too-much-detail/
62. "Upgrades." OpenStack Documentation. January 15, 2017. Accessed January 15, 2017. http://docs.openstack.org/ops-guide/ops-upgrades.html
63. "OpenStack Command Line." OpenStack Documentation. Accessed October 16, 2016. http://docs.openstack.org/developer/python-openstackclient/man/openstack.html
64. "OpenStack Orchestration In Depth, Part I: Introduction to Heat." Accessed September 24, 2016. November 7, 2014. https://developer.rackspace.com/blog/openstack-orchestration-in-depth-part-1-introduction-to-heat/
65. "Heat Orchestration Template (HOT) specification." OpenStack Documentation. November 17, 2017. Accessed November 17, 2017. https://docs.openstack.org/heat/latest/template\_guide/hot\_spec.html
66. "Heat Orchestration Template (HOT) specification." OpenStack Developer Documentation. October 21, 2016. Accessed October 22, 2016. http://docs.openstack.org/developer/heat/template\_guide/hot\_spec.html
67. "Vagrant OpenStack Cloud Provider." GitHub - ggiamarchi. January 30, 2017. Accessed April 3, 2017. https://github.com/ggiamarchi/vagrant-openstack-provider
68. "Tempest Configuration Guide." Sep 14th, 2016. http://docs.openstack.org/developer/tempest/configuration.html
69. "Stable branches." OpenStack Documentation. December 12, 2017. Accessed January 24, 2018. https://docs.openstack.org/project-team-guide/stable-branches.html
70. "[Rally] Installation and upgrades." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/install\_and\_upgrade/index.html
71. "[Rally] Quick start." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/quick\_start/index.html
72. "Step 3. Benchmarking OpenStack with existing users." OpenStack Documentation. July 3, 2017. Accessed January 25, 2018. https://docs.openstack.org/developer/rally/quick\_start/tutorial/step\_3\_benchmarking\_with\_existing\_users.html
73. "Allow deployment without admin creds." OpenStack Gerrit Code Review. June 3, 2017. Accessed January 25, 2018. https://review.openstack.org/#/c/465495/
74. "Main concepts of Rally." OpenStack Documentation. July 3, 2017. Accessed January 26, 2018. https://docs.openstack.org/developer/rally/miscellaneous/concepts.html
75. "[Ironic] Enabling drivers." OpenStack Documentation. March 15, 2018. Accessed March 15, 2018. https://docs.openstack.org/ironic/queens/admin/drivers.html
76. "VirtualBMC." TripleO Documentation. Accessed January 29, 2018.
77. "CHAPTER 8. SCALING THE OVERCLOUD." Red Hat Documentation. Accessed January 30, 2018. https://access.redhat.com/documentation/en-us/red\_hat\_openstack\_platform/10/html/director\_installation\_and\_usage/sect-scaling\_the\_overcloud
78. "Verification reports." Rally Documentation. Accessed March 13, 2018. http://docs.xrally.xyz/projects/openstack/en/latest/verification/reports.html
79. "OpenStack Pike Repository." CentOS Mirror. Accessed March 15, 2018. http://mirror.centos.org/centos-7/7/cloud/x86\_64/openstack-pike/
80. "External Ceph." OpenStack Documentation. March 15, 2018. Accessed March 19, 2018. https://docs.openstack.org/kolla-ansible/queens/reference/external-ceph-guide.html
81. "Containers based Undercloud Deployment." OpenStack Documentation. Accessed March 19, 2018. https://docs.openstack.org/tripleo-docs/latest/install/containers\_deployment/undercloud.html
