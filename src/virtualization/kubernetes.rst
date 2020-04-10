Kubernetes
==========

.. contents:: Table of Contents

Architecture
------------

Kubernetes, also known as k8s, is an open-source container management platform. It handles the life-cycle of Pods which are a collection of related containers required to run an application. Kubernetes clusters contain two types of servers:

-  Master = Manages the state of the Nodes and their Pods.
-  Node, Worker, or Minion = Run user applications in containers and respond to requests from the Masters.

Master services:

-  etcd = The most common database for storing all of the Kubernetes configuration data.
-  kube-apiserver = Handles authentication requests and retrieving/storing data from/to etcd.
-  kube-controller-manager = Monitors Nodes and Pods. It will preform recovery tasks if a failure is detected.
-  kube-scheduler = Determines what Node to schedule a Pod on.

Node services:

-  Container runtime = Any service that supports that Container Runtime Interface (CRI). That includes docker, containerd, CRI-O, and others.
-  kubelet = Manages containers using the container runtime.
-  kube-proxy = Handles virtual networking connections for internal (containers across different Nodes) and external (Kubernetes Services) use.

[1]

Releases
--------

Kubernetes
~~~~~~~~~~

Kubernetes was originally created by Google in 2003 and was called the Borg System. In 2014, it was renamed to Kubernetes and released as open-source software under the Apache License version 2.0. [2]

Release highlights:

-  `1.0 <https://www.zdnet.com/article/google-releases-kubernetes-1-0/>`__

   -  First stable public release of Kuberenetes.

-  `1.1 <https://kubernetes.io/blog/2015/11/kubernetes-1-1-performance-upgrades-improved-tooling-and-a-growing-community/>`__

   -  `Horizontal Pod Autoscaler <https://learnk8s.io/autoscaling-apps-kubernetes>`__ added to automatically scale the number of containers based on metrics inside of a running Pod.
   -  `Ingress <https://kubernetes.io/docs/concepts/services-networking/ingress/>`__ now supports HTTP load balancing.
   -  `Job objects <https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/>`__ are added to allow an app to run until it successfully completes.

-  `1.2 <https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.2.md>`__

   -  `ConfigMap objects <https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/>`__ now support Dynamic Configuration to allow Pod changes at any time.
   -  `Deployment objects <https://kubernetes.io/docs/concepts/workloads/controllers/deployment/>`__ now supports Turnkey Deployments to automate the full life-cycle of a Pod.
   -  `DaemonSet objects <https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/>`__ added to run one Pod on every Node.
   -  Ingress now supports TLS.
   -  Introduced `kubectl drain <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain>`__ to force all Pods to be moved off one Node to other Nodes.
   -  Added an optional web graphical user interface (GUI) known as the Kubernetes `Dashboard <https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/>`__.

-  `1.3 <https://kubernetes.io/blog/2016/07/kubernetes-1-3-bridging-cloud-native-and-enterprise-workloads/>`__

   -  `Minikube <https://minikube.sigs.k8s.io/docs/>`__ was created for quick and easy development environment for Kubernetes.
   -  `Container Network Interface (CNI) <https://github.com/containernetworking/cni>`__ is now supported.
   -  `rkt <https://coreos.com/rkt/>`__ can now be used as a container runtime.
   -  Cross-cluster discovery support for running Pods across multiple clouds.
   -  `PetSet objects <https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/>`__ (later `renamed to SatefulSet <https://github.com/kubernetes/kubernetes/issues/35534>`__) introduced for running stateful applications such as databases.

-  `1.13 <https://kubernetes.io/blog/2018/12/03/kubernetes-1-13-release-announcement/>`__

   -  `kubeadm <https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/>`__ is now officially supported for installing and setting up a Kubernetes cluster.
   -  `CoreDNS <https://coredns.io/>`__ is the default DNS provider.
   -  `Container Storage Interface (CSI) <https://kubernetes-csi.github.io/docs/drivers.html>`__ is now stable for integrating more cloud storage solutions.

OpenShift
~~~~~~~~~

The Red Hat OpenShift Container Platform (OCP) is an enterprise product based on Google's Kubernetes. [16] It has a stronger focus on security with support for having access control lists (ACLs) for managing containers in separate projects and full SELinux support. It also provides more features to extend Kubernetes functionality. Only NFS is officially supported as the storage back-end. Other storage providers are marked as a "Technology Preview." [3]

The Origin Kubernetes Distribution (OKD), originally known as OpenShift Origin, is the free and open source community edition of RHOCP. [4]

