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
-  kube-controller-manager = Monitors and controls Kubernetes resources. It will perform recovery tasks if a failure is detected. This binary runs many different controller processes:

   -  attachdetach, bootstrapsigner, cloud-node-lifecycle, clusterrole-aggregation, cronjob, csrapproving, csrcleaner, csrsigning, daemonset, deployment, disruption, endpoint, endpointslice, garbagecollector, horizontalpodautoscaling, job, namespace, nodeipam, nodelifecycle, persistentvolume-binder, persistentvolume-expander, podgc, pv-protection, pvc-protection, replicaset, replicationcontroller, resourcequota, root-ca-cert-publisher, route, service, serviceaccount, serviceaccount-token, statefulset, tokencleaner, ttl, ttl-after-finished [29]

-  kube-scheduler = Determines what Node to schedule a Pod on.

Node services:

-  Container runtime = Any service that supports that Container Runtime Interface (CRI). That includes docker, containerd, CRI-O, rkt, and others.
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

   -  Cloud Provider Labels are now stable.

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

Resource APIs are used to create objects in Kubernetes. They define the desired state of objects. Controllers are used to enforce that state. Every object manifest has the following fields. Typically these are defined declaratively via a YAML manifest file.

-  **apiVersion (string)** = The version of the API. Normally ``v1`` or ``<APIGROUP>/v1``.
-  **kind (string)** = Name of the API to create an object from.
-  **metadata (dictionary)** = Metadata for the object.

   -  **name (string)** = The unique name of this object. Only one object with this Resoure kind and name can exist in a namespace.
   -  **labels (dictionary)** = Any key-value pair to help identify this object. This is optional but recommended to help find specific or related objects.

-  **spec (dictionary)** = Provide information on how this object will be created and used. Valid inputs are different for every API. Not all APIs will have a spec.
-  status = The current state information for the object. This can be shown via ``kubectl get <RESOURCE_API> <OBJECT> -o yaml``.

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

Imperative and Declarative Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Imperative

   -  `commands <https://kubernetes.io/docs/tasks/manage-kubernetes-objects/imperative-command/>`__ = Using only the CLI (no configuration file) to create and manage resources. Syntax: ``kubectl run`` for Pods and ``kubectl create <RESOURCE_API>`` for most other resources.
   -  `object configuration <https://kubernetes.io/docs/tasks/manage-kubernetes-objects/imperative-config/>`__ = Using the CLI and an existing configuration file/directory to create and manage resources. Syntax: ``kubectl {create,delete,get,replace} -f <FILE>.yaml``.

-  Declarative

   -  `object configuration <https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/>`__ = Directly apply a configuration and change it's state using a manifest file. Syntax: ``kubectl {apply,diff} -f <FILE>.yaml``.

A YAML file can be used to define an object that will be created using an API resource. This is commonly called a manifest, definition, declarative, or an object configuration file. Once it has been applied it becomes a live object configuration that is stored in Kubernetes back-end database. It is recommended to use declarative objects because they can be easily tracked and updated through a source code management (SCM) such as git. [25]

**Run Generators**

In Kubernetes < 1.18, the imperative command ``kubectl run`` would create a Deployment. It could optionally be used to create a Pod instead.

.. code-block:: sh

   $ kubectl run <DEPLOYMENT_NAME> --image=<IMAGE>
   kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.

.. code-block:: sh

   $ kubectl run --generator=run-pod/v1 <POD_NAME> --image=<IMAGE>

In Kubernetes >= 1.18, the command can only create a Pod. This is to align the command with the functionality of ``docker run``.

.. code-block:: sh

   $ kubectl run <POD_NAME> --image=<IMAGE>

[26]

API Resources
-------------

Each section lists the following information:

-  <API_GROUP>

   -  <API_RESOURCE> = <DESCRIPTION>

A manifest file can be created to use the resource following this format:

.. code-block:: yaml

   ---
   apiVersion: <GROUP>/<API_VERSION>
   kind: <API_RESOURCE>
   metadata:
     name: <NAME>
   spec:

Information about every API can be found be using the ``kubectl explain`` command, viewing the `API Reference Docs <https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/>`__, or viewing the `Kubernetes Documentation <https://kubernetes.io/docs/home/>`__.

Cluster
~~~~~~~

Cluster APIs are used by Kubernetes cluster operators to define how it is configured. [21] These are not to be confused with the singular `Cluster API <https://kind.sigs.k8s.io/>`__ that is used to create development Kubernetes clusters using containers.

-  apiregistration.k8s.io

   -  APIService = Add third-party Kubernetes APIs.

-  auditregistration.k8s.io

   -  AuditSink = Audit a Kubernetes cluster dynamically with webhooks.

-  authentication.k8s.io

   -  TokenRequest = Create a token.
   -  TokenReview = Verify if a token is authenticated.

-  authorization.k8s.io

   -  LocalSubjectAccessReview = Check if a specific action can be used by a user within a namespace.
   -  SelfSubjectAccessReview = Check if a specific action can be used by the current user.
   -  SelfSubjectRulesReview = View the actions the current user can do in a namespace.
   -  SubjectAccessReview = Check if a specific action can be used by a user.

-  certificates.k8s.io

   -  CertificateSigningRequest = Force certificates to be signed either automatically or manually.

-  coordination.k8s.io

   -  Lease = Provides an efficient heartbeat from the kubelet service to let the kube-controller-manager know it is still available.

-  core

   -  Binding = Bind objects together.
   -  ComponentStatus = Provides the status of Kubernetes cluster services such as etcd, kube-scheduler, and kube-controller-manager.
   -  Namespace = Create namespaces for developers to isolate their objects.
   -  Node = Manage attributes of worker nodes.
   -  PersistentVolume = Manage persistent and stateful volumes. PersistentVolumeClaims can be created from this object.
   -  ResourceQuota = Manage resource allocations and limits.
   -  ServiceAccount = Manage Kubernetes accounts used by Pods.

-  flowcontrol.apiserver.k8s.io

   -  FlowSchema = Assign priorities to incoming requests.
   -  PriorityLevelConfiguration = Manage the limit of outstanding and queued requests to the kube-apiserver.

-  networking.k8s.io

   -  NetworkPolicy = Manage Pod networks. The network plugin in the Kubernetes cluster has to support this feature (not every plugin does).

-  node.k8s.io

   -  RuntimeClass = Configure containerd or CRI-O runtimes. This can then be used by a Pod.

-  rbac.authorization.k8s.io

   -  ClusterRole = Role-based access control (RBAC) for all resources regardless of namespace separation.
   -  ClusterRoleBinding = A list of users and their permissions for a given ClusterRole.
   -  Role = RBAC for all namespaced resources.
   -  RoleBinding = A list of users and their permissions for a given Role.

Namespace
^^^^^^^^^

-  API group / version (latest): v1
-  Shortname: ns
-  Namespaced: false

----

``ns.spec:``

-  finalizers (list of strings) = This list must be empty before a namespace can be deleted. It can contain any arbitrary values.

----

**Examples:**

NS example.

.. code-block:: yaml

   ---
   kind: Namespace
   apiVersion: v1
   metadata:
     name: new-namespace

NS with finalizers.

.. code-block:: yaml

   ---
   kind: Namespace
   apiVersion: v1
   metadata:
     name: my-namespace
   spec:
     finalizers:
       - foo
       - bar

[21]

PersistentVolume
^^^^^^^^^^^^^^^^

-  API group / version (latest): v1
-  Shortname: pv
-  Namespaced: false

