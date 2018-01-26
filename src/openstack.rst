OpenStack Ocata
===============

.. contents:: Table of Contents

Introduction
------------

This guide is aimed to help guide Cloud Administrators through
deploying, managing, and upgrading OpenStack. Most topics mentioned in
this guide can be applied to similar environments and/or versions.

Versions
~~~~~~~~

Each OpenStack release starts with a letter, chronologically starting with A. These are usually named after the city where one of the recent development conferences were held. The major version number of OpenStack represents the major version number of each software in that release. For example, Ocata software is versioned as ``15.X.X``. A new release comes out after about 6 months of development. After a release, phase 1 of support provides bug fixes for 6 months. Then phase 2 starts for the next 6-12 months that will only provide major bug fixes. Phase 3 only provides security patches for the now end-of-life (EOL) release. Each release is typically supported for 1 year before becoming EOL. [85]

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

       1. Stability. This release included features that are mainly
          related to reliability, scaling, and performance enhancements.
          This came out 5 months after Newton, instead of the usual 6,
          due to the minimal amount of major changes. [2]
       2. Remove old OpenStack libraries that were built into some
          services. Instead, services should rely on the proper
          up-to-date dependencies provided by external packages. [3]

16. Pike

    -  Release: 2017-08-30
    -  EOL: 2018-09-03 [1]
    -  Goals:

       1. Convert all of the OpenStack code to be compatible with Python
          3. This is because Python 2 will become EOL in 2020.
       2. Make all APIs into WSGI applications. This will allow web
          servers to scale out and run faster with tuning compared to
          running as a standalone Python daemon. [4]

17. Queens

    -  Currently in development. The expected release date is in
       February or March of 2018. [1]
    -  Goals:

       -  Remove the need for the access control list "policy" files by
          having default values defined in the source code.
       -  Tempest will be split up into different projects for
          maintaining individual service unit tests. This contrasts with
          the old model that had all Tempest tests maintained in one
          central repository. [5]

18. Rocky

    -  On the roadmap.

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

::

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

::

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

-  Aodh = Telemetry alarming
-  Barbican = Key Management
-  CloudKitty = Billing
-  Congress = Governance
-  Designate = DNS
-  Freezer = Backup and recovery
-  Ironic = Bare-Metal Provisioning
-  Karbor = Data protection
-  Magnum = Containers
-  Manila = Shared Filesystems
-  Mistral = OpenStack Workflow
-  Monasca = Monitoring
-  Murano = Application Catalog
-  Octavia = Load Balancing
-  Rally = Benchmarking
-  Sahara = Elastic Map Reduce
-  Searchlight = Indexing
-  Trove = Database
-  Zaqar = Messaging
-  Zun = Containers

[10]

Automation
----------

It is possible to easily install OpenStack as an all-in-one (AIO) server
or onto a cluster of servers. Various tools exist for automating the
deployment and management of OpenStack.

Packstack
~~~~~~~~~

Supported operating system: RHEL 7, Fedora

Packstack is part of Red Hat's RDO project. It's purpose is for
providing small and simple demonstrations of OpenStack. This tool does
not handle any upgrades of the OpenStack services.

Install
^^^^^^^

First, install the required repositories for OpenStack.

RHEL:

::

    # yum install https://repos.fedorapeople.org/repos/openstack/openstack-ocata/rdo-release-ocata-3.noarch.rpm
    # subscription-manager repos --enable rhel-7-server-optional-rpms --enable rhel-7-server-extras-rpms

CentOS:

::

    # yum install centos-release-openstack-ocata

Finally, install the Packstack utility.

::

    # yum -y install openstack-packstack

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

::

    # packstack --gen-answer-file <FILE>
    # packstack --answer-file <FILE>

Packstack logs are stored in /var/tmp/packstack/. The administrator and
demo user credentials will be saved to the user's home directory.

::

    # source ~/keystonerc_admin
    # source ~/keystonerc_demo

Although the network will not be exposed by default, it can still be
configured later. The primary interface to the lab's network, typically
``eth0``, will need to be configured as a Open vSwitch bridge to allow
this. Be sure to replace the "IPADDR", "PREFIX", and "GATEWAY" with the
server's correct settings. Neutron will also need to be configured to
allow "flat" networks.

::

    # vim /etc/sysconfig/network-scripts/ifcfg-eth0
    DEVICE=eth0
    ONBOOT=yes
    DEVICETYPE=ovs
    TYPE=OVSPort
    OVS_BRIDGE=br-ex
    BOOTPROTO=none
    NM_CONTROLLED=no

::

    # vim /etc/sysconfig/network-scripts/ifcfg-br-ex
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

::

    # packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:eth0 --os-neutron-ml2-type-drivers=vxlan,flat

Alternatively, use these configuration options in the answer file.

::

    CONFIG_NEUTRON_ML2_TYPE_DRIVERS=vxlan,flat
    CONFIG_NEUTRON_OVS_BRIDGE_MAPPINGS=extnet:br-ex
    CONFIG_NEUTRON_OVS_BRIDGE_IFACES=br-ex:eth0
    CONFIG_PROVISION_DEMO=n

::

    # packstack --answer-file <ANSWER_FILE>

After the installation is finished, create the necessary network in
Neutron as the admin user. In this example, the network will
automatically allocate IP addresses between 192.168.1.201 and
192.168.1.254. The IP 192.168.1.1 is the router / default gateway.

::

    # . keystonerc_admin
    # neutron net-create external_network --provider:network_type flat --provider:physical_network extnet --router:external
    # neutron subnet-create --name public_subnet --enable_dhcp=False --allocation-pool=start=192.168.1.201,end=192.168.1.254 --gateway=192.168.1.1 external_network 192.168.1.0/24

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

       # for cert in selfcert ssl_dashboard ssl_vnc; do openssl req -x509 -sha256 -newkey rsa:2048 -keyout /etc/pki/tls/private/${cert}.key -out /etc/pki/tls/certs/${cert}.crt -days 365 -nodes; done

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

For uninstalling everything that is installed by Packstack, run this
Bash script on all of the OpenStack nodes [14]. Use at your own risk.

.. code:: bash

    #!/bin/bash
    # Warning! Dangerous step! Destroys VMs
    for x in $(virsh list --all | grep instance- | awk '{print $2}') ; do
        virsh destroy $x ;
        virsh undefine $x ;
    done ;

    # Warning! Dangerous step! Removes lots of packages, including many
    # which may be unrelated to RDO.
    yum remove -y nrpe "*nagios*" puppet ntp ntp-perl ntpdate "*openstack*" \
    "*nova*" "*keystone*" "*glance*" "*cinder*" "*swift*" \
    mysql mysql-server httpd "*memcache*" scsi-target-utils \
    iscsi-initiator-utils perl-DBI perl-DBD-MySQL ;

    ps -ef | grep -i repli | grep swift | awk '{print $2}' | xargs kill ;

    # Warning! Dangerous step! Deletes local application data
    rm -rf /etc/nagios /etc/yum.repos.d/packstack_* /root/.my.cnf \
    /var/lib/mysql/ /var/lib/glance /var/lib/nova /etc/nova /etc/swift \
    /srv/node/device*/* /var/lib/cinder/ /etc/rsync.d/frag* \
    /var/cache/swift /var/log/keystone ;

    umount /srv/node/device* ;
    killall -9 dnsmasq tgtd httpd ;
    setenforce 1 ;
    vgremove -f cinder-volumes ;
    losetup -a | sed -e 's/:.*//g' | xargs losetup -d ;
    find /etc/pki/tls -name "ssl_ps*" | xargs rm -rf ;
    for x in $(df | grep "/lib/" | sed -e 's/.* //g') ; do
        umount $x ;
    done

OpenStack-Ansible
~~~~~~~~~~~~~~~~~

Supported operating systems: RHEL 7, Ubuntu 16.04, openSUSE Leap 42,
SUSE Linux Enterprise 12

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

[15]

Quick
^^^^^

Install
'''''''

Minimum requirements:

-  8 CPU cores
-  50GB storage
-  8GB RAM (16GB recommended)

This quick installation guide covers how to install an all-in-one
environment. It is recommended to deploy this inside of a virtual
machine (with nested virtualization enabled) as many system
configurations are changed.

Setup the OpenStack-Ansible project.

::

    # git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
    # cd /opt/openstack-ansible/
    # git checkout stable/ocata

There are two all-in-one scenarios that will run different Ansible
Playbooks. The default is "aio" but this can be changed to the second
scenario by setting the ``SCENARIO`` shell variable to "ceph."
Alternatively, the roles to run can be manually modified in
``/opt/openstack-ansible/tests/bootstrap-aio.yml`` Playbook.

``# export SCENARIO="ceph"``

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

Then OpenStack-Ansible project can now setup and deploy the LXC
containers to run OpenStack.

::

    # scripts/bootstrap-ansible.sh
    # scripts/bootstrap-aio.sh
    # cd /opt/openstack-ansible/playbooks
    # openstack-ansible setup-hosts.yml
    # openstack-ansible setup-infrastructure.yml
    # openstack-ansible setup-openstack.yml

If the installation fails, it is recommended to reinstall the operating
system to completely clear out all of the custom configurations that
OpenStack-Ansible creates. Running the ``scripts/run-playbooks.sh``
script will not work again until the existing LXC containers and
configurations have been removed. [16]

