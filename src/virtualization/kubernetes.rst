Kubernetes
==========

.. contents:: Table of Contents

Architecture
------------

Kubernetes is an open-source container management platform. It handles the life-cycle of Pods which are a collection of related containers required to run an application. Kubernetes clusters contain two types of servers:

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

Kubernetes was originally created by Google in 2003 and was called the Borg System. In 2014, it was renamed to Kubernetes and released as open-source software under the Apache License version 2.0. [2]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/virtualization/kubernetes.rst>`__

Bibliography
------------

1. "Kubernetes Components." Kubernetes Concepts. January 16, 2020. Accessed April 8, 2020. https://kubernetes.io/docs/concepts/overview/components/
2. "The History of Kubernetes on a Timeline." RisingStack Blog. June 20, 2018. Accessed April 8, 2020. https://blog.risingstack.com/the-history-of-kubernetes/