----

``pv.spec:``

-  **accessModes** (list) [18]

   -  ReadOnlyMany = More than one Pod can only read the data to/from this storage
   -  ReadWriteOnce = Only one Pod can read and write to/from this storage.
   -  ReadWriteMany = More than one Pod can read and write data to/from this storage.

-  **capacity (map)**

   -  **storage (string)** = The capacity, in "Gi", that the PV pool contains.

-  claimRef (map) = A reference to bind this PVC object to a PV object.
-  mountOptions (list) = Linux mount options for the PVC on a Pod.
-  nodeAffinity (map) = NodeAffinity settings for selecting what worker nodes this PVC should be used on.
-  persistentVolumeReclaimPolicy (string) = What to do when the volume is no longer required by a Pod.

   -  Retain = Default for manually provisioned PV.
   -  Delete = Default for dynamically provisioned PV.

-  **storageClassName (string)** = Any unique name or the name of an existing StorageClass to inherit attributes from. It is used by PVCs to identify the PV to create storage from. Leave blank to use the default StorageClass (if one exists).
-  volumeMode (string) = The volume type required for the PVC object.

**Storage plugin types (select one and then configure the map of settings):**

-  awsElasticBlockStore
-  azureDisk
-  azureFile
-  cephfs

   -  **monitors** (list of strings) = Ceph monitors to connect to.
   -  path (string) = Default is /. The mounted root.
   -  readOnly (boolean) - If the PV will be read-only.
   -  secretFile (string) = Default is /etc/ceph/user.secret. The key ring file used for authenticating as the RADOS user.
   -  secretRef (map)

      -  name (string) = The name of the Secret object that contains the RADOS key ring file. Use "key" as the key name in the Secret.

   -  user (string) = The RADOS user.

-  csi
-  cinder = OpenStack's Block-Storage-as-a-Service.

   -  fsType (string) = Default is ext4. The file system of the volume.
   -  readOnly (boolean)
   -  secretRef (map) = Authentication details for OpenStack.
   -  **volumeID** (string) = The Cinder volume ID to use.

-  fc (Fibre Channel)
-  flexVolume
-  flocker
-  gcePersistentDisk
-  glusterfs

   -  **endpoints** (string) = The Endpoint that is tied to all of the GlusterFS server IPs.
   -  endpointsNamespace (string) = The namespace the Endpoint is in.
   -  **path** = The GlusterFS network volume/share name.
   -  readOnly (boolean)

-  hostPath = Use a local directory on a worker node to store data. Set a "nodeAffinity" to the worker node that will have the hostPath directory and data available.

   -  **path** (string) = The file system path to use.
   -  type (string) = How to manage the path.

      -  "" = No operation on the path.
      -  BlockDevice = Use a block device.
      -  CharDevice = Use a character device.
      -  Directory = Use an existing directory.
      -  DirectoryOrCreate = Create the directory if it does not exist.
      -  File = Use an existing file.
      -  FileOrCreate = Create the file if it does not exist.
      -  Socket = Use a UNIX socket.

-  iscsi

   -  chapAuthDiscovery (boolean)
   -  chapAuthSession (boolean)
   -  fsType (string)
   -  initiatorName (string) = Set a custom iSCSI Initiator name.
   -  **iqn** (string) = The iSCSI Target.
   -  iscsiInterface (string) = Default is default. The iSCSI Interface name.
   -  **lun** (integer) = The Target LUN number.
   -  portals (list of strings) = A list of ``<IP>:<PORT>`` strings for each iSCSI Portal.
   -  readOnly (boolean)
   -  secretRef (map)

      -  name (string) = The Secret object that contains the CHAP authentication details.

   -  **targetPortal** (string) = The primary iSCSI Target Portal to use.

-  local = Mount a local partition.

   -  fsType (string)
   -  **path** (string) = The full path to the partition to mount.

-  nfs

   -  **path** (string) = The NFS file share.
   -  readOnly (boolean)
   -  **server** (string) = The NFS server address.

-  photonPersistentDisk
-  portworxVolume
-  quobyte
-  rbd

   -  fsType (string)
   -  **image** (string) = The RADOS image to use.
   -  **monitors** (list of strings) = The list of Ceph monitors to connect to.
   -  pool (string) = The RADOS pool to use.
   -  readOnly (boolean)
   -  secretRef (map)

      - name (string) = The Secret name to used for authenticating as the RADOS user.

   -  user (string)

-  scaleIO
-  storageos
-  vsphereVolume

[21][38]

----

**Examples:**

PV with CephFS.

.. code-block:: yaml

   ---
   kind: Secret
   apiVersion: v1
   metadata:
     name: secret-cephfs-key
   data:
     key: lEhoWAwcyRxurSYkGwizxUtVFagtlPIJEntXmzNyfWaCmCMRRuliOr==

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-cephfs
   spec:
     accessModes:
       - ReadWriteMany
       - ReadWriteOnce
     capacity:
       storage: 100Gi
     cephfs:
       monitors:
         - 10.0.0.101
         - 10.0.0.102
         - 10.0.0.103
        secretRef:
          name: secret-cephfs-key
        user: foo

PV with OpenStack's Cinder block storage service. The Kubernetes cluster must first be `configured to work with OpenStack <https://docs.openshift.com/container-platform/3.11/install_config/configuring_openstack.html#install-config-configuring-openstack>`__.

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-cinder
   spec:
     accessModes:
       - ReadWriteMany
       - ReadWriteOnce
     capacity:
       storage: 10Gi
     cinder:
       fsType: ext4
       volumeID: d6dac7fb-e17f-44bb-9708-ee27a679273b

PV with GlusterFS. The GlusterFS client utility ``glusterfs-fuse`` needs to be installed on each Node. A Service and Endpoint are required to access the network shares. They both must share the same object name. The "ports" values are not used but are required by the APIs. [37]

.. code-block:: yaml

   ---
   kind: Service
   apiVersion: v1
   metadata:
     name: glusterfs-network
   spec:
     ports:
       - port: 1
   ---
   kind: Endpoint
   apiVersion: v1
   metadata:
     name: glusterfs-network
   subsets:
     - addresses:
         - ip: 10.10.10.201
       ports:
         - port: 1
     - addresses:
         - ip: 10.10.10.202
       ports:
         - port: 1
     - addresses:
         - ip: 10.10.10.203
       ports:
         - port: 1

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-glusterfs
   spec:
     accessModes:
       - ReadWriteMany
       - ReadWriteOnce
     capacity:
       storage: 300Mi
     glusterfs:
       endpoints: glusterfs-network
       path: glusterVol

PV with hostPath.

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-hostpath
   spec:
     accessModes:
       - ReadWriteOnce
     capacity:
       storage: 50Mi
     hostPath:
       path: /var/lib/k8s-hospath
       type: DirectoryOrCreate

PV with iSCSI.

.. code-block:: yaml

   ---
   kind: Secret
   apiVersion: v1
   metadata:
     name: secret-iscsi-chap
   type: "kubernetes.io/iscsi-chap"
   data:
     discovery.sendtargets.auth.username:
     discovery.sendtargets.auth.password:
     discovery.sendtargets.auth.username_in:
     discovery.sendtargets.auth.password_in:
     node.session.auth.username:
     node.session.auth.password:
     node.session.auth.username_in:
     node.session.auth.password_in:

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-iscsi
   spec:
     accessModes:
       - ReadWriteOnce
     capacity:
       storage: 1Ti
     iscsi:
       chapAuthDiscovery: true
       chapAuthSession: true
       fsType: xfs
       iqn: iqn.food.bar.tld:example
       lun: 0
       readOnly: true
       secretRef:
         name: secret-iscsi-chap
       targetPortal: 192.168.1.15

