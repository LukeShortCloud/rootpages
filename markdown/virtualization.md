# Virtualization

* Hardware Virtualization
    * KVM
    * Xen
* [Containers](#containers)
    * [Docker](#containers---docker)
        * [Networking](#containers---docker---networking) 


# Containers

Containers are a type of software virtualization. Using a directory structure that contains an entire operating system (typically referred to as a chroot), containers can easily spin up and utilize system resources without the overhead of full hardware allocation. It is not possible to use seperate kernels with this approach.


## Containers - Docker

Docker creates containers using the LXC kernel module on Linux.

A command is run to start a daemon in the container. As long as that process is still running in the foreground, the container will remain active. Some processes may spun in the background. A workaround for this is to append `&& tail -f /dev/null` to the command. If the daemon successfully starts, then a never-ending task can be run instead (such as viewing the never ending file of /dev/null). [1]

Source:

1. "Get started with Docker." Docker. Accessed November 19, 2016. https://docs.docker.com/engine/getstarted


### Containers - Docker - Networking

Networking is automatically bridged to the public interface and set up with a NAT. This allows full communication to/from the container, provided that the necessary ports are open in the firewall and configured in the Docker image.

Networking issues from within a container are commonly due to network packet size (MTU) issues. There are a few work-a-rounds.

1. Configure the default MTU size for Docker deployments by modifying the daemon's process settings. This value should generally be below the default of 1500.
```
# vim /etc/sysconfig/docker
OPTIONS='--selinux-enabled --log-driver=journald --mtu 1400'
# systemctl daemon-reload
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
# systemclt restart docker
```

2. Forward all packets between the Docker link through the physical link.
```
# iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
```

[1]

Source:

1. "containers in docker 1.11 does not get same MTU as host #22297." Docker GitHub. September 26, 2016. Accessed November 19, 2016. https://github.com/docker/docker/issues/22297