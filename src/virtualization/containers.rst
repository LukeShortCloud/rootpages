Containers
==========

.. contents:: Table of Contents

Containers are a type of software virtualization. Using a directory
structure that contains an entire operating system (typically referred
to as a chroot), containers can easily spin up and utilize system
resources without the overhead of full hardware allocation. It is not
possible to use separate kernels with this approach.

Images
------

`Docker Hub <https://hub.docker.com/>`__ provides a central location to find, download, and upload container docker and CRI-O compatible images. Here is a list of common operating system images for each family of distributions:

-  Arch Linux

   -  base/archlinux

-  Fedora

   -  centos:7
   -  fedora:28

-  Debian

   -  debian:9
   -  ubuntu:18.04

-  openSUSE

   -  opensuse/leap:15.0

More containers can be found `here <https://hub.docker.com/explore/>`__.

docker
------

The docker software (with a lowercase "d") was created by the Docker company to manage and create containers using the LXC kernel module on Linux.

A command is ran to start a daemon in the container. As long as that process is still running in the foreground, the container will remain active. Some processes may spawn in the background. A workaround for this is to append ``&& tail -f /dev/null`` to the command. If the daemon successfully starts, then a never-ending task can be run instead (such as viewing the never ending file of /dev/null). [16]

The docker software (with a lowercase "d") was created by the Docker company to manage and create containers using the LXC kernel module on Linux.$
By default, only the "root" user has access to manage docker containers. Users assigned to a "docker" group will have the necessary privileges. However, they will then have administrator access to the system. If the "docker" group is newly created then the daemon needs to be restarted for the change to load up. The docker user may also have to run the ``newgrp docker`` command to reload their groups. [48]

.. code-block:: sh

    $ sudo groupadd docker
    $ sudo usermod -a -G docker <USER>
    $ sudo systemctl restart docker

Networking
~~~~~~~~~~

Networking is automatically bridged to the public interface and set up
with a NAT. This allows full communication to/from the container,
provided that the necessary ports are open in the firewall and
configured in the docker image.

Networking issues from within a container are commonly due to network
packet size (MTU) issues. There are a few work-a-rounds.

1. Configure the default MTU size for docker deployments by modifying
   the daemon's process settings. This value should generally be below
   the default of 1500.

   .. code-block:: sh

       $ sudo vim /etc/sysconfig/docker
       OPTIONS='--selinux-enabled --log-driver=journald --mtu 1400'
       $ sudo systemctl restart docker

   OR

   .. code-block:: sh

       $ sudo vim /usr/lib/systemd/system/docker.service
       ExecStart=/usr/bin/docker-current daemon \
             --exec-opt native.cgroupdriver=systemd --mtu 1400 \
             $OPTIONS \
             $DOCKER_STORAGE_OPTIONS \
             $DOCKER_NETWORK_OPTIONS \
             $ADD_REGISTRY \
             $BLOCK_REGISTRY \
             $INSECURE_REGISTRY
       $ sudo systemctl daemon-reload
       $ sudo systemctl restart docker

2. Forward all packets between the docker link through the physical
   link.

   .. code-block:: sh

       $ sudo iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

[17]

In rare cases, the bridge networking will not be working properly. An
error message similar to this may appear during creation.

::

    ERROR: for <CONTAINER_NAME> failed to create endpoint <NETWORK_ENDPOINT> on network bridge: iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport <DESTINATION_PORT_HOST> -j DNAT --to-destination <IP_ADDRESS>:<DESTINATION_PORT_CONTAINER> ! -i docker0: iptables: No chain/target/match by that name.

The solution is to delete the virtual "docker0" interface and then
restart the docker service for it to be properly recreated.

.. code-block:: sh

    $ sudo ip link delete docker0
    $ sudo systemctl restart docker

[18]

Java
~~~~

Java <= 9, by default, will try to allocate a large amount of memory for the runtime and garbage collection. This can lead to resource exhaustion of RAM on a hypervisor. The maximum memory allocation should be specified to Java applications using ``-Xmx<SIZE_IN_MB>m``. [54] This is no longer an issue in Java >= 10 as it is now aware of when it is being containerized. [55]

Example Java <=9 usage in a docker compose file that utilizes an environment variable:

::

   CMD java -XX:+PrintFlagsFinal $JAVA_OPTS -jar app.jar

