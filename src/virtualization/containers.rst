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

`Docker Hub <https://hub.docker.com/>`__ is a container registry that provides a central location to find, download, and upload container images. Here is a list of common operating system images for each family of distributions:

-  Arch Linux

   -  archlinux:latest

-  Fedora

   -  almalinux:9
   -  centos:stream9
   -  fedora:40

-  Debian

   -  debian:12
   -  ubuntu:24.04

-  openSUSE

   -  opensuse/leap:15.6
   -  opensuse/tumbleweed:latest

More containers can be found `here <https://hub.docker.com/explore/>`__.

Bootstrap an Operating System
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using a package manager and the main operating system repositories, it is possible to bootstrap an operating system. It installs all of the operating system packages into a directory. It can then be used as a chroot or for a container image. This can be done on different operating systems but the relevant package manager has to be installed. Arch Linux is one of the few distributions that ships all of the most popular package managers.

**Arch Linux**

.. code-block:: sh

   $ mkdir -p archlinux_bootstrap/var/lib/pacman
   $ cd archlinux_bootstrap
   $ sudo pacman -r . -Syy
   $ sudo pacman -r . -S base

If not using Arch Linux with ``pacman`` installed, `download <https://www.archlinux.org/download/>`__ the ``archlinux-bootstrap-<DATE>-x86_64.tar.gz`` tarball from one of the HTTP Direct Downloads mirror.

**CentOS 8**

.. code-block:: sh

   $ sudo cat <<EOF > /etc/yum/repos.d/centos8.repo
   [centos8]
   name=centos8
   baseurl=http://mirror.centos.org/centos-8/8/BaseOS/x86_64/os/
   enabled=1
   EOF
   $ mkdir ${HOME}/centos8_bootstrap
   $ sudo yum install centos-release dnf @base --installroot=${HOME}/centos8_bootstrap

**Debian 10**

.. code-block:: sh

   $ mkdir debian10_bootstrap
   $ sudo debootstrap --arch amd64 buster ./debian10_bootstrap/ https://deb.debian.org/debian/

**Fedora 31**

.. code-block:: sh

   $ mkdir ${HOME}/fedora31_bootstrap
   $ sudo dnf install --installroot=${HOME}/fedora31_bootstrap --releasever=31 --nogpgcheck fedora-release
   $ sudo dnf groupinstall --installroot=${HOME}/fedora31_bootstrap --releasever=31 --nogpgcheck minimal-environment

**RHEL 8**

.. code-block:: sh

   $ sudo mount rhel-8.0-x86_64-dvd.iso /mnt
   $ sudo cat <<EOF > /etc/yum/repos.d/rhel8.repo
   [rhel8]
   name=rhel8
   baseurl=file:///mnt/
   enabled=1
   EOF
   $ sudo yum clean all
   $ mkdir ${HOME}/rhel8_bootstrap
   $ sudo yum groupinstall base --installroot=${HOME}/rhel8_bootstrap

**Ubuntu 20.04**

.. code-block:: sh

   $ mkdir ubuntu2004_bootstrap
   $ sudo debootstrap --no-check-gpg --arch amd64 focal ./ubuntu2004_bootstrap/ http://archive.ubuntu.com/ubuntu

[12]

Copy Images
~~~~~~~~~~~

Save a container image as a tarball.

-  Local image [34]:

   -  Docker archive format:

      .. code-block:: sh

         $ [docker|podman] save <CONTAINER_IMAGE>:<CONTAINER_TAG> --output <FILE>.tar

      .. code-block:: sh

         $ skopeo copy containers-storage:<CONTAINER_IMAGE>:<CONTAINER_TAG> docker-archive:<FILE>.tar

   -  OCI archive format:

      .. code-block:: sh

         $ [docker|podman] save <CONTAINER_IMAGE>:<CONTAINER_TAG> --format oci-archive --output <FILE>.tar

      .. code-block:: sh

         $ skopeo copy containers-storage:<CONTAINER_IMAGE>:<CONTAINER_TAG> oci-archive:<FILE>.tar

