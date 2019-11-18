OpenStack-Ansible
=================

.. contents:: Table of Contents

OpenStack-Ansible uses Ansible for automating the deployment of Ubuntu inside of LXC containers that run the OpenStack services. This was created by RackSpace as an official tool for deploying and managing production environments.

-  Supported operating systems: Ubuntu 16.04 or 18.04
-  Experimentally supported operating systems: CentOS 7, openSUSE Leap 42

It offers key features that include:

-  Full LXC containerization of services.
-  HAProxy load balancing for clustering containers.
-  Scaling for MariaDB Galera, RabbitMQ, compute nodes, and more.
-  Central logging with rsyslog.
-  OpenStack package repository caching.
-  Automated upgrades.

[3]

The `OpenStack-Ansible GitHub repository <https://github.com/openstack/openstack-ansible>`__ has three different versions that can be used for deployments or upgrades.

-  ``stable/<OPENSTACK_RELEASE_NAME>`` = A branch for a specific release of OpenStack. All of the latest updates are committed here. Example: "stable/queens".
-  ``<OPENSTACK_RELEASE_NUMBER_MAJOR>.<OSA_MINOR>.<OSA_PATCH>`` = A tag of a specific OpenStack-Ansible release. The major version number is the same number that correlates to the OpenStack release. The minor and patch versions represent OpenStack-Ansible updates to the code. Example: "17.0.2" is the OpenStack Queens release and is the second OpenStack-Ansible update.
-  ``<OPENSTACK-RELEASE>-eol`` =  A tag of an end-of-life release. Upstream versions of OpenStack no longer recieve any support after a year. This contains the last code for that release. Example: "newton-eol".

SELinux is currently not supported for CentOS deployments due to the lack of SELinux maintainers in OpenStack-Ansible. [1]

All-in-One (AIO)
----------------

**Install**

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

   git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
   cd /opt/openstack-ansible/
   git checkout stable/queens

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

   scripts/bootstrap-ansible.sh
   scripts/bootstrap-aio.sh
   cd /opt/openstack-ansible/playbooks
   openstack-ansible setup-hosts.yml
   openstack-ansible setup-infrastructure.yml
   openstack-ansible setup-openstack.yml

If the installation fails, it is recommended to reinstall the operating
system to completely clear out all of the custom configurations that
OpenStack-Ansible creates. Running the ``scripts/run-playbooks.sh``
script will not work again until the existing LXC containers and
configurations have been removed.

After a reboot, the three-node MariaDB Galera cluster needs to be restarted properly by running the Galera installation playbook again.

.. code-block:: sh

   cd /opt/openstack-ansible/playbooks
   openstack-ansible -e galera_ignore_cluster_state=true galera-install.yml

[2]

OpenStack-Ansible will create a default "public" and "private" networks for the "demo" project. These are both on isolated networks that are only on the hypervisor. These networks can be removed by deleting these resources in the order below.

.. code-block:: sh

   openstack router unset --external-gateway router
   openstack router remove subnet router private-subnet
   openstack router delete router
   openstack network delete public
   openstack network delete private

The all-in-one environment does not have the ability to create networks on the external network. On a more complete lab deployment of OpenStack-Ansible (not an all-in-one), this is normally accomplished by creating a flat provider network. Example:

.. code-block:: sh

   openstack router create router_public
   openstack network create --share --provider-network-type flat --provider-physical-network flat --external external_network
   openstack subnet create --subnet-range 192.168.1.0/24 --allocation-pool start=192.168.1.201,end=192.168.1.254 --dns-nameserver 192.168.1.1 --gateway 192.168.1.1 --no-dhcp --network external_network external_subnet
   openstack router set router_public --external-gateway external_network

[11]

**Uninstall**

`This Bash script <https://docs.openstack.org/openstack-ansible/queens/user/aio/quickstart.html#rebuilding-an-aio>`__ can be used to clean up and uninstall most of the
OpenStack-Ansible installation. Use at your own risk. The recommended
way to uninstall OpenStack-Ansible is to reinstall the operating system. [2]

Configurations
--------------

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

[3]

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

[3]

Neutron
~~~~~~~

