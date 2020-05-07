TripleO
=======

.. contents:: Table of Contents

Introduction
------------

Supported operating systems: RHEL/CentOS >= 7, Fedora

TripleO means "OpenStack on OpenStack." The Undercloud is first deployed onto a single node with the essential OpenStack services to handle baremetal deployments. That server is then used to create and manage a full production cloud called the Overcloud.

TripleO is a collection of many services. As part of the Transformation Squad's goal, Undercloud services are being removed and/or refactored to provide a simpler deployment tool. These are the services that are used on the Undercloud [52]:

.. csv-table::
   :header: Service, Removed In, Replaced By, Description
   :widths: 20, 20, 20, 20

   Ansible, "", "", Used for deploying the Undercloud and Overcloud services.
   Ceilometer, Stein, "", Collects information about the Overcloud nodes.
   docker, Ussuri, Podman, Container runtime for OpenStack services.
   Glance, "", "", Image management used by Ironic.
   Gnocchi, Stein, "", A more efficient alternative to Ceilometer.
   Heat, "", "", Heat parameters define the deployment settings.
   Horizon, "Stein", "", Web dashboard for deploying an Overcloud.
   Ironic, "", "", Manages the bare-metal provisioning.
   Keystone, "", "", Authentication of OpenStack services.
   Kolla, "", "", Provides container images of OpenStack services.
   MariaDB, "", "", Database for OpenStack services.
   Mistral, "", "", Workflows are used to define and execute all of the deployment processes.
   Neutron, "", "", Manages the Overcloud networks.
   Nova, "", "", Manages the Overcloud nodes after provisioning.
   Paunch, "", "", Container state management.
   Podman, "", "", Container runtime for OpenStack services.
   Puppet, "", "", Configuration management.
   RabbitMQ, "", "", Messaging back-end for OpenStack services.
   Zaqar, "", "", A messaging service used by Mistral.

In Pike, most of the Overcloud services are deployed as containers built by Kolla. The most notable service that lacked container support was Neutron due to it's complexity. Starting in Queens, all of the Overcloud services are installed as containers. Support for also running the Undercloud services in containers was added as a technology preview in Queens and later became the default configuration for Rocky. Previously, `instack-undercloud <https://opendev.org/openstack/instack-undercloud>`__ was used to setup and install the Undercloud services and now the same deployment method for the Overcloud is used for the Undercloud. [20]

Red Hat OpenStack Platform Releases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Red Hat provides most of the development to the core OpenStack services.
The RPM Distribution of OpenStack (RDO) project is a community project
lead by Red Hat to use the latest upstream code from OpenStack and
package it to work and be distributable on Red Hat Enterprise Linux and
Fedora based operating systems. [2]

The Red Hat OpenStack Platform (RHOSP) is a solution by Red Hat that
takes the upstream OpenStack source code and makes it enterprise quality
by hardening the security and increasing it's stability. Upgrades from one major release of RHOSP to the next have been supported since RHOSP 8.

Release Cycle:

-  RHOSP < 10 = Each release is supported for up to 3 years.
-  RHOSP >= 10 = Starting with RHOSP 10, every third release of RHOSP is a long-life (LL) release with up to 5 years of support. In-between releases are supported for 1 year. Fast-forward upgrades are supported to upgrade directly from one LL release to the next (for example, 10 to 13).
-  RHOSP >= 16 = Every release of RHOSP is now a LL release. [43]

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

-  RHOSP 14 (Rocky)

   -  Release: 2019-01-10
   -  EOL: 2020-01-10

-  RHOSP 15 (Stein)

   -  Release: 2019-09-19
   -  EOL: 2020-09-19

-  **RHOSP 16 LL (Train)**

   -  Release: 2020-02-06
   -  EOL: 2025-02-06

[1]

RHOSP supports running a virtualized Undercloud on these platforms [3]:

-  Kernel-based Virtual Machine (QEMU with KVM acceleration)
-  Red Hat Virtualization (RHV)
-  Microsoft Hyper-V
-  VMWare ESX and ESXi

RHOSP only supports using libvirt with KVM as the compute hypervisor's virtualization technology. [28]

The version of RHOSP in use can be found on the Undercloud by viewing the "/etc/rhosp-release" file. OpenStack packages can also be tracked down to which major release it is a part of by using https://access.redhat.com/downloads/content/package-browser.


.. code-block:: sh

    $ yum install rhosp-release
    $ cat /etc/rhosp-release
    Red Hat OpenStack Platform release 16.0.1 (Train)

Historical Milestones
---------------------

Upstream
~~~~~~~~

-  Havana

   -  `The first release of Spinal Stack. <https://spinal-stack.readthedocs.io/en/latest/changelog/havana/index.html>`__

-  Icehouse

   -  `The last release of Spinal Stack before it was rebranded to TripleO (OpenStack-on-OpenStack) for the Juno release. <https://spinal-stack.readthedocs.io/en/latest/changelog/icehouse/index.html>`__

-  Mitaka

   -  `Introduced the TripleO UI dashboard for helping to deploy an Overcloud. <https://specs.openstack.org/openstack/tripleo-specs/specs/mitaka/tripleo-ui.html>`__

-  Ocata

   -  `OpenStack services on the Overcloud are containerized using containers built by Kolla (except for Cinder, Manila, and Neutron). <https://specs.openstack.org/openstack/tripleo-specs/specs/ocata/containerize-tripleo-overcloud.html>`__

-  Pike

   -  config-download (Ansible content) was created as an alternative to Heat for deploying the OpenStack services on the Overcloud.

-  Queens

   -  `Introduced Fast Forward Upgrades (FFUs). The first supported FFU is from Newton straight to Queens. <https://specs.openstack.org/openstack/tripleo-specs/specs/queens/fast-forward-upgrades.html>`__
   -  All OpenStack services on the Overcloud have been containerized.
   -  Experimental support for using containerized OpenStack services on the Undercloud.

-  Rocky

   -  instack-undercloud is no longer used for installing the Undercloud. The Undercloud now reuses the same workflows used by the Overcloud deploy, update, and upgrade process.
   -  Undercloud services are now containerized by default.
   -  `config-download is now the default deployment method. <https://blueprints.launchpad.net/tripleo/+spec/config-download-default>`__
   -  config-download now supports using ceph-ansible for managing Ceph clusters.
   -  `Introduced Standalone deployments (an all-in-one Overcloud that does not require an Undercloud). <https://blueprints.launchpad.net/tripleo/+spec/all-in-one>`__
   -  Deprecated the TripleO UI.

-  Stein

   -  `Container management can now use podman instead of docker. <https://specs.openstack.org/openstack/tripleo-specs/specs/stein/podman.html>`__
   -  `Removed the TripleO UI. <https://docs.openstack.org/tripleo-docs/latest/install/deprecated/basic_deployment_ui.html>`__

-  Train

   -  Fast Forward Upgrade from Queens to Train.
   -  `The first upstream release to support CentOS 8. <https://blogs.rdoproject.org/2019/10/rdo-centos-stream/>`__
   -  `Minion node support for scaling the Undercloud resources for Heat and Ironic. <https://specs.openstack.org/openstack/tripleo-specs/specs/train/undercloud-minion.html>`__

-  Ussuri (work-in-progress)

   -  `Replaced Paunch with Ansible for container management. <https://review.opendev.org/#/c/700738/>`__
   -  `Removed Undercloud dependencies on Glance, Neutron, and Nova by having a Nova-less deployment process. <https://blueprints.launchpad.net/tripleo/+spec/nova-less-deploy>`__ `MetalSmith <https://github.com/openstack/metalsmith>`__ can now used to provision the Overcloud nodes separately from the Overcloud deployment. TripleO treats all deployments as pre-deployed servers.
   -  `Removed Mistral and Zaqar from the Undercloud. The Overcloud deployment workflow now uses Ansible. <https://specs.openstack.org/openstack/tripleo-specs/specs/ussuri/mistral-to-ansible.html>`__
   -  `Provided standardized Ansible playbooks and roles for operators to manage their TripleO clouds. <https://specs.openstack.org/openstack/tripleo-specs/specs/ussuri/tripleo-operator-ansible.html>`__

[57][58]

Downstream
~~~~~~~~~~

-  RHOSP 2

   -  `The first OpenStack product released by Red Hat. <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_OpenStack_Platform/2/html/Release_Notes/index.html>`__

-  RHOSP 3

   -  The first RHOSP release to include the `Foreman OpenStack Manager <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_OpenStack_Platform/3/html/Deployment_Guide_Foreman_Technology_Preview/index.html>`__ to automate the deployment of servers and installation of OpenStack services.
   -  This was the first RHOSP release to have official support.

-  RHOSP 5

   -  `Introduced Packstack as an easy way to deploy a single-node proof-of-concept cloud using Puppet. <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_OpenStack_Platform/5/html/Getting_Started_Guide/index.html>`__.
   -  `The first release to support RHEL 7 <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_OpenStack_Platform/5/html/Technical_Notes/index.html>`__.
   -  `Red Hat acquired eNovance, the company that created TripleO (previously named Spinal Stack), in June of 2014. <https://www.redhat.com/en/about/press-releases/red-hat-acquire-enovance-leader-openstack-integration-services>`__

-  RHOSP 6

   -  `Introduced TripleO as another proof-of-concept deployment tool. It uses an all-in-one OpenStack cloud (the Undercloud) to deploy a production cloud (the Overcloud). <https://access.redhat.com/articles/1320563>`__

-  RHOSP 7

   -  `TripleO, now known as Director downstream and temporarily renamed to the RDO Manager upstream, replaces the Foreman OpenStack Manager as the deployment tool. <https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_openstack_platform/7/html/director_installation_and_usage/index>`__

-  RHOSP 8

   -  `Automated minor updates and major upgrades. <https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/8/html/upgrading_red_hat_openstack_platform/index>`__

-  RHOSP 10

   -  The first long-life release to receive up to 5 years of support.

-  RHOSP 13

   -  RHOSP's second long-life release.
   -  Introduced Fast Forward Upgrade path from RHOSP 10 to 13.

-  RHOSP 14

   -  The TripleO UI has been deprecated.

-  RHOSP 15

   -  The first release to support RHEL 8.
   -  `Telemetry services (aodh, ceilometer, and gnocchi) are deprecated in favor of the Red Hat Service Assurance Framework. <https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/15/html-single/release_notes/index#deprecated_functionality>`__

-  RHOSP 16

   -  RHOSP's third long-life release.
   -  Introduced Fast Forward Upgrade path from RHOSP 13 to 16.

[1]

Repositories
------------

Upstream
~~~~~~~~

The upstream TripleO project has three main repositories for each OpenStack release:

.. csv-table::
   :header: Name and Aliases, Testing Level, Use Case
   :widths: 20, 20, 20

   "General Availability (GA), Release, or Tested", High, Production
   "Testing, Test, or Buildlogs", Medium, Pre-production
   "Trunk, Current, Consistent, or Untested", Low, Development

If installing on RHEL, it is required to enable additional repositories [40]:

   -  RHEL 7:

      .. code-block:: sh

         $ sudo subscription-manager repos --enable rhel-7-server-rpms --enable rhel-7-server-rh-common-rpms --enable rhel-7-server-extras-rpms

-  **GA**:

   -  CentOS:

      .. code-block:: sh

         $ sudo yum install centos-release-openstack-${OPENSTACK_RELEASE}

   -  RHEL:

      .. code-block:: sh

        $ sudo yum install https://repos.fedorapeople.org/repos/openstack/openstack-${OPENSTACK_RELEASE}/rdo-release-${OPENSTACK_RELEASE}-${RDO_RPM_RELEASE}.noarch.rpm

-  **Testing**

   -  CentOS:

      .. code-block:: sh

         $ sudo yum install centos-release-openstack-${OPENSTACK_RELEASE}
         $ sudo yum-config-manager --enable centos-openstack-${OPENSTACK_RELEASE}-test

   -  RHEL:

      .. code-block:: sh

        $ sudo yum install https://repos.fedorapeople.org/repos/openstack/openstack-${OPENSTACK_RELEASE}/rdo-release-${OPENSTACK_RELEASE}-${RDO_RPM_RELEASE}.noarch.rpm
        $ sudo yum-config-manager --enable openstack-${OPENSTACK_RELEASE}-testing