-  Remote image [35]:

   -  Docker archive format:

      .. code-block:: sh

         $ [docker|podman] pull <CONTAINER_REGISTRY_DOMAIN>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_IMAGE>:<CONTAINER:TAG>
         $ [docker|podman] save <CONTAINER_IMAGE>:<CONTAINER_TAG> --output <FILE>.tar

      .. code-block:: sh

         $ skopeo copy docker://<CONTAINER_REGISTRY_DOMAIN>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_IMAGE>:<CONTAINER_TAG> docker-archive:<FILE>.tar

   -  OCI archive format:

      .. code-block:: sh

         $ [docker|podman] pull <CONTAINER_REGISTRY_DOMAIN>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_IMAGE>:<CONTAINER:TAG>
         $ [docker|podman] save <CONTAINER_IMAGE>:<CONTAINER_TAG> --format oci-archive --output <FILE>.tar

      .. code-block:: sh

         $ skopeo copy docker://<CONTAINER_REGISTRY_DOMAIN>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_IMAGE>:<CONTAINER_TAG> oci-archive:<FILE>.tar

Registries
----------

A container registry stores Open Container Initiative (OCI) formatted images. These can universally be used across any modern cloud-native platform.

Here are a list of different container registries that exist [22]:

-  Amazon Elastic Container Registry (ECR)
-  Docker Hub
-  Docker Trusted Registry (DTR)
-  Harbor
-  JFrog Artifactory
-  Nexus Repository
-  Pulp Container Registry
-  Quay

By default, the ``docker`` command manages container images on the `Docker Hub <https://hub.docker.com/>`__ registry.

.. code-block:: sh

   $ docker login
   $ docker push <NAMESPACE_NAME>/<CONTAINER_NAME>:<TAG>

Other registries can also be used by specifying the fully qualified domain name of the registry.

.. code-block:: sh

   $ docker login <REGISTRY>
   $ docker push <REGISTRY>/<NAMESPACE_NAME>/<CONTAINER_NAME>:<TAG>

Registries:

-  registry.redhat.io = Red Hat customer.
-  quay.io = Red Hat Quay.

It may be required to first create a new image with a name of the alternative registry.

.. code-block:: sh

   $ docker tag <CONTAINER_IMAGE_ID> <REGISTRY>/<NAMESPACE_NAME>/<CONTAINER_NAME>:<TAG>
   $ docker push <REGISTRY>/<NAMESPACE_NAME>/<CONTAINER_NAME>:<TAG>

[21]

Insecure
~~~~~~~~

The docker daemon strictly enforces verified certificates. If a certificate for a container registry cannot be validated, then the docker client will refuse to connect to it. These are workarounds for connecting to registries with untrusted and/or broken certificates.

**Add a Certificate Authority**

Create a directory in ``/etc/docker/certs.d/`` or ``~/.docker/certs.d/`` named ``<REGISTRY_DOMAIN_OR_IP>:<REGISTRY_PORT>``. Place the certificate authority certificate and public key there. Normally a "ca.crt" file would contain both of those but may also be provided separately as "ca.cert" and "ca.key" files. On Linux, a restart of the docker daemon is not required. [23]

On macOS, local certificates will be synced to from ``~/.docker/certs.d/`` to ``/etc/docker/certs.d/`` in the back-end virtual machine after restarting the Docker Desktop app. [24]

.. code-block:: sh

   $ osascript -e 'quit app Docker'
   $ open -a Docker

**Ignore Certificates**

If a certificate has a common name of something other than the domain or IP address of the container registry then it will not work. In this case, the certificate should be ignored entirely by being listed as an insecure registry. This can also be used as an alternative to providing a certificate authority.

Edit the docker daemon configuration file and add a list of registries to ignore invalid or self-signed certificates.

-  Linux: ``/etc/docker/daemon.json``
-  macOS: ``~/.docker/daemon.json`` or navigate to Docker Desktop > Preferences > Docker Engine.

.. code-block:: json

   {
     "insecure-registries": [
       "<REGISTRY_1_DOMAIN_OR_IP>:<REGISTRY_1_PORT>",
       "<REGISTRY_2_DOMAIN_OR_IP>:<REGISTRY_2_PORT>"
     ]
   }

