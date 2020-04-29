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

-  `1.4 <https://kubernetes.io/blog/2016/09/kubernetes-1-4-making-it-easy-to-run-on-kuberentes-anywhere/>`__

   -   `kubeadm <https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/>`__` introduced for installing Kubernetes clusters.
   -  ScheduledJob objects (later named to `CronJob <https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/>`__) added to run an application during a regularyly scheduled time.
   -  `PodSecurityPolicies <https://kubernetes.io/docs/concepts/policy/pod-security-policy/>`__ object added for setting the security context of containers.
   -  `Anti- and Inter-Affinity <https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity>`__ for helping to select which Nodes a Pod will be deployed on.
   -  AppArmor support.
   -  Azure Data Disk and Quobyte volume plugins.

-  `1.5 <https://kubernetes.io/blog/2016/12/kubernetes-1-5-supporting-production-workloads/>`__

   -  `kubefed <https://github.com/kubernetes-sigs/kubefed/blob/master/docs/userguide.md>`__ command for manginging federated Kubernetes clusters.
   -  `PodDistruptionBudget <https://kubernetes.io/docs/tasks/run-application/configure-pdb/>`__ object allows for managing Node eviction rules.
   -  Windows container support.
   -  `Container Runtime Interface (CRI) <https://developer.ibm.com/technologies/containers/blogs/kube-cri-overview/>`__ allows different runtimes besides docker.
   -  Functionality tests for Nodes.
   -  PetSet renamed to StatefulSet.

-  `1.6 <https://coreos.com/blog/kubernetes-1-6.html>`__

   -  The first release of Kubernetes not from Google (from CoreOS).
   -  etcd now defaults to version 3.
   -  docker is no longer a dependency. Other runtimes such as rkt and CRI-O are supported.
   -  RBAC is now in beta.
   -  PersistentVolumeClaim objects will now be created automatically.

-  `1.7 <https://www.redhat.com/en/blog/whats-new-kubernetes-17-extensibility-rules>`__

   -  `Custom Resource Definitions (CRDs) <https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/>`__ allows existing APIs to have expanded functionality.
   -  `API Aggregation <https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation/>`__ allows new APIs to be natively added to Kubernetes.
   -  Secrets can now be encrypted in etcd.
   -  Nodes can now have limited access to a subset of the Kubernetes APIs (only the ones it needs).
   -  Extensible External Admission Control adds additional security policies and checks.
   -  `NetworkPolicy API <https://kubernetes.io/docs/concepts/services-networking/network-policies/>`__ is now stable.

-  `1.8 <https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.8.md#notable-features>`__

   -  RBAC is now stable.
   -  Storage mount options are now stable.
   -  `kubectl plugins <https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/>`__ are now supported to extend the CLI's functionality.

-  `1.9 <https://kubernetes.io/blog/2017/12/kubernetes-19-workloads-expanded-ecosystem/>`__

   -  `Workloads APIs <https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.10/#-strong-workloads-apis-strong->`__ are now stable.
   -  Introduced Container Storage Interface (CSI) for adding additional storage back-ends to Kubernetes.
   -  `CoreDNS installation <https://kubernetes.io/docs/tasks/administer-cluster/coredns/>`__ is now supported by ``kubeadm``.

-  `1.10 <https://kubernetes.io/blog/2018/03/26/kubernetes-1.10-stabilizing-storage-security-networking/>`__

   -  Third-party authentication can now be used with ``kubectl``.

-  `1.11 <https://kubernetes.io/blog/2018/06/27/kubernetes-1.11-release-announcement/>`__

   -  `IPVS load balancing <https://kubernetes.io/blog/2018/07/09/ipvs-based-in-cluster-load-balancing-deep-dive/>`__ is now stable.
   -  CoreDNS support is now stable.

-  `1.12 <https://kubernetes.io/blog/2018/09/27/kubernetes-1.12-kubelet-tls-bootstrap-and-azure-virtual-machine-scale-sets-vmss-move-to-general-availability/>`__

   -  `Kubelet TLS Bootstrap <https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/>`__ is now stable.
   -  Snapshot support for CSI managed Persistent Volumes.

-  `1.13 <https://kubernetes.io/blog/2018/12/03/kubernetes-1-13-release-announcement/>`__

   -  `kubeadm <https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/>`__ is now officially supported for installing and setting up a Kubernetes cluster.
   -  `CoreDNS <https://coredns.io/>`__ is the default DNS provider.
   -  `Container Storage Interface (CSI) <https://kubernetes-csi.github.io/docs/drivers.html>`__ is now stable for integrating more cloud storage solutions.

-  `1.14 <https://kubernetes.io/blog/2019/03/25/kubernetes-1-14-release-announcement/>`__

   -  Windows Nodes is now stable.
   -  Persistent Local Volumes is now stable.
   -  ``kubectl`` plugin mechanism is now stable.

-  `1.15 <https://kubernetes.io/blog/2019/06/19/kubernetes-1-15-release-announcement/>`__

   -  CRDs now support default settings.
   -  Storage plugins are being converted to use CSI instead.
   -  Cloning CSI Persistent Volumes is now supported.

-  `1.16 <https://kubernetes.io/blog/2019/09/18/kubernetes-1-16-release-announcement/>`__

   -  CRDs are now stable.
   -  Metrics now use a registry (just as how all other Kubernetes services do).
   -  ``kubeadm`` now supports joining and reseting Windows Nodes.
   -  CSI support on Windows.
   -  `EndpointSlice API <https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/>`__ introduced as a scalable alternative to Endpoints.

