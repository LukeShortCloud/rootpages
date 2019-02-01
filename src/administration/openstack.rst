OpenStack
=========

.. contents:: Table of Contents

Introduction
------------

This guide is aimed to help Cloud Administrators through deploying, managing, and upgrading OpenStack.

Versions
~~~~~~~~

Each OpenStack release starts with a letter, chronologically starting with A. These are usually named after the city where one of the recent development conferences were held. The major version number of OpenStack represents the major version number of each software in that release. For example, Ocata software is versioned as ``15.X.X``. A new feature release comes out after about 6 months of development. Every major release adheres to a maintenance cycle.

Maintenance Phases <= Newton

-  Phase 1 = 6 months of stability and security fixes.
-  Phase 2 = 6 months of major stability and security fixes.
-  Phase 3 = 6 months of major security fixes.

Maintenance Phases >= Ocata

-  Maintained = 18 months of stability and security fixes and official releases from the OpenStack Foundation.
-  Extended Maintenance (em) = Stability and security fixes by community contributors. There are no tagged minor releases. The code will be treated as a rolling minor release.
-  Unmaintained = 6 months of no community contributions.
-  EOL = The last version of that OpenStack release to be archived.

[69]

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
    -  EOL: TBD [1]
    -  Goals:

       -  Stability. This release included features that are mainly related to reliability, scaling, and performance enhancements. This came out 5 months after Newton, instead of the usual 6, due to the minimal amount of major changes. [2]
       -  Remove old OpenStack libraries that were built into some services. Instead, services should rely on the proper up-to-date dependencies provided by external packages. [3]

    - `New Features <https://www.openstack.org/news/view/302/openstack-ocata-strengthens-core-infrastructure-services-and-container-integration-with-15th-release-of-cloud-computing-software>`__

16. Pike

    -  Release: 2017-08-30
    -  EOL: TBD [1]
    -  Goals:

       -  Convert most of the OpenStack code to be compatible with Python 3. This is because Python 2 will become EOL in 2020.
       -  Make all APIs into WSGI applications. This will allow web servers to scale out and run faster with tuning compared to running as a standalone Python daemon. [4]

    -  `New Features <https://www.openstack.org/news/view/340/openstack-pike-delivers-composable-infrastructure-services-and-improved-lifecycle-management>`__

17. Queens

    -  Release: 2018-02-28
    -  EOL: TBD [1]
    -  Goals:

       -  Remove the need for the access control list "policy" files by having default values defined in the source code.
       -  Tempest will be split up into different projects for maintaining individual service unit tests. This contrasts with the old model that had all Tempest tests maintained in one central repository. [5]

    -  `New Features <https://www.openstack.org/news/view/371/openstack-queens-release-expands-support-for-gpus-and-containers-to-meet-edge-nfv-and-machine-learning-workload-demands>`__
    -  `Release Highlights <https://releases.openstack.org/queens/highlights.html>`__

18. Rocky

    -  Release: 2018-08-30
    -  EOL: TBD [1]
    -  Goals:

       -  Make configuraiton options mutable. This avoids having to restart services whenever the configuraiton is updated.
       -  Remove deprecated mox tests to further push towards full Python 3 support. [93]

    -  `New Features <https://superuser.openstack.org/articles/what-you-need-to-know-about-the-openstack-rocky-release/>`__
    -  `Release Highlights <https://releases.openstack.org/rocky/highlights.html>`__

19. Stein

    -  Expected release: 2019-04-10
    -  EOL: TBD [1]
    -  Goals:

       -  Use Python 3 by default. Python 2.7 will only be tested using unit tests.
       -  Pre-upgrade checks. Verify if an upgrade will be successful. Also provide useful information to the end-user on how to overcome known issues. [95]

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
   -  EOL: 2019-08-24

-  **RHOSP 10 LL (Newton)**

   -  Release: 2016-12-15
   -  EOL: 2021-12-15

-  RHOSP 11 (Ocata)

   -  Release: 2017-05-18
   -  EOL: 2018-05-18

-  RHOSP 12 (Pike)

   -  Release: 2017-12-13
   -  EOL: 2018-12-13

-  **RHOSP 13 LL (Queens)**

   -  Release: 2018-06-27
   -  EOL: 2023-06-27

[6]

RHOSP supports running a virtualized Undercloud on these platforms [9]:

-  Kernel-based Virtual Machine (QEMU with KVM acceleration)
-  Red Hat Virtualization (RHV)
-  Microsoft Hyper-V
-  VMWare ESX and ESXi

RHOSP only supports using libvirt with KVM as the compute hypervisor's virtualization technology. [94]

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

After the installation is finished, create the necessary network in Neutron as the admin user. In this example, the network will automatically allocate IP addresses between 192.168.1.201 and 192.168.1.254. The IP 192.168.1.1 is both the physical router and default gateway.

.. code-block:: sh

    $ . keystonerc_admin
    $ openstack network create --share --provider-physical-network physical_network --provider-network-type flat --router external external_network
    $ openstack subnet create --subnet-range 192.168.1.0/24 --gateway 192.168.1.1 --network external_network --allocation-pool start=192.168.1.201,end=192.168.1.254 --no-dhcp public_subnet

The "external\_network" can now be associated with a router in user accounts.

[12][90]

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

-  CONFIG_<SERVICE>_INSTALL = Install a specific OpenStack service.
-  CONFIG_<NODE>_HOST = The host to setup the relevant services on.
-  CONFIG_<NODE>_HOSTS = A list of hosts to setup the relevant
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

-  Supported operating systems: Ubuntu 16.04
-  Experimentally supported operating systems: CentOS 7, openSUSE Leap 42

OpenStack-Ansible uses Ansible for automating the deployment of Ubuntu inside of LXC containers that run the OpenStack services. This was created by RackSpace as an official tool for deploying and managing production environments.

It offers key features that include:

-  Full LXC containerization of services.
-  HAProxy load balancing for clustering containers.
-  Scaling for MariaDB Galera, RabbitMQ, compute nodes, and more.
-  Central logging with rsyslog.
-  OpenStack package repository caching.
-  Automated upgrades.

[16]

The `OpenStack-Ansible GitHub repository <https://github.com/openstack/openstack-ansible>`__ has three different versions that can be used for deployments or upgrades.

-  ``stable/<OPENSTACK_RELEASE_NAME>`` = A branch for a specific release of OpenStack. All of the latest updates are committed here. Example: "stable/queens".
-  ``<OPENSTACK_RELEASE_NUMBER_MAJOR>.<OSA_MINOR>.<OSA_PATCH>`` = A tag of a specific OpenStack-Ansible release. The major version number is the same number that correlates to the OpenStack release. The minor and patch versions represent OpenStack-Ansible updates to the code. Example: "17.0.2" is the OpenStack Queens release and is the second OpenStack-Ansible update.
-  ``<OPENSTACK-RELEASE>-eol`` =  A tag of an end-of-life release. Upstream versions of OpenStack no longer recieve any support after a year. This contains the last code for that release. Example: "newton-eol".

SELinux is currently not supported for CentOS deployments due to the lack of SELinux maintainers in OpenStack-Ansible. [14]

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

There are many all-in-one scenarios that will run different Ansible playbooks. The default is "aio_lxc" which deploys the major OpenStack services to LXC containers. This can be changed to a different scenario by setting the ``SCENARIO`` shell variable to something else. Alternatively, the playbooks to run can be manually modified from the variable file ``/opt/openstack-ansible/tests/vars/bootstrap-aio-vars.yml``. Additional playbooks can be added by copying them from ``/opt/openstack-ansible/etc/openstack_deploy/conf.d/`` to ``/etc/openstack_deploy/conf.d/``. The file extensions should be changed from ``.yml.aio`` to ``.yml`` to be correctly parsed.

``$ export SCENARIO="aio_basekit"``

Scenarios:

-  aio_basekit
-  aio_lxc (Default)
-  aio_metal
-  ceph
-  octavia
-  tacker
-  translations

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
configurations have been removed.

After a reboot, the three-node MariaDB Galera cluster needs to be restarted properly by running the Galera installation playbook again.

.. code-block:: sh

   $ cd /opt/openstack-ansible/playbooks
   $ sudo openstack-ansible -e galera_ignore_cluster_state=true galera-install.yml

[15]

OpenStack-Ansible will create a default "public" and "private" networks for the "demo" project. These are both on isolated networks that are only on the hypervisor. These networks can be removed by deleting these resources in the order below.

.. code-block:: sh

    $ openstack router unset --external-gateway router
    $ openstack router remove subnet router private-subnet
    $ openstack router delete router
    $ openstack network delete public
    $ openstack network delete private