PV with a local mount.

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-local
   spec:
     accessModes:
       - ReadWriteOnce
     capacity:
       storage: 500Gi
     local:
       fsType: xfs
       path: /dev/vd3

PV with Network File Share (NFS)

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-nfs
   spec:
     accessModes:
       - ReadWriteOnce
     capacity:
       storage: 1Gi
     nfs:
       path: "/"
       server: nfs.server.tld

PVC with RADOS Block Device (RBD).

.. code-block:: yaml

   ---
   kind: Secret
   apiVersion: v1
   metadata:
     name: secret-rbd-key
   data:
     key: eFuBtFpciHkPQBSrJXVpZnsfluklbDYnPRaLrfjoqGbnZfcfunlSyB==

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: pv-rbd
   spec:
     capacity:
       storage: 150Gi
     rbd:
       monitors:
         - 10.0.0.201
         - 10.0.0.202
         - 10.0.0.203
        secretRef:
          name: secret-rbd-key
        user: fu

[36]

Config and Storage
~~~~~~~~~~~~~~~~~~

Config and storage APIs manages key-value stores and persistent data storage. [21]

-  core

   -  ConfigMap = Manage key-value stores.
   -  Secret = Manage base64 encoded key-value stores.
   -  PersistentVolumeClaim = Manage persistent storage created from a PersistentVolume.
   -  Volume = Manage local or network volume mounts.

-  storage.k8s.io

   -  CSIDriver = Define how Kubernetes will interact with the CSI storage back-end.
   -  CSINode = Define CSI drivers.
   -  StorageClass = Manage the automatic creation of persistent storage.
   -  VolumeAttachment = Record when a CSI volume is created. This is used by other resources to then act upon the creation of the object.

ConfigMap
^^^^^^^^^

-  API group / version (latest): v1
-  Shortname: cm
-  Namespaced: true

ConfigMap does not have a ``cm.spec`` section. The ``cm.data:`` field is used the most.

``cm:``

-  binaryData (map) = Define key-value pairs where the value is a base64 encoded string.
-  data (map) = Define key-value pairs.
-  immutable (boolean) = If the key-value pairs in the object should be read-only.

[21]

----

**Examples:**

ConfigMap using all of it's available options.

.. code-block:: yaml

   ---
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: cm-env
   immutable: true
   data:
     hello: world
     foo: bar
   binaryData:
     goodbye: Y3J1ZWwgd29ybGQ=

PersistentVolumeClaim
^^^^^^^^^^^^^^^^^^^^^

-  API group / version (latest): v1
-  Shortname: pvc
-  Namespaced: true

----

Use either ``pvc.spec.selector``, ``pvc.spec.storageClassName``, or ``pvc.spec.volumeName`` to define what PersistentVolume to bind to.

``pvc.spec:``

-  **accessModes** (list of strings) = The accessModes to allow. The lists values must also be allowed in the PV.

   -  ReadOnlyMany
   -  ReadWriteOnce
   -  ReadWriteMany

-  dataSource (map) An existing object to create a new PVC object from.

   -  apiGroup (string) = The API group for the kind. Do not define this key if using PersistentVolume. Use "snapshot.storage.k8s.io" as the value for VolumeSnapshot.
   -  **kind** (string) = PersistentVolumeClaim or VolumeSnapshot.
   -  **name** (string) = The object name.

-  **resources** (map)

   -  limits (map) = The maximum storage allocation.

      -  storage (string) = Specify the requested storage size in the format ``<PVC_STORAGE>Gi``.

   -  **requests** (map) = The minimum storage allocation. This will be the default if ``limits`` is not defined.

      -  **storage** (string)

-  **selector** (`map of Selector <#selector>`_) = The key-value label pairs to find a PV to bind to.
-  **storageClassName** (string) = The StorageClass to create a PVC from.
-  volumeMode (string) = How to manage the PVC when attaching it to a Pod.

   -  Block = The block device will be formatted and then mounted.
   -  Filesystem = The filesystem will be mounted.

-  **volumeName** (string) = The PersistentVolume name to create a PVC from.

----

**Examples:**

PVC example.

.. code-block:: yaml

   ---
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: pvc-app
   spec:
     accessModes:
       - ReadWriteMany
       - ReadWriteOnce
     resources:
       requests:
         storage: 5Gi
     volumeName: <PERSISTENTVOLUME_NAME>

[21]

Secret
^^^^^^^

-  API group / version (latest): v1
-  Shortname: (None)
-  Namespaced: true

Secrets are **not** encrypted. They use base64 encoding. Secret does not have a ``secret.spec`` section. The ``secret.data:`` field is used the most.

``secret:``

-  data (map) = Define key-value pairs with base64 encoded values.
-  immutable (boolean) = If the key-value pairs in the object should be read-only.
-  stringData (map) = Define key-value pairs as strings. The values will be converted into base64 and merged into the ``secret.data`` section. The plain-text values will not be displayed by the API.
-  type (string) = The type of Secret to create. The full list can be found `here <https://github.com/kubernetes/kubernetes/blob/v1.18.0/pkg/apis/core/types.go#L4800-L4886>`__. By default, it is "Opaque" meaning that the key-value pairs are general purpose.

[21]

----

**Examples:**

Secret using all of it's available options.

.. code-block:: sh

   $ echo -n 'kenobi' | base64
   a2Vub2Jp

.. code-block:: yaml

   ---
   kind: Secret
   apiVersion: v1
   metadata:
     name: secret-http-auth
   immutable: true
   type: kubernetes.io/basic-auth
   stringData:
     username: obiwan
   data:
     password: a2Vub2Jp

.. code-block:: sh

   $ kubectl get secret secret-http-auth -o yaml | grep -A 2 ^data:
   data:
     password: a2Vub2Jp
     username: b2Jpd2Fu

[21]

Metadata
~~~~~~~~

Metadata APIs are used to change the behvaior of other objects. [21]

-  admissionregistration.k8s.io

   -  MutatingWebhookConfiguration = Validate and optionally modify API webhook requests.
   -  ValidatingWebhookConfiguration = Validate API webhook requests.

-  apiextensions.k8s.io

   -  CustomResourceDefinition = Create a new API resource.

-  apps

   -  ControllerRevision = View the full history of a Deployment.
   -  PodTemplate = Create a base template that can be used to create Pods from.

-  autoscaling

   -  HorizontalPodAutoscaler = Define metrics to collect for automatic Pod scaling.

-  core

   -  Event = Create a custom event to track and log.
   -  LimitRange = Define default resource requirements for Pods.

-  policy

   -  PodDisruptionBudget = Define the minimum and maximum amount of Pods that should be running during special situations such as eviction.
   -  PodSecurityPolicy = Define Pod users and permissions.

-  scheduling.k8s.io

   -  PriorityClass = Define a custom priority to be used by Pods.

-  settings.k8s.io

   -  PodPreset = Define default settings that a Pod can use.

Service
~~~~~~~

Service APIs are used to manage networks for Pods. [21]

-  core

   -  Endpoints = View simple information about the running Kubernetes networking objects.
   -  Service = Manage internal access to a Pod.

-  discovery.k8s.io

   -  EndpointSlice = A more advanced implementation of Endpoints.