-  **Trunk**

   -  Trunk builds are divided into three different categories [54]:

      -  current = The latest successfully built packages from every individual RDO and OpenStack project.
      -  consistent = A snapshot of the last current build when all of the packages were successfully built.
      -  current-tripleo-rdo = A snapshot of the last consistent build that passed all of the `CI promotion jobs <https://ci.centos.org/view/rdo/view/promotion-pipeline/job/rdo_trunk-promote-train-current-tripleo/>`__. This is also known as current-passed-ci.

   -  RDO repository (current-tripleo-rdo):

      .. code-block:: sh

        $ sudo yum install https://repos.fedorapeople.org/repos/openstack/openstack-${OPENSTACK_RELEASE}/rdo-release-${OPENSTACK_RELEASE}-${RDO_RPM_RELEASE}.noarch.rpm
        $ sudo yum-config-manager --enable rdo-trunk-${OPENSTACK_RELEASE}-tested

   -  Or ``tripleo-repos`` [22]:

      .. code-block:: sh

          $ sudo yum install "https://trunk.rdoproject.org/centos7/current/$(curl -k https://trunk.rdoproject.org/centos7/current/ | grep python2-tripleo-repos- | cut -d\" -f8)"
          $ sudo tripleo-repos -b ${OPENSTACK_RELEASE} current-tripleo-rdo

   -  Or manually:

      .. code-block:: sh

          $ sudo curl -L -o /etc/yum.repos.d/delorean-${OPENSTACK_RELEASE}.repo https://trunk.rdoproject.org/centos7-${OPENSTACK_RELEASE}/current-tripleo-rdo/delorean.repo
          $ sudo curl -L -o /etc/yum.repos.d/delorean-deps-${OPENSTACK_RELEASE}.repo https://trunk.rdoproject.org/centos7-${OPENSTACK_RELEASE}/delorean-deps.repo

   -  Create a container image prepare file that uses the ``current-tripleo`` (default) or ``current-tripleo-rdo`` tag. Configure the ``undercloud.conf`` to use this file via the ``container_images_file`` parameter. Configure the Overcloud to use it by adding it as another Heat environment template: ``openstack overcloud deploy --templates -e ~/containers-prepare-parameters.yaml``.

      .. code-block:: sh

         $ openstack tripleo container image prepare default --output-env-file ~/containers-prepare-parameters.yaml
         $ ${EDITOR} ~/containers-prepare-parameters.yaml

      .. code-block:: yaml

         ---
         parameter_defaults:
           ContainerImagePrepare:
              - set:
                  tag: current-tripleo-rdo

[53]

Downstream
~~~~~~~~~~

It is recommended to disable any existing repositories to avoid package conflicts.

.. code-block:: sh

   $ sudo subscription-manager repos --disable=*

-  RHOSP 10 [26]:

   .. code-block:: sh

       $ sudo subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms --enable=rhel-ha-for-rhel-7-server-rpms --enable=rhel-7-server-nfv-rpms --enable=rhel-7-server-rhceph-2-tools-rpms --enable=rhel-7-server-rhceph-2-mon-rpms --enable=rhel-7-server-rhceph-2-osd-rpms --enable=rhel-7-server-openstack-10-rpms

-  RHOSP 13 [27]:

   .. code-block:: sh

       $ sudo subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms --enable=rhel-ha-for-rhel-7-server-rpms --enable=rhel-7-server-nfv-rpms --enable=rhel-7-server-rhceph-3-tools-rpms --enable=rhel-7-server-rhceph-3-mon-rpms --enable=rhel-7-server-rhceph-3-osd-rpms --enable=rhel-7-server-openstack-13-rpms

-  RHOSP 16 [55]:

   .. code-block:: sh

       $ sudo subscription-manager repos --enable=rhel-8-for-x86_64-baseos-rpms --enable=rhel-8-for-x86_64-appstream-rpms --enable=rhel-8-for-x86_64-highavailability-rpms --enable=ansible-2.8-for-rhel-8-x86_64-rpms --enable=openstack-16-for-rhel-8-x86_64-rpms --enable=fast-datapath-for-rhel-8-x86_64-rpms

Deployment (Quick)
------------------

Packstack
~~~~~~~~~

Supported operating system: RHEL/CentOS 7, Fedora

Packstack is part of Red Hat's RDO project. It's purpose is for
providing small and simple demonstrations of OpenStack. This tool does
not handle any upgrades of the OpenStack services.

Hardware requirements [9]:

-  16GB RAM

Install
^^^^^^^

Disable NetworkManager. It is not compatible with Packstack.

.. code-block:: sh

    $ sudo systemctl disable NetworkManager

Install the Packstack utility.

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
By default, the network will be entirely isolated. [4]

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

[5][90]

Answer File
^^^^^^^^^^^

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
   configuration file [6]:

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

TripleO Quickstart
~~~~~~~~~~~~~~~~~~

The TripleO Quickstart project was created to use Ansible to automate deploying a TripleO Undercloud and Overcloud. [7] The project recommends a minimum of 32GB RAM and 120GB of disk space when deploying with the default settings. [9] This deployment has to use a baremetal hypervisor. Deploying TripleO within a virtual machine that uses nested virtualization is not supported. [10]

-  Download the tripleo-quickstart script or clone the entire repository
   from OpenDev or GitHub.

   .. code-block:: sh

       $ curl -O https://opendev.org/openstack/tripleo-quickstart/raw/branch/master/quickstart.sh

   OR

   .. code-block:: sh

       $ git clone https://opendev.org/openstack/tripleo-quickstart.git
       $ cd tripleo-quickstart

-  Install dependencies for the quickstart script.

   .. code-block:: sh

       $ sudo bash quickstart.sh --install-deps

TripleO can now be installed automatically with the default setup of 3
virtual machines. This will be created to meet the minimum TripleO cloud
requirements: (1) an Undercloud to deploy a (2) controller and (3)
compute node. [8] . Otherwise, a different node configuration from
"config/nodes/" can be specified or created.

Common node variables:

-  {block\|ceph\|compute\|control\|default\|objectstorage\|undercloud}\_{memory\|vcpu}
   = Define the amount of processor cores or RAM (in megabytes) to
   allocate to the respective virtual machine type. Use "default" to
   apply to all nodes that are not explicitly defined.

Further customizations should be configured now before deploying the
TripleO environment. Refer to the `Undercloud Deploy role's
documentation <https://opendev.org/openstack/tripleo-quickstart-extras/src/branch/master/roles/undercloud-deploy/README.md>`__
on all of the Ansible variables for the Undercloud. Add any override
variables to a YAML file and then add the arguments
``-e @<VARIABLE_FILE>.yaml`` to the "quickstart.sh" commands.

``1.`` Automatic

-  Run the quickstart script to install TripleO. Use "127.0.0.2" for the
   localhost IP address if TripleO will be installed on the same system
   that the quickstart command is running on.

   .. code-block:: sh

       $ bash quickstart.sh --release trunk/queens --tags all <REMOTE_HYPERVISOR_IP>

[7]

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
     releases can be found in the OpenDev or GitHub project in the
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
   - ``-v`` = Show verbose output from the Ansible playbooks.
   - ``--config=~/.quickstart/config/general_config/containers_minimal.yml`` = Deploy the Overcloud from Kolla docker containers. [20]

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

[11]

Standalone Containers
~~~~~~~~~~~~~~~~~~~~~

Requirements:

-  4 CPU cores
-  8GB RAM
-  50GB storage

Starting with Rocky, an all-in-one cloud can be deployed without the need of an Undercloud. This is known as a Standalone deployment and it is almost exactly the same as an Undercloud deployment. It deploys a fully functional Overcloud onto the local server. Unlike a typical Overcloud deployment, Mistral is not used. Instructions on how to setup a Standalone cloud are documented `here <https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/standalone.html>`__.

After the installation, the config-download Ansible playbooks will be available in the home directory as ``undercloud-ansible-<UUID>``. The Standalone deployment does not support being scaled out and is designed specifically for developers as an alternative to `devstack <https://docs.openstack.org/devstack/latest/>`__.

**Updates**

These steps apply to both Undercloud and Standalone cloud deployments.

-  Update:

   .. code-block:: sh

      $ openstack {undercloud install|tripleo deploy} --force-stack-update

-  Upgrade:

   .. code-block:: sh

      $ openstack {undercloud|tripleo} upgrade

-  Reinstall:

   .. code-block:: sh

      $ openstack {undercloud install|tripleo deploy}  --force-stack-create

[48]

InfraRed 2
~~~~~~~~~~

InfraRed uses Ansible playbooks to automate deploying downstream RHOSP packages and upstream RDO packages.

Install InfraRed into a Python 2 virtual environment.

.. code-block:: shell

   $ virtualenv ~/venv_infrared
   $ source ~/venv_infrared/bin/activate
   $ git clone https://github.com/redhat-openstack/infrared.git
   $ cd infrared
   $ pip2 install --user .

As of 2019, these are the officially supported plugins in InfraRed.

-  provision

   -  beaker
   -  docker
   -  foreman
   -  openstack
   -  virsh

-  install

   -  build-packages
   -  cloud-config
   -  containers-sanity
   -  install-ceph
   -  oooq
   -  packstack
   -  patch-components
   -  tripleo-overcloud
   -  tripleo-standalone
   -  tripleo-undercloud

-  test

   -  browbeat
   -  bzaf
   -  gabbi
   -  jordan
   -  openstack-coverage
   -  ospdui
   -  pytest-runner
   -  rally
   -  robot
   -  tempest
   -  tripleo-config-changes
   -  tripleo-post-tests

-  other

   -  collect-logs
   -  dellemc-idrac
   -  list-builds

Use the ``infrared plugin search`` command to view the GitHub URL of each plugin. Then use ``infrared plugin add <GITHUB_URL>`` to install the plugin.

Alternatively, install plugins from the working directory of the ``infrared`` repository.

Install a provision plugin, such as virsh, along with the required plugins for deploying and managing a TripleO cloud.

.. code-block:: shell

   $ infrared plugin add plugins/virsh
   $ infrared plugin add plugins/tripleo-undercloud
   $ infrared plugin add plugins/tripleo-overcloud
   $ infrared plugin add plugins/cloud-config

-  Optionally create an answers file manually or by using the CLI and then import it. Otherwise, use the CLI arguments.

   .. code-block:: shell

      $ infrared virsh --from-file=virsh_prov.ini

-  [virsh]

   -  **host-address** = Required argument. Edit with any value, OR override with CLI: --host-address=<option>
   -  host-memory-overcommit = Default: ``False``.
   -  **host-key** = Required argument. Edit with any value, OR override with CLI: --host-key=<option>
   -  host-user = Default: ``root``.
   -  **topology-nodes** = The number of each node to deploy.

      -  Minimal: ``"ovb_undercloud:1,controller:1,compute:1"``.
      -  Minimal with OpenStack Virtual Baremetal (OVB) support for provisioning: ``"ovb_undercloud:1,ovb_controller:1,ovb_compute:1"``.

-  Deploy the virtual machines that will be used by the lab.

   -  Virsh provisioner:

      .. code-block:: sh

         $ infrared virsh --host-address 127.0.0.1 --host-key ~/.ssh/id_rsa --host-memory-overcommit yes --topology-nodes "ovb_undercloud:1,controller:1,compute:1"

   -  OpenStack provisioner:

      .. code-block:: sh

         $ infrared openstack --cloud ${OS_CLOUD} --prefix <OPTIONAL_RESOURCE_PREFIX> --key-file ~/.ssh/id_rsa --topology-network 3_nets_ovb --topology-nodes "ovb_undercloud:1,ovb_controller:1,ovb_compute:1" --anti-spoofing False --dns <DNS1>,<DNS2> --provider-network <EXTERNAL_PROVIDER_NETWORK> --image <RHEL_OR_CENTOS> --username <SSH_USER>

   -  An Ansible inventory of the hosts will be generated here: ``~/.infrared/.workspaces/active/hosts``.

-  Deploy the Undercloud.

   -  RHOSP:

      .. code-block:: sh

         $ RHOSP_VERSION=16
         $ infrared tripleo-undercloud --version ${RHOSP_VERSION} --build ${PUDDLE_VERSION} --images-task rpm --ntp-server clock.redhat.com,clock2.redhat.com

   -  RDO:

      .. code-block:: sh

         $ RDO_VERSION=train
         $ infrared tripleo-undercloud --version ${RDO_VERSION} --images-task=import --images-url=https://images.rdoproject.org/${RDO_VERSION}/rdo_trunk/current-tripleo/stable/

-  Deploy the Overcloud.

   .. code-block:: sh

      $ infrared tripleo-overcloud --deployment-files virt --version ${RDO_VERSION} --introspect yes --tagging yes --deploy yes

-  After the Overcloud is deployed, optionally configure resources on it.

   .. code-block:: sh

      $ infrared cloud-config --deployment-files virt --tasks create_external_network,forward_overcloud_dashboard,network_time,tempest_deployer_input

[35]

Deployment (Full)
-----------------

Minimum recommended requirements [8]:

-  Undercloud node:

   -  4 CPU cores
   -  8GB RAM (16GB recommended)
   -  60GB storage
   -  2 network interface cards (NICs) [21]
   -  A fully qualified domain name (FQDN)

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

RHOSP enables high-availability (HA) for the control plane by default and requires having exactly 3 Controller nodes as part of the Overcloud. [45] TripleO can have HA enabled by setting the ``ControllerCount`` to ``3`` and including this template: ``-e /usr/share/openstack-tripleo-heat-templates/environments/docker-ha.yaml``. [46]

Undercloud
~~~~~~~~~~

The Undercloud can be installed onto a bare metal server or a virtual machine. Follow the "hypervisor" section to assist with automatically creating an Undercloud virtual machine. The Undercloud requires at least 2 NICs (typically ``eth0`` and ``eth1``). The first is used for external connectivity. The second is dedicated to provisioning the Overcloud nodes with Ironic. On those nodes, the related interface that can reach the Undercloud's ``eth1`` should be configured for PXE booting in the BIOS. [21]

Considerations before starting the Undercloud deployment:

-  The Undercloud server requires two network interfaces. One with public Internet/management access and the second dedicated to provisioning.
-  Configure the hostname.
-  Set `push_destination: True` in a custom container-image-prepare.yaml file.
-  undercloud.conf
    - The NTP and DNS resolvers need to be accurate and accessible.
    - If deploying or managing more than 250 hosts, it is required to change the ctlplane-subnet to a use a subnet mask with more available IP addresses.
    - Use the custom container-image-prepare.yaml file.

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

          $ curl -O https://opendev.org/openstack/tripleo-quickstart/raw/branch/master/quickstart.sh
          $ bash quickstart.sh --release trunk/queens --tags all --playbook quickstart.yml -e overcloud_nodes="" $VIRTHOST

   -  Log into the virtual machine once TripleO Quickstart has completed
      setting up the environment.

      .. code-block:: sh

          $ ssh -F ~/.quickstart/ssh.config.ansible undercloud

-  **Undercloud (Manual)**

   -  It is recommended to create a user named "stack" with sudo
      privileges to manage the Undercloud.

      .. code-block:: sh

          $ sudo useradd stack
          $ sudo passwd stack
          $ echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
          $ sudo chmod 0440 /etc/sudoers.d/stack
          $ su - stack

   -  Install TripleO. For <= Stein, install ``python-tripleoclient`` instead.

      .. code-block:: sh

          $ sudo yum install python3-tripleoclient openstack-tripleo-common openstack-tripleo-heat-templates

   -  Update the operating system and reboot the server.

      .. code-block:: sh

         $ sudo yum update && sudo reboot

   -  Copy the sample configuration to use as a base template. Optionally configure it.

      -  <= Stein:

         .. code-block:: sh

             $ cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf

      -  >= Train:

         .. code-block:: sh

             $ cp /usr/share/python-tripleoclient/undercloud.conf.sample ~/undercloud.conf

   -  Common Undercloud configuration options. If using an automated power management driver with Ironic, the IP address for the Undercloud's provisioning NIC must use the same network and broadcast domain. [15]

      -  enable\_\* = Enable or disable non-essential OpenStack services on the Undercloud.
      -  **dhcp\_{start\|end}** = The range of IP addresses to temporarily use for provisioning Overcloud nodes. This range is a limiting factor in how many nodes can be provisioned at once.
      -  **local\_interface** = The network interface to use for provisioning new Overcloud nodes. This will be configured as an Open vSwitch bridge. Default: eth1.
      -  **local\_ip** = The local IP address of the Undercloud node to be used for using DHCP for providing IP addresses for Overcloud nodes during PXE booting. This should not be a public IP address.
      -  **inspection\_iprange** = The IP range to use for Ironic's introspection of the Overcloud nodes. This range needs to unique from the DHCP start/end range.
      -  local\_mtu = The MTU size to use for the local interface.
      -  **cidr** = The CIDR range of IP addresses to use for the Overcloud nodes.
      -  masquerade\_network = The network CIDR that will be used for masquerading external network connections.
      -  **gateway** = The default gateway to use for external connectivity to the Internet during provisioning. Use the "local\_ip" when masquerading is used.
      -  undercloud\_admin\_vip = The IP address to listen on for admin API endpoints.
      -  undercloud\_hostname = The fully qualified hostname to use for the Undercloud.
      -  undercloud\_nameservers = A list of DNS resolvers to use.
      -  undercloud\_ntp\_servers = A list of NTP servers to use.
      -  undercloud\_public\_vip = The IP address to listen on for public API endpoints.
      -  enabled_hardware_types = The Ironic power management drivers to enable. For virtual lab environments, append "manual-management".

   -  Example of changing the control plane (provisioning) network details.

      .. code-block:: ini

         [DEFAULT]
         undercloud_admin_host = 192.168.100.3
         undercloud_public_host = 192.168.100.2
         [ctlplane-subnet]
         cidr = 192.168.100.0/24
         dhcp_start = 192.168.100.4
         dhcp_end = 192.168.100.150
         gateway = 192.168.100.1
         inspection_iprange = 192.168.100.201,192.168.100.250
         masquerade = true

   -  Deploy the Undercloud. Anytime the configuration for the Undercloud changes, this command needs to be re-ran to update the installation.

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

[12]

The next step is to optionally provision the Overcloud nodes and then deploy the OpenStack services.

Uninstall
^^^^^^^^^

Use the script provided `here <https://access.redhat.com/solutions/2210421>`__ to uninstall the Undercloud services.

Overcloud (Provision Nodes with Ironic)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TripleO can provision a full CentOS or RHEL operating system onto a new baremetal server using the Ironic service. The normal TripleO deployment process is split into these steps [59]:

-  Upload pre-built Overcloud image files to Glance.
-  Import the ``instackenv`` file with power management details about the nodes.
-  Introspect the nodes. This will PXE/network boot the Overcloud nodes so that Ironic can gather hardware information used during provisioning.
-  Deploy the Overcloud. This will automatically provision the nodes. Provisioning can optionally be done manually before the deployment.

-----

-  **Image Preparation**

   -  GA releases do not have pre-built Overcloud image files. They must be manually created. [60]

      .. code-block:: sh

        $ The openstack overcloud image build --all

   -  RDO Trunk (current-tripleo-rdo):

      .. code-block:: sh

        $ export OS_RELEASE="train"
        $ export TRUNK_BRANCH="current-tripleo-rdo"
        $ mkdir images
        $ cd images
        $ curl -O https://images.rdoproject.org/${OS_RELEASE}/rdo_trunk/${TRUNK_BRANCH}/ironic-python-agent.tar
        $ curl -O https://images.rdoproject.org/${OS_RELEASE}/rdo_trunk/${TRUNK_BRANCH}/overcloud-full.tar
        $ tar -v -x -f ironic-python-agent.tar
        $ tar -v -x -f overcloud-full.tar

   -  RHOSP [38]

      .. code-block:: sh

        $ export OS_RELEASE="13.0"
        $ mkdir images
        $ cd images
        $ sudo yum install rhosp-director-images rhosp-director-images-ipa
        $ tar -v -x -f /usr/share/rhosp-director-images/overcloud-full-latest-${OS_RELEEASE}.tar
        $ tar -v -x -f /usr/share/rhosp-director-images/ironic-python-agent-latest-${OS_RELEASE}.tar

-  These files are extracted from the tar archives:

   -  ironic-python-agent.initramfs
   -  ironic-python-agent.kernel
   -  overcloud-full.initrd
   -  overcloud-full.qcow2
   -  overcloud-full.vmlinuz

-  Upload those images.

   .. code-block:: sh

       $ openstack overcloud image upload --image-path /home/stack/images/

-  For using containers, the RDO images from Docker Hub are configured by default. Enable container caching on the Undercloud by generating this template. This will increase the Overcloud deployment time since container images will only have to be pulled from Docker Hub once. [33]

   .. code-block:: sh

      $ openstack tripleo container image prepare default --output-env-file ~/templates/containers-prepare-parameter.yaml

**Introspection**

-  Create an ``instackenv.{json|yaml}`` file that describes the physical infrastructure of the Overcloud. [15] By default Ironic manages rebooting machines using the IPMI "pxe_ipmitool" driver. [18] Below are the common values to use that define how to handle power management (PM) for the Overcloud nodes via Ironic.

   -  All

      -  name = A descriptive name of the node.
      -  pm_type = The power management driver type to use. Common drivers include "pxe_ipmitool" and "manual-management".
      -  capabilities = Set custom capabilities. For example, the profile and boot options can be defined here: ``"profile:compute,boot_option:local"``.

   -  IPMI

      -  pm_user = The PM user to use.
      -  pm_password = The PM password to use.
      -  pm_addr = The PM IP address to use.

   -  Fake PXE

      -  arch = The processor architecture. The standard is "x86_64".
      -  cpu = The number of processor cores.
      -  mac = A list of MAC addresses that should be used for the PXE boot. This normally only contains one value.
      -  memory = The amount of RAM, in MiB.
      -  disk = The amount of disk space, in GiB. Set this to be 1 GiB less than the actual reported storage size. That will prevent partitioning issues during the Overcloud deployment.

   -  ``instackenv.json`` syntax:

      .. code-block:: json

          {
              "nodes": [
                  {
                      "name": "<DESCRIPTIVE_NAME>",
                      "pm_type": "manual-management",
                      "arch": "x86_64",
                      "cpu": "<CPU_CORES>",
                      "memory": "<RAM_MB>",
                      "disk": "<DISK_GB>",
                      "capabilities": "profile:control,boot_option:local"
                  },
                  {
                      "name": "<DESCRIPTIVE_NAME>",
                      "pm_type": "pxe_ipmitool",
                      "pm_user": "<IPMI_USER>",
                      "pm_password": "<IPMI_PASSWORD>",
                      "pm_addr": "<IPMI_IP_ADDRESS>",
                      "mac": [
                          "AA:BB:CC:DD:EE:FF"
                      ],
                      "capabilities": "profile:compute,boot_option:local"
                  }
              ]
          }

   -  ``instackenv.yaml`` syntax:

      .. code-block:: yaml

         ---
         nodes:
           - name: <DESCRIPTIVE_NAME>
             pm_type: manual-management
             arch: x86_64
             cpu: <CPU_CORES>
             memory: <RAM_MB>
             disk: <DISK_GB>
             mac:
               - "AA:BB:CC:DD:EE:FF"
             capabilities: "profile:control,boot_option:local"
           - name: <DESCRIPTIVE_NAME>
             pm_type: pxe_ipmitool
             pm_user: <IPMI_USER>
             pm_password: <IPMI_PASSWORD>
             pm_addr: <IPMI_IP_ADDRESS>
             capabilities: "profile:compute,boot_option:local"

   -  Virtual lab environment:

      -  The "manual-management" driver can be used. This will require the end-user to manually reboot the managed nodes.

      -  Virtual machines deployed using Vagrant need to have vagrant-libvirt's default eth0 management interface removed. The first interface on the machine (normally eth0) is used for introspection and provisioning and cannot be that management interface.

         .. code-block:: sh

             $ sudo virsh detach-interface ${VM_NAME} network --persistent --mac $(sudo virsh dumpxml ${VM_NAME} | grep -B4 vagrant-libvirt | grep mac | cut -d "'" -f2)

-  Import the nodes and then introspect them immediately. [24]

   .. code-block:: sh

       $ openstack overcloud node import --introspect --provide instackenv.json

-  Alternatively, import them and inspect them later.

   .. code-block:: sh

       $ openstack overcloud node import instackenv.json
       Started Mistral Workflow tripleo.baremetal.v1.register_or_update. Execution ID: cf2ce144-a22a-4838-9a68-e7c3c5cf0dad
       Waiting for messages on queue 'tripleo' with no timeout.
       2 node(s) successfully moved to the "manageable" state.
       Successfully registered node UUID c1456e44-5245-4a4d-b551-3c6d6217dac4
       Successfully registered node UUID 9a277de3-02be-4022-ad26-ec4e66d97bd1

   -  Verify that Ironic has successfully added the new baremetal nodes.

      .. code-block:: sh

          $ openstack baremetal node list
          +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
          | UUID                                 | Name      | Instance UUID | Power State | Provisioning State | Maintenance |
          +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+
          | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | None          | None        | manageable         | False       |
          | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | None          | None        | manageable         | False       |
          +--------------------------------------+-----------+---------------+-------------+--------------------+-------------+

-  Start the introspection. [24] Each Overcloud node requires at least 4GB of RAM or else the introspection will fail with a kernel panic during the network booted live session.

   -  **Method \#1:** Automatical introspection with a managed Ironic driver (such as IPMI). This command will introspect all nodes in the ``management`` state and set them to the ``available`` state when complete.

      .. code-block:: sh

          $ openstack overcloud node introspect --all-manageable --provide
          Waiting for introspection to finish...
          Waiting for messages on queue 'tripleo' with no timeout.
          Introspection of node c1456e44-5245-4a4d-b551-3c6d6217dac4 completed. Status:SUCCESS. Errors:None
          Introspection of node 9a277de3-02be-4022-ad26-ec4e66d97bd1 completed. Status:SUCCESS. Errors:None
          Introspection completed.
          Waiting for messages on queue 'tripleo' with no timeout.
          2 node(s) successfully moved to the "available" state.

   -  **Method \#2:** Automatic but the connection details are given via the CLI instead of the instackenv file.

      -  Automatically discover the available servers by scanning hardware devices (such as IPMI) via a CIDR range and using different logins.

            .. code-block:: sh

                $ openstack overcloud node discover --range <CIDR> --credentials <USER1>:<PASSWORD1> --credentials <USER2>:<PASSWORD2>

   -  **Method \#3:** Lab environment using the manual-management driver.

      -  In another terminal, verify that the "Power State" is "power on" and then manually start the virtual machines. The introspection will take a long time to complete.

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

-  Configure the necessary flavors (mandatory for getting accurate results when using the manual-management Ironic driver). [25] Commonly custom "control" and "compute" flavors will need to be created.

   .. code-block:: sh

       $ openstack flavor create --id auto --vcpus <CPU_COUNT> --ram <RAM_IN_MB> --disk <DISK_IN_GB_MINUS_ONE> --swap <SWAP_IN_MB> --property "capabilities:profile"="<FLAVOR_NAME>" <FLAVOR_NAME>