The all-in-one environment does not have the ability to create networks on the external network. On a more complete lab deployment of OpenStack-Ansible (not an all-in-one), this is normally accomplished by creating a flat provider network. Example:

.. code-block:: sh

    $ openstack router create router_public
    $ openstack network create --share --provider-network-type flat --provider-physical-network flat --external external_network
    $ openstack subnet create --subnet-range 192.168.1.0/24 --allocation-pool start=192.168.1.201,end=192.168.1.254 --dns-nameserver 192.168.1.1 --gateway 192.168.1.1 --no-dhcp --network external_network external_subnet
    $ openstack router set router_public --external-gateway external_network

[91]

Uninstall
'''''''''

`This Bash script <https://docs.openstack.org/openstack-ansible/queens/user/aio/quickstart.html#rebuilding-an-aio>`__ can be used to clean up and uninstall most of the
OpenStack-Ansible installation. Use at your own risk. The recommended
way to uninstall OpenStack-Ansible is to reinstall the operating system. [15]

Full
^^^^

Minimum requirements:

-  3 infrastructure nodes
-  2 compute nodes
-  1 log node

It is also required to have at least 3 different network bridges.

-  **br-mgmt** = All the nodes should have this network. This is the
   management network where all nodes can be accessed and managed by.
-  br-storage = This is the only optional interface. It is
   recommended to use this to separate the "storage" nodes traffic. This
   should exist on the "storage" (when using bare-metal) and "compute"
   nodes.
-  **br-vlan** = This should exist on the "network" (when using bare-metal) and "compute" nodes. It is used for external provider networks.
-  **br-vxlan** = This should exist on the "network" and "compute" nodes. It is used for private self-service networks.

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

Neutron
&&&&&&&

The ``br-vlan`` interface should provide access to the Internet. This is normally configured to use a VLAN. However, it can also be configured to use flat networking using the example configurations below. The "eth11" interface will be used to attach the ``br-vlan`` bridge onto with no VLAN tagging. [89]

.. code-block:: yaml

    provider_networks:
      - network:
        container_bridge: "br-vlan"
        container_type: "veth"
        container_interface: "eth11"
        type: "flat"
        net_name: "flat"
        group_binds:
          - neutron_linuxbridge_agent

After deployment, the external Neutron network and subnet can be created. [90]

.. code-block:: sh

    $ . /root/openrc
    $ openstack network create --share --provider-physical-network physical_network --provider-network-type flat --router external external_network
    $ openstack subnet create --subnet-range 192.168.1.0/24 --gateway 192.168.1.1 --network external_network --allocation-pool start=192.168.1.201,end=192.168.1.254 --no-dhcp public_subnet

Nova
&&&&

Common variables:

-  nova\_virt\_type = The virtualization technology to use for deploying
   instances with OpenStack. By default, OpenStack-Ansible will guess`
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

TripleO Queens configuration:

.. code-block:: yaml

   parameter_defaults:
     NovaEnableRbdBackend: true
     CinderEnableRbdBackend: true
     CinderBackupBackend: ceph
     GlanceBackend: rbd
     GnocchiBackend: rbd
     NovaRbdPoolName: vms
     CinderRbdPoolName: volumes
     CinderBackupRbdPoolName: backups
     GlanceRbdPoolName: images
     GnocchiRbdPoolName: metrics
     CephClientUserName: openstack
     CephClusterFSID: '<CLUSTER_FILE_SYSTEM_ID>'
     CephClientKey: '<CEPHX_USER_KEY>'
     CephExternalMonHost: '<CEPH_MONITOR_1>, <CEPH_MONITOR_2>, <CEPH_MONITOR_3>'

[98]

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

This is for upgrading OpenStack from one minor version to another in the same major release. An example would be going from 17.0.0 to 17.0.6.

-  Change the OpenStack-Ansible version to a new minor tag release. If a
   branch for a OpenStack release name is being used already, pull the
   latest branch commits down from GitHub.

   .. code-block:: sh

       $ cd /opt/openstack-ansible/
       $ sudo git fetch --all
       $ sudo git tag
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

OpenStack-Ansible has playbooks capable of fully upgrading OpenStack from one major release to the next. It is recommended to do a manual upgrade by following the `official guide <https://docs.openstack.org/openstack-ansible/queens/admin/upgrades/major-upgrades.html>`__. Below outlines how to do this automatically. OpenStack should first be updated to the latest minor version. [22]

-  Move into the OpenStack-Ansible project.

   .. code-block:: sh

       $ cd /opt/openstack-ansible

-  View the available OpenStack releases and choose which one to use.

   .. code-block:: sh

       $ sudo git fetch --all
       $ sudo git branch -a
       $ sudo git tag
       $ sudo git checkout <BRANCH_OR_TAG>

-  Run the upgrade script.

   .. code-block:: sh

       $ sudo ./scripts/run-upgrade.sh

TripleO
~~~~~~~

Supported operating systems: RHEL/CentOS 7, Fedora >= 22

TripleO means "OpenStack on OpenStack." The Undercloud is first deployed in a small, usually all-in-one, environment. This server is then used to create and manage a full Overcloud cluster.

In Pike, most of the Overcloud can be deployed into docker containers built by Kolla. The most notable service that lacked container support was Neutron due to it's complexity. Starting in Queens, all of the Overcloud services can now be installed as docker containers. Experimental support for also running the Undercloud services in containers was added in Queens and became the default configuration for Rocky. [81]

Minimum recommended hardware requirements [24]:

-  Undercloud node:

   -  4 CPU cores
   -  8GB RAM (16GB recommended)
   -  60GB storage
   -  2 network interface cards (NICs) [82]

-  Overcloud nodes:

   -  4 CPU cores
   -  8GB RAM
   -  80GB storage

Here is an overview of the deployment process using TripleO:

- Install the all-in-one Undercloud. This cloud will be used by the OpenStack operator to control and manage the Overcloud.
- Import the Overcloud nodes into Ironic.
- Configure those nodes to load both an initramfs and full kernel via a PXE boot.
- Optionally set the nodes to be "manageable" and introspect the Overcloud nodes. This will report back detailed information about each node.
- Set the Overcloud nodes to be "available" for provisioning.
- Optionally configure settings for the Overcloud deployment (highly recommended).
- Deploy the Overcloud. This cloud will be the production cloud that developers can use.

TripleO Quickstart
^^^^^^^^^^^^^^^^^^

The TripleO Quickstart project was created to use Ansible to automate deploying a TripleO Undercloud and Overcloud. [23] The project recommends a minimum of 32GB RAM and 120GB of disk space when deploying with the default settings. [25] This deployment has to use a baremetal hypervisor. Deploying TripleO within a virtual machine that uses nested virtualization is not supported. [26]

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

       $ sudo bash quickstart.sh --install-deps

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

   - ``--clean`` = Remove previously created files from the working
     directory on the start of TripleO Quickstart.
   - ``--extra-vars supported_distro_check=false`` = Run on an unsupported hypervisor such as Fedora.
   - ``--no-clone`` = Use the current working directory for
     TripleO Quickstart. This should only be if the entire repository
     has been cloned.
   - ``--nodes config/nodes/<CONFIGURATION>.yml`` = Specify the
     configuration that determines how many Overcloud nodes should be
     deployed.
   - ``--playbook`` = Specify a Playbook to run.
   - ``--release`` = The OpenStack release to use. All of the available
     releases can be found in the GitHub project in the
     "config/release/" directory. Use "trunk/``<RELEASE_NAME>``" for
     the development version and "stable/``<RELEASE_NAME>``" for the
     stable version.
   - ``--retain-inventory`` = Use the existing inventory. This is
     useful for managing an existing TripleO Quickstart infrastructure.
   - ``--teardown {all|nodes|none|virthost}`` = Delete everything
     related to TripleO (all), only the virtual machines (nodes),
     nothing (none), or the virtual machines and settings on the
     hypervisor (virthost).
   - ``--tags all`` = Deploy a complete all-in-one TripleO installation
     automatically. If a Playbook is specified via ``-p``, then
     everything in that Playbook will run.
   - ``-v`` = Show verbose output from the Ansible Playbooks.
   - ``--config=~/.quickstart/config/general_config/containers_minimal.yml`` = Deploy the Overcloud from Kolla docker containers. [81]

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

Standalone Containers
^^^^^^^^^^^^^^^^^^^^^

Starting with Rocky, an all-in-one cloud can be deployed using TripleO. This skips the Undercloud and instead deploys a fully functional Overcloud. Instructions on how to do this are documented `here <https://docs.openstack.org/tripleo-docs/latest/install/containers_deployment/standalone.html>`__.

Full
^^^^

Install
'''''''

Undercloud
&&&&&&&&&&

The Undercloud can be installed onto a bare metal server or a virtual machine. Follow the "hypervisor" section to assist with automatically creating an Undercloud virtual machine. The Undercloud requires at least 2 NICs (typically ``eth0`` and ``eth1``). The first is used for external connectivity. The second is dedicated to provisioning the Overcloud nodes with Ironic. On those nodes, the related interface that can reach the Undercloud's ``eth1`` should be configured for PXE booting in the BIOS. [82]

-  **Undercloud (Automatic)**

   -  RDO provides pre-made Undercloud images.

       -  <= Queens:

           .. code-block:: sh

              $ curl -O https://images.rdoproject.org/queens/delorean/current-tripleo-rdo/undercloud.qcow2

       -  >= Rocky:

           .. code-block:: sh

              $ curl -O https://images.rdoproject.org/rocky/rdo_trunk/current-tripleo-rdo/undercloud.qcow2

   -  TripleO Quickstart can build an Undercloud image.

      -  Leave the overcloud\_nodes variable blank to only deploy the Undercloud. Otherwise, provide a number of virtual machines that should be created for use in the Overcloud.

      .. code-block:: sh

          $ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh
          $ bash quickstart.sh --release trunk/queens --tags all --playbook quickstart.yml -e overcloud_nodes="" $VIRTHOST

   -  Log into the virtual machine once TripleO Quickstart has completed
      setting up the environment.

      .. code-block:: sh

          $ ssh -F ~/.quickstart/ssh.config.ansible undercloud


-  **Undercloud (Manual)**

   -  Install the necessary repositories.

      -  TripleO

         -  Install the RDO Trunk / Delorean repositories.

            .. code-block:: sh

                $ sudo curl -L -o /etc/yum.repos.d/delorean-queens.repo https://trunk.rdoproject.org/centos7-queens/current/delorean.repo
                $ sudo curl -L -o /etc/yum.repos.d/delorean-deps-queens.repo https://trunk.rdoproject.org/centos7-queens/delorean-deps.repo

         -  Install the latest Tripleo repository manager. This will allow newer minor versions of OpenStack packages to be installed in the future. [83]

            .. code-block:: sh

                $ sudo yum install "https://trunk.rdoproject.org/centos7/current/$(curl -k https://trunk.rdoproject.org/centos7/current/ | grep python2-tripleo-repos- | cut -d\" -f8)"
                $ sudo tripleo-repos -b queens current

      -  RHOSP 10 [87]:

         .. code-block:: sh

             $ sudo subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms --enable=rhel-ha-for-rhel-7-server-rpms --enable=rhel-7-server-nfv-rpms --enable=rhel-7-server-rhceph-2-tools-rpms --enable=rhel-7-server-rhceph-2-mon-rpms --enable=rhel-7-server-rhceph-2-osd-rpms --enable=rhel-7-server-openstack-10-rpms

      -  RHOSP 13 [88]:

         .. code-block:: sh

             $ sudo subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms --enable=rhel-ha-for-rhel-7-server-rpms --enable=rhel-7-server-nfv-rpms --enable=rhel-7-server-rhceph-3-tools-rpms --enable=rhel-7-server-rhceph-3-mon-rpms --enable=rhel-7-server-rhceph-3-osd-rpms --enable=rhel-7-server-openstack-13-rpms
   -  It is recommended to create a user named "stack" with sudo
      privileges to manage the Undercloud.

      .. code-block:: sh

          $ sudo useradd stack
          $ sudo passwd stack
          $ echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
          $ sudo chmod 0440 /etc/sudoers.d/stack
          $ su - stack

   -  Install TripleO.

      .. code-block:: sh

          $ sudo yum install python-tripleoclient openstack-tripleo-common openstack-tripleo-heat-templates

   -  Update the operating system and reboot the server.

      .. code-block:: sh

         $ sudo yum update && sudo reboot

   -  Copy the sample configuration to use as a base template. Optionally configure it.

      .. code-block:: sh

          $ cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf

   -  Common Undercloud configuration options. If using an automated power management driver with Ironic, the IP address for the Undercloud's provisioning NIC must use the same network and broadcast domain. [37]

      -  enable\_\* = Enable or disable non-essential OpenStack services on the Undercloud.
      -  **dhcp\_{start\|end}** = The range of IP addresses to temporarily use for provisioning Overcloud nodes. This range is a limiting factor in how many nodes can be provisioned at once.
      -  **local\_interface** = The network interface to use for provisioning new Overcloud nodes. This will be configured as an Open vSwitch bridge. Default: eth1.
      -  **local\_ip** = The local IP address of the Undercloud node to be used for using DHCP for providing IP addresses for Overcloud nodes during PXE booting. This should not be a public IP address.
      -  **inspection\_iprange** = The IP range to use for Ironic's introspection of the Overcloud nodes. This range needs to unique from the DHCP start/end range.
      -  local\_mtu = The MTU size to use for the local interface.
      -  **cidr** (**network_cidr** in Newton) = The CIDR range of IP addresses to use for the Overcloud nodes.
      -  masquerade\_network = The network CIDR that will be used for masquerading external network connections.
      -  **gateway** (**network\_gateway** in Newton) = The default gateway to use for external connectivity to the Internet during provisioning. Use the "local\_ip" when masquerading is used.
      -  undercloud\_admin\_vip = The IP address to listen on for admin API endpoints.
      -  undercloud\_hostname = The fully qualified hostname to use for the Undercloud.
      -  undercloud\_public\_vip = The IP address to listen on for public API endpoints.
      -  enabled_hardware_types (**enabled\_drivers** in Newton) = The Ironic power management drivers to enable. For virtual lab environments, append "manual-management" (Queens) or "fake_pxe" (Newton) to this list.

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

**Image Preperation**

-  Download the prebuilt Overcloud image files from https://images.rdoproject.org/queens/delorean/current-tripleo-rdo/.

   -  <= Queens

      .. code-block:: sh

        $ mkdir images
        $ cd images
        $ curl -O https://images.rdoproject.org/queens/delorean/current-tripleo-rdo/ironic-python-agent.tar
        $ curl -O https://images.rdoproject.org/queens/delorean/current-tripleo-rdo/overcloud-full.tar
        $ tar -v -x -f ironic-python-agent.tar
        $ tar -v -x -f overcloud-full.tar

   -  >= Rocky

      .. code-block:: sh

        $ mkdir images
        $ cd images
        $ curl -O https://images.rdoproject.org/rocky/rdo_trunk/current-tripleo-rdo/ironic-python-agent.tar
        $ curl -O https://images.rdoproject.org/rocky/rdo_trunk/current-tripleo-rdo/overcloud-full.tar
        $ tar -v -x -f ironic-python-agent.tar
        $ tar -v -x -f overcloud-full.tar

-  These files are extracted from the tar archives:

   -  ironic-python-agent.initramfs
   -  ironic-python-agent.kernel
   -  overcloud-full.initrd
   -  overcloud-full.qcow2
   -  overcloud-full.vmlinuz

-  Upload those images.

   .. code-block:: sh

       $ openstack overcloud image upload --image-path /home/stack/images/

-  For using containers, the RDO images from Docker Hub are configured by default. Enable container caching on the Undercloud by generating this template. This will increase the Overcluod deployment time since container images will only have to be pulled from Docker Hub once. [102]

   .. code-block:: sh

      $ openstack tripleo container image prepare default --output-env-file ~/templates/containers-prepare-parameter.yaml

**Introspection**

-  Create a "instackenv.json" file that describes the physical infrastructure of the Overcloud. [37] By default Ironic manages rebooting machines using the IPMI "pxe_ipmitool" driver. [75] Below are the common values to use that define how to handle power management (PM) for the Overcloud nodes via Ironic.

   -  All

      -  name = The name of the node.
      -  pm_type = The power management driver type to use. Common drivers include "pxe_ipmitool" and "fake_pxe".
      -  capabilities = Set custom capabilities. For example, the profile and boot options can be defined here: ``"profile:compute,boot_option:local"``.

   -  IPMI

      -  pm_user = The PM user to use.
      -  pm_password = The PM password to use.
      -  pm_addr = The PM IP address to use.

   -  Fake PXE

      -  arch = The processor architecture. The standard is "x86_64".
      -  cpu = The number of processor cores.
      -  mac = A list of MAC addresses that should be managed by Ironic.
      -  memory = The amount of RAM, in MiB.
      -  disk = The amount of disk space, in GiB. Set this to be 1 GiB less than the actual reported storage size. That will prevent partitioning issues during the Overcloud deployment.

   -  Example instackenv (JSON):

      .. code-block:: json

          {
              "nodes": [
                  {
                      "name": "control00",
                      "pm_type": "fake_pxe",
                      "arch": "x86_64",
                      "cpu": "12",
                      "memory": "32768",
                      "disk": "256",
                      "mac": [
                          "AA:BB:CC:DD:EE:FF"
                      ],
                      "capabilities": "profile:control,boot_option:local"
                  },
                  {
                      "name": "compute00",
                      "pm_type": "pxe_ipmitool",
                      "pm_user": "IPMIUSER",
                      "pm_password": "password123",
                      "pm_addr": "10.10.10.11",
                      "capabilities": "profile:compute,boot_option:local"
                  }
              ]
          }

   -  Example instackenv (YAML):

      .. code-block:: yaml

         ---
         nodes:
           - name: controller00
             pm_type: fake_pxe
             arch: x86_64
             cpu: 12
             memory: 32768
             disk: 256
             mac:
               - AA:BB:CC:DD:EE:FF
             capabilities: "profile:control,boot_option:local"
           - name: compute00
             pm_type: pxe_ipmitool
             pm_user: IPMIUSER
             pm_password: pasword123
             pm_addr: 10.10.10.11
             capabilities: "profile:compute,boot_option:local"

   -  Virtual lab environment:

      -  The "pxe_fake" driver can be used. This will require the end-user to manually reboot the managed nodes.

      -  Virtual machines deployed using Vagrant need to have vagrant-libvirt's default eth0 management interface removed. The first interface on the machine (normally eth0) is used for introspection and provisioning and cannot be that management interface. [103]

         .. code-block:: sh

             $ sudo virsh detach-interface ${VM_NAME} network --persistent --mac $(sudo virsh dumpxml ${VM_NAME} | grep -B4 vagrant-libvirt | grep mac | cut -d "'" -f2)

-  Import the nodes.

   -  Newton:

      .. code-block:: sh

          $ openstack baremetal import --json instackenv.json

   -  Queens [85]:

      .. code-block:: sh

          $ openstack overcloud node import instackenv.json
          Started Mistral Workflow tripleo.baremetal.v1.register_or_update. Execution ID: cf2ce144-a22a-4838-9a68-e7c3c5cf0dad
          Waiting for messages on queue 'tripleo' with no timeout.
          2 node(s) successfully moved to the "manageable" state.
          Successfully registered node UUID c1456e44-5245-4a4d-b551-3c6d6217dac4
          Successfully registered node UUID 9a277de3-02be-4022-ad26-ec4e66d97bd1
          $ openstack baremetal node list
          +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
          | UUID                                 | Name      | Instance UUID | Power State | Provisioning State | Maintenance |
          +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
          | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | None          | None        | manageable         | False       |
          | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | None          | None        | manageable         | False       |
          +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+

-  Start the introspection. In another terminal, verify that the "Power State" is "power on" and then manually start the virtual machines. The introspection will take a long time to complete.

         -  Newton:

            .. code-block:: sh

                $ openstack baremetal introspection bulk start

         -  Queens [85]:

            .. code-block:: sh

                $ openstack overcloud node introspect --all-manageable --provide

            .. code-block:: sh

               $ openstack baremetal node list
               +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
               | UUID                                 | Name      | Instance UUID | Power State | Provisioning State | Maintenance |
               +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
               | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | None          | power on    | manageable         | False       |
               | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | None          | power on    | manageable         | False       |
               +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+

      -  When the "Power State" becomes "power off" and the "Provisioning State" becomes "available" then manually shutdown the virtual machines.

         .. code-block:: sh

            $ openstack baremetal node list
            +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
            | UUID                                 | Name      | Instance UUID | Power State | Provisioning State | Maintenance |
            +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
            | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | None          | power off   | available          | False       |
            | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | None          | power off   | available          | False       |
            +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+

   -  Physical environment:

      -  Import the configuration that defines the Overcloud infrastructure and have it introspected so it can be deployed.

         -  Queens [85]:

            .. code-block:: sh

                $ openstack overcloud node import --introspect --provide instackenv.json

         -  Alternatively, automatically discover the available servers by
            scanning IPMI devices via a CIDR range and using different IPMI
            logins.

            .. code-block:: sh

                $ openstack overcloud node discover --range <CIDR> --credentials <USER1>:<PASSWORD1> --credentials <USER2>:<PASSWORD2>

-  Configure the necessary flavors (mandatory for getting accurate results when using the fake_pxe Ironic driver). [86] Commonly custom "control" and "compute" flavors will need to be created.

   .. code-block:: sh

       $ openstack flavor create --id auto --vcpus <CPU_COUNT> --ram <RAM_IN_MB> --disk <DISK_IN_GB_MINUS_ONE> --swap <SWAP_IN_MB> --property "capabilities:profile"="<FLAVOR_NAME>" <FLAVOR_NAME>

-  Configure the kernel and initramfs that the baremetal nodes should boot from.

   -  Newton:

      .. code-block:: sh

          $ openstack baremetal configure boot

   -  Queens (optional) [85]:

      .. code-block:: sh

          $ openstack baremetal node list
          $ openstack overcloud node configure <NODE_ID>

-  If the profile and/or boot option were not specified in the instackenv.json file then configure it now. Verify that the profiles have been applied. Valid default flavors are ``block-strage``, ``ceph-stroage``, ``compute``, ``control``, and ``swift-storage``.

   .. code-block:: sh

       $ openstack baremetal node set --property capabilities='profile:control,boot_option:local' c1456e44-5245-4a4d-b551-3c6d6217dac4
       $ openstack baremetal node set --property capabilities='profile:compute,boot_option:local' 9a277de3-02be-4022-ad26-ec4e66d97bd1
       $ openstack overcloud profiles list --all
       +--------------------------------------+-----------+-----------------+-----------------+-------------------+-------+
       | Node UUID                            | Node Name | Provision State | Current Profile | Possible Profiles | Error |
       +--------------------------------------+-----------+-----------------+-----------------+-------------------+-------+
       | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | available       | control         |                   |       |
       | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | available       | compute         |                   |       |
       +--------------------------------------+-----------+-----------------+-----------------+-------------------+-------

-  Set a DNS nameserver.

   .. code-block:: sh

      $ openstack subnet list
      $ openstack subnet set --dns-nameserver 8.8.8.8 <SUBNET_ID>

**Deployment**

-  Configure the networking Heat templates that define the physical and virtual network interface settings.

   -  Newton:

      -  Pick a network configuration from ``/usr/share/openstack-tripleo-heat-templates/environments/`` and modify it to fit the deployment environment. Templates include:

         -  bond-with-vlans
         -  multiple-nics
         -  single-nic-linux-bridge-vlans
         -  single-nic-vlans

   -  Queens:

      -  Scenario #1 - Default templates:

         .. code-block:: sh

             $ cd /usr/share/openstack-tripleo-heat-templates/
             $ mkdir /home/stack/templates/
             $ /usr/share/openstack-tripleo-heat-templates/tools/process-templates.py -o /home/stack/templates/

      -  Scenario #2 - Variables can be customized via the "roles_data.yaml" and "network_data.yml" files. Example usage can be found `here <https://github.com/redhat-openstack/tripleo-workshop/tree/master/composable-roles-dev>`__.

         .. code-block:: sh

             $ mkdir /home/stack/templates/
             $ cp /usr/share/openstack-tripleo-heat-templates/roles_data.yaml /home/stack/templates/roles_data_custom.yaml
             $ cp /usr/share/openstack-tripleo-heat-templates/network_data.yml /home/stack/templates/network_data_custom.yaml
             $ /usr/share/openstack-tripleo-heat-templates/tools/process-templates.py --roles-data ~/templates/roles_data_custom.yaml --roles-data ~/templates/network_data_custom.yaml

-  In a YAML Heat tepmlate, set the number of controller, compute, Ceph, and/or any other nodes that should be deployed.

   .. code-block:: yaml

      ---
      parameter_defaults:
        OvercloudControllerFlavor: control
        OvercloudComputeFlavor: compute
        OvercloudCephStorageFlavor: ceph
        ControllerCount: <NUMBER_OF_CONTROLLER_NODES>
        ComputeCount: <NUMBER_OF_COMPUTE_NODES>
        CephStorageCount: <NUMBER_OF_CEPH_NODES>

-  Deploy the Overcloud with any custom Heat configurations. [29] Starting with the Pike release, most services are deployed as containers by default. For preventing the use of containers, remove the "docker.yaml" and "docker-ha.yaml" files from ``${TEMPLATES_DIRECTORY}/environments/``. [30] Lab environments should use the low resource usage template: ``-e ~/templates/environments/low-memory-usage.yaml``.

   .. code-block:: sh

       $ openstack help overcloud deploy
       $ openstack overcloud deploy --templates ~/templates -r ~/templates/roles_data_custom.yaml --control-flavor control --compute-flavor compute

   -  Virtual lab environment:

      -  When the "Provisioning State" becomes "wait call-back" then manually start the virtual machines. The relevant Overcloud image will be copied to the local drive(s). At this point, Nova will have already changed the servers to have the "Status" of "BUILD".

         .. code-block:: sh

             $ openstack baremetal node list
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             | UUID                                 | Name      | Instance UUID                        | Power State | Provisioning State | Maintenance |
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | 16a09779-b324-4d83-bc7d-3d24d2f4aa5d | power on    | wait call-back     | False       |
             | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | 5c2d1374-8b20-4af6-b114-df15bbd3d9ca | power on    | wait call-back     | False       |
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             $ openstack server list
             +--------------------------------------+-------------------------+--------+------------------------+----------------+---------+
             | ID                                   | Name                    | Status | Networks               | Image          | Flavor  |
             +--------------------------------------+-------------------------+--------+------------------------+----------------+---------+
             | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | overcloud-novacompute-0 | BUILD  | ctlplane=192.168.24.35 | overcloud-full | compute |
             | c1456e44-5245-4a4d-b551-3c6d6217dac4 | overcloud-controller-0  | BUILD  | ctlplane=192.168.24.34 | overcloud-full | control |
             +--------------------------------------+-------------------------+--------+------------------------+----------------+---------+

      -  The nodes will then be in the "Provisioning State" of "deploying". At this phase the operating system image is copied over, partitions are resized, and SSH keys are configured for access to the ``heat-admin`` user account.

         .. code-block:: sh

            $ openstack baremetal node list
            +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
            | UUID                                 | Name      | Instance UUID                        | Power State | Provisioning State | Maintenance |
            +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
            | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | 16a09779-b324-4d83-bc7d-3d24d2f4aa5d | power on    | deploying          | False       |
            | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | 5c2d1374-8b20-4af6-b114-df15bbd3d9ca | power on    | deploying          | False       |
            +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+

      -  After that is complete, the virtual machines will power off. Ironic will report that the "Power State" is now "power on" and the Provisioning State" is now "active." Manually start the virtual machines now.

         .. code-block:: sh

             $ openstack baremetal node list
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             | UUID                                 | Name      | Instance UUID                        | Power State | Provisioning State | Maintenance |
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | 16a09779-b324-4d83-bc7d-3d24d2f4aa5d | power on    | active             | False       |
             | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | 5c2d1374-8b20-4af6-b114-df15bbd3d9ca | power on    | active             | False       |
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+

-  The rest of the deploy will continue and can take a few hours to complete.

-  Verify that the Overcloud was deployed successfully. If it was not, then troubleshoot any stack resources that failed.

   .. code-block:: sh

       $ openstack stack list
       $ openstack stack failures list <OVERCLOUD_STACK_ID>
       $ openstack stack show <OVERCLOUD_STACK_ID>
       $ openstack stack resource list <OVERCLOUD_STACK_ID>
       $ openstack stack resource show <OVERCLOUD_STACK_ID> <RESOURCE_NAME>

-  Source the Overcloud admin credentials to manage it.

   .. code-block:: sh

       $ source ~/overcloudrc

-  The nodes can be managed via SSH using the "heat-admin" user.

   .. code-block:: sh

      $ openstack server list
      +--------------------------------------+-------------------------+--------+------------------------+----------------+---------+
      | ID                                   | Name                    | Status | Networks               | Image          | Flavor  |
      +--------------------------------------+-------------------------+--------+------------------------+----------------+---------+
      | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | overcloud-novacompute-0 | ACTIVE | ctlplane=192.168.24.35 | overcloud-full | compute |
      | c1456e44-5245-4a4d-b551-3c6d6217dac4 | overcloud-controller-0  | ACTIVE | ctlplane=192.168.24.34 | overcloud-full | control |
      +--------------------------------------+-------------------------+--------+------------------------+----------------+---------+
      $ ssh -l heat-admin 192.168.24.34

[29][84]

-  Passwords for the Overcloud services can be found by running:

   -  TripleO Newton:

      .. code-block:: sh

         $ mistral environment-get overcloud

   -  TripleO Queens:

      .. code-block:: sh

         $ openstack object save overcloud plan-environment.yaml

-  In >= Rocky (or in Queens, if configured), the Ansible files used for the configuration management can be downloaded. Those files can then be imported into an external source such as Ansible Tower or AWX. The ``tripleo-ansible-inventory`` script is used to generate a dynamic inventory file for Ansible that contains the Overcloud hosts. [99]

    .. code-block:: sh

       $ openstack overcloud config download

Operations
''''''''''