-  networking.k8s.io

   -  Ingress = Manage external access to a Pod based on an existing Service.
   -  IngressClass = Configure the Ingress controller back-end.

Service
^^^^^^^

-  API group / version (latest): v1
-  Shortname: svc
-  Namespaced: true

----

``svc.spec:``

-  clusterIP (string) = Define a static IP address to use for a ClusterIP, LoadBalancer, or Node type.
-  externalIPs (list of strings) = Static IP addresses of from an external unmanaged load balancer.
-  externalName (string) = The domain name to use for routing internal traffic.
-  externalTrafficPolicy (string)

   -  Cluster = Clustered sessions are slower but equally distributed.
   -  Local = Local sessions are faster and more reliable but may not be equally distributed.

-  healthCheckNodePort (integer) = The port to use for health checks. This only works when these two settings are in use: ``svc.spec.type: LoadBalancer`` and ``svc.spec.externalTrafficPolicy: Local``
-  ipFamily (string) = The IP version to use. ``IPv4`` or ``IPv6``.
-  loadBalancerIP (string) = If supported by the cloud-provider, specify an IP address for the load balancer.
-  loadBalancerSourceRanges (list of strings) = If supported by the cloud-provider, only allow incoming connects from these IP addresses.
-  ports (list of maps) = Ports to expose/open.
-  publishNotReadyAddresses (boolean) = Default is false. Publish IP address information to the internal Kubernetes DNS server before a Pod is in a ready state.
-  **selector** (`map of Selector <#selector>`_) = Bind this Service object to a Pod based on the provided labels.
-  sessionAffinity (map) = Default is None.

   -  ClientIP = Keep the same session for a client connecting to a Pod.
   -  None = Do not keep the same session. A client reconnecting may connect to a new Pod.

-  sessionAffinityConfig (map) = Additional settings for the sessionAffinity.

   -  clientIP (map)

      -  timeoutSeconds (integer) = Default is 3 hours. The sticky session timeout in seconds.

-  topologyKeys (list of strings) = A list of Endpoint labels to bind to. The first Endpoint found from the list will be used.
-  **type** (string) = Default is ClusterIP. The type of Service to create.

   -  ClusterIP = Create an internal IP address that load balances requests to a specific Pod.
   -  ExternalName = The same as ClusterIP except it relies on a domain name instead of an IP address.
   -  LoadBalancer = If the cloud provider has an external load balancer offering, this Service object will create a new load balancer.
   -  NodePort = Open a port on every Node and map it to a specific Pod.

----

**Examples:**

SVC with ClusterIP and a static IP address.

.. code-block:: yaml

   ---
   kind: Service
   apiVersion: v1
   metadata:
     name: svc-clusterip
   spec:
     clusterIP: 10.0.0.222
     ports:
       - port: 80
         protocol: TCP
         targetPort: 80
     selector:
       <POD_LABEL_KEY>: <POD_LABEL_VALUE>

SVC with ExternalName.

.. code-block:: yaml

   ---
   kind: Service
   apiVersion: v1
   metadata:
     name: svc-externalname
   spec:
     type: ExternalName
     externalName: foo.bar.com
     ports:
       - port: 50000
         protocol: TCP
         targetPort: 50000
     selector:
       <POD_LABEL_KEY>: <POD_LABEL_VALUE>

SVC with LoadBalancer.

.. code-block:: yaml

   ---
   kind: Service
   apiVersion: v1
   metadata:
     name: svc-loadbalancer
   spec:
     type: LoadBalancer
     externalTrafficPolicy: Local
     loadBalancerSourceRanges:
       - 172.80.0.0/16
       - 130.100.20.0/24
     ports:
       - port: 80
         protocol: TCP
         targetPort: 8080
     selector:
       <POD_LABEL_KEY>: <POD_LABEL_VALUE>

SVC with NodePort.

.. code-block:: yaml

   ---
   kind: Service
   apiVersion: v1
   metadata:
     name: svc-nodeport
   spec:
     type: NodePort
     ports:
       - port: 3000
         protocol: TCP
         targetPort: 3000
     selector:
       <POD_LABEL_KEY>: <POD_LABEL_VALUE>

[21]

Workloads
~~~~~~~~~

Workload APIs manage running applications. [21]

-  apps

   -  DaemonSet = Manages Kubernetes Pods that run on worker nodes. Objects created using this API are usually for logging or networking.
   -  Deployment = Uses both the Pod and ReplicaSet API along with managing the life-cycle of an application. It is designed for stateless applications.
   -  ReplicaSet = New API for manging replicas that has support for label selectors.
   -  StatefulSet = Similar to a Deployment except it can handle persistent storage along with ordered scaling and rolling updates. Each new Pod created will have a new persistent volume claim created (if applicable). [17]

-  batch

   -  CronJob = Schedule Pods to run at specific intervals of time.
   -  Job = A one-time execution of a Pod.

-  core

   -  Pod = The smallest API resource that can be used to create containers.
   -  ReplicationController = Older API for managing replicas. [27]

Most applications should use the Deployment or the StatefulSet API due to the collection of features it provides.

Deployment
^^^^^^^^^^

-  API group / version (latest): apps/v1
-  Shortname: deploy
-  Namespaced: true

----

``deploy.spec:``

-  minReadySeconds (integer) = Default is 0 seconds. The amount of seconds to wait for a Pod to put into the "ready" state.
-  paused (boolean) = If the deployment is paused.
-  progressDeadlineSeconds (integer) = The amount of seconds before a non-ready Deployment is considered to be in the "failed" state.
-  replicas (integer) = Default is 1. The number of Pods to create.
-  revisionHistoryLimit (integer) = Default is 10. The amount of ReplicaSets from a previous Deployment to keep for the purpose of a rollback.
-  **selector** (`map of Selector <#selector>`_) = The ReplicaSet will match Pods with these labels.
-  strategy (map) = The Deployment strategy when updating and rolling back a Deployment.
-  **template** (`map of a Pod manifest <#pod>`_) = The Pod definition to manage as a Deployment.

   -  metadata (map) = Specify any non-``name`` value here.
   -  spec (map)

----

**Examples:**

Deployment example.

.. code-block:: yaml

   ---
   kind: Deployment
   apiVersion: apps/v1
   metadata:
     name: deploy-website
   spec:
     replicas: 5
     selector:
       matchLabels:
         foo: bar
     template:
       metadata:
         labels:
           foo: bar
       spec:
         containers:
           - name: nginx
             image: nginx:1.7.0
             ports:
               - containerPort: 80
           - name: php-fpm
             image: php-fpm:7.0
             ports:
               - containerPort: 8080

[21]

Pod
^^^

-  API group / version (latest): v1
-  Shortname: po
-  Namespaced: true

----

``po.spec:``

-  activeDeadlineSeconds (integer) = The startTime, in seconds, to wait before marking a Pod as failed.
-  affinity (map) = Define scheduling constraints.

   -  nodeAffinity (map) = Specify NodeAffinity spec values here.

      -  requiredDuringSchedulingIgnoredDuringExecution (map)
      -  requiredDuringSchedulingRequiredDuringExecution (map)
      -  preferredDuringSchedulingIgnoredDuringExecution (map)

-  automountServiceAccountToken (boolean) = If the service account token should be available via a mount. The default is true.
-  **containers** (list of `Containers map <#containers>`_) = The list of containers the Pod should create and manage.
-  dnsConfig (map) = DNS settings to add to the /etc/resolv.conf file.

   -  nameservers (list) = List of nameservers.
   -  options (list of maps) = List of options.

      -  name (string)
      -  value (string) = Optional. A value to bind to the option name.

   -  searches (list) = List of searches.

