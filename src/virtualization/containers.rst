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

   -  archlinux

-  Fedora

   -  centos:8
   -  fedora:31

-  Debian

   -  debian:10
   -  ubuntu:20.04

-  openSUSE

   -  opensuse/leap:15.2
   -  opensuse/tumbleweed

More containers can be found `here <https://hub.docker.com/explore/>`__.

docker
------

The docker software (with a lowercase "d") was created by the Docker company to manage and create containers using the LXC kernel module on Linux.

A command is ran to start a daemon in the container. As long as that process is still running in the foreground, the container will remain active. Some processes may spawn in the background. A workaround for this is to append ``&& tail -f /dev/null`` to the command. If the daemon successfully starts, then a never-ending task can be run instead (such as viewing the never ending file of /dev/null). [1]

The docker software (with a lowercase "d") was created by the Docker company to manage and create containers using the LXC kernel module on Linux.$
By default, only the "root" user has access to manage docker containers. Users assigned to a "docker" group will have the necessary privileges. However, they will then have administrator access to the system. If the "docker" group is newly created then the daemon needs to be restarted for the change to load up. The docker user may also have to run the ``newgrp docker`` command to reload their groups. [2]

.. code-block:: sh

    $ sudo groupadd docker
    $ sudo usermod -a -G docker <USER>
    $ sudo systemctl restart docker

Dockerfile
~~~~~~~~~~

docker containers are built by using a template called ``Dockerfile``. This file contains a set of instructions on how to build and handle the container when it's started.

**Dockerfile Commands**

-  **FROM** <IMAGE>:<TAG> = The original container image to copy and use as a base for this new container.
-  ADD <SOURCE> <DESTINATION> = Similar in functionality to ``COPY``. This should only be used to download URLs or extract archives.
-  CMD = The default command to run in the container, if ``ENTRYPOINT`` is not defined. If ``ENTRYPOINT`` is defined, then ``CMD`` will serve as default arguments to ``ENTRYPOINT`` that can be overridden from the docker CLI.
-  COPY <SOURCE> <DESTINATION> = Copy a file or directory to/from the container image. It is recommended to use this method instead of ``ADD`` for simple operations.
-  **ENTRYPOINT** = The default command to run in this container. Arguments from the docker CLI will be passed to this command and override the optional ``CMD`` arguments. Use if this container is supposed to be an executable.
-  ENV <VARIABLE>=<VALUE> = Create shell environment variables.
-  EXPOSE <PORT>/<PROTOCOL> = Connect to certain network ports.
-  **FROM** = The original image to create this container from.
-  LABEL = A no-operation string that helps to identify the image. One or more labels can be specified.
-  MAINTAINER (deprecated) = The name or e-mail address of the image maintainer.

   -  Use ``LABEL maintainer=<EMAIL_ADDRESS>`` instead.

-  RUN = A command that can be ran once in the container. Use the ``CMD <COMMAND> <ARG1> <ARG2>`` format to open a shell or ``CMD ['<COMMAND>', '<ARG1>', '<ARG2>']`` to execute without a shell.
-  USER <UID>:<GID> = Configure a UID and/or GID to run the container as.
-  VOLUME <PATH> = A list of paths inside the container that can mount to an external persistent storagedevice (for example, for storing a database).
-  WORKDIR = The working directory where commands will be executed from.

[23]

**Storage Space**

Containers should be ephemeral where the persistent data is stored in an external location (volume) and/or a database. Almost every Dockerfile operation creates a writable/container layer ontop of the previous layer. Each layer takes up more space.

Lower space usage by [28]:

-  Using a small image such as `alpine <https://hub.docker.com/_/alpine>`__.
-  Combining all ``RUN`` commands into one statement. Chain them together with ``&&`` to ensure that each command succeeds before moving onto the next one.
-  Cleaning package manager cache (if applicable).
-  Using the `docker image build --squash <https://docs.docker.com/engine/reference/commandline/image_build/>`__  or `buildah bud --squash <https://github.com/containers/buildah/blob/master/docs/buildah-bud.md>`__ command to consolidate all additional layers when creating a new image. Use `docker-squash <https://github.com/goldmann/docker-squash>`__ to consolidate an existing image.

A Dockerfile cannot ``ADD`` or ``COPY`` directories above where the ``docker build`` command is being run from. Only that directory and sub-directories can be used. Use ``docker build -f <PATH_TO_DOCKERFILE>`` to use a Dockerfile from a different directory and also use the current working directory for copying files from. [29]

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

[3]

In rare cases, the bridge networking will not be working properly. An
error message similar to this may appear during creation.

