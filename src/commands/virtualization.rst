Virtualization
==============

.. contents:: Table of Contents

See also: Administrative, Hardware, Networking, OpenStack

Containers
----------

buildah
~~~~~~~

Package: buildah

A utility used to build new container images as non-privileged users.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   images, show local container images
   containers, list all of the buildah containers
   from --name <NAME> <OS>:<TAG>, create a new container from the specified image on Docker Hub
   run <NAME> /bin/bash, open an interactive shell on the container
   rm, remove a container
   rmi, remove an image
   --format=docker, use the docker format instead of the default OCI format
   "{bud,build-using-dockerfile Dockerfile}", build an image from a Dockerfile; this mirrors the usage of `docker image build`
   bud -f <DOCKER_FILE> -t <IMAGE_NAME>:<TAG_NAME> ., "build a new image from a specified Dockerfile, give it a named tag, and save to the local directory"
   bud --squash, build an image and consolidate as many layers as possible
   push --tls-verify=false <IMAGE> docker://127.0.0.1:5000/<USER>/<IMAGE_NAME>:<TAG>, push the container image to a local private image registry (use the official docker ``registry`` image to run a local server)

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   bud -f Dockerfile -t fedora28-arm64-java ., build a new container from the Dockerfile

docker
~~~~~~

Package: docker

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "search", "look for available docker images online"
   "pull <OS>", "download the latest image for a specified OS"
   "pull <OS>:<VERSION>", "download a specified version"
   "images", "show downloaded images"
   "network", "manage networks"
   "network ls", "view all networks"
   "rmi", "remove image files"
   "rm", "delete a container"
   "ps", "list active containers"
   --format="{{json .}}", list the JSON output and also see which values can be used as part of a JSON query output
   ps --format "{{.Names}}", only show active container names
   "ps -a", "list all active and stopped containers"
   ps {-f|--filter} status={created|dead|exited|paused|removing|restarting|running}, filter containers by their current (docker supported) state
   ps -f ""status=exited"", show stopped containers
   "exec", "execute a single command in a specified container"
   "exec -it <CONTAINER_ID> bash", "open a Bash session in the container"
   "run --name <NAME> <IMAGE>", "start a container in the foreground and optionally give it a name"
   "run -d <IMAGE>", "start a container in the background"
   "run -d <IMAGE> tail -f /dev/null", "start a container and keep it running (by running a never-ending command)"
   "run --net=<NAME> --ip <IP_ADDRESS> -p <HYPERVISOR_PORT>:<CONTAINER_PORT>", "start a container using a specific network, assigning a static IP, and setup port forwarding"
   "run --mount type=bind,source=<DIR_ON_HYPERVISOR>,target=<DIR_IN_CONTAINER>", start a container with a bind mount to access the part of the hypervisor's file system
   "--volume <DIR_ON_HYPERVISOR>:<DIR_IN_CONTAINER>:z", mount a volume with SELinux labelling enabled
   "stop", "shutdown a container"
   "stop $(docker ps -aq)", "stop all containers"
   "logs", "view the standard output from a running docker container"
   logs -c <CONTAINER> <POD>, show the logs from a specific container
   logs -p <POD>, show the logs from the previously terminated container
   logs -f <POD>, tail the current standard output stream in real-time
   "{-v,--volume} <SOURCE>:<DESTINATION>", "bind mount a folder from the host node to a folder inside of the container for persistent storage"
   "{images|ps} {-q,--quiet,--quiet=true}", "list only IDs for images or running containers"
   "{-f,--force}", "force an action"
   "inspect", "view detailed information about a container"
   image build --squash <DOCKERFILE> <IMAGE_NAME>, build a container image from a Dockerfile and consolidate as many layers as possible
   image build -f <DOCKERFILE>, build an image using a Dockerfile in a different directory (the current working directory will be used by the build instead of where the Dockerfile is located)
   "network create --subnet <CIDR> <NETWORK_NAME>", "create a new docker network using a specific network CIDR and name"
   cp <SRC> <CONTAINER>:<DEST>, copy a file or directory from the hypervisor to a container
   login <REGISTRY>, log into a container registry
   logout <REGISTRY>, log out of a container registry

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro unop/fedora-systemd:28 /usr/lib/systemd/systemd", "start a docker container with systemd support (requires systemd to be installed into the image)"
   "run -v /var/run/docker.sock:/var/run/docker.sock ---cap-add=SYS_ADMIN", start a container with support to run nested docker containers
   "run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock --privileged --name fedora28systemd -d unop/fedora-systemd:28 /usr/sbin/init", run a container with systemd and docker support

