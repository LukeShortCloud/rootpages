OpenStack
=========

.. contents:: Table of Contents

See also: Administrative, MySQL, Networking

Utilities
---------

openstack-service
~~~~~~~~~~~~~~~~~~

Used for managing the OpenStack service states using the system's "init" utility.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "status", "show the status of the enabled OpenStack services"
   "restart", "restart the enabled OpenStack services"

openstack-status
~~~~~~~~~~~~~~~~

Package: openstack-utils

Show the status of all services and details about them using the operating system's "init" utility. This provides a more human readable format than ``openstack-service status``.

openstack-config (crudini)
~~~~~~~~~~~~~~~~~~~~~~~~~~

CLI tool to modify configuration files for OpenStack (Create, Read, Update, and Delete ini configuration files)

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--get", "show all sections"
   "--get --format=lines <FILE>", "show variables set in a specified configuration file"
   "--set <FILE> <SECTION> <VARIABLE> <NEWVALUE>", "update a value inside of a configuration"

ostestr
~~~~~~~

Tool for checking the stability of all of OpenStack's APIs using Tempest.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "specify a specific API to test"
   "--regex '(?!.*\[.*\bslow\b.*\])(^tempest\.(api|scenario))'", "show only if the test passes with ""ok"" or fails with ""FAILED"""
   "--parallel", "spawn multiple users for faster testing"
   "--list", "show all of the tests that will be run"
   "--no-discover", "lowers the overhead of single unit testing"
   "run --failing", "rerun failed tests"

ospurge
~~~~~~~

This tool is used to remove all resources from a project and then delete it.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--cleanup-project", "specify the project to remove resources from"
   "--own-project", "remove everything from the current project that is being used for authentication"
   "--dont-delete-project", "do not remove the project"

openstack
~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--all-projects", "when used with some options, it will show all resources created"
   "--format {csv|json|table|value|yaml}", "format the output with one of these data structures"
   --log-file <FILE_NAME>, save the stdout and stderr to a text file
   --quiet, run with no verbosity (the default is 1 verbosity)
   -v, run with double verbosity

packstack
~~~~~~~~~~

Used to deploy a proof of concept all-in-one OpenStack cloud.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--allinone", "do an all-in-one deploy, no configuration file is needed"
   "--gen-answer-file <FILE>", "create an answer file to customize the configuration"
   "--answer-file <FILE>", "use the specified answer file"
   "--timeout", "specify a longer timeout for the Puppet modules"

Keystone
--------

openstack user
~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "show a list of users"

openstack project
~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "project list", "show tenants/projects"
   "user create --project <PROJECT_ID> --password <PASSWORD> <USER_NAME>", "create a new user"
   "user set <USER_NAME>", "update a user's account"
   "purge", "delete a project and all of it s resources"
   "purge --keep-project", "delete all of the resources in project but do not delete the project itself"
   "purge --dry-run", "show what resources would be deleted from the purge"

openstack role
~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "show all roles"
   "show <ROLE>", "show all roles available"
   "add --user <USER> --project <PROJECT> <ROLE>", "assign a user to a project by giving them a role to it; default roles include ""user"" and ""admin"""

openstack token
~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "issue", "create a new token"
   "revoke", "disable a specified token"

openstack endpoint
~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "show all of the endpoints and their URLs"

Glance
------

openstack image
~~~~~~~~~~~~~~~

Package: python-glanceclient

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "create", "upload an image to Glance"
   "list", "show all of the available images"
   "set <IMAGE_ID>", "modify the metadata of an existing image"
   "save --file", "download an image and save it as a specified file name"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "create --public --disk-format=qcow2 --file /var/lib/libvirt/images/RHEL7.6.qcow2 --container-format=bare RHEL7.6", "create and upload a RHEL image to Glance"

Cinder
------

openstack volume
~~~~~~~~~~~~~~~~

Package: python-cinderclient

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "list all of the volumes"
   "list --all-projects", "list the volumes for all projects"
   "state --state {creating|deleting|in-use|attaching|detaching|error|error_deleting|maintenance}", "forcefully change the state of a volume as the admin user"

Nova
----

openstack host
~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "show all controller and compute nodes"
   "show <HOST>", "show all projects and their resource usage on a specific compute node"

openstack hypervisor
~~~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   stats show, show the used and available resources on the compute nodes