-  Configure the kernel and initramfs that the baremetal nodes should boot from.

   -  Queens (optional) [24]:

      .. code-block:: sh

          $ openstack baremetal node list
          $ openstack overcloud node configure <NODE_ID>

-  If the profile and/or boot option were not specified in the instackenv.json file then configure it now. Verify that the profiles have been applied. Valid default flavors are ``block-storage``, ``ceph-storage``, ``compute``, ``control``, and ``swift-storage``.

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

-  Set a DNS nameserver on the control plane subnet. Starting with Rocky, this is automatically set to the value of ``undercloud_nameservers`` from the ``undercloud.conf`` configuration.

   .. code-block:: sh

      $ openstack subnet set --dns-nameserver 8.8.8.8 --dns-nameserver 1.1.1.1 ctlplane-subnet

**Deployment**

-  Configure the networking Heat templates that define the physical and virtual network interface settings.

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

   -  Scenario #3 - No templates:

      -  If no custom network settings will be used, then the Heat templates do not need to be generated. By default, TripleO will configure different subnets to separate traffic (instead of also using VLANs) onto the default network interface of the Overcloud nodes.

-  In a YAML Heat template, set the number of controller, compute, Ceph, and/or any other nodes that should be deployed.

   .. code-block:: yaml

      ---
      parameter_defaults:
        OvercloudControllerFlavor: control
        OvercloudComputeFlavor: compute
        OvercloudCephStorageFlavor: ceph
        ControllerCount: <NUMBER_OF_CONTROLLER_NODES>
        ComputeCount: <NUMBER_OF_COMPUTE_NODES>
        CephStorageCount: <NUMBER_OF_CEPH_NODES>

-  Alternatively, the initial default count can be set in the ``roles_data.yaml`` file.

   .. code-block:: yaml

      - name: Controller
        CountDefault: <NUMBER_OF_CONTROLLER_NODES>
      - name: Compute
        CountDefault: <NUMBER_OF_COMPUTE_NODES>
      - name: CephStorage
        CountDefault: <NUMBER_OF_CEPHSTORAGE_NODES>

-  Deploy the Overcloud with any custom Heat configurations. [13] Starting with the Pike release, most services are deployed as containers by default. For preventing the use of containers, remove the "docker.yaml" and "docker-ha.yaml" files from ``${TEMPLATES_DIRECTORY}/environments/``. [14]

   .. code-block:: sh

       $ openstack help overcloud deploy
       $ openstack overcloud deploy --templates ~/templates -r ~/templates/roles_data_custom.yaml

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

      -  After that is complete, the virtual machines will power off. Ironic will report that the "Power State" is now "power on" and the Provisioning State" is now "active." The nodes have now been provisioned with the Overcloud image. Change the boot order of each machine to start with the hard drive instead of the network interface card. Manually start the virtual machines after that.

         .. code-block:: sh

             $ openstack baremetal node list
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             | UUID                                 | Name      | Instance UUID                        | Power State | Provisioning State | Maintenance |
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+
             | c1456e44-5245-4a4d-b551-3c6d6217dac4 | control01 | 16a09779-b324-4d83-bc7d-3d24d2f4aa5d | power on    | active             | False       |
             | 9a277de3-02be-4022-ad26-ec4e66d97bd1 | compute01 | 5c2d1374-8b20-4af6-b114-df15bbd3d9ca | power on    | active             | False       |
             +--------------------------------------+-----------+--------------------------------------+-------------+--------------------+-------------+

-  The deploy will continue onto the configuration management stage. Before Rocky, this process used os-collect-config (Heat). Starting with Rocky, this now uses config-download (Ansible).

::

   2019-10-30 23:40:47Z [overcloud-AllNodesDeploySteps-5yoxyq2a4bgz]: UPDATE_COMPLETE  Stack UPDATE completed successfully
   2019-10-30 23:40:47Z [AllNodesDeploySteps]: UPDATE_COMPLETE  state changed
   2019-10-30 23:40:51Z [overcloud]: UPDATE_COMPLETE  Stack UPDATE completed successfully

    Stack overcloud UPDATE_COMPLETE

   Deploying overcloud configuration
   Enabling ssh admin (tripleo-admin) for hosts:
   192.168.24.17 192.168.24.16
   Using ssh user cloud-user for initial connection.
   Using ssh key at /home/stack/.ssh/id_rsa for initial connection.
   Inserting TripleO short term key for 192.168.24.17
   Warning: Permanently added '192.168.24.17' (ECDSA) to the list of known hosts.
   Inserting TripleO short term key for 192.168.24.16
   Warning: Permanently added '192.168.24.16' (ECDSA) to the list of known hosts.
   Starting ssh admin enablement workflow
   Started Mistral Workflow tripleo.access.v1.enable_ssh_admin. Execution ID: 0a69a3a3-d9bb-43c6-8aed-0ef33f6336d7
   ssh admin enablement workflow - RUNNING.
   ssh admin enablement workflow - RUNNING.
   ssh admin enablement workflow - COMPLETE.
   Removing TripleO short term key from 192.168.24.17
   Warning: Permanently added '192.168.24.17' (ECDSA) to the list of known hosts.

-  Once the deployment is complete, verify that the Overcloud was deployed successfully. If it was not, then troubleshoot any stack resources that failed.

   ::

      PLAY RECAP *********************************************************************
      overcloud-controller-0     : ok=257  changed=142  unreachable=0    failed=0
      overcloud-novacompute-0    : ok=178  changed=78   unreachable=0    failed=0
      undercloud                 : ok=21   changed=12   unreachable=0    failed=0
      
      Wednesday 13 February 2019  14:38:34 -0500 (0:00:00.103)       0:40:32.320 ****
      ===============================================================================
      
      Ansible passed.
      Overcloud configuration completed.
      Waiting for messages on queue 'tripleo' with no timeout.
      Host 192.168.24.23 not found in /home/stack/.ssh/known_hosts
      Overcloud Endpoint: http://192.168.24.23:5000
      Overcloud Horizon Dashboard URL: http://192.168.24.23:80/dashboard
      Overcloud rc file: /home/stack/overcloudrc
      Overcloud Deployed

   .. code-block:: sh

       $ openstack stack list
       $ openstack stack failures list <OVERCLOUD_STACK_ID> --long
       $ openstack stack show <OVERCLOUD_STACK_ID>
       $ openstack stack resource list <OVERCLOUD_STACK_ID>
       $ openstack stack resource show <OVERCLOUD_STACK_ID> <RESOURCE_NAME>
       $ openstack overcloud failures list # Requires >= Rocky

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

[13][23]

-  Passwords for the Overcloud services can be found by running:

   -  TripleO Queens:

      .. code-block:: sh

         $ openstack object save overcloud plan-environment.yaml

-  In >= Rocky (or in Queens, if configured), the Ansible files used for the configuration management can be downloaded. Those files can then be imported into an external source such as Ansible Tower or AWX. The ``tripleo-ansible-inventory`` script is used to generate a dynamic inventory file for Ansible that contains the Overcloud hosts. [30]

    .. code-block:: sh

       $ openstack overcloud config download

-  For a lab with a private network, use a proxy service from the hypervisor to access the dashboard and API IP address.

    .. code-block:: sh

       $ sshuttle -r stack@undercloud 192.168.24.23

Overcloud (Pre-deployed/provisioned Nodes)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introspection and the operating system provisioning can be skipped if the Overcloud nodes are already setup and running.

Pros:

-  Easier to deploy, subjectively.
-  Faster to deploy if using a pre-configured operating system snapshot.
-  No Nova or Ironic dependencies.

Cons:

-  All Overclouds nodes must be pre-provisioned. Ironic cannot manage any for provisioning.
-  Requires the operating system to already be installed.
-  Repositories have to be installed and enabled manually.
-  Validations are not supported.

-----

**Overcloud Nodes**

-  Install CentOS or RHEL.
-  Create a ``stack`` user. Add the ``stack`` user's SSH key from the Undercloud to allow access during deployment.

   -  Alternatively, specify a different user for the deployment with ``openstack overcloud deploy --overcloud-ssh-user <USER> --overcloud-ssh-key <PRIVATE_KEY_FLIE>``. This user is only used during the initial deployment to create a ``tripleo-admin`` user (or the user ``heat-admin`` in Queens release and older).

-  Enable the RDO or RHOSP repositories.
-  Install the Heat user agent (required only for <= Queens when not using config-download).

   .. code-block:: sh

      $ sudo yum -y install python-heat-agent*

**Undercloud/Director**

-  For config-download scenarios on < Train, generate Heat templates for pre-provisioned nodes from a special roles data file. Starting in Train, it uses the default ``/usr/share/openstack-tripleo-heat-templates/roles_data.yaml`` file. Previously, roles such as ``ControllerDeployedServer`` and ``ComputeDeployedServer`` were used. These now use the standard ``Controller`` and ``Compute`` roles.

   .. code-block:: sh

      $ cd /usr/share/openstack-tripleo-heat-templates/
      $ mkdir /home/stack/templates/
      $ /usr/share/openstack-tripleo-heat-templates/tools/process-templates.py --roles-data /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-server-roles-data.yaml --output /home/stack/templates/

-  TripleO needs a hostname and port mapping to know what IP addresses to connect to for the deployment. The ``NeutronPublicInterface`` (eth0 by default) will be converted into a bridge (br-ex by default). It will have static IP addressing set to what the ``fixed_ips`` and ``cidr`` are set to. The ``ControlPlaneDefaultRoute`` will set the default route in ``/etc/sysconfig/network-scripts/route-br-ex``.

-  **Scenario 1: Use the Undercloud control plane network.**

   -  The control plane IP address of each Overcloud node should be within the range of the ``network_cidr`` value defined in the ``undercloud.conf`` configuration. By default this is ``192.168.24.0/24`` with 192.168.24.{1,2,3} all being reserved/used by the Undercloud.

      .. code-block:: yaml

          ---
          resource_registry:
            # This allows the IPs for provisioning to be manually set via DeployedServerPortMap.
            OS::TripleO::DeployedServer::ControlPlanePort: /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-neutron-port.yaml
            # These role resources will convert the NeutronPublicInterface into the required br-ex bridge interface.
            ## Open vSwitch
            OS::TripleO::ControllerDeployedServer::Net::SoftwareConfig: net-config-static-bridge.yaml
            OS::TripleO::ComputeDeployedServer::Net::SoftwareConfig: net-config-static-bridge.yaml

          parameter_defaults:
            # The Overcloud NIC that has a default route.
            ## Specify the exact network interface name.
            ## Alternatively, use a Heat alias such as "nic1" (eth0) or "nic2" (eth1) if the NICs are named
            ## differently on the Overcloud nodes.
            NeutronPublicInterface: nic2
            # The default route for the Overcloud nodes.
            # Example: 192.168.24.1
            ControlPlaneDefaultRoute: <DEFAULT_ROUTE_IP_ADDRESS>
            EC2MetadataIp: <UNDERCLOUD_LOCAL_IP>
            DeployedServerPortMap:
              <CONTROLLER0_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <CONTROLLER0_IPV4>
                subnets:
                  # Example = 192.168.24.0/24
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    # Example = 192.168.24.0/24
                    - <NETWORK_ADDRESS>/<PREFIX>
              <CONTROLLER1_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <CONTROLLER1_IPV4>
                subnets:
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    - <NETWORK_ADDRESS>/<PREFIX>
              <CONTROLLER2_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <CONTROLLER2_IPV4>
                subnets:
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    - <NETWORK_ADDRESS>/<PREFIX>
              <COMPUTE0_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <COMPUTE0_IPV4>
                subnets:
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    - <NETWORK_ADDRESS>/<PREFIX>
              <COMPUTE1_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <COMPUTE1_IPV4>
                subnets:
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    - <NETWORK_ADDRESS>/<PREFIX>