Operations
''''''''''

A new node can be added at any time to an existing all-in-one
deployment. Copy the configuration file for an all-in-one instance.

::

    # cd /opt/openstack-ansible/
    # cp etc/openstack_deploy/conf.d/<PLAYBOOK_INSTANCE_CONFIGURATION>.yml.aio /etc/openstack_deploy/conf.d/<PLAYBOOK_INSTANCE_CONFIGURATION>.yml

Add the new container to the list of inventory servers.

::

    # /opt/openstack-ansible/scripts/inventory-manage.py > /dev/null

Update the repository server to include the new packages required.

::

    # cd playbooks/
    # openstack-ansible repo-install.yml

Deploy the new container and then run the Playbook.

::

    # openstack-ansible setup-everything.yml --limit <NEW_CONTAINER_NAME>
    # openstack-ansible <PLAYBOOK> --limit <NEW_CONTAINER_NAME>

[17]

Uninstall
'''''''''

This Bash script can be used to clean up and uninstall most of the
OpenStack-Ansible installation. Use at your own risk. The recommended
way to uninstall OpenStack-Ansible is to reinstall the operating system. [18]

.. code:: bash

    #!/bin/bash
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

Download and install the latest stable OpenStack-Ansible suite from
GitHub.

::

    # apt-get install git
    # git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
    # cd /opt/openstack-ansible/
    # git checkout stable/ocata
    # cp -a -r -v /opt/openstack-ansible/etc/openstack_deploy/ /etc/

Then copy over and modify the main configuration file.

::

    # cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml

[19]

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

[20]

Nova
&&&&

The default variables for Nova are listed at
https://docs.openstack.org/developer/openstack-ansible-os\_nova/ocata/.
These can be overriden.

Common variables:

-  nova\_virt\_type = The virtualization technology to use for deploying
   instances with OpenStack. By default, OpenStack-Ansible will guess
   what should be used based on what is installed on the hypervisor.
   Valid options are: ``qemu``, ``kvm``, ``lxd``, ``ironic``, or
   ``powervm``.

[21]

Ceph
&&&&

Ceph can be customized to be deployed differently from the default
configuration or to use an existing Ceph cluster.

These settings can be adjusted to use different Ceph users, pools,
and/or monitor nodes.

::

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

By default, OpenStack-Ansible will generate the ceph.conf configuration
file by connecting to the Ceph monitor hosts and obtaining the
information from there. Extra configuration options can be specified or
overriden using the "ceph\_extra"confs" dictionary.

::

    ceph_extra_confs:
    -  src: "<PATH_TO_LOCAL_CEPH_CONFIGURATION>"
       dest: "/etc/ceph/ceph.conf"
       mon_host: <MONITOR_IP>
       client_name: <CEPH_CLIENT>
       keyring_src: <PATH_TO_LOCAL_CEPH_CLIENT_KEYRING_FILE>
       keyring_dest: /etc/ceph/ceph.client.<CEPH_CLIENT>.keyring
       secret_uuid: '{{ cinder_ceph_client_<CEPH_CLIENT> }}'

Alternatively, the entire configuration file can be defined as a
variable using proper YAML syntax. [23]

::

    ceph_conf_file: |
      [global]
      fsid = 00000000-1111-2222-3333-444444444444
      mon_initial_members = mon1.example.local,mon2.example.local,mon3.example.local
      mon_host = {{ ceph_mons|join(',') }}
      auth_cluster_required = cephx
      auth_service_required = cephx

A new custom deployment of Ceph can be configured. It is recommended to
use at least 3 hosts for high availability and quorum. [22]

::

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

[22]

Another real-world example of deploying and managing Ceph as part of
OpenStack-Ansible can be found here:
https://github.com/openstack/openstack-ansible/commit/057bb30547ef753b4559a689902be711b83fd76f

Operations
''''''''''

OpenStack Utilities
&&&&&&&&&&&&&&&&&&&

Once OpenStack-Ansible is installed, it can be used immediately. The
primary container to use is the ``utility`` container.

::

    # lxc-ls -1 | grep utility
    # lxc-attach -n <UTILITY_CONTAINER_NAME>

The file ``/root/openrc`` should exist on the container with the
administrator credentials. Source this file to use them.

::

    # source /root/openrc

Verify that all of the correct services and endpoints exist.

::

    # openstack service list
    # openstack endpoint list

[24]

Ansible Inventory
&&&&&&&&&&&&&&&&&

Ansible's inventory contains all of the connection and variable details
about the hosts (in this case, LXC containers) and which group they are
a part of. This section covers finding and using these inventory values
for management and troubleshooting.

-  Change into the OpenStack-Ansible directory.

   ::

       # cd /opt/openstack-ansible/

-  Show all of the groups and the hosts that are a part of it.

   ::

       # ./scripts/inventory-manage.py -G

-  Show all of the hosts and the groups they are a part of.

   ::

       # ./scripts/inventory-manage.py -g

-  List hosts that a Playbook will run against.

   ::

       # openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP> --list-hosts

-  List all the Ansible tasks that will be executed on a group or host.

   ::

       # openstack-ansible ./playbooks/os-<COMPONENT>-install.yml --limit <GROUP_OR_HOST> --list-tasks

[25]

Add a Infrastructure Container
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

Add the new host to the ``infra_hosts`` section in
``/etc/openstack_deploy/openstack_user_config.yml``. Then the inventory
can be updated which will generate a new unique node name that the
OpenStack-Ansible Playbooks can run against. The ``--limit`` options are
important because they will ensure that it will only run on the new
infrastructure node.

::

    # cd /opt/openstack-ansible/playbooks
    # /opt/openstack-ansible/playbooks/inventory/dynamic_inventory.py > /dev/null
    # /opt/openstack-ansible/scripts/inventory-manage.py -l |awk '/<NEW_INFRA_HOST>/ {print $2}' | sort -u | tee /root/add_host.limit
    # openstack-ansible setup-everything.yml --limit @/root/add_host.limit
    # openstack-ansible --tags=openstack-host-hostfile setup-hosts.yml

[26]

Add a Compute Container
&&&&&&&&&&&&&&&&&&&&&&&

Add the new host to the ``compute_hosts`` section in
``/etc/openstack_deploy/openstack_user_config.yml``. Then the
OpenStack-Ansible deployment Playbooks can be run again.

::

    # cd /opt/openstack-ansible/playbooks
    # openstack-ansible setup-hosts.yml --limit <NEW_COMPUTE_HOST_NAME>
    # openstack-ansible setup-openstack.yml --skip-tags nova-key-distribute --limit <NEW_COMPUTE_HOST_NAME>
    # openstack-ansible setup-openstack.yml --tags nova-key --limit compute_hosts

[27]

Remove a Compute Container
&&&&&&&&&&&&&&&&&&&&&&&&&&

Stop the services on the compute container and then use the
``openstack-ansible-ops`` project's Playbook ``remote_compute_node.yml``
to fully it. Be sure to also remove the host from the
``/etc/openstack_deploy/openstack_user_config.yml`` configuration when
done.

::

    # lxc-ls -1 | grep compute
    # lxc-attach -n <COMPUTE_CONTAINER_TO_REMOVE>
    # stop nova-compute
    # stop neutron-linuxbridge-agent
    # exit
    # git clone https://git.openstack.org/openstack/openstack-ansible-ops /opt/openstack-ansible-ops
    # cd /opt/openstack-ansible-ops/ansible_tools/playbooks
    # openstack-ansible remove_compute_node.yml -e node_to_be_removed="<COMPUTE_CONTAINER_TO_REMOVE>"

[28]

Upgrades
''''''''

Minor
&&&&&

This is for upgrading OpenStack from one minor version to another in the
same major release. An example would be going from 15.0.0 to 15.1.1.

-  Change the OpenStack-Ansible version to a new minor tag release. If a
   branch for a OpenStack release name is being used already, pull the
   latest branch commits down from GitHub.

   ::

       # cd /opt/openstack-ansible/
       # git fetch --all
       # git checkout <TAG>

-  Update:

   -  **All services.**

      ::

          # ./scripts/bootstrap-ansible.sh
          # cd ./playbooks/
          # openstack-ansible setup-hosts.yml
          # openstack-ansible -e rabbitmq_upgrade=true setup-infrastructure.yml
          # openstack-ansible setup-openstack.yml

   -  **Specific services.**

      -  Update the cached package repository.

         ::

             # cd ./playbooks/
             # openstack-ansible repo-install.yml

      -  A single service can be upgraded now.

         ::

             # openstack-ansible <COMPONENT>-install.yml --limit <GROUP_OR_HOST>

      -  Some services, such as MariaDB and RabbitMQ, require special
         variables to be set to force an upgrade.

         ::

             # openstack-ansible galera-install.yml -e 'galera_upgrade=true'

         ::

             # openstack-ansible rabbitmq-install.yml -e 'rabbitmq_upgrade=true'

[29]

Major
&&&&&

OpenStack-Ansible has scripts capable of fully upgrading OpenStack from
one major release to the next. It is recommended to do a manual upgrade
by following the official guide:
https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/manual-upgrade.html.
Below outlines how to do this automatically. [30]

-  Move into the OpenStack-Ansible project.

   ::

       # cd /opt/openstack-ansible

-  View the available OpenStack releases and choose which one to use.

   ::

       # git branch -a
       # git tag

   ::

       # git checkout <BRANCH_OR_TAG>

-  Run the upgrade script.

   ::

       # ./scripts/run-upgrade.sh

TripleO
~~~~~~~

Supported operating systems: RHEL 7, Fedora >= 22

TripleO means "OpenStack on OpenStack." The Undercloud is first deployed
in a small, usually all-in-one, environment. This server is then used to
create and manage a full Overcloud cluster. Virtual machines or physical
servers can be used. [31]

Quick
^^^^^

The "TripleO-Quickstart" project was created to use Ansible to automate
deploying TripleO as fast and easily as possible. [32]

Install
'''''''

TripleO-Quickstart recommends a minimum of 32GB RAM and 120GB of disk
space when deploying with the default settings. [35] This deployment has
to use a baremetal hypervisor. Deploying TripleO within a virtual
machine that uses nested virtualization is not supported. [36]

-  Download the tripleo-quickstart script or clone the entire repository
   from GitHub.

   ::

       $ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh

   OR

   ::

       $ git clone https://github.com/openstack/tripleo-quickstart.git
       $ cd tripleo-quickstart

-  Install dependencies for the quickstart script.

   ::

       $ bash quickstart.sh --install-deps

TripleO can now be installed automatically with the default setup of 3
virtual machines. This will be created to meet the minimum TripleO cloud
requirements: (1) an Undercloud to deploy a (2) controller and (3)
compute node. [34] . Otherwise, a different node configuration from
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
   that the quickstart commmand is running on.

::

    $ bash quickstart.sh --release stable/ocata --tags all <REMOTE_HYPERVISOR_IP>

[33]

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

--------------

-  Setup the Undercloud virtual machine.

   ::

       $ bash quickstart.sh --release stable/ocata --clean --teardown all --tags all --playbook quickstart.yml <REMOTE_HYPERVISOR_IP>

-  Install the Undercloud services.

   ::

       $ bash quickstart.sh --release stable/ocata --teardown none --no-clone --tags all --retain-inventory --playbook quickstart-extras-undercloud.yml <REMOTE_HYPERVISOR_IP>

-  Setup the Overcloud virtual machines.

   ::

       $ bash quickstart.sh --release stable/ocata --teardown none --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml --retain-inventory --playbook quickstart-extras-overcloud-prep.yml <REMOTE_HYPERVISOR_IP>

-  Install the Overcloud services.

   ::

       $ bash quickstart.sh --release stable/ocata --teardown none --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml --retain-inventory --playbook quickstart-extras-overcloud.yml <REMOTE_HYPERVISOR_IP>

-  Validate the installation.

   ::

       $ bash quickstart.sh --release stable/ocata --teardown none --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml --retain-inventory  --playbook quickstart-extras-validate.yml <REMOTE_HYPERVISOR_IP>

[37]

Full
^^^^

Undercloud
''''''''''

