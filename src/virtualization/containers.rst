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

**Dockerfile Instructions**

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
-  USER <UID>:<GID> = Configure a UID and/or GID to run the container as.
-  VOLUME <PATH> = A list of paths inside the container that can mount to an external persistent storagedevice (for example, for storing a database).
-  WORKDIR = The working directory where commands will be executed from.

[9]

**OpenShift Instructions**

Some instructions in the Dockerfile have special uses in regards to OpenShift.

-  LABEL

   -  io.openshift.tags = A comma-separated list of keywords that help categorize the usage of the image.
   -  io.k8s.description = A detailed description of what the container image does.
   -  io.openshift.expose-services = Syntax is ``<PORT>/<PROTOCOL>:<NAME>``. A description of the ports defined via ``EXPOSE``.

-  USER = This value is ignored on OpenShift as a random UID will be used instead.

**Storage Space**

Containers should be ephemeral where the persistent data is stored in an external location (volume) and/or a database. Almost every Dockerfile operation creates a writable/container layer ontop of the previous layer. Each layer takes up more space.

Lower space usage by [10]:

-  Using a small image such as `alpine <https://hub.docker.com/_/alpine>`__.
-  Combining all ``RUN`` commands into one statement. Chain them together with ``&&`` to ensure that each command succeeds before moving onto the next one.
-  Cleaning package manager cache (if applicable).
-  Using the `docker image build --squash <https://docs.docker.com/engine/reference/commandline/image_build/>`__  or `buildah bud --squash <https://github.com/containers/buildah/blob/master/docs/buildah-bud.md>`__ command to consolidate all additional layers when creating a new image. Use `docker-squash <https://github.com/goldmann/docker-squash>`__ to consolidate an existing image.

A Dockerfile cannot ``ADD`` or ``COPY`` directories above where the ``docker build`` command is being run from. Only that directory and sub-directories can be used. Use ``docker build -f <PATH_TO_DOCKERFILE>`` to use a Dockerfile from a different directory and also use the current working directory for copying files from. [11]

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
9. "Dockerfile reference." Docker Documentation. 2019. Accessed April 3, 2019. https://docs.docker.com/engine/reference/builder/
10. "Five Ways to Slim Docker Images." Codacy Blog. December 14, 2017. Accessed March 21, 2020. https://blog.codacy.com/five-ways-to-slim-your-docker-images/
11. "Best practices for writing Dockerfiles." Docker Documentation. Accessed March 21, 2020. https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
12. "How to Bootstrap different Linux Distribution Under Arch Linux." lukeluo.blogspot.com. September 6, 2015. Accessed May 30, 2020. http://lukeluo.blogspot.com/2015/09/how-to-bootstrap-different-linux.html