-  dnsPolicy (string) = DNS resolution settings managed by Kubernetes.

   -  ClusterFirst = Default. Quries for domain names that do not include the Kubernetes cluster hostname will use the resolvers from the worker Node.
   -  ClusterFirstWithHostNet = ``Pod.spec.dnsPolicy.ClusterFirst`` for Pods using the ``Pod.spec.hostNetwork`` option.
   -  Default = Use the worker Node's DNS resolution settings.
   -  None = Only provide DNS settings via ``Pod.spec.dnsConfig``.

-  enableServiceLinks (boolean) = Provide Service information via environment variables.
-  ephemeralContainers (list of `Containers map <#containers>`_) = Temporary containers for debugging.
-  hostAliases (map) = Additional /etc/hosts entries.

   -  hostnames (string)
   -  ip (string)

-  hostIPC (boolean) = Default is false. Use the IPC namespace.
-  hostPID (boolean) = Default is false. Use the PID namespace.
-  hostname (string) = Default is "<HOSTNAME>.<SUBDOMAIN>.<POD_NAMESPACE.svc.<CLUSTER_DOMAIN>". The cluster domain default is "cluster.local".  A custom hostname for the Pod.
-  hostNetwork (boolean) = Default is false. Use the worker nodes' primary namespace (not managed by Kubernetes).
-  imagePullSecrets (list of maps)

   -  name (string) = The name of the Secret to use.

-  initContainers (list of `Containers map <#containers>`_) = A list of containers to create in order. If any of them fail then the entire Pod is marked as failed.
-  nodeName (string) = The name of the work Node to schedule the Pod on.
-  nodeSelector (map) = Key-value pairs on a worker Node that must be matched.
-  overhead (`map of System Resources <#system-resources>`_) = The amount of resource overhead by having Kubernetes run the Pod. This is added ontop of amounts defined by ``Pod.spec.containers.resources.limits`` and ``Pod.spec.containers.resources.requests``.
-  preemptionPolicy (string) Defaults to PreemptLowerPriority. Specify a Policy for low priority Pods.
-  priority (integer) = Specify a high or low priority value for the Pod.
-  priorityClassName (string) = Specify a PriorityClass object name to use for priority settings.
-  readinessGates (list of strings) = The readiness gates that need to pass for a Pod to be marked as ready.

   -  conditionType (string) = A valid value from the Pod's condition list.

-  restartPolicy (string) = The policy for when containers stop in a Pod.

   -  Always = Default.
   -  Never
   -  OnFailure

-  runtimeClassName (string) = The container RuntimeClass settings to use.
-  schedulerName (string) = Use a different scheduler besides the default kube-scheduler.
-  securityContext (map) = Permissions to set for all containers in the Pod.

   -  fsGroup (integer) = A group to use volume mounts.
   -  fsGroupChangePolicy (string) = The policy for changing the group permission.

      -  Always (default)
      -  OnRootMismatch

   -  runAsGroup (integer)
   -  runAsNonRoot (boolean)
   -  runAsUser (integer)
   -  seLinuxOptions (map)
   -  supplementalGroups (list of integers) = Additional GID to assign to the process.
   -  sysctls (list of maps) = sysctl parameters to set.

      -  name (string)
      -  value (string)

   -  windowsOptions (map)

-  serviceAccountName (string) = Run the Pod under a different ServiceAccount.
-  shareProcessNamespace (boolean) = Default is false. Use the same namespace for all containers in the Pod.
-  subdomain (string) = The subdomain to use in the full hostname of the Pod.
-  terminationGracePeriodSeconds (integer) = Default is 30. The amount of seconds before forcefully stopping a all containers in the Pod.
-  tolerations (list of maps) = Specify tolerations to Node taints.

   -  key (string) = Taint key.
   -  value (string) = Taint value.
   -  operator (string) = Default is Equal. Alternatively use Exists.
   -  effect (string) = NoExecute, NoSchedule, or PreferNoSchedule.
   -  tolerationSeconds (integer) = The amount of seconds to tolerate a taint.

-  toplogySpreadConstraints (map) = Define how to spread Pods across the Kubernetes cluster.

   -  labelSelector (map) = A key-value pair to find similar Pods. Schedule the Pod to run on that worker Node.
   -  maxSkew (integer) = The number of Pods that can be unevenly distributed.
   -  toplogyKey (string) = A key label on a worker Node to look for.
   -  whenUnsatisfiable (string) = Default is DoNotSchedule. Alternatively use ScheduleAnyway.

-  volumes (list of maps) = Volumes to expose to all of the containers.

   -  name (string) = The name of the PVC
   -  <PV_STORAGE_PLUGIN_TYPE> (map) = Settings for the PVC.

[21]

----

**Examples:**

Pod with two containers.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: two-apps
   spec:
     containers:
       - name: nginx
         image: nginx
       - name: php
         image: php-fpm

Pod thate overrides the ENTRYPOINT for a container.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: phun
   spec:
     containers:
       - name: php
         image: php-fpm
         args:
           - php-fpm
           - --nodaemonize

Pod with persistent storage (without a PVC).

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: db-cb
   spec:
     containers:
       - name: couchbase
         image: couchbase-server:community-6.0.0
         volumeMounts:
           - name: local-volume
             mountPath: /opt/couchbase/var
       volumes:
         - name: local-volume
           hostPath:
             path: /var/lib/couchbase

Pod with persistent storage (with a PVC).

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: db-mysql
   spec:
     containers:
       - name: mariadb
         image: mariadb:10.5
         volumeMounts:
           - mountPath: /var/lib/mysql
             name: mariadb-volume
     volumes:
       - name: mariadb-volume
         persistentVolumeClaim:
           claimName: <PVC_NAME>

Pod with environment variables from different sources.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: all-the-sources
   spec:
     containers:
       - name: nginx
         image: nginx:1.9.0
         env:
           - name: foo
             value: bar
           - name: <KEY>
             valueFrom:
               configMapKeyRef:
                 name: <CONFIGMAP_NAME>
                 key: <CONFIGMAP_KEY>
         envFrom:
           - configMapRef:
               name: <CONFIGMAP_NAME>
           - secretRef:
               name: <SECRET_NAME>

Pod with Secret key-values provided as files on an ephemeral volume.

.. code-block:: sh

   $ kubectl create secret generic --from-literal=foo=bar 007

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: webapp
   spec:
     containers:
       - name: nginx
         image: nginx
         volumeMounts:
           - name: secret-volume
             mountPath: /opt/nginx-config
             readOnly: true
     volumes:
       - name: secret-volume
         secret:
           secretName: "007"

.. code-block:: sh

   $ kubectl exec webapp -- ls -1 /opt/nginx-config/
   foo
   $ kubectl exec webapp -- cat /opt/nginx-config/foo
   bar

Pod with common security settings.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: http-secure
   spec:
     containers:
       - name: nginx
         image: nginx:1.9.0
         securityContext:
           runAsUser: 1000
           capabilities:
             add: ["NET_ADMIN", "SYS_TIME"]
           privileged: false

Pod with quotas set (without a ResourceQuota).

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: miniapp
   spec:
     containers:
       - name: nginx
         image: nginx:1.9.0
      resources:
        requests:
          cpu: 1
          memory: "256Mi"
        limits:
          cpu: 2
          memory: "512Mi"