LXC
---

Linux Containers (LXC) utilizes the Linux kernel to natively run
containers.

Debian install [19]:

.. code-block:: sh

    $ sudo apt-get install lxc

RHEL install [20] requires the Extra Packages for Enterprise Linux (EPEL)
repository:

-  RHEL:

   .. code-block:: sh

       $ sudo yum install epel-release
       $ sudo yum install lxc lxc-templates libvirt

On RHEL family systems the ``lxcbr0`` interface is not created or used.
Alternatively, the libvirt interface ``virbr0`` should be used.

.. code-block:: sh

    $ sudo vim /etc/lxc/default.conf
    lxc.network.link = virbr0

The required services need to be started before LXC containers will be
able to run.

.. code-block:: sh

    $ sudo systemctl start libvirtd
    $ sudo systemctl start lxc

Templates that can be referenced for LXC container creation can be found
in the ``/usr/share/lxc/templates/`` directory.

Container Management Platforms
------------------------------

OpenShift
~~~~~~~~~

The OpenShift Container Platform (OCP) is a Red Hat product based on Google's Kubernetes. [29] It has a stronger focus on security with support for having access control lists (ACLs) for managing containers in separate projects and full SELinux support. It also provides more features to extend Kubernetes functionality. Only NFS is officially supported as the storage back-end. Other storage providers are marked as a "Technology Preview." [30]

The Origin Kubernetes Distribution (OKD), originally known as OpenShift Origin, is the free and open source community edition of OpenShift. [52]

Minishift
^^^^^^^^^

Minishift deploys a virtual machine with OpenShift pre-installed as a test environment for developers. This is only supported on x86_64 processors.

**Install (Fedora):**

-  Download the latest release of Minishift from `here <https://github.com/minishift/minishift/releases>`__ and the latest release of OC from `here <https://github.com/openshift/origin/releases>`__.

.. code-block:: sh

    $ MINISHIFT_VER=1.31.0
    $ wget https://github.com/minishift/minishift/releases/download/v${MINISHIFT_VER}/minishift-${MINISHIFT_VER}-linux-amd64.tgz
    $ tar -v -x -f minishift-${MINISHIFT_VER}-linux-amd64.tgz
    $ sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm
    $ sudo chmod 0755 /usr/local/bin/docker-machine-driver-kvm
    $ wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
    $ tar -v -x -f openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz$
    $ sudo cp openshift-origin-client-tools-v3.11.0*/oc /usr/local/bin/
    $ cd ./minishift-${MINISHIFT_VER}-linux-amd64/
    $ ./minishift openshift version list
    $ ./minishift start --openshift-version v3.11.0

[31][32]

**Install (RHEL):**

Enable the Red Hat Developer Tools repository first. Then Minishift can be installed.

.. code-block:: sh

    $ sudo subscription-manager repos --enable rhel-7-server-devtools-rpms
    $ sudo yum install cdk-minishift
    $ minishift setup-cdk --force --default-vm-driver="kvm"
    $ sudo ln -s ~/.minishift/cache/oc/v3.*/linux/oc /usr/bin/oc
    $ minishift openshift version list
    $ minishift start --openshift-version v3.11.0

[33]

For installing newer versions of Minishift, the old environment must be wiped first.

.. code-block:: sh

   $ minishift stop
   $ minishift delete
   $ rm -rf ~/.kube ~/.minishift
   $ sudo rm -f $(which oc)

[58]

OpenShift Ansible
^^^^^^^^^^^^^^^^^

The OpenShift Ansible project is an official collection of Ansible playbooks to manage the installation and life-cycle of production OpenShift clusters.

.. code-block:: sh

   $ git clone https://github.com/openshift/openshift-ansible.git
   $ cd openshift-ansible
   $ git checkout release-3.11

Settings for the deployment are defined in a single inventory file. Examples can be found in the ``inventory`` directory. ``[OSEv3:children]`` is a group of groups that should contain all of the hosts.

Inventory file variables:

-  ``openshift_deployment_type`` = ``origin`` for the upstream OKD on CentOS or ``openshift-enterprise`` for the downstream OCP on Red Hat CoreOS.
-  ``openshift_release`` = The OpenShift release to use. Example: ``v3.11``.
-  ``openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider'}]`` = Enable htpasswd authentication.
-  ``openshift_master_htpasswd_users={'<USER1>': '<HTPASSWD_HASH>', '<USER2>': '<HTPASSWD_HASH>'}`` = Configure OpenShift users. Create a password for the user by running ``htpasswd -nb <USER> <PASSWORD>``.
-  ``openshift_disable_check=memory_availability,disk_availability`` = Disable certain checks for a minimal lab deployment.
-  ``openshift_master_cluster_hostname`` = The private internal hostname.
-  ``openshift_master_cluster_public_hostname`` = The public internal hostname.

[56]

The container registry is ephemeral so after a reboot the data will be wiped. All of the storage inventory configuration options and settings can be found `here <https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html#advanced-install-registry>`__. For lab environments using NFS, unsupported options will need to be enabled using ``openshift_enable_unsupported_configurations=True``. The ``nfs`` group will also need to be created and added to the ``OSEv3:children`` group of groups.

Install Openshift.

.. code-block:: sh

   $ sudo yum -y ansible pyOpenSSL python-cryptography python-lxml
   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/prerequisites.yml
   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/deploy_cluster.yml

Persistent container application storage can also be configured after installation by using one of the configurations from `here <https://docs.openshift.com/container-platform/3.11/install_config/persistent_storage/index.html>`__.

Uninstall OpenShift services from nodes by specifying them in the inventory and using the uninstall playbook.

.. code-block:: sh

   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/adhoc/uninstall.yml

Kubernetes
~~~~~~~~~~

Kubernetes provides an API and graphical user interface for the orchestration and scaling of docker containers. It was originally created by Google as part of their Google Kubernetes Engine cloud platform.

Minikube
^^^^^^^^

Minikube deploys a virtual machine with Kubernetes pre-installed as a test environment for developers. This is only supported on x86_64 processors.

Download the latest Minikube release from `here <https://github.com/kubernetes/minikube/releases>`__.

.. code-block:: sh

   $ MINIKUBE_VER=0.33.1
   $ sudo curl -L https://github.com/kubernetes/minikube/releases/download/v${MINIKUBE_VER}/minikube-linux-amd64 -o /usr/local/bin/minikube
   $ sudo chmod +x /usr/local/bin/minikube

Install the the KVM2 virtualization driver.

.. code-block:: sh

   $ sudo curl -L https://github.com/kubernetes/minikube/releases/download/v${MINIKUBE_VER}/docker-machine-driver-kvm2 -o /usr/local/bin/docker-machine-driver-kvm2
   $ sudo chmod +x /usr/local/bin/docker-machine-driver-kvm2

Deploy Kubernetes using the specified version.

.. code-block:: sh

   $ minikube get-k8s-versions
   $ minikube start --vm-driver kvm2 --kubernetes-version <VERSION>

Install kubectl for managing Kubernetes.

.. code-block:: sh

   $ sudo curl -L https://storage.googleapis.com/kubernetes-release/release/<VERSION>/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
   $ sudo chomd +x /usr/local/bin/kubectl

[51]

kubeadm
^^^^^^^

Supported operating systems:

-  Debian 9, Ubuntu >= 16.04
-  RHEL/CentOS 7
-  HypriotOS
-  Container Linux

The official ``kubeadm`` utility is used to quickly create production environments and manage their life-cycle. This tool had became stable and supported since the Kubernetes 1.13 release. [60] Install it using the instructions found `here <https://kubernetes.io/docs/setup/independent/install-kubeadm/>`__. Other pre-requisite steps include disabling swap partitions, enabling IP forwarding, and installing docker. On RHEL/CentOS, SELinux needs to be disabled as it is not supported for use with kubeadm.

.. code-block:: sh

   $ sudo swapoff --all

.. code-block:: sh

   $ sudo modprobe br_netfilter
   $ echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
   $ sudo sysctl -p

Kubernetes requires a network provider, Fannel by default, to create an overlay network for inter-communication between pods across all of the worker nodes. A CIDR needs to be defined and can be any network.

Syntax:

.. code-block:: sh

   $ sudo kubeadm init --pod-network-cidr <OVERLAY_NETWORK_CIDR>

Example (Flannel):

.. code-block:: sh

   $ sudo kubeadm init --pod-network-cidr=10.244.0.0/16