openstack console
~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "log show", "display the console log for an instance"
   "url show", "display the URL to access the remote console"

openstack usage
~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "shows allocated data usage for all instances"

openstack keypair
~~~~~~~~~~~~~~~~~

Manage SSH keys.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   create <KEY_NAME>, create a new public and private key
   create --public-key ~/.ssh/id_rsa.pub <KEY_NAME>, import an existing public key

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   openstack keypair create shared_key > shared_key.pem, create and save the private key into a file

openstack server
~~~~~~~~~~~~~~~~

Package: python-novaclient

Manage virtual machine instances.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "list instances for the current project"
   "list --host <HOST>", "show all instances on a specific host"
   "list --all-projects", "list all instances managed by Nova"
   "create --flavor <FLAVOR> --image <IMAGE> --key-name <PUBLIC_KEY_NAME> --security-group <SEC_GROUP> --nic net-id=<NETWORK> <NAME>", "create a new instance"
   "--availability-zone <ZONE>:<HOST>", "spawn an instance on a specific hypervisor host"
   "--user-data", "load a custom cloud-init configuration file"
   "pause", "freeze a server's state"
   "resume", "resume a paused server"
   "start", "start server"
   "stop", "stop server"
   "reboot", "reboot server"
   "delete", "delete an instance"
   "show", "show detailed information about an instance"
   "rescue --image <IMAGE>", "boot up a live environment with a specific image attached to an instance"

nova
~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "evacuate", "live migrate one or all instances from one compute host to another"
   "migrate", "migrate all instances from one compute node to another after shutting down the instances"
   "force-delete", "forcefully delete an instance"
   "set-password", "change root password"

Neutron
-------

openstack port-*
~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "port-create", "create port"
   "port-delete", "delete port"

openstack firewall
~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "group rule list", "show firewall rules"
   "group rule show", "show information about a specific firewall rule"

openstack floating ip
~~~~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "floatingip-create", "add public IP to pool"
   "floatingip-delete", "remove public IP from pool"
   "floatingip-associate", "add public IP to VM"
   "floatingip-disassociate", "remove public IP from VM"

openstack network
~~~~~~~~~~~~~~~~~

Package: python-neutronclient

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "create", "create a network"
   "delete", "delete a network"
   "list", "show all networks"
   "set", "change the setting of a network"
   "show", "show details about a given network"
   "agent list", "show all Neutron related services and if they are running"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "create --provider:network_type={flat|vlan|vxlan|gre} --provider:physical_network=<PHY_DEVICE_MAP> --shared <NEW_NETWORK_NAME>", "create a public network tied to a physical interface"

neutron
~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "purge", "delete all Neutron objects in a given project"
   "dhcp-agent-list-hosting-net", "show all DHCP agents and their status for a given network"
   "dhcp-agent-network-remove", "disable a DHCP agent"
   "dhcp-agent-network-add", "re-enable a DHCP agent"
   "lbaas-loadbalancer-create <SUBNET>", "create a load balancer tied to a subnet"
   "lbaas-listener-create --loadbalancer <LOADBALANCER> --protocol TCP --protocol-port=<PORT>", "create a listener/rule for the load balancer"
   "lbaas-pool-create --lb-algorithm ROUND_ROBIN --listener <LISTENER> --protocol TCP", "create a pool tied to a listener"
   "lbaas-member-create --subnet <SUBNET> --address <IPADDRESS> --protocol-port <PORT> <POOL>", "add IPs to the pool to load balancer"
   "floatingip-create ext-net --port-id <PORTID>", "associate a floating IP with the load balancer's VIP port"

Ironic
-------

openstack baremetal
~~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   node list, list all bare-metal servers deployed by Ironic
   node list --long, list but with all of the details of each node
   node maintenance set <NODE>, turn maintenance mode on to disallow it from having health checks or being in new deployments
   node maintenance unset <NODE>, turn off maintenance mode
   node manage <NODE>, place a node into the ""manageable"" state to allow for introspection
   node provide <NODE>, place a node into the ""available"" state to allow for deployment
   node unset <NODE> --property capabilities, remove all capabilities
   node clean <NODE>, zero out all of the storage devices managed by Ironic
   "node clean --clean-steps '[{""interface"": ""deploy"", ""step"": ""erase_devices_metadata""}]' <NODE>", only clean the partition table metadata
   node vif list <NODE>, show all virtual interfaces from Neutron that are attached
   node vif detach <VIF> <NODE>, detatch a virtual interface from the node
   introspection abort <NODE>, stop introspection
   introspection data save <NODE>, display the JSON output of the introspection data for a specific node
   introspection interface list <NODE>, list all of the network interfaces found during introspection

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "openstack baremetal introspection data save <NODE> | python -m json.tool", view the introspection data in a human readable format