Below is a list of RHOCP and OKD versions that correspond with the upstream Kubernetes release. The RHOCP 4.0 release was skipped and used for internal testing only. RHOCP 4 introduced Operators and OperatorHub. It also requires all Master nodes to be installed on Red Hat CoreOS. [5]

.. csv-table::
   :header: RHOCP/OKD, Kubernetes
   :widths: 20, 20

   4.4, 1.17
   4.3, 1.16
   4.2, 1.14
   4.1, 1.13
   3.11, 1.11
   3.10, 1.10
   3.9, 1.9

Every release of RHOCP is supported for about 1.5 years. When ``<RHOCP_RELEASE> + 3`` is released, the ``<RHOCP_RELEASE>`` soon becomes end-of-life. [6]

Installation
------------

Minikube
~~~~~~~~

Minikube deploys a virtual machine with Kubernetes pre-installed as a test environment for developers. This is only supported on x86_64 processors.

Download the latest Minikube release from `here <https://github.com/kubernetes/minikube/releases>`__.

.. code-block:: sh

   $ MINIKUBE_VER=1.8.2
   $ sudo curl -L https://github.com/kubernetes/minikube/releases/download/v${MINIKUBE_VER}/minikube-linux-amd64 -o /usr/local/bin/minikube
   $ sudo chmod +x /usr/local/bin/minikube

Optionally install a driver such as KVM2. The ``minikube`` installer will automatically download it if it cannot be found.

.. code-block:: sh

   $ sudo curl -L https://github.com/kubernetes/minikube/releases/download/v${MINIKUBE_VER}/docker-machine-driver-kvm2 -o /usr/local/bin/docker-machine-driver-kvm2
   $ sudo chmod +x /usr/local/bin/docker-machine-driver-kvm2

Deploy Kubernetes. Optionally specify the Kubernetes version to use. If using the ``kvm2`` driver as the root user, the ``--force`` argument is also required.

.. code-block:: sh

   $ minikube start --vm-driver kvm2 --kubernetes-version ${KUBERNETES_VERSION}

Install kubectl for managing Kubernetes.

.. code-block:: sh

   $ sudo curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
   $ sudo chomd +x /usr/local/bin/kubectl

[7]

kubeadm
~~~~~~~

Supported operating systems:

-  Debian 9, Ubuntu >= 16.04
-  RHEL/CentOS 7
-  HypriotOS
-  Container Linux

The official ``kubeadm`` utility is used to quickly create production environments and manage their life-cycle. This tool had became stable and supported since the Kubernetes 1.13 release. [8] Install it using the instructions found `here <https://kubernetes.io/docs/setup/independent/install-kubeadm/>`__. Other pre-requisite steps include disabling swap partitions, enabling IP forwarding, and installing docker. On RHEL/CentOS, SELinux needs to be disabled as it is not supported for use with kubeadm.

.. code-block:: sh

   $ sudo swapoff --all

.. code-block:: sh

   $ sudo modprobe br_netfilter
   $ echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
   $ sudo sysctl -p

Kubernetes requires a network provider, Flannel by default, to create an overlay network for inter-communication between pods across all of the worker nodes. A CIDR needs to be defined and can be any network.

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

[9]

k3s
~~~

k3s was created by Rancher Labs as a simple way to deploy low-resource Kubernetes clusters quickly. It supports both x86 and ARM processors. It uses the ``containerd`` runtime by default, CoreDNS for hostname resolution and management, and Flannel for networking. All of the tools and resources are provided in a single ``k3s`` binary. All beta and alpha features of Kubernetes have been removed to keep the binary small.

Master:

.. code-block:: sh

   $ git clone https://github.com/rancher/k3s.git
   $ cd k3s
   $ sudo ./install.sh
   $ sudo systemctl enable k3s

Find the token on the master:

.. code-block:: sh

   $ sudo cat /var/lib/rancher/k3s/server/node-token

Worker:

.. code-block:: sh

   $ git clone https://github.com/rancher/k3s.git
   $ cd k3s
   $ K3S_TOKEN=<TOKEN> K3S_URL=https://<MASTER_HOST>:6443 ./install.sh
   $ sudo systemctl enable k3s-agent

**Upgrade**

Either update the local git repository and checkout the desired version tag to upgrade to or curl the latest installer script and specify the version using an environment variable.

Master:

.. code-block:: sh

   $ curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=<GITHUB_VERSION_TAG> sh -a

Agent:

.. code-block:: sh

   $ curl -sfL https://get.k3s.io | K3S_TOKEN=<TOKEN> K3S_URL=https://<MASTER_HOST>:6443 INSTALL_K3S_VERSION=<GITHUB_VERSION_TAG> sh -a

Verify that the upgrade worked.

.. code-block:: sh

   $ k3s --version

**Uninstall**

Master:

.. code-block:: sh

   $ sudo /usr/local/bin/k3s-uninstall.sh

Worker:

.. code-block:: sh

   $ sudo /usr/local/bin/k3s-agent-uninstall.sh

**Commands**

Access the ``kubectl`` command through ``k3s`` to manage resources on the cluster.

.. code-block:: sh

   $ sudo k3s kubectl --help

For using the ``kubectl`` command on other systems, copy the configuration from the master node.

.. code-block:: sh

   $ scp root@<MASTER>:/etc/rancher/k3s/k3s.yaml ~/.kube/config
   $ sed -i s'/localhost/<MASTER_HOST>/'g ~/.kube/config

[10]

For storage, k3s supports all of the stable Container Storage Interface (CSI) and sample driver providers. As of k3s v0.4.0 (Kubernetes 1.14.0), these are the supported providers:

-  Alicloud Elastic Block Storage
-  Alicloud Elastic File System
-  Alicloud OSS
-  AWS Elastic File System
-  AWS Elastic Storage
-  AWS FSx for Lustre
-  CephFS
-  Cinder
-  cloudscale.ch
-  Datera
-  DigitalOcean Block Storage
-  DriveScale
-  Flexvolume
-  GlusterFS
-  Hitachi Vantra
-  HostPath
-  Linode Block Storage
-  LINSTOR
-  MapR
-  NFS
-  Portworx
-  QingCloud CSI
-  QingStor CSI
-  Quobyte
-  RBD
-  ScaleIO
-  StorageOS
-  Synology NAS
-  XSKY
-  VFS Driver
-  vSphere
-  YanRongYun

[11]

Minishift
~~~~~~~~~

Minishift deploys a virtual machine with OpenShift pre-installed as a test environment for developers. This is only supported on x86_64 processors.

**Install (Fedora):**

-  Download the latest release of Minishift from `here <https://github.com/minishift/minishift/releases>`__ and the latest release of OC from `here <https://github.com/openshift/origin/releases>`__.

.. code-block:: sh

    $ MINISHIFT_VER=1.34.2
    $ wget https://github.com/minishift/minishift/releases/download/v${MINISHIFT_VER}/minishift-${MINISHIFT_VER}-linux-amd64.tgz
    $ tar -v -x -f minishift-${MINISHIFT_VER}-linux-amd64.tgz
    $ curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
    $ sudo chmod 0755 /usr/local/bin/docker-machine-driver-kvm
    $ wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
    $ tar -v -x -f openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz$
    $ sudo cp openshift-origin-client-tools-v3.11.0*/oc /usr/local/bin/
    $ cd ./minishift-${MINISHIFT_VER}-linux-amd64/
    $ ./minishift openshift version list
    $ ./minishift start --openshift-version v3.11.0

[12][13]

**Install (RHEL):**

Enable the Red Hat Developer Tools repository first. Then Minishift can be installed.

.. code-block:: sh

    $ sudo subscription-manager repos --enable rhel-7-server-devtools-rpms
    $ sudo yum install cdk-minishift
    $ minishift setup-cdk --force --default-vm-driver="kvm"
    $ sudo ln -s ~/.minishift/cache/oc/v3.*/linux/oc /usr/bin/oc
    $ minishift openshift version list
    $ minishift start --openshift-version v3.11.0

[14]

For installing newer versions of Minishift, the old environment must be wiped first.

.. code-block:: sh

   $ minishift stop
   $ minishift delete
   $ rm -rf ~/.kube ~/.minishift
   $ sudo rm -f $(which oc)

[22]

OpenShift Ansible
~~~~~~~~~~~~~~~~~

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

[15]

The container registry is ephemeral so after a reboot the data will be wiped. All of the storage inventory configuration options and settings can be found `here <https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html#advanced-install-registry>`__. For lab environments using NFS, unsupported options will need to be enabled using ``openshift_enable_unsupported_configurations=True``. The ``nfs`` group will also need to be created and added to the ``OSEv3:children`` group of groups.

.. code-block:: sh

   $ sudo yum -y ansible pyOpenSSL python-cryptography python-lxml
   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/prerequisites.yml
   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/deploy_cluster.yml