Install a network add-on based on the Container Network Interface (CNI) protocols following the instructions `here <https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network>`__.

Example (Flannel):

.. code-block:: sh

   $ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

Create an authentication token if the original deployment token expired.

.. code-block:: sh

   $ kubeadm token list
   $ kubeadm token create

Look-up the discovery token hash by using the certificate authority file.

.. code-block:: sh

   $ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

On the app/worker nodes, add them to the cluster by running:

.. code-block:: sh

   $ sudo kubeadm join --token <TOKEN> <MASTER_IP_ADDRESS>:6443 --discovery-token-ca-cert-hash sha256:<HASH>

[59]

Storage
^^^^^^^

Kubernetes storage requires a ``PersistentVolume`` (PV) pool that users can create multiple ``PersistentVolumeClaim`` (PVC) claims from.

Storage is recommended to be dynamic (ephemeral) so that applications can scale and handle failures in a cloudy way. However, databases and legacy applications may require static (persistent) storage.

-  PersistentVolume spec [61]:

   -  storageClassName = The storage back-end to use. Leave blank to use the default. Set to a non-existent storage class to manually manage it (for example, "" or "manual").
   -  **accessModes** [62]

      -  ReadOnlyMany = More than one pod can only read the data to/from this storage
      -  ReadWriteOnce = Only one pod can read and write to/from this storage.
      -  ReadWriteMany = More than one pod can read and write data to/from this storage.

   -  **capacity** =

      -  **storage** = The capacity, in "Gi", that the PV pool contains.

   -  mountOptions
   -  nodeAffinity = A list of worker nodes that can use this storage.
   -  persistentVolumeReclaimPolicy
   -  volumeMode

- (Configurable PV dictionaries)

   -  awsElasticBlockStore
   -  azureDisk
   -  azureFile
   -  cephfs
   -  cinder
   -  fc
   -  flexVolume
   -  flocker
   -  gcePersistentDisk
   -  glusterfs
   -  hostPath = Use a local directory on a worker node to store data. Consider additionally setting the "nodeAffinity" to the node that will store the data. Alternatively, use ``glusterfs`` instead of ``hostPath`` to sync the directory across all of the worker nodes.

      -  path = The file system path to use.

   -  iscis
   -  local
   -  nfs
   -  photonPersistentDisk
   -  portworxVolume
   -  quobyte
   -  rbd
   -  scaleIO
   -  storageos
   -  vsphereVolume

Static
''''''

The example below shows how to configure static storage for a pod using local storage.

-  Create a PV. Set a unique ``<PV_NAME>``, configure the ``<PV_STORAGE_MAX>`` gigabytes that the PV can allocate, and define the ``<LOCAL_FILE_SYSTEM_PATH>`` where the data from pods should be stored on the worker nodes. In this scenario, it is also recommended to configure a ``nodeAffinity`` that restricts the PV from only being used by the worker node that has the local storage.

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: <PV_NAME>
     labels:
       type: local
   spec:
     storageClassName: manual
     capacity:
       storage: <PV_STORAGE_MAX>Gi
     accessModes:
       - ReadWriteOnce
     hostPath:
       path: "<LOCAL_FILE_SYSTEM_PATH>"
     nodeAffinity:
       required:
         nodeSelectorTerms:
           - matchExpressions:
             - key: kubernetes.io/hostname
               operator: In
               values:
                 - <WORKER_NODE_WITH_LOCAL_FILE_SYSTEM_PATH>

-  Create a PVC from the PV pool. Set a unique ``<PVC_NAME>`` and the ``<PVC_STORAGE>`` size. The size should not exceed the maximum available storage from the PV.

.. code-block:: yaml

   ---
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: <PVC_NAME>
   spec:
     storageClassName: manual
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: <PVC_STORAGE>Gi

-  Create a pod using the PVC. Set ``<POD_VOLUME_NAME>`` to a nickname of the PVC volume that will be used by the actual pod and indicate the ``mountPath`` for where it should be mounted inside of the container.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: task-pv-pod
   spec:
     volumes:
       - name: <POD_VOLUME_NAME>
         persistentVolumeClaim:
          claimName: <PVC_NAME>
     containers:
       - name: task-pv-container
         image: mysql
         volumeMounts:
           - mountPath: "/var/lib/mysql"
             name: <POD_VOLUME_NAME>

[63]