The Undercloud can be installed onto a bare metal server or a virtual
machine. Follow the "hypervisor" section to assist with automatically
creating an Undercloud virtual machine.

-  **Hypervisor** (optional)

   -  Install the RDO Trunk / Delorean repositories.

      ::

          $ sudo curl -L -o /etc/yum.repos.d/delorean-ocata.repo https://trunk.rdoproject.org/centos7-ocata/current/delorean.repo
          $ sudo curl -L -o /etc/yum.repos.d/delorean-deps-ocata.repo https://trunk.rdoproject.org/centos7-ocata/delorean-deps.repo

   -  Install the Undercloud environment deployment tools.

      ::

          $ sudo yum install instack-undercloud

   -  Deploy a new virtual machine to be used for the Undercloud.

      ::

          $ instack–virt–setup

   -  Alternatively, use the TripleO-Quickstart project to deploy the
      Undercloud virtual machine. Leave the overcloud\_nodes variable
      blank to only deploy the Undercloud. Otherwise, provide a number
      of virtual machines that should be created for use in the
      Overcloud.

      ::

          $ curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh
          $ bash quickstart.sh --tags all --playbook quickstart.yml -e overcloud_nodes="" $VIRTHOST

   -  Log into the virtual machine once TripleO-Quickstart has completed
      setting up the environment.

      ::

          $ ssh -F ~/.quickstart/ssh.config.ansible undercloud

-  **Undercloud**

   -  It is recommended to create a user named "stack" with sudo
      privileges to manage the Undercloud.

      ::

          # useradd stack
          # passwd stack
          # echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack
          # chmod 0440 /etc/sudoers.d/stack
          # su - stack

   -  Install the RDO Trunk repositories.
   -  Install TripleO.

      ::

          # yum install python-tripleoclient

   -  Copy the sample configuration to use as a base template.

      ::

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

      ::

          $ openstack undercloud install

   -  The installation will be logged to
      ``$HOME/.instack/install-undercloud.log``.
   -  After the installation, OpenStack user credentials will be saved
      to ``$HOME/stackrc``. Source this file before running OpenStack
      commands to verify that the Undercloud is operational.

      ::

          $ source ~/stackrc
          $ openstack catalog list

   -  All OpenStack service passwords will be saved to
      ``$HOME/undercloud-passwords.conf``.

[38]

