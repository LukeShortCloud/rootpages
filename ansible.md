# Ansible 2
* [Configuraiton](#configuration)
  * [Inventory](#inventory)
* [Command Usage](#command-usage)
* [Playbooks](#playbooks)

## Introduction
Ansible is a utility for managing server deployments and updates. The project is well known for the ease of deploying updated configuration files, it's backwards compatible nature, as well as helping to automate infrastructures [1]. Ansible uses SSH to connect to server's remotely. If an Ansible task is ever re-run on a server, it will verify if the task is truly necessary (ex., if a package already exists) [2].

Sources:

1. Hochstein, *Ansible Up & Running*, 2.
2. "An Ansible Tutorial."

## Configuration
### Inventory
Default file: /etc/ansible/hosts

The hosts file is referred to as the "inventory" for Ansible. Here servers and groups of servers are defined. Ansible can then be used to execute commands and/or playbooks on these hosts.

The general syntax is:
```
[GROUPNAME]
SERVER1NAME
SERVER2NAME
```

Groups are created by using brackets "[" and "]" to specify the name. In this example, the group name is "dns-us" and contains two servers.
```
[dns-us]
dns1
dns2
```

A group can also be created from other groups by using the ":children" tag.
```
[dns-global:children]
dns-us
dns-ca
dns-mx
```

There are a large number of customizations that can be used to suit most server's access requirements.

Common Inventory Options[1]:
* ansible_host = The IP address or hostname of the server.
* ansible_port = A custom SSH port (i.e., if not using the standard port 22).
* ansible_connection = These options specify how to log in to execute tasks. Valid options are "ssh" to remotely connect to the server (this is the default behavior), "local" to run as the current user, and "chroot" to change into a different main root file system.
* ansible_user = The SSH user.
* ansible_pass = The SSH user's password. This is very insecure to keep passwords in plain text files so it is recommended to use SSH keys or pass the "--ask-pass" option to ansible when running tasks.
* ansible_ssh_private_key_file = Specify the private SSH key to use for accessing the server(s).
* ansible_ssh_common_args = Append additionally SSH command-line arguments.
* ansilbe_sudo = Use "sudo" to run commands without being root. Valid options are "false" (this is the default) or "true".
* ansible_sudo_user = Specify the user to use "sudo" with.
* ansible_su = Switch to the root user once logged in as the SSH user.
* ansible_python_interpreter = This will force Ansible to run on remote systems using a different Python binary. Ansible only supports Python 2 so on server's where only Python 3 is available, such as Arch Linux, a custom install of Python 2 can be used instead.

Here is an example of common Ansible options that can be used.
```
localhost ansible_connection=local
dns1 ansible_host=192.168.1.53 ansilbe_port=2222 ansible_sudo=true ansible_sudo_user=cloud
dns2 ansible_host=192.168.1.54
/home/user/ubuntu1604 ansible_connection=chroot
```

Sources:

1. "Ansible Inventory"

## Command Usage
## Playbooks
Playbooks organize tasks into one or more YAML files.

Sources:

---
Book Sources (Chicago citation):

* Lorin Hochstein *Ansible Up & Running* (Sebastopol: O'Reilly Media, Inc., 2015).
* "An Ansible Tutorial." Servers for Hackers. August 26, 2014. Accessed June 24, 2016. https://serversforhackers.com/an-ansible-tutorial.
* "Intro to Playbooks." Ansible Docs. June 22, 2016. Accessed June 24, 2016.  http://docs.ansible.com/ansible/playbooks_intro.html
* "Ansible Frequently Asked Questions." Ansible Docs. June 22, 2016. http://docs.ansible.com/ansible/faq.html
* "Ansible Inventory." Ansible Docs. June 22, 2016. http://docs.ansible.com/ansible/intro_inventory.html