Ceilometer
----------

ceilometer
~~~~~~~~~~

Package: python-ceilometerclient

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "meter-list", "show available meters"
   "meter-list --query project=<PROJECT_ID>", "call this after the first ceilometer option (i.e. meter-list) to show all related results for a specific project"

Heat
----

openstack stack
~~~~~~~~~~~~~~~

Manage Heat stacks.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--wait", "wait for the stack to be created before returning the user to their shell prompt"
   "list", "show all of the Heat stacks in use"

Swift
-----

openstack object
~~~~~~~~~~~~~~~~

Package: python-swiftclient

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "list", "list all containers"
   "upload <CONTAINER> <FILE>", "upload a file to a container"
   "save <CONTAINER> <FILE>", "download a file from a Swift container"

TripleO
-------

openstack undercloud
~~~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   install, install the Undercloud using the ~/undercloud.conf configuration file
   minion install, (>= Train) install Minion services (minimal Heat and Ironic) on another Undercloud node
   upgrade, update the Undercloud to the latest minor version or upgrade to the latest major version (based on which packages are available)
   upgrade --skip-package-updates, do not update the RPM packages (in case they have already been updated manually)
   upgrade --no-validations, do not run upgrade validations

openstack overcloud
~~~~~~~~~~~~~~~~~~~

Mange the Overcloud from a TripleO deployment of OpenStack.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   execute -s overcloud <SCRIPT>, execute a script on all of the Overcloud nodes
   node import instackenv.json, import the Overcloud nodes based on an Ironic template (they will be in the manageable state)
   node import --provide instackenv.json, "import the Overcloud nodes in the ""available"" state so they can be introspected"
   node import --introspect --provide instackenv.json, "import the Overcloud nodes in the ""available"" state after automatically doing introspection"
   node introspect --all-manageable, introspect all existing nodes
   node introspect --all-manageable --provide, introspect all existing nodes and automatically place them in the ""available"" state when done
   node provide --all-manageable, change all Overcloud nodes that are in a ""manageable"" state into an ""available"" state
   profiles list, show the Nova flavors in use for each node
   profiles match --control-flavor <FLAVOR> --control-scale <INTEGER> --compute-flavor <FLAVOR> --compute-scale <INTEGER>, see which nodes will match the flavor and scale of nodes specified
   delete overcloud, delete the Overcloud stack and cleanup other generated resources (this is preferred over `openstack stack delete overcloud`)

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   profiles match --control-flavor control --control-scale 3 --compute-flavor compute --compute-scale 2, show which nodes would be matched for a deployment with 3 controller nodes and 2 compute nodes

openstack overcloud deploy
''''''''''''''''''''''''''

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --stack <STACK_NAME>, provide a custom stack name (default: overcloud)
   --templates, the path to the Heat templates directory
   -e, the path to an additional Heat template
   "--{control,compute}-flavor <FLAVOR>", "REMOVED IN TRAIN, use Heat template variables instead. Assign a custom flavor profile."
   --override-ansible-cfg, provide a custom Ansible configuration file for config-download

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   --stack production --templates /home/stack/templates -e /home/stack/templates/environments/low-memory.yaml, deploy an Overcloud stack named production that will use the default settings and low memory settings for the services

openstack overcloud update
''''''''''''''''''''''''''

Handle minor version updates.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   prepare, Update the Heat stack based on the latest TripleO Heat templates.
   run --limit <NODE>, Run the minor update Ansible tasks.
   converge, Re-enable all of the original (non-update) Ansible tasks for the deployment.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   run --limit all, Run the update on every node.

