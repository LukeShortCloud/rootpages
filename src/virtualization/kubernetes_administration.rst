Kubernetes Administration
=========================

.. contents:: Table of Contents

Architecture
------------

Kubernetes
~~~~~~~~~~

Kubernetes, also known as k8s, is an open-source container management platform. It handles the life-cycle of Pods which are a collection of related containers required to run an application. Kubernetes clusters contain two types of servers:

-  Control Plane Node (previously known as Master Node) = Manages the state of the Nodes and their Pods.
-  Worker Node (previously known as Node, Worker, Worker Machines, or Minion) = Run user applications in containers and respond to requests from the Control Plane Nodes.

Control Plane Node services:

-  etcd = The most common database for storing all of the Kubernetes configuration data.
-  kube-apiserver = Handles authentication requests and retrieving/storing data from/to etcd.
-  kube-controller-manager = Monitors and controls Kubernetes resources. It will perform recovery tasks if a failure is detected. This binary runs many different controller processes:

   -  attachdetach, bootstrapsigner, cloud-node-lifecycle, clusterrole-aggregation, cronjob, csrapproving, csrcleaner, csrsigning, daemonset, deployment, disruption, endpoint, endpointslice, garbagecollector, horizontalpodautoscaling, job, namespace, nodeipam, nodelifecycle, persistentvolume-binder, persistentvolume-expander, podgc, pv-protection, pvc-protection, replicaset, replicationcontroller, resourcequota, root-ca-cert-publisher, route, service, serviceaccount, serviceaccount-token, statefulset, tokencleaner, ttl, ttl-after-finished [18]

-  kube-scheduler = Determines what Node to schedule a Pod on.

Worker Node services:

-  Container runtime = Any service for executing containers that supports the Container Runtime Interface (CRI). Kubernetes officially supports containerd, CRI-O, and docker. [42]
-  kubelet = Manages containers using the container runtime.
-  kube-proxy = Handles virtual networking connections for internal (containers across different Nodes) and external (Kubernetes Services) use.

[1]

Networking
^^^^^^^^^^

Pod Networking
''''''''''''''

Kubernetes requires a Container Network Interface (CNI) plugin to create an overlay network for inter-communication between Pods across all of the Control Plane and Worker Nodes. The default Pod network CIDR (as configured by ``kubeadm init --pod-network-cidr``) is normally assumed to be 10.244.0.0/16. The default Service network CIDR (as configured by ``kubeadm init --service-cidr``) is 10.96.0.0/12. [61]

Ports
'''''

Depending on the role of the Node and what Container Network Interface (CNI) plugin is used, different ports need to be opened in the firewall.

Control Plane Nodes:

.. csv-table::
   :header: Port, Description
   :widths: 20, 20

   2379/TCP, etcd client.
   2380/TCP, etcd server.
   6443/TCP, kube-api-server.
   10250/TCP, kubelet.
   10251/TCP, kube-scheduler.
   10252/TCP, kube-controller-manager.
   10254/TCP, Ingress Controller probes.
   30000-32767/TCP+UDP, Default NodePort ports when a port is not specified.

Worker Nodes:

.. csv-table::
   :header: Port, Description
   :widths: 20, 20

   10250/TCP, kubelet.
   30000-32767/TCP+UDP, Default NodePort ports when a port is not specified.

CNI Ports (All Nodes) [60]:

.. csv-table::
   :header: Port, Description
   :widths: 20, 20

   179/TCP, Calico BGP.
   8472/UDP, Flannel VXLAN overlay network (Linux).
   4789/UDP, Flannel VXLAN overlay network (Windows).
   4789/UDP, Antrea VXLAN overlay network.
   6081/UDP, Antrea Geneve overlay network.
   7471/TCP, Antrea STT overlay network.
   9099/TCP, Flannel probes.
   6783/TCP, Weave.
   6783-6784/UDP, Weave.
   10349-10250/TCP, Antrea.

[47]

Recommended Architecture
^^^^^^^^^^^^^^^^^^^^^^^^

These are recommendations for a generic upstream Kubernetes cluster.

-  **Operating system: Debian**

   -  Most deployments of vanilla Kubernetes use a Debian-based distribution. For Fedora based-distributions, the very customized and opinionated OpenShift fork of Kubernetes is used.

-  **Firewall: ufw**

   -  firewalld is known to cause issues. Even the official Kubernetes installer ``kubeadm`` warns against using it. [94]
   -  ufw is a lot easier to manage than pure iptables/nftables. However, it loads rules before kube-proxy does so extra rules need to be in place to allow certain traffic. [95]

-  **Container runtime: crun**

   -  It is twice as fast as runc and uses less memory. This is due to it being written in C instead of Go. [96]

-  **Container runtime interface (CNI): containerd**

   -  containerd provides the best overall performance.
   -  CRI-O is recommended for heavy I/O workloads. [97]

-  **Kubernetes installer: kubeadm**

   -  This is the standard installer created and maintained by the Kubernetes community.

-  **CNI plugin: Antrea**

   -  This is the most feature-rich CNI plugin.

-  **Ingress Controller: Traefik**

   -  This is the most popular Ingress Controller.

k3s
~~~

Networking
^^^^^^^^^^

Ports
'''''

firewalld is not supported on k3s. iptables is the recommended firewall. [92]

Control Plane Nodes:

.. csv-table::
   :header: Port, Description
   :widths: 20, 20

   22/TCP, SSH for the Node Driver.
   80/TCP, Proxy to use with an external SSL/TLS termination app.
   443/TCP, Rancher UI and API. Rancher Catalogs.
   2376/TCP, Docker TLS port for Docker Machine.
   6443/TCP, kube-api-server.
   8472/UDP, Flannel VXLAN overlay network (Linux).
   10250/TCP, kubelet.

Worker Nodes:

.. csv-table::
   :header: Port, Description
   :widths: 20, 20

   22/TCP, SSH for the Node Driver.
   443/TCP, Rancher Catalogs.
   2376/TCP, Docker TLS port for Docker Machine.
   8472/UDP, Flannel VXLAN overlay network (Linux).
   10250/TCP, kubelet.

[47]

OpenShift
~~~~~~~~~

The Red Hat OpenShift Container Platform (RHOCP) is an enterprise product based on Google's Kubernetes. [16] It has a stronger focus on security with support for having access control lists (ACLs) for managing containers in separate projects and full SELinux support. It also provides more features to extend Kubernetes functionality.

The Origin Kubernetes Distribution (OKD), originally known as OpenShift Origin, is the free and open source community edition of RHOCP. [4] OKD 4.5 was the first stable release for the 4.Y series. [21] It supports being deployed ontop of Red Hat CoreOS and Fedora CoreOS. [21]

OpenShift has 3 primary architectures:

-  Single Node (OKD only) = Proof-of-concept deployments with all OpenShift services running on a single Node.
-  Three Node = Edge deployments using multiple Single Nodes.
-  Full = Production deployments (recommended minimum requirements). [23]

   -  x3 Control Nodes
   -  x2 Logging and monitoring Nodes
   -  x3 Routing Nodes
   -  x2 Worker Nodes

Node types and services:

-  Control = These Nodes have to be deployed using Red Hat CoreOS (RHOCP) or Fedora CoreOS (OKD). [24] All other Nodes can use RHEL (RHOCP) or Fedora (OKD).

   -  etcd
   -  kube-api
   -  kube-controller-manager

-  Logging and Monitoring [25]

   -  EFK stack

      -  Fluentd = Log collection.
      -  Elasticsearch = Log storage.
      -  Kibana = Visualization.

   -  Curator = Log filtering (based on timestamps) in OpenShift < 4.5.

-  Router = This Node is optional and is combined with the Control Node by default. [26]

   -  Ingress = HAProxy and/or F5 BIG-IP.

-  Worker/Compute = The life-cycle of these Nodes are handled by the MachineSet API. Control Plane Nodes do not use the MachineSet API as to prevent accidental deletion of the control plane. [24]

   -  CRI-O (container runtime)
   -  kubelet

Supported infrastructure for installing OpenShift on [27]:

-  Public cloud

   -  Amazon Web Services (AWS)
   -  Google Compute Platform (GCP)
   -  Microsoft Azure

-  On-site

   -  Bare metal
   -  OpenStack
   -  Red Hat Virtualization (RHV)
   -  VMWare vSphere

PersistentVolume support [3]:

-  AWS Elastic Block Store (EBS)
-  Azure Disk
-  Azure File
-  Cinder
-  Container Storage Interface (CSI) = Any storage provider that uses CSI as a front-end can be used with OpenShift.
-  Fibre Channel
-  Google Compute Engine (GCE) Persistent Disk
-  HostPath
-  iSCSI
-  Local volume
-  NFS
-  Red Hat OpenShift Container Storage (Ceph RBD)
-  VMWare vSphere

Tanzu
~~~~~

Tanzu (pronounced tawn-zoo) Kubernetes Grid (TKG) is developed by VMware as a collection of different products to install upstream Kubernetes.

There are currently four offerings for TKG [54]:

-  **TKG Multicloud (TKGm)** or **TKG** = TKGm, sometimes referred to as just TKG, supports creating and managing infrastructure on Amazon Web Services, Microsoft Azure, and VMware vSphere 6. For VMware vSphere 7, TKGm can be used but TKGS is recommended instead.
-  **Tanzu Community Edition (TCE)** = The free and open source upstream version of TKGm.
-  **TKG Services (TKGS)** = VMware vSphere 7 creates and manages the Kubernetes cluster.
-  **TKG Integrated Edition (TKGI)** = Previosuly Enterprise PKS. Uses BOSH to deploy and manage virtual machines for the Kubernetes cluster. BOSH supports creating infrastructure on Alibaba Cloud, Amazon Web Services, Google Cloud Platform, Microsoft Azure, OpenStack, and VMware vSphere. [55]

TKGm
^^^^

TKGm stands for TKG Multicloud. It is a product for installing Kubernetes on-top of virtual infrastructure provided by AWS, Azure, GCE, or VMware vSphere. It first deploys an all-in-one TKG Management Cluster using `kind <https://kind.sigs.k8s.io/>`__. This then uses the `Cluster API <https://cluster-api.sigs.k8s.io/>`__ to deploy and manage one or more production Kubernetes clouds. [32]

TCE
^^^

Supported storage classes [90]:

-  Amazon Elastic Block Store (EBS)
-  Azure Disk
-  Internet Small Computer System Interface (iSCSI)
-  Network File System (NFS)
-  vSphere Cloud Native Storage (CNS)

TKGS
^^^^

TKG Service (TKGS) is a product built into VMware vSphere 7 that provides heavy integration with Kubernetes.

Requirements for TKGS:

-  ESXi hypervisors = At least two are required. For the best results, use three or more.
-  vSphere HA = Highly available vSphere clusters.
-  HAProxy load balancer = Virtual machines running HAProxy are used for load balancing requests to Kubernetes.
-  DRS = Distributed Resource Scheduler.
-  vSAN = Virtual Storage Area Network.
-  vDS = vSphere Distributed Switch.

Layers of TKGS:

1.  Supervisor cluster = The Kubernetes workload management cluster. Only vSphere itself has full access to the administrative account. End-users are expected to log into a namespace to create a production Kubernetes cluster.
2.  Supervisor cluster namespace = This namespace exists in both vSphere and Kubernetes. It is used to isolate teams and resources. This is used to create the production Kubernetes cluster using the TanzuKubernetesCluster API.
3.  TanzuKubenretesCluster (tkc) = This is the Kubernetes cluster that will be used for deploying applications.

[73]