Restart the docker daemon:

-  Linux:

   .. code-block:: sh

      $ sudo systemctl restart docker

-  macOS:

   .. code-block:: sh

      $ osascript -e 'quit app Docker'
      $ open -a Docker

Container Runtimes
------------------

Container runtimes handle launching, stopping, and removing containers. Typically a container runtime will be used as a library for implementing a CRI and optionally a Container Engine on-top of the CRI. End-users do not need to interact directly with a container runtime. [13]

An OCI compliant container runtime reads metadata about a container from a config.json file. This describes everything about the container. It will then handle overlay mounts, creating cgroups for process isolation, configuring AppArmor or SELinux, and starting the container process. [20]

runC and crun
~~~~~~~~~~~~~

runC was originally developed by Docker as one of the first modern container runtimes and is written in Go. crun is developed by Red Hat as a re-implementation of runC in the C programming language. It is twice as fast as runC. [14] Legacy container runtimes that are no longer maintained include railcar and rkt. Both runC and crun follow the Open Container Initiative (OCI) for providing a standardized container runtime. [13]

Container Runtime Interfaces (CRIs)
-----------------------------------

CRIs are wrappers around container runtimes that provide a standard API for Kubernetes and other container management platforms to interact with. [13]

containerd (docker)
~~~~~~~~~~~~~~~~~~~

containerd is a cross-platform (Linux and Windows) CRI built on-top of runC. It is what the Docker Engine uses in the back-end. [15]

Installation
^^^^^^^^^^^^

Supported operating systems:

-  CentOS/RHEL >= 7
-  Debian >= 9
-  Ubuntu >= 16.04
-  Windows

Debian and Ubuntu:

-  Install the required dependencies:

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common

-  Add the repository and its GPG key.

   .. code-block:: sh

      $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | awk '{print tolower($0)}') $(lsb_release -cs) stable"
      $ curl -fsSL https://download.docker.com/linux/$(lsb_release -is | awk '{print tolower($0)}')/gpg | sudo apt-key --keyring /etc/apt/trusted.gpg.d/docker.gpg add -

-  Install containerd.

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install containerd.io

-  Pick to either use containerd by itself or the Docker Engine.

   -  containerd:

      -  Create default configuration file and restart containerd to reload the new configuration file.

         .. code-block:: sh

            $ sudo mkdir -p /etc/containerd
            $ containerd config default | sudo tee /etc/containerd/config.toml
            $ sudo systemctl restart containerd

   -  Docker Engine:

      -  Install the Docker Engine.

         .. code-block:: sh

            $ sudo apt-get install docker-ce docker-ce-cli

      -  Configure it.

         .. code-block:: sh

            $ cat <<EOF | sudo tee /etc/docker/daemon.json
            {
              "exec-opts": ["native.cgroupdriver=systemd"],
              "log-driver": "json-file",
              "log-opts": {
                "max-size": "100m"
              },
              "storage-driver": "overlay2"
            }
            EOF
            $ sudo mkdir -p /etc/systemd/system/docker.service.d
            $ sudo systemctl daemon-reload

      -  Restart it to load the new configuration. Also ensure it will start on boot.

         .. code-block:: sh

            $ sudo systemctl restart docker
            $ sudo systemctl enable docker

[16]

Usage
^^^^^

Use ``crictl`` to manage containers that are running using the ``containerd`` or ``docker`` daemon (default). The command uses the same arguments as the ``docker`` CLI tool except it also has the ability to view Kubernetes pods via ``crictl pods``.

There are three main ways to define which daemon to interact with. Use one of the three.

1.  Use the ``/etc/crictl.yaml`` configuration file.

   -  containerd:

      .. code-block:: yaml

         ---
         runtime-endpoint: unix:///var/run/containerd.sock
         image-endpoint: unix:///var/run/containerd.sock
         timeout: 5
         debug: false

   -  docker:

      .. code-block:: yaml

         ---
         runtime-endpoint: unix:///var/run/dockershim.sock
         image-endpoint: unix:///var/run/dockershim.sock
         timeout: 5
         debug: false