openstack overcloud upgrade
'''''''''''''''''''''''''''

Handle major version upgrades.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   prepare, Update the Heat stack based on the latest TripleO Heat templates.
   run --limit <NODE>, Run the major upgrade Ansible tasks.
   converge, Re-enable all of the original (non-upgrade) Ansible tasks for the deployment.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   run --limit Compute, Run the upgrade on all of the Compute nodes.

openstack tripleo
~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   container image push, (>= Train) push a local container image to the local Undercloud container registry

tripleo-ansible-inventory
~~~~~~~~~~~~~~~~~~~~~~~~~

Create dynamic inventory for Ansible to manage the Undercloud and Overcloud infrastructure of a TripleO deployment.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--list", "list the entire inventory"

InfraRed
--------

infrared
~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   ssh <NODE>, "ssh into a node (examples: undercloud-0, controller-2, compute-1, etc.)"

infrared plugin
~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   list, list the installed plugins
   list --available, list all of the plugins that can be installed
   add plugins/<PLUGIN>, install a new plugin
   add all, install all of the plugins
   remove <PLUGIN> <PLUGIN2>, delete one or more plugins
   remove all, delete all of the plugins
   update <PLUGIN>

infrared virsh
~~~~~~~~~~~~~~

Manage the creation or deletion of a virtual lab environment using ``virsh``.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --host-address <IP_ADDRESS>, the hypervisor address to access via SSH
   --host-user <SSH_USER>, the hypervisor SSH user
   --host-key <SSH_KEY_FILE>, the private SSH key file to use
   --host-validate no, do not attempt to enable hardware virtualization on the hypervisor
   --host-memory-overcommit yes, allow the hypervisor to run virtual machines that may consume more RAM then what is available
   --topology <TOPOLOGY>, specify the topology of what nodes should be deployed and how many

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "--host-address 127.0.0.1 --host-key ~/.ssh/id_rsa --topology-nodes ""undercloud:1,controller:3,compute:2""", deploy 5 virtual machines for an InfraRed lab

infrared openstack
~~~~~~~~~~~~~~~~~~

Manage a virtual TripleO lab environment using OpenStack instances.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --cloud ${OS_CLOUD}, the OpenStack cloud credentials to use
   --prefix <OPTIONAL_RESOURCE_PREFIX>, a prefix for all virtual resources (allows for multiple lab environments)
   --key-file ~/.ssh/id_rsa, the public SSH key that should be added to the Undercloud ``~/.ssh/authorized_keys`` file
   "--topology-network 3_nets_ovb --topology-nodes 'ovb_undercloud:1,ovb_controller:1,ovb_compute:1'", use Open Virtual Baremetal (OVB)
   --anti-spoofing False, allow spoofing to allow any IP address and MAC to be used on a Neutron network
   "--dns <DNS1>,<DNS2>", custom DNS servers for the Undercloud
   --provider-network <EXTERNAL_PROVIDER_NETWORK>, the provider network that will be used to assign floating IP addresses from
   --image <RHEL_OR_CENTOS>, the operating system image to use
   --username <SSH_USER>, the SSH user that is configured in the image

infrared tripleo-undercloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Manage the installation of the Undercloud.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --version, the RHOSP version number or RDO release name
   "--enable-testing-repos {all,rhel,extras,ceph}", enable pre-release repositories
   --cdn <FILE>, specify a file with a valid Red Hat subscription credentials
   --images-task rpm, install RHOSP via RPM repositories
   --images-task import --images-url=<URL>, install RDO via importing an existing Overcloud virtual machine image
   --images-task build, use a RHEL or CentOS guest virtual machine image as a base to build an Overcloud image from
   "--ntp-server <NTP_SERVER1>,<NTP_SERVER2>", specify custom NTP servers for the Undercloud

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   --images-task=import --version rocky --images-url=https://images.rdoproject.org/rocky/rdo_trunk/current-tripleo-rdo/, install a RDO Rocky Undercloud and setup the Overcloud image by importing a pre-built image

infrared tripleo-overcloud
~~~~~~~~~~~~~~~~~~~~~~~~~~

Manage the deployment of the Overcloud.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --deployment-files <DIRECTORY>, the path to the TripleO Heat templates to deploy with
   --deployment-files virt, use the default Infrared Overcloud Heat templates
   --version, the RHOSP version number or RDO release name
   --introspect yes, introspect the Overcloud nodes
   --tagging yes, tag the Overcloud nodes
   --deploy yes, deploy the Overcloud

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   --deploy-files virt --version 14 --introspect yes --tagging yes --deploy yes, fully deploy a RHOSP 14 Overcloud

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/commands/openstack.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_commands/openstack.rst>`__