Add a Compute Node
&&&&&&&&&&&&&&&&&&

-  From the Undercloud, create a `instackenv.json` file describing the new node. Import the file using Ironic.

.. code-block:: sh

    $ source ~/stackrc
    $ openstack baremetal import --json ~/instackenv.json

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

-  Update the compute node scale using a Heat template.

.. code-block:: yaml

   ---
   parameter_defaults:
     ComputeCount: <NEW_COMPUTE_COUNT>

-  Redeploy the Overcloud while specifying the number of compute nodes that should exist in total after it is complete. The `ComputeCount` parameter in the Heat templates should also be increased to reflect it's new value.

.. code-block:: sh

    $ openstack overcloud deploy --templates ~/templates <DEPLOYMENT_OPTIONS>

[77]

Rebooting the Cloud
&&&&&&&&&&&&&&&&&&&

Servers hosting the cloud services will eventually need to go through a reboot to load up the latest patches for kernels, glibc, and other vital system components. This is the order in which servers should be restarted, one node at a time.

-  Undercloud
-  Controller

   -  Stop clustered services on a controller node before rebooting.

      .. code-block:: sh

         $ sudo pcs cluster stop

   -  Reconnect to the clustered services after the reboot.

      .. code-block:: sh

         $ sudo pcs cluster start

