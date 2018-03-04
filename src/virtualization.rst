Virtualization
==============

.. contents:: Table of Contents

libvirt
-------

"libvirt" provides a framework and API for accessing and controlling
different virtualization hypervisors. This Root Pages' guide assumes
that libvirt is used for managing Quick Emulator (QEMU) virtual
machines. [1]

Hardware Virtualization
-----------------------

Hardware virtualization speeds up and further isolates virtualized environments. Most newer CPUs support this. There is "Intel VT (Virtualization Techonology)" and "AMD SVM (Secure Virtual Machine)" for x86 processors. Hardware virtualization must be supported by both the motherboard and processor. It should also be enabled in the BIOS. [2]

Intel has three subtypes of virtualization:

-  VT-x = Basic hardware virtualization and host separation support.
-  VT-d = I/O passthrough support.
-  VT-c = Improved network I/O passthrough support.

[3]

AMD has two subtypes of virtualization:

-  AMD-V = Basic hardware virtualization and host separation support.
-  AMD-Vi = I/O passthrough support.

Check for Intel or AMD virtualization support:

::

    $ grep vmx /proc/cpuinfo # Intel

::

    $ grep svm /proc/cpuinfo # AMD

Verify the exact subtype of virtualization:

::

    $ lscpu | grep ^Virtualization # Intel or AMD

KVM
~~~

The "Kernel-based Virtual Machine (KVM)" is the default kernel module
for handling hardware virtualization in Linux since the 2.6.20 kernel.
[4] It is used to accelerate the QEMU hypervisor. [5]

Performance Tuning
^^^^^^^^^^^^^^^^^^

Configuration details for virtual machines can be modified to provide
better performance. For processors, it is recommended to use the same
CPU settings so that all of it's features are available to the guest.
[6]

QEMU:

::

    # qemu -cpu host ...

libvirt:

::

    # virsh edit <VIRTUAL_MACHINE>
    <cpu mode='host-passthrough'/>

The network driver that provides the best performance is "virtio." Some
guests may not support this feature and require additional drivers.

QEMU:

::

    # qemu -net nic,model=virtio ...

libvirt:

::

    # virsh edit <VIRTUAL_MACHINE>
    <interface type='network'>
      ...
      <model type='virtio' />
    </interface>****

Using a tap device (that will be assigned to an existing interface) or a
bridge will speed up network connections.

QEMU:

::

    ... -net tap,ifname=<NETWORK_DEVICE> ...

::

    ... -net bridge,br=<NETWORK_BRIDGE_DEVICE> ...

libvirt:

::

    # virsh edit <VIRTUAL_MACHINE>
        <interface type='bridge'>
    ...
          <source bridge='<BRDIGE_DEVICE>'/>
          <model type='virtio'/>
        </interface>

If possible, PCI passthrough provides the best performance as there is
no virtualization overhead.

QEMU:

::

    # qemu -net none -device vfio-pci,host=<PCI_DEVICE_ADDRESS> ...

Raw disk partitions have the greatest speeds with the "virtio" driver
and cache disabled.

QEMU:

::

    # qemu -drive file=<PATH_TO_STORAGE_DEVICE>,cache=none,if=virtio ...

libvirt:

::

    # virsh edit <VIRTUAL_MACHINE>
    <disk type='...' device='disk'>
      ...
      <target dev='<DEVICE_NAME>' bus='virtio'/>
    </disk>

[6][7]

When using the QCOW2 image format, create the image using metadata
preallocation or else there could be up to a x5 performance penalty. [8]

::

    # qemu-img create -f qcow2 -o size=<SIZE>G,preallocation=metadata <NEW_IMAGE_NAME>

Nested Virtualization
^^^^^^^^^^^^^^^^^^^^^

KVM supports nested virtualization. This allows a virtual machine full
access to the processor to run another virtual machine in itself. This
is disabled by default.

Verify that the computer's processor supports nested KVM virtualization.
[11]

-  Intel:

   ::

       $ cat /sys/module/kvm_intel/parameters/nested
       Y