etcdctl
~~~~~~~

Manage a ``etcd`` key-value store database (commonly used in Kubernetes).

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   get <KEY>, view the value of a key
   get / --prefix --keys-only, view the top-level keys
   set <KEY> <VALUE>, create a new key-value pair

kubeadm
~~~~~~~

Manage Kubernetes infrastructure.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   init --pod-network-cidr <CIDR>, create a new Kubernetes cluster with a valid network CIDR to allow pod network add-ons to be installed
   token create, create a new temporary token that will expire in 24 hours
   token list, list all active and expired tokens

kubectl
~~~~~~~

Package: kubernetes-client

Manage Kubernetes resources via the API.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -o name, print out only the name
   -o wide, print out all of the information
   -o {json|yaml}, print out the JSON or YAML configuration
   --v=<VERBOSITY>, set the command verbosity from 0-9
   version, show the Kubernetes client and server version
   version --client, only show the Kubernetes client version
   api-resources, "show all of the APIs along with their shortnames, API group, kind, and if it is namespaced"
   api-resources --api-group <GROUP>, only show APIs belonging to a specific API group
   "api-resources --api-group """, show the core APIs
   api-resources --namespaced={true|false}, show APIs that do (or do not) support being namespaced
   api-resources --verb={create|delete|deletecollection|get|list|patch|update|watch}, show APIs that support the ``kubectl <VERB>``
   explain --recursive <API>, explain all of the options for creating an object from that API
   explain <API>.spec, show all of the top-level spec options for the API
   edit <API> <OBJECT>, edit an existing object's YAML manifest
   "cluster-info", "show the clustered services and their status"
   "get nodes", "show all of the Nodes in the Kubernetes cluster"
   "run <POD_NAME> --image=<PATH_TO_IMAGE>:<VERSION> --port=<PORT>", "create a container from the specific version of the image, listening on the specified port, and give it the specified name"
   "get <RESOURCE_API>", show all of the objects created using a specific API
   get <API> -w, watch/refresh the output of getting all objects from an API
   get <API> --show-kind, show the kind of each object
   get <API> --show-labels, show all of the labels for each object
   "{annotate,label} <API> <OBJECT> <KEY>=<VALUE>", add an annotation or label to an existing object
   "{annotate,label} <API> <OBJECT> <KEY>-", remove an annotation or label key-value pair
   drain <NODE>, remove all objects from the Node; this will also cordon the Node
   cordon <NODE>, prevent new objects from being created on this Node
   uncordon <NODE>, allow new objects to be created on this Node again
   "describe pods <POD>", describe the settings for a specific pod
   "delete pods <POD>", "delete a pod"
   delete pod <POD> --wait=0, start the deletion of a Pod and then return to the command prompt
   "proxy", "create a proxy from your hypervisor to be able to access the private network that the containers share"
   "attach <NAME> -i", "attach to a already running container"
   logs <POD> <CONTAINER>, show logs for a specific container
   exec <POD> -- <COMMAND>, run a command on all containers in a pod
   exec <POD> -c <CONTAINER> -- <COMMAND>, run a command on a specific container in a pod
   exec -it <POD> -- /bin/bash, enter into a pod with an interactive Bash shell
   port-forward <POD> <LOCAL_PORT>:<POD_PORT>, create a port forward on the 127.0.0.1 localhost to help with debugging network services
   port-forward --address 0.0.0.0 <POD> <LOCAL_PORT>:<POD_PORT>, create a port forward that listens on all IP addresses
   get <API> [--all-namespaces|-A], show all objects created from the specified API
   get <API> --show-labels, show all labels in use
   get <API> [--selector|-l] "<KEY>=<VALUE>", lookup all objects with the specified label
   get all --all-namespaces, show every object on the Kubernetes cluster
   get <API> --sort-by=.metadata.name, list resources by name
   get <API> --sort-by=.metadata.creationTimestamp, list resources by creation date and time
   delete <API> <OBJECT>, delete an object
   delete <API> --all, delete all objects from a specific API
   apply -f <FILE_DIR_OR_URL>, apply a declarative configuration file
   diff -f <FILE_DIR_OR_URL>, show the difference between the live object configuration and the specified object configuration
   "scale {deploy,rs,sc,sts} <OBJECT> --replicas=<REPLICAS>", change the amount of replicas
   "rollout {history,pause,restart,resume,status,undo} {deploy,ds,sts} <OBJECT>", view or change a deployment rollout
   taint node <NODE> <KEY>=<VALUE>:<EFFECT>, add a taint to a Node
   taint nodes -l <LABEL_KEY>=<LABEL_VALUE> <TAINT_KEY>=<TAINT_VALUE>:<EFFECT>, add a taint to Nodes that have the specified label
   create secret docker-registry <SECRET_NAME> --docker-server=<DOCKER_SERVER>> --docker-username=<DOCKER_USER> --docker-password=<DOCKER_PASSWORD> --docker-email=<DOCKER_EMAIL>, create a Secret with registry login information
   create secret generic <SECRET_NAME> --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=<path/to/.docker/config.json, create a Secret with registry login information from an existing configuration file

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "run -i --tty <NAME> --image=<IMAGE_NAME>:<IMAGE_VERSION> --restart=Never /bin/sh", "start a Pod with a single container and enter into it via a Bash shell"
   run <POD_NAME> --restart=Never --rm -it -- <COMMAND> <ARG1>, run a container once and then delete it