Overcloud
'''''''''

-  Download the prebuilt Overcloud image files from
   https://images.rdoproject.org/

   -  ironic-python-agent.initramfs
   -  ironic-python-agent.kernel
   -  overcloud-full.initrd
   -  overcloud-full.qcow2
   -  overcloud-full.vmlinuz

-  Upload those images.

   ::

       $ openstack overcloud image upload

-  Create a "instackenv.json" file that describes the physical
   infrastructure of the Overcloud as `outlined
   here <https://docs.openstack.org/tripleo-docs/latest/install/environments/baremetal.html#instackenv>`__.
   By default, everything is managed by IPMI. PXE can also be used,
   however it cannot manage power cycling a server.
-  Import the configuration that defines the Overcloud infrastructure
   and have it introspected so it can be deployed:

   ::

       $ openstack overcloud node import --introspect --provide instackenv.json

   -  Alternatively, automatically discover the available servers by
      scanning IPMI devices via a CIDR range and using different IPMI
      logins.

      ::

          $ openstack overcloud node discover --range <CIDR> \
          --credentials <USER1>:<PASSWORD1> --credentials <USER2>:<PASSWORD2>

-  Deploy the Overcloud with any custom Heat configurations. [39] Starting with the Pike release, most services are deployed as containers by default. For preventing the use of containers, remove the "docker.yaml" and "docker-ha.yaml" files from `/usr/share/openstack-tripleo-heat-templates/environments/`. [40]

   ::

       $ openstack help overcloud deploy

-  Verify that the Overcloud was deployed.

   ::

       $ openstack stack list
       $ openstack stack show <OVERCLOUD_STACK_ID>

-  Source the Overcloud credentials to manage it.

   ::

       $ source ~/overcloudrc

[39]

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

Different database backends can be used by the API services on the
controller nodes.

-  MariaDB/MySQL. Requires the "PyMySQL" Python library. Starting with
   Liberty, this is preferred on Ubuntu over using "``mysql://``" as the
   latest OpenStack libraries are written for PyMySQL connections (not
   to be confused with "MySQL-python"). [41] RHEL still requires the use
   of the legacy "``mysql://``" connector. [44]

   ::

       [ database ] connection = mysql+pymysql://<USER>:<PASSWORD>@<MYSQL_HOST>:<MYSQL_PORT>/<DATABASE>

-  PostgreSQL. Requires the "psycopg2" Python library. [42]

   ::

       [ database ] connection = postgresql://<USER>:<PASSWORD>@<POSTGRESQL_HOST>:<POSTGRESQL_PORT>/<DATABASE>

-  SQLite.

   ::

       [ database ] connection = sqlite:///<DATABASE>.sqlite

-  MongoDB is generally only used for Ceilometer when it is not using
   the Gnocchi back-end. [43]

   ::

       [ database ] mongodb://<USER>:<PASSWORD>@<MONGODB_HOST>:<MONGODB_PORT>/<DATABASE>

Messaging
^^^^^^^^^

For high availability and scalability, servers should be configured with
a messaging agent. This allows a client's request to correctly be
handled by the messaging queue and sent to one node to process that
request.

The configuration has been consolidated into the ``transport_url``
option. Multiple messaging hosts can be defined by using a comma before
naming a virtual host.

::

    transport_url = <TRANSPORT>://<USER1>:<PASS1>@<HOST1>:<PORT1>,<USER2>:<PASS2>@<HOST2>:<PORT2>/<VIRTUAL_HOST>

Scenario #1 - RabbitMQ

On the controller nodes, RabbitMQ needs to be installed. Then a user
must be created with full privileges.

::

    # rabbitmqctl add_user <RABBIT_USER> <RABBIT_PASSWORD>
    # rabbitmqctl set_permissions openstack ".*" ".*" ".*"

In the configuration file for every service, set the transport\_url
options for RabbitMQ. A virtual host is not required. By default it will
use ``/``.

::

    [ DEFAULT ] transport_url = rabbit://<RABBIT_USER>:<RABBIT_PASSWORD>@<RABBIT_HOST>/<VIRTUAL_HOST>

[45]

Scenario #2 - ZeroMQ

This provides the best performance and stability. Scalability becomes a
concern only when getting into hundreds of nodes. Instead of relying on
a messaging queue, OpenStack services talk directly to each other using
the ZeroMQ library. Redis is required to be running and installed for
acting as a message storage back-end for all of the servers. [45][46]

::

    [ DEFAULT ] transport_url = "zmq+redis://<REDIS_HOST>:6379"

::

    [ oslo_messaging_zmq ] rpc_zmq_bind_address = <IP>
    [ oslo_messaging_zmq ] rpc_zmq_bind_matchmaker = redis
    [ oslo_messaging_zmq ] rpc_zmq_host = <FQDN_OR_IP>

Alternatively, for high availability, use Redis Sentinel servers for the
``transport_url``.

::

    [ DEFAULT ] transport_url = "zmq+redis://<REDIS_SENTINEL_HOST1>:26379,<REDI_SENTINEL_HOST2>:26379"

For all-in-one deployments, the minimum requirement is to specify that
ZeroMQ should be used.

::

    [ DEFAULT ] transport_url = "zmq://"

[47]

Keystone
~~~~~~~~

API v3
^^^^^^

In Newton, the Keystone v2.0 API has been completely deprecated. It will
be removed entirely from OpenStack in the ``Queens`` release. [48] It is
possible to run both v2.0 and v3 at the same time but it's desirable to
move towards the v3 standard. If both have to be enabled, services
should be configured to use v2.0 or else problems can occur with v3's
domain scoping. For disabling v2.0 entirely, Keystone's API paste
configuration needs to have these lines removed (or commented out) and
then the web server should be restarted.

-  /etc/keystone/keystone-paste.ini

   -  [pipeline:public\_api]

      -  pipeline = cors sizelimit url\_normalize request\_id
         admin\_token\_auth build\_auth\_context token\_auth json\_body
         ec2\_extension public\_service

   -  [pipeline:admin\_api]

      -  pipeline = cors sizelimit url\_normalize request\_id
         admin\_token\_auth build\_auth\_context token\_auth json\_body
         ec2\_extension s3\_extension admin\_service

   -  [composite:main]

      -  /v2.0 = public\_api

   -  [composite:admin]

      -  /v2.0 = admin\_api

[49]

Token Provider
^^^^^^^^^^^^^^

The token provider is used to create and delete tokens for
authentication. Different providers can be used as the backend.

Scenario #1 - UUID (default)

-  /etc/keystone/keystone.conf

   -  [token]

      -  provider = uuid

Scenario #2 - PKI

PKI tokens have been removed since the Ocata release. [52]

-  /etc/keystone/keystone.conf

   -  [token]

      -  provider = pki

-  Create the certificates. A new directory "/etc/keystone/ssl/" will be
   used to store these files.

   ::

       # keystone-manage pki_setup --keystone-user keystone --keystone-group keystone

Scenario #3 - Fernet (fastest token creation)

A public and private key wil need to be created for Fernet and the
related Credential authentication.

-  /etc/keystone/keystone.conf

   -  [token]

      -  provider = fernet

   -  [fernet\_tokens]

      -  key\_repository = /etc/keystone/fernet-keys/

   -  [credential]

      -  provider = fernet
      -  key\_repository = /etc/keystone/credential-keys/

   -  [token]

      -  provider = fernet

-  Create the required keys:

   ::

       # mkdir /etc/keystone/fernet-keys/
       # chmod 750 /etc/keystone/fernet-keys/
       # chown keystone.keystone /etc/keystone/fernet-keys/
       # keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

   ::

       # mkdir /etc/keystone/credential-keys/
       # chmod 750 /etc/keystone/credential-keys/
       # chown keystone.keystone /etc/keystone/credential-keys/
       # keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

[50][51][53]

Nova
~~~~

-  /etc/nova/nova.conf

   -  [libvirt]

      -  inject\_key = false

         -  Do not inject SSH keys via Nova. This should be handled by
            the Nova's metadata service. This will either be
            "openstack-nova-api" or "openstack-nova-metadata-api"
            depending on your setup.

   -  [DEFAULT]

      -  enabled\_apis = osapi\_compute,metadata

         -  Enable support for the Nova API and Nova's metadata API. If
            "metedata" is specified here, then the "openstack-nova-api"
            handles the metadata and not "openstack-nova-metadata-api."

   -  [api\_database]

      -  connection =
         connection=mysql://nova:password@10.1.1.1/nova\_api

   -  [database]

      -  connection = mysql://nova:password@10.1.1.1/nova

         -  For the controller nodes, specify the connection SQL
            connection string. In this example it uses MySQL, the MySQL
            user "nova" with a password called "password", it connects
            to the IP address "10.1.1.1" and it is using the database
            "nova."

Hypervisors
^^^^^^^^^^^

Nova supports a wide range of virtualization technologies. Full hardware
virtualization, paravirtualization, or containers can be used. Even
Windows' Hyper-V is supported. [54]

Scenario #1 - KVM

-  /etc/nova/nova.conf

   -  [DEFAULT]

      -  compute\_driver = libvirt.LibvirtDriver

   -  [libvirt]

      -  virt\_type = kvm

[55]

Scenario #2 - Xen

-  /etc/nova/nova.conf

   -  [DEFAULT]

      -  compute\_driver = libvirt.LibvirtDriver

   -  [libvirt]

      -  virt\_type = xen

[56]

Scenario #3 - LXC

-  /etc/nova/nova.conf

   -  [DEFAULT]

      -  compute\_driver = libvirt.LibvirtDriver

   -  [libvirt]

      -  virt\_type = lxc

[57]

CPU Pinning
^^^^^^^^^^^

-  Verify that the processor(s) has hardware support for non-uniform
   memory access (NUMA). If it does, NUMA may still need to be turned on
   in the BIOS. NUMA nodes are the physical processors. These processors
   are then mapped to specific sectors of RAM.

   ::

       # lscpu | grep NUMA
       NUMA node(s):          2
       NUMA node0 CPU(s):     0-9,20-29
       NUMA node1 CPU(s):     10-19,30-39

   ::

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

   ::

       # virsh nodeinfo | grep NUMA
       NUMA cell(s):        2

-  Append the two NUMA filters ``NUMATopologyFilter`` and
   ``AggregateInstanceExtraSpecsFilter`` to the Nova
   ``scheduler_default_filters``. [58]

   ::

       # vim /etc/nova/nova.conf
       [ DEFAULT ] scheduler_default_filters = RetryFilter,AvailabilityZoneFilter,RamFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImageProp
       ertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,NUMATopologyFilter,AggregateInstanceExtraSpecsFilter

-  Restart the Nova scheduler service on the controller node(s).

   ::

       # systemctl restart openstack-nova-scheduler

-  Set the aggregate/availability zone to allow pinning.

   ::

       # openstack aggregate create <AGGREGATE_ZONE>
       # openstack aggregate set --property pinned=true <AGGREGATE_ZONE>

-  Add the compute hosts to the new aggregate zone.

   ::

       # openstack host list | grep compute
       # openstack aggregate host add <AGGREGATE_ZONE> <COMPUTE_HOST>

-  Modify a flavor to provide dedicated CPU pinning.

   ::

       # openstack flavor set <FLAVOR_ID> --property hw:cpu_policy=dedicated --property hw:cpu_thread_policy=prefer

-  Optionally, force images to only work with CPU pinned flavors. [59]

   ::

       # openstack image set <IMAGE_ID> --property hw_cpu_policy=dedicated --property hw_cpu_thread_policy=isolate

Ceph
^^^^

Nova can be configured to use Ceph as the storage provider for the
instance. This works with any QEMU based hypervisor.

-  /etc/nova/nova.conf

   -  [libvirt]

      -  images\_type = rbd
      -  images\_rbd\_pool = ``<CEPH_VOLUME_POOL>``
      -  images\_rbd\_ceph\_conf = /etc/ceph/ceph.conf
      -  rbd\_user = ``<CEPHX_USER>``
      -  rbd\_secret\_uuid = ``<LIBVIRT_SECRET_UUID>``

[60]

Nested Virtualization
^^^^^^^^^^^^^^^^^^^^^

Nested virtualization allows virtual machines to run virtual machines
inside of them.

The kernel module must be stopped, the nested setting enabled, and then
the module must be started again.

Intel:

::

    # rmmod kvm_intel
    # echo “options kvm_intel nested=1” >> /etc/modprobe.d/kvm_inet.conf
    # modprobe kvm_intel

AMD:

::

    # rmmod kvm_amd
    # echo “options kvm_amd nested=1” >> /etc/modprobe.d/kvm_amd.conf
    # modprobe kvm_amd

-  /etc/nova/nova.conf

   -  [libvirt]

      -  virt\_type = kvm
      -  cpu\_mode = host-passthrough

[61]

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
Firewall-as-a-Service (FWaaS), and more. [62]

Provider Networks
'''''''''''''''''

Linux Bridge
&&&&&&&&&&&&

https://docs.openstack.org/neutron/pike/admin/deploy-lb-provider.html