OpenStack-Ansible does not manage the network interfaces on host nodes. The ``br-vlan`` interface is recommended to be configured to provide access to the Internet. However, any network configuration can be configured.

Configure OpenStack-Ansible to only use a single interface (eth0), with no VLANs, on the 192.168.1.0/24 subnet:

.. code-block:: yaml

   cidr_networks:
     management: "192.168.1.0/24"

   used_ips:
     - 192.168.1.1,192.168.1.251,192.168.1.252

   global_overrides:
     internal_lb_vip_address: 192.168.1.252
     external_lb_vip_address: 192.168.1.251
     tunnel_bridge: eth0
     management_bridge: eth0
     provider_networks:
       - network:
         container_bridge: eth0
         container_type: veth
         type: raw
         container_interface: eth1
         ip_from_q: management
         is_container_address: True
         is_ssh_address: True
         groups_binds:
           - all_containers
           - hosts

After deployment, the external Neutron network and subnet can be created. [10]

.. code-block:: sh

    $ . /root/openrc
    $ openstack network create --share --provider-physical-network physical_network --provider-network-type flat --router external external_network
    $ openstack subnet create --subnet-range 192.168.1.0/24 --gateway 192.168.1.1 --network external_network --allocation-pool start=192.168.1.201,end=192.168.1.254 --no-dhcp public_subnet

Nova
~~~~

Common variables:

-  nova\_virt\_type = The virtualization technology to use for deploying
   instances with OpenStack. By default, OpenStack-Ansible will guess`
   what should be used based on what is installed on the hypervisor.
   Valid options are: ``qemu``, ``kvm``, ``lxd``, ``ironic``, or
   ``powervm``.

[4]

Ceph
~~~~

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
variable using proper YAML syntax. [6]

.. code-block:: yaml

    ceph_conf_file: |
      [global]
      fsid = 00000000-1111-2222-3333-444444444444
      mon_initial_members = mon1.example.local,mon2.example.local,mon3.example.local
      mon_host = {{ ceph_mons|join(',') }}
      auth_cluster_required = cephx
      auth_service_required = cephx

A new custom deployment of Ceph can be configured. It is recommended to
use at least 3 hosts for high availability and quorum. [5]

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

[5]

Another real-world example of deploying and managing Ceph as part of
OpenStack-Ansible can be found here:
https://github.com/openstack/openstack-ansible/commit/057bb30547ef753b4559a689902be711b83fd76f

Install
-------

Download and install the latest stable OpenStack-Ansible suite from GitHub.

.. code-block:: sh

   git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
   cd /opt/openstack-ansible/
   git checkout stable/rocky
   cp -a -r -v /opt/openstack-ansible/etc/openstack_deploy/ /etc/

Install Ansible and the related OpenStack Roles.

.. code-block:: sh

   /opt/openstack-ansible/scripts/bootstrap-ansible.sh

Generate random passwords for the services.

.. code-block:: sh

   /opt/openstack-ansible/scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml

- Configure OSA and verify that the configuration syntax is correct. There are "example", "test", and "prod[uction]" configuration files provided to ues as a base to start a new configuration from.

.. code-block:: sh

   cp /etc/openstack_deploy/openstack_user_config.yml.test.example /etc/openstack_deploy/openstack_user_config.yml
   cp /etc/openstack_deploy/user_variables.yml.test.example /etc/openstack_deploy/user_variables.yml
   vim /etc/openstack_deploy/openstack_user_config.yml
   cd /opt/openstack-ansible/playbooks/
   openstack-ansible setup-infrastructure.yml --syntax-check

-  Prepare the hosts.

.. code-block:: sh

   openstack-ansible setup-hosts.yml

- Setup the LXC containers.

.. code-block:: sh

   openstack-ansible setup-infrastructure.yml

-  Install the OpenStack services.

.. code-block:: sh

   openstack-ansible setup-openstack.yml

[3]

Operations
----------

OpenStack Utilities
~~~~~~~~~~~~~~~~~~~

Once OpenStack-Ansible is installed, it can be used immediately. The
primary container to use is the ``utility`` container.

.. code-block:: sh

   lxc-ls -1 | grep utility
   lxc-attach -n <UTILITY_CONTAINER_NAME>

The file ``/root/openrc`` should exist on the container with the
administrator credentials. Source this file to use them.

.. code-block:: sh

   source /root/openrc

Verify that all of the correct services and endpoints exist.

.. code-block:: sh

   openstack service list
   openstack endpoint list

[7]

Ansible Inventory
~~~~~~~~~~~~~~~~~

Ansible's inventory contains all of the connection and variable details
about the hosts (in this case, LXC containers) and which group they are
a part of. This section covers finding and using these inventory values
for management and troubleshooting.

-  Change into the OpenStack-Ansible directory.

   .. code-block:: sh

      /opt/openstack-ansible/

-  Show all of the groups and the hosts that are a part of it.

   .. code-block:: sh

      ./scripts/inventory-manage.py -G

-  Show all of the hosts and the groups they are a part of.

   .. code-block:: sh

      ./scripts/inventory-manage.py -g

-  List hosts that a Playbook will run against.

   .. code-block:: sh

      openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP> --list-hosts

-  List all the Ansible tasks that will be executed on a group or host.

   .. code-block:: sh

      openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP_OR_HOST> --list-tasks

[8]

Add a Infrastructure Node
~~~~~~~~~~~~~~~~~~~~~~~~~

Add the new host to the ``infra_hosts`` section in
``/etc/openstack_deploy/openstack_user_config.yml``. Then the inventory
can be updated which will generate a new unique node name that the
OpenStack-Ansible Playbooks can run against. The ``--limit`` options are
important because they will ensure that it will only run on the new
infrastructure node.

.. code-block:: sh

   cd /opt/openstack-ansible/playbooks
   /opt/openstack-ansible/playbooks/inventory/dynamic_inventory.py > /dev/null
   /opt/openstack-ansible/scripts/inventory-manage.py -l |awk '/<NEW_INFRA_HOST>/ {print $2}' | sort -u | tee /root/add_host.limit
   openstack-ansible setup-everything.yml --limit @/root/add_host.limit
   openstack-ansible --tags=openstack-host-hostfile setup-hosts.yml

[7]

Add a Compute Node
~~~~~~~~~~~~~~~~~~

Add the new host to the ``compute_hosts`` section in
``/etc/openstack_deploy/openstack_user_config.yml``. Then the
OpenStack-Ansible deployment Playbooks can be run again. If Ceilometer is in use then the `` /etc/openstack_deploy/conf.d/ceilometer.yml`` configuration will also have to be updated.

.. code-block:: sh

   cd /opt/openstack-ansible/playbooks
   openstack-ansible setup-hosts.yml --limit localhost,<NEW_COMPUTE_HOST>
   ansible nova_all -m setup -a 'filter=ansible_local gather_subset="!all"'
   openstack-ansible setup-openstack.yml --skip-tags nova-key-distribute --limit localhost,<NEW_COMPUTE_HOST>
   openstack-ansible setup-openstack.yml --tags nova-key --limit compute_hosts

[7]

Remove a Compute Node
~~~~~~~~~~~~~~~~~~~~~

Stop the services on the compute container and then use the
``openstack-ansible-ops`` project's Playbook ``remote_compute_node.yml``
to fully it. The host must also be removed from the
``/etc/openstack_deploy/openstack_user_config.yml`` configuration when
done.

.. code-block:: sh

    lxc-ls -1 | grep compute
    lxc-attach -n <COMPUTE_CONTAINER_TO_REMOVE>
    stop nova-compute
    stop neutron-linuxbridge-agent
    exit
    git clone https://git.openstack.org/openstack/openstack-ansible-ops /opt/openstack-ansible-ops
    cd /opt/openstack-ansible-ops/ansible_tools/playbooks
    openstack-ansible remove_compute_node.yml -e node_to_be_removed="<COMPUTE_CONTAINER_TO_REMOVE>"

[7]

Upgrades
--------

Minor
~~~~~

This is for upgrading OpenStack from one minor version to another in the same major release. An example would be going from 17.0.0 to 17.0.6.

-  Change the OpenStack-Ansible version to a new minor tag release. If a
   branch for a OpenStack release name is being used already, pull the
   latest branch commits down from GitHub.

   .. code-block:: sh

      cd /opt/openstack-ansible/
      git fetch --all
      git tag
      git checkout <TAG>

-  Update:

   -  **All services.**

      .. code-block:: sh

         ./scripts/bootstrap-ansible.sh
         cd ./playbooks/
         openstack-ansible setup-hosts.yml
         openstack-ansible -e rabbitmq_upgrade=true setup-infrastructure.yml
         openstack-ansible setup-openstack.yml

   -  **Specific services.**

      -  Update the cached package repository.

         .. code-block:: sh

            cd ./playbooks/
            sudo openstack-ansible repo-install.yml

      -  A single service can be upgraded now.

         .. code-block:: sh

            openstack-ansible <COMPONENT>-install.yml --limit <GROUP_OR_HOST>

      -  Some services, such as MariaDB and RabbitMQ, require special
         variables to be set to force an upgrade.

         .. code-block:: sh

            openstack-ansible galera-install.yml -e 'galera_upgrade=true'

         .. code-block:: sh

            openstack-ansible rabbitmq-install.yml -e 'rabbitmq_upgrade=true'

[9]

Major
~~~~~

OpenStack-Ansible has playbooks capable of fully upgrading OpenStack from one major release to the next. It is recommended to do a manual upgrade by following the `official guide <https://docs.openstack.org/openstack-ansible/queens/admin/upgrades/major-upgrades.html>`__. Below outlines how to do this automatically. OpenStack should first be updated to the latest minor version. [9]

