OpenStack
=========

.. contents:: Table of Contents

Introduction
------------

This guide is aimed to help Cloud Administrators through deploying, managing, and upgrading OpenStack.

Releases
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
-  End-of-life (eol) = The last version of that OpenStack release to be archived.

[42]

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
       -  Remove deprecated mox tests to further push towards full Python 3 support. [53]

    -  `New Features <https://superuser.openstack.org/articles/what-you-need-to-know-about-the-openstack-rocky-release/>`__
    -  `Release Highlights <https://releases.openstack.org/rocky/highlights.html>`__

19. Stein

    -  Release: 2019-04-10
    -  EOL: TBD [1]
    -  Goals:

       -  Use Python 3 by default. Python 2.7 will only be tested using unit tests.
       -  Pre-upgrade checks. Verify if an upgrade will be successful. Also provide useful information to the end-user on how to overcome known issues. [54]

    -  `New Features <https://www.openstack.org/news/view/421/openstack-stein-enhances-bare-metal-and-network-management-while-launching-kubernetes-clusters-faster-than-ever>`__
    -  `Release Highlights <https://releases.openstack.org/stein/highlights.html>`__

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

[6]

Configurations
--------------

This section focuses on the configuration files and their settings for each OpenStack service.

Common
~~~~~~

These are the generic INI configuration options for setting up different OpenStack services.

Database
^^^^^^^^

Different database servers can be used by the API services on the
controller nodes.

-  MariaDB/MySQL. The original ``mysql://`` connector can be used for the "MySQL-Python" library. Starting with Liberty, the newer "PyMySQL" library was added for Python 3 support. [7] RDO first added the required ``python2-PyMySQL`` package in the Pike release. [10][49]

   .. code-block:: ini

       [database]
       connection = mysql+pymysql://<USER>:<PASSWORD>@<MYSQL_HOST>:<MYSQL_PORT>/<DATABASE>

-  PostgreSQL. Requires the "psycopg2" Python library. [8]

   .. code-block:: ini

       [database]
       connection = postgresql://<USER>:<PASSWORD>@<POSTGRESQL_HOST>:<POSTGRESQL_PORT>/<DATABASE>

-  SQLite.

   .. code-block:: ini

       [database]
       connection = sqlite:///<DATABASE>.sqlite

-  MongoDB is generally only used for Ceilometer when it is not using
   the Gnocchi back-end. [9]

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

[11][12]

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

TripleO Queens configuration [55]:

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

In Mitaka, the Keystone v2.0 API has been deprecated. It will be removed entirely from OpenStack in the ``T`` release. [13] It is possible to run both v2.0 and v3 at the same time but it's desirable to move towards the v3 standard. If both have to be enabled, services should be configured to use v2.0 or else problems can occur with v3's domain scoping. For disabling v2.0 entirely, Keystone's API paste configuration needs to have these lines removed (or commented out) and then the web server should be restarted.

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

[14]

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

[15]

TripleO Queens configuration [56]:

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

PKI tokens have been removed since the Ocata release. [16]

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

-  Do not inject passwords, SSH keys, or partitions via Nova. This is recommended for Ceph storage back-ends. [20] This should be handled by the Nova's metadata service that will use cloud-init instead of Nova itself. This will either be "openstack-nova-api" or "openstack-nova-metadata-api" depending on the configuration.

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

[17]

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

[18]

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

[19]

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

[20]

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

[21]

Neutron
~~~~~~~

Network Types
^^^^^^^^^^^^^

In OpenStack, there are two common scenarios for networks: ``provider`` and ``self-service``.

Provider:

-  Simpler
-  Instances have direct access to a bridge device.
-  Faster
-  Best network for bare-metal machines.

Self-service:

-  Complex
-  Instances network traffic is isolated and tunneled.
-  More available virtual networks
-  Required for Firewall-as-a-Service (FWaaS) Load-Balancing-as-a-Service (LBaaS) to work.

[22]

For software-defined networking, the recommended services to use for Neutron's Modular Layer 2 (ML2) plugin are Open vSwitch (OVS) or Open Virtual Networking (OVN). OVS is mature and tested. OVN is an extension of OVS that uses a new tunneling protocol named Geneve that is faster, more efficient, and allows for more tunnels than older protocols such as VXLAN. For compatibility purposes, it works with VXLAN but those tunnels lose the benefits that Geneve offers. It also provides more features such as built-in services for handling DHCP, NAT, load-balancing, and more. [51]

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