Pod running on a specific Node based on the Node's hostname.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: simple-app
   spec:
     containers:
       - name: nginx
         image: nginx:1.9.0
     nodeSelector:
       kubernetes.io/hostname: worker04

Third-Party
~~~~~~~~~~~

These APIs are not available on a default installation of upstream Kubernetes.

Ingress
^^^^^^^

-  API group / version (latest): networking.k8s.io/v1beta1
-  Shortname: ing
-  Namespaced: true

----

``ing.spec:``

-  backend (map) = The default backend for when no rule is matched.

   -  resource (map) = Use this OR serviceName and servicePort.

      -  apiGroup (string) = The object API group.
      -  **kind** (string) = The object API kind.
      -  **name** (string) = The object name.

   -  serviceName (string) = The Service name to use.
   -  servicePort (string) = The Service port to use.

-  ingressClassName (string) = The Ingress Controller to use.
-  rules (list of maps) = Rules to define when and where to route public traffic to.

   -  host (string) = The domain name (not an IP address) to accept requests on. This domain should resolve an IP address on one of the Master Nodes in the Kubernetes cluster.
   -  http (map)

      -  paths (list of maps)

         -  **backend** (map) = Backend details specific to this path.

            -  resource (map)

               -  apiGroup (string)
               -  **kind** (string)
               -  **name** (string)

            -  serviceName (string)
            -  servicePort (string)

         -  path (string) = The HTTP path to use. Pathes must begin with ``/``.
         -  pathType (string) = How to find a match for the path. Default is ImplementationSpecific.

            -  Exact = Match the exact path.
            -  Prefix = Split the path by the ``/`` character and find a matching path from that ordered list.
            -  ImplementationSpecific = The IngressClass can determine how to interpret the path.

-  tls (list of maps) = List of all of the SSL/TLS certificates.

   -  hosts (list of strings) = A list of hosts to bind the SSL/TLS certificate to.
   -  secretName (string) = The Secret object name that contains the SSL/TLS certificate.

----

**Examples:**

ING with domain name.

.. code-block:: yaml

   ---
   kind: Ingress
   apiVersion: extensions/v1beta1
   metadata:
     name: ing-domain
   spec:
     rules:
       - host: app.example.com
         http:
           paths:
             - path: /app
               backend:
                 serviceName: svc-foo
                 servicePort: 80

ING with an existing TLS certificate.

.. code-block:: yaml

   ---
   kind: Secret
   apiVersion: v1
   metadata:
     name: secret-tls
   type: kubernetes.io/tls
   data:
     tls.crt: <CERTIFICATE_BASE64_ENCODED>
     tls.key: <KEY_BASE64_ENCODED>
   ---
   kind: Ingress
   apiVersion: extensions/v1beta1
   metadata:
     name: ing-tls
   spec:
     rules:
       - host: login.example.com
         http:
           paths:
             - path: /
               backend:
                 serviceName: svc-bar
                 servicePort: 80
     tls:
       - hosts:
           - login.example.com
         secretName: secret-tls

[21]

(Common Reoccuring Fields)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Containers
^^^^^^^^^^

``Pod.spec.{containers,ephemeralContainers,initContainers}`` (list of maps)

-  args (list of strings) = CMD.
-  command (list of strings) = ENTRYPOINT.
-  env (list of maps) = Environment variables to load in the container.
-  envFrom (list of maps) = Environment variables (from another object) to load in the container.

   -  configMapRef (map)

      -  name (string) = Name of the ConfigMap object to load.

   -  prefix (string) = A prefix to append to each key from the ConfigMap.

-  **image** (string)
-  imagePullPolicy (string)

   -  Always = Default for "latest" tag.
   -  IfNotPresent = Default for all other tags.
   -  Never

-  lifecycle (map)

   -  postStart (map) = Action to take after a container starts.

      -  exec (map)

         -  command (list of strings) = A command to run.

      -  httpGet (map) = A HTTP URL to GET.

         -  httpHeaders (map)
         -  path (string)
         -  port (string)
         -  scheme (string) = Defaults to HTTP. Optionally set to HTTPS.

      -  tcpSocket (map) = A TCP socket to connect to.

         -  port (string)

   -  preStop (map) = Action to take before a container stops.

      -  exec (map)
      -  httpGet (map)
      -  tcpSocket (map)

-  livenessProbe (`map of Probe <#probe>`_) = Probe to see if the application in the container is running properly.
-  **name** (string) = Name of the container.
-  ports (map) = Manage ports for the container.

   -  containerPort (integer) = The port in the container to open.
   -  hostIP (string) = The IP address to bind the ``Pod.spec.containers.hostPort`` to.
   -  hostPort (integer) = The port on the worker node to open.
   -  name (string) = Optionally provide a name. This can be used by a Service object.
   -  protocol (string) = Default is TCP. Set to TCP, UDP, or SCTP.

-  readinessProbe (`map of Probe <#probe>`_) = Probe to see if the application is ready to be exposed by a network Service..
-  resources (map)

   -  limits (`map of System Resources <#system-resources>`_) = Hard resource limits.
   -  requests (`map of System Resources <#system-resources>`_) = Estimated resource usage. Used by kube-scheduler to help find a suitable worker Node.

-  securityContext (map)

   -  allowPrivilegeEscalation (boolean) = If a user can access higher privileges than it currently has.
   -  capabilities (map) = The capabilities the container has access to.

      -  add (string)
      -  remove (string)

   -  privileged (boolean) = Default is false. If the container should run with root privileges.
   -  procMount (string) = The proc mount type.
   -  readOnlyRootFilesystem (boolean) = Default is false. If the container should be read-only.
   -  runAsGroup (integer) = GID.
   -  runAsNonRoot (boolean) = If the container should not run as the root user.
   -  runAsUser (integer) = UID.
   -  seLinuxOptions (map) = SELinux contexts to set for the container.

      -  level (string)
      -  role (string)
      -  type (string)
      -  user (string)

   -  windowsOptions (map) = Windows specific settings.

-  startupProbe (`map of Probe <#probe>`_) = Probe to see if the application in the container has fully started.
-  stdin (boolean) = Default is false. If stdin should be allowed.
-  stdinOnce (boolean) = Default is false. If stdin should be sent to the container once.
-  terminationMessagePath (string) = File path to write the termination message to.
-  terminationMessagePolicy (string) = Default is File. Alternatively use FallbackToLogsOnError.
-  tty (boolean) = Default is false. Requires ``Pod.spec.containers.stdin`` to be true. If a TTY should be created for the container.
-  volumeDevices (map) = Mount a PersistentVolumeClaim.

   -  devicePath (string) = The path in the container to mount to.
   -  name (string) = The name of the Pod's PVC to mount.

-  volumeMounts (map) = Mount a volume.

   -  mountPath (string) = The path in the container to mount to.
   -  mountPropagation (string) = Default is MountPropagationNone. How the moutns are propagated to or from the host and container.
   -  name (string)
   -  readOnly (boolean) = If the volume should be read-only.
   -  subPath (string) = Defaults to the root directory (""). The path in the volume to mount.
   -  subPathExpr (string) = The same as ``Pod.spec.volumeMounts.subPath`` except environment variables can be used.

-  workingDir (string) = The working directory for the ``Pod.spec.containers.command`` (ENTRYPOINT) or ``Pod.spec.containers.args`` (CMD).

[21]

Probe
^^^^^

``Pod.spec.containers.{liveness,readiness,startup}Probe`` (map)

-  exec (map) = Execute a command.

   -  command (list of strings) = The command and arguments to execute.