-  Ceph

   -  Disable rebalancing before rebooting.

      .. code-block:: sh

         $ sudo ceph osd set noout
         $ sudo ceph osd set norebalance

   -  Enable rebalancing after all of the nodes are back online.

      .. code-block:: sh

         $ sudo ceph osd unset noout
         $ sudo ceph osd unset norebalance


-  Compute

   -  Disallow new instances from spawning on a specific compute node.

      .. code-block:: sh

         $ openstack compute service list
         $ openstack compute service set <COMPUTE_HOST> nova-compute --disable

   -  Live migrate all instances off of that compute node.

      .. code-block:: sh

         $ nova host-evacuate-live <COMPUTE_HOST>

   -  Verify that all instances have been migrated off before rebooting.

      .. code-block:: sh

         $ openstack server list --host <COMPUTE_HOST> --all-projects

[104]

Configurations
^^^^^^^^^^^^^^

These are configurations specific to Overcloud deployments using TripleO. Custom settings are defined using a YAML Heat template.

.. code-block:: yaml

   ---
   parameter_defaults:
     <KEY>: <VALUE>

Networks
''''''''

There are 6 different types of networks in a standard TripleO deployment:

-  External = The external network that can access the Internet. This is used for the Horizon dashboard, public API endpoints, and floating IP addresses. Default VLAN: 10
-  Internal = Default VLAN: 20.
-  Storage = Default VLAN: 30.
-  StorageMgmt = Default VLAN: 40
-  Tenant = Default VLAN: 50
-  Management = Default VLAN: 60.

