Virtualization
==============

.. contents:: Table of Contents

See also: Administrative, Hardware, Networking, OpenStack

Containers
----------

docker
~~~~~~

Package: docker

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "search", "look for available Docker images online"
   "pull <OS>", "download the latest image for a specified OS"
   "pull <OS>:<VERSION>", "download a specified version"
   "images", "show downloaded images"
   "network", "manage networks"
   "network ls", "view all networks"
   "rmi", "remove image files"
   "rm", "delete a container"
   "ps", "list active containers"
   "ps -a", "list all active and stopped containers"
   "exec", "execute a single command in a specified container"
   "exec -it <CONTAINER_ID> bash", "open a Bash session in the container"
   "run <IMAGE>", "start a container in the foreground"
   "run -d <IMAGE>", "start a container in the background"
   "run -d <IMAGE> tail -f /dev/null", "start a container and keep it running (by running a never-ending command)"
   "run --net=<NAME> --ip <IP_ADDRESS> -p <HYPERVISOR_PORT>:<CONTAINER_PORT>", "start a container using a specific network, assigning a static IP, and setup port forwarding"
   "stop", "shutdown a container"
   "stop $(docker ps -aq)", "stop all containers"
   "logs", "view the logs / standard output from a running Docker container"
   "-v <SOURCE>:<DESTINATION>", "bind mount a folder from the host node to a folder inside of the container for persistent storage"
   "-q", "list only IDs"
   "-f", "force an action"
   "inspect", "view detailed information about a container"
   "network create --subnet <CIDR> <NAME>", "create a new Docker network using a specific network CIDR and name"
   "run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro <OS>:<VERSION> /usr/lib/systemd/systemd", "start a docker container with systemd support"

kubectl
~~~~~~~

Package: kubernetes-client

Manage Kubernetes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "version", "show the Kubernetes version"
   "cluster-info", "show the clustered services and their status"
   "get nodes", "show all of the Kubernetes hypervisor nodes"
   "run <NAME> --image=<PATH_TO_IMAGE>:<VERSION> --port=<PORT>", "create a container from the specific version of the image, listening on the specified port, and give it the specified name"
   "run -i --tty <NAME> --image=<IMAGE_NAME>:<IMAGE_VERSION> --restart=Never /bin/bash", "start a container and enter into it via a Bash shell"
   "get deployments", "show all of the containers that have been defined"
   "get pods", "show the actual containers"
   "pod delete", "delete a container"
   "proxy", "create a proxy from your hypervisor to be able to access the private network that the containers share"
   "attach <NAME> -i", "attach to a already running container"

minikube
~~~~~~~~

Package: None

Deploy an all-in-one Kubernetes cluster.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "start", "deploy a Kubernetes cluster to the local machine"

oc
~~

Package: origin-clients (upstream)

Create and manage OpenShift clusters.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "cluster up", "spin up OpenShift Origin"
   "cluster up --public-hostname <IP>", "specify the IP to bind to for OpenShift Origin"
   "cluster down", "remove OpenShift Origin"

podman
~~~~~~

Package: podman

The libpodman library provides a utility to manage and run containers with CRI-O and not the docker deamon. It provides all of the same arguments and syntax as the docker command (except for Docker Swarm administration) along with additional capatibilities to launch standalone Kubernetes pods.

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
   "net-define", "add a new libvirt network configuration based on an XML file"
   "net-start", "start a libvirt network"
   "net-destroy", "forcefully stop a libvirt network"
   "net-autostart", "enable the libvirt network to be started when the libvirtd service is also started"
   "net-undefine", "remove the configure for the libvirt network"

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

   "web1 /boot/grub2/grub.conf", "edit the GRUB2 configuraiton file on the web1 virtual machine"

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

virt-xml-validate
~~~~~~~~~~~~~~~~~

Package: libvirt-client

Validate a libvirt XML configuration for a virtual machine.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<LIBVIRT_XML_FILE>", "provide the path to a libvirt XML file"

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
   "ssh-config", "show the SSH configuraiton details for the virtual machines"
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
   "WINEDLLOVERIDES='<DLL>=b,n'", "manually override a DLL to use the built-in Wine libraries and fallback to native Windows DLLs (if those are installed)"
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

`History <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/virtualization.rst>`__
---------------------------------------------------------------------------------------------------------

Bibliography
------------

References:

-  Containers

   -  docker

      -  https://github.com/docker/docker/wiki/Public-docker-images
      -  http://stackoverflow.com/questions/30209776/docker-container-will-automatically-stop-after-docker-run-d
      -  https://coderwall.com/p/2es5jw/docker-cheat-sheet-with-examples
      -  https://docs.docker.com/engine/tutorials/dockervolumes/
      -  https://hub.docker.com/r/geerlingguy/docker-debian9-ansible/

   -  kubectl

      -  http://blog.kubernetes.io/2015/10/some-things-you-didnt-know-about-kubectl_28.html

   -  minikube

      -  https://github.com/kubernetes/minikube/releases

-  QEMU

   -  virt-filesystems

      -  http://superuser.com/questions/669945/extend-partition-in-kvm

   -  virt-install

      -  https://www.howtoforge.com/virtualization-with-kvm-on-a-centos-6.4-server
      -  http://blog.allanglesit.com/2011/03/kvm-guests-using-virt-install-to-install-vms-from-a-cd-or-iso-imag/

   -  virt-resize

      -  http://superuser.com/questions/669945/extend-partition-in-kvm

   -  virt-xml-validate

      -  http://linux.die.net/man/1/virt-xml-validate

   -  virsh

      -  http://www.certdepot.net/sys-start-and-stop-virtual-machines/
      -  https://www.centos.org/docs/5/html/5.2/Virtualization/chap-Virtualization-Managing_guests_with_virsh.html

-  Vagrant

   -  vagrant

      -  https://www.vagrantup.com/docs/
      -  http://blog.scottlowe.org/2015/09/28/using-vagrant-with-openstack/
      -  https://www.vagrantup.com/docs/cli/box.html

-  WINE

   -  winetricks

      -  https://wiki.winehq.org/Winetricks
      -  https://askubuntu.com/questions/254086/how-do-i-override-a-dll-without-using-the-winecfg-gui-in-wine