-  failureThreshold (integer) = Default is 3. Minimimum number of probe failures allowed.
-  httpGet (map)
-  initialDelaySeconds (integer) = Seconds to delay before starting a probe.
-  periodSeconds (integer) = Default is 10. The interval, in seconds, to run a probe.
-  successThreshold (integer) = Default is 1. The amount of times a probe needs to succeed before marking the a previously failed probe check as now passing.
-  tcpSocket (map)
-  timeoutSeconds (integer) = Default is 1. The amount of seconds before the probe times out.

[21]

Selector
^^^^^^^^

``deploy.spec.selector``, ``pvc.spec.selector``, ``svc.spec.selector`` (map)

-  matchExpressions (list of maps) = Do a logical lookup for labels.

   -  **key** (string) = The label key.
   -  **operator** = DoesNotExist, Exists, In, or NotIn. The operator will analyze the key-value pair.
   -  values (list of strings) = A list of possible values.

-  matchLabels (map) = Specify any exact key-value label pair to match.

System Resources
^^^^^^^^^^^^^^^^

``Pod.spec.containers.resources.{limit,requests}``, ``Pod.spec.overhead`` (map)

-  cpu (string) = Specify the CPU load number.
-  memory (string) = Specify "Mi" or "Gi" of RAM.

[21]

Concepts
--------

Popular APIs
~~~~~~~~~~~~

These are common Kubernetes APIs used by developers [28]:

-  ConfigMap
-  CronJob
-  DaemonSet
-  Deployment
-  HorizontalPodAutoscaler
-  Ingress
-  Job
-  PersistentVolumeClaim
-  Pod
-  ReplicaSet
-  Secret
-  Service
-  StatefulSet
-  VerticalPodAutoscaler

Labels and Annotations
~~~~~~~~~~~~~~~~~~~~~~

Labels and annotations both provide a way to assign a key-value pair to an object. This can later be looked up by other objects and by administrators. Labels help to organize related objects and perform actions on them. Many APIs support using a selector to lookup and bind to objects with labels that are found. Helm has a variety of labels that it recommends. [44] Annotations are similar except they are meant for non-human processing.

Define labels and annotations in the metadata section of a manifest.

.. code-block:: yaml

   ---
   metadata:
     annontations:
       <KEY>: <VALUE>
     labels:
       <KEY>: <VALUE>

View all labels in use.

.. code-block:: sh

   $ kubectl get all --show-labels

View all objects with a specific label.

.. code-block:: sh

   $ kubectl get all -l "<KEY>=<VALUE>"

Namespaces
~~~~~~~~~~

Namespaces help to isolate objects. Common use cases include having one application per Namespace or one team per Namespace.

View what APIs do and do not support being created inside a Namespace. Any resource that does not support a Namespace is globally accessible [43], such as a PersistentVolume.

.. code-block:: sh

   $ kubectl api-resource --namespace=true
   $ kubectl api-resource --namespace=false

An object can declaratively bind itself to a Namespace by specifying it in the metadata.

.. code-block:: yaml

   ---
   metadata:
     namespace: <NAMESPACE_NAME>

Persistent Storage
~~~~~~~~~~~~~~~~~~

By default, all storage is emphemeral. The PersistentVolume (PV) and PersistentVolumeClaim (PVC) APIs provide a way to persistently store information for use-cases such as databases. A PV defines the available storage and connection details for the Kubernetes cluster to use. A PVC defines the storage allocation for use by a Pod.

The example below shows how to configure static storage for a Pod using a directory on a worker node.

-  Create a PV. Set a unique ``<PV_NAME>``, use any name for storageClassName, configure the ``<PV_STORAGE_MAX>`` gigabytes that the PV can allocate, and define the ``<LOCAL_FILE_SYSTEM_PATH>`` where the data from Pods should be stored on the worker nodes. In this scenario, it is also recommended to configure a ``nodeAffinity`` that restricts the PV from only being used by the worker node that has the local storage.

.. code-block:: yaml

   ---
   kind: PersistentVolume
   apiVersion: v1
   metadata:
     name: <PV_NAME>
   spec:
     storageClassName: <STORAGE_CLASS_NAME>
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

-  Create a PVC from the PV pool. Set a unique ``<PVC_NAME>`` and the ``<PVC_STORAGE>`` size. The size should not exceed the maximum available storage from the PV. To bind to the previously created PV, use the same ``<STORAGE_CLASS_NAME>``

.. code-block:: yaml

   ---
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: <PVC_NAME>
   spec:
     storageClassName: <STORAGE_CLASS_NAME>
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: <PVC_STORAGE>Gi

-  Create a Pod using the PVC. Set ``<POD_VOLUME_NAME>`` to a nickname of the PVC volume that will be used by the actual Pod and indicate the ``mountPath`` for where it should be mounted inside of the container.

.. code-block:: yaml

   ---
   kind: Pod
   apiVersion: v1
   metadata:
     name: <POD_NAME>
   spec:
     volumes:
       - name: <POD_VOLUME_NAME>
         persistentVolumeClaim:
           claimName: <PVC_NAME>
     containers:
       - name: mysql
         image: mysql:8.0
         volumeMounts:
           - mountPath: "/var/lib/mysql"
             name: <POD_VOLUME_NAME>

[19]

Service and Ingress (Public Networking)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are two APIs for managing networking in Kubernetes: Service (internal) and Ingress (external). A Service by itself is used to expose access to a Pod and ports in it for development and testing purposes. There are various different types of services. Most can be managed by ``kubectl expose``.

ServiceTypes [39]:

-  ClusterIP = Opens a port and exposes it on an internal IP that can only be accessed on Nodes (no external connectivity). Internally in Kubernetes, requests to ``<SERVICE>.default.svc.cluster.local`` will be redirected to this IP address. The port is only open on the Nodes which have the related Pod running.
-  NodePort = Opens a port on every Node (even if a Pod it is tied to is not on it). Connectivity can be made through the IP address of the Nodes that have the Pod running.
-  LoadBalancer = Use a third-party cloud provider's load balancing service.
-  ExternalName = Similar to a ClusterIP except a domain name can be given. ``kubectl expose --type=ExternalName`` currently `does not work <https://github.com/kubernetes/kubernetes/issues/87398>`__ because there is no argument for the external name.

Ingress is used to publicily expose a Pod and it's ports. It can redirect traffic based on domain names and HTTP paths. It also supports creating load balancers and handling SSL/TLS termination. It requires a Service to bind to. [40]

Ingress Controllers are different back-ends that handle the Ingress API. They use different technologies and generally have their own use-cases. The only ones that are officially supported are NGINX and Google's Compute Engine (GCE).

Top 5 Ingress Controllers and their use-cases [41]:

-  Ambassador = API gateway.
-  HAProxy = Load balancing.
-  Istio Ingress Gateway = Fast performance.
-  NGINX = Default.
-  Traefik = Let's Encrypt SSL/TLS generation.

A Kubernetes cluster can have more than one Ingress Controller installed. In an object's manifest, the one to use can be specified. [42]

Kubernetes < 1.18:

.. code-block:: yaml

   metadata:
     annotations:
       kubernetes.io/ingress.class: <INGRESS_CONTROLLER>

Kubernetes >= 1.18:

.. code-block:: yaml

   spec:
     ingressClassName: <INGRESS_CONTROLLER>

Helm (Package Manager)
~~~~~~~~~~~~~~~~~~~~~~