::

    ERROR: for <CONTAINER_NAME> failed to create endpoint <NETWORK_ENDPOINT> on network bridge: iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport <DESTINATION_PORT_HOST> -j DNAT --to-destination <IP_ADDRESS>:<DESTINATION_PORT_CONTAINER> ! -i docker0: iptables: No chain/target/match by that name.

The solution is to delete the virtual "docker0" interface and then
restart the docker service for it to be properly recreated.

.. code-block:: sh

    $ sudo ip link delete docker0
    $ sudo systemctl restart docker

[4]

Java
~~~~

Java <= 9, by default, will try to allocate a large amount of memory for the runtime and garbage collection. This can lead to resource exhaustion of RAM on a hypervisor. The maximum memory allocation should be specified to Java applications using ``-Xmx<SIZE_IN_MB>m``. [7] This is no longer an issue in Java >= 10 as it is now aware of when it is being containerized. [8]

Example Java <=9 usage in a docker compose file that utilizes an environment variable:

::

   CMD java -XX:+PrintFlagsFinal $JAVA_OPTS -jar app.jar

LXC
---

Linux Containers (LXC) utilizes the Linux kernel to natively run
containers.

Debian install [5]:

.. code-block:: sh

    $ sudo apt-get install lxc

RHEL install [6] requires the Extra Packages for Enterprise Linux (EPEL)
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

Kubernetes
~~~~~~~~~~

Kubernetes provides an API and graphical user interface for the orchestration and scaling of docker containers. It was originally created by Google as part of their Google Kubernetes Engine cloud platform.

Storage
^^^^^^^

Kubernetes storage requires a ``PersistentVolume`` (PV) pool that users can create multiple ``PersistentVolumeClaim`` (PVC) claims from.

Storage is recommended to be dynamic (ephemeral) so that applications can scale and handle failures in a cloudy way. However, databases and legacy applications may require static (persistent) storage.

-  PersistentVolume spec [18]:

   -  storageClassName = The storage back-end to use. Leave blank to use the default. Set to a non-existent storage class to manually manage it (for example, "" or "manual").
   -  **accessModes** [19]

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

[20]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/virtualization/containers.rst>`__
-  `< 2019.04.01 (Virtualization) <https://github.com/ekultails/rootpages/commits/master/src/administration/virtualization.rst>`__
-  `< 2019.01.01 (Virtualization) <https://github.com/ekultails/rootpages/commits/master/src/virtualization.rst>`__
-  `< 2018.01.01 (Virtualization) <https://github.com/ekultails/rootpages/commits/master/markdown/virtualization.md>`__

Bibliography
------------

1. "Get started with Docker." Docker. Accessed November 19, 2016. https://docs.docker.com/engine/getstarted
2. "Getting started with Docker." Fedora Developer Portal. Accessed May 16, 2018. https://developer.fedoraproject.org/tools/docker/docker-installation.html
3. "containers in docker 1.11 does not get same MTU as host #22297." Docker GitHub. September 26, 2016. Accessed November 19, 2016. https://github.com/docker/docker/issues/22297
4. "iptables failed - No chain/target/match by that name #16816." Docker GitHub. November 10, 2016. Accessed December 17, 2016. https://github.com/docker/docker/issues/16816
5. "LXC." Ubuntu Documentation. Accessed August 8, 2017. https://help.ubuntu.com/lts/serverguide/lxc.html
6. "How to install and setup LXC (Linux Container) on Fedora Linux 26." nixCraft. July 13, 2017. Accessed August 8, 2017. https://www.cyberciti.biz/faq/how-to-install-and-setup-lxc-linux-container-on-fedora-linux-26/
7. "Java inside docker: What you must know to not FAIL." Red Hat Developers Blog. March 14, 2017. Accessed October 2018. https://developers.redhat.com/blog/2017/03/14/java-inside-docker/
8. "Improve docker container detection and resource configuration usage." Java Bug System. November 16, 2017. Accessed October 5, 2018. https://bugs.openjdk.java.net/browse/JDK-8146115
18. "API OVERVIEW." Kubernetes API Reference Docs. Accessed January 29, 2019. https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#storageclass-v1-storage
19. "Persistent Volumes." Kubernetes Concepts. January 16, 2019. Accessed January 29, 2019. https://kubernetes.io/docs/concepts/storage/persistent-volumes/
20. "Configure a Pod to Use a PersistentVolume for Storage." Kubernetes Tasks. November 6, 2018. Accessed January 29, 2019. https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
23. "Dockerfile reference." Docker Documentation. 2019. Accessed April 3, 2019. https://docs.docker.com/engine/reference/builder/
28. "Five Ways to Slim Docker Images." Codacy Blog. December 14, 2017. Accessed March 21, 2020. https://blog.codacy.com/five-ways-to-slim-your-docker-images/
29. "Best practices for writing Dockerfiles." Docker Documentation. Accessed March 21, 2020. https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