Networking
''''''''''

CNI plugin [74][99]:

-  Kubernetes >= 1.18 = Antrea
-  Kubernetes <= 1.17 = Calico

Service LoadBalancer = HAProxy or NSX-T Load Balancer. [75]

Releases
--------

Kubernetes
~~~~~~~~~~

Kubernetes was originally created by Google in 2003 and was called the Borg System. In 2014, it was renamed to Kubernetes and released as open-source software under the Apache License version 2.0. [2]

Release highlights:

-  `1.0 <https://www.zdnet.com/article/google-releases-kubernetes-1-0/>`__

   -  First stable public release of Kubernetes.

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

   -  `minikube <https://minikube.sigs.k8s.io/docs/>`__ was created for quick and easy development environment for Kubernetes.
   -  `Container Network Interface (CNI) <https://github.com/containernetworking/cni>`__ is now supported.
   -  `rkt <https://coreos.com/rkt/>`__ can now be used as a container runtime.
   -  Cross-cluster discovery support for running Pods across multiple clouds.
   -  `PetSet objects <https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/>`__ (later `renamed to SatefulSet <https://github.com/kubernetes/kubernetes/issues/35534>`__) introduced for running stateful applications such as databases.

-  `1.4 <https://kubernetes.io/blog/2016/09/kubernetes-1-4-making-it-easy-to-run-on-kuberentes-anywhere/>`__

   -   `kubeadm <https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/>`__ introduced for installing Kubernetes clusters.
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

   -  Topology Manager API now supports NUMA CPU pinning.
   -  `kubectl alpha debug <https://kubernetes.io/docs/tasks/debug-application-cluster/debug-running-pod/#ephemeral-container>`__ argument introduced to attach a temporary container to a running container for troubleshooting purposes.
   -  Windows CSI now supports privileged storage configurations.

-  `1.19 <https://kubernetes.io/blog/2020/08/26/kubernetes-release-1.19-accentuate-the-paw-sitive/>`__

   -  Each major Kubernetes release is now supported for 12 months (up from 9).
   -  APIs that are in-development must reach the next tier of stability during the next Kubernetes release. If not, they will be deprecated and removed from the project.
   -  New APIs:

      -  EndpointSlice
      -  CSIStorageCapacity = An object is automatically created for a supported CSI driver to report back the available storage.

   -  Stable APIs:

      -  CertificateSigningRequest
      -  Event
      -  Ingress

   -  TLS 1.3 support.
   -  Ephemeral PVCs.
   -  Consistent log format for all Kubernetes control plane logs.

-  `1.20 <https://kubernetes.io/blog/2020/12/08/kubernetes-1-20-release-announcement/>`__

   -  Dockershim has been deprecated. In a future release, Kubernetes will no longer directly use the ``docker`` binary to manage containers.
   -  Exec probes have been fixed to finally timeout properly.
   -  Alpha APIs:

      -  Graceful shutdown of pods during a node shutdown is now supported (but disabled by default): ``kube-apiserver --feature-gates=GracefulNodeShutdown=false``

   -  Beta APIs:

      -  ``kubectl debug``

   -  Stable APIs:


      -  RuntimeClass
      -  `VolumeSnapshot, VolumeSnapshotContent, and VolumeSnapshotClass <https://kubernetes.io/docs/concepts/storage/volume-snapshots/>`__

   -  `API Priority and Fairness (APF) <https://kubernetes.io/docs/concepts/cluster-administration/flow-control/>`__ is enabled by default: ``kube-apiserver --feature-gates=APIPriorityAndFairness=true``
   -  `PID limits <https://kubernetes.io/docs/concepts/policy/pid-limiting/>`__ are enabled by default: ``kube-apiserver --feature-gates=SupportNodePidsLimit=true,SupportPodPidsLimit=true``
   -  Dual-stack IPv4 and IPv6 support has been re-added to Kubernetes.

-  `1.21 <https://kubernetes.io/blog/2021/04/08/kubernetes-1-21-release-announcement/>`__

   -  PodSecurityPolicy is now deprecated.
   -  ``service.spec.topologyKeys`` is now deprecated.
   -  Dual-stack IPv4 and IPv6 support is now beta.
   -  ``pod.spec.securityContext.sysctls`` is now stable.
   -  ``configmap.immutable`` and ``secret.immutable`` are now stable.
   -  Alpha APIs:

      -  `Volume health monitoring <https://kubernetes.io/docs/concepts/storage/volume-health-monitoring/>`__ is now supported as part of the CSI integration within ``kubelet``. This feature requires a supported External Health Monitor controller.

   -  Beta APIs:

      -  Graceful shutdown of pods during a node shutdown is now enabled by default: ``kube-apiserver --feature-gates=GracefulNodeShutdown=true``

   -  Stable APIs:

      -  CronJobs
      -  EndpointSplice
      -  PodDisruptionBudgets

-  `1.22 <https://kubernetes.io/blog/2021/08/04/kubernetes-1-22-release-announcement/>`__

   -  `Server-Side Apply <https://kubernetes.io/docs/reference/using-api/server-side-apply/>`__ is now stable.
   -  Credential plugins are now stable.
   -  cgroupsv2 can now be used to restrict both CPU and memory allocations for pods (disabled by default): ``kubelet --feature-gates=MemoryQoS=false``. cgroupsv1 was only able to restrict CPU allocations for pods.
   -  Swap is now supported (disabled by default): ``kubelet --feature-gates=NodeSwap=false``
   -  Windows CSI is now stable.
   -  Default seccomp profiles can now be used.
   -  kubeadm can `deploy the control plane as a non-root user <https://kubernetes.io/docs/tasks/administer-cluster/kubelet-in-userns/>`__ (disabled by default): ``kubelet --feature-gates=KubeletInUserNamespace=false``
   -  ``kubectl debug`` now requires features only found in ``kubectl`` version 1.22 and is not backwards compatible with version 1.21.

-  `1.23 <https://kubernetes.io/blog/2021/12/07/kubernetes-1-23-release-announcement/>`__

   -  Dual-stack IPv4 and IPv6 support is now stable.
   -  Generic ephemeral volumes are now stable. Any persistent volume provider that supports this feature will automatically delete a persistent volume claim if it is marked as ephemeral.
   -  Skip volume ownership change is now stable. Kubernetes can now optionally configure a mount to not have a ``chmod`` and ``chown`` run on the mount to speed up the start time of a pod.
   -  Migration from built-in to CSI storage plugins is now beta for plugins relating to public cloud storage providers.
   -  Structured logging is now beta.
   -  Invalid YAML manifests can better feedback about validation issues when using ``kubectl create`` or ``kubectl apply``. This is disabled by default: ``kube-apiserver --feature-gates=ServerSideFieldValidation=false``.
   -  OpenAPI v3 is now availble in alpha to provide more features to the Kuberntes API endpoint.
   -  `klog <https://kubernetes.io/docs/concepts/cluster-administration/system-logs/#klog>`__ is now deprecated.
   -  FlexVolume storage driver is now deprecated.
   -  Stable APIs:

      -  HorizontalPodAutoscaler (autoscaling/v2)

-  `1.24 <https://kubernetes.io/blog/2022/05/03/kubernetes-1-24-release-announcement/>`__

   -  Dockershim has been removed. The ``docker`` binary will no longer work with Kubernetes. Install and use ``containerd`` or ``CRI-O`` instead.
   -  CNI introduces breaking changes. For ``containerd``, first upgrade to version >= 1.6.4 or >= 1.5.11. For ``CRI-O``, first upgrade to version >= 1.24.
   -  Dynamic Kubelet configuration has been removed from the kubelet (but not yet for the kube-apiserver).
   -  Any new beta APIs will be disabled by default. Previously, alpha APIs are disabled and beta APIs are enabled. Now only stable APIs will be enabled by default.
   -  Kubernetes releases are now signed.
   -  Service objects that are of type LoadBalancer now support more than one back-end using the annotation ``service.kubernetes.io/load-balancer-class: <LOAD_BALANCER_CLASS>``.
   -  OpenAPI v3 is now beta.
   -  gRPC pod probes are now beta.
   -  `kubelet credential provider <https://kubernetes.io/docs/tasks/kubelet-credential-provider/kubelet-credential-provider/>`__ is now beta (disabled by default).
   -  Service types of ClusterIP now support static IP ranges (disabled by default): ``kube-apiserver --feature-gates=ServiceIPStaticSubrange=false``
   -  Stable APIs:

      -  CSIStorageCapacity

OpenShift
~~~~~~~~~

Below is a list of RHOCP and OKD versions that correspond with the upstream Kubernetes release. The RHOCP 4.0 release was skipped and used for internal testing only. RHOCP 4 introduced Operators and OperatorHub. It also requires all Control Plane Nodes to be installed on Red Hat CoreOS. [5]

.. csv-table::
   :header: RHOCP/OKD, Kubernetes
   :widths: 20, 20

   4.10, 1.23
   4.9, 1.22
   4.8, 1.21
   4.7, 1.20
   4.6, 1.19
   4.5, 1.18
   4.4, 1.17
   4.3, 1.16
   4.2, 1.14
   4.1, 1.13
   3.11, 1.11
   3.10, 1.10
   3.9, 1.9

Every release of RHOCP is supported for about 1.5 years. When ``<RHOCP_RELEASE> + 3`` is released, the ``<RHOCP_RELEASE>`` soon becomes end-of-life. Starting with RHOCP 4.8, all even numbered minor releases are labelled as Extended Update Support (EUS). Red Hat recommends using EUS releases and supports upgrading from one EUS release to the next (skipping the odd numbered release in-between). [6]

Tanzu
~~~~~

TKGm
^^^^

Each Tanzu Kubernetes Grid Multicloud (TKGm) release supports up to three versions of Kubernetes. Listed below is the minimum TKGm version to deploy the specified Kubernetes versions. [33]

.. csv-table::
   :header: TKGm, Kubernetes
   :widths: 20, 20

   1.5.0, "1.22.5, 1.21.8, and 1.20.14"
   1.4.0, "1.21.2, 1.20.8, and 1.19.2"
   1.3.0, "1.20.4, 1.19.8, 1.18.16, and 1.17.16"
   1.2.0, "1.19.1, 1.18.8, and 1.17.11"
   1.1.0, "1.18.6 and 1.17.9"
   1.0.0, 1.17.3

TCE
^^^

Tanzu Community Edition (TCE) is the upstream variant of TKGm. Based on similar release dates, here are the equivalent versions. [88]

.. csv-table::
   :header: TCE, TKGm
   :widths: 20, 20

   0.10.0, 1.5.0
   0.8.0, 1.4.0
   0.4.0, 1.3.0

TKGS
^^^^

Each version of VMware vSphere supports a range of Kubernetes versions that can be deployed using the TanzuKubernetesCluster (TKC) API. [74]

.. csv-table::
   :header: vSphere, Kubernetes Minimum, Kubernetes Maximum
   :widths: 20, 20, 20

   7.0 Update 3, v1.21.2---vmware.1-tkg.1.ee25d55, TBD
   7.0 Update 2, v1.17.7+vmware.1-tkg.1.154236c, v1.20.12+vmware.1-tkg.1.b9a42f3
   7.0 Update 1, v1.16.12+vmware.1-tkg.1.da7afe7, v1.18.15+vmware.1-tkg.2.ebf6117

View all available Kubernetes versions of TKC in TKGS:

.. code-block:: sh

   $ tanzu kubernetes-release get

.. code-block:: sh

   $ kubectl get tanzukubernetesrelease

.. code-block:: sh

   $ kubectl get tkr

View all of the available patch versions of TKC for a specified version of Kubernetes:

.. code-block:: sh

   $ tanzu kubernetes-release get v<KUBERNETES_VERSION_MAJOR>.<KUBERNETES_VERSION_MINOR>

View valid versions of TKC that can be upgraded to from the specified version:

.. code-block:: sh

   $ tanzu kubernetes-release available-upgrades get <TANZU_KUBERNETES_RELEASE_FULL>

[62]

Installation
------------

minikube
~~~~~~~~

minikube deploys containers or a virtual machine with Kubernetes pre-installed as a test environment for developers. The Docker container driver is the default as of minikube 1.12.0. [89] AMD/Intel, Arm (including Apple Silicon), and PowerPC processor architectures are all supported.

Define the processor architecture to use.

-  Linux

   -  AMD/Intel:

      .. code-block:: sh

         $ export MINIKUBE_ARCH="linux-amd64"

   -  Arm:

      .. code-block:: sh

         $ export MINIKUBE_ARCH="linux-arm64"

-  macOS

   -  Intel:

      .. code-block:: sh

         $ export MINIKUBE_ARCH="darwin-amd64"

   -  Arm:

      .. code-block:: sh

         $ export MINIKUBE_ARCH="darwin-arm64"

Download the latest minikube release from `here <https://github.com/kubernetes/minikube/releases>`__.

.. code-block:: sh

   $ sudo curl -L https://github.com/kubernetes/minikube/releases/latest/download/minikube-${MINIKUBE_ARCH} -o /usr/local/bin/minikube
   $ sudo chmod +x /usr/local/bin/minikube

Select the virtualization driver to use. The ``minikube`` installer will automatically download it if it cannot be found. A full list of the available drivers can be found `here <https://minikube.sigs.k8s.io/docs/drivers/>`__.

-  All

   -  docker
   -  qemu2
   -  virtualbox

-  Linux

   -  kvm2
   -  podman

-  macOS

   -  hyperkit
   -  parallels
   -  vmwarefusion

-  Windows

   -  hyperv
   -  vmware

Deploy Kubernetes. Optionally specify the Kubernetes version to use. If using the ``kvm2`` driver as the root user on Linux, the ``--force`` argument is also required.

.. code-block:: sh

   $ minikube start --driver ${MINIKUBE_DRIVER} --kubernetes-version ${KUBERNETES_VERSION}

[7]

kubeadm
~~~~~~~

Supported operating systems:

-  Debian >= 9, Ubuntu >= 16.04
-  Fedora >= 25, RHEL/CentOS >= 7
-  Flatcar Container Linux
-  HypriotOS >= 1.0.1

The official ``kubeadm`` utility is used to quickly create production environments and manage their life-cycle. This tool had became stable and supported since the Kubernetes 1.13 release. [8] Pre-requisite steps include disabling swap partitions, enabling IP forwarding, and installing a container runtime interface (CRI) such as ``containerd`` or ``CRI-O``. On Fedora-based distributions, SELinux needs to be disabled as it is not supported for use with kubeadm.

.. code-block:: sh

   $ sudo swapoff --all

.. code-block:: sh

   $ echo "br_netfilter" | sudo tee /etc/modules-load.d/br_netfilter.conf
   $ sudo modprobe br_netfilter
   $ echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
   $ sudo sysctl -p

Setup the Kubernetes repository.

-  Debian:

   .. code-block:: sh

      $ sudo apt-get update && sudo apt-get install apt-transport-https ca-certificates curl
      $ sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
      $ echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
      $ sudo apt-get update

Search for a specific version of Kubernetes and install it:

-  Debian:

   .. code-block:: sh

      $ apt-cache madison kubeadm
      $ export KUBE_VERSION="1.18.20-00"
      $ sudo -E apt-get install kubeadm=${KUBE_VERSION} kubelet=${KUBE_VERSION} kubectl=${KUBE_VERSION}

Prevent those packages from being accidently upgraded:

-  Debian:

   .. code-block:: sh

      $ sudo apt-mark hold kubeadm kubelet kubectl

[59]

Initialize a Kubernetes Control Plane Node. This will bootstrap a ``kubelet`` container which will read manifest files generated in ``/etc/kubernetes/manifests/`` to create all of the other required Kubernetes daemons as containers.

Syntax for a single Control Plane Node:

.. code-block:: sh

   $ sudo kubeadm init --pod-network-cidr=10.244.0.0/16

Syntax for the first of many Control Plane Nodes (take note of the ``[upload-certs] Using certificate key`` message that will appear as it will be required later):

.. code-block:: sh

   $ sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --upload-certs --control-plane-endpoint <LOAD_BALANCED_IP>:6443

Although it is `possible to change the Control Plane endpoint <https://blog.scottlowe.org/2019/08/12/converting-kubernetes-to-ha-control-plane/>`__ for a highly available cluster, it is not recommended. Ensure it is configured to a load balanced IP address and not just a single IP address of one of the Control Plane Nodes.

Load the administrator Kubernetes configuration file as root and continue. Otherwise, copy the configuration file to the local user.

.. code-block:: sh

   $ su -
   # export KUBECONFIG=/etc/kubernetes/admin.conf

.. code-block:: sh

   $ mkdir -p $HOME/.kube
   $ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   $ sudo chown $(id -u):$(id -g) $HOME/.kube/config

Install the Canal (Flannel and Calico) Container Network Interface (CNI) plugins. Otherwise, the first Control Plane Node will be stuck in the "NotReady" state as seen by ``kubectl get nodes``.

Flannel [48]:

.. code-block:: sh

   $ kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

Calico [49]:

.. code-block:: sh

   $ kubectl apply -f https://docs.projectcalico.org/manifests/canal.yaml

Create an authentication token if the original deployment token expired.

.. code-block:: sh

   $ kubeadm token list
   $ kubeadm token create

Look-up the discovery token hash by using the certificate authority file.

.. code-block:: sh

   $ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

On the Worker Nodes, add them to the cluster by running:

.. code-block:: sh

   $ sudo kubeadm join --token <TOKEN> <MASTER_IP_ADDRESS>:6443 --discovery-token-ca-cert-hash sha256:<HASH>

Optionally allow Control Plane Nodes to also run Pods.

.. code-block:: sh

   $ kubectl taint nodes --all node-role.kubernetes.io/master-

[9]

k3s
~~~

k3s was created by Rancher Labs as a simple way to deploy small Kubernetes clusters quickly. It supports both x86 and ARM processors. It uses the ``containerd`` runtime by default, CoreDNS for hostname resolution and management, and Flannel for networking. All of the tools and resources are provided in a single ``k3s`` binary. All beta and alpha features of Kubernetes have been removed to keep the binary small.

Pre-requisites:

`cgroupsv2 were not supported until v1.20.4+ks1 <https://github.com/k3s-io/k3s/issues/1825>`__. For older releases, force the use of cgroupsv1 and then reboot the Node.

.. code-block:: sh

   $ sudo vim /etc/default/grub
   GRUB_CMDLINE_LINUX_DEFAULT="quiet cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory"
   $ sudo update-grub

k3s does not support firewalld. [92] Disable the service and switch to iptables before installing.

.. code-block:: sh

   $ sudo systemctl stop firewalld
   $ sudo systemctl disable firewalld
   $ sudo yum install iptables-services
   $ sudo systemctl start iptables
   $ sudo systemctl enable iptables

-  If k3s was accidently installed with firewalld running, it must uninstalled completely before re-installing it. [93]

   .. code-block:: sh

      $ sudo k3s-killall.sh
      $ sudo k3s-uninstall.sh

Common installation environment variables [50]:

-  INSTALL_K3S_VERSION = The version of k3s to install. Specify a `k3s tag from GitHub <https://github.com/k3s-io/k3s/tags>`__.
-  INSTALL_K3S_CHANNEL = ``stable`` (default), ``latest``, or ``testing``. The current version tied to the channel is listed `here <https://update.k3s.io/v1-release/channels>`__.
-  K3S_URL = The Control Plane endpoint URL to connect to. The URL is provided after a successful installation of the first Control Plane Node. This variable will also set the Node to become a Worker Node.
-  K3S_TOKEN = Required for the Worker Node. The token credential to connect to the Kubernetes cluster.

The installation script will download the ``k3s`` binary, setup the systemd unit file, enable the service (``k3s`` for Control Plane Nodes and ``k3s-agent`` for Worker Nodes), then start the service.

Control Plane Node:

.. code-block:: sh

   $ curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh -

Find the token:

.. code-block:: sh

   $ sudo cat /var/lib/rancher/k3s/server/node-token

Worker Nodes:

.. code-block:: sh

   $ curl -sfL https://get.k3s.io | K3S_TOKEN=<TOKEN> K3S_URL=https://<MASTER_HOST>:6443 INSTALL_K3S_CHANNEL=latest sh -

**Commands**

Access the ``kubectl`` command through ``k3s`` to manage resources on the cluster.

.. code-block:: sh

   $ sudo k3s kubectl --help

For using the ``kubectl`` command on other systems, copy the configuration from the Control Plane Node.

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

Requirements:

-  Minimum

   -  2 CPU cores
   -  4 GB RAM

-  `Recommended <https://github.com/minishift/minishift/issues/3217#issuecomment-533769748>`__

   -  4 CPU cores
   -  8 GB RAM

Minishift deploys a virtual machine with OpenShift pre-installed as a test environment for developers. This is only supported on x86_64 processors.

**Install (Fedora):**

-  Download the latest release of Minishift from `here <https://github.com/minishift/minishift/releases>`__ and the latest release of OC from `here <https://github.com/openshift/origin/releases>`__.

.. code-block:: sh

    $ MINISHIFT_VER=1.34.2
    $ wget https://github.com/minishift/minishift/releases/download/v${MINISHIFT_VER}/minishift-${MINISHIFT_VER}-linux-amd64.tgz
    $ tar -v -x -f minishift-${MINISHIFT_VER}-linux-amd64.tgz
    $ sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
    $ sudo chmod 0755 /usr/local/bin/docker-machine-driver-kvm
    $ wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
    $ tar -v -x -f openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
    $ sudo cp openshift-origin-client-tools-v3.11.0*/oc /usr/local/bin/
    $ cd ./minishift-${MINISHIFT_VER}-linux-amd64/
    $ ./minishift openshift version list
    $ ./minishift start --openshift-version v3.11.0

-  Optionally access the virtual machine.

.. code-block:: sh

   $ ./minishift ssh

[12][13]

**Install (RHEL 7):**

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

[17]

CodeReady Containers (CRC)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Requirements:

-  4 CPU cores
-  9 GB RAM
-  35 GB of storage
-  Operating system: Enterprise Linux >= 7.5 or Fedora

`Red Hat CodeReady Containers (CRC) <https://github.com/code-ready/crc>`__ deploys a minimal RHOCP 4 environment into a virtual machine without machine-config and monitoring services. It requires a free developer account from Red Hat to download the ``crc`` binary and copy the pull secret from `here <https://cloud.redhat.com/openshift/install/crc/installer-provisioned>`__.

.. code-block:: sh

    $ tar -x -v -f ~/Downloads/crc-linux-amd64.tar.xz
    $ mv ~/Downloads/crc-linux-*-amd64/crc ~/.local/bin/

Delete any existing CRC virtual machines if they exist, prepare the hypervisor, and then start a new OpenShift virtual machine. All installation files are stored in ``~/.crc``.

.. code-block:: sh

   $ crc delete
   $ crc setup
   $ crc start
   ? Image pull secret <PASTE_PULL_SECRET_HERE>

Find the path to the ``oc`` binary to use.

.. code-block:: sh

   $ crc oc-env

Optionally log into the virtual machine.

.. code-block:: sh

   $ crc console

Stop the virtual machine at any time.

.. code-block:: sh

   $ crc stop

[28]

kind
~~~~

kind is a tool written in Go that is used by upstream Kubernetes developers. It simulates different Kubernetes nodes via the use of containers on a single local workstation. As of kind v0.8.0, a single node deployment of Kubernetes will have persistent storage and survive if the container restart. Multi-node Kubernetes clusters will break if the containers are restarted. [91]

Installation:

-  All operating systems:

   .. code-block:: sh

      $ GO111MODULE="on" go get sigs.k8s.io/kind@v0.9.0

-  macOS specific:

   .. code-block:: sh

      $ brew install kind

Usage:

-  Create a cluster:

   .. code-block:: sh

      $ kind create cluster

-  Or create a cluster using a specific tag from `here <https://hub.docker.com/r/kindest/node/tags?page=1&ordering=last_updated>`__:

   .. code-block:: sh

      $ kind create cluster --image kindest/node:<TAG>

-  Or create a cluster using a Kubernetes manifest file for the Cluster API:

   .. code-block:: sh

      $ kind create cluster --config=<CLUSTER_MANIFEST>.yaml

   .. code-block:: sh

      $ cat <<EOF | kind create cluster --config=-
      kind: Cluster
      apiVersion: kind.x-k8s.io/v1alpha4
      nodes:
      - role: control-plane
      EOF

   -  Create a cluster with an Ingress Controller that is port-forwarded to the host (required for Docker on macOS and Windows, not Linux) [79]:

      .. code-block:: sh

         $ cat <<EOF | kind create cluster --config=-
         kind: Cluster
         apiVersion: kind.x-k8s.io/v1alpha4
         nodes:
         - role: control-plane
           kubeadmConfigPatches:
           - |
             kind: InitConfiguration
             nodeRegistration:
               kubeletExtraArgs:
                 node-labels: "ingress=true"
           extraPortMappings:
           - containerPort: 80
             hostPort: 80
             protocol: TCP
           - containerPort: 443
             hostPort: 443
             protocol: TCP
         - role: control-plane
         - role: control-plane
         - role: worker
         - role: worker
         - role: worker
         - role: worker
         - role: worker
         EOF
         $ kubectl apply --filename https://projectcontour.io/quickstart/contour.yaml
         $ kubectl patch daemonsets --namespace projectcontour envoy --patch '{"spec":{"template":{"spec":{"nodeSelector":{"ingress":"true"},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'

-  Configure kubectl to use the cluster by default:

   .. code-block:: sh

      $ kubectl config set-context kind-kind

[45]

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

Uninstall OpenShift services from Nodes by specifying them in the inventory and using the uninstall playbook.

.. code-block:: sh

   $ sudo ansible-playbook -i <INVENTORY_FILE> playbooks/adhoc/uninstall.yml

Tanzu
~~~~~

TKGm
^^^^

Before installing a Kubernetes cloud with Tanzu, the ``tkg`` utility has to be set up.

-  Install both ``docker`` and ``kubectl``.
-  Download the Tanzu-related binaries from `here <https://www.vmware.com/go/get-tkg>`__. A VMWare account is required to login and download it.
-  Extract the binaries:  ``tar -v -x -f tkg-linux-amd64-v${TKG_VERSION}-vmware.1.tar.gz``
-  Move them into an executable location in ``$PATH``: ``chmod +x ./tkg/* && mv ./tkg/* ~/.local/bin/``
-  Symlink the ``tkg`` binary: ``ln -s ~/.local/bin/tkg-linux-amd64-v${TKG_VERSION}+vmware.1 ~/.local/bin/tkg``
-  Verify that ``tkg`` works: ``tkg-linux-amd64-<VERSION>+vmware.1 version``.
-  Create the configuration files in ``~/.tkg/`` by running: ``tkg get management-cluster``

[34]

AWS
'''