Helm is a package manager for Kubernetes applications. Helm 2 and below required a Tiller server component to be installed on the Kubernetes cluster. This is no longer required as of Helm 3. Helm is now a standalone client-side-only command. [32]

Vocabulary:

-  Chart = A Helm package with all of the related resource manifests to run an application.
-  Repository = A collection of Charts that can be installed.
-  Release = A unique name given each time a Chart is installed. This is used to help track different installations and the history of a Helm Chart.

`Helm Hub <https://hub.helm.sh/>`__ is the official repository for Helm Charts. There are currently over one thousand Charts available. Third-party repositories are also supported. Helm can even install Charts from a directory (such as a local git repository). [33]

Each Chart contains a "values.yaml" for manifest settings that can be overridden. It is expected that it contains sane defaults and can be deployed without any modifications. The manifest files are `Go templates <https://golang.org/pkg/text/template/>`__ that get rendered out based on the values provided to Helm. `The Chart Template Developer's Guide <https://helm.sh/docs/chart_template_guide/>`__ explains in more detail how to fully customize templates. It is possible to override values that are not templated, or to add new ones, by using `Kustomize <https://kustomize.io/>`__. The biggest downside to using Kustomize is that Helm no longer has visibility into the release/life-cycle of a Chart. [34]

Installation
------------

kubectl (CLI)
~~~~~~~~~~~~~

The ``kubectl`` command is used to manage Kubernetes objects. The binary version can manage a Kubernetes cluster of the same version and the previous minor release. [30]

Installation:

.. code-block:: sh

   $ cd ~/.local/bin/
   $ export KUBE_VER="1.18.3"
   $ curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VER}/bin/linux/amd64/kubectl
   $ chmod +x ./kubectl
   $ kubectl version --client

::

   Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.3", GitCommit:"2e7996e3e2712684bc73f0dec0200d64eec7fe40", GitTreeState:"clean", BuildDate:"2020-05-20T12:52:00Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}

By default, the configuration file (provided by the Kubernetes cluster administrator) will be loaded from the file ``~/.kube/config``. This can be set to a different file. [31]

.. code-block:: sh

   $ export KUBECONFIG="<PATH_TO_KUBE_CONFIG>.yml"
   $ kubectl config view
   $ kubectl cluster-info
   $ kubectl version

helm (CLI)
~~~~~~~~~~

Find the latest version from `Helm's GitHub releases page <https://github.com/helm/helm/releases>`__. [35]

Installation:

.. code-block:: sh

   $ export HELM_VER="3.2.2"
   $ curl -LO https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz
   $ tar -x -f helm-v${HELM_VER}-linux-amd64.tar.gz
   $ cp linux-amd64/helm ~/.local/bin/

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

Kubernetes requires a network provider, Flannel by default, to create an overlay network for inter-communication between Pods across all of the worker nodes. A CIDR needs to be defined and can be any network.

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
17. "Kubernetes Persistent Volumes with Deployment and StatefulSet." Alen Komljen. January 17, 2019. Accessed May 29, 2020. https://akomljen.com/kubernetes-persistent-volumes-with-deployment-and-statefulset/
18. "Persistent Volumes." Kubernetes Concepts. January 16, 2019. Accessed January 29, 2019. https://kubernetes.io/docs/concepts/storage/persistent-volumes/
19. "Configure a Pod to Use a PersistentVolume for Storage." Kubernetes Tasks. December 20, 2019. Accessed June 3, 2020. https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
20. "So you want to change the API?" GitHub kubernetes/community. June 25, 2019. Accessed April 15, 2020. https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api_changes.md
21. "[Kubernetes 1.18] API OVERVIEW." Kubernetes API Reference Docs. April 13, 2020. Accessed June 30, 2020. https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/
22. "Kubernetes Resources and Controllers Overview." The Kubectl Book. Accessed April 29, 2020. https://kubectl.docs.kubernetes.io/pages/kubectl_book/resources_and_controllers.html
23. "Overview of kubectl." Kubernetes Reference. March 28, 2020. Accessed April 29, 2020. https://kubernetes.io/docs/reference/kubectl/overview/
24. "Using kubectl to jumpstart a YAML file — #HeptioProTip." heptio Blog. September 21, 2017. Accessed April 29, 2020. https://blog.heptio.com/using-kubectl-to-jumpstart-a-yaml-file-heptioprotip-6f5b8a63a3ea
25. "Declarative Management of Kubernetes Objects Using Configuration Files." Kubernetes Tasks. May 2, 2020. Accessed May 28, 2020. https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/
26. "Kubernetes Tips: Create Pods With Imperative Commands in 1.18." Better Programming - Medium. April 7, 2020. Accessed May 28, 2020. https://medium.com/better-programming/kubernetes-tips-create-pods-with-imperative-commands-in-1-18-62ea6e1ceb32
27. "ReplicationController." Kuberntes Concepts. March 28, 2020. May 29, 2020. https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/
28. "What are the most useful Kubernetes Resources for developers?" www.Dev4Devs.com. October 20, 2019. Accessed June 8, 2020. https://dev4devs.com/2019/10/20/what-are-the-kubernetes-resources-which-are-most-useful-for-developers/
29. "kube-controller-manager." Kubernetes Reference. April 13, 2020. Accessed June 8, 2020. https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/
30. "Install and Set Up kubectl." Kubernetes Tasks. May 30, 2020. Accessed June 11, 2020.https://kubernetes.io/docs/tasks/tools/install-kubectl/
31. "Configure Access to Multiple Clusters." Kubernetes Tasks. May 30, 2020. Accessed June 11, 2020. https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/
32. "Helm 3.0.0 has been released!" Helm Blog. November 13, 2019. Accessed June 16, 2020. https://helm.sh/blog/helm-3-released/
33. "Using Helm." Helm Docs. Accessed June 16, 2020. https://helm.sh/docs/intro/using_helm/
34. "Customizing Upstream Helm Charts with Kustomize." Testing Clouds at 128bpm. July 20, 2018. Accessed June 16, 2020. https://testingclouds.wordpress.com/2018/07/20/844/
35. "Installing Helm. Helm Docs. Accessed June 16, 2020. https://helm.sh/docs/intro/install/
36. "examples." GitHub kubernetes/examples. May 21, 2020. Accessed June 25, 2020.  https://github.com/kubernetes/examples
37. "Complete Example Using GlusterFS." OpenShift Container Platform 3.11 Documentation. June 21, 2020. Accessed June 25, 2020. https://docs.openshift.com/container-platform/3.11/install_config/storage_examples/gluster_example.html
38. "Volumes." Kubernetes Concepts. May 15, 2020. Accessed June 25, 2020. https://kubernetes.io/docs/concepts/storage/volumes/
39. "Service." Kubernetes Concepts. May 30, 2020. Accessed June 28, 2020. https://kubernetes.io/docs/concepts/services-networking/service/
40. "Ingress." Kubernetes Concepts. May 30, 2020. Accessed June 28, 2020. https://kubernetes.io/docs/concepts/services-networking/ingress/
41. "Comparison of Kubernetes Top Ingress Controllers." caylent. May 9, 2019. Accessed June 28, 2020. https://caylent.com/kubernetes-top-ingress-controllers
42. "Ingress Controllers." Kubernetes Concepts. May 30, 2020. Accessed June 28, 2020. https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
43. "Namespaces." Kubernetes Concepts. June 22, 2020. Accessed June 30, 2020. https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
44. "Labels and Annotations." Helm Docs. Accessed June 30, 2020. https://helm.sh/docs/chart_best_practices/labels/