The VLANs need to be trunked on the switch. A 7th native VLAN should also be configured on the switch for the provisioning network. [100]

Configure the network CIDRs, IP address ranges to allocation, and VLAN tags.

::

   <NETWORK_TYPE>NetCidr: <CIDR>
   <NETWORK_TYPE>AllocationPools: [{"start": "<START_IP>", "end": "<LAST_IP>"}]
   <NETWORK_TYPE>NetworkVlanID: <VLAN_ID>

Configure these settings to match the IP address that the Undercloud is configured to use for provisioning.

::

   ControlPlaneSubnetCidr: '24'
   ControlPlaneDefaultRoute: <UNDERCLOUD_IP>
   EC2MetadataIp: <UNDERCLOUD_IP>

Configure the Overcloud access to the public Internet. Define the default router for the External network, DNS resolvers, and the NTP servers.

::

   ExternalInterfaceDefaultRoute: <PUBLIC_DEFAULT_GATEWAY_ADDRESS>
   DnsServers: ["8.8.8.8", "8.8.4.4"]
   NtpServer: ["pool.ntp.org"]

Define the allowed network tag/tunnel types that Neutron networks use. The Neutron tunnel type is used for internal tranmissions between the compute and network nodes. By default, the Neutron network bridge will be attached to ``br-int`` if left blank. This will configure a provider network. Otherwise, ``br-ex`` should be specified for self-service networks.