2.  Use CLI arguments.

   -  containerd: ``$ sudo crictl --runtime-endpoint=/var/run/containerd/containerd.sock --image-endpoint=/var/run/containerd/containerd.sock``
   -  docker: ``$ sudo crictl --runtime-endpoint=/var/run/dockershim.sock --image-endpoint=/var/run/dockershim.sock``

3.  Use environment variables.

   -  containerd:

      .. code-block:: sh

         $ export CONTAINER_RUNTIME_ENDPOINT="/var/run/containerd/containerd.sock"
         $ export IMAGE_SERVICE_ENDPOINT="${CONTAINER_RUNTIME_ENDPOINT}"
         $ sudo -E crictl

   -  docker:

      .. code-block:: sh

         $ export CONTAINER_RUNTIME_ENDPOINT="/var/run/containerd/containerd.sock"
         $ export IMAGE_SERVICE_ENDPOINT="${CONTAINER_RUNTIME_ENDPOINT}"
         $ sudo -E crictl

[25]

CRI-O
~~~~~

CRI-O is a lightweight CRI created by Red Hat and is specifically for Kubernetes only. It supports both runC (cgroups v1) and crun (cgroups v2). [17] In OpenShift 4, CRI-O is the default CRI. [18]

Installation
^^^^^^^^^^^^

Supported operating systems:

-  CentOS >= 7
-  Debian Testing or Unstable (currently Debian 11)
-  Fedora
-  openSUSE Tumbleweed
-  Ubuntu >= 18.04

Debian and Ubuntu:

-  Install the required dependencies:

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common

-  Add the CRI-O repository and its GPG key.

   .. code-block:: sh

      $ export OS="xUbuntu_20.04" # Or use "Debian_Testing" for Debian.
      $ cat <<EOF | sudo -E tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
      deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /
      EOF
      $ cat <<EOF | sudo -E tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
      deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /
      EOF
      $ curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
      $ curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers-cri-o.gpg add -

-  Install CRI-O and start the service.

   .. code-block:: sh

      $ sudo apt-get update
      $ sudo apt-get install cri-o cri-o-runc
      $ sudo systemctl daemon-reload
      $ sudo systemctl start crio

[16]

Container Engines
-----------------

A Container Engine provides a set of tools for end-users to interact with and manage containers. [13]

Docker Engine
~~~~~~~~~~~~~

The Docker Engine provides a single binary ``docker`` that can build and run containers as well as manage image repositories. It uses the CRI containerd which uses the container runtime runC. Legacy versions of the Docker Engine relied on the LXC kernel module.

A command is ran to start a daemon in the container. As long as that process is still running in the foreground, the container will remain active. Some processes may spawn in the background. A workaround for this is to append ``&& tail -f /dev/null`` to the command. If the daemon successfully starts, then a never-ending task can be run instead (such as viewing the never ending file of /dev/null). [1]

By default, only the "root" user has access to manage docker containers. Users assigned to a "docker" group will have the necessary privileges. However, they will then have administrator access to the system. If the "docker" group is newly created then the daemon needs to be restarted for the change to load up. The docker user may also have to run the ``newgrp docker`` command to reload their groups. [2]

.. code-block:: sh

    $ sudo groupadd docker
    $ sudo usermod -a -G docker <USER>
    $ sudo systemctl restart docker

Dockerfile (Containerfile)
^^^^^^^^^^^^^^^^^^^^^^^^^^

docker containers are built by using a template called ``Dockerfile``. This file contains a set of instructions on how to build and handle the container when it is started.

Podman is a drop-in replacement for docker and can use a ``Dockerfile`` but prefers the generic ``Containerfile`` name instead. However, docker does not support ``Containerfile`` by default. Use the command ``docker bulid -f Containerfile .`` to specify a different container file name.

**Containerfile Instructions**

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