-  AMD:

   ::

       $ cat /sys/module/kvm_amd/parameters/nested
       Y

Option #1 - Modprobe

-  Intel

   ::

       # vim /etc/modprobe.d/nested_virtualization.conf
       options kvm-intel nested=1

   ::

       # modprobe -r kvm-intel
       # modprobe kvm-intel

-  AMD

   ::

       # vim /etc/modprobe.d/nested_virtualization.conf
       options kvm-amd nested=1

   ::

       # modprobe -r kvm-amd
       # modprobe kvm-amd

Option #2 - GRUB2

Append this option to the already existing "GRUB\_CMDLINE\_LINUX"
options.

-  Intel

   ::

       # vim /etc/default/grub
       GRUB_CMDLINE_LINUX="kvm-intel.nested=1"

-  AMD

   ::

       # vim /etc/default/grub
       GRUB_CMDLINE_LINUX="kvm-amd.nested=1"

-  Then rebuild the GRUB 2 configuration.

   ::

       # grub-mkconfig -o /boot/grub/grub.cfg

[9]

Edit the virtual machine's XML configuration to change the CPU mode to
be "host-passthrough."

::

    # virsh edit <VIRTUAL_MACHINE>
    <cpu mode='host-passthrough'/>

[10]

Reboot the virtual machine and verify that the hypervisor and the
virtual machine both report the same capabilities and processor
information.

::

    # virsh capabilities

Finally verify that, in the virtual machine, it has full hardware
virtualization support.

::

    # virt-host-validate

[11]

GPU Passthrough
^^^^^^^^^^^^^^^

GPU passthrough provides a virtual machine guest with full access to a graphics card. It is required to have two video cards, one for host/hypervisor and one for the guest. [12] Hardware virtualization via VT-d (Intel) or SVM (AMD) is also required along with input-output memory management unit (IOMMU) support. Those settings can be enabled in the BIOS/UEFI on supported motherboards. Components of a motherboard are separated into different IOMMU groups. For GPU passthrough to work, every device in the IOMMU group has to be disabled on the host with a stub kernel driver and passed through to the guest. For the best results, it is recommended to use a motherboard that isolates each connector for the graphics card, usually a PCI slot, into it's own IOMMU group. The QEMU settings for the guest should be configured to use "SeaBIOS" for older cards or "OVMF" for newer cards that support UEFI. [36]

-  Enable IOMMU on the hypervisor via the bootloader's kernel options. This will provide a static ID to each hardware device. The "vfio-pci" kernel module also needs to start on boot.

Intel:

::

    intel_iommu=on rd.driver.pre=vfio-pci

AMD:

::

    amd_iommu=on rd.driver.pre=vfio-pci

-  For the GRUB bootloader, rebuild the configuration.

Fedora:

::

    # grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

-  Find the IOMMU number for the graphics card. This should be the last alphanumeric set at the end of the line for the graphics card. The format should look similar to `XXXX:XXXX`. Add it to the options for the "vfio-pci" kernel module. This will bind a stub kernel driver to the device so that Linux does not use it.

::

    # lspci -k -nn -v | less
    # vim /etc/modprobe.d/vfio.conf
    options vfio-pci ids=XXXX:XXXX,YYYY:YYYY,ZZZZ:ZZZZ

-  Rebuild the initramfs to include the VFIO related drivers.

Fedora:

::

    $ echo 'add_drivers+="vfio vfio_iommu_type1 vfio_pci"' > /etc/dracut.conf.d/vfio.conf
    $ sudo dracut --force

-  Reboot the hypervisor operating system.

[34][35]

Nvidia cards initialized in the guest with a driver version >= 337.88 can detect if the operating system is being virtualized. This can lead to a "Code: 43" error being returned by the driver and the graphics card not working. A work-a-round for this is to set a random "vendor\_id" to a alphanumeric 12 character value and forcing KVM's emulation to be hidden. This does not affect ATI/AMD graphics cards.

Libvirt:

::

    # virsh edit <VIRTUAL_MACHINE>
    <features>
        <hyperv>
            <vendor_id state='on' value='123456abcdef'/>
        </hyperv>
        <kvm>
            <hidden state='on'/>
        </kvm>
    </features>

