Kolla
======

.. contents:: Table of Contents

Overview
--------

Kolla contains three projects [1]:

-  Kolla = Tools for building OpenStack service containers.
-  Kolla Ansible = Deployment tool for Kolla containers.
-  Kayobe = Baremetal node provisioning using Kolla, Kolla Ansible, and Bifrost.

Releases
--------

.. csv-table::
   :header: Kolla-Ansible, OpenStack
   :widths: 20, 20

    1, Liberty
    2, Mitaka
    3, Newton
    4, Ocata
    5, Pike
    6, Queens
    7, Rocky
    8, Stein
    9, Train
    10, Ussuri

[2]

Kolla-Ansible
-------------

Operating systems:

-  Supported: CentOS/RHEL, Debian, Ubuntu
-  Recommended: CentOS/RHEL 8 or Ubuntu 18.04

Kolla-Ansible supports managing different types of nodes. Each node is a defined as a group in Ansible.

Node types [3]:

-  Control = OpenStack APIs
-  Network = Neutron agents
-  Compute = Hypervisors
-  Storage = Cinder or Swift
-  Monitoring = Monitoring services

Deployment (Quick)
~~~~~~~~~~~~~~~~~~

Requirements: 1 vCPU, 8GB RAM, 40GB storage space, and 2 network interfaces

This covers how to install an all-in-one OpenStack installation using the Train release of Kolla-Ansible and CentOS 8.

Install dependencies for Kolla-Ansible:

.. code-block:: sh

   $ sudo yum install gcc libffi-devel openssl-devel python3-devel python3-libselinux python3-virtualenv

Create and activate a Python virtual environment. This is to isolate the dependencies and avoid breaking Python packages installed by RPMs.

.. code-block:: sh

   $ virtualenv ~/kolla-ansible
   $ source ~/kolla-ansible/bin/activate

Install Kolla-Ansible:

.. code-block:: sh

   $ pip install -U pip setuptools
   $ pip install 'ansible<2.10'
   $ pip install 'kolla-ansible<10'

Kolla-Ansible does not support SELinux. However, if SELinux is in permissive mode then Ansible will complain if the ``selinux`` Python library is not installed. [4]

.. code-block:: sh

   $ pip install selinux

Copy over the configuration files and sample inventory:

.. code-block:: sh

   $ sudo mkdir -p /etc/kolla
   $ sudo chown $USER:$USER /etc/kolla
   $ cp -r ~/kolla-ansible/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
   $ cp ~/kolla-ansible/share/kolla-ansible/ansible/inventory/* .

Generate passwords. These will be stored in ``/etc/kolla/passwords.yml``.

.. code-block:: sh

   $ kolla-genpwd

Modify the main configuration file ``/etc/kolla/globals.yml``.

::

   kolla_base_distro: "centos"
   kolla_install_type: "source"
   network_interface: "eth0"
   # This interface has to be different than 'network_interface'.
   neutron_external_interface: "eth1"
   # This IP address will be used to access the OpenStack services.
   # It should be an unallocated IP address.
   kolla_internal_vip_address: "<EXTERNAL_IP>"

Configure the inventory to use the Python binary in the virtual environment. This is required to import and use the ``docker`` Python library since there is no packaged RPM for it on EL8.

.. code-block:: sh

   $ vim all-in-one

::

   [control]
   localhost       ansible_connection=local ansible_python_interpreter=/root/kolla-ansible/bin/python3
   
   [network]
   localhost       ansible_connection=local ansible_python_interpreter=/root/kolla-ansible/bin/python3
   
   [compute]
   localhost       ansible_connection=local ansible_python_interpreter=/root/kolla-ansible/bin/python3
   
   [storage]
   localhost       ansible_connection=local ansible_python_interpreter=/root/kolla-ansible/bin/python3
   
   [monitoring]
   localhost       ansible_connection=local ansible_python_interpreter=/root/kolla-ansible/bin/python3
   
   [deployment]
   localhost       ansible_connection=local ansible_python_interpreter=/root/kolla-ansible/bin/python3

Deploy OpenStack:

.. code-block:: sh

   $ kolla-ansible -i ./all-in-one bootstrap-servers
   $ kolla-ansible -i ./all-in-one prechecks
   $ kolla-ansible -i ./all-in-one deploy

Configure the OpenStack utilities:

.. code-block:: sh

   $ pip install 'python-openstackclient<6.0'
   $ kolla-ansible post-deploy
   $ . /etc/kolla/admin-openrc.sh

Setup sample resources on the OpenStack cloud:

.. code-block:: sh

   $ ~/kolla-ansible/share/kolla-ansible/init-runonce

[5]

Configuration
~~~~~~~~~~~~~

All of the configurations are handled in ``/etc/kolla/globals.yml``.

-  kolla_base_distro = ``centos``, ``debian``, ``rhel``, or ``ubuntu``.
-  kolla_install_type = ``binary`` (from package manager repository) or ``source`` (from git repository). Using ``source`` is recommended as it gets bug fixes and updates faster.
-  network_interface = The interface to use for the API and management networks.
-  neutron_external_interface = The interface to use for the Neutron external networks. It cannot be the same as ``network_interface``.
-  kolla_internal_vip_address = The private IP address to use for API and management traffic. 
-  kolla_external_vip_address = The public IP address to use for API and management traffic. 
-  enable_<SERVICE> = Enable additional services. View the available settings: ``grep ^\#enable_ /etc/kolla/globals.yml``.
-  enable_openstack_core = Enable Keystone, Glance, Heat, Horizon, Neutron, and Nova.

[6]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/openstack/kolla.rst>`__

Bibliography
------------

1. "Kolla." OpenStack Wiki. Accessed May 29, 2020. https://wiki.openstack.org/wiki/Kolla
2. "openstack/kolla." opendev. May 28, 2020. Accessed May 29, 2020. https://opendev.org/openstack/kolla
3. "Production architecture guide." kolla-ansible OpenStack Documentation. January 27, 2020. Accessed May 29, 2020. https://docs.openstack.org/kolla-ansible/latest/admin/production-architecture-guide.html
4. "Kolla Security." kolla-ansible OpenStack Documentation. April 6, 2018. Accessed May 29, 2020. https://docs.openstack.org/kolla-ansible/train/user/security.html
5. "Quick Start." kolla-ansible OpenStack Documentation. May 24, 2020. Accessed May 29, 2020. https://docs.openstack.org/kolla-ansible/train/user/quickstart.html
6. "Kolla Ansible Configuration." kolla-ansible OpenStack Documentation. December 13, 2020. Accessed May 29, 2020. https://docs.openstack.org/kayobe/train/configuration/kolla-ansible.html