-  ONBUILD <INSTRUCTION> <ARGS> = Define instructions to only execute during the build process. This is specific to docker and by default does not apply to images being built with OCI tools such as Buildah.
-  RUN = A command that can be ran once in the container. Use the ``CMD <COMMAND> <ARG1> <ARG2>`` format to open a shell or ``CMD ['<COMMAND>', '<ARG1>', '<ARG2>']`` to execute without a shell.
-  USER <UID>:<GID> = Configure a UID and/or GID to run the container as. After this instruction is defined, all ``CMD``, ``ENTRYPOINT``, and ``RUN`` commands use this specified user.
-  VOLUME <PATH> = A list of paths inside the container that can mount to an external persistent storagedevice (for example, for storing a database).
-  WORKDIR = The working directory where commands will be executed from.

[9]

**OpenShift Instructions**

Some instructions in the Containerfile have special uses in regards to OpenShift.

-  LABEL

   -  io.openshift.tags = A comma-separated list of keywords that help categorize the usage of the image.
   -  io.k8s.description = A detailed description of what the container image does.
   -  io.openshift.expose-services = Syntax is ``<PORT>/<PROTOCOL>:<NAME>``. A description of the ports defined via ``EXPOSE``.

-  USER = This value is ignored on OpenShift as a random UID will be used instead.

**Storage Space**

Containers should be ephemeral where the persistent data is stored in an external location (volume) and/or a database. Almost every Containerfile operation creates a writable/container layer ontop of the previous layer. Each layer created with ``ADD``, ``COPY``, and ``RUN`` takes up more space.

Lower space usage by [10]:

-  Using a small image such as `alpine <https://hub.docker.com/_/alpine>`__.
-  Combining all ``RUN`` commands into one statement. Chain them together with ``&&`` to ensure that each command succeeds before moving onto the next one.
-  Cleaning package manager cache (if applicable).

   -  Debian: ``RUN apt-get clean``
   -  Fedora:  ``RUN dnf clean all``

-  Using the `docker image build --squash <https://docs.docker.com/engine/reference/commandline/image_build/>`__  or `buildah bud --squash <https://github.com/containers/buildah/blob/master/docs/buildah-bud.md>`__ command to consolidate all additional layers when creating a new image. Use `docker-squash <https://github.com/goldmann/docker-squash>`__ to consolidate an existing image.

A Containerfile cannot ``ADD`` or ``COPY`` directories above where the ``docker build`` command is being run from. Only that directory and sub-directories can be used. Use ``docker build -f <CONTAINERFILE>`` to use a Containerfile from a different directory and also use the current working directory for copying files from. [11]

File Creation
'''''''''''''

Use the ``RUN`` instruction with ``echo`` to create a  file.

::

   RUN echo -e "[gh-cli]\n\
   name=packages for the GitHub CLI\n\
   baseurl=https://cli.github.com/packages/rpm\n\
   enabled=1\n\
   gpgkey=https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x23F3D4EA75716059" > /etc/yum.repos.d/gh-cli.repo

Use the ``COPY`` instruction to copy one or more files from the same directory that the ``Containerfile`` is in to a directory inside of the container.

::

   COPY foobar1.conf foobar2.conf /etc/foobar/

Use ``COPY`` to copy all of the files in a directory into a container.

::

  COPY rootfs/var/lib/foobar/ /var/lib/foobar/

Networking
^^^^^^^^^^

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
^^^^

Java <= 9, by default, will try to allocate a large amount of memory for the runtime and garbage collection. This can lead to resource exhaustion of RAM on a hypervisor. The maximum memory allocation should be specified to Java applications using ``-Xmx<SIZE_IN_MB>m``. [7] This is no longer an issue in Java >= 10 as it is now aware of when it is being containerized. [8]

Example Java <=9 usage in a docker compose file that utilizes an environment variable:

::

   CMD java -XX:+PrintFlagsFinal $JAVA_OPTS -jar app.jar

Multi-Architecture Support
^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``docker buildx build`` command can be used as a replacement for ``docker build`` to create a container image based on the CPU architecture of the running host. In the ``Containerfile``, the ``ARCH`` argument needs to be set to an empty value. [31]

::

   ARG ARCH=
   FROM ${ARCH}ubuntu:latest

Container Tools (buildah, podman, and skopeo)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduction
^^^^^^^^^^^^