-  `1.17 <https://kubernetes.io/blog/2019/12/09/kubernetes-1-17-release-announcement/>`__

   -  Cloud Prover Labels are now stable.

-  `1.18 <https://kubernetes.io/blog/2020/03/25/kubernetes-1-18-release-announcement/>`__

   -  Toplogy Manager API now supports NUMA CPU pinning.
   -  `kubectl alpha debug <https://kubernetes.io/docs/tasks/debug-application-cluster/debug-running-pod/#ephemeral-container>`__ argument introduced to attach a temporary container to a running container for troubleshooting purposes.
   -  Windows CSI now supports privileged storage configurations.

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

API
---

Stability
~~~~~~~~~

New Kubernetes APIs go through a life-cycle of updates before being marked as stable. Below are the different possible stages in ascending order.

-  Development or Prototype = Not found in any official releases. May not work.
-  Alpha = Partially implemented. Disabled by default. Versioning starts with ``v1alpha1``.
-  Beta = Feature complete. Includes mostly completed API test coverage. Upgrades may break. Versioning starts with ``v1beta1``.
-  Stable or General Availability (GA) = Fully supported in Kubernetes. Will remain backwards compatible with upgrades. Versioning starts with ``v1``.

[20]

Types
~~~~~

All of the available APIs are categorized into these types:

-  Cluster
-  Config and Storage
-  Metadata
-  Service
-  Workloads

[21]

Resources
~~~~~~~~~

Resource APIs are used to create objects in Kubernetes. They define the desired state of objects. Controllers are used to enforce that state. Every object must be defined using a YAML template file with these fields:

-  **apiVersion (string)** = The version of the API. Normally ``v1`` or ``<APIGROUP>/v1``.
-  **kind (string)** = Name of the API to create an object from.
-  **metadata (dictionary)** = Metadata for the object.

   -  **name (string)** = The unique name of this object. Only one object with this Resoure kind and name can exist in a namespace.
   -  **labels (dictionary)** = Any key-value pair to help identify this object. This is optional but recommended to help find specific or related objects.

-  **spec (dictionary)** = Provide information on how this object will be created and used. Valid inputs are different for every API.

.. code-block:: yaml

   ---
   apiVersion: <RESOURCE_APIGROUP>/<RESOURCE_APIVERSION>
   kind: <RESOURCE_KIND>
   metadata:
     name: <OBJECT_NAME>
     labels:
       <KEY>: <VALUE>
   spec:

[22]

List the values for each Resource such as the ``<NAME>``, ``<APIGROUP>``, ``<KIND>``, and if it supports namespaces. Further documentation on all of the available configuration fields for a Resource can also be shown.

.. code-block:: sh

   $ kubectl api-resources
   $ kubectl explain <RESOURCE_NAME>
   $ kubectl explain <RESOURCE_NAME>.spec --recursive
   $ kubectl explain <RESOURCE_NAME> --recursive

View the ``<RESOURCE_APIGROUP>/<RESOURCE_APIVERSION>`` versions available to use.

.. code-block:: sh

   $ kubectl api-versions

Show all objects from one of the Resource APIs.

.. code-block:: sh

   $ kubectl get <RESOURCE_NAME>

View details about an object.

.. code-block:: sh

   $ kubectl describe <RESOURCE_NAME> <OBJECT_NAME>

[23]

Edit or view the YAML configuration for an existing object.

.. code-block:: sh

   $ kubectl edit <RESOURCE_NAME> <OBJECT_NAME>
   $ kubectl get <RESOURCE_NAME> <OBJECT_NAME> -o yaml --export

Create a basic template for a Deployment or any object. It can be saved and used as a starting point for a new template. No object will be created.

.. code-block:: sh

   $ kubectl run <DEPLOYMENT_NAME> --image=<CONTAINER_IMAGE_NAME> --dry-run -o yaml
   $ kubectl create <RESOURCE_NAME> <OBJECT_NAME> --dry-run -o yaml

[24]

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

k3s was created by Rancher Labs as a simple way to deploy small Kubernetes clusters quickly. It supports both x86 and ARM processors. It uses the ``containerd`` runtime by default, CoreDNS for hostname resolution and management, and Flannel for networking. All of the tools and resources are provided in a single ``k3s`` binary. All beta and alpha features of Kubernetes have been removed to keep the binary small.

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
20. "So you want to change the API?" GitHub kubernetes/community. June 25, 2019. Accessed April 15, 2020. https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api_changes.md
21. "[Kubernetes 1.18] API OVERVIEW." Kubernetes API Reference Docs. April 13, 2020. Accessed April 15, 2020. https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/
22. "Kubernetes Resources and Controllers Overview." The Kubectl Book. Accessed April 29, 2020. https://kubectl.docs.kubernetes.io/pages/kubectl_book/resources_and_controllers.html
23. "Overview of kubectl." Kubernetes Reference. March 28, 2020. Accessed April 29, 2020. https://kubernetes.io/docs/reference/kubectl/overview/
24. "Using kubectl to jumpstart a YAML file — #HeptioProTip." heptio Blog. September 21, 2017. Accessed April 29, 2020. https://blog.heptio.com/using-kubectl-to-jumpstart-a-yaml-file-heptioprotip-6f5b8a63a3ea