::

   NeutronNetworkType: "vxlan,gre,vlan,flat"
   NeutronTunnelTypes: "vxlan"
   NeutronExternalNetworkBridge: "''"

Configure bonding interface options, if applicable. Below is an example for LACP.

::

   bonding_options: "mode=802.3ad lacp_rate=slow updelay=1000 miimon=100"

[100]

Pacakges
''''''''

By default, TripleO will not install packages. The standard Overcloud image from RDO already has all of the OpenStack packages installed. When using a custom image or not using Ironic for deploying Overcloud nodes, packages can be configured to be installed.

::

   EnablePackageInstall: true

A different repository for Overcloud service containers can be configured (>= Pike).

::

    DockerNamespace: registry.example.tld/rocky
    DockerNamespaceIsRegistry: true
    DockerInsecureRegistryAddress: registry.example.tld
    DockerNamespaceIsInsecureRegistry: true

Configurations
--------------

This section focuses on the configuration files and their settings for each OpenStack service.

TripleO
~~~~~~~

Configuration options for services can be defined using ExtraConfig.

-  ExtraConfig = Apply to all nodes.
-  ComputeExtraConfig
-  ControllerExtraConfig
-  BlockStorageExtraConfig
-  ObjectStorageExtraConfig
-  CephStorageExtraConfig

Puppet manifests define the default variables that are set. These also show what Puppet dictionary variables are used for each configuration. All of the service manifests can be found here: ``/usr/share/openstack-puppet/modules/$OPENSTACK_SERVICE/manifests/``.

.. code-block:: yaml

   ---
   parameter_defaults:
     <EXTRACONFIG_SERVICE>ExtraConfig:
        # The primary manifest handles at least the primary configuraiton file.
        <OPENSTACK_SERVICE>::<MANIFEST>::<PUPPET_DICTIONARY>: <VALUE>
        # Some OpenStack services use more than one configuration file which could be handled
        # by nested manifests.
        <OPENSTACK_SERVICE>::<MANIFEST>::<MANIFEST_SUB_DIRECTORY>::<SUB_MANIFEST>::<PUPPET_DICTIONARY>: <VALUE>

Settings that are not handled by the Puppet modules can be overriden manually. The dictionary name for each configuration file is defined in mainfests/config.pp in the ``<OPENSTACK_SERVICE>::config`` class.

.. code-block:: yaml

   ---
   parameter_defaults:
     <EXTRACONFIG_SERVICE>ExtraConfig:
        <OPENSTACK_SERVICE>::config::<PUPPET_DICTIONARY>:
            # Configure a value in the [DEFAULT] section.
            'DEFAULT/<KEY>':
              value: <VALUE>
        <OPENSTACK_SERVICE>::config::<PUPPET_DICTIONARY>:
            # Configure a value in a different section.
            '<SECTION>/<KEY>':
              value: <VALUE>

[101]

Common
~~~~~~

These are the generic INI configuration options for setting up different OpenStack services.

Database
^^^^^^^^

Different database servers can be used by the API services on the
controller nodes.

-  MariaDB/MySQL. The original ``mysql://`` connector can be used for the "MySQL-Python" library. Starting with Liberty, the newer "PyMySQL" library was added for Python 3 support. [31] RDO first added the required ``python2-PyMySQL`` package in the Pike release. [34][79]

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

Ironic
~~~~~~

Drivers
^^^^^^^

Ironic supports different ways of managing power cycling of managed nodes. The default enabled driver is IPMITool.

OpenStack Newton configuration:

File: /etc/ironic/ironic.conf

.. code-block:: ini

    [DEFAULT]
    enabled_drivers = <DRIVER>

OpenStack Queens configuration:

.. code-block:: ini

    [DEFAULT]
    enabled_hardware_types = <HARDWARE_DRIVER_TYPE>
    enabled_power_interfaces = <POWER_INTERFACE>
    enabled_management_interfaces = <MANAGEMENT_INTERFACE>

TripleO Queens configuration [96]:

.. code-block:: yaml

   parameter_defaults:
     IronicEnabledHardwareTypes:
       - <HARDWARE_DRIVER_TYPE>
     IronicEnabledPowerInterfaces:
       - <POWER_INTERFACE>
     IronicEnabledManagementInterfaces:
       - <MANAGEMENT_INTERFACE>

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

TripleO Queens configuration [97]:

Create the Fernet keys and save them to Swift

.. code-block:: sh

   $ source ~/stackrc
   $ sudo keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
   $ sudo tar -zcf keystone-fernet-keys.tar.gz /etc/keystone/fernet-keys
   $ upload-swift-artifacts -f keystone-fernet-keys.tar.gz --environment ~/templates/deployment-artifacts.yaml

Verify that the object was saved to Swift and that the necessary environment template was generated.

   $ swift list overcloud-artifacts Keystone-fernet-keys.tar.gz
   $ cat ~/templates/deployment-artifacts.yaml

Append the token provider setting to the "parameter_defaults" section in the "deployment-artifacts.yaml" file. Then use this file for the Overcloud deployment.

.. code-block:: yaml

   parameter_defaults:
     controllerExtraConfig:
       keystone::token_provider: "fernet"

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

TripleO configuration [96]:

.. code-block:: yaml

   parameter_defaults:
     NeutronEnableDVR: true

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
-  Review the `release notes <https://releases.openstack.org/>`__ of the OpenStack services that will be
   upgraded. These will contain details of deprecations and new
   configuration changes.
-  Update configuration files. Sample configuration options can be found at
   ``https://docs.openstack.org/<RELEASE>/configuration/``.
-  If not already, consider using an automation tool such as Ansible to
   deploy new service configurations.
-  Remove the old package repository for OpenStack.
-  Add the new package repository for OpenStack.
-  Update all of the packages on the controller node first.
-  Update the database schemas. [92]

.. code-block:: sh

    $ sudo keystone-manage token_flush
    $ su -s /bin/sh -c "keystone-manage db_sync" keystone
    $ su -s /bin/sh -c "glance-manage db_sync" glance
    $ su -s /bin/sh -c "cinder-manage db sync" cinder
    $ su -s /bin/sh -c "heat-manage db_sync" heat
    $ su -s /bin/sh -c "nova-manage db sync" nova
    $ su -s /bin/sh -c "nova-manage api_db sync" nova
    $ ceilometer-dbsync
    $ aodh-dbsync
    $ gnocchi-upgrade
    $ su -s /bin/sh -c "sahara-db-manage upgrade heads" sahara
    $ su -s /bin/sh -c "neutron-db-manage upgrade heads" neutron

-  Restart the services on the controller nodes. ``$ sudo openstack-service restart``
-  View the logs for any problems.

   -  Services on the controller nodes support messages/requests from the current version and the previous version so everything should still continue to work properly.

-  Update the packages and restart the services on the other nodes.

[62]

Command Line Interface Utilities
--------------------------------

The OpenStack command line interface (CLI) resources used to be handled
by separate commands. These have all been modified and are managed by
the universal "openstack" command. The various options and arguments for OpenStack related commands can be found in Root Pages' `Commands - OpenStack <../commands/openstack.html>`__.

For the CLI utilities to work, the environment variables need to be set
for the project and user. This way the commands can automatically
authenticate.

-  Add the credentials to a text file. Use the ".sh" extension to signify it's a shell script. A few default variables are filled in below.
-  Keystone v2.0

   .. code-block:: sh

       # Unset any variables that may already be sourced.
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
       # These values need to be filled in.
       export PROJECT_ID=
       export PROJECT_NAME=
       export OS_USERNAME=
       export OS_PASSWORD=
       export OS_REGION_NAME="RegionOne"
       export OS_AUTH_URL="http://<CONTROLLER>:5000/v2.0"
       export OS_AUTH_VERSION="2.0"
       # For compatibility, some services expect this
       # variable to be used for defining the API version
       # instead.
       export OS_IDENTITY_API_VERSION="${OS_AUTH_VERSION}"

-  Keystone v3

   .. code-block:: sh

       # Unset any variables that may already be sourced.
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
       # These values need to be filled in.
       export OS_PROJECT_ID=
       export OS_PROJECT_NAME=
       export OS_PROJECT_DOMAIN_NAME="default"
       export OS_USERID=
       export OS_USERNAME=
       export OS_PASSWORD=
       export OS_USER_DOMAIN_NAME="default"
       export OS_REGION_NAME="RegionOne"
       export OS_AUTH_URL="http://<CONTROLLER>:5000/v3"
       export OS_AUTH_VERSION="3"
       # For compatibility, some services expect this
       # variable to be used for defining the API version
       # instead.
       export OS_IDENTITY_API_VERSION="${OS_AUTH_VERSION}"

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
compatibility reasons. Since the Newton release, the release name can be used instead of a date for the version.