[23]

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

[24]

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

[25]

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

[26]

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

[27]

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

[28]

Distributed Virtual Routing
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Distributed virtual routing (DVR) is a concept that involves deploying
routers to both the compute and network nodes to spread out resource
usage. All layer 2 traffic will be equally spread out among the servers.
Public floating IPs will still need to go through the SNAT process via
the routers on the controller or network nodes. This is only supported when the Open
vSwitch agent is used. [29]

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

[30]

TripleO configuration [55]:

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

[29]

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
usernames should match the client users that were just created. [31]

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
system's package manager. [31]

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

[31]

Encryption
^^^^^^^^^^

Cinder volumes support the Linux LUKS encryption. The only requirement
is that the compute nodes have the "cryptsetup" package installed. [32]

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

[33][50]

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

[34][35]

cloud-init
----------

Every instance that is managed by Nova will be configured if cloud-init is installed on the operating system image. Common operations include setting up users and groups, installing packages, configuring SSH keys, etc. The full list of modules that can be used are documented `here <https://cloudinit.readthedocs.io/en/latest/topics/modules.html>`__. Example configurations can be found `here <https://cloudinit.readthedocs.io/en/latest/topics/examples.html>`__. cloud-init will only run once. The service can be forced to run again by deleting the ``/var/lib/cloud/instance/`` directory. All of the files and directories wihtin ``/var/lib/cloud/`` are documented `here <https://cloudinit.readthedocs.io/en/latest/topics/dir_layout.html>`__. [62]

Upgrades
--------

Upgrading a production OpenStack environment requires a lot of planning. It is recommended to test an upgrade in a pre-production environment before rolling it out to production. Automation tools generally have their own guides but most of these guidelines should still apply to manual deployment upgrades. The entire steps include to:

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
-  Update the database schemas. [52]

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

[36]

As of the Newton release, services are compatible with a ``N - 1`` release. This means that, for example, services that are partially upgraded to Newton will continue to work with Mitaka. [63]

Command Line Interface Utilities
--------------------------------

The OpenStack command line interface (CLI) resources used to be handled
by separate commands. These have all been modified and are managed by
the universal "openstack" command. The various options and arguments for OpenStack related commands can be found in Root Pages' `Commands - OpenStack <../commands/openstack.html>`__.

Install all of the OpenStack CLI tools using pip.

.. code-block:: sh

   $ pip install --user python-openstackclient

Alternatively, only install the client utilities for the select services that are installed onto the OpenStack cloud. [57]

.. code-block:: sh

   $ pip install --user python-<SERVICE>client

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

[37]

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
has been created). [38]

All Heat templates must began with defining the version of OpenStack is
was designed for (using the release date as the version) and enclose all
resources in a "resources" dictionary. The version indicates that all
features up until that specific release are used. This is for backwards
compatibility reasons. Since the Newton release, the release name can be used instead of a date for the version.

.. code-block:: yaml

    ---
    heat_template_version: 2017-02-24

    resources:

Valid Heat template versions include [39]:

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

Official examples of Heat templates can be found `here <https://opendev.org/openstack/heat-templates/src/branch/master/hot>`__. Below is a demonstration on how to create a virtual machine with public networking.

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

[39]

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

[40]

Mistral Workflows
-----------------

List all of the available actions that Mistral can preform. [60]

.. code-block:: sh

   $ mistral action-list

The only supported Mistral template version is ``2.0``. All templates should start with this block:

.. code-block:: yaml

   ---
   version: 2.0

A workflow can accept input and output variables. The input is used for the tasks and once complete output it is saved in the Mistral database.

.. code-block:: yaml

   <WORKFLOW_NAME>:
     description: <DESCRIPTION>
     input:
       - <INPUT1>
       - <INPUT2>
     output:
       - <KEY>: <VALUE>
     tasks:
       <TASK1_NAME>:
         action: <MISTRAL_ACTION1>
       <TASK2_NAME>:
         action: <MISTRAL_ACTION2>

Common actions:

-  std.echo = Used for testing by displaying the output of variables.

   -  **output** = The output to display.

-  std.fail = Force the workflow to fail.
-  std.http = Handle HTTP requests.

   -  headers = Custom headers to add to the request.
   -  method = The HTTP method to use.
   -  **url** = The URL to interact with.
   -  verify = If the certificate should be verified.