Persistent container application storage can also be configured after installation by using one of the configurations from `here <https://docs.openshift.com/container-platform/3.11/install_config/persistent_storage/index.html>`__.

Uninstall OpenShift services from nodes by specifying them in the inventory and using the uninstall playbook.

.. code-block:: sh

   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/adhoc/uninstall.yml

Persistent Storage
------------------

Kubernetes storage requires a ``PersistentVolume`` (PV) pool that users can create multiple ``PersistentVolumeClaim`` (PVC) claims from.

Storage is recommended to be dynamic (ephemeral) so that applications can scale and handle failures in a cloudy way. However, databases and legacy applications may require static (persistent) storage.

-  PersistentVolume spec [17]:

   -  storageClassName = The storage back-end to use. Leave blank to use the default. Set to a non-existent storage class to manually manage it (for example, "" or "manual").
   -  **accessModes** [18]

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

API
~~~

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
     # For distributed storage, consider using "nfs" instead of "hostPath".
     # See: https://docs.okd.io/latest/install_config/persistent_storage/persistent_storage_nfs.html
     #nfs:
     #  path: /exports/app
     #  server: 192.168.1.100
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

[19]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/virtualization/kubernetes.rst>`__

Bibliography
------------

1. "Kubernetes Components." Kubernetes Concepts. January 16, 2020. Accessed April 8, 2020. https://kubernetes.io/docs/concepts/overview/components/
2. "The History of Kubernetes on a Timeline." RisingStack Blog. June 20, 2018. Accessed April 8, 2020. https://blog.risingstack.com/the-history-of-kubernetes/
3. "Persistent Storage." OpenShift Documentation. Accessed February 26, 2018. https://docs.openshift.com/enterprise/3.0/architecture/additional_concepts/storage.html
4. "OKD: Renaming of OpenShift Origin with 3.10 Release." Red Hat OpenShift Blog. August 3, 2018. Accessed September 17, 2018. https://blog.openshift.com/okd310release/
5. "Releases Notes. OpenShift Container Platform 4.1 Documentation. https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html-single/release_notes/index
6. "Red Hat OpenShift Container Platform Life Cycle Policy." Red Hat Support. Accessed March 9, 2020. https://access.redhat.com/support/policy/updates/openshift
7. "Install Minikube." Kubernetes Documentation. Accessed September 17, 2018. https://kubernetes.io/docs/tasks/tools/install-minikube/
8. "Kubernetes 1.13: Simplified Cluster Management with Kubeadm, Container Storage Interface (CSI), and CoreDNS as Default DNS are Now Generally Available." Kubernetes Blog. December 3, 2018. Accessed December 5, 2018. https://kubernetes.io/blog/2018/12/03/kubernetes-1-13-release-announcement/
9. "Creating a single master cluster with kubeadm." Kubernetes Setup. November 24, 2018. Accessed November 26, 2018. https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
10. "k3s - 5 less than k8s." k3s, GitHub. March 29, 2019. Accessed April 1, 2019. https://github.com/rancher/k3s
11. "Drivers." Kubernetes CSI Developer Documentation. Accessed April 11, 2019. https://kubernetes-csi.github.io/docs/drivers.html
12. "Minishift Quickstart." OpenShift Documentation. Accessed February 26, 2018. https://docs.openshift.org/latest/minishift/getting-started/quickstart.html
13. "Run OpenShift Locally with Minishift." Fedora Magazine. June 20, 2017. Accessed February 26, 2018. https://fedoramagazine.org/run-openshift-locally-minishift/
14. "CHAPTER 5. INSTALLING RED HAT CONTAINER DEVELOPMENT KIT." Red Hat Customer Portal. Accessed February 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_container_development_kit/3.0/html/installation_guide/installing-rhcdk
15. "Configuring Clusters." OpenShift Container Platform Documentation. Accessed February 5, 2019. https://docs.openshift.com/container-platform/3.11/install_config/index.html
16. "OpenShift: Container Application Platform by Red Hat." OpenShift. Accessed February 26, 2018. https://www.openshift.com/
17. "API OVERVIEW." Kubernetes API Reference Docs. Accessed January 29, 2019. https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#storageclass-v1-storage
18. "Persistent Volumes." Kubernetes Concepts. January 16, 2019. Accessed January 29, 2019. https://kubernetes.io/docs/concepts/storage/persistent-volumes/
19. "Configure a Pod to Use a PersistentVolume for Storage." Kubernetes Tasks. November 6, 2018. Accessed January 29, 2019. https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
