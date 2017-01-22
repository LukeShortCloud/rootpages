# Virtualization

* [Hardware Virtualization](#hardware-virtualization)
    * [KVM](#hardware-virtualization---kvm)
        * [Performance Tweaks](#hardware-virtualization---kvm---performance-tweaks)
        * [Nested Virtualization](#hardware-virtualization---kvm---nested-virtualization)
        * [GPU Passthrough](#hardware-virtualization---kvm---gpu-passthrough)
        * virt-manager
        * oVirt
    * [Xen](#hardware-virtualization---xen)
        * [Nested Virtualization](#hardware-virtualization---xen---nested-virtualization)
        * XenServer
* [Software Virtualization](#software-virtualization)
    * QEMU
    * [Containers](#software-virtualization---containers)
        * [Docker](#software-virtualization---containers---docker)
            * [Networking](#software-virtualization---containers---docker---networking)


# Hardware Virtualization

Hardware virtualization uses specially supported processors to speed up and isolate virtualized environments. Most newer CPUs support this. There is "Intel VT (Virtualization Techonology)" and "AMD SVM (Secure Virtual Machine)" for x86 processors. [1]

Intel has three subtypes of virtualization:

* VT-x = Basic hardware virtualization and host separation support.
* VT-d = I/O passthrough support.
* VT-c = Improved network I/O passthrough support.

[2]

AMD has two subtypes of virtualization:

* AMD-V = Basic hardware virtualization and host separation support.
* AMD-Vi = I/O passthrough support.


Check for Intel or AMD virtualization support:

```
$ grep vmx /proc/cpuinfo # Intel
```
```
$ grep svm /proc/cpuinfo # AMD
```

Verify the exact subtype of virtualization:
```
$ lscpu | grep ^Virtualization # Intel or AMD
```

Hardware virtualization must be supported by both the motherboard and processor. It should also be enabled in the BIOS. [1]

Sources:

1. "Linux: Find Out If CPU Support Intel VT and AMD-V Virtualization Support." February 11, 2015. nixCraft. Accessed December 18, 2016. https://www.cyberciti.biz/faq/linux-xen-vmware-kvm-intel-vt-amd-v-support/
2. "Intel VT (Virtualization Technology) Definition." TechTarget. October, 2009. Accessed December 18, 2016. http://searchservervirtualization.techtarget.com/definition/Intel-VT


## Hardware Virtualization - KVM

The "Kernel-based Virtual Machine (KVM)" is the default kernel module for handling hardware virtualization in Linux since the 2.6.20 kernel. [1]

Source:

1. "Kernel Virtual Machine." KVM. Accessed December 18, 2016. http://www.linux-kvm.org/page/Main_Page


### Hardware Virtualization - KVM - Performance Tweaks

Configuration detials for virtual machines can be modified to provide better performance. For processors, it is recommended to use the same CPU settings so that all of it's features are available to the guest. [1]

```
# qemu -cpu host ...
```
```
# virsh edit <VIRTUAL_MACHINE>
<cpu mode='host-passthrough'>
```

The network driver that provides the best performance is "virtio." Some guests may not support this feature and require additional drivers.

```
# qemu -net nic,model=virtio ...
```
```
# virsh edit <VIRTUAL_MACHINE>
<interface type='network'>
  ...
  <model type='virtio' />
</interface>****
```

Using a tap device (that will be greated to an existing interface) or a bridge will speed up network greatly.
```
... -net tap,ifname=<NETWORK_DEVICE> ...
```
```
... -net bridge,br=<NETWORK_BRIDGE_DEVICE> ...
```
```
# virsh edit <VIRTUAL_MACHINE>
    <interface type='bridge'>
...
      <source bridge='<BRDIGE_DEVICE>'/>
      <model type='virtio'/>
    </interface>
```

If possible, PCI passthrough provides the best performance as there is no virtualization overhead.
```
# qemu -net none -device vfio-pci,host=<PCI_DEVICE_ADDRESS> ...
```


Raw disk partitions have the greatest speeds with the "virtio" driver and cache disabled.
```
# qemu -drive file=<PATH_TO_STORAGE_DEVICE>,cache=none,if=virtio ...
```
```
# virsh edit <VIRTUAL_MACHINE>
<disk type='...' device='disk'>
  ...
  <target dev='<DEVICE_NAME>' bus='virtio'/>
</disk>
```

[1][2]

Sources:

1. "Tuning KVM." KVM. Accessed January 7, 2016. http://www.linux-kvm.org/page/Tuning_KVM
2. "Virtio." libvirt Wiki. October 3, 2013. Accessed January 7, 2016. https://wiki.libvirt.org/page/Virtio


### Hardware Virtualization - KVM - Nested Virtualization

KVM supports nested virtualization. This allows a virtual machine full access to the processor to run another virtual machine in itself. This is disabled by default.

#### Option #1 - Modprobe

* Intel
```
# vim /etc/modprobe.d/nested_virtualization.conf
options intel nested=1
```
```
# modprobe -r kvm-intel
# modprobe kvm-intel
```
* AMD
```
# vim /etc/modprobe.d/nested_virtualization.conf
options amd nested=1
```
```
# modprobe -r kvm-amd
# modprobe kvm-amd
```

#### Option #2 - GRUB2

* Intel
```
# vim /etc/default/grub
GRUB_CMDLINE_LINUX="console=tty0 kvm-intel.nested=1"
```
* AMD
```
# vim /etc/default/grub
GRUB_CMDLINE_LINUX="console=tty0 kvm-amd.nested=1"
```
* Then rebuild the GRUB 2 configuration.
```
# grub-mkconfig -o /boot/grub/grub.cfg
```

[1]

Finally, edit the virtual machine's XML configuration to change the CPU mode to be "host-passthrough."

```
# virsh edit <VIRTUAL_MACHINE>
<cpu mode='host-passthrough'>
```
[2]

Sources:

1. "How to Enable Nested KVM." Rhys Oxenhams' Cloud Technology Blog. June 26, 2012. Accessed December 18, 2016. http://www.rdoxenham.com/?p=275
2. "Configure DevStack with KVM-based Nested Virtualization." December 18, 2016. Accessed December 18, 2016. http://docs.openstack.org/developer/devstack/guides/devstack-with-nested-kvm.html


### Hardware Virtualization - KVM - GPU Passthrough

GPU passthrough is useful for running a Windows virtual machine guest for gaming inside of Linux. It is recommended to have two video cards, one for Linux and one for the guest virtual machine. [1]

Nvidia cards have a detection in the driver to see if the operating system has a hypervisor running. This can lead to a "Code: 43" error in the driver as it false-positively reports none. This affects Nvidia drivers starting with version 337.88. A work-a-round for this is to set a random "vendor_id" to a alphanumeric 12 character value and forcing KVM's emulation to be hidden. This does not affect ATI/AMD graphics cards. [2]

```
# virsh edit <VIRTUAL_MACHINE>
<features>
    <hyperv>
        <vendor_id state='on' value='123456abcdef'/>
    </hyperv>
	<kvm>
        <hidden state='on'/>
	</kvm>
</features>
```
[2]

Sources:

1. "GPU Passthrough with KVM and Debian Linux." scottlinux.com Linux Blog. August 28, 2016. Accessed December 18, 2016. https://scottlinux.com/2016/08/28/gpu-passthrough-with-kvm-and-debian-linux/
2. "PCI passthrough via OVMF." Arch Linux Wiki. December 18, 2016. Accessed December 18, 2016. https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF


## Hardware Virtualization - Xen

Xen is a free and open source software published under the GNU General Public License (GPL). It was originally designed to be a competitor of VMWare. It is currently owned by Citrix and offers a paid support package for it's virtual machine hypervisor/manager XenServer. [1]

Source:

1. "Xen Definition." TechTarget. March, 2009. Accessed December 18, 2016. http://searchservervirtualization.techtarget.com/definition/Xen

### Hardware Virtualization - Xen - Nested Virtualization

Since Xen 4.4, nested virtualization has been supported by default. It needs to be configured in the guest virtual machine using "nestedhvm." The "hap" feature also needs to be enabled for better performance and stability. Lastly, the CPU's ID needs to be modified to hide the original virtualization ID.

```
nestedhvm=1
hap=1
cpuid = ['0x1:ecx=0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx']
```

[1]

Source:

1. "Nested Virtualization in Xen." Xen Project Wiki. December 13, 2016. Accessed December 18, 2016. https://wiki.xenproject.org/wiki/Nested_Virtualization_in_Xen

# Software Virtualization


# Software Virtualization - Containers

Containers are a type of software virtualization. Using a directory structure that contains an entire operating system (typically referred to as a chroot), containers can easily spin up and utilize system resources without the overhead of full hardware allocation. It is not possible to use seperate kernels with this approach.


### Software Virtualization - Containers - Docker

Docker creates containers using the LXC kernel module on Linux.

A command is run to start a daemon in the container. As long as that process is still running in the foreground, the container will remain active. Some processes may spawn in the background. A workaround for this is to append `&& tail -f /dev/null` to the command. If the daemon successfully starts, then a never-ending task can be run instead (such as viewing the never ending file of /dev/null). [1]

Source:

1. "Get started with Docker." Docker. Accessed November 19, 2016. https://docs.docker.com/engine/getstarted


### Software Virtualization - Containers - Docker - Networking

Networking is automatically bridged to the public interface and set up with a NAT. This allows full communication to/from the container, provided that the necessary ports are open in the firewall and configured in the Docker image.

Networking issues from within a container are commonly due to network packet size (MTU) issues. There are a few work-a-rounds.

1. Configure the default MTU size for Docker deployments by modifying the daemon's process settings. This value should generally be below the default of 1500.
```
# vim /etc/sysconfig/docker
OPTIONS='--selinux-enabled --log-driver=journald --mtu 1400'
# systemctl restart docker
```
OR
```
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
```
2. Forward all packets between the Docker link through the physical link.
```
# iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
```

[1]

In rare cases, the bridge networking will not be working properly. An error message similar to this may appear during creation.

```
ERROR: for <CONTAINER_NAME> failed to create endpoint <NETWORK_ENDPOINT> on network bridge: iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport <DESTINATION_PORT_HOST> -j DNAT --to-destination <IP_ADDRESS>:<DESTINATION_PORT_CONTAINER> ! -i docker0: iptables: No chain/target/match by that name.
```

The solution is to delete the virtual "docker0" interface and then restart the Docker service for it to be properly recreated.

```
# ip link delete docker0
# systemctl restart docker
```

[2]

Sources:

1. "containers in docker 1.11 does not get same MTU as host #22297." Docker GitHub. September 26, 2016. Accessed November 19, 2016. https://github.com/docker/docker/issues/22297
2. "iptables failed - No chain/target/match by that name #16816." Docker GitHub. November 10, 2016. Accessed December 17, 2016. https://github.com/docker/docker/issues/16816