Setup a TKG Management Cluster and then the production Kubernetes cluster using infrastructure provided by Amazon Web Services (AWS).

-  Install ``jq``.
-  Install the dependencies for the ``aws`` command: ``glibc``, ``groff``, and ``less``.
-  Install the ``aws`` utility and verify it works. Find the latest version from `here <https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst>`__. [35]

   .. code-block:: sh

      $ export AWS_CLI_VERSION="2.0.59"
      $ curl -O "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip"
      $ unzip awscli-*.zip
      $ sudo ./aws/install
      $ aws --version

-  Generate a SSH key pair: ``aws ec2 create-key-pair --key-name default --output json | jq .KeyMaterial -r > default.pem``
-  Kubernetes installation:

    -  Creat the AWS CloudFormation stack and then initialize/create the TKG Management Cluster. [36]

       .. code-block:: sh

          # CLI setup.
          $ export AWS_REGION=<REGION>
          $ export AWS_SSH_KEY_NAME="default"
          $ tkg config permissions aws
          $ tkg init --infrastructure aws --plan [dev|prod]

       .. code-block:: sh

          # Alternatively, use the web dashboard setup.
          $ tkg init --ui

   -  Optionally create a configuration file for the production Kubernetes cluster. By default, the "dev" plan will create one Control Plane Node and the "prod" plan will create three. Both will create one Worker Node.

      .. code-block:: sh

         $ tkg config cluster <KUBERNETES_CLUSTER_NAME> --plan [dev|prod] --controlplane-machine-count <CONTROLPLANE_COUNT> --worker-machine-count <WORKER_COUNT> --namespace <NAMESPACE> > ~/.tkg/cluster_config.yaml

   -  Deploy the production Kubernetes cluster and give it a unique and descriptive name. [37]

      .. code-block:: sh

         $ tkg create cluster <KUBERNETES_CLUSTER_NAME> --plan [dev|prod] --kubernetes-version=v1.19.1

   -  Verify that the production Kubernetes cluster can now be accessed. [38]

      .. code-block:: sh

         $ tkg get cluster
         $ tkg get credentials <KUBERNETES_CLUSTER_NAME>
         Credentials of workload cluster '<KUBERNETES_CLUSTER_NAME>' have been saved
         You can now access the cluster by running 'kubectl config use-context <KUBERNETES_CLUSTER_NAME>-admin@<KUBERNETES_CLUSTER_NAME>'
         $ kubectl config use-context <KUBERNETES_CLUSTER_NAME>-admin@<KUBERNETES_CLUSTER_NAME>
         $ kubectl get nodes -o wide
         $ kubectl get -n kube-system pods