.. code-block:: yaml

    ---
    heat_template_version: 2017-02-24

    resources:

Valid Heat template versions include [65]:

-  ``2018-08-31`` or ``rocky``
-  ``2018-03-02`` or ``queens``
-  ``2017-09-01`` or ``pike``
-  ``2017-02-24`` or ``ocata``
-  ``2016-10-14`` or ``newton``
-  ``2016-04-08`` (Mitaka)
-  ``2015-10-15`` (Liberty)
-  ``2015-04-30`` (Kilo)
-  ``2014-10-16`` (Juno)
-  ``2013-05-23`` (Icehouse)

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

Manual
~~~~~~

Manual testing of the core OpenStack services can be done by deploying an instance using a CirrOS image from `here <https://download.cirros-cloud.net/>`__. It is a minimalist fork of Ubuntu with a small set of packages installed. It was designed to run with the ``tiny`` instance flavor. The default password for < 0.4 is ``cubswin:)`` and for >= 0.4 it is ``gocubsgo``. [105]

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

Install Rally 0.12 on RHEL using a Python virtual environment.

RHEL:

.. code-block:: sh

    $ sudo yum install gcc git gmp-devel libffi-devel libxml2-devel libxslt-devel openssl-devel postgresql-devel python-devel python-pip redhat-lsb-core redhat-rpm-config wget
    $ virtualenv ~/rally-venv
    $ . ~/rally-venv/bin/activate
    (rally-venv)$ pip install -U pip setuptools
    (rally-venv)$ pip install rally==0.12.*

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

Rally requires a deployment, that defines the OpenStack credentials to test with, to be registered. It is recommended to use an account with the "admin" role so that all features of the cloud can be tested and benchmarked. The "admin" user is no longer required in Rally version >= 0.10.0. [73]

View registered deployments:

.. code-block:: sh

    (rally-venv)$ rally deployment list
    (rally-venv)$ rally deployment show <DEPLOYMENT_NAME>

Switch to an existing registered deployment:

.. code-block:: sh

    (rally-venv)$ rally deployment use <DEPLOYMENT_NAME>

The current OpenStack credentials for the deployment that is active are saved to ``~/.rally/openrc``.

A deployment and it's resources and be removing by running:

.. code-block:: sh

   (rally-venv)$ rally deployment destroy <DEPLOYMENT_NAME>

Alternatively, keep the configuraiton and only clean-up the OpenStack resources and existing test data.

.. code-block:: sh

   (rally-venv)$ rally deployment recreate <DEPLOYMENT_NAME>

`1.` Automatic Registration

The fastest way to create this configuration is by referencing the OpenStack credential's shell environment variables.

.. code-block:: sh

    (rally-venv)$ . <OPENSTACK_RC_FILE>
    (rally-venv)$ rally deployment create --fromenv --name=existing

`2.` Manual Registration

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

Additional variables can be passed via the command line.

.. code-block:: sh

    (rally-venv)$ rally task start --task-args "<JSON_ARGS>" <SCENARIO_FILE>.<JSON_OR_YAML>

.. code-block:: sh

    (rally-venv)$ rally task start --task-args-file <ARGS_FILE>.<JSON_OR_YAML> <SCENARIO_FILE>.<JSON_OR_YAML>

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

OpenStack can be tuned to use less processing power and run faster.

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

`History <https://github.com/ekultails/rootpages/commits/master/src/openstack.rst>`__
-------------------------------------------------------------------------------------

Bibliography
------------