[13]

Xen
~~~

Xen is a free and open source software hypervisor under the GNU General
Public License (GPL). It was originally designed to be a competitor of
VMWare. It is currently owned by Citrix and offers a paid support
package for it's virtual machine hypervisor/manager XenServer. [14] By
itself it can be used as a basic hypervisor, similar to QEMU. It can
also be used with QEMU to provide accelerated hardware virtualization.

Nested Virtualization
^^^^^^^^^^^^^^^^^^^^^

Since Xen 4.4, experimental support was added for nested virtualization.
A few settings need to be added to the Xen virtual machine's file,
typically located in the "/etc/xen/" directory. Turn "nestedhvm" on for
nested virtualization support. The "hap" feature also needs to be
enabled for faster performance. Lastly, the CPU's ID needs to be
modified to hide the original virtualization ID.

::

        nestedhvm=1
        hap=1
        cpuid = ['0x1:ecx=0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx']

[15]

Software Virtualization
-----------------------

Containers
~~~~~~~~~~

Containers are a type of software virtualization. Using a directory
structure that contains an entire operating system (typically referred
to as a chroot), containers can easily spin up and utilize system
resources without the overhead of full hardware allocation. It is not
possible to use separate kernels with this approach.

docker
^^^^^^

The docker software (with a lowercase "d") was created by the Docker
company to manage and create containers using the LXC kernel module on
Linux.

A command is run to start a daemon in the container. As long as that
process is still running in the foreground, the container will remain
active. Some processes may spawn in the background. A workaround for
this is to append ``&& tail -f /dev/null`` to the command. If the daemon
successfully starts, then a never-ending task can be run instead (such
as viewing the never ending file of /dev/null). [16]

Networking
''''''''''

Networking is automatically bridged to the public interface and set up
with a NAT. This allows full communication to/from the container,
provided that the necessary ports are open in the firewall and
configured in the docker image.

Networking issues from within a container are commonly due to network
packet size (MTU) issues. There are a few work-a-rounds.

1. Configure the default MTU size for docker deployments by modifying
   the daemon's process settings. This value should generally be below
   the default of 1500.

   ::

       # vim /etc/sysconfig/docker
       OPTIONS='--selinux-enabled --log-driver=journald --mtu 1400'
       # systemctl restart docker

   OR

   ::

       # vim /usr/lib/systemd/system/docker.service
       ExecStart=/usr/bin/docker-current daemon \
             --exec-opt native.cgroupdriver=systemd --mtu 1400 \
             $OPTIONS \
             $DOCKER_STORAGE_OPTIONS \
             $DOCKER_NETWORK_OPTIONS \
             $ADD_REGISTRY \
             $BLOCK_REGISTRY \
             $INSECURE_REGISTRY
       # systemctl daemon-reload
       # systemctl restart docker

2. Forward all packets between the docker link through the physical
   link.

   ::

       # iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

[17]

In rare cases, the bridge networking will not be working properly. An
error message similar to this may appear during creation.

::

    ERROR: for <CONTAINER_NAME> failed to create endpoint <NETWORK_ENDPOINT> on network bridge: iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport <DESTINATION_PORT_HOST> -j DNAT --to-destination <IP_ADDRESS>:<DESTINATION_PORT_CONTAINER> ! -i docker0: iptables: No chain/target/match by that name.

The solution is to delete the virtual "docker0" interface and then
restart the docker service for it to be properly recreated.

::

    # ip link delete docker0
    # systemctl restart docker

[18]

LXC
^^^

Linux Containers (LXC) utilizes the Linux kernel to natively run
containers.

Debian install [19]:

::

    # apt-get install lxc

RHEL install [20] requires the Extra Packages for Enterprise Linux (EPEL)
repository:

-  RHEL:

   ::

       # yum install epel-release
       # yum install lxc lxc-templates libvirt

On RHEL family systems the ``lxcbr0`` interface is not created or used.
Alternatively, the libvirt interface ``virbr0`` should be used.

::

    # vim /etc/lxc/default.conf
    lxc.network.link = virbr0

The required services need to be started before LXC containers will be
able to run.

::

    # systemctl start libvirtd
    # systemctl start lxc

Templates that can be referenced for LXC container creation can be found
in the ``/usr/share/lxc/templates/`` directory.

Container Management Platforms
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenShift
^^^^^^^^^

OpenShift is a Red hat product based on Google's Kubernetes. [29] It has a stronger focus on security with support for having access control lists (ACLs) for managing containers in separate projects and full SELinux support. Only NFS is officially supported as the storage back-end. Other storage providers are marked as a "Technology Preview." [30]

MiniShift
'''''''''