-  **Scenario 2: Use a custom network (not on the Undercloud control plane).**

   -  The Undercloud must be configured to use a public host for API communication during provisioning. The only way to do that, for security reasons, is to enable a TLS certificate.

      -  Set the ``undercloud_public_host`` in the ``undercloud.conf`` to an IP address or hostname that will be accessible by the Overcloud control plane IP addresses.
      -  Create a YAML file with the Puppet Hiera data that forces the deployment to use the public API endpoint on the Undercloud instead of the internal one. Set the ``hieradata_override`` value to the file path of that YAML file in the ``undercloud.conf``.

         .. code-block:: yaml

           ---
           heat_clients_endpoint_type: public
           heat::engine::default_deployment_signal_transport: TEMP_URL_SIGNAL

      -  Set the ``generate_service_certificate`` to ``true`` in the ``undercloud.conf``. This will generate a self-signed certificate.
      -  Load the new Undercloud configuration by re-running ``openstack undercloud install``.

   -  Set a custom control plane virtual IP that will be used by the HAProxy load balancer.

      .. code-block:: yaml

          ---
          resource_registry:
            OS::TripleO::ControllerDeployedServer::Net::SoftwareConfig: net-config-static-bridge.yaml
            OS::TripleO::ComputeDeployedServer::Net::SoftwareConfig: net-config-static-bridge.yaml
            # These resources will allow for a custom control plane virtual IP to be used for controller node services.
            OS::TripleO::DeployedServer::ControlPlanePort: /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-neutron-port.yaml
            OS::TripleO::Network::Ports::ControlPlaneVipPort: /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-neutron-port.yaml
            OS::TripleO::Network::Ports::RedisVipPort: /usr/share/openstack-tripleo-heat-templates/network/ports/noop.yaml
            OS::TripleO::Network::Ports::OVNDBsVipPort: /usr/share/openstack-tripleo-heat-templates/network/ports/noop.yaml

          parameter_defaults:
            NeutronPublicInterface: <NIC>
            ControlPlaneDefaultRoute: <DEFAULT_ROUTE_IP_ADDRESS>
            EC2MetadataIp: <UNDERCLOUD_PUBLIC_HOST>
            DeployedServerPortMap:
              control_virtual_ip:
                fixed_ips:
                  # This IP must be accessible by all of the Overcloud nodes and should be on the same network.
                  # It must also must be a unique IP address and not conflict with any other IP addresses.
                  - ip_address: <CONTROL_VIRTUAL_IP_ADDRESS>
                subnets:
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    - <NETWORK_ADDRESS>/<PREFIX>
              <CONTROLLER0_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <CONTROLLER0_IPV4>
                subnets:
                  # Example = 192.168.122.0/24
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    # Example = 192.168.122.0/24
                    - <NETWORK_ADDRESS>/<PREFIX>
              <COMPUTE0_SHORT_HOSTNAME>-ctlplane:
                fixed_ips:
                  - ip_address: <COMPUTE0_IPV4>
                subnets:
                  - cidr: <NETWORK_ADDRESS>/<PREFIX>
                network:
                  tags:
                    - <NETWORK_ADDRESS>/<PREFIX>

-  If config-download will be used, hostname maps have to be defined. These must be mapped to the short hostname of the servers that relate to the port mappings.

   .. code-block:: yaml

       ---
       parameter_defaults:
         HostnameMap:
           overcloud-controller-0: <CONTROLLER0_SHORT_HOSTNAME>
           overcloud-controller-1: <CONTROLLER1_SHORT_HOSTNAME>
           overcloud-controller-2: <CONTROLLER2_SHORT_HOSTNAME>
           overcloud-novacompute-0: <COMPUTE0_SHORT_HOSTNAME>
           overcloud-novacompute-1: <COMPUTE1_SHORT_HOSTNAME>

-  Start the deployment of the Overcloud using at least these arguments and templates. The Heat templates defining the hostname and port maps must also be included.

   -  <= Stein:

      .. code-block:: sh

         $ openstack overcloud deploy --disable-validations --templates ~/templates \
             -e ~/templates/environments/deployed-server-environment.yaml \
             -e ~/templates/environments/deployed-server-bootstrap-environment-rhel.yaml \
             -e ~/templates/environments/deployed-server-pacemaker-environment.yaml \
             -r /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-server-roles-data.yaml

   -  >= Train:

      .. code-block:: sh

         $ openstack overcloud deploy --disable-validations --templates ~/templates \
             -e ~/templates/environments/deployed-server-environment.yaml \
             -r /usr/share/openstack-tripleo-heat-templates/roles_data.yaml

**config-download (>= Rocky)**

No further action is required.

**config-download (Queens)**

Add the ``--config-download -e ~/templates/environments/config-download-environment.yaml`` template after (not before) the predeployed server templates to properly enable config-download.

**os-collect-config (Queens, Automatic)**

-  When using Queens without config-download, the deployment will pause on the creation of the Overcloud nodes. The Heat agent on the Overcloud nodes need to be registered for the deployment to continue. For new deployments only (not scaling), automatic detection of the Heat agents can be used. Use the Overcloud node roles defined in the "roles_data.yaml" configuration file.

   ::

      2019-01-01 12:00:00Z [overcloud.Compute.0.NovaCompute]: CREATE_IN_PROGRESS  state changed
      2019-01-01 12:00:01Z [overcloud.Controller.0.Controller]: CREATE_IN_PROGRESS  state changed

-  Then run the ``get-occ-config`` script on the Undercloud to configure the service.

   .. code-block:: sh

      $ export OVERCLOUD_ROLES="ControllerDeployedServer ComputeDeployedServer"
      $ export ControllerDeployedServer_hosts="<CONTROLLER0_IP> <CONTROLLER1_IP> <CONTROLLER2_IP>"
      $ export ComputeDeployedServer_hosts="<COMPUTE0_IP> <COMPUTE1_IP>"
      $ /usr/share/openstack-tripleo-heat-templates/deployed-server/scripts/get-occ-config.sh

**os-collect-config (Queens, Manual)**

-  Use the manual method if the automatic one does not work.
-  Generate metadata URLs for the Overcloud nodes.

   .. code-block:: sh

      $ for STACK in $(openstack stack resource list -n5 --filter name=deployed-server -c stack_name -f value overcloud) ; do STACKID=$(echo $STACK | cut -d '-' -f2,4 --output-delimiter " ") ; echo "== Metadata URL for $STACKID ==" ; openstack stack resource metadata $STACK deployed-server | jq -r '.["os-collect-config"].request.metadata_url' ; echo ; done

-  On the Overcloud nodes, add the correct metadata URL to the os-collect-config configuration, and then restart the service.

   .. code-block:: sh

      $ sudo rm /usr/libexec/os-apply-config/templates/etc/os-collect-config.conf
      $ sudo vi /usr/libexec/os-apply-config/templates/etc/os-collect-config.conf

   .. code-block:: ini

      [DEFAULT]
      collectors=request
      command=os-refresh-config
      polling_interval=30
      
      [request]
      metadata_url=<METADATA_URL>

   .. code-block:: sh

      $ sudo systemctl restart os-collect-config