-  std.ssh = Run commands via SSH.

   -  **cmd** = The command to run.
   -  host
   -  username
   -  password
   -  private_key_filename = The full path to the private key or the name of the private key in ``~/.ssh/``.

-  std.javascript or std.js = Execute JavaScript code.

   -  **script** = The source code text to run.

-  send_email = Send an e-mail.

   -  to_addrs = A list of e-mail addresses to send the e-mail to.
   -  body = The text body of the e-mail.

Common task attributes:

-  description = A string describing what the action does.
-  input = Input strings
-  output = Output strings.
-  output-on-error = Strings that will only output if the task fails.
-  on-{complete,error,success} = A list of tasks to run given the state of the current task.
-  {pause-before,wait-before,wait-after} = Define dependencies or requirements between tasks.
-  timeout = The timeout, in seconds, before the task is marked as a failure.
-  retry = The number of times to retry the task before being marked as a failure.
-  concurrency = The maximum number of parallel task actions to run at once.

[61]

Load the YAML workflow into Mistral.

.. code-block:: sh

   $ mistral workflow-create <WORKFLOW_YAML_FILE_NAME>

Then execute the workflow using another file that contains the input variables and check it's progress.

.. code-block:: sh

   $ mistral execution-create <WORKFLOW> <VARIABLES_FILE>
   $ mistral execution-list
   $ mistral execution-get <EXECUTION_ID>

[60]

Testing
-------

Manual
~~~~~~

Manual testing of the core OpenStack services can be done by deploying an instance using a CirrOS image from `here <https://download.cirros-cloud.net/>`__. It is a minimalist fork of Ubuntu with a small set of packages installed. It was designed to run with the ``tiny`` instance flavor. [58] The default password for < 0.4 is ``cubswin:)`` and for >= 0.4 it is ``gocubsgo``. [59]

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

[41]

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

[43]

Registering
^^^^^^^^^^^

Rally requires a deployment, that defines the OpenStack credentials to test with, to be registered. It is recommended to use an account with the "admin" role so that all features of the cloud can be tested and benchmarked. The "admin" user is no longer required in Rally version >= 0.10.0. [46]

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

For only using non-privileged OpenStack users, omit the "admin" dictionary. [45]

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

[44]

Scenarios
^^^^^^^^^

Scenarios define the tests that will be ran. Variables can be tweaked to customize them. All Rally scenario files are Jinja2 templates and can be in JSON or YAML format. Multiple scenarios can be setup in a single file for Rally to test them all.

Example scenarios:

.. code-block:: sh

    (rally-venv)$ ls -1 ~/rally-venv/samples/tasks/scenarios/*

Each scenario can be configured using similar options.

-  args = Override default values for a task.
-  context = Defines the resources that need to be created before a task runs.
-  runner [47]

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

[44]

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

[48]

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

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/openstack/openstack.rst>`__
-  `< 2020.01.01 <https://github.com/ekultails/rootpages/commits/master/src/virtualization/openstack.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/openstack.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/openstack.md>`__

Bibliography
------------

1. "OpenStack Releases." OpenStack Releases. September 26, 2018. Accessed September 26, 2018. https://releases.openstack.org/
2. "New OpenStack Ocata stabilizes popular open-source cloud." February 22, 2017. Accessed April 10, 2017. http://www.zdnet.com/article/new-openstack-ocata-stabilizes-popular-open-source-cloud/
3. "Ocata [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/ocata/index.html
4. "Pike [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/pike/index.html
5. "Queens [Goals]." OpenStack Documentation. June 27, 2019. Accessed October 28, 2019. https://governance.openstack.org/tc/goals/queens/index.html
6. "Project Navigator." OpenStack. Accessed March 15, 2018. https://www.openstack.org/software/project-navigator/
7. "DevStack switching from MySQL-python to PyMySQL." OpenStack nimeyo. June 9, 2015. Accessed October 15, 2016. https://openstack.nimeyo.com/48230/openstack-all-devstack-switching-from-mysql-python-pymysql
8. "Using PostgreSQL with OpenStack." FREE AND OPEN SOURCE SOFTWARE KNOWLEDGE BASE. June 06, 2014. Accessed October 15, 2016. https://fosskb.in/2014/06/06/using-postgresql-with-openstack/
9. "[Ceilometer] Installation Guide." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/ceilometer/queens/install/
10. "Liberty install guide RHEL, keystone DB population unsuccessful: Module pymysql not found." OpenStack Manuals Bugs. March 24, 2017. Accessed April 3, 2017. https://bugs.launchpad.net/openstack-manuals/+bug/1501991
11. "Message queue." OpenStack Documentation. March 18, 2018. Accessed March 19, 2018. https://docs.openstack.org/install-guide/environment-messaging.html
12. "[oslo.messaging] Configurations." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/oslo.messaging/queens/configuration/
13. "[Keystone] Pike Series Release Notes." OpenStack Documentation. Accessed March 15, 2018. https://docs.openstack.org/releasenotes/keystone/pike.html
14. "Setting up an RDO deployment to be Identity V3 Only." Young Logic. May 8, 2015. Accessed October 16, 2016. https://adam.younglogic.com/2015/05/rdo-v3-only/
15. "Install and configure [Keystone on RDO]." OpenStack Documentation. March 13, 2018. Accessed March 15, 2018. https://docs.openstack.org/keystone/queens/install/keystone-install-rdo.html
16. "Ocata Series [Keystone] Release Notes." OpenStack Documentation. Accessed April 3, 2017. https://docs.openstack.org/releasenotes/keystone/ocata.html
17. "Hypervisors." OpenStack Documentation. March 8, 2018. Accessed March 18, 2018. https://docs.openstack.org/nova/queens/admin/configuration/hypervisors.html
18. “Driving in the Fast Lane – CPU Pinning and NUMA Topology Awareness in OpenStack Compute.” Red Hat Stack. Mary 5, 2015. Accessed April 13, 2017. http://redhatstackblog.redhat.com/2015/05/05/cpu-pinning-and-numa-topology-awareness-in-openstack-compute/
19. "CPU topologies." OpenStack Documentation. March 8, 2018. Accessed March 18, 2018. https://docs.openstack.org/nova/queens/admin/cpu-topologies.html
20. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. Accessed March 18, 2018. http://docs.ceph.com/docs/master/rbd/rbd-openstack
21. "Nested Virtualization in OpenStack, Part 2." Stratoscale. June 28, 2016. Accessed November 9, 2017. https://www.stratoscale.com/blog/openstack/nested-virtualization-openstack-part-2/
22. "[Compute service] Overview." OpenStack Documentation. March 8, 2018. Accessed March 19, 2018. https://docs.openstack.org/nova/queens/install/overview.html
23. "Open vSwitch: Self-service networks." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/deploy-ovs-selfservice.html
24. "Neutron Installation Guide." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/install/index.html
25. "DNS resolution for instances." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-dns-res.html
26. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/
27. "Load Balancer as a Service (LBaaS)." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-lbaas.html
28. "Quality of Service (QoS)." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-qos.html
29. "Neutron/DVR/HowTo" OpenStack Wiki. January 5, 2017. Accessed March 7, 2017. https://wiki.openstack.org/wiki/Neutron/DVR/HowTo
30. "Distributed Virtual Routing with VRRP." OpenStack Documentation. March 16, 2018. Accessed March 19, 2018. https://docs.openstack.org/neutron/queens/admin/config-dvr-ha-snat.html
31. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. Accessed March 26, 2018. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
32. "Volume encryption supported by the key manager." Openstack Documentation. March 18, 2018. Accessed March 19, 2018. https://docs.openstack.org/cinder/queens/configuration/block-storage/volume-encryption.html
33. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
34. "Adding additional NAT rule on neutron-l3-agent." Ask OpenStack. February 15, 2015. Accessed February 23, 2017. https://ask.openstack.org/en/question/60829/adding-additional-nat-rule-on-neutron-l3-agent/
35. "Networking in too much detail." RDO Project. January 9, 2017. Accessed February 23, 2017. https://www.rdoproject.org/networking/networking-in-too-much-detail/
36. "Upgrades." OpenStack Documentation. January 15, 2017. Accessed January 15, 2017. http://docs.openstack.org/ops-guide/ops-upgrades.html
37. "OpenStack Command Line." OpenStack Documentation. Accessed October 16, 2016. http://docs.openstack.org/developer/python-openstackclient/man/openstack.html
38. "OpenStack Orchestration In Depth, Part I: Introduction to Heat." Accessed September 24, 2016. November 7, 2014. https://developer.rackspace.com/blog/openstack-orchestration-in-depth-part-1-introduction-to-heat/
39. "Heat Orchestration Template (HOT) specification." OpenStack Documentation. February 15, 2019. Accessed October 28, 2019. https://docs.openstack.org/heat/latest/template_guide/hot_spec.html
40. "ggiamarchi/vagrant-openstack-provider." GitHub. January 30, 2017. Accessed April 3, 2017. https://github.com/ggiamarchi/vagrant-openstack-provider
41. "Tempest Configuration Guide." Sep 14th, 2016. http://docs.openstack.org/developer/tempest/configuration.html
42. "Stable branches." OpenStack Documentation. September 14, 2018. Accessed September 26, 2018. https://docs.openstack.org/project-team-guide/stable-branches.html
43. "[Rally] Installation and upgrades." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/install_and_upgrade/index.html
44. "[Rally] Quick start." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/quick_start/index.html
45. "Step 3. Benchmarking OpenStack with existing users." OpenStack Documentation. July 3, 2017. Accessed January 25, 2018. https://docs.openstack.org/developer/rally/quick_start/tutorial/step_3_benchmarking_with_existing_users.html
46. "Allow deployment without admin creds." OpenStack Gerrit Code Review. June 3, 2017. Accessed January 25, 2018. https://review.openstack.org/#/c/465495/
47. "Main concepts of Rally." OpenStack Documentation. July 3, 2017. Accessed January 26, 2018. https://docs.openstack.org/developer/rally/miscellaneous/concepts.html
48. "Verification reports." Rally Documentation. Accessed October 28, 2019. https://docs.openstack.org/rally/latest/verification/reports.html
49. "OpenStack Pike Repository." CentOS Vault. May 20, 2019. Accessed October 28, 2019. http://vault.centos.org/7.6.1810/cloud/x86_64/openstack-pike/
50. "External Ceph." OpenStack Documentation. March 15, 2018. Accessed March 19, 2018. https://docs.openstack.org/kolla-ansible/queens/reference/external-ceph-guide.html
51. "OVS 2.6 and The First Release of OVN." Russell Bryant. September 29, 2016. Accessed October 24, 2019. https://blog.russellbryant.net/2016/09/29/ovs-2-6-and-the-first-release-of-ovn/
52. "Upgrading OpenStack Services Simultaneously." RDO Project. Accessed August 15, 2018. https://www.rdoproject.org/install/upgrading-rdo-1/#upgrading-compute-all-at-once
53. "Rocky [Goals]." OpenStack Documentation. September 21, 2018. Accessed September 26, 2018. https://governance.openstack.org/tc/goals/pike/index.html
54. "Stein [Goals]." OpenStack Documentation. September 21, 2018. Accessed September 26, 2018. https://governance.openstack.org/tc/goals/stein/index.html
55. "Feature Configuration." TripleO Documentation. September 21, 2018. Accessed September 27, 2018. https://docs.openstack.org/tripleo-docs/latest/install/advanced_deployment/features.html
56. "Enabling Keystone's Fernet Tokens in Red Hat OpenStack Platform." Red Hat Blog. December 11, 2017. Accessed October 28, 2019. https://www.redhat.com/en/blog/enabling-keystones-fernet-tokens-red-hat-openstack-platform
57. "Install the OpenStack command-line clients." OpenStack Documentation. August 16, 2019. Accessed October 1, 2019. https://docs.openstack.org/mitaka/user-guide/common/cli_install_openstack_command_line_clients.html
58. "Get images." OpenStack Documentation. January 25, 2019. Accessed January 28, 2019. https://docs.openstack.org/image-guide/obtain-images.html
59. "set default password to 'gocubsgo'." cirros, Launchpad. November 3, 2016. Accessed February 23, 2019. https://git.launchpad.net/cirros/commit/?id=9a7c371ef329cf78f256d0a5a8f475d9c57f5477
60. "Workflow service (mistral) command-line client." OpenStack Documentation. August 15, 2018. Accessed March 1, 2019. https://docs.openstack.org/ocata/cli-reference/mistral.html
61. "Mistral Workflow Language v2 specification." OpenStack Documentation. Accessed November 13, 2019. Accessed March 1, 2019. https://docs.openstack.org/mistral/latest/user/wf_lang_v2.html
62. "[Cloud-Init] Documentation." Cloud-Init Documentation. Accessed July 25, 2019. https://cloudinit.readthedocs.io/en/latest/index.html
63. "Oslo." OpenStack Wiki. July 17, 2018. Accessed November 1, 2019. https://wiki.openstack.org/wiki/Oslo