Open vSwitch
&&&&&&&&&&&&

https://docs.openstack.org/neutron/pike/admin/deploy-ovs-provider.html

Self-Service Networks
'''''''''''''''''''''

Linux Bridge
&&&&&&&&&&&&

https://docs.openstack.org/neutron/pike/admin/deploy-lb-selfservice.html

Open vSwitch
&&&&&&&&&&&&

One device is required, but it is recommended to separate traffic onto
two different network interfaces. There is ``br-vlan`` (sometimes also
referred to as ``br-provider``) for internal tagged traffic and
``br-ex`` for external connectivity.

::

    # ovs-vsctl add-br br-vlan
    # ovs-vsctl add-port br-vlan <VLAN_INTERFACE>
    # ovs-vsctl add-br br-ex
    # ovs-vsctl add-port br-ex <EXTERNAL_INTERFACE>

-  /etc/neutron/neutron.conf

   -  [DEFAULT]

      -  core\_plugin = ml2
      -  service\_plugins = router
      -  allow\_overlapping\_ips = True

-  /etc/neutron/plugins/ml2/ml2\_conf.ini

   -  [ml2]

      -  type\_drivers = flat,vlan,vxlan
      -  tenant\_network\_types = vxlan
      -  mechanism\_drivers = linuxbridge,l2population
      -  ml2\_type\_vxlan = ``<START_NUMBER>``,\ ``<END_NUMBER>``

-  /etc/neutron/plugins/ml2/openvswitch\_agent.ini

   -  [ovs]

      -  bridge\_mappings = ``<LABEL>``:br-vlan

         -  The ``<LABEL>`` can be any unique name. It is used as an
            alias for the interface name.

      -  local\_ip = ``<IP_ADDRESS>``

         -  This IP address should be accessible on the ``br-vlan``
            interface.

   -  [agent]

      -  tunnel\_types = vxlan
      -  l2\_population = True

   -  [securitygroup]

      -  firewall\_driver = iptables\_hybrid

-  /etc/neutron/l3\_agent.ini

   -  [DEFAULT]

      -  interface\_driver = openvswitch
      -  external\_network\_bridge =

         -  This value should be left defined but blank.

[63]

On the controller node, restart the Nova API service and then start the
required Neutron services.

::

    # systemctl restart openstack-nova-api
    # systemctl enable neutron-server neutron-openvswitch-agent neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent
    # systemctl start neutron-server neutron-openvswitch-agent neutron-dhcp-agent neutron-metadata-agent neutron-l3-agent

Finally, on the compute nodes, restart the compute service and then
start the Open vSwitch agent.

::

    # systemctl restart openstack-nova-compute
    # systemctl enable neutron-openvswitch-agent
    # systemctl start neutron-openvswitch-agent

[64]

DNS
^^^

By default, Neutron does not provide any DNS resolvers. This means that
DNS will not work. It is possible to either provide a default list of
name servers or configure Neutron to refer to the relevant
/etc/resolv.conf file on the server.

Scenario #1 - Define default resolvers (recommended)

-  /etc/neutron/dhcp\_agent.ini

   -  [DEFAULT]

      -  dnsmasq\_dns\_servers = 8.8.8.8,8.8.4.4

Scenario #2 - Leave resolvers to be configured by the subnet details

-  Nothing needs to be configured. This is the default setting.

Scenario #3 - Do not provide resolvers

-  /etc/neutron/dhcp\_agent.ini

   -  [DEFAULT]

      -  dnsmasq\_local\_resolv = True

[65]

Metadata
^^^^^^^^

The metadata service provides useful information about the instance from
the IP address 169.254.169.254/32. This service is also used to
communicate with "cloud-init" on the instance to configure SSH keys and
other post-boot tasks.

Assuming authentication is already configured, set these options for the
OpenStack environment. These are the basics needed before the metadata
service can be used correctly. Then you can choose to use DHCP
namespaces (layer 2) or router namespaces (layer 3) for
delivering/receiving requests.

-  /etc/neutron/metadata\_agent.ini

   -  [DEFAULT]

      -  nova\_metadata\_ip = CONTROLLER\_IP
      -  metadata\_proxy\_shared\_secret = ``<SECRET_KEY>``

-  /etc/nova/nova.conf

   -  [DEFAULT]

      -  enabled\_apis = osapi\_compute,metadata

   -  [neutron]

      -  service\_metadata\_proxy = True
      -  metadata\_proxy\_shared\_secret = ``<SECRET_KEY>``

Scenario #1 - DHCP Namespace (recommended for DVR)

-  /etc/neutron/dhcp\_agent.ini

   -  [DEFAULT]

      -  force\_metadata = True
      -  enable\_isolated\_metadata = True
      -  enable\_metadata\_network = True

-  /etc/neutron/l3\_agent.ini

   -  [DEFAULT]

      -  enable\_metadata\_proxy = False

Scenario #2 - Router Namespace

-  /etc/neutron/dhcp\_agent.ini

   -  [DEFAULT]

      -  force\_metadata = False
      -  enable\_isolated\_metadata = True
      -  enable\_metadata\_network = False

-  /etc/neutron/l3\_agent.ini

   -  [DEFAULT]

      -  enable\_metadata\_proxy = True

[66]

Load-Balancing-as-a-Service
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Load-Balancing-as-a-Service version 2 (LBaaS v2) has been stable since
Liberty. It can be configured with either the HAProxy or Octavia
back-end. LBaaS v1 has been removed since the Newton release.

-  /etc/neutron/neutron.conf

   -  [DEFAULT]

      -  service\_plugins = ``<EXISTING_PLUGINS>``,
         neutron\_lbaas.services.loadbalancer.plugin.LoadBalancerPluginv2

         -  Append the LBaaSv2 service plugin.

-  /etc/neutron/lbaas\_agent.ini

   -  [DEFAULT]

      -  interface\_driver =
         neutron.agent.linux.interface.OVSInterfaceDriver

         -  This is for Neutron with the Open vSwitch backend only.

      -  interface\_driver =
         neutron.agent.linux.interface.BridgeInterfaceDriver

         -  This is for Neutron with the Linux Bridge backend only.

Scenario #1 - HAProxy (recommended for it's maturity)

-  /etc/neutron/neutron\_lbaas.conf

   -  [service\_providers]

      -  service\_provider =
         LOADBALANCERV2:Haproxy:neutron\_lbaas.drivers.haproxy.plugin\_driver.HaproxyOnHostPluginDriver:default

-  /etc/neutron/lbaas\_agent.ini

   -  [DEFAULT]

      -  device\_driver =
         neutron\_lbaas.drivers.haproxy.namespace\_driver.HaproxyNSDriver

   -  [haproxy]

      -  user\_group = haproxy

         -  Specify the group that HAProxy runs as. In RHEL, it's
            ``haproxy``.

Scenario #2 - Octavia

-  /etc/neutron/neutron\_lbaas.conf

   -  [service\_providers]

      -  service\_provider =
         LOADBALANCERV2:Octavia:neutron\_lbaas.drivers.octavia.driver.OctaviaDriver:default

[67]

Quality of Service
^^^^^^^^^^^^^^^^^^

The Quality of Service (QoS) plugin can be used to rate limit the amount
of bandwidth that is allowed through a network port.

-  /etc/neutron/neutron.conf

   -  [DEFAULT]

      -  service\_plugins = neutron.services.qos.qos\_plugin.QoSPlugin

         -  Append the QoS plugin to the list of service\_plugins.

-  /etc/neutron/plugins/ml2/openvswitch\_agent.ini

   -  [ml2]

      -  extension\_drivers = qos

         -  Append the QoS driver with the modular layer 2 plugin
            provider. In this example it is added to Open vSwitch.
            LinuxBridge and SR-IOV also support the quality of service
            extension.

-  /etc/neutron/plugins/ml2/ml2\_conf.ini

   -  [agent]

      -  extensions = qos

         -  Append the QoS extension to the modular layer 2
            configuration.

[68]

Distributed Virtual Routing
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Distributed virtual routing (DVR) is a concept that involves deploying
routers to both the compute and network nodes to spread out resource
usage. All layer 2 traffic will be equally spread out among the servers.
Public floating IPs will still need to go through the SNAT process via
the routers on the network nodes. This is only supported when the Open
vSwitch agent is used. [69]

-  /etc/neutron/neutron.conf

   -  [DEFAULT]

      -  router\_distributed = true

-  /etc/neutron/l3\_agent.ini (compute)

   -  [DEFAULT]

      -  agent\_mode = dvr

-  /etc/neutron/l3\_agent.ini (network or all-in-one)

   -  [DEFAULT]

      -  agent\_mode = dvr\_snat

-  /etc/neutron/plugins/ml2/ml2\_conf.ini

   -  [ml2]

      -  mechanism\_drivers = openvswitch, l2population

-  /etc/neutron/plugins/ml2/openvswitch\_agent.ini

   -  [agent]

      -  l2\_population = true

   -  [agent]

      -  enable\_distributed\_routing = true

High Availability
^^^^^^^^^^^^^^^^^

High availability (HA) in Neutron allows for routers to failover to
another duplicate router if one fails or is no longer present. All new
routers will be highly available.

-  /etc/neutron/neutron.conf

   -  [DEFAULT]

      -  l3\_ha = true
      -  max\_l3\_agents\_per\_router = 2
      -  allow\_automatic\_l3agent\_failover = true

[70]

Ceph
~~~~

For Cinder and/or Glance to work with Ceph, the Ceph configuration needs
to exist on each controller and compute node. This can be copied over
from the Ceph nodes. An example is provided below.

::

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

::

    # ceph osd pool create glance <PG_NUM> <PGP_NUM>
    # ceph osd pool create cinder <PG_NUM> <PGP_NUM>
    # ceph auth get-or-create client.cinder mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=volumes'
    # ceph auth get-or-create client.glance mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=images'

If Cephx is turned on to utilize authentication, then a client keyring
file should be created on the controller and compute nodes. This will
allow the services to communicate to Ceph as a specific user. The
usernames should match the client users that were just created. [71]

::

    # vim /etc/ceph/ceph.client.<USERNAME>.keyring
    [client.<USERNAME>]
            key = <KEY>

On the controller and compute nodes the Nova, Cinder, and Glance
services require permission to read the ``/etc/ceph/ceph.conf`` and
client configurations at ``/etc/ceph/ceph.client.<USERNAME>.keyring``.
The service users should be added to a common group to help securely
share these settings.

::

    # for openstack_service in "cinder glance nova"; do usermod -a -G ceph ${openstack_service}; done
    # chmod -R 640 /etc/ceph/
    # chown -R ceph.ceph /etc/ceph/

For the services to work, the relevant Python libraries for accessing
Ceph need to be installed. These can be installed by the operating
system's package manager. [72]

RHEL:

::

    python-ceph-compat
    python-rbd

Debian:

::

    python-ceph

Cinder
~~~~~~

The Cinder service provides block devices for instances.

Ceph
^^^^

Ceph has become the most popular backend to Cinder due to it's high
availability and scalability.

-  /etc/cinder/cinder.conf

   -  [DEFAULT]

      -  enabled\_backends = ceph

         -  Use the ``[ceph]`` section for the backend configuration.
            This new section can actually be named anything but the same
            name must be used here.

      -  volume\_backend\_name = volumes
      -  rados\_connect\_timeout = -1

   -  [ceph]

      -  volume\_driver = cinder.volume.drivers.rbd.RBDDriver

         -  Use Cinder's RBD Python library.

      -  rbd\_pool = volumes

         -  This is the RBD pool to use for volumes.

      -  rbd\_ceph\_conf = /etc/ceph/ceph.conf
      -  rbd\_flatten\_volume\_from\_snapshot = false

         -  Ceph supports efficient thin provisioned snapshots.

      -  rbd\_max\_clone\_depth = 5
      -  rbd\_store\_chunk\_size = 4
      -  rados\_connect\_timeout = -1
      -  glance\_api\_version = 2

-  /etc/nova/nova.conf

   -  [libvirt]

      -  images\_type = rbd
      -  images\_rbd\_pool = volumes
      -  images\_rbd\_ceph\_conf = /etc/ceph/ceph.conf
      -  rbd\_user = cinder
      -  rbd\_secret\_uuid = ``<LIBVIRT_SECRET_UUID>``

         -  This is the Libvirt secret UUID that allows for
            authentication with Cephx. It is configured with the
            ``virsh`` secret commands. Refer to the Root Page's
            ``Virtualization`` guide for more information.

            ::

                # virsh --help | grep secret

[73]

Encryption
^^^^^^^^^^

Cinder volumes support the Linux LUKS encryption. The only requirement
is that the compute nodes have the "cryptsetup" package installed. [74]

::

    $ openstack volume type create LUKS
    $ cinder encryption-type-create --cipher aes-xts-plain64 --key_size 512 --control_location front-end LUKS nova.volume.encryptors.luks.LuksEncryptor

Encrypted volumes can now be created.

::

    $ openstack volume create --size <SIZE_IN_GB> --type LUKS <VOLUME_NAME>

Glance
~~~~~~

Glance is used to store and manage images for instance deployment.

Ceph
^^^^

Ceph can be used to store images.

-  /etc/glance/glance-api.conf

   -  [DEFAULT]

      -  show\_image\_direct\_url = True

         -  This will allow copy-on-write (CoW) operations for efficient
            usage of storage for instances. Instead of cloning the
            entire image, CoW will be used to store changes between the
            instance and the original image. This assumes that Cinder is
            also configured to use Ceph.
         -  The back-end Ceph addressing will be viewable by the public
            Glance API. It is important to make sure that Ceph is not
            publicly accessible.

   -  [glance\_store]

      -  stores = rbd
      -  default\_store = rbd
      -  rbd\_store\_pool = ``<RBD_POOL>``
      -  rbd\_store\_user = ``<RBD_USER>``
      -  rbd\_store\_ceph\_conf = /etc/ceph/ceph.conf
      -  rbd\_store\_chunk\_size = 8

[75]

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

::

    # ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-OUTPUT -d <FLOATING_IP>/32 -j DNAT --to-destination <LOCAL_IP>
    # ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-PREROUTING -d <FLOATING_IP>/32 -j DNAT --to-destination <LOCAL_IP>
    # ip netns exec snat-<ROUTER_ID> iptables -t nat -A neutron-l3-agent-float-snat -s <LOCAL_IP>/32 -j SNAT --to-source <FLOATING_IP>
    # ip netns exec snat-<ROUTER_ID> ip address add <FLOATING_IP>/32 brd <FLOATING_IP> dev qg-b2e3c286-b2

With no floating IPs allocated, the iptables NAT table in the SNAT
namespace should look similar to this.

::

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

[76][77]

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

[78]

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

-  Add the credentials to a text file This is generally ends with the
   ".sh" extension to signify it's a shell file. A few default variables
   are filled in below.
-  Keystone v2.0

   ::

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

-  Keystone v3

   ::

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

-  Source the credential file to load it into the shell environment:

   ::

       $ source <USER_CREDENTIALS_FILE>.sh

-  View the available command line options.

   ::

       $ openstack help

   ::

       $ openstack help <OPTION>

[79]

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
has been created). [80]

All Heat templates must began with defining the version of OpenStack is
was designed for (using the release date as the version) and enclose all
resources in a "resources" dictionary. The version indicates that all
features up until that specific release are used. This is for backwards
compatibility reasons.

::

    ---
    heat_template_version: 2017-02-24

    resources:

Valid Heat template versions include [81]:

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

::

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

::

    { get_resource: <OBJECT_NAME> }

Official examples of Heat templates can be found here:
https://github.com/openstack/heat-templates/tree/master/hot. Below is a
demonstration on how to create a virtual machine with public networking.

-  Create a network, assigned to the "internal\_network" object.

::

      internal_network:
        type: OS::Neutron::Net

-  Create a subnet for the created network. Required properties: network
   name or ID.

::

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

::

      subnet_port:
        type: OS::Neutron::Port
        properties:
          network: { get_resource: internal_network }
          fixed_ips:
            - subnet_id: { get_resource: internal_subnet }
          security_groups:
            - basic_allow

-  Create a router associated with the public "ext-net" network.

::

      external_router:
        type: OS::Neutron::Router
        properties:
          external_gateway_info:
            network: ext-net

-  Attach a port from the network to the router.

::

      external_router_interface:
        type: OS::Neutron::RouterInterface
        properties:
          router: { get_resource: external_router }
          subnet: { get_resource: internal_subnet }

-  Create a key pair called "HeatKeyPair." Required property: name.

::

      ssh_keys:
        type: OS::Nova::KeyPair
        properties:
          name: HeatKeyPair
          public_key: HeatKeyPair
          save_private_key: true

-  Create an instance using the "m1.small" flavor, "RHEL7" image, and
   assign the subnet port created by "OS::Neutron::Port."

::

      instance_creation:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: RHEL7
          networks:
            - port: { get_resource: subnet_port }

-  Allocate an IP from the "ext-net" floating IP pool.

::

      floating_ip:
        type: OS::Neutron::FloatingIP
        properties:
          floating_network: ext-net

-  Allocate a a floating IP to the created instance from a
   "instance\_creation" function. Alternatively, a specific instance's
   ID can be defined here.

::

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

::

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

::

    { get_param: <CUSTOM_NAME> }

[82]

Vagrant
~~~~~~~

Vagrant is a tool to automate the deployment of virtual machines. A
"Vagrantfile" file is used to initalize the instance. An example is
provided below.

::

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

::

    $ vagrant up --provider=openstack

[83]

Testing
-------

Tempest
~~~~~~~

Tempest is used to query all of the different APIs in use. This helps to
validate the functionality of OpenStack. This software is a rolling
release aimed towards verifying the latest OpenStack release in
development but it should also work for older versions as well.

The sample configuration file "/etc/tempest/tempest.conf.sample" should
be copied to "/etc/tempest/tempest.conf" and then modified. If it is not
available then the latest configuration file can be downloaded from one
of these sources: \*
http://docs.openstack.org/developer/tempest/sampleconf.html \*
http://docs.openstack.org/developer/tempest/\_static/tempest.conf.sample

-  Provide credentials to a user with the "admin" role.

   ::

       [auth]
       admin_username
       admin_password
       admin_project_name
       admin_domain_name
       default_credentials_domain_name = Default

-  Specify the Keystone version to use. Valid options are "v2" and "v3."

   ::

       [identity]
       auth_version

-  Provide the admin Keystone endpoint for v2 (uri) or v3 (uri\_v3).

   ::

       [identity]
       uri
       uri_v3

-  Two different size flavor IDs should be given.

   ::

       [compute]
       flavor_ref
       flavor_ref_alt

-  Two different image IDs should be given.

   ::

       [compute]
       image_ref
       image_ref_alt

-  Define what services should be tested for the specific cloud.

   ::

       [service_available]
       cinder = true
       neutron = true
       glance = true
       swift = false
       nova = true
       heat = false
       sahara = false
       ironic = false

[84]

Rally
~~~~~

Rally is the benchmark-as-a-service (BaaS) that tests the OpenStack APIs for both functionality and for helping with performance tuning. This tool has support for using different verifier plugins. It is primarily built to be a wrapper for Tempest that is easier to configure and saves the results to a database so it can generate reports.

Installation
^^^^^^^^^^^^

Install (RHEL):

::

    $ curl -L -o ~/install_rally.sh https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh
    $ sudo yum install gcc gmp-devel libffi-devel libxml2-devel libxslt-devel openssl-devel postgresql-devel python-devel python-pip redhat-lsb-core redhat-rpm-config wget
    $ bash ~/install_rally.sh --target ~/rally-venv

Rally can now be used by activating the Python virtual environment.

::

    $ . ~/rally-venv/bin/activate

Before the first use, finish the installation by creating the Rally SQLite database.

::

    (rally-venv)$ rally db recreate

If Rally is ever upgraded to the latest version, the database also needs to be upgraded.

::

    (rally-venv)$ rally db revision
    (rally-venv)$ rally db upgrade

[86]

Registering
^^^^^^^^^^^

Rally requires a configuration, that defines the OpenStack credentials to test with, is registered. It is recommended to use an account with the "admin" role so that all features of the cloud can be tested and benchmarked. As of June 3, 2017, the use of an "admin" user is no longer required. [89]

View registered deployments:

::

    (rally-venv)$ rally deployment list
    (rally-venv)$ rally deployment show <DEPLOYMENT_NAME>

`1.` Automatic

The fastest way to create this configuration is by referencing the OpenStack credential's shell environment variables.

::

    (rally-venv)$ . <OPENSTACK_RC_FILE>
    (rally-venv)$ rally deployment create --fromenv --name=existing

`2.` Manual

A JSON file can be created to define the OpenStack credentials that Rally be using. Example files can be found at `~/rally-venv/samples/deployments/`.

::

    (rally-venv)$ cp ~/rally-venv/samples/deployments/existing.json ~/existing.json

::

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

::

    (rally-venv)$ rally deployment create --file=~/existing.json --name=<DEPLOYMENT_NAME>

[87]

Scenarios
^^^^^^^^^

Scenarios define the tests that will be ran. Variables can be tweaked to customize them. All Rally scenario files are Jinja2 templates and can be in JSON or YAML format. Multiple scenarios can be setup in a single file for Rally to test them all.

Example scenarios:

::

    (rally-venv)$ ls -1 ~/rally-venv/samples/tasks/scenarios/*

Each scenario can be configured using similar options.

-  args = Override default values for a task.
-  context = Defines the resources that need to be created before a task runs.
-  runner [90]

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

::

    (rally-venv)$ rally task start <SCENARIO_FILE>.<JSON_OR_YAML>

[87]

Performance
-----------

OpenStack can be tuned to use less load and run faster.

-  KeyStone
-  Switch to Fernet keys.

   -  Creation of tokens is significantly faster because it does not rely on storing them in a database.
   -  Refer to `Configurations - Keystone - Token
      Provider <#configurations---keystone---token-provider>`__.

-  Neutron
-  Use distributed virtual routing (DVR).

   -  This offloads a lot of networking resources onto the compute
      nodes.

-  General
-  Utilize /etc/hosts.

   -  Ensure that all of your domain names (including the public
      domains) are listed in the /etc/hosts. This avoids a performance
      hit from DNS lookups. Alternatively, consider setting up a
      recursive DNS server on the controller nodes.

-  Use memcache.

   -  This is generally configured by an option called
      "memcache\_servers" in the configuration files for most services.
      Consider using "CouchBase" for it's ease of clustering and
      redundancy support.

Bibliography
------------

1. "OpenStack Releases." OpenStack Releases. October 4, 2017. Accessed October 4, 2017. https://releases.openstack.org/
2. "New OpenStack Ocata stabilizes popular open-source cloud." February 22, 2017. Accessed April 10, 2017. http://www.zdnet.com/article/new-openstack-ocata-stabilizes-popular-open-source-cloud/
3. "Ocata [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/ocata/index.html
4. "Pike [Goals]." OpenStack Documentation. April 10, 2017. Accessed April 10, 2017. https://governance.openstack.org/tc/goals/pike/index.html
5. "Queens [Goals]." OpenStack Documentation. September 26, 2017. Accessed October 4, 2017. https://governance.openstack.org/tc/goals/pike/index.html
6. "Red Hat OpenStack Platform Life Cycle." Red Hat Support. January 24, 2018. https://access.redhat.com/support/policy/updates/openstack/platform
7. "Frequently Asked Questions." RDO Project. Accessed December 21, 2017. https://www.rdoproject.org/rdo/faq/
8. "How can I determine which version of Red Hat Enterprise Linux - Openstack Platform (RHEL-OSP) I am using?" Red Hat Articles. May 20, 2016. Accessed December 19, 2017. https://access.redhat.com/articles/1250803
9. "Director Installation and Usage." Red Hat OpenStack Platform 10 Documentation. November 23, 2017. Accessed December 22, 2017. https://access.redhat.com/documentation/en-us/red\_hat\_openstack\_platform/10/pdf/director\_installation\_and\_usage/Red\_Hat\_OpenStack\_Platform-10-Director\_Installation\_and\_Usage-en-US.pdf
10. "Project Navigator." OpenStack. Accessed May 14, 2017. https://www.openstack.org/software/project-navigator/
11. "All-in-one quickstart: Proof of concept for single node." RDO Project. Accessed April 3, 2017. https://www.rdoproject.org/install/quickstart/
12. "Neutron with existing external network. RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/networking/neutron-with-existing-external-network/
13. "Error while installing openstack 'newton' using rdo packstack." Ask OpenStack. October 25, 2016. Accessed September 28, 2017. https://ask.openstack.org/en/question/97645/error-while-installing-openstack-newton-using-rdo-packstack/
14. "CHAPTER 5. REMOVING PACKSTACK DEPLOYMENTS." Red Hat Documentation. Accessed November 6, 2017. https://access.redhat.com/documentation/en-US/Red\_Hat\_Enterprise\_Linux\_OpenStack\_Platform/6/html/Deploying\_OpenStack\_Proof\_of\_Concept\_Environments/chap-Removing\_Packstack\_Deployments.html
15. "OpenStack-Ansible." GitHub. March 30, 2017. Accessed August 25, 2017. https://github.com/openstack/openstack-ansible
16. "Quick Start." OpenStack-Ansible Developer Documentation. March 29, 2017. Accessed March 30, 2017. http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html
17. "Quick Start." OpenStack-Ansible Developer Documentation. March 30, 2017. Accessed March 31, 2017. http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html
18. "Quick Start." OpenStack-Ansible Developer Documentation. March 29, 2017. Accessed March 30, 2017. http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html
19. "[OpenStack-Ansible Project Deploy Guide] Overview." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/project-deploy-guide/openstack-ansible/ocata/overview.html
20. "[OpenStack-Ansible Project Deploy Guide] Overview." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/project-deploy-guide/openstack-ansible/ocata/overview.html
21. "Nova role for OpenStack-Ansible." OpenStack Documentation. April 7, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-os\_nova/ocata/
22. "openstack ansible ceph." OpenStack FAQ. April 9, 2017. Accessed April 9, 2017. https://www.openstackfaq.com/openstack-ansible-ceph/
23. "Configuring the Ceph client (optional)." OpenStack Documentation. April 5, 2017. Accessed April 9, 2017. https://docs.openstack.org/developer/openstack-ansible-ceph\_client/configure-ceph.html
24. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017. https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html
25. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. May 31, 2017. Accessed May 31, 2017. https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/index.html
26. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017. https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html
27. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017. https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html
28. "[OpenStack-Ansible] Operations guide." OpenStack Documentation. March 29, 2017. Accessed March 30, 2017. https://docs.openstack.org/developer/openstack-ansible/draft-operations-guide/index.html
29. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. May 31, 2017. Accessed May 31, 2017. https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/index.html
30. "[OpenStack-Ansible] Upgrade Guide." OpenStack Documentation. April 21, 2017. Accessed April 23, 2017. https://docs.openstack.org/developer/openstack-ansible/ocata/upgrade-guide/index.html
31. "tripleo-quickstart." TripleO-Quickstart GitHub. January 10, 2017. Accessed January 15, 2017. https://github.com/openstack/tripleo-quickstart
32. "TripleO quickstart." RDO Project. Accessed August 16, 2017. https://www.rdoproject.org/tripleo/
33. "TripleO quickstart." RDO Project. Accessed August 16, 2017. https://www.rdoproject.org/tripleo/
34. "[TripleO] Minimum System Requirements." TripleO Documentation. Accessed August 16, 2017. https://images.rdoproject.org/docs/baremetal/requirements.html
35. [RDO] Recommended hardware." RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/hardware/recommended/
36. "[TripleO] Virtual Environment." TripleO Documentation. Accessed September 28, 2017. http://tripleo-docs.readthedocs.io/en/latest/environments/virtual.html
37. "Getting started with TripleO-Quickstart." OpenStack Documentation. Accessed December 20, 2017. https://docs.openstack.org/tripleo-quickstart/latest/getting-started.html
38. "TripleO Documentation." OpenStack Documentation. Accessed September 12, 2017. https://docs.openstack.org/tripleo-docs/latest/
39. "Basic Deployment (CLI)." OpenStack Documentation. Accessed November 9, 2017. https://docs.openstack.org/tripleo-docs/latest/install/basic\_deployment/basic\_deployment\_cli.html
40. "Bug 1466744 - Include docker.yaml and docker-ha.yaml environment files by default." Red Hat Bugzilla. December 13, 2017. Accessed January 12, 2018. https://bugzilla.redhat.com/show_bug.cgi?id=1466744
41. "DevStack switching from MySQL-python to PyMySQL." OpenStack nimeyo. June 9, 2015. Accessed October 15, 2016. https://openstack.nimeyo.com/48230/openstack-all-devstack-switching-from-mysql-python-pymysql
42. "Using PostgreSQL with OpenStack." FREE AND OPEN SOURCE SOFTWARE KNOWLEDGE BASE. June 06, 2014. Accessed October 15, 2016. https://fosskb.in/2014/06/06/using-postgresql-with-openstack/
43. "Install and configure [Ceilometer] for Red Hat Enterprise Linux and CentOS." OpenStack Documentation. March 24, 2017. Accessed April 3, 2017. https://docs.openstack.org/project-install-guide/telemetry/ocata/install-base-rdo.html
44. "Liberty install guide RHEL, keystone DB population unsuccessful: Module pymysql not found." OpenStack Manuals Bugs. March 24, 2017. Accessed April 3, 2017. https://bugs.launchpad.net/openstack-manuals/+bug/1501991
45. "Message queue." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/environment-messaging.html
46. "RPC messaging configurations." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/common-configurations/rpc.html
47. "ZeroMQ Driver Deployment Guide." OpenStack Documentation. January 22, 2018. Accessed January 24, 2018. https://docs.openstack.org/oslo.messaging/latest/admin/zmq_driver.html
48. "Newton Series Release Notes." OpenStack Documentation. Accessed February 18, 2017. http://docs.openstack.org/releasenotes/keystone/newton.html
49. "Setting up an RDO deployment to be Identity V3 Only." Young Logic. May 8, 2015. Accessed October 16, 2016. https://adam.younglogic.com/2015/05/rdo-v3-only/
50. "Installa and configure [Keystone on RDO]." OpenStack Documentation. October 11, 2017. Accessed January 24, 2018. https://docs.openstack.org/keystone/latest/install/keystone-install-rdo.html
51. "OpenStack Keystone Fernet tokens." Dolph Mathews. Accessed August 27th, 2016. http://dolphm.com/openstack-keystone-fernet-tokens/
52. "Ocata Series [Keystone] Release Notes." OpenStack Documentation. Accessed April 3, 2017. https://docs.openstack.org/releasenotes/keystone/ocata.html
53. "Install and configure [Keystone]." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/keystone-install.html
54. "Hypervisors." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisors.html
55. "KVM." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisor-kvm.html
56. "Xen." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisor-xen-libvirt.html
57. "LXC (Linux containers)." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/compute/hypervisor-lxc.html
58. "Driving in the Fast Lane – CPU Pinning and NUMA Topology Awareness in OpenStack Compute." Red Hat Stack. Mary 5, 2015. Accessed April 13, 2017. http://redhatstackblog.redhat.com/2015/05/05/cpu-pinning-and-numa-topology-awareness-in-openstack-compute/
59. "OpenStack Administrator Guide SUSE OpenStack Cloud 7." SUSE Documentation. February 22, 2017. Accessed April 13, 2017. https://www.suse.com/documentation/suse-openstack-cloud-7/pdfdoc/book\_cloud\_admin/book\_cloud\_admin.pdf
60. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack
61. "Nested Virtualization in OpenStack, Part 2." Stratoscale. June 28, 2016. Accessed November 9, 2017. https://www.stratoscale.com/blog/openstack/nested-virtualization-openstack-part-2/
62. "[RDO Nova Installation] Overview." OpenStack Documentation. October 28, 2017. Accessed November 6, 2017. https://docs.openstack.org/nova/pike/install/overview.html
63. "Open vSwitch: Self-service networks." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/networking-guide/deploy-ovs-selfservice.html
64. "[Installing the] Networking service." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/install-guide-rdo/neutron.html
65. "Name resolution for instances." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/networking-guide/config-dns-res.html
66. "Introduction of Metadata Service in OpenStack." VietStack. September 09, 2014. Accessed August 13th, 2016. https://vietstack.wordpress.com/2014/09/27/introduction-of-metadata-service-in-openstack/
67. "Load Balancer as a Service (LBaaS)." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. http://docs.openstack.org/draft/networking-guide/config-lbaas.html
68. "Quality of Service (QoS)." OpenStack Documentation. October 10, 2016. Accessed October 16, 2016. http://docs.openstack.org/draft/networking-guide/config-qos.html
69. "Neutron/DVR/HowTo" OpenStack Wiki. January 5, 2017. Accessed March 7, 2017. https://wiki.openstack.org/wiki/Neutron/DVR/HowTo
70. "Distributed Virtual Routing with VRRP." OpenStack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/networking-guide/config-dvr-ha-snat.html
71. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
72. "[Glance] Basic Configuration." OpenStack Documentation. April 5, 2017. Accessed April 5, 2017. https://docs.openstack.org/developer/glance/configuring.html
73. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack
74. "Volume encryption supported by the key manager" Openstack Documentation. April 3, 2017. Accessed April 3, 2017. https://docs.openstack.org/ocata/config-reference/block-storage/volume-encryption.html
75. "BLOCK DEVICES AND OPENSTACK." Ceph Documentation. April 5, 2017. Accessed April 5, 2017. http://docs.ceph.com/docs/master/rbd/rbd-openstack/
76. "Adding additional NAT rule on neutron-l3-agent." Ask OpenStack. February 15, 2015. Accessed February 23, 2017. https://ask.openstack.org/en/question/60829/adding-additional-nat-rule-on-neutron-l3-agent/
77. "Networking in too much detail." RDO Project. January 9, 2017. Accessed February 23, 2017. https://www.rdoproject.org/networking/networking-in-too-much-detail/
78. "Upgrades." OpenStack Documentation. January 15, 2017. Accessed January 15, 2017. http://docs.openstack.org/ops-guide/ops-upgrades.html
79. "OpenStack Command Line." OpenStack Documentation. Accessed October 16, 2016. http://docs.openstack.org/developer/python-openstackclient/man/openstack.html
80. "OpenStack Orchestration In Depth, Part I: Introduction to Heat." Accessed September 24, 2016. November 7, 2014. https://developer.rackspace.com/blog/openstack-orchestration-in-depth-part-1-introduction-to-heat/
81. "Heat Orchestration Template (HOT) specification." OpenStack Documentation. November 17, 2017. Accessed November 17, 2017. https://docs.openstack.org/heat/latest/template\_guide/hot\_spec.html
82. "Heat Orchestration Template (HOT) specification." OpenStack Developer Documentation. October 21, 2016. Accessed October 22, 2016. http://docs.openstack.org/developer/heat/template\_guide/hot\_spec.html
83. "Vagrant OpenStack Cloud Provider." GitHub - ggiamarchi. January 30, 2017. Accessed April 3, 2017. https://github.com/ggiamarchi/vagrant-openstack-provider
84. "Tempest Configuration Guide." Sep 14th, 2016. http://docs.openstack.org/developer/tempest/configuration.html
85. "Stable branches." OpenStack Documentation. December 12, 2017. Accessed January 24, 2018. https://docs.openstack.org/project-team-guide/stable-branches.html
86. "[Rally] Installation and upgrades." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/install_and_upgrade/index.html
87. "[Rally] Quick start." Rally Documentation. Accessed January 25, 2018. https://rally.readthedocs.io/en/latest/quick_start/index.html
88. "Step 3. Benchmarking OpenStack with existing users." OpenStack Documentation. July 3, 2017. Accessed January 25, 2018. https://docs.openstack.org/developer/rally/quick_start/tutorial/step_3_benchmarking_with_existing_users.html
89. "Allow deployment without admin creds." OpenStack Gerrit Code Review. June 3, 2017. Accessed January 25, 2018. https://review.openstack.org/#/c/465495/
90. "Main concepts of Rally." OpenStack Documentation. July 3, 2017. Accessed January 26, 2018. https://docs.openstack.org/developer/rally/miscellaneous/concepts.html