MiniShift is an easy to use all-in-one installation for testing out OpenShift.

Install (Fedora):

-  Install Libvirt and KVM and add non-privileged MiniShift users to the "libvirt" group.

::

    $ sudo dnf -y install qemu-kvm libvirt
    $ sudo usermod -a -G libvirt $USER

-  Download the latest release of MiniShift from: https://github.com/minishift/minishift/releases

::

    $ OPENSHIFT_VER=1.13.1
    $ wget https://github.com/minishift/minishift/releases/download/v${OPENSHIFT_VER}/minishift-${OPENSHIFT_VER}-linux-amd64.tgz
    $ tar -v -x -f minishift-${OPENSHIFT_VER}-linux-amd64.tgz
    $ sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
    $ chmod 0755 /usr/local/bin/docker-machine-driver-kvm
    $ cd ./minishift-${OPENSHIFT_VER}-linux-amd64/
    $ ./minishift start

[31][32]

Install (RHEL):

Enable the Red Hat Developer Tools repository first. Then MiniShift can be installed.

::

    $ sudo subscription-manager repos --enable rhel-7-server-devtools-rpms
    $ sudo yum install cdk-minishift
    $ minishift setup-cdk --force --default-vm-driver="kvm"
    $ sudo ln -s ~/.minishift/cache/oc/v3.*/linux/oc /usr/bin/oc
    $ minishift start

[33]

Orchestration
-------------

Virtual machine provisioning can be automated through the use of
different tools.

Vagrant
~~~~~~~

Vagrant is programmed in Ruby to help automate virtual machine (VM)
deployment. It uses a single file called "Vagrantfile" to describe the
virtual machines to create. By default, Vagrant will use VirtualBox as
the hypervisor but other technologies can be used.

-  Officially supported hypervisors [21]:

   -  docker
   -  hyperv
   -  virtualbox
   -  vmware\_desktop
   -  vmware\_fusion

-  Unofficial hypervisors [22]:

   -  aws
   -  azure
   -  google
   -  libvirt (KVM or Xen)
   -  lxc
   -  managed-servers (physical bare metal servers)
   -  parallels
   -  vsphere

Most unoffocial hypervisor providers can be automatically installed as a
plugin from the command line.

::

    $ vagrant plugin install vagrant-<HYPERVISOR>

Deploy VMs using a Vagrant file:

::

    $ vagrant up

OR

::

    $ vagrant up --provider <HYPERVISOR>

Destroy VMs using a Vagrant file:

::

    $ vagrant destroy

The default username and password should be ``vagrant``.

This guide can be followed for creating custom Vagrant boxes:
https://www.vagrantup.com/docs/boxes/base.html.

Vagrantfile
^^^^^^^^^^^

A default Vagrantfile can be created to start customizing with.

::

    $ vagrant init

All of the settings should be defined within the ``Vagrant.configure()``
block.

::

    Vagrant.configure("2") do |config|
        # Define VM settings here.
    end

Define the virtual machine template to use. This will be downloaded, by
default (if the ``box_url`` is not changed) from the HashiCorp website.

-  box = Required. The name of the virtual machine to download. A list
   of official virtual machines can be found at
   ``https://atlas.hashicorp.com/boxes/search``.
-  box\_version = The version of the virtual machine to use.
-  box\_url = The URL to the virtual machine details.

Example:

::

    Vagrant.configure("2") do |config|
      config.vm.box = "ubuntu/xenial64"
      config.vm.box_version = "v20170508.0.0"
      config.vm.box_url = "https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box"
    end

[23]

Networks
''''''''

Networks are either ``private`` or ``public``. ``private`` networks use
host-only networking and use network address translation (NAT) to
communicate out to the Internet. Virtual machines (VMs) can communicate
with each other but they cannot be reached from the outside world. Port
forwarding can also be configured to allow access to specific ports from
the hypervisor node. ``public`` networks allow a virtual machine to
attach to a bridge device for full connectivity with the external
network. This section covers VirtualBox networks since it is the default
virtualization provider.

With a ``private`` network, the IP address can either be a random
address assigned by DHCP or a static IP that is defined.

::

    Vagrant.configure("2") do |config|
      config.vm.network "private_network", type: "dhcp"
    end

::

    Vagrant.configure("2") do |config|
      config.vm.network "private_network", ip: "<IP4_OR_IP6_ADDRESS>", netmask: "<SUBNET_MASK>"
    end

The same rules apply to ``public`` networks except it uses the external
DHCP server on the network (if it exists).

::

    Vagrant.configure("2") do |config|
      config.vm.network "public_network", use_dhcp_assigned_default_route: true
    end

When a ``public`` network is defined and no interface is given, the
end-user is prompted to pick a physical network interface device to
bridge onto for public network access. This bridge device can also be
specified manually.

::

    Vagrant.configure("2") do |config|
      config.vm.network "public_network", bridge: "eth0: First NIC"
    end

In this example, port 2222 on the localhost (127.0.0.1) of the
hypervisor will forward to port 22 of the VM.

::

    ...
        config.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2222
    ...

[24]

libvirt
&&&&&&&

The options and syntax for public networks with the "libvirt" provider
are slightly different.

Options:

-  dev = The bridge device name.
-  mode = The libvirt mode to use. Default: ``bridge``.
-  type = The libvirt interface type. This is normally set to
   ``bridge``.
-  network\_name = The name of a network to use.
-  portgroup = The libvirt portgroup to use.
-  ovs = Instead of using a Linux bridge, use Open vSwitch instead.
   Default: ``false``.
-  trust\_guest\_rx\_filters = Enable the ``trustGuestRxFilters``
   setting. Default: ``false``.

Example:

::

    config.vm.define "controller" do |controller|
        controller.vm.network "public_network", ip: "10.0.0.205", dev: "br0", mode: "bridge", type: "bridge"
    end

[25]

Provisioning
''''''''''''

After a virtual machine (VM) has been created, additional commands can
be run to configure the guest VMs. This is referred to as
"provisioning."

-  Provisioners [26]:

   -  `ansible <https://www.vagrantup.com/docs/provisioning/ansible_intro.html>`__
      = Run a Ansible Playbook from the hypervisor node.
   -  ansible\_local = Run a Ansible Playbook from within the VM.
   -  cfengine = Use CFEngine to configure the VM.
   -  chef\_solo = Run a Chef Cookbook from inside the VM using
      ``chef-solo``.
   -  chef\_zero = Run a Chef Cookbook, but use ``chef-zero`` to emulate
      a Chef server inside of the VM.
   -  chef\_client = Use a remote Chef server to run a Cookbook inside
      the VM.
   -  chef\_apply = Run a Chef recipe with ``chef-apply``.
   -  docker = Install and configure docker inside of the VM.
   -  file = Copy files from the hypervisor to the VM. Note that the
      directory that the ``Vagrantfile`` is in will be mounted as the
      directory ``/vagrant/`` inside of the VM.
   -  puppet = Run single Puppet manifests with ``puppet apply``.
   -  puppet\_server = Run a Puppet manifest inside of the VM using an
      external Puppet server.
   -  salt = Run Salt states inside of the VM.
   -  shell = Run CLI shell commands.