-  If issues are encountered with the manual process, stop the service and then run the os-collect-config command and force it to use the primary configuration file.

  .. code-block:: sh

     $ sudo rm -rf /var/lib/heat-config/deployed/*
     $ sudo systemctl stop os-collect-config
     $ sudo os-collect-config --debug --force --one-time --config-file /etc/os-collect-config.conf

[36][37]

Operations
----------

Add a Compute Node
~~~~~~~~~~~~~~~~~~

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

[19]

Remove a Compute Node
~~~~~~~~~~~~~~~~~~~~~

Disable the Nova services.

.. code-block:: sh

   $ . ~/overcloudrc
   $ openstack compute service set <NODE> nova-compute --disable

Delete the Compute node and include the templates used during deployment. [49]

.. code-block:: sh

   $ . ~/strackrc
   $ openstack overcloud node delete --stack overcloud --templates ~/templates <NODE>

Delete additional services related to the Compute node.

.. code-block:: sh

   $ . ~/overcloudrc
   $ openstack compute service delete <NODE>
   $ openstack network agent delete <NODE>
   $ openstack resource provider delete <NDOE>

Decrease the ``ComputeCount`` in the Heat parameters used for the deployment.

[50]

Rebooting the Cloud
~~~~~~~~~~~~~~~~~~~

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

[34]

Ansible Playbooks (config-download)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Queens release of TripleO featured optional usage of Ansible configuration management via a feature called ``config-download``. It has been the default method of deployment since Rocky where it also added official support for deploying Ceph and Octavia. TripleO will log into the Overcloud nodes and configure a ``tripleo-admin`` user that will be used by Ansible for running updates and upgrades [39]. Use these arguments to enable config-download on Queens.

.. code-block:: sh

   $ openstack overcloud deploy --templates ~/templates --config-download -e /usr/share/openstack-tripleo-heat-templates/environments/config-download-environment.yaml --overcloud-ssh-user heat-admin --overcloud-ssh-key ~/.ssh/id_rsa

In Queens, for reverting back to using Heat for the deployment, remove the config-download arguments and include an environment file with these resource registries [56]:

.. code-block:: yaml

   ---
   resource_registry:
     OS::TripleO::SoftwareDeployment: OS::Heat::StructuredDeployment
     OS::TripleO::DeploymentSteps: OS::Heat::StructuredDeploymentGroup
     OS::Heat::SoftwareDeployment:  OS::TripleO::Heat::SoftwareDeployment
     OS::Heat::StructuredDeployment: OS::TripleO::Heat::StructuredDeployment

The latest playbooks and variables used to deploy the Overcloud can be downloaded to the current working directory.

.. code-block:: sh

    $ openstack overcloud config download

All of that Ansible content is stored in a local git repository at ``/var/lib/mistral/overcloud/``. The log files of the last config-download run are found at ``/var/lib/mistral/overcloud/ansible.log`` and ``/var/lib/mistral/overcloud/ansible-errors.json``.

The ``deploy_steps_playbook.yaml`` file is the primary playbook that executes all of the deployment playbooks. Before running the playbook, the tripleo-admin account needs to be configured on the Overcloud nodes. This can be done manually if the playbooks for the deployment or scale-up are used manually (ex., not using ``openstack overcloud deploy``) [36]:

-  Queens:

   .. code-block:: sh

      $ export OVERCLOUD_HOSTS="<IP1> <IP2>"
      $ /usr/share/openstack-tripleo-heat-templates/deployed-server/scripts/enable-ssh-admin.sh

-  Train:

   .. code-block:: sh

      $ openstack overcloud admin authorize

A static inventory can be created using the available dynamic inventory script ``tripleo-ansible-inventory``.

.. code-block:: sh

   $ tripleo-ansible-inventory --ansible_ssh_user tripleo-admin --static-yaml-inventory tripleo-ansible-inventory.yaml

Tags (as of Stein):

-  always
-  facts
-  common_roles
-  container_config
-  container_config_scripts
-  container_config_tasks
-  container_image_prepare
-  container_startup_configs
-  external_deploy_steps
-  external_post_deploy_steps
-  host_config
-  host_prep_steps
-  overcloud
-  pre_deploy_steps
-  step0
-  step1
-  step2
-  step3
-  step4
-  step5
-  tripleo_ssh_known_hosts

For only updating the Ansible playbooks based on the Heat templates, pass the ``--stack-only`` argument to the Overcloud deployment. They can then be downloaded and executed manually.

.. code-block:: sh

   $ openstack overcloud deploy --stack-only

[41]

If the playbooks are already generated from a successful STACK_CREATE of the Overcloud, then the deployment can be ran again using only the playbooks (skipping the need to parse the Heat templates).

.. code-block:: sh

   $ openstack overcloud deploy --config-download-only

Fact caching is enabled by default which can lead to issues with re-deployment. This can be manually cleared out on the Undercloud.

.. code-block:: sh

   $ sudo rm -rf /var/lib/mistral/ansible_fact_cache/*

Force re-running tasks that only run during the initial deployment by using the ``force=true`` variable. The example below will run the network configuration tasks again.

.. code-block:: sh

   $ ansible-playbook -i inventory.yaml --become --tags facts,post_deploy_steps deploy_steps_playbook.yaml -e force=true

Configurations
--------------

These are configurations specific to Overcloud deployments using TripleO. Custom settings are defined using a YAML Heat template.

.. code-block:: yaml

   ---
   parameter_defaults:
     <KEY>: <VALUE>

Services
~~~~~~~~

Overcloud services (both OpenStack and Linux) are defined in TripleO Heat templates. In <= Stein, the services were configured using puppet-tripleo. In >= Train, the services are configured using tripleo-ansible. All of the valid services are defined in the ``/usr/share/openstack-tripleo-heat-templates/roles_data.yaml`` file.

Services can be disabled from being deployed and configured on the Overcloud one of two ways.

1. Remove the service entry from the relevant role in the ``roles_data.yaml`` file before processing/generating the Heat templates.
2. Create a new Heat template file and set the service to ``OS::Heat::None``.

.. code-block:: yaml

   ---
   resource_registry:
     OS::TripleO::Services::<SERVICE>: OS::Heat::None

Configuration options for OpenStack services can be defined using ExtraConfig.

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
        # The primary manifest handles at least the primary configuration file.
        <OPENSTACK_SERVICE>::<MANIFEST>::<PUPPET_DICTIONARY>: <VALUE>
        # Some OpenStack services use more than one configuration file which could be handled
        # by nested manifests.
        <OPENSTACK_SERVICE>::<MANIFEST>::<MANIFEST_SUB_DIRECTORY>::<SUB_MANIFEST>::<PUPPET_DICTIONARY>: <VALUE>

Settings that are not handled by the Puppet modules can be overridden manually. The dictionary name for each configuration file is defined in ``manifests/config.pp`` in the ``<OPENSTACK_SERVICE>::config`` class.

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

[32]

The root MySQL account password can be configured for the Undercloud and/or Overcloud.

Undercloud:

.. code-block:: ini

   # undercloud.conf
   [auth]
   undercloud_db_password=<PASSWORD>

Overcloud:

.. code-block:: yaml

   ---
   parameter_defaults:
     MysqlRootPassword: <PASSWORD>

Networks
~~~~~~~~

When no network template is defined, VLANs are not used and instead each network will be assigned different subnets. Networks are only created using the ``STACK_CREATE`` phase and will not run during the ``STACK_UPDATE`` phase unless the Heat parameter ``NetworkDeploymentActions: ['CREATE','UPDATE']`` is set.

Interfaces (os-net-config)
^^^^^^^^^^^^^^^^^^^^^^^^^^

os-net-config is developed as part of TripleO and used to configure the network interfaces, DNS nameservers, IP addresses, and routes on all nodes (Undercloud and Overcloud).

Render the TripleO Heat Templates (THT) to view the static net-config files. These provide different layouts and examples for how to configure the networking interfaces.

.. code-block:: sh

    $ cd /usr/share/openstack-tripleo-heat-templates/
    $ mkdir ~/templates/
    $ /usr/share/openstack-tripleo-heat-templates/tools/process-templates.py -o ~/templates/
    $ cd ~/templates/
    $ ls -1 net-config-*
    net-config-bond.yaml
    net-config-bridge.yaml
    net-config-linux-bridge.yaml
    net-config-noop.yaml
    net-config-standalone.yaml
    net-config-static-bridge-nic-two-only.yaml
    net-config-static-bridge-two-nics.yaml
    net-config-static-bridge-with-external-dhcp.yaml
    net-config-static-bridge.yaml
    net-config-static.yaml
    net-config-undercloud.yaml

Set a custom net-config file on a per-role basis by overriding the resource registry for network configuration.

Syntax:

   .. code-block:: yaml

      ---
      resource_registry:
        OS::TripleO::<ROLE>::Net::SoftwareConfig: <PATH_TO>/<NIC_CONFIG_TEMPLATE>.yaml

Example:

   .. code-block:: yaml

      ---
      resource_registry:
        OS::TripleO::Controller::Net::SoftwareConfig: net-config-bond.yaml

A network environment template can be used to set related TripleO-provided net-config settings for all roles.

.. code-block:: sh

   $ ls -1 environments/net-*
   environments/net-2-linux-bonds-with-vlans.yaml
   environments/net-bond-with-vlans-no-external.yaml
   environments/net-bond-with-vlans.yaml
   environments/net-dpdkbond-with-vlans.yaml
   environments/net-multiple-nics-vlans.yaml
   environments/net-multiple-nics.yaml
   environments/net-noop.yaml
   environments/net-single-nic-linux-bridge-with-vlans.yaml
   environments/net-single-nic-with-vlans-no-external.yaml
   environments/net-single-nic-with-vlans.yaml
   $ openstack overcloud deploy -e ~/templates/environments/<NETWORK_ENVIRONMENT>.yaml

The ``$network_config`` dictionary stores the entire os-net-config configuration. The `run-os-net-config.sh <https://opendev.org/openstack/tripleo-heat-templates/src/branch/master/network/scripts/run-os-net-config.sh>`__ script will find and replace all references to ``interface_name`` with the Heat parameter value for ``NeutronPublicInterface`` and also replaces ``bridge_name`` with ``NeutronPhysicalBridge``. The script will default any interface not defined in the os-net-config settings to use DHCP. If DHCP does not work, then the "network" service may fail to restart during the Overcloud deployment leading to an inaccessible Overcloud.

net-config THT template:

.. code-block:: yaml

   resources:
     OsNetConfigImpl:
       type: OS::Heat::SoftwareConfig
       properties:
         group: script
         config:
           str_replace:
             template:
               get_file: network/scripts/run-os-net-config.sh
             params:
               $network_config:

The configuration file is stored on every node at ``/etc/os-net-config/config.yaml``. Settings from a custom file can be manually applied for testing by running ``os-net-config -c <OS_NET_CONFIG_FILE>.yaml -v --detailed-exit-codes --cleanup``.

Every network object that can be managed is known as a ``type``. Common types include: interface, ovs_bond, ovs_bridge, route_rule, team, and vlan. The full list of valid parameters are listed in the `schema.yaml <https://opendev.org/openstack/os-net-config/src/branch/master/os_net_config/schema.yaml>`__ file of os-net-config.

The ``interface`` type accepts passing nic1 (eth0), nic2 (eth1), etc. as the ``name`` attribute for dynamically associating an interface. Alternatively, the actual name of the network interface, such as eth0 or eth1, can be defined.

Below are sample configurations that can be defined in a net-config THT template. They will render out the Heat parametes during the deployment.

DHCP:

.. code-block:: yaml

   $network_config:
     network_config:
       - type: interface
         name: nic1
         use_dhcp: true

Static:

.. code-block:: yaml

   $network_config:
     network_config:
       - type: interface
         name: network_interface
         addresses:
           - ip_netmask: 192.168.122.101/24
         dns_servers:
           get_param: DnsServers
         domain:
           get_param: DnsSearchDomains

Control Plane IP Address:

.. code-block:: yaml

   $network_config:
     network_config:
       - type: interface
         name: eth3
         addresses:
           - ip_netmask:
               list_join:
                 - /
                 - - get_param: ControlPlaneIp
                   - get_param: ControlPlaneSubnetCidr
         routes:
           - default: true
             next_hop:
               get_param: ControlPlaneDefaultRoute

Bridge on a Bond:

.. code-block:: yaml

   $network_config:
     network_config:
       - type: ovs_bridge
         name: bridge_interface
         use_dhcp: true
         members:
           - type: ovs_bond
             name: bond0
             ovs_options:
               get_param: BondInterfaceOvsOptions
             members:
               - type: interface
                 name: nic1
               - type: interface
                 name: nic2

[61]

Only Open vSwitch (OVS) and Open Virtual Networking (OVN) are supported for bridge types. Linux Bridge is not tested in CI nor supported by Red Hat. RHEL 8 removed support for the legacy bridge utilities. [62]

VLANs
^^^^^

There are 6 different types of networks in a standard TripleO deployment using a VLANs template.

-  External = The external network that can access the Internet. This is used for the Horizon dashboard, public API endpoints, and floating IP addresses. Default VLAN: 10.
-  Internal = Default VLAN: 20.
-  Storage = Default VLAN: 30.
-  StorageMgmt = Default VLAN: 40
-  Tenant = Default VLAN: 50
-  Management = Default VLAN: 60.

The VLANs need to be trunked on the switch. A 7th native VLAN should also be configured on the switch for the provisioning network.

IP Addressing
^^^^^^^^^^^^^

Configure the network CIDRs, IP address ranges to allocation, and VLAN tags.

::

   <NETWORK_TYPE>NetCidr: <CIDR>
   <NETWORK_TYPE>AllocationPools:
     - start: <START_IP>
       end: <END_IP>
   <NETWORK_TYPE>NetworkVlanID: <VLAN_ID>

Configure these settings to match the IP address that the Undercloud is configured to use for provisioning. The default value is ``192.168.24.1``.

::

   ControlPlaneSubnetCidr: '24'
   ControlPlaneDefaultRoute: <UNDERCLOUD_IP_OR_ROUTER>
   EC2MetadataIp: <UNDERCLOUD_IP>

Public
^^^^^^

Configure the Overcloud access to the public Internet. Define the default router for the External network, DNS resolvers, and the NTP servers. It is important the DNS is setup correctly because if chronyc fails to resolve the NTP servers then it will not try to resolve them again. DNS is also required to download and install additional TripleO packages.

::

   ExternalInterfaceDefaultRoute: <PUBLIC_DEFAULT_GATEWAY_ADDRESS>
   DnsServers:
     - 10.5.30.160
     - 10.11.5.19
   NtpServer:
     - clock.redhat.com
     - clock2.redhat.com

Define the allowed network tag/tunnel types that Neutron networks use. The Neutron tunnel type is used for internal transmissions between the compute and network nodes. By default, the Neutron network bridge will be attached to ``br-int`` if left blank. This will configure a provider network. Otherwise, ``br-ex`` should be specified for self-service networks.

::

   NeutronNetworkType: "vxlan,gre,vlan,flat"
   NeutronTunnelTypes: "vxlan"
   NeutronExternalNetworkBridge: "''"

Define the interface to use for public networks. The ``NeutronPublicInterface`` (nic1/eth0 by default) will be converted into the an Open vSwitch bridge named based on the value of ``NeutronPhysicalBridge`` (br-ex by default). Optionally, define a VLAN tag for it. If no IP addressing information is configured for this interface, TripleO will default to configuring DHCP.

::

   NeutronPublicInterface: eth1
   NeutronPhysicalBridge: br0
   NeutronPublicInterfaceTag: 100

Configure bonding interface options, if applicable. Below is an example for LACP.

::

   bonding_options: "mode=802.3ad lacp_rate=slow updelay=1000 miimon=100"

Configure the bridge that will be used for public routers and floating IPs. Map it to a user-friendly name that will be used by Neutron resources.

::

   NeutronPhysicalBridge: br-ctlplane
   NeutronBridgeMappings: datacentre:br-ctlplane

[31]

Containers
~~~~~~~~~~

-  Configure the Undercloud to cache container images and serve them to the Overcloud nodes. This caching speeds up the deployment and lowers the amount of Internet bandwidth used. By default, Overcloud nodes will directly get images from the defined public registries. A private registry on the Undercloud will need to be configured as an insecure registry (it does not use a SSL/TLS certificate by default).

.. code-block:: ini

   # undercloud.conf
   [DEFAULT]
   container_images_file = /home/stack/containers-prepare-parameter.yml
   container_insecure_registries = ['192.168.24.1:8787']

.. code-block:: yaml

   ---
   # containers-prepare-parameters.yml
   parameter_defaults:
     DockerInsecureRegistryAddress:
       - 192.168.24.1:8787
     ContainerImagePrepare:
       - push_destination: true

-  Authenticate with a registry. For example, the Red Hat repository that contains the RHOSP container images. [42]

.. code-block:: yaml

   ---
   parameter_defaults:
   ContainerImageRegistryCredentials:
     registry.redhat.io:
       <RED_HAT_USERNAME>: <RED_HAT_PASSWORD>

-  Information on how to define custom registries, set container names, version tags to use, and other related settings can be found `here <https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/container_image_prepare.html>`__.

-  Custom package repositories and RPMs installed in containers are handled by the `tripleo-modify-image <https://opendev.org/openstack/ansible-role-tripleo-modify-image>`__ Ansible role.

.. code-block:: yaml

   ContainerImagePrepare:
     - push_destination: true
       includes:
         - <CONTAINER_NAME>
       modify_role: tripleo-modify-image
       modify_append_tag: "-hotfix"
       modify_vars:
         <TRIPLEO_MODIFY_IMAGES_ROLE_VARIABLES>

Packages
~~~~~~~~

By default, TripleO will not install packages. The standard Overcloud image from RDO already has all of the OpenStack packages installed. When using a custom image or not using Ironic for deploying Overcloud nodes, packages can be configured to be installed.

::

   EnablePackageInstall: true

A different repository for Overcloud service containers can be configured (>= Pike).

::

    DockerNamespace: registry.example.tld/rocky
    DockerNamespaceIsRegistry: true
    DockerInsecureRegistryAddress: registry.example.tld
    DockerNamespaceIsInsecureRegistry: true

Ceph
~~~~

**Releases**

Ceph is fully supported as a back-end for Overcloud storage services. If Ceph is enabled in TripleO, it will be used by default for Glance and Cinder. Before Pike, puppet-ceph was used to manage Ceph. Experimental support for using ceph-ansible was added in Pike. [17] It is fully supported via config-download as of Rocky. In Train, it uses the same Ansible inventory as config-download. Ceph updates are handled during the ``external_deploy_steps_tasks`` stage of config-download.

Red Hat Ceph Storage (RHCS) is the supported enterprise version of Ceph. RHCS 3.2 added official support for BlueStore. Using Ceph's FileStore mechanism has been deprecated since RHOSP 14. FileStore to BlueStore migration is supported by Red Hat. Customers must first update to RHCS 4 and then each OSD node is upgraded one at a time. [16]

RHCS releases and supported platforms:

-  RHCS 2 (Jewel) = RHOSP 10, 11, and 12.
-  RHCS 3 (Luminous) = RHOSP 13 and 14.
-  RHCS 4 (Nautilus) = RHOSP >= 15.

**Deployment Types**

TripleO can use an existing/independent ``external`` Ceph cluster. This is not managed by TripleO, and only provides connection details for OpenStack to communicate with the Ceph cluster. This requires the ``environments/ceph-ansible-external.yaml`` template. For a managed ``internal`` cluster, TripleO can deploy and manage the life-cycle of Ceph by using the ``environments/ceph-ansible.yaml`` template.

**Packages**

There are package and container requirements for both ``internal`` and ``external`` deployments of Ceph. The ceph-ansible package has to be installed for either the internal or external use case. For RHOSP, this is provided by the ``ceph-tools`` repository. As of Pike, the ``ceph-container`` has to be used to manage the Ceph services (even only as a client). This means that troubleshooting must be done inside the container. All OSD daemons run through a single container on each OSD node.

**Architecture**

TripleO puts the ceph-mon[itors] on the Overcloud Controller nodes. The OSDs are recommended to be placed on dedicated hardware. Hyperconverged infrastructure (HCI) is supported to run OSDs on the Compute nodes alongside the OpenStack services. For the Edge deployments, the ceph-mons live on the OSD nodes.

If the specified disks for deployment are clean, TripleO will create the LVMs required for the Ceph OSDs.

Pools for each OpenStack service are automatically created.

-  images = Glance
-  metrics = Gnocchi
-  backups = Cinder
-  vms = Nova
-  volumes = Cinder

One keyring at ``/etc/ceph/ceph.client.openstack.keyring`` is created by default to access all of the pool/rbds.

**Deployment (Internal)**

Use the ``environments/ceph-ansible.yaml`` Heat template. The command output of ``ceph-ansible`` is saved in the config-download directory at ``ceph-ansible/ceph-ansible-command.log``.

``~/templates/environments/ceph-ansible.yaml`` = Enables Ceph
``~/ceph.yaml`` = Specify a custom file with your own overrides

Configure the object storage back-end: ``bluestore`` or ``filestore``.

.. code-block:: yaml

   ---
   parameter_defaults:
     osd_objectstore: <BACKEND>

Example configuration of letting ``ceph-volume`` automatically determine which disks to use for what purpose (OSD or metadata). LVM is the recommended scenario.

.. code-block:: yaml

   ---
   parameter_defaults:
     CephAnsibleDisksConfig:
       devices:
         - /dev/sdb
         - /dev/sdc
         - /dev/nvme1n1
       osd_scenario: lvm
       osd_objectstore: bluestore

Manually created LVMs can also be defined to skip the usage of ``ceph-volume``.

.. code-block:: yaml

   ---
   parameter_defaults:
     CephAnsibleDisksConfig:
       lvm_volumes:
         - data: data-lv2
           data_vg: vg2
           db: db-lv2
           db_vg: vg2
       osd_scenario: lvm
       osd_objectstore: bluestore

If the initial deployment of TripleO with internal Ceph fails, the storage devices used for Ceph should be cleaned. If the undercloud.conf has ``clean_nodes = True`` set then the cleaning will be done automatically when Ironic chances a node state from ``active`` to ``available`` or ``manageable`` to ``available``.

Example of common settings for Ceph in RHOSP:

.. code-block:: yaml

   ---
   parameter_defaults:
     CephAnsiblePlaybookVerbosity: 3
     CephPoolDefaultSize: 1
     CephPoolDefaultPgNum: 32
     LocalCephAnsibleFetchDirectoryBackup: /tmp/fetch_dir
     CephAnsibleDisksConfig:
       osd_scenario: lvm
       osd_objectstore: bluestore
       lvm_volumes:
         - data: data-lv2
           data_vg: vg2
           db: db-lv2
           db_vg: vg2
     CephAnsibleExtraConfig:
       mon_host_v1:
         enabled: False
     # Required on RHOSP 15 until RHCS 4 becomes GA.
     EnableRhcs4Beta: true

-  CephAnsiblePlaybookVerbosity = If set to > 0, then the playbooks are kept (and the verbosity is enabled for the playbook).
-  CephAnsiblePoolDefaultSize = Set the replica size for each pool. Default: 3. Lab recommended: 1.
-  CephAnsibleDefaultPgNum = For a production environment, use `PGCalc <https://access.redhat.com/labs/cephpgc/>`__ to determine the optimal value. Set to a low number for a lab with 1 disk. Lab recommended: 32.
-  CephAnsibleExtraConfig: mon_host_v1: enabled: false = Force msgr2 (messenger v2). By default, both v1 and v2 are used, which causes issues in lab environments such as Standalone.

**Deployment (External)**

Use the ``environments/ceph-ansible-external.yaml`` Heat template.

TripleO Queens:

.. code-block:: yaml

   ---
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

[29]

Overcloud (cloud-init)
~~~~~~~~~~~~~~~~~~~~~~

Any Overcloud node that is provisioned and managed by Ironic and Nova can be configured using cloud-init configuration data.

.. code-block:: yaml

   ---
   parameter_defaults:
     OS::TripleO::NodeUserData: <CLOUD_INIT_CONFIG>.yml

Minions
~~~~~~~

Introduced in the Train release [47], the Undercloud can be scaled horizontally by using ``minion`` nodes to help with a large Overcloud deployment, update, or upgrade. This runs the "heat-engine" and "ironic-conductor" services on additional nodes. There are no limits to the number of minions that can be used. When not in use, minion nodes can be turned off. The only requirement is that all of the nodes are on the Control Plane network. The framework for the minion installer is based on the standalone installer.

-  Copy the required files from the Undercloud to the minions.

.. code-block:: sh

   $ scp tripleo-undercloud-outputs.yaml tripleo-undercloud-passwords.yaml <USER>@<MINION_MACHINE>

-  Install the TripleO packages.

.. code-block:: sh

   $ sudo yum install python3-tripleoclient

Configure the Minion node. The ``minion_local_ip`` and the ``minion_local_interface`` should be on the Overcloud control plane / provisioning network. The ``container_images_file`` should also use the same custom ``container-image-prepare.yaml`` file that the Undercloud uses (if applicable).

.. code-block:: sh

   $ cp /usr/share/python-tripleoclient/minion.conf.sample ~/minion.conf

Install the Minion services.

.. code-block:: sh

   $ openstack undercloud minion install

-  Verify the services are running as expected.

.. code-block:: sh

   $ source ~/stackrc
   $ openstack orchestration service list
   $ openstack baremetal conductor list

[44]

Scaling (Large Overcloud)
~~~~~~~~~~~~~~~~~~~~~~~~~

RHOSP 13 supports deploying 500 Overcloud nodes. This requires a few optimization tweaks to the Undercloud. Details about how to accomplish this can be found `here <https://www.redhat.com/en/blog/scaling-red-hat-openstack-platform-more-500-overcloud-nodes>`__. Set the ``NodeCreateBatchSize`` Heat parameter to a value equal to the number of Overcloud nodes. This will greatly decrease the initial Heat template processing time.

Puppet
~~~~~~

Puppet is used for configuring the OpenStack and operating system services.

-  Train = Puppet 5
-  Queens = Puppet 4
-  Newton = Puppet 3

Lab Tips
~~~~~~~~

These are trips and tricks for setting up a full, yet basic, TripleO cloud for testing the deployment.

-  Use the Standalone deployment or at least the minimum amount of nodes required for TripleO: 1 Undercloud, 1 Controller, and 1 Compute.
-  Use the most minimal resources required on the Overcloud nodes for a deployment.

   -  Controller: 4 vCPUs and 16GB RAM
   -  Compute: 2 vCPUs

      -  Pre-deployed: 2GB RAM
      -  Ironic provisioned: 4GB RAM

-  If using OpenStack as the lab infrastructure, disable port security to allow any MAC and IP address to be used. Also disable security groups to avoid further connection issues.

   ::

      $ openstack port set --disable-port-security --no-security-group <PORT>

-  Use the low resource usage template: ``environments/low-memory-usage.yaml``. This sets the ``worker`` count to 1 for all of the OpenStack services, lowers the Apache resource utilization (used as the CGI handler for OpenStack services), and configures low defaults for (optional) Ceph services.
-  Avoid using complex network templates such as ``environments/network-isolation.yaml`` and ``environments/network-environment.yaml``. By default, TripleO will use flat networking for all of the services and separate traffic using different subnets.
-  For virtual machines without nested virtualization, set the parameter ``NovaComputeLibvirtType`` to ``qemu``.
-  Use `this template <https://opendev.org/openstack/tripleo-heat-templates/src/commit/d2bcf0f530cade1ca65b90fbe91953dfb67958b0/ci/environments/scenario000-standalone.yaml>`__ (designed for Train) as a reference to prevent deploying unnecessary services on the Overcloud. That template will disable everything except Keystone. Alternatively, remove services from the ``roles_data.yaml`` file.
-  Disable Swift. Then use NFS as the back-end for Cinder, Glance, Gnocchi, and Nova based off of the configuration files from ``/usr/share/openstack-tripleo-heat-templates/environments/storage/*-nfs.yaml``. [51] Add the NFS mount option 'nosharecache' to address `this <https://bugzilla.redhat.com/show_bug.cgi?id=1513275>`__ bug.

   .. code-block:: yaml

     ---
     # Disable Swift
     resource_registry:
       OS::TripleO::Services::SwiftProxy: OS::Heat::None
       OS::TripleO::Services::SwiftStorage: OS::Heat::None
       OS::TripleO::Services::SwiftRingBuilder: OS::Heat::None

     parameter_defaults:
       ControllerExtraConfig:
         tripleo::haproxy::swift_proxy_server: false

   .. code-block:: yaml

      ---
      # Enable NFS back-ends
      resource_registry:
        OS::TripleO::Services::CephMgr: ~/templates/docker/services/ceph-ansible/ceph-mgr.yaml
        OS::TripleO::Services::CephMon: ~/templates/docker/services/ceph-ansible/ceph-mon.yaml
        OS::TripleO::Services::CephOSD: ~/templates/docker/services/ceph-ansible/ceph-osd.yaml
        OS::TripleO::Services::CephClient: ~/templates/docker/services/ceph-ansible/ceph-client.yaml

      parameter_defaults:
        # Cinder
        CinderBackupBackend: nfs
        CinderEnableIscsiBackend: false
        CinderEnableNfsBackend: true
        CinderEnableRbdBackend: false
        CinderNfsMountOptions: 'rw,sync,vers=4,minorversion=2,nosharecache,context=system_u:object_r:cinder_var_lib_t:s0'
        CinderNfsServers: '<NFS_SERVER_IP>:/exports/cinder'
        # Glance
        GlanceBackend: file
        GlanceNfsEnabled: true
        GlanceNfsOptions: 'rw,sync,vers=4,minorversion=2,nosharecache,context=system_u:object_r:glance_var_lib_t:s0'
        GlanceNfsShare: '<NFS_SERVER_IP>:/exports/glance'
        # Gnocchi
        GnocchiBackend: file
        # Nova
        NovaNfsEnabled: true
        NovaEnableRbdBackend: false
        NovaNfsOptions: 'rw,sync,vers=4,minorversion=2,nosharecache,context=system_u:object_r:nfs_t:s0'
        NovaNfsShare: '<NFS_SERVER_IP>:/exports/nova'

   -  TripleO will not create or manage an NFS server. If using the Undercloud as the NFS server, the firewall ports for the service will need to be opened.

      .. code-block:: sh

         $ sudo iptables -I INPUT -p tcp -m tcp --dport 111 -j ACCEPT
         $ sudo iptables -I INPUT -p tcp -m tcp --dport 2049 -j ACCEPT
         $ sudo iptables -I INPUT -p udp -m udp --dport 111 -j ACCEPT
         $ sudo iptables -I INPUT -p udp -m udp --dport 2049 -j ACCEPT
         $ sudo iptables-save | sudo tee /etc/sysconfig/iptables

Troubleshooting
---------------

Tips
~~~~

-  Disable the Extra Packages for Enterprise Linux (EPEL) and Puppet Labs repositories if these are available. These will cause package conflicts and result in the installation of wrong dependencies.
-  If a deployment fails, view the config-download playbook errors: ``$ openstack overcloud failures list``.
-  If highly-available (HA) services on the Controller nodes are stopped or not working, cleanup and restart the affected resources managed by Pacemaker.

.. code-block:: sh

   $ sudo pcs status
   $ sudo crm_resource -C <RESOURCE_BUNDLE>
   $ sudo pcs resource restart <RESOURCE_BUNDLE>

-  Changes can be made to a container manually for testing. For permanent changes, use the `containers-prepare-parameter.yaml <https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/container_image_prepare.html>`__ file.

.. code-block:: sh

   $ sudo systemctl stop tripleo_<SERVICE>
   $ sudo vim /var/lib/config-data/puppet-generated/<CONTAINER_NAME>/etc/foo/bar.conf
   $ sudo vim /var/lib/config-data/puppet-generated/<CONTAINER_NAME>/etc/httpd/conf.d/10-<SERVICE>_wsgi.conf
   $ sudo systemctl start tripleo_<SERVICE>

-  Puppet variables can be retrieved from Hieradata on both the Undercloud and Overcloud nodes. Example:

.. code-block:: sh

   $ sudo hiera -c /etc/puppet/hiera.yaml mysql::server::root_password

-  Enable various parameters to assist with debugging.

   .. code-block:: yaml

      ---
      parameter_defaults:
        ContainerHealthcheckDisabled: true
        ContainerImagePrepareDebug: true
        # Enable 'Debug' logging for all OpenStack services.
        Debug: true
        SELinuxMode: permissive

Errors
~~~~~~

"**No valid host was found**" when running ``openstack overcloud deploy``.

::

   <OVERCLOUD_STACK_NAME>.<ROLE_TYPE>.<NODE_INDEX>.<ROLE_NAME>: resource_type: OS::TripleO::<ROLE_TYPE>Server physical_resource_id: <RESOURCE_ID> status: CREATE_FAILED status_reason: | ResourceInError: resources.<ROLE_NAME>: Went to status ERROR due to "Message: No valid host was found. There are not enough hosts available., Code: 500"

::

   overcloud.Controller.0.Controller: resource_type: OS::TripleO::ControllerServer physical_resource_id: 2e41f61b-8f3c-4fed-a523-0e56a7a88ecc status: CREATE_FAILED status_reason: | ResourceInError: resources.Controller: Went to status ERROR due to "Message: No valid host was found. There are not enough hosts available., Code: 500"

::

   overcloud.Compute.0.NovaCompute: resource_type: OS::TripleO::ComputeServer physical_resource_id: ab29fe63-4103-4afd-bc95-9a9e720920ed status: CREATE_FAILED status_reason: | ResourceInError: resources.NovaCompute: Went to status ERROR due to "Message: No valid host was found. There are not enough hosts available., Code: 500"

::

   overcloud.BlockStorage.0.BlockStorage: resource_type: OS::TripleO::BlockStorageServer physical_resource_id: 7640f169-7790-4b73-9006-8171ddd450e4 status: CREATE_FAILED status_reason: | ResourceInError: resources.BlockStorage: Went to status ERROR due to "Message: No valid host was found. There are not enough hosts available., Code: 500"

-  All Overcloud nodes are required to have been successfully introspected.

   -  If introspection is failing with a kernel panic, ensure the nodes have at least 4GB of RAM.

-  All nodes must have "Maintenance" mode set to "False" and be in the "Provisioning State" of "available" .

   .. code-block:: sh

      $ openstack baremetal node list
      $ openstack baremetal node maintenance unset <BAREMETAL_NODE>
      $ openstack baremetal node provide <BAREMETAL_NODE>

-  All Overcloud nodes require a `profile tag <https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/provisioning/profile_matching.html>`__ that will determine what type of node it will be.

   -  Manually set the profile type for each node: block-storage, ceph-storage, compute, control, or swift-storage.

      .. code-block:: sh

          $ openstack baremetal node set --property capabilities='profile:<PROFILE_TYPE>,boot_option:local' <BAREMETAL_NODE>

-  Ensure that each ``<ROLE_NAME>Count:`` Heat parameter is correctly set to the number of nodes that are available.

----

"**StackValidationFailed: The Resource Type (OS::TripleO::<ROLE>::<RESOURCE>) could not be found.**" when running ``openstack overcloud deploy``.

-  The <ROLE> needs to be set to a valid role defined in the ``roles_data.yaml`` file.
-  The ``resource_registry`` mapping must link a resource type to a file ending with the ``.yaml`` extension (``.yml`` will not work). Example:

   .. code-block:: yaml

      ---
      resource_registry:
        OS::TripleO::ControllerDeployedServer::Net::SoftwareConfig: net-config-static-bridge.yaml

-  The resource type may be undefined. That means a THT template is missing and needs to be included as part of the deployment.
-  The resource type may be misspelled.

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/openstack/tripleo.rst>`__
-  `< 2020.01.01 (OpenStack) <https://github.com/ekultails/rootpages/commits/master/src/virtualization/openstack.rst>`__
-  `< 2019.01.01 (OpenStack) <https://github.com/ekultails/rootpages/commits/master/src/openstack.rst>`__
-  `< 2018.01.01 (OpenStack) <https://github.com/ekultails/rootpages/commits/master/markdown/openstack.md>`__

Bibliography
------------

1. "Red Hat OpenStack Platform Life Cycle." Red Hat Support. Accessed February 17, 2020. https://access.redhat.com/support/policy/updates/openstack/platform
2. "Frequently Asked Questions." RDO Project. Accessed December 21, 2017. https://www.rdoproject.org/rdo/faq/
3. "Director Installation and Usage." Red Hat OpenStack Platform 13 Documentation. September 26, 2018. Accessed September 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/pdf/director_installation_and_usage/Red_Hat_OpenStack_Platform-13-Director_Installation_and_Usage-en-US.pdf
4. "Packstack: Create a proof of concept cloud." RDO Project. Accessed March 19, 2018. https://www.rdoproject.org/install/packstack/
5. "Neutron with existing external network. RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/networking/neutron-with-existing-external-network/
6. "Error while installing openstack 'newton' using rdo packstack." Ask OpenStack. October 25, 2016. Accessed September 28, 2017. https://ask.openstack.org/en/question/97645/error-while-installing-openstack-newton-using-rdo-packstack/
7. "TripleO quickstart." RDO Project. Accessed March 26, 2018. https://www.rdoproject.org/tripleo/
8. "[TripleO] Minimum System Requirements." TripleO Documentation. September 7, 2016. Accessed March 26, 2018. https://images.rdoproject.org/docs/baremetal/requirements.html
9. [RDO] Recommended hardware." RDO Project. Accessed September 28, 2017. https://www.rdoproject.org/hardware/recommended/
10. "[TripleO] Virtual Environment." TripleO Documentation. Accessed September 28, 2017. http://tripleo-docs.readthedocs.io/en/latest/environments/virtual.html
11. "Getting started with TripleO-Quickstart." OpenStack Documentation. Accessed December 20, 2017. https://docs.openstack.org/tripleo-quickstart/latest/getting-started.html
12. "TripleO Documentation." OpenStack Documentation. Accessed September 12, 2017. https://docs.openstack.org/tripleo-docs/latest/
13. "Basic Deployment (CLI)." OpenStack Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/install_overcloud.html
14. "Bug 1466744 - Include docker.yaml and docker-ha.yaml environment files by default." Red Hat Bugzilla. December 13, 2017. Accessed January 12, 2018. https://bugzilla.redhat.com/show_bug.cgi?id=1466744
15. "Baremetal Environment." TripleO OpenStack Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/environments/baremetal.html
16. "Does Red Hat Ceph support migration from FileStore to BlueStore with the release of RHCS 3.2?" Red Hat Customer Portal. May 23, 2019. Accessed October 28, 2019. https://access.redhat.com/articles/3793241
17. "Configuring Ceph with Custom Config Settings." OpenStack Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/features/ceph_config.html
18. "[Ironic] Enabling drivers." OpenStack Documentation. March 15, 2018. Accessed March 15, 2018. https://docs.openstack.org/ironic/queens/admin/drivers.html
19. "CHAPTER 8. SCALING THE OVERCLOUD." Red Hat Documentation. Accessed January 30, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/10/html/director_installation_and_usage/sect-scaling_the_overcloud
20. "Containers based Undercloud Deployment." OpenStack Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/undercloud.html
21. "[TripleO Quickstart] Networking." TripleO Documentation. September 7, 2016. Accessed April 9, 2018. https://images.rdoproject.org/docs/baremetal/networking.html
22. "Repository Enablement." OpenStack TripleO Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/repositories.html
23. "TripleO: Using the fake_pxe driver with Ironic." Leif Madsen Blog. November 11, 2016. Accessed June 13, 2018. http://blog.leifmadsen.com/blog/2016/11/11/tripleo-using-the-fake_pxe-driver-with-ironic/
24. "Bug 1535214 - baremetal commands that were deprecated in Ocata have been removed in Queens." Red Hat Bugzilla. Accessed June 13, 2018. https://bugzilla.redhat.com/show_bug.cgi?id=1535214
25. "OpenStack lab on your laptop with TripleO and director." Tricky Cloud. November 25, 2015. Accessed June 13, 2018. https://trickycloud.wordpress.com/2015/11/15/openstack-lab-on-your-laptop-with-tripleo-and-director/
26. "Director Installation and Usage." Red Hat OpenStack Platform 10 Documentation. Accessed July 18, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/10/html/director_installation_and_usage/
27. "Director Installation and Usage." Red Hat OpenStack Platform 13 Documentation. Accessed July 18, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/
28. "Red Hat OpenStack Platform 13 Release Notes." Red Hat OpenStack Platform 13 Documentation. September 20, 2018. Accessed September 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/pdf/release_notes/Red_Hat_OpenStack_Platform-13-Release_Notes-en-US.pdf
29. "Use an external Ceph cluster with the Overcloud." TripleO Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/features/ceph_external.html
30. "TRIPLEO AND ANSIBLE: CONFIG-DOWNLOAD WITH ANSIBLE TOWER (PART 3)." Slagle's Blog. June 1, 2018. Accessed October 3, 2018. https://blogslagle.wordpress.com/2018/06/01/tripleo-and-ansible-config-download-with-ansible-tower-part-3/
31. "Configuring Network Isolation." TripleO Documentation. January 30, 2020. Accessed February 5, 2020. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/features/network_isolation.html
32. "Modifying default node configuration." TripleO Documentation. Accessed October 28, 2019. http://tripleo.org/install/advanced_deployment/node_config.html
33. "Containers based Overcloud Deployment." OpenStack Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/overcloud.html
34. CHAPTER 12. REBOOTING NODES." Red Hat OpenStack Platform 13 Documentation. Accessed January 28, 2019. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/sect-rebooting_the_overcloud
35. "Bootstrap." InfraRed Documentation. Accessed February 8, 2019. https://infrared.readthedocs.io/en/stable/bootstrap.html
36. "CHAPTER 8. CONFIGURING A BASIC OVERCLOUD USING PRE-PROVISIONED NODES." Red Hat Documentation. Accessed January 28, 2020. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/chap-configuring_basic_overcloud_requirements_on_pre_provisioned_nodes
37. "Using Already Deployed Servers." OpenStack Documentation. January 30, 2020. Accessed February 4, 2020. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/features/deployed_server.html
38. "CHAPTER 4. INSTALLING THE UNDERCLOUD." Red Hat Documentation. Accessed April 1, 2019. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/installing-the-undercloud
39. "CHAPTER 10. CONFIGURING THE OVERCLOUD WITH ANSIBLE." Red Hat Documentation. Accessed May 14, 2019. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/configuring-the-overcloud-with-ansible
40. "Evaluating OpenStack: Single-Node Deployment." Red Hat Knowledgebase. October 5, 2018. Accessed May 15, 2019. https://access.redhat.com/articles/1127153
41. "TripleO config-download User’s Guide: Deploying with Ansible." OpenStack Documentation. October 25, 2019. Accessed October 28, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/ansible_config_download.html
42. "CHAPTER 3. PREPARING FOR DIRECTOR INSTALLATION." Red Hat RHOSP 15 Documentation. Accessed September 26, 2019. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/15/html/director_installation_and_usage/preparing-for-director-installation
43. "The road ahead for the Red Hat OpenStack Platform." Red Hat Blog. August 20, 2019. Accessed September 26, 2019. https://www.redhat.com/en/blog/road-ahead-red-hat-openstack-platform
44. "Installing a Undercloud Minion." OpenStack Documentation. October 29, 2019. Accessed November 1, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/features/undercloud_minion.html
45. "CHAPTER 3. PLANNING YOUR OVERCLOUD." Red Hat Documentation. Accessed November 20, 2019. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/chap-planning_your_overcloud
46. "Configuring High Availability." tripleo-docs. November 20, 2019. Accessed November 20, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/features/high_availability.html
47. "Scale Undercloud with a Minion." tripleo-docs. May 3, 2019. Accessed December 3, 2019. https://specs.openstack.org/openstack/tripleo-specs/specs/train/undercloud-minion.html
48. "Understanding undercloud/standalone stack updates." tripleo-docs. December 19, 2019. Accessed December 19, 2019. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/post_deployment/updating-stacks-notes.html
49. "Deleting Overcloud Nodes." TripleO Documentation. January 30, 2020. Accessed January 30, 2020. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/post_deployment/delete_nodes.html
50. "Scaling the Overcloud. Red Hat OpenStack Platform 13 Documentation. Accessed January 30, 2020. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/director_installation_and_usage/sect-scaling_the_overcloud
51. "Chapter 19. Storage Configuration." Red Hat OpenStack Platform 13 Documentation. Accessed February 5, 2020. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/advanced_overcloud_customization/storage_configuration
52. "TripleO Architecture." TripleO Documentation. August 16, 2019. Accessed February 6, 2020. https://docs.openstack.org/tripleo-docs/latest/install/introduction/architecture.html
53. "Overview of available RDO repos." RDO Project. January 27, 2018. Accessed February 6, 2020. https://www.rdoproject.org/what/repos/
54. "Workflow: RDO Trunk repo." RDO Project. May 24, 2019. Accessed February 6, 2020. https://www.rdoproject.org/what/trunk-repos/
55. "Director Installation and Usage." Red Hat OpenStack Platform 16.0 Documentation. Accessed February 7, 2020. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/16.0/html/director_installation_and_usage/index
56. "Ensure config-download mappings are unset on ceph-upgrade." OpenDev openstack/tripleo-heat-templates. April 27, 2018. Accessed February 10, 2020. https://opendev.org/openstack/tripleo-heat-templates/commit/24469e3c02747b7b6de6d61fcf2a8b9be67b370b
57. "TripleO Project Specifications." TripleO Documentation. October 16, 2019. Accessed February 17, 2020. https://specs.openstack.org/openstack/tripleo-specs/
58. "Blueprints for tripleo." tripleo Launchpad. Accessed February 17, 2020. https://blueprints.launchpad.net/tripleo
59. "CHAPTER 7. CONFIGURING A BASIC OVERCLOUD WITH CLI TOOLS." Red hat RHOSP 16 Documentation. Accessed April 21, 2020. https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/16.0/html/director_installation_and_usage/creating-a-basic-overcloud-with-cli-tools
60. "Building a Single Image." TripleO Documentation. April 20, 2020. Accessed April 21, 2020. https://docs.openstack.org/project-deploy-guide/tripleo-docs/latest/deployment/build_single_image.html
61. "Network Configuration with os-net-config." Ales Nosek - The Software Practitioner. September 28, 2015. Accessed May 4, 2020. http://alesnosek.com/blog/2015/09/28/network-configuration-with-os-net-config/
62. "Linux Bridge Container Permission Issues. Launchpad Bugs tripleo. May 4, 2020. Accessed May 4, 2020. https://bugs.launchpad.net/tripleo/+bug/1862179