1. "OpenStack Releases." OpenStack Releases. September 26, 2018. Accessed September 26, 2018. https://releases.openstack.org/
2. "New OpenStack Ocata stabilizes popular open-source cloud." February 22, 2017. Accessed April 10, 2017. http://www.zdnet.com/article/new-openstack-ocata-stabilizes-popular-open-source-cloud/
3. "Ocata [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/ocata/index.html
4. "Pike [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/pike/index.html
5. "Queens [Goals]." OpenStack Documentation. September 26, 2017. Accessed October 4, 2017. https://governance.openstack.org/tc/goals/pike/index.html
6. "Red Hat OpenStack Platform Life Cycle." Red Hat Support. Accessed July 12, 2018. https://access.redhat.com/support/policy/updates/openstack/platform
7. "Frequently Asked Questions." RDO Project. Accessed December 21, 2017. https://www.rdoproject.org/rdo/faq/
8. "How can I determine which version of Red Hat Enterprise Linux - Openstack Platform (RHEL-OSP) I am using?" Red Hat Articles. May 20, 2016. Accessed December 19, 2017. https://access.redhat.com/articles/1250803
9. "Director Installation and Usage." Red Hat OpenStack Platform 13 Documentation. September 26, 2018. Accessed September 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/pdf/director_installation_and_usage/Red_Hat_OpenStack_Platform-13-Director_Installation_and_Usage-en-US.pdf
10. "Project Navigator." OpenStack. Accessed March 15, 2018. https://www.openstack.org/software/project-navigator/
11. "Packstack: Create a proof of concept cloud." RDO Project. Accessed March 19, 2018. https://www.rdoproject.org/install/packstack/
12. "Neutron with existing external network. RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/networking/neutron-with-existing-external-network/
13. "Error while installing openstack 'newton' using rdo packstack." Ask OpenStack. October 25, 2016. Accessed September 28, 2017. https://ask.openstack.org/en/question/97645/error-while-installing-openstack-newton-using-rdo-packstack/
14. "Hosts role should set SELinux into permissive mode." openstack-ansible Launchpad Bugs. January 27, 2017. Accessed July 25, 2018. https://bugs.launchpad.net/openstack-ansible/+bug/1657517
15. "Quickstart: AIO." OpenStack-Ansible Documentation. July 13, 2018. Accessed July 19, 2018. https://docs.openstack.org/openstack-ansible/queens/user/aio/quickstart.html
16. "OpenStack-Ansible Deployment Guide." OpenStack Documentation. July 24, 2018. Accessed July 25, 2018. https://docs.openstack.org/project-deploy-guide/openstack-ansible/queens/
17. "Nova role for OpenStack-Ansible." OpenStack Documentation. March 15, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible-os_nova/queens/
18. "openstack ansible ceph." OpenStack FAQ. April 9, 2017. Accessed April 9, 2017. https://www.openstackfaq.com/openstack-ansible-ceph/
19. "Configuring the Ceph client (optional)." OpenStack Documentation. April 5, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-ceph_client/configure-ceph.html
20. "[OpenStack-Ansible] Operations Guide." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible/queens/admin/index.html
21. "Developer Documentation." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible/latest/contributor/index.html
22. "Operations Guide." OpenStack-Ansible Documentation. July 13, 2018. Accessed July 19, 2018. https://docs.openstack.org/openstack-ansible/queens/admin/index.html/
23. "TripleO quickstart." RDO Project. Accessed March 26, 2018. https://www.rdoproject.org/tripleo/
24. "[TripleO] Minimum System Requirements." TripleO Documentation. September 7, 2016. Accessed March 26, 2018. https://images.rdoproject.org/docs/baremetal/requirements.html
25. [RDO] Recommended hardware." RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/hardware/recommended/
26. "[TripleO] Virtual Environment." TripleO Documentation. Accessed September 28, 2017. http://tripleo-docs.readthedocs.io/en/latest/environments/virtual.html
27. "Getting started with TripleO-Quickstart." OpenStack Documentation. Accessed December 20, 2017. https://docs.openstack.org/tripleo-quickstart/latest/getting-started.html
28. "TripleO Documentation." OpenStack Documentation. Accessed September 12, 2017. https://docs.openstack.org/tripleo-docs/latest/
29. "Basic Deployment (CLI)." OpenStack Documentation. Accessed November 9, 2017. https://docs.openstack.org/tripleo-docs/latest/install/basic_deployment/basic_deployment_cli.html
30. "Bug 1466744 - Include docker.yaml and docker-ha.yaml environment files by default." Red Hat Bugzilla. December 13, 2017. Accessed January 12, 2018. https://bugzilla.redhat.com/show_bug.cgi?id=1466744
31. "DevStack switching from MySQL-python to PyMySQL." OpenStack nimeyo. June 9, 2015. Accessed October 15, 2016. https://openstack.nimeyo.com/48230/openstack-all-devstack-switching-from-mysql-python-pymysql
32. "Using PostgreSQL with OpenStack." FREE AND OPEN SOURCE SOFTWARE KNOWLEDGE BASE. June 06, 2014. Accessed October 15, 2016. https://fosskb.in/2014/06/06/using-postgresql-with-openstack/
33. "[Ceilometer] Installation Guide." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/ceilometer/queens/install/
34. "Liberty install guide RHEL, keystone DB population unsuccessful: Module pymysql not found." OpenStack Manuals Bugs. March 24, 2017. Accessed April 3, 2017. https://bugs.launchpad.net/openstack-manuals/+bug/1501991
35. "Message queue." OpenStack Documentation. March 18, 2018. Accessed March 19, 2018. https://docs.openstack.org/install-guide/environment-messaging.html
36. "[oslo.messaging] Configurations." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/oslo.messaging/queens/configuration/
37. "Baremetal Environment." TripleO OpenStack Documentation. January 19, 2019. Accessed January 22, 2019. https://docs.openstack.org/tripleo-docs/latest/install/environments/baremetal.html
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
65. "Heat Orchestration Template (HOT) specification." OpenStack Documentation. October 4, 2018. Accessed October 5, 2018. https://docs.openstack.org/heat/latest/template_guide/hot_spec.html
66. "Heat Orchestration Template (HOT) specification." OpenStack Developer Documentation. October 21, 2016. Accessed October 22, 2016. http://docs.openstack.org/developer/heat/template_guide/hot_spec.html
67. "ggiamarchi/vagrant-openstack-provider." GitHub. January 30, 2017. Accessed April 3, 2017. https://github.com/ggiamarchi/vagrant-openstack-provider
68. "Tempest Configuration Guide." Sep 14th, 2016. http://docs.openstack.org/developer/tempest/configuration.html
69. "Stable branches." OpenStack Documentation. September 14, 2018. Accessed September 26, 2018. https://docs.openstack.org/project-team-guide/stable-branches.html
70. "[Rally] Installation and upgrades." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/install_and_upgrade/index.html
71. "[Rally] Quick start." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/quick_start/index.html
72. "Step 3. Benchmarking OpenStack with existing users." OpenStack Documentation. July 3, 2017. Accessed January 25, 2018. https://docs.openstack.org/developer/rally/quick_start/tutorial/step_3_benchmarking_with_existing_users.html
73. "Allow deployment without admin creds." OpenStack Gerrit Code Review. June 3, 2017. Accessed January 25, 2018. https://review.openstack.org/#/c/465495/
74. "Main concepts of Rally." OpenStack Documentation. July 3, 2017. Accessed January 26, 2018. https://docs.openstack.org/developer/rally/miscellaneous/concepts.html
75. "[Ironic] Enabling drivers." OpenStack Documentation. March 15, 2018. Accessed March 15, 2018. https://docs.openstack.org/ironic/queens/admin/drivers.html
76. "VirtualBMC." TripleO Documentation. Accessed January 29, 2018.
77. "CHAPTER 8. SCALING THE OVERCLOUD." Red Hat Documentation. Accessed January 30, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/10/html/director_installation_and_usage/sect-scaling_the_overcloud
78. "Verification reports." Rally Documentation. Accessed March 13, 2018. http://docs.xrally.xyz/projects/openstack/en/latest/verification/reports.html
79. "OpenStack Pike Repository." CentOS Mirror. Accessed March 15, 2018. http://mirror.centos.org/centos-7/7/cloud/x86_64/openstack-pike/
80. "External Ceph." OpenStack Documentation. March 15, 2018. Accessed March 19, 2018. https://docs.openstack.org/kolla-ansible/queens/reference/external-ceph-guide.html
81. "Containers based Undercloud Deployment." OpenStack Documentation. Accessed September 26, 2018. https://docs.openstack.org/tripleo-docs/latest/install/containers_deployment/undercloud.html
82. "[TripleO Quickstart] Networking." TripleO Documentation. September 7, 2016. Accessed April 9, 2018. https://images.rdoproject.org/docs/baremetal/networking.html
83. "Repository Enablement." OpenStack TripleO Documentation. May 5, 2018. Accessed May 7, 2018. https://docs.openstack.org/tripleo-docs/latest/install/basic_deployment/repositories.html
84. "TripleO: Using the fake_pxe driver with Ironic." Leif Madsen Blog. November 11, 2016. Accessed June 13, 2018. http://blog.leifmadsen.com/blog/2016/11/11/tripleo-using-the-fake_pxe-driver-with-ironic/
85. "Bug 1535214 - baremetal commands that were deprecated in Ocata have been removed in Queens." Red Hat Bugzilla. Accessed June 13, 2018. https://bugzilla.redhat.com/show_bug.cgi?id=1535214
86. "OpenStack lab on your laptop with TripleO and director." Tricky Cloud. November 25, 2015. Accessed June 13, 2018. https://trickycloud.wordpress.com/2015/11/15/openstack-lab-on-your-laptop-with-tripleo-and-director/
87. "DIRECTOR INSTALLATION AND USAGE." Red Hat OpenStack Platform 10 Support Access. Accessed July 18, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/10/html/director_installation_and_usage/
88. "DIRECTOR INSTALLATION AND USAGE." Red Hat OpenStack Platform 13 Support Access. Accessed July 18, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/
89. "Deploying and customizing OpenStack Mitaka with openstack-ansible." cunninghamshane. August 19, 2016. Accessed July 25, 2018. https://cunninghamshane.com/deploying-and-customizing-openstack-mitaka-with-openstack-ansible/
90. "Open vSwitch: Provider Networks." Neutron OpenStack Documentation. July 24, 2018. Accessed July 25, 2018. https://docs.openstack.org/neutron/queens/admin/deploy-ovs-provider.html
91. "Deploying a Home Lab using OpenStack-Ansible." Lance Bragstad Random Bits. August 2, 2018. Accessed August 9, 2018. https://www.lbragstad.com/blog/using-openstack-ansible-for-home-lab
92. "Upgrading OpenStack Services Simultaneously." RDO Project. Accessed August 15, 2018. https://www.rdoproject.org/install/upgrading-rdo-1/#upgrading-compute-all-at-once
93. "Rocky [Goals]." OpenStack Documentation. September 21, 2018. Accessed September 26, 2018. https://governance.openstack.org/tc/goals/pike/index.html
94. "Red Hat OpenStack Platform 13 Release Notes." Red Hat OpenStack Platform 13 Documentation. September 20, 2018. Accessed September 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/pdf/release_notes/Red_Hat_OpenStack_Platform-13-Release_Notes-en-US.pdf
95. "Stein [Goals]." OpenStack Documentation. September 21, 2018. Accessed September 26, 2018. https://governance.openstack.org/tc/goals/stein/index.html
96. "Feature Configuraiton." TripleO Documentation. September 21, 2018. Accessed September 27, 2018. https://docs.openstack.org/tripleo-docs/latest/install/advanced_deployment/features.html
97. "Enabling Keystone’s Fernet Tokens in Red Hat OpenStack Platform." Sweeping Information. December 12, 2017. Accessed September 27, 2018. https://hk.saowen.com/a/d108272fc7f3a3edaaa5d48200444b7ec08af46e5d8898311ad68286da265538
98. "Use an external Ceph cluster with the Overcloud." TripleO Documentation. September 29, 2018. Accessed September 30, 2018. https://docs.openstack.org/tripleo-docs/latest/install/advanced_deployment/ceph_external.html
99. "TRIPLEO AND ANSIBLE: CONFIG-DOWNLOAD WITH ANSIBLE TOWER (PART 3)." Slagle's Blog. June 1, 2018. Accessed October 3, 2018. https://blogslagle.wordpress.com/2018/06/01/tripleo-and-ansible-config-download-with-ansible-tower-part-3/
100. "Configuring Network Isolation." TripleO Documentation. October 17, 2018. Accessed October 17, 2018. https://docs.openstack.org/tripleo-docs/latest/install/advanced_deployment/network_isolation.html
101. "Modifying default node configuration." TripleO Documentation. October 17, 2018. Accessed October 18, 2018. https://docs.openstack.org/tripleo-docs/latest/install/advanced_deployment/node_config.html
102. "Containers based Overcloud Deployment." TripleO Documentation. December 4, 2018. Accessed December 14, 2018. https://docs.openstack.org/tripleo-docs/latest/install/containers_deployment/overcloud.html
103. "homeski/vagrant-openstack." GitHub. December 11, 2017. Accessed January 22, 2019. https://github.com/homeski/vagrant-openstack/tree/master/osp10
104. CHAPTER 12. REBOOTING NODES." Red Hat OpenStack Platform 13 Documentation. Accessed January 28, 2019. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/sect-rebooting_the_overcloud
105. "Get images." OpenStack Documentation. January 25, 2019. Accessed January 28, 2019. https://docs.openstack.org/image-guide/obtain-images.html