TCE
^^^

Install the ``tanzu`` CLI utility. [82]

-  Linux:

   .. code-block:: sh

      $ export TCE_VER="v0.11.0"
      $ wget https://github.com/vmware-tanzu/community-edition/releases/download/${TCE_VER}/tce-linux-amd64-${TCE_VER}.tar.gz
      $ tar -x -v -f tce-linux-amd64-${TCE_VER}.tar.gz
      $ cd tce-linux-amd64-${TCE_VER}
      $ ./install.sh

-  macOS:

   .. code-block:: sh

      $ brew install vmware-tanzu/tanzu/tanzu-community-edition
      $ /usr/local/Cellar/tanzu-community-edition/*/libexec/configure-tce.sh

For lab deployments, create a single standalone cluster. [87]

.. code-block:: sh

   $ tanzu unmanaged-cluster create <STANDALONE_CLUSTER_NAME>

For production deployments, a single management Kubernetes cluster is created and then one or more Kubernetes workload clusters are created from that.

   -  Create a management cluster using the Docker Engine. [83]

      .. code-block:: sh

         $ tanzu management-cluster create -i docker --name <MANAGEMENT_CLUSTER_NAME> -v 10 --plan dev --ceip-participation=false

   -  Create one or more workload clusters using the management cluster. [83]

      .. code-block:: sh

         $ kubectl config get-contexts
         $ kubectl config use-context <MANAGEMENT_CLUSTER-NAME>-admin@<MANAGEMENT_CLUSTER-NAME>
         $ tanzu cluster create <WORKLOAD_CLUSTER_NAME> --plan dev
         $ tanzu cluster kubeconfig get <WORKLOAD_CLUSTER_NAME> --admin
         $ kubectl config use-context <WORKLOAD_CLUSTER-NAME>-admin@<WORKLOAD_CLUSTER-NAME>

Tanzu Packages
''''''''''''''

Setup the Tanzu Packages repository globally:

.. code-block:: sh

   $ tanzu package repository add tce-repo --url projects.registry.vmware.com/tce/main:0.11.0 --namespace tanzu-package-repo-global

View the available packages to install:

.. code-block:: sh

   $ tanzu package available list

Install a package:

.. code-block:: sh

   $ tanzu package install <PACKAGE_NAME_SHORT> --package-name <PACKAGE_NAME_FULL> --version <PACKAGE_VERSION>

[85]

TKGS
^^^^

Applications
''''''''''''

Harbor
&&&&&&

**IMPORTANT:** The version of Harbor provided by TKGS in VMware vSphere <= 7.0U2 is an older version and lacks many of the features found in the upstream release. It only provides basic push and pull capabilities. It is recommended to install the Helm chart instead.

Enable Harbor in TKGS [67]:

-  vSphere Client > Workload Management > Clusters > (select the workload cluster) > Configure > Namespaces > Image Registry > Embedded Harbor: ENABLE

Each Kubernetes Namespace will now have two secrets created: a pull and push Secret. These are named ``<VSPHERE_NAMESPACE>-default-image-[pull|push]-secret``. In the specification of a Pod, use the pull Secret in ``pod.spec.imagePullSecrets.name``. When interacting with the container registry manually via ``docker login``, use a vSphere user that has "edit" permissions with the cluster. [68]

Uninstall
---------

minikube
~~~~~~~~

Stop all running instances, delete them, and then delete the minikube cache and configuration directory. [7]

.. code-block:: sh

   $ minikube stop --all
   $ minikube delete --all
   $ rm -r -f ~/.minikube/

CodeReady Containers (CRC)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Stop CRC, delete the virtual machine, and cleanup system-wide configuration changes the installer made. Then delete all of the CRC files or at least remove the ``~/.crc/cache/`` directory to free up storage space.

.. code-block:: sh

   $ crc stop
   $ crc delete
   $ crc cleanup
   $ rm -rf ~/.crc/

kubeadm
~~~~~~~

Any Node provisioned with ``kubeadm init`` or ``kubeadm join`` can uninstall Kubernetes.

.. code-block:: sh

   $ sudo kubeadm reset
   $ sudo rm -f /etc/cni/net.d/*
   $ sudo ipvsadm --clear

Reset the ``iptables`` rules [51]:

.. code-block:: sh

   $ sudo iptables -F
   $ sudo iptables -t nat -F
   $ sudo iptables -t mangle -F
   $ sudo iptables -X

k3s
~~~

Control Plane Nodes:

.. code-block:: sh

   $ sudo /usr/local/bin/k3s-killall.sh
   $ sudo /usr/local/bin/k3s-uninstall.sh

Worker Nodes:

.. code-block:: sh

   $ sudo /usr/local/bin/k3s-killall.sh
   $ sudo /usr/local/bin/k3s-agent-uninstall.sh

kind
~~~~

Remove all kind containers by running this command [45]

.. code-block:: sh

   $ kind delete cluster

Tanzu
~~~~~

TKGm
^^^^

-  First, uninstall the production Kubernetes cluster(s). [39]

   .. code-block:: sh

      $ tkg delete cluster <TKG_CLUSTER>

-  Finally, delete the Management Cluster. [40]

   .. code-block:: sh

      $ tkg delete management-cluster <TKG_MANAGEMENT_CLUSTER>

   -  This error may occur. Workaround the issue by setting the environment variable ``AWS_B64ENCODED_CREDENTIALS`` to any value. [41]

      ::

         Logs of the command execution can also be found at: /tmp/tkg-20201031T164426485425119.log
         Verifying management cluster...
         
         Error: : unable to delete management cluster: unable to get management cluster provider information: error verifying config variables: value for variables [AWS_B64ENCODED_CREDENTIALS] is not set. Please set the value using os environment variables or the tkg config file
         
         Detailed log about the failure can be found at: /tmp/tkg-20201031T164426485425119.log

      .. code-block:: sh

         $ export AWS_B64ENCODED_CREDENTIALS=foobar
         $ tkg delete management-cluster <TKG_MANAGEMENT_CLUSTER>

TCE
^^^

-  Servers

   -  Delete all standalone clusters. [87]

      .. code-block:: sh

         $ tanzu unmanaged-cluster delete <STANDALONE_CLUSTER_NAME>

   -  Delete all workload clusters.

      .. code-block:: sh

         $ tanzu cluster delete <WORKLOAD_CLUSTER_NAME>

   -  Delete the management cluster. [84]

      .. code-block:: sh

         $ tanzu management-cluster delete <MANAGEMENT_CLUSTER_NAME>

      -  If there are any problems deleting a managment cluster, try forcing a delete.

         .. code-block:: sh

            $ tanzu management-cluster delete <MANAGEMENT_CLUSTER_NAME>

         -  If there are still problems, then manually delete the containers (Docker Engine) or virtual machines (vSphere, AWS, or Azure).

            -  Docker Engine:

               .. code-block:: sh

                  $ sudo docker ps -a | egrep "haproxy|vmware" | awk '{print $1}' | xargs docker stop
                  $ sudo docker ps -a | egrep "haproxy|vmware" | awk '{print $1}' | xargs docker rm

        -  Then delete the configuration.

           .. code-block:: sh

              $ tanzu config server delete <MANAGEMENT_CLUSTER_NAME>

-  Client

   -  Linux

      .. code-block:: sh

         $ ~/.local/share/tce/uninstall.sh

   -  macOS

      .. code-block:: sh

         $ ~/Library/Application\ Support/tce/uninstall.sh

[86]

Upgrade
-------

Introduction
~~~~~~~~~~~~

Upgrades can be done from one minor or patch release to another. Minor version upgrades cannot skip a version. For example, upgrading from 1.17.0 to 1.18.4 can be done but from 1.17.0 to 1.19.0 will not work. [30]

Compatibility guarantees differ between services [31]:

-  kube-apiserver = No other component in the cluster can have a minor version higher than this.
-  kubelet and kube-proxy = Supports two versions behind the kube-apiserver.
-  cloud-controller-manager, kube-controller-manager, and kube-scheduler = Supports one version behind kube-apiserver.
-  kubectl (client) = Supports one version older than, later than, or equal to the kube-apiserver.

Common upgrade scenarios (for a Kubernetes and/or operating system upgrade), in order of recommendation:

1.  Upgrade one Node at a time. Workloads will be migrated off the Node.

    -  Use ``kubectl drain`` to remove all workloads from the Node.
    -  Once the upgrade is complete, use ``kubectl uncordon`` to allow workloads to be scheduled on the Node again.

2.  Upgrade one Node at a time to new hardware. Workloads will be migrated off the Node.

    -  Use ``kubectl drain`` to remove all workloads from the old Node.
    -  Use ``kubectl delete node`` to delete the old Node.

3.  Upgrade all Nodes at the same time. This will cause downtime.

minikube
~~~~~~~~

minikube can be upgraded by starting with a specified Kubernetes version (or use "latest"). [29]

.. code-block:: sh

   $ minikube stop
   $ minikube start --kubernetes-version ${KUBERNETES_VERSION}

kubeadm
~~~~~~~

Control Plane Nodes
^^^^^^^^^^^^^^^^^^^

Check for a newer version of ``kubeadm``.

.. code-block:: sh

   $ apt update
   $ apt-cache madison kubeadm

Update ``kubeadm`` to the desired Kubernetes version to upgrade to.

.. code-block:: sh

   $ sudo apt-get install -y --allow-change-held-packages kubeadm=<KUBERNETES_PACKAGE_VERSION>

View the modifications that a ``kubeadm upgrade`` would make.

.. code-block:: sh

   $ sudo kubeadm upgrade plan

Upgrade to the specified ``X.Y.Z`` version on the first Control Plane Node

.. code-block:: sh

   $ sudo kubeadm upgrade apply vX.Y.Z

Log into the other Control Plane Nodes and upgrade those.

.. code-block:: sh

   $ sudo kubeadm upgrade node vX.Y.Z

Upgrade the ``kubelet`` service on all of the Control Plane Nodes.

.. code-block:: sh

   $ apt-get install -y --allow-change-held-packages kubelet=<KUBERNETES_PACKAGE_VERSION> kubectl=<KUBERNETES_PACKAGE_VERSION>
   $ sudo systemctl daemon-reload
   $ sudo systemctl restart kubelet

[30]

Worker Nodes
^^^^^^^^^^^^

Update ``kubeadm``.

Drain all objects from one of the Worker Nodes.

.. code-block:: sh

    $ kubectl drain --ignore-daemonsets <NODE>

Upgrade the Worker Node.

.. code-block:: sh

   $ sudo kubeadm upgrade node

Upgrade the ``kubelet`` service.

Allow objects to be scheduled onto the Node again.

.. code-block:: sh

   $ kubectl uncordon <NODE>

Verify that all Nodes have the "READY" status.

.. code-block:: sh

   $ kubectl get nodes

[30]

k3s
~~~

Either update the local git repository and checkout the desired version tag to upgrade to or curl the latest installer script and specify the version using an environment variable.

Control Plane Nodes:

.. code-block:: sh

   $ curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=<GITHUB_VERSION_TAG> sh -a

Work Nodes:

.. code-block:: sh

   $ curl -sfL https://get.k3s.io | K3S_TOKEN=<TOKEN> K3S_URL=https://<MASTER_HOST>:6443 INSTALL_K3S_VERSION=<GITHUB_VERSION_TAG> sh -a

Verify that the upgrade worked.

.. code-block:: sh

   $ k3s --version

[10]

kind
~~~~

kind does not officially support upgrades. It was designed for developers to spin up new Kubernetes clusters temporarily for testing. However, it is technically possible to use ``kubeadm`` to upgrade each Node. [46]

Ingress Controllers
-------------------

Introduction
~~~~~~~~~~~~

The ``Ingress`` API requires at least one Ingress Controller to be installed. That controller creates a ``Service`` of type ``LoadBalancer`` using an external IP address that is available on all of the Nodes. Domain names should have their DNS resolve to that IP address.

The Ingress Controller will handle all incoming HTTP connections on port 80. It also supports handling TLS termination for incoming HTTPS connections on port 443. Custom layer 7 routing rules for the HTTP/S traffic can be defined via the API.

Other ports and protocols are not supported. Use a ``Service`` of type ``LoadBalancer`` or ``NodePort`` instead for applications that do not use HTTP or require a custom port. [58]

These are the most popular Ingress controllers [57] in order of the number of GitHub stars they have:

1.  `Traefik <https://github.com/traefik/traefik>`__
2.  `Istio <https://github.com/istio/istio>`__
3.  `NGINX (Kubernetes) <https://github.com/kubernetes/ingress-nginx>`__
4.  `Emissary <https://github.com/emissary-ingress/emissary>`__ (formerly known as `Ambassador <https://www.cncf.io/blog/2021/04/13/emissary-ingress-formerly-ambassador-is-now-a-cncf-incubating-project/>`__)
5.  `NGINX (NGINX, Inc.) <https://github.com/nginxinc/kubernetes-ingress>`__
6.  `Contour <https://github.com/projectcontour/contour>`__
7.  `Kong <https://github.com/Kong/kubernetes-ingress-controller>`__
8.  `Voyager <https://github.com/voyagermesh/voyager>`__
9.  `HAProxy <https://github.com/haproxytech/kubernetes-ingress>`__

A full list of Ingress Controllers can be found `here <https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/>`__.

Recommended Ingress Controller for each use case:

-  Proof-of-concept = NGINX (Kubernetes). A basic Ingress Controller that is maintained by the Kubernetes project.
-  Home lab = Traefik. This is the most popular Ingress Controller and is known to work out-of-the-box.
-  Work lab = Contour. It uses Enovy in the back-end to provide advanced routing capabilities, similar to what Istio does, but is more lightweight on resources and easier to manage.
-  Security = Istio. This is the most secure but it uses the most amount of resources (every pod has a side car container to manager network traffic) and upgrades are difficult.

Contour
~~~~~~~

The official Contour project does not have a Helm chart to help install their Ingress Controller. Instead, the Bitnami project has a collection of installers including a Helm Chart for Contour. [70]

View the `Helm chart values here <https://github.com/bitnami/charts/blob/master/bitnami/contour>`__.

Installation [63]:

.. code-block:: sh

   $ helm repo add bitnami https://charts.bitnami.com/bitnami
   $ helm repo update
   $ helm install contour bitnami/contour

NGINX
~~~~~

There are two different Ingress Controllers that use the NGINX reverse-proxy server: (1) ``kubernetes/ingress-nginx`` and (2) ``nginxinc/kubernetes-ingress``. The first one is the official Ingress Controller supported by the Kubernetes project. The second one is provided by NGINX, Inc. that adds more advanced features. [64]

kubernetes/ingress-nginx
^^^^^^^^^^^^^^^^^^^^^^^^

Installation [65]:

.. code-block:: sh

   $ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   $ helm repo update
   $ helm install ingress-nginx-kubernetes ingress-nginx/ingress-nginx

nginxinc/kubernetes-ingress
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installation [66]:

.. code-block:: sh

   $ helm repo add nginx-stable https://helm.nginx.com/stable
   $ helm repo update
   $ helm install ingress-nginx-nginxinc nginx-stable/nginx-ingress

Traefik
~~~~~~~

Traefik provides features such as advancing routing, SSL/TLS certificate management, and LetsEncrypt support for automatically creating and signing new certificates. [43]

Installation [44]:

.. code-block:: sh

   $ helm repo add traefik https://helm.traefik.io/traefik
   $ helm repo update
   $ helm install traefik traefik/traefik
   $ helm history traefik

Concepts
--------

Container Network Interface (CNI) Plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``kubelet`` service on each ``Node`` interacts with a CNI plugin to manage the network connections between Pods. The cloud operator must pick at least one plugin. For using more than one plugin, use the `Multus CNI project <https://github.com/intel/multus-cni>`__. Canal (both Calico and Flannel combined into a single plugin) is recommended for most use cases.

.. csv-table::
   :header: Plugin, Arm Support, Ease of Configuration, Resource Usage, Network Layer, Encryption, NetworkPolicy Support, Windows Support, Use Case
   :widths: 20, 20, 20, 20, 20, 20, 20, 20, 20

   Antrea, Yes, Easy, Low, 3 and 4, Yes, Yes, Yes, Windows and VMware TKG
   Calico, Yes, Medium, Low, 3, No, Yes, No, Highly configurable
   Canal, Yes, Medium, Low, 3, No, Yes, No, Combine the easiness of Flannel and the NetworkPolicy support of Calico
   Cilium, No, Easy, High, 3, No, Yes, No, BPF Linux kernel integration
   Flannel, Yes, Easy, Low, 2, No, No, No, Simple overlay network management
   kubenet, Yes, Easy,  Low, 2, No, No, No, Very basic Linux bridge management
   kube-router, Yes, Medium, Low, 3, No, Yes, No, Feature rich
   Weave Net, Yes, Hard, Medium, 3, No, Yes, No, Manage mesh networks
   Weave Net (Encrypted), Yes, Hard, High, 3, Yes, Yes, No, Secure networks

Recommended CNI plugin for each use case:

-  Proof-of-concept = kubenet. It is built into Kubernetes and does not require any additional setup.
-  Home lab = Flannel. Easy to setup and provides container network separation.
-  Work lab = Canal. It expands upond Flannel by adding support for other features such as the  NetworkPolicy API.
-  Security = Weave Net. Designed to be scalable and secure.
-  Windows Node = Antrea. The only vendor-agnostic CNI plugin that works on Windows Nodes.

Legacy plugins that are no longer maintained:

-  Romana

[19][20]

CoreDNS
~~~~~~~

CoreDNS is the standard internal DNS server used by Kubernetes. All of the Pods in the Kubernetes cluster use it to resolve the internal domain ("cluster.local" by default) and then forward all other DNS requests to the DNS resolvers configured in ``/etc/resolv.conf`` file on the actual Node.

It is configured through a ConfigMap and Deployment in the "kube-system" namespace. Here is an example of what it should look like on a default installation of Kubernetes.

.. code-block:: sh

   $ kubectl --namespace kube-system get configmap coredns --output yaml

.. code-block:: yaml

   ---
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: coredns
     namespace: kube-system
   data:
     Corefile: |
       .:53 {
           errors
           health {
              lameduck 5s
           }
           ready
           kubernetes cluster.local in-addr.arpa ip6.arpa {
              pods insecure
              fallthrough in-addr.arpa ip6.arpa
              ttl 30
           }
           prometheus :9153
           forward . /etc/resolv.conf
           cache 30
           loop
           reload
           loadbalance
       }

.. code-block:: sh

   $ kubectl --namespace kube-system get deployment coredns --output yaml

.. code-block:: yaml

   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     annotations:
       deployment.kubernetes.io/revision: "1"
     labels:
       k8s-app: kube-dns
     name: coredns
     namespace: kube-system
   spec:
     progressDeadlineSeconds: 600
     replicas: 2
     revisionHistoryLimit: 10
     selector:
       matchLabels:
         k8s-app: kube-dns
     strategy:
       rollingUpdate:
         maxSurge: 25%
         maxUnavailable: 1
       type: RollingUpdate
     template:
       metadata:
         labels:
           k8s-app: kube-dns
       spec:
         containers:
         - args:
           - -conf
           - /etc/coredns/Corefile
           image: k8s.gcr.io/coredns:1.6.7
           imagePullPolicy: IfNotPresent
           livenessProbe:
             failureThreshold: 5
             httpGet:
               path: /health
               port: 8080
               scheme: HTTP
             initialDelaySeconds: 60
             periodSeconds: 10
             successThreshold: 1
             timeoutSeconds: 5
           name: coredns
           ports:
           - containerPort: 53
             name: dns
             protocol: UDP
           - containerPort: 53
             name: dns-tcp
             protocol: TCP
           - containerPort: 9153
             name: metrics
             protocol: TCP
           readinessProbe:
             failureThreshold: 3
             httpGet:
               path: /ready
               port: 8181
               scheme: HTTP
             periodSeconds: 10
             successThreshold: 1
             timeoutSeconds: 1
           resources:
             limits:
               memory: 170Mi
             requests:
               cpu: 100m
               memory: 70Mi
           securityContext:
             allowPrivilegeEscalation: false
             capabilities:
               add:
               - NET_BIND_SERVICE
               drop:
               - all
             readOnlyRootFilesystem: true
           terminationMessagePath: /dev/termination-log
           terminationMessagePolicy: File
           volumeMounts:
           - mountPath: /etc/coredns
             name: config-volume
             readOnly: true
         dnsPolicy: Default
         nodeSelector:
           kubernetes.io/os: linux
         priorityClassName: system-cluster-critical
         restartPolicy: Always
         schedulerName: default-scheduler
         securityContext: {}
         serviceAccount: coredns
         serviceAccountName: coredns
         terminationGracePeriodSeconds: 30
         tolerations:
         - key: CriticalAddonsOnly
           operator: Exists
         - effect: NoSchedule
           key: node-role.kubernetes.io/master
         volumes:
         - configMap:
             defaultMode: 420
             items:
             - key: Corefile
               path: Corefile
             name: coredns
           name: config-volume

It is possible to modify CoreDNS to serve its own DNS records for testing purposes.

-  Append a new configuration for a custom domain name. Then add a new data field for that custom domain.

   .. code-block:: yaml

      ---
      apiVersion: v1
      kind: ConfigMap
      metadata:
        name: coredns
        namespace: kube-system
      data:
        Corefile: |
          .:53 {
              errors
              health {
                 lameduck 5s
              }
              ready
              kubernetes cluster.local in-addr.arpa ip6.arpa {
                 pods insecure
                 fallthrough in-addr.arpa ip6.arpa
                 ttl 30
              }
              prometheus :9153
              forward . /etc/resolv.conf
              cache 30
              loop
              reload
              loadbalance
          }
          # Add this extra configuration for CoreDNS.
          <DOMAIN>.<TOP_LEVEL_DOMAIN> {
              file <DOMAIN>.<TOP_LEVEL_DOMAIN>
          }
        # Add this new data field and value that will be used as another configuration file.
        <DOMAIN>.<TOP_LEVEL_DOMAIN>: |
          $ORIGIN lab.com.
          @    IN    SOA    coredns.example.com.    <EMAIL_USER>.<EMAIL_DOMAIN>. (
              2021022823
              7200
              3600
              1209600
              3600
          )
          <SUBDOMAIN>    IN    A    <IP_ADDRESS_FOR_SUBDOMAIN>
          *    IN    A    <IP_ADDRESS_FOR_WILDCARD>

-  Update the Deployment to load the new data field from the ConfigMap as a file.

   .. code-block:: sh

      $ kubectl --namespace kube-system edit deployment coredns

   .. code-block:: sh

      volumes:
      - configMap:
          defaultMode: 420
          items:
          - key: Corefile
            path: Corefile
          # Add a new item with these two lines.
          - key: <DOMAIN>.<TOP_LEVEL_DOMAIN>
            path: <DOMAIN>.<TOP_LEVEL_DOMAIN>
          name: coredns
        name: config-volume

Service LoadBalancers
~~~~~~~~~~~~~~~~~~~~~

A Service with the type of LoadBalancer provides an external IP address that can be used to access an application from outside of the Kubernetes cluster. Most public cloud providers have built-in support for their own load balancing services to integrate with Kubernetes.

An installation of Kubernetes on bare-metal requires a special third-party Service LoadBalancer to be installed and configured to be able to access applications without using an internal Service of the type ClusterIP or a Service of the type NodePort on an undesired port number.

Bare-metal:

1.  `MetalLB <https://metallb.universe.tf/>`__ = The most popular and widely used bare-metal Service LoadBalancer.
2.  `kube-vip <https://github.com/kube-vip/kube-vip>`__ = A basic Kubernetes load balancer.
3.  `Seesaw <https://opensource.google/projects/seesaw>`__ = No binaries are packaged so it must be compiled from source code.
4.  `Klipper Service Load Balancer <https://rancher.com/docs/k3s/latest/en/networking/>`__ = Designed for Rancher's k3s.

MetalLB
^^^^^^^

**Installation**

-  Manual:

   -  Find the desired version from the `GitHub metallb/metallb releases page <https://github.com/metallb/metallb/releases>`__.
   -  Install MetalLB into the metallb-system namespace. [76]

      .. code-block:: sh

         $ export METALLB_VERSION=v0.10.3
         $ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/manifests/namespace.yaml
         $ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/manifests/metallb.yaml

   -  Configure the external IP range to use for Service LoadBalancers. [77] As soon as this ConfigMap object is created, Service objects of type LoadBalancer will get an external IP address. If not, there is an issue with the installation or configuration.

      .. code-block:: sh

         $ cat <<EOF | kubectl apply -f -
         ---
         apiVersion: v1
         kind: ConfigMap
         metadata:
           name: config
           namespace: metallb-system
         data:
           config: |
             address-pools:
               - name: default
                 protocol: layer2
                 addresses:
                   - <IP_ADDRESS_FIRST>-<IP_ADDRESS_LAST>
         EOF

-  Automatic (Helm) [78]:

   .. code-block:: sh

      $ helm repo add bitnami https://charts.bitnami.com/bitnami
      $ helm repo update
      $ helm install --create-namespace --namespace metallb-system --set 'configInline.address-pools[0].name'=default --set 'configInline.address-pools[0].protocol'=layer2 --set 'configInline.address-pools[0].addresses[0]'="<IP_ADDRESS_FIRST>-<IP_ADDRESS_LAST>" metallb bitnami/metallb

cert-manager
~~~~~~~~~~~~

cert-manager provides integration with various SSL/TLS certificate providers such as Let's Encrypt. Through annotations, it can automatically generate certificates for Ingress objects.

Installation using the Helm chart [98]:

.. code-block:: sh

   $ helm repo add jetstack https://charts.jetstack.io
   $ helm repo update
   $ helm install \
     cert-manager jetstack/cert-manager \
     --namespace cert-manager \
     --create-namespace \
     --set installCRDs=true

Container Registries
~~~~~~~~~~~~~~~~~~~~

Harbor
^^^^^^

harbor/harbor
'''''''''''''

The ``harbor`` Helm chart from ``https://helm.goharbor.io`` is the official chart for installing Harbor.

Harbor will use the default StorageClass for the PersistentVolumeClaim. Set these Helm chart variables to a different StorageClass or use "-" to disable persistent storage:

-  ``persistence.persistentVolumeClaim.[chartmuseum|database|jobservice|redis|registry|trivy].storageClass``

The default storage sizes for Harbor are small by default. The container registry itself will only have 5 GiB of available space. These can be adjusted by setting different ``<SIZE>Gi`` values in these Helm chart variables.

- ``persistence.persistentVolumeClaim.[chartmuseum|database|jobservice|redis|registry|trivy].size``

Optionally configure a universal image pull Secret to use.

- ``'imagePullSecrets[0].name'``

View the `Helm chart values here <https://github.com/goharbor/harbor-helm>`__.

Install:

.. code-block:: sh

   $ helm repo add harbor https://helm.goharbor.io
   $ helm update
   $ helm install harbor harbor/harbor

Log in with the default account [71]:

-  Username: admin
-  Password: Harbor12345

Uninstall:

.. code-block:: sh

   $ helm uninstall harbor
   $ kubectl delete pvc -l chart=harbor

[69]

bitnami/harbor
''''''''''''''

The ``harbor`` Helm chart from ``https://charts.bitnami.com/bitnami`` is an unofficial chart based on the upstream Helm chart. It is developed by VMware and provides additional features such as consolidated variables, secure/random admin password, automatic external Service LoadBalancer, and more.

Unlike the ``harbor/harbor`` chart, this chart supports setting a global StorageClass for all PersistentVolumeClaims:

- ``global.storageClass``

Optionally configure a universal image pull Secret to use.

- ``'global.imagePullSecrets[0]'``

View the `Helm chart values here <https://github.com/bitnami/charts/tree/master/bitnami/harbor>`__.

Install:

.. code-block:: sh

   $ helm repo add bitnami https://charts.bitnami.com/bitnami
   $ helm repo update
   $ helm install harbor-bitnami bitnami/harbor

Locate the ``admin`` acocunt password:

.. code-block:: sh

   $ echo Password: $(kubectl get secret bitnami-harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 --decode)
   Password: bzOLNxqrhq

Uninstall:

.. code-block:: sh

   $ helm uninstall harbor-bitnami
   $ kubectl delete pvc bitnami-harbor-chartmuseum bitnami-harbor-jobservice bitnami-harbor-registry data-bitnami-harbor-postgresql-0 data-bitnami-harbor-trivy-0 redis-data-bitnami-harbor-redis-master-0

[72]

Serverless
~~~~~~~~~~

Serverless is a concept of being able to scale an application down to zero. This helps to save resources and money.

Knative
^^^^^^^

Knative is the most popular implementation of serverless. The project originally had three components but now it only has two:

1. `Knative Serving <https://knative.dev/docs/serving/>`__ = The serverless component of Knative. It provides scaling and routing capabilities.
2. `Knative Eventing <https://knative.dev/docs/eventing/>`__ = A messaging queue that sends events from a specified event provider to an event sink (such as an application). An event source handles taking a message from the provider and sending it to the sink. A full list of supported event sources can be found `here <https://knative.dev/docs/eventing/sources/index.html>`__.
3. `Knative Build <https://github.com/knative/build>`__ = This project is no longer maintained as part of Knative. It has been forked into the Tekton Pipelines project. [80]

Install:

-  Find a desired version of Knative Serving from the `releases <https://github.com/knative/serving/releases>`__ page.

   .. code-block:: sh

      $ export KNATIVE_VERSION=v1.1.0

-  Install Knative Serving:

   .. code-block:: sh

      $ kubectl apply -f https://github.com/knative/serving/releases/download/knative-${KNATIVE_VERSION}/serving-crds.yaml
      $ kubectl apply -f https://github.com/knative/serving/releases/download/knative-${KNATIVE_VERSION}/serving-core.yaml
      $ kubectl get pods --namespace knative-serving

-  Install a CNI plugin that is specifically configured for use by Knative by following the instructions from `here <https://knative.dev/docs/install/serving/install-serving-with-yaml/#install-a-networking-layer>`__. Ambassador, Contour, Istio, and Kourier are all supported. Installing a CNI plugin from a Knative release will ensure that it does not conflict with other CNI plugins.

   -  Contour:

      .. code-block:: sh

         $ kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-${KNATIVE_VERSION}/contour.yaml
         $ kubectl apply -f https://github.com/knative/net-contour/releases/download/knative-${KNATIVE_VERSION}/net-contour.yaml
         $ kubectl patch configmap/config-network \
             --namespace knative-serving \
             --type merge \
             --patch '{"data":{"ingress-class":"contour.ingress.networking.knative.dev"}}'
         $ kubectl get service envoy --namespace contour-external

   -  Istio:

      .. code-block:: sh

         $ kubectl apply -l knative.dev/crd-install=true -f https://github.com/knative/net-istio/releases/download/knative-${KNATIVE_VERSON}/istio.yaml
         $ kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-${KNATIVE_VERSION}/istio.yaml
         $ kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-${KNATIVE_VERSION}/net-istio.yaml
         $ kubectl get service istio-ingressgateway --namespace istio-system

   -  Kourier (recommended default):

      .. code-block:: sh

         $ kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-${KNATIVE_VERSION}/kourier.yaml
         $ kubectl patch configmap/config-network \
             --namespace knative-serving \
             --type merge \
             --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'
         $ kubectl get service kourier --namespace kourier-system

-  Install cert-manager support:

   .. code-block:: sh

      $ kubectl apply -f https://github.com/knative/net-certmanager/releases/download/knative-${KNATIVE_VERSION}/release.yaml

[81]

Tanzu Administration
~~~~~~~~~~~~~~~~~~~~

TKGS
^^^^

Supervisor Cluster Access
'''''''''''''''''''''''''

Access to the TKGS Supervisor cluster is restricted and only meant to be used accessed by automated APIs and VMware support for troubleshooting. Any modifications made to the Supervisor cluster **WILL** revoke the ability of VMware to provide support for it. In that case, the Supervisor cluster will need to be completely re-deployed.

-  SSH into the vCenter host.

   ::

      $ ssh -l root <VCENTER_SERVER_IP>
      
      VMware vCenter Server 7.0.2.00000
      
      Type: vCenter Server with an embedded Platform Services Controller
      
      root@<VCENTER_SERVER_IP>'s password:
      Connected to service
      
          * List APIs: "help api list"
          * List Plugins: "help pi list"
          * Launch BASH: "shell"
      
      Command>

-  Open a shell and then find the password used by all SuperVisorControlPlaneVMs.

   ::

      Command> shell
      Shell access is granted to root
      root@<VCENTER_HOSTNAME> [ ~ ]# /usr/lib/vmware-wcp/decryptK8Pwd.py
      Read key from file
      
      Connected to PSQL
      
      Cluster: domain-c8:446a411e-7f5c-4d4a-8e35-720c6a07ff44
      IP: 10.213.212.45
      PWD: VHFSZbeMPYZIxZcKOhB9dNAR35UrAsE9gMILZQz5QjsK6obI0/PX7CiTKFeIx2vbcmC6OmeILeweue3PlkHHWMUzixMRHAugtHx5TyDgqYxazEsQrMBi47v8H0wHjyYJCdyleGviTRbSvN8LcnipvgDltcTl0cab94KRYJ5BkzY=
      ------------------------------------------------------------

-  From vSphere, find an IP address of one of the SupervisorControlPlaneVM virtual machines. Ignore the IP address from the previous command. Use the "PWD" password to log in.

   ::

      root@<VCENTER_HOSTNAME> [ ~ ]# ssh -l root <SUPERVISOR_CONTROL_PLANE_VM_IP>
      FIPS mode initialized
      Password: VHFSZbeMPYZIxZcKOhB9dNAR35UrAsE9gMILZQz5QjsK6obI0/PX7CiTKFeIx2vbcmC6OmeILeweue3PlkHHWMUzixMRHAugtHx5TyDgqYxazEsQrMBi47v8H0wHjyYJCdyleGviTRbSvN8LcnipvgDltcTl0cab94KRYJ5BkzY=
      Last login: Fri Aug 27 21:35:36 2021 from 10.213.212.14
       21:40:15 up 23 days,  3:12,  0 users,  load average: 12.10, 8.86, 7.46
      
      41 Security notice(s)
      Run 'tdnf updateinfo info' to see the details.
      root@<SUPERVISOR_CONTROL_PLANE_VM_HOSTNAME> [ ~ ]#

-  The default Kubernetes configuration provides full "admin" access to the cluster via ``kubectl``.

[56]

Troubleshooting
---------------

Errors
~~~~~~

Error when installing Flannel with ``kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml``:

.. code-block:: sh

   $ kubectl -n kube-system describe pod kube-flannel-ds-rgzpn
   E0304 04:04:44.958281       1 main.go:292] Error registering network: failed to acquire lease: node "<NODE_HOSTNAME>" pod cidr not assigned

Solution:

-  Kubernetes was not installed with a Pod network CIDR assigned. For kubeadm, uninstall the cluster and reinstall with the argument: ``kubeadm --pod-network-cidr=10.244.0.0/16``.

----

CoreDNS container is stuck in the ``STATUS`` of ``ContainerCreating`` with the error message ``failed to find plugin "<PLUGIN>" in path [<PATH>]``.

.. code-block:: sh

   $ kubectl -n kube-system describe pod coredns-f9fd979d6-cr7p6
     Warning  FailedCreatePodSandBox  69s (x17 over 4m40s)  kubelet            (combined from similar events): Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "76c5c21331dd5998d9a6efd5ac6d74c45b10386db7d34555c7e0f22f5969ee13": failed to find plugin "loopback" in path [/usr/lib/cni]

Solutions:

-  The CNI plugins might be installed to a different path such as ``/opt/cni/bin/`` instead of ``/usr/lib/cni/``. Run this command to create a symlink to it: ``ln -s /opt/cni/bin /usr/lib/cni``.
-  If the CNI plugins are missing from the system, then download the source code, compile the plugins, and then copy them to the correct directory. [52]

   .. code-block:: sh

      $ git clone https://github.com/containernetworking/plugins.git
      $ cd plugins
      $ ./build_linux.sh
      $ sudo mkdir -p /usr/lib/cni/ # Or use '/opt/cni/bin/'.
      $ sudo cp ./bin/* /usr/lib/cni/

----

CoreDNS container is stuck in ``STATUS`` of ``ContainerCreating`` with the error message ``error getting ClusterInformation: connection is unauthorized: Unauthorized``:

.. code-block:: sh

   $ kubectl -n kube-system describe pod coredns-f9fd979d6-72lh2
     Warning  FailedCreatePodSandBox  3m3s (x17 over 6m33s)  kubelet            (combined from similar events): Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "dcc4d29a213211977d0aa11195980a11533d722cfcd9ef11cf7b1385ef9dde10": error getting ClusterInformation: connection is unauthorized: Unauthorized

Solution:

-  Calico/Canal or another CNI plugin was uninstalled. CNI plugins usually leave configuration files on the system. Manually delete those files.

   .. code-block:: sh

      $ sudo rm -f /etc/cni/net.d/10-canal.conflist /etc/cni/net.d/calico-kubeconfig

----

``k3s`` keeps reporting the error ``x509: certificate has expired or is not yet valid``:

.. code-block:: sh

   $ sudo cat /var/log/syslog
   Mar 10 21:11:18 kube0 k3s[438]: E0310 21:11:18.648950     438 reflector.go:153] k8s.io/client-go/informers/factory.go:135: Failed to list *v1beta1.Event: Unauthorized
   Mar 10 21:11:18 kube0 k3s[438]: E0310 21:11:18.664390     438 authentication.go:104] Unable to authenticate the request due to an error: x509: certificate has expired or is not yet valid
   Mar 10 21:11:18 kube0 k3s[438]: I0310 21:11:18.665009     438 log.go:172] http: TLS handshake error from 127.0.0.1:45154: remote error: tls: bad certificate
   Mar 10 21:11:18 kube0 k3s[438]: E0310 21:11:18.666361     438 reflector.go:153] k8s.io/client-go/informers/factory.go:135: Failed to list *v1beta1.CSIDriver: Get https://127.0.0.1:6443/apis/storage.k8s.io/v1beta1/csidrivers?limit=500&resourceVersion=0: x509: certificate has expired or is not yet valid
   Mar 10 21:11:18 kube0 k3s[438]: E0310 21:11:18.667607     438 reflector.go:153] k8s.io/client-go/informers/factory.go:135: Failed to list *v1.Pod: Unauthorized
   Mar 10 21:11:18 kube0 k3s[438]: E0310 21:11:18.696824     438 authentication.go:104] Unable to authenticate the request due to an error: x509: certificate has expired or is not yet valid

Solutions:

-  The system time is set incorrectly.
-  Upgrade to >= ``v1.19.1+k3s1`` where certificate rotation was fixed.
-  Restart the ``k3s`` service. Once it starts, if it detects that a certificate is going to expire within 90 days or less, it will recreate the certificates.

   .. code-block:: sh

      # Control-plane Node
      $ sudo systemctl restart k3s
      # Worker Node
      $ sudo systemctl restart k3s-agent

-  The certificate has already expired. ``k3s`` will only rotate certificates that are about to expire (not ones that have expired). Manually set the date back to force the certificates to be regenerated.

   .. code-block:: sh

      $ kubectl get nodes
      Unable to connect to the server: x509: certificate has expired or is not yet valid: current time 2021-03-10T21:34:56Z is after 2021-02-27T21:54:59Z

   .. code-block:: sh

      # Stop the 'k3s' (Control Plane) or 'k3s-agent' (Worker Node) service.
      $ sudo systemctl stop k3s
      # Manually set the date to be within 90 days before the certificate has expired.
      $ sudo date -s 20210220
      # Start k3s to rotate the certificates.
      $ sudo systemctl start k3s
      # Verify it works now.
      $ kubectl get nodes
      # Stop k3s.
      $ sudo systemctl stop k3s
      # Set the date back manually. Or use a time synchornization program such as 'chronyd' or 'ntpd'.
      $ sudo date -s 20210310

[53]

----

Error ``use of <SIGNER_NAME> signer with system:masters group is not allowed`` when creating a CertificateSigningRequest object:

.. code-block:: sh

   $ kubectl apply -f csr-user-foobar.yaml
   Error from server (Forbidden): error when creating "csr-user-foobar.yaml": certificatesigningrequests.certificates.k8s.io "csr-user-foobar" is forbidden: use of kubernetes.io/kube-apiserver-client signer with system:masters group is not allowed

Solutions:

-  Manually create/sign the certificate with ``openssl`` and the Kubernetes CA.
-  Or use ``openssl`` to generate a new certificate signing request that does not include ``/O=system:masters``.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization/kubernetes_administration.rst>`__
-  `< 2019.10.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization/kubernetes.rst>`__
-  `< 2019.07.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization/containers.rst>`__
-  `< 2019.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/virtualization.rst>`__

Bibliography
------------

1. "Kubernetes Components." Kubernetes Concepts. January 16, 2020. Accessed April 8, 2020. https://kubernetes.io/docs/concepts/overview/components/
2. "The History of Kubernetes on a Timeline." RisingStack Blog. June 20, 2018. Accessed April 8, 2020. https://blog.risingstack.com/the-history-of-kubernetes/
3. "Understanding persistent storage." Red Hat OpenShift Container Platform 4.5 Documentation. Accessed July 16, 2020. https://docs.openshift.com/container-platform/4.5/storage/understanding-persistent-storage.html
4. "OKD: Renaming of OpenShift Origin with 3.10 Release." Red Hat OpenShift Blog. August 3, 2018. Accessed September 17, 2018. https://blog.openshift.com/okd310release/
5. "Releases Notes. OpenShift Container Platform 4.1 Documentation. https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html-single/release_notes/index
6. "Red Hat OpenShift Container Platform Life Cycle Policy." Red Hat Support. Accessed April 11, 2021. https://access.redhat.com/support/policy/updates/openshift
7. "minikube start." minikube Documentation. November 19, 2021. Accessed April 11, 2022. https://minikube.sigs.k8s.io/docs/start/
8. "Kubernetes 1.13: Simplified Cluster Management with Kubeadm, Container Storage Interface (CSI), and CoreDNS as Default DNS are Now Generally Available." Kubernetes Blog. December 3, 2018. Accessed December 5, 2018. https://kubernetes.io/blog/2018/12/03/kubernetes-1-13-release-announcement/
9. "Creating a cluster with kubeadm." Kubernetes Documentation. February 4, 2021. Accessed February 19, 2021. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
10. "k3s - 5 less than k8s." k3s, GitHub. March 29, 2019. Accessed April 1, 2019. https://github.com/rancher/k3s
11. "Drivers." Kubernetes CSI Developer Documentation. Accessed April 11, 2019. https://kubernetes-csi.github.io/docs/drivers.html
12. "Minishift Quickstart." OpenShift Documentation. Accessed February 26, 2018. https://docs.openshift.org/latest/minishift/getting-started/quickstart.html
13. "Run OpenShift Locally with Minishift." Fedora Magazine. June 20, 2017. Accessed February 26, 2018. https://fedoramagazine.org/run-openshift-locally-minishift/
14. "CHAPTER 5. INSTALLING RED HAT CONTAINER DEVELOPMENT KIT." Red Hat Customer Portal. Accessed February 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_container_development_kit/3.0/html/installation_guide/installing-rhcdk
15. "Configuring Clusters." OpenShift Container Platform Documentation. Accessed February 5, 2019. https://docs.openshift.com/container-platform/3.11/install_config/index.html
16. "OpenShift: Container Application Platform by Red Hat." OpenShift. Accessed February 26, 2018. https://www.openshift.com/
17. "How to run AWX on Minishift." opensource.com. October 26, 2018. Accessed July 3, 2020. https://opensource.com/article/18/10/how-run-awx-minishift
18. "kube-controller-manager." Kubernetes Reference. April 13, 2020. Accessed June 8, 2020. https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/
19. "Comparing Kubernetes CNI Providers: Flannel, Calico, Canal, and Weave." Rancher Lab's Kubernetes Blog. December 4, 2019. Accessed July 14, 2020. https://rancher.com/blog/2019/2019-03-21-comparing-kubernetes-cni-providers-flannel-calico-canal-and-weave/
20. "Benchmark results of Kubernetes network plugins (CNI) over 10Gbit/s network (Updated: April 2019)." ITNEXT. April 12, 2019. Accessed July 14, 2020. https://itnext.io/benchmark-results-of-kubernetes-network-plugins-cni-over-10gbit-s-network-36475925a560
21. "OKD4 is now Generally Available." Red Hat OpenShift Blog. July 15, 2020. Accessed July 16, 2020. https://www.openshift.com/blog/okd4-is-now-generally-available
22. "Guide to Installing an OKD 4.4 Cluster on your Home Lab." Red Hat OpenShift Blog. March 24, 2020. July 16, 2020. https://openshift.com/blog/guide-to-installing-an-okd-4-4-cluster-on-your-home-lab
23. "OpenShift 4.0 Infrastructure Deep Dive." YouTube - Rob Szumski. January 23, 2019. Accessed July 16, 2020. https://www.youtube.com/watch?v=Wi3QNi4zi_4
24. "The OpenShift Container Platform control plane." Red Hat OpenShift Container Platform 4.5 Documentation. Accessed July 16, 2020. https://docs.openshift.com/container-platform/4.5/architecture/control-plane.html
25. "Understanding cluster logging." Red Hat OpenShift Container Platform 4.5 Documentation. Accessed July 16. https://docs.openshift.com/container-platform/4.5/logging/cluster-logging.html
26. "Router Overview." Red Hat OpenShift Container Platform 3.11 Documentation. Accessed July 16, 2020. https://docs.openshift.com/container-platform/3.11/install_config/router/index.html
27. "Installation methods for different platforms." Red Hat OpenShift Container Platform 4.5. Accessed July 16, 2020. https://docs.openshift.com/container-platform/4.5/installing/install_config/installation-types.html
28. "Getting Started Guide." crc. Accessed August 13, 2020. https://code-ready.github.io/crc/
29. "Basic controls." minikube Documentation. April 7, 2020. Accessed October 18, 2020. https://minikube.sigs.k8s.io/docs/handbook/controls/
30. "Upgrading kubeadm clusters." Kubernetes Documentation. August 7, 2020. Accessed October 18, 2020. https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
31. "Kubernetes version and version skew support policy." Kubernetes Documentation. August 15, 2020. Accessed October 18, 2020. https://kubernetes.io/docs/setup/release/version-skew-policy/
32. "Deploying Tanzu Kubernetes Clusters and Managing their Lifecycle." VMware Tanzu Kubernetes Grid Docs. October 26, 2020. Accessed October 27, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-index.html
33. "VMware Tanzu Kubernetes Grid 1.5 Release Notes." VMware Tanzu Kubernetes Grid Docs. April 6, 2022. Accessed April 11, 2022. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.5/rn/vmware-tanzu-kubernetes-grid-15-release-notes/index.html
34. "Download and Install the Tanzu Kubernetes Grid CLI." VMware Tanzu Kubernetes Grid Docs. August 27, 2020. Accessed October 27, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.1/vmware-tanzu-kubernetes-grid-11/GUID-install-tkg-set-up-tkg.html
35. "AWS Command Line Interface User Guide." AWS Documentation. May 19, 2020. Accessed October 27, 2020. https://docs.aws.amazon.com/cli/latest/userguide/aws-cli.pdf
36. "Deploy Management Clusters to Amazon EC2 with the CLI." VMware Tanzu Kubernetes Grid Docs. October 26, 2020. Accessed October 27, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-aws-cli.html
37. "Create Tanzu Kubernetes Clusters." VMware Tanzu Kubernetes Grid Docs. October 26, 2020. Accessed October 27, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-create.html
38. "Connect to and Examine Tanzu Kubernetes Clusters." VMware Tanzu Kubernetes Grid Docs. October 26, 2020. Accessed October 27, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-connect.html
39. "Delete Tanzu Kubernetes Clusters." VMWare Tanzu Kubernetes Grid Docs. October 26, 2020. Accessed October 31, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-delete-cluster.html
40. "Delete Management Clusters." VMWare Tanzu Kubernetes Grid Docs. August 27, 2020. Accessed October 31, 2020. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.1/vmware-tanzu-kubernetes-grid-11/GUID-manage-instance-delete-management-cluster.html
41. "[clusterctl] "clusterctl config provider" fails to show AWS, VSphere, and Azure info #2876." GitHub kubernetes-sigs/cluster-api. April 20, 2020. Accessed October 31, 2020.
42. "Container runtimes." Kubernetes Documentation. October 28, 2020. Accessed November 14, 2020. https://kubernetes.io/docs/setup/production-environment/container-runtimes/
43. "Traefik & Kubernetes." Traefik Labs Docs. 2020. Accessed November 30, 2020. https://doc.traefik.io/traefik/providers/kubernetes-ingress/
44. "Install Traefik." Traefik Labs Docs. 2020. Accessed November 30, 2020. https://doc.traefik.io/traefik/getting-started/install-traefik/
45. "Quick Start." kind. December 3, 2020. Accessed January 19, 2021. https://kind.sigs.k8s.io/docs/user/quick-start
46. "Upgrading underlying kubernetes version #1972." GitHub kubernetes-sigs/kind. December 9, 2020. Accessed January 19, 2021. https://github.com/kubernetes-sigs/kind/issues/1972
47. "Port Requirements." Rancher Docs: Port Requirements. November 17, 2020. Accessed February 19, 2021. https://rancher.com/docs/rancher/v2.x/en/installation/requirements/ports/
48. "kubeadm." GitHub flannel-io/flannel. October 25, 2020. Accessed February 19, 2021. https://github.com/flannel-io/flannel/blob/master/Documentation/kubernetes.md
49. "Install Calico for policy and flannel (aka Canal) for networking." Project Calico Documentation. April 17, 2020. Accessed February 19, 2021. https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel
50. "Installation Options." Rancher Docs. Accessed February 24, 2021. https://rancher.com/docs/k3s/latest/en/installation/install-options/
51. "Properly Resetting Your kubeadm-bootstrapped Cluster Nodes — #HeptioProTip." Heptio Blog. January 3, 2018. March 2, 2021. https://blog.heptio.com/properly-resetting-your-kubeadm-bootstrapped-cluster-nodes-heptioprotip-473bd0b824aa
52. "coredns been in Pending state." Programmer Sought. Accessed March 3, 2021.  https://www.programmersought.com/article/23693305901/
53. "certificate expired and rotate #1621." GitHub k3s-io/k3s. February 8, 2021. Accessed March 10, 2021. https://github.com/k3s-io/k3s/issues/1621
54. "VMware Tanzu Kubernetes Grid Documentation." VMware Docs. Accessed March 11, 2021. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/index.html
55. "Welcome to Cloud Foundry BOSH." Cloud Foundry BOSH. Accessed March 11, 2021. https://bosh.io/docs/
56. "Common issues with a vSphere with Tanzu Cluster deployment stuck in Configuring state (83060)." VMware Customer Connect. July 27, 2021. Accessed August 27, 2021. https://kb.vmware.com/s/article/83060
57. "Comparing Ingress controllers for Kubernetes." Flant Blog. October 12, 2019. Accessed March 26, 2021. https://medium.com/flant-com/comparing-ingress-controllers-for-kubernetes-9b397483b46b
58. "Ingress Controllers." Kubernetes Documentation. February 13, 2021. Accessed March 30, 2021. https://kubernetes.io/docs/concepts/services-networking/ingress-controllers
59. "Installing kubeadm." Kubernetes Documentation. February 17, 2021. Accessed July 22, 2021. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
60. "Network Requirements." GitHub antrea-io/antrea. May 7, 2021. Accessed July 12, 2021. https://github.com/antrea-io/antrea/blob/main/docs/network-requirements.md
61. "kubeadm init." Kubernetes Documentation. February 17, 2021. Accessed June 14, 2021. https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
62. "Deploy Tanzu Kubernetes Clusters with Different Kubernetes Versions." VMware Docs. June 9, 2021. Accessed June 10, 2021. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.3/vmware-tanzu-kubernetes-grid-13/GUID-tanzu-k8s-clusters-k8s-versions.html
63. "Getting Started." Contour. Accessed April 8, 2021. https://projectcontour.io/getting-started/
64. "Differences Between nginxinc/kubernetes-ingress and kubernetes/ingress-nginx Ingress Controllers." GitHub nginxinc/kubernetes-ingress. July 13, 2020. Accessed April 8, 2021. https://github.com/nginxinc/kubernetes-ingress/blob/master/docs/nginx-ingress-controllers.md
65. "Installation Guide." NGINX Ingress Controller. Accessed April 8, 2021. https://kubernetes.github.io/ingress-nginx/deploy/
66. "Installation with Helm." NGINX Docs. Accessed April 8, 2021. https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/
67. "Enable the Embedded Harbor Registry." VMware Docs. February 16, 2021. Accessed April 13, 2021. https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-AE24CF79-3C74-4CCD-B7C7-757AD082D86A.html
68. "Configure a Tanzu Kubernetes Cluster with the Image Pull Secret for the Embedded Harbor Registry." VMware Docs. February 16, 2021. Accessed April 13, 2021. https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-13CDE060-DF61-4AA0-9DEE-6D3F903BAB77.html
69. "Helm Chart for Harbor." GitHub goharbor/harbor-helm. February 26, 2021. Accessed April 14, 2021. https://github.com/goharbor/harbor-helm
70. "Create a helm chart for Contour #2050." GitHub projectcontour/contour. February 12, 2021. Accessed April 15, 2021. https://github.com/projectcontour/contour/issues/2050
71. "Run the Installer Script." Harbor docs. October 28, 2020. Accessed April 16, 2021. https://goharbor.io/doc/2.1.0/install-config/run-installer-script/
72. "Harbor." GitHub bitnami/charts. March 30, 2021. Accessed April 16, 2021. https://github.com/bitnami/charts/tree/master/bitnami/harbor
73. "vSphere with Tanzu Configuration and Management." VMware Docs. April 3, 2021. Accessed April 19, 2021. https://kubernetes.io/docs/reference/access-authn-authz/rbac/
74. "Verify Tanzu Kubernetes Cluster Compatibility for Update." VMware Docs. December 9, 2021. Accessed August 24, 2022. https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-292482C2-A5FA-44B5-B26E-F887A91BB19D.html
75. "Tanzu Kubernetes Cluster Networking." VMware Docs. April 21, 2021. Accessed June 10, 2021. https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-A7756D67-0B95-447D-A645-E2A384BF8135.html
76. "Installation." MetalLB, bare metal load-balancer for Kubernetes. 2021. Accessed October 12, 2021. https://metallb.universe.tf/installation/
77. "Configuration." MetalLB, bare metal load-balancer for Kubernetes. 2021. Accessed October 12, 2021. https://metallb.universe.tf/configuration/
78. "MetalLB." GitHub bitnami/charts. October 8, 2021. Accessed October 12, 2021. https://github.com/bitnami/charts/tree/master/bitnami/metallb
79. "Ingress." kind. July 14, 2021. Accessed October 28, 2021. https://kind.sigs.k8s.io/docs/user/ingress
80. "Migrating from Knative Build." Tekton. Accessed January 14, 2022. https://tekton.dev/docs/pipelines/migrating-from-knative-build/
81. "Installing Knative Serving using YAML files." Knative. Accessed January 14, 2022. https://knative.dev/docs/install/serving/install-serving-with-yaml/
82. "Getting Started with Managed Clusters." VMware Tanzu Community Edition Documentation. Accessed February 18, 2022. https://tanzucommunityedition.io/docs/latest/getting-started/
83. "Deploy a Management Cluster to Docker." VMware Tanzu Community Edition Documentation. Accessed February 18, 2022. https://tanzucommunityedition.io/docs/latest/docker-install-mgmt/
84. "Delete Management Clusters." VMware Tanzu Community Edition Documentation. Accessed February 18, 2022. https://tanzucommunityedition.io/docs/latest/delete-mgmt/
85. "Work with Packages." VMware Tanzu Community Edition Documentation. Accessed April 12, 2022. https://tanzucommunityedition.io/docs/v0.11/package-management/
86. "Uninstall the Tanzu CLI." VMware Tanzu Community Edition Documentation. Accessed February 18, 2022. https://tanzucommunityedition.io/docs/latest/cli-uninstall/
87. "Getting Started with Unmanaged Clusters." VMware Tanzu Community Edition Documentation. Accessed February 23, 2022. https://tanzucommunityedition.io/docs/latest/getting-started-unmanaged/
88. "Releases." GitHub vmware-tanzu/community-edition. March 29, 2022. Accessed April 11, 2022. https://github.com/vmware-tanzu/community-edition/releases
89. "make docker driver highly preferred #8623." GitHub kubernetes/minikube. July 1, 2020. Accessed April 11, 2022. https://github.com/kubernetes/minikube/pull/8623
90. "Create Persistent Volumes with Storage Classes." VMware Tanzu Community Edition Documentation. Accessed April 12, 2022. https://tanzucommunityedition.io/docs/v0.11/storage/
91. "Cluster doesn't restart when docker restarts #148." GitHub kubernetes-sigs/kind. March 20, 2022. Accessed April 12, 2022. https://github.com/kubernetes-sigs/kind/issues/148#issuecomment-1044197449
92. "Opening Ports with firewalld." Rancher Docs. March 21, 2022. Accessed May 4, 2022. https://rancher.com/docs/rancher/v2.6/en/installation/resources/advanced/firewall/
93. "k3s service cannot start in RHEL with firewall enabled #401." GitHub k3s-io/k3s. February 19, 2021. Accessed May 5, 2022. https://github.com/k3s-io/k3s/issues/401
94. "Implementation details." Kubernetes Documentation. January 18, 2022. Accessed May 18, 2022. https://kubernetes.io/docs/reference/setup-tools/kubeadm/implementation-details/
95. "What firewall do you use/How do you lockdown a node?" Reddit r/kubernetes. July 16, 2021. Accessed May 18, 2022. https://www.reddit.com/r/kubernetes/comments/olhrpo/what_firewall_do_you_usehow_do_you_lockdown_a_node/
96. "An introduction to crun, a fast and low-memory footprint container runtime." Red Hat Enable Sysadmin. August 3, 2020. Accessed May 18, 2020. https://www.redhat.com/sysadmin/introduction-crun
97. "Performance Evaluation of Container Runtimes." Chair of Computer Architecture and Parallel Systems, TU Munich, Garching, Germany. 2020. Accessed May 18, 2022.
98. "Installing with Helm." cert-manager Documentation. 2022. Accessed July 5, 2022. https://cert-manager.io/docs/installation/helm/
99. "VMware Tanzu Kubernetes releases Release Notes." VMware Docs. July 29, 2022. Accessed August 24, 2022. https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-releases/services/rn/vmware-tanzu-kubernetes-releases-release-notes/index.html