-  Move into the OpenStack-Ansible project.

   .. code-block:: sh

      cd /opt/openstack-ansible

-  View the available OpenStack releases and choose which one to use.

   .. code-block:: sh

      git fetch --all
      git branch -a
      git tag
      git checkout <BRANCH_OR_TAG>

-  Run the upgrade script.

   .. code-block:: sh

      ./scripts/run-upgrade.sh

`History <https://github.com/ekultails/rootpages/commits/master/src/openstack/openstack-ansible.rst>`__
-------------------------------------------------------------------------------------------------------

Bibliography
------------

1. "Hosts role should set SELinux into permissive mode." openstack-ansible Launchpad Bugs. January 27, 2017. Accessed July 25, 2018. https://bugs.launchpad.net/openstack-ansible/+bug/1657517
2. "Quickstart: AIO." OpenStack-Ansible Documentation. July 13, 2018. Accessed July 19, 2018. https://docs.openstack.org/openstack-ansible/queens/user/aio/quickstart.html
3. "OpenStack-Ansible Deployment Guide." OpenStack Documentation. July 24, 2018. Accessed July 25, 2018. https://docs.openstack.org/project-deploy-guide/openstack-ansible/queens/
4. "Nova role for OpenStack-Ansible." OpenStack Documentation. March 15, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible-os_nova/queens/
5. "openstack ansible ceph." OpenStack FAQ. April 9, 2017. Accessed April 9, 2017. https://www.openstackfaq.com/openstack-ansible-ceph/
6. "Configuring the Ceph client (optional)." OpenStack Documentation. April 5, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-ceph_client/configure-ceph.html
7. "[OpenStack-Ansible] Operations Guide." OpenStack Documentation. October 8, 2019. Accessed October 28, 2019. https://docs.openstack.org/openstack-ansible/queens/admin/index.html
8. "Developer Documentation." OpenStack Documentation. March 19, 2018. Accessed March 19, 2018. https://docs.openstack.org/openstack-ansible/latest/contributor/index.html
9. "Operations Guide." OpenStack-Ansible Documentation. July 13, 2018. Accessed July 19, 2018. https://docs.openstack.org/openstack-ansible/queens/admin/index.html
10. "Open vSwitch: Provider Networks." Neutron OpenStack Documentation. July 24, 2018. Accessed July 25, 2018. https://docs.openstack.org/neutron/queens/admin/deploy-ovs-provider.html
11. "Deploying a Home Lab using OpenStack-Ansible." Lance Bragstad Random Bits. August 2, 2018. Accessed August 9, 2018. https://www.lbragstad.com/blog/using-openstack-ansible-for-home-lab