Multiple Machines
'''''''''''''''''

A ``Vagrantfile`` can specify more than one virtual machine.

The recommended way to provision multiple VMs is to statically define
each individual VM to create as shown here. [27]

::

    Vagrant.configure("2") do |config|

      config.vm.define "web" do |web|
        web.vm.box = "nginx"
      end

      config.vm.define "php" do |php|
        php.vm.box = "phpfpm"
      end

      config.vm.define "db" do |db|
        db.vm.box = "mariadb"
      end

    end

However, it is possible to use Ruby to dynamically define and create
VMs. This will work for creating the VMs but using the ``vagrant``
command to manage the VMs will not work properly [28]:

::

    servers=[
      {
        :hostname => "web",
        :ip => "10.0.0.10",
        :box => "xenial",
        :ram => 1024,
        :cpu => 2
      },
      {
        :hostname => "db",
        :ip => "10.10.10.11",
        :box => "saucy",
        :ram => xenial,
        :cpu => 4
      }
    ]

    Vagrant.configure(2) do |config|
        servers.each do |machine|
            config.vm.define machine[:hostname] do |node|
                node.vm.box = machine[:box]
                node.vm.hostname = machine[:hostname]
                node.vm.network "private_network", ip: machine[:ip]
                node.vm.provider "virtualbox" do |vb|
                    vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
                end
            end
        end
    end


GUI
---

There are many programs for managing virtualization from a graphical user interface (GUI).

Common GUIs:

-  oVirt
-  virt-manager
-  XenServer


Bibliography
------------

1. "libvirt Introduction." libvirt VIRTUALIZATION API. Accessed December 22, 2017. https://libvirt.org/index.html
2. "Linux: Find Out If CPU Support Intel VT and AMD-V Virtualization Support." February 11, 2015. nixCraft. Accessed December 18, 2016. https://www.cyberciti.biz/faq/linux-xen-vmware-kvm-intel-vt-amd-v-support/
3. "Intel VT (Virtualization Technology) Definition." TechTarget. October, 2009. Accessed December 18, 2016. http://searchservervirtualization.techtarget.com/definition/Intel-VT
4. "Kernel Virtual Machine." KVM. Accessed December 18, 2016. http://www.linux-kvm.org/page/Main\_Page
5. "KVM vs QEMU vs Libvirt." The Geeky Way. February 14, 2014. Accessed December 22, 2017. http://thegeekyway.com/kvm-vs-qemu-vs-libvirt/
6. "Tuning KVM." KVM. Accessed January 7, 2016. http://www.linux-kvm.org/page/Tuning\_KVM
7. "Virtio." libvirt Wiki. October 3, 2013. Accessed January 7, 2016. https://wiki.libvirt.org/page/Virtio
8. "KVM I/O slowness on RHEL 6." March 11, 2011. Accessed August 30, 2017. http://www.ilsistemista.net/index.php/virtualization/11-kvm-io-slowness-on-rhel-6.html
9. "How to Enable Nested KVM." Rhys Oxenhams' Cloud Technology Blog. June 26, 2012. Accessed December 1, 2017. http://www.rdoxenham.com/?p=275
10. "Configure DevStack with KVM-based Nested Virtualization." December 18, 2016. Accessed December 18, 2016. http://docs.openstack.org/developer/devstack/guides/devstack-with-nested-kvm.html
11. "How to enable nested virtualization in KVM." Fedora Project Wiki. June 19, 2015. Accessed August 30, 2017. https://fedoraproject.org/wiki/How\_to\_enable\_nested\_virtualization\_in\_KVM
12. "GPU Passthrough with KVM and Debian Linux." scottlinux.com Linux Blog. August 28, 2016. Accessed December 18, 2016. https://scottlinux.com/2016/08/28/gpu-passthrough-with-kvm-and-debian-linux/
13. "PCI passthrough via OVMF." Arch Linux Wiki. December 18, 2016. Accessed December 18, 2016. https://wiki.archlinux.org/index.php/PCI\_passthrough\_via\_OVMF
14. "Xen Definition." TechTarget. March, 2009. Accessed December 18, 2016. http://searchservervirtualization.techtarget.com/definition/Xen
15. "Nested Virtualization in Xen." Xen Project Wiki. November 2, 2017. Accessed December 22, 2017. https://wiki.xenproject.org/wiki/Nested\_Virtualization\_in\_Xen
16. "Get started with Docker." Docker. Accessed November 19, 2016. https://docs.docker.com/engine/getstarted
17. "containers in docker 1.11 does not get same MTU as host #22297." Docker GitHub. September 26, 2016. Accessed November 19, 2016. https://github.com/docker/docker/issues/22297
18. "iptables failed - No chain/target/match by that name #16816." Docker GitHub. November 10, 2016. Accessed December 17, 2016. https://github.com/docker/docker/issues/16816
19. "LXC." Ubuntu Documentation. Accessed August 8, 2017. https://help.ubuntu.com/lts/serverguide/lxc.html
20. "How to install and setup LXC (Linux Container) on Fedora Linux 26." nixCraft. July 13, 2017. Accessed August 8, 2017. https://www.cyberciti.biz/faq/how-to-install-and-setup-lxc-linux-container-on-fedora-linux-26/
21. "Introduction to Vagrant." Vagrant Documentation. April 24, 2017. Accessed May 9, 2017. https://www.vagrantup.com/intro/getting-started/index.html
22. "Available Vagrant Plugins." mitchell/vagrant GitHub. November 9, 2016. Accessed May 8, 2017. https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins
23. "[Vagrant] Boxes." Vagrant Documentation. April 24, 2017. Accessed May 9, 2017. https://www.vagrantup.com/docs/boxes.html
24. "[Vagrant] Networking." Vagrant Documentation. April 24, 2017. Accessed May 9, 2017. https://www.vagrantup.com/docs/networking/
25. "Vagrant Libvirt Provider [README]." vagrant-libvirt GitHub. May 8, 2017. Accessed June 17, 2017. https://github.com/vagrant-libvirt/vagrant-libvirt
26. "[Vagrant] Provisioning." Vagrant Documentation. April 24, 2017. Accessed May 9, 2017. https://www.vagrantup.com/docs/provisioning/
27. "[Vagrant] Multi-Machine." Vagrant Documentation. April 24, 2017. Accessed May 9, 2017. https://www.vagrantup.com/docs/multi-machine/
28. "Vagrantfile." Linux system administration and monitoring / Windows servers and CDN video. May 9, 2017. Accessed May 9, 2017. http://sysadm.pp.ua/linux/sistemy-virtualizacii/vagrantfile.html
29. "OpenShift: Container Application Platform by Red Hat." OpenShift. Accessed February 26, 2018. https://www.openshift.com/
30. "Persistent Storage." OpenShift Documentation. Accessed February 26, 2018. https://docs.openshift.com/enterprise/3.0/architecture/additional_concepts/storage.html
31. "Minishift Quickstart." OpenShift Documentation. Accessed February 26, 2018. https://docs.openshift.org/latest/minishift/getting-started/quickstart.html
32. "Run OpenShift Locally with Minishift." Fedora Magazine. June 20, 2017. Accessed February 26, 2018. https://fedoramagazine.org/run-openshift-locally-minishift/
33. "CHAPTER 5. INSTALLING RED HAT CONTAINER DEVELOPMENT KIT." Red Hat Customer Portal. Accessed February 26, 2018. https://access.redhat.com/documentation/en-us/red_hat_container_development_kit/3.0/html/installation_guide/installing-rhcdk
34. "PCI passthrough via OVMF." Arch Linux Wiki. February 13, 2018. Accessed February 26, 2018. https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
35. "RYZEN GPU PASSTHROUGH SETUP GUIDE: FEDORA 26 + WINDOWS GAMING ON LINUX." Level One Techs. June 25, 2017. Accessed February 26, 2018. https://level1techs.com/article/ryzen-gpu-passthrough-setup-guide-fedora-26-windows-gaming-linux
36. "IOMMU Groups – What You Need to Consider." Heiko's Blog. July 25, 2017. Accessed March 3, 2018. https://heiko-sieger.info/iommu-groups-what-you-need-to-consider/
