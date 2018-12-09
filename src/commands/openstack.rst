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

   "node list", "list all bare-metal servers deployed by Ironic"
   "node manage <NODE>", "place a node into the ""manageable"" state"
   "node provide <NODE>", "place a node into the ""available"" state"

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

openstack overcloud
~~~~~~~~~~~~~~~~~~~

Mange the Overcloud from a TripleO deployment of OpenStack.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "execute -s overcloud <SCRIPT>", "excute a script on all of the Overcloud nodes"

tripleo-ansible-inventory
~~~~~~~~~~~~~~~~~~~~~~~~~

Create dynamic inventory for Ansible to manage the Undercloud and Overcloud infrastructure of a TripleO deployment.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--list", "list the entire inventory"

`History <https://github.com/ekultails/rootpages/commits/master/src/commands/openstack.rst>`__
----------------------------------------------------------------------------------------------