minikube
~~~~~~~~

Package: None

Deploy an all-in-one Kubernetes cluster.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "start", "deploy a Kubernetes cluster (by default as a virtual machine)"
   start --kubernetes-version=latest, start or upgrade to the latest version
   start --kubernetes-version=<VERSION, start or upgrade to the specified version
   start -p <NAME>, start a separate Kubernetes cluster
   stop, stop the virtual machine
   delete, delete the virtual machine
   delete --all, delete all Minikube-managed virtual machines
   ssh, log into the virtual machine
   dashboard, open the Kubernetes dashboard
   dashboard --url, provide the URL to the Kubernetes dashboard
   kubectl -- <ARGS>, run `kubectl` commands
   service --url <SERVICE_NAME>, provide the URL to access the specified Kubernetes Service object
   tunnel, create a network tunnel to the virtual machine to access internal IPs
   tunnel --cleanup, remove old routes

oc
~~

Package: origin-clients (upstream)

Create and manage OpenShift clusters. Many arguments are inherited from ``kubectl``. Unique OpenShift arguments are documented below.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "cluster up", "spin up OpenShift Origin"
   "cluster up --public-hostname <IP>", "specify the IP to bind to for OpenShift Origin"
   "cluster down", "remove OpenShift Origin"
   new-project, create a new Project object
   new-app --docker-image=<IMAGE>, create a new Pod using an existing container image
   new-app <GIT_URL>#docker-build --context-dir <DOCKERFILE_DIRECTORY>, build a container image from a git repository using the ``Dockerfile`` found in the specified context directory and then create a Pod using that new image
   rsh <POD> <COMMAND>, run a command inside of a Pod
   rsh -t <POD>, open an interactive shell inside of a Pod
   process -f <TEMPLATE_MANIFEST>, show all of the objects that would be created from the Template
   process --parameters -f <TEMPLATE_MANIFEST>, show all of the parameters that can be set in a Template
   process -p <KEY>=<VALUE> -f <TEMPLATE_MANIFEST>, use the specified parameter
   process --param-file=<PARAM_FILE> -f <TEMPLATE_MANIFEST>, use key-value pair parameters that are defined in a separate file
   export all, "display all objects from the following APIs: BuildConfig, Build, DeploymentConfig, ImageStream, Pod, ReplicaSet, Route, and Service"
   export all --as-template=<TEMPLATE_NAME> <TEMPLATE_MANIFEST_FILE>, export all objects as a Template manifest
   adm top [nodes|pods], show the current resource usage of all Nodes or Pods (equivalent to ``kubectl top``)
   adm node-logs -u [crio|kubelet] <NODE>, view the logs of a systemd service such as CRI-O or Kubelet logs on a specified Node
   debug [node|pod]/<NAME>, attach to a running Node or Pod by using a side-car container using the EL operating system; use ``chroot /host`` to access the file system
   project <PROJECT>, change the current Project/Namespace context
   status, view the status of all objects within a Project/Namespace

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   oc process -p foo=bar -f example_template.yaml | oc create -f -, process a Template with a parameter and then create all of the objects from it