The `Container Tools project <https://github.com/containers>`__ bundles a set of fully-featured programs to replicate the functionality of the ``docker`` command using the OCI standard. [19] No daemon or CRI is used and instead the tools communicate directly with crun or runC. The `podman codebase <https://github.com/containers/podman>`__ (previously known as libpod) is shared between the Container Tools and CRI-O projects. However, the two projects are not able to manage containers created from the other.

Container Tools:

-  ``buildah`` = Build container images.
-  ``podman`` = Run containers. Designed as a drop-in CLI replacement for ``docker``. It has a focus on adding additional functional to replicate the Pod API from Kubernetes. Containers will run as a non-privileged user by default.
-  ``skopeo`` = Manage container image registries.


Podman
^^^^^^

Reset
'''''

Reset all Podman configurations and delete all containers.

.. code-block:: sh

   $ podman system reset

If that command fails, manually delete everything. [33]

.. code-block:: sh

   $ sudo rm -r -f  ~/.local/share/containers/ ~/.config/containers/

LXC
~~~

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

Wrappers
--------

Introduction
~~~~~~~~~~~~

Wrappers provide a layer of abstraction over container engines to make them easier to use.

Distrobox
~~~~~~~~~

Distrobox fully supports CLI and GUI applications (including audio), USB devices, and sharing storage devices. It can use the ``docker`` or ``podman`` container engine.

Installation:

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S distrobox

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install distrobox

-  Ubuntu (not Debian):

   .. code-block:: sh

      $ sudo apt-get install distrobox

-  Other Linux distributions:

   .. code-block:: sh

      $ curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

   -  Uninstall:

      .. code-block:: sh

         $ curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/uninstall | sudo sh

-  Non-root installation [32]:

   .. code-block:: sh

      $ curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local
      $ sudo touch /etc/subuid /etc/subgid
      $ sudo usermod --add-subuid 100000-165535 --add-subgid 100000-165535 $USER
      $ export PODMAN_LAUNCHER_VERSION="0.0.3"
      $ curl --location --output ~/.local/bin/podman https://github.com/89luca89/podman-launcher/releases/download/v${PODMAN_LAUNCHER_VERSION}/podman-launcher-amd64
      $ chmod +x ~/.local/bin/podman

   -  Uninstall:

      .. code-block:: sh

         $ curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/uninstall | sh -s -- --prefix ~/.local
         $ rm ~/.local/bin/podman

Ensure that the local user can control the Xorg server:

.. code-block:: sh

   $ xhost +si:localuser:$USER
   $ echo "xhost +si:localuser:$USER" >> ~/.xinitrc

Create a new container with a container image:

-  Arch Linux:

   .. code-block:: sh

      $ distrobox create --pull --image archlinux:latest --name archlinux

-  Debian:

   .. code-block:: sh

      $ distrobox create --image debian:12 --name debian-12

-  Fedora Toolbox:

   .. code-block:: sh

      $ distrobox create --image registry.fedoraproject.org/fedora-toolbox:38 --name fedora-toolbox-38

Create a container (optionally with additional features):

-  Create a basic container. By default, this will use the latest stable fedora-toolbox container.

   .. code-block:: sh

      $ distrobox create <CONTAINER_NAME>

-  Create a container with NVIDIA support (requires Distrobox >= 1.5.0):

   .. code-block:: sh

      $ distrobox --version
      $ distrobox create --nvidia --image <CONTAINER_IMAGE>:<CONTAINER_TAG> <CONTAINER_NAME>

-  Create a container with ``root`` access to the host operating system:

   .. code-block:: sh

      $ distrobox create --root --image <CONTAINER_IMAGE>:<CONTAINER_TAG> <CONTAINER_NAME>

-  Create a container with a volume from the host mounted in (by default, only ``/home/$USER/`` is mounted):

   .. code-block:: sh

      $ distrobox create --volume /media --image <CONTAINER_IMAGE>:<CONTAINER_TAG> <CONTAINER_NAME>

-  Create a container with systemd support (requires a container image with systemd installed, Distrobox >= 1.5.0 can install it during the initialization stage):

   .. code-block:: sh

      $ distrobox create --init --image docker.io/almalinux/9-init alamalinux-9-init

   .. code-block:: sh

      $ distrobox create --init --additional-packages "systemd" --image debian:12 debian-12-init

Enter the container. This will automatically run ``distrobox-init`` inside the container which installs required dependencies (such as ``sudo``), creates a user account that mirros that name and ID of the host user, manages mounts, sets up audio and graphics integration, and more [27]:

.. code-block:: sh

   $ distrobox enter <CONTAINER_NAME>

Alternatively, enter a ``root`` container. If a container was not created with ``--root``, this will not work.

.. code-block:: sh

   $ distrobox enter --root <CONTAINER_NAME>

List all containers managed by Distrobox:

.. code-block:: sh

   $ distrobox list

Delete a Distrobox container:

.. code-block:: sh

   $ distrobox stop <CONTAINER_NAME>
   $ distrobox rm <CONTAINER_NAME>

[28][29][30]

Toolbox
~~~~~~~

Fedora Silverblue is the only Linux distribution that uses Toolbox containers. It provides a way to install both CLI and GUI applications inside of a container as to not affect the read-only file system. It also provides additional features such as mounting the user's home directory, full access to ``/dev`` devices, networking passthrough, systemd support, and more.

Requirements to create a Toolbox container [26]:

-  Environment variables ``NAME`` and ``VERSION`` defined.
-  Labels of ``com.github.containers.toolbox="true"``, ``name="$NAME"``, and ``version="$VERSION"``.
-  ``bash`` and ``sudo`` binaries are installed.
-  ``sudo`` is configured to allow the ``toolbox`` user to run privileged commands without the use of a password.

   -  ``echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox``

-  Default command is ``bash``.

Troubleshooting
---------------

Errors
~~~~~~

Error when pulling a container image from a Harbor container registry proxy-cache project:

.. code-block:: sh

   $ docker pull <HARBOR_ADDRESS>/<HARBOR_PROJECT_NAME>/<DOCKER_HUB_PROJECT_NAME>/<DOCKER_HUB_CONTAINER_NAME>
   Using default tag: latest
   Error response from daemon: unknown: artifact docker-hub-proxy-cache/mysql/mysql-router@sha256:66d5955bbf926b9ab35df6e199aa434c89c96a2b8c5a47531cf011d67b4b37f0 not found

Solution:

-  View the ``harbor-core`` logs. The repository may be temporarily blocked by Docker Hub API rate limiting. Wait at least two hours before trying to pull the image again.

   ::

      2021-04-22T06:17:47Z [WARNING] [/server/middleware/repoproxy/proxy.go:139]: Artifact: <HARBOR_PROJECT_NAME>/<DOCKER_HUB_PROJECT_NAME>/<DOCKER_HUB_CONTAINER_NAME>:, digest:sha256:66d5955bbf926b9ab35df6e199aa434c89c96a2b8c5a47531cf011d67b4b37f0 is not found in proxy cache, fetch it from remote repo
      2021-04-22T06:17:47Z [DEBUG] [/server/middleware/repoproxy/proxy.go:141]: the tag is , digest is sha256:66d5955bbf926b9ab35df6e199aa434c89c96a2b8c5a47531cf011d67b4b37f0
      2021-04-22T06:17:47Z [WARNING] [/server/middleware/repoproxy/proxy.go:151]: Proxy to remote failed, fallback to local repo, error: http status code: 429, body: {
        "errors": [
          {
            "code": "TOOMANYREQUESTS",
            "message": "You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit"
          }
        ]
      }

----

"**Unable to fetch some archives**" when trying to build a container using Debian as the base image.

Solutions:

-  ``RUN apt-get update`` in the Containerfile before installing packages.
-  Use ``docker build --no-cache`` to not re-use old package repository cache.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization/containers.rst>`__
-  `< 2019.04.01 (Virtualization) <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/virtualization.rst>`__
-  `< 2019.01.01 (Virtualization) <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization.rst>`__
-  `< 2018.01.01 (Virtualization) <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/virtualization.md>`__

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
9. "Dockerfile reference." Docker Documentation. 2019. Accessed April 3, 2019. https://docs.docker.com/engine/reference/builder/
10. "Five Ways to Slim Docker Images." Codacy Blog. December 14, 2017. Accessed March 21, 2020. https://blog.codacy.com/five-ways-to-slim-your-docker-images/
11. "Best practices for writing Dockerfiles." Docker Documentation. Accessed March 21, 2020. https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
12. "How to Bootstrap different Linux Distribution Under Arch Linux." lukeluo.blogspot.com. September 6, 2015. Accessed May 30, 2020. http://lukeluo.blogspot.com/2015/09/how-to-bootstrap-different-linux.html
13. "A Comprehensive Container Runtime Comparison." Capital One Tech Cloud. June 10, 2020. Accessed November 22, 2020. https://www.capitalone.com/tech/cloud/container-runtime/
14. "containers/crun." GitHub. November 16, 2020. Accessed November 22, 2020. https://github.com/containers/crun
15. "containerd." containerd. 2020. Accessed November 22, 2020. https://containerd.io/
16. "Container runtimes." Kubernetes Documentation. October 28, 2020. Accessed November 22, 2020. https://kubernetes.io/docs/setup/production-environment/container-runtimes/
17. "cri-o." cri-o. Accessed November 22, 2020. https://cri-o.io/
18. "The OpenShift Container Platform control plane." OpenShift Container Platform 4.6 Documentation. Accessed November 22, 2020. https://docs.openshift.com/container-platform/4.6/architecture/control-plane.html
19. "podman." podman. November 13, 2020. Accessed November 22, 2020. https://podman.io/
20. "A Practical Introduction to Container Terminology." Red Hat Developer. February 22, 2018. Accessed November 22, 2020. https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/
21. "docker push." Docker Documentation. Accessed March 2, 2021. https://docs.docker.com/engine/reference/commandline/push/
22. "Episode 147: CoreDNS." GitHub vmware-tanzu/tgik. April 3, 2021. Accessed April 13, 2021. https://github.com/vmware-tanzu/tgik/tree/master/episodes/147
23. "Test an insecure registry." Docker Documentation. Accessed April 21, 2021. https://docs.docker.com/registry/insecure/
24. "Docker Desktop for Mac user manual." Docker Documentation. Accessed April 21, 2021. https://docs.docker.com/docker-for-mac/
25. "Debugging Kubernetes nodes with crictl." Kubernetes Documentation. December 10, 2020. Accessed July 20, 2021. https://kubernetes.io/docs/tasks/debug-application-cluster/crictl/
26. "Toolbox." ArchWiki. January 20, 2023. Accessed February 6, 2023. https://wiki.archlinux.org/title/Toolbox
27. "distrobox-init(1)." Arch manual page. Accessed June 27, 2023. https://man.archlinux.org/man/extra/distrobox/distrobox-init.1.en
28. "Distrobox." Arch Wiki. June 18, 2023. Accessed June 27, 2023. https://wiki.archlinux.org/title/Distrobox
29. "Distrobox." GitHub 89luca89/distrobox. June 25, 2023. Accessed June 27, 2023. https://github.com/89luca89/distrobox
30. "Useful tips." GitHub 89luca89/distrobox. June 15, 2023. Accessed June 27, 2023. https://github.com/89luca89/distrobox/blob/main/docs/useful_tips.md
31. "Multi-arch build and images, the simple way." Docker Blog. April 30, 2020. Accessed September 25, 2023. https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/
32. "Install Podman in a static manner." GitHub 89luca89/distrobox. September 20, 2023. Accessed October 26, 2023. https://github.com/89luca89/distrobox/blob/main/docs/posts/install_podman_static.md
33. "How to reset podman and buildah after experimenting as a non-root user?" Stack Overflow. October 19, 2021. Accessed May 16, 2024. https://stackoverflow.com/questions/56542220/how-to-reset-podman-and-buildah-after-experimenting-as-a-non-root-user
34. "docker image save." Docker Docs. Accessed May 22, 2024. https://docs.docker.com/reference/cli/docker/image/save/
35. "mkiso thread." Answer Overflow. October, 2023. Accessed May 22, 2024. https://www.answeroverflow.com/m/1156701086443393175