podman
~~~~~~

Package: podman

The libpod library provides a utility to manage and run containers with CRI-O and not the docker deamon. It provides all of the same arguments and syntax as the docker command (except for Docker Swarm administration) along with additional capabilities to launch standalone Kubernetes pods.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   ls, list running containers
   create --name <NAME> <IMAGE>:<TAG>, create a container from an image and give it a name
   start <NAME>, start a container
   start {-i|--interactive} <NAME>, start a container and attach to the stdin
   run --name <NAME> --interactive <IMAGE>:<TAG>, start a container and open an interactive shell inside of it
   attach <NAME>, watch the stdout and stderr of a container process
   ps {-f|--filter} status={configured|created|exited|paused|running|stopped|unknown}, filter containers by their current (podman supported) state; note that configured==created and stopped==exited are mapped for compatibility with docker
   rm --all, Remove all stopped containers
   rmi --all, Remove all images
   --tls-verify=false, Disable TLS verification (allow HTTP and insecure HTTPS traffic from registries
   logout --all, logout of all container registires
   system reset, "delete all build cache, containers, images, and pods; this is an alias for `podman unshare rm -rf ~/.local/share/container ~/.config/containers`"

oVirt
-----

hosted-engine
~~~~~~~~~~~~~

This manages the oVirt Engine virtual machine.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--help", "Show the available arguments."
   "<ARGUMENT> --help", "Show additional help information about a specific argument."
   "--console", "Attach to the text console of the virtual machine for troubleshooting."
   "--vm-start", "Start the virtual machine."
   "--vm-status", "View the status of the virtual machine."
   "--vm-{shutdown|poweroff}", "Gracefully shutdown the virtual machine or force it to be powered off immediately."

QEMU
----

guestfish
~~~~~~~~~

Package: libguestfs-tools-c

Modify local virtual machine images.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -a, specify the image to modify
   --ro, mount the image as read-only
   --rw, mount the image as writable
   -i , automatically mount partitions
   --cmd-help, view guestfish commands that can be ran
   <COMMAND>, run a command inside of the image

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

    -a rhel76.img --ro -i cat /etc/machine-id, mount the rhel76 image as read-only and then view the contents of the machine-id file

qemu-img
~~~~~~~~

Package: qemu-img

Create and convert virtual machine images.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "convert -f vmdk vmawre_image.vmdk -O qcow2 kvm_image.qcow2", "convert a VMDK image to qcow2; valid options for -f/-O include raw, vmdk (VMWare), vpc (Hyper-V [vhd]), vdi (VirtualBox), qed (KVM) qcow2 (KVM, Xen)"
   "create -f qcow2 example.qcow2 8G", "create an 8GB virtual machine image called 'example.qcow2'"
   "resize <IMAGENAME> +10G", "increase an image to be 10GB larger"
   "info", "show information about an image"
   "create -f raw rbd:<POOL>/<IMAGE> <SIZE>G", "create a raw RBD image using Ceph"
   "convert -f qcow2 -O raw <QCOW2_IMAGE> rbd:<POOL>/<IMAGE>", "upload a file to Ceph, while converting it into a raw format"
   "-o preallocation=metadata", "this provides the best performance for QCOW2 images without fully allocating all of the space"
   "-o preallocation=full", "the same as metadata except that all zeros (empty space) are actually written to the file system"
   create -f qcow2 -b <ORIGINAL>.qcow2 <SNAPSHOT>.qcow2, "use -b to create a snapshot/backup image (use the snapshot image for the virtual machine now, it will contain the new writes)"
   "-p", "show a live progress bar"

virsh
~~~~~

Package: libvirt-client

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "autostart", "set VM for automatic boot"
   "autostart <VM_NAME> --disable", "disable automatic boot"
   "console", "console directly into a VM"
   "list --all", "shows all VMs"
   "create", "temporarily start a VM from an XML configuration file"
   "define", "start a VM from an XML configuration file and save it"
   "start", "start a VM"
   "shutdown", "stop a VM"
   "destroy", "immediately stop a VM"
   "reboot", "restart a VM"
   "undefine", "remove a virtual machine"
   "vncdisplay", "show the IP address and port (that should be prefixed with '590' that VNC is listening on, if applicable"
   "dominfo", "shows the general configuration for the VM"
   "dumpxml", "dump the exact XML configuration"
   "edit", "edit the XML config with the $EDITOR"
   "setmem <VM_NAME> --live", "increase available RAM on a live VM"
   "setmem <VM_NAME> --config", "increase available RAM on a VM after it is manually rebooted by virsh"
   "vncdisplay", "attaches a VNC connection"
   "capabilities", "shows CPU capabilities/features for the current host"
   "managedsave-remove", "remove the saved RAM session from a sleeping/suspended VM"
   "snapshot-create-as <VM_NAME> <SNAPSHOT_NAME>", "create a snapshot of the virtual machine"
   "snapshot-list", "view all of the available snapshots"
   "snapshot-revert --domain <VM> <SNAPSHOT_NAME>", "revert a VM image to a snapshot"
   "net-list", "list the active libvirt networks"
   "net-list --all", "show all of the defined libvirt networks"
   net-dhcp-leases <NETWORK>, show all DHCP leases that are in use from a libvirt network
   "net-define", "add a new libvirt network configuration based on an XML file"
   "net-start", "start a libvirt network"
   "net-destroy", "forcefully stop a libvirt network"
   "net-autostart", "enable the libvirt network to be started when the libvirtd service is also started"
   "net-undefine", "remove the configure for the libvirt network"
   pool-list, list the available image pools
   pool-refresh <IMAGE_POOL>, refresh the cache list of current image names that exist in a given pool

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "attach-interface --domain fileserver1 --type bridge --source br0", "attach a new bridge interface 'br0' to the 'fileserver1' virtual machine"

virt-customize
~~~~~~~~~~~~~~

Package: libguestfs-tools-c

Execute commands inside of a virtual machine image file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-a <IMAGE_FILE>", "specify the image to modify"
   "--root-password password:<PASSWORD>", "change the root password"
   "--run-command '<COMMAND>'", "run a command inside of the image"
   --uninstall cloud-init, install the cloud-init software that is commonly installed on cloud images
   --ssh-inject <USER>:file:<FILE>, inject a specified SSH public key into the user's ~/.ssh/authorized_keys file
   --ssh-inject <USER>:string:<SSH_KEY_PUB>, same as file except the full public key string can be specified instead of the path to the file

Note that newer versions of this tool will automatically generate an unique machine-id after any customization. This will cause issues later on with cluster services if more than one machine will run using a copy of that base image. systemd will only regenerate it if the configuration file exists and is empty. This can be fixed by running: ``$ virt-sysprep --operations machine-id -a <IMAGE>``.

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -a /var/lib/libvirt/images/rhel-server-7.6-x86_64-kvm.qcow2 --root-password password:toor --uninstall cloud-init, setup a RHEL 7.6 image to be used on a non-cloud environment

virt-edit
~~~~~~~~~

Package: libguestfs-tools-c

Modify files inside of a virtual machine image file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<VM> <FULL_FILE_PATH>", "specify the virtual machine name and the path of the file to edit"

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "web1 /boot/grub2/grub.conf", "edit the GRUB2 configuration file on the web1 virtual machine"

virt-filesystems
~~~~~~~~~~~~~~~~

Package: libguestfs-tools

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--long -h --all -a", "find all available partitions in the image file"

virt-install
~~~~~~~~~~~~

Package: virt-install

Installation utility for virtual machines.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--name", "create guest vm name"
   "--memory", "specify the amount of RAM to allocate, in MBs, and options to use"
   "--memorybacking hugepages=on", "enable Huge Pages allocation"
   "--vcpus", "allocate CPUs"
   "--cpu", "the CPU model and options to use"
   "--cpu host-passthrough", "passthrough the CPU settings from the hypervisor"
   "--disk", "specify the partition to use for the vm"
   "--disk path=<PATH>,bus=virtio,cache=none", "use a disk and utilize the faster VirtIO drivers"
   "--network=bridge:<BRIDGE_DEVICE>,model=virtio", "use a network bridge with the faster VirtIO drivers"
   "--location", "network location of the tree file for the OS installation information"
   "--nographics", "install via a CLI console"
   "--graphics {vnc,listen=<ADDRESS>,port=<PORT>,password=<PASS>}", "use VNC to install the OS via a GUI; other specific options can also be defined such as to listen on all IPs with the 0.0.0.0 wildcard"
   "--import", "do not install the OS; use an existing pre-installed OS image or disk"
   "--livecd", "skip the installation and always boot from the disk"
   "--initrd-inject <FILE>", "add a file to the initrd/initramfs"
   "--extra-args=""<ARGS>""", "pass additional Linux kernel /proc/cmdline options"
   "--initrd-inject <KICKSTART_FILE> --extra-args=""ks=file:/<KICKSTART_FILE>""", "install the VM using a kickstart file"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "--cpu core2duo", "set the processor to use the Intel Core 2 Duo profile"
   "--connect=qemu:///system --network=bridge:br0,model=virtio --extra-args='ks=console=tty0 console=ttyS0,115200' --name=centos7 --disk /var/lib/libvirt/images/centos7.qcow2,bus=virtio,cache=none,io=native --ram 2048 --vcpus=2 --check-cpu --location=http://mirror.centos.org/centos/7/os/x86_64/ --graphics vnc,listen=0.0.0.0,port=5999,password=<PASSWORD>", "do a network install of CentOS 7 via a VNC connection"

virt-resize
~~~~~~~~~~~

Package: libguestfs-tools-c

Automatically increase partitions in virtual machine images.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--expand /dev/sd<XY> <SOURCEIMAGE> <BLANK_DESTINATION_IMAGE>", "increase the size of the partition /dev/sdXX to be the maximum available"
   "--expand /dev/sd<XX> --LV-expand /dev/<VOLUMEGROUP>/<LOGICALVOLUME> <SOURCEIMAGE> <BLANK_DESTINATION_IMAGE>", increase the size of a logical volume"

virt-xml
~~~~~~~~

Generate an XML configuration based on the same arguments usage as ``virt-install``.

virt-xml-validate
~~~~~~~~~~~~~~~~~

Package: libvirt-client

Validate a libvirt XML configuration for a virtual machine.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<LIBVIRT_XML_FILE>", "provide the path to a libvirt XML file"

Terraform
---------

terraform
~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   help, show the help output
   help <COMMAND>, show the help output for a specific command
   version, show the Terraform binary version
   -install-autocomplete, install shell argument completions for Terraform
   init, add Terraform configuration files and download missing plugins
   apply, deploy the infrastructure
   destroy, remove/cleanup the infrastructure
   workspace [delete|list|new|select|show], manage different workspaces

Vagrant
-------

vagrant
~~~~~~~

Package: vagrant

Automatically deploy customized virtual machines.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--provider=<TYPE>", "use virtualization back-end such as aws, kvm, virtualbox, or vmware_fusion"
   "plugin install vagrant-openstack-provider", "install OpenStack support"
   "plugin install vagrant-libvirt", "installs KVM support"
   "openstack image-list", "list all available OpenStack images"
   "init <VM>", "create a new virtual machine based on that image"
   "up <VM>", "start the virtual machine"
   "destroy <VM>", "delete the virtual machine"
   "box list", "show all virtual machines images that are downloaded"
   "box update", "update the virtual machine to the latest version"
   "box remove", "delete a virtual machine image"
   "destroy", "delete and remove a virtual machine"
   "status", "show all VMs managed by Vagrant and their current status"
   "halt", "shutdown a VM"
   "suspend", "suspend the VM into a sleep state"
   "ssh-config", "show the SSH configuration details for the virtual machines"
   "box list", "show all of the cached images"
   "prune <IMAGE>", "delete all old versions of a cached image"
   "box remove <IMAGE>", "delete an image"

WINE
----

wine
~~~~

Package: wine

Wine is Not an Emulator (WINE) provides a compatibility layer that translates Windows system calls into native Linux system calls. This provides a way to run Windows programs without virtualizing Windows and minimizing performance overhead.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "WINEPREFIX=''", "specify this prefix variable before the wine command to use a different Wine environment"
   "WINEARCH=''", "set the architecture to win32 or win64"
   "WINEDLLOVERRIDES='<DLL>=b,n'", "manually override a DLL to use the built-in Wine libraries and fallback to native Windows DLLs (if those are installed)"
   "msiexec /i", "install a MSI executable"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "WINEPREFIX='/home/user/sw_bf2_prefix' wine", "start wine using a custom directory for an isolated Windows environment"

winetricks
~~~~~~~~~~

Package: winetricks

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "WINE=''", "specify the path to the wine binary to use; this is useful if different versions are installed"
   "alldlls=default", "revert all DLLs to their default state; if it is managed by Wine then Wine will use it's built-in replacement"

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/commands/virtualization.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/virtualization.rst>`__
