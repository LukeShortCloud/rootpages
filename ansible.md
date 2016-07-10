# Ansible 2
* [Configuration](#configuration)
  * [Inventory](#configuration---inventory)
    * [Variables](#configuration---inventory---variables)
* [Command Usage](#command-usage)
* [Playbooks](#playbooks)
  * [Directory Structure](#playbooks---directory-structure)
  * [Modules](#playbooks---modules)
    * [Files and Templates](#playbooks---modules---files-and-templates)
    * [Service](#playbooks---modules---service)

## Introduction
Ansible is a utility for managing server deployments and updates. The project is well known for the ease of deploying updated configuration files, it's backwards compatible nature, as well as helping to automate infrastructures. [1] Ansible uses SSH to connect to server's remotely. If an Ansible task is ever re-run on a server, it will verify if the task is truly necessary (ex., if a package already exists). [2]

Sources:

1. Hochstein, *Ansible Up & Running*, 2.
2. "An Ansible Tutorial."

## Configuration
### Configuration - Inventory
Default file: /etc/ansible/hosts

The hosts file is referred to as the "inventory" for Ansible. Here servers and groups of servers are defined. Ansible can then be used to execute commands and/or Playbooks on these hosts.

The general syntax is:
```
[GROUPNAME]
SERVER1NAME
SERVER2NAME
```

Groups are created by using brackets "[" and "]" to specify the name. In this example, the group name is "dns-us" and contains three servers.
```
[dns-us]
dns-us1
dns-us2
dns-us3
```

A group can also be created from other groups by using the ":children" tag.
```
[dns-global:children]
dns-us
dns-ca
dns-mx
```

Variables are created for a host and/or group using the tag ":vars". Then any custom variable can be defined and associated with a string. Here is an example below. These can also be defined in seperate files as explained in [Inventory - Variables](#inventory---variables).
```
[examplehost:vars]
domain_name=examplehost.tld
domain_ip=192.168.7.7
```

There are a large number of customizations that can be used to suit most server's access requirements.

Common Inventory Options:
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
* ansible_python_interpreter = This will force Ansible to run on remote systems using a different Python binary. Ansible only supports Python 2 so on server's where only Python 3 is available, such as Arch Linux, a custom install of Python 2 can be used instead.[1]

Here is an example of common Ansible options that can be used.
```
localhost ansible_connection=local
dns1 ansible_host=192.168.1.53 ansilbe_port=2222 ansible_sudo=true ansible_sudo_user=cloud
dns2 ansible_host=192.168.1.54
/home/user/ubuntu1604 ansible_connection=chroot
```

### Configuration - Inventory - Variables

Variables that Playbooks will use can be defined for specific hosts and/or groups.
* /etc/ansible/host_vars/ = Create a file named after the host.
* /etc/ansible/group_vars/ = Create a file named after the group of hosts.
* all = This file can exist under the above directories to define global variables for all hosts and/or groups.

The files in these directories can have any name and do not require an extension. It is assumed that they are YAML files. Here is an example for a host variable file.
```
---
domain_name: examplehost.tld
domain_ip: 192.168.10.1
hello_string: Hello World!
```

In the Playbook and/or template files, these variables can then be referenced when enclosed by double braces "{{" and "}}". [2]
```
Hello world from {{ domain_name }}!
```

Sources:

1. "Ansible Inventory"
2. "Ansible Variables."
3. "Ansible Best Practices."

## Command Usage
## Playbooks
Playbooks organize tasks into one or more YAML files. It can be a self-contained file or a large project organized in a directory.

### Playbooks - Directory Structure

* site.yml = This is generally the main Playbook file. It should include all other Playbook files required if more than one is used.
  * Example syntax:

```
---
include: nginx.yml
include: php-fpm.yml
```

* roles/`<ROLENAME>`/vars/main.yml = Global variables for a role.
  * Example syntax:

```
---
memcache_hosts=192.168.1.11,192.168.1.12,192.168.1.13
ldap_ip=192.168.10.1
```

* group_vars/ and host_vars/ = These files define variables for hosts and/or groups. Details about this can be found in the [Variables](#configuration---inventory---variables) section.

* templates/ = Template configuration files for services. The files in here end with a ".j2" suffix to signify that it uses the Jinja2 template engine. [1]
  * Example syntax:

```
<html>
<body>My domain name is {{ domain }}</body>
</html>
```

Sources:

1. "An Ansible Tutorial."


## Playbooks - Modules
### Playbooks - Modules - Files and Templates
Both the file and template modules provide ways to managing and configuring various files. The file module is used to handle files that will not be modified [1] and templates are to be used when Ansible will fill in the variables. [2] Most of the attributes are the same between the two.

Common options:
* src = Define the source file or template. If a full path is not given, Ansible will check in the roles/`<ROLENAME>`/files/ directory for a file or roles/`<ROLENAME>`/templates/ for a template.
* dest = This is the full path to where the file should be copied to on the destination server.
* owner = Set the user owner.
* group = Set the group owner.
* mode = Set the octal or symbloc permissions. If using octal, it has to be four digits. The first digit is generally the flag "0" to indicate no special permissions.
* setype = Set SELinux file permissions.
* state = Specify the state the file should be created in.
  * File = Copy the file.
  * Link = Create a soft link shortcut.
  * Hard = Create a hard link reference.
  * Touch = Create an empty file.
  * Directory = Create all subdirectories in the destination folder.
  * Absent = Delete destination folders. [1]

Example
```
template: src=example.conf.j2 dst=/etc/example/example.conf mode=0644 owner=root group=nobody
```

Sources:

1. "Ansible File Module."
2. "Ansible Template Module."

### Playbooks - Modules - Service
The service module is used to handle system services.

Common options:
* name = Specify the service name.
* enabled = Enable the service to start on boot or not. Valid options are "yes" or "no."
* sleep = When restarted a service, specify the amount of time (in seconds) to wait before starting a service after stopping it.
* state = Specify what state the service should be in.
  * started = Start the service.
  * stopped = Stop the service.
  * restarted = Stop and then start the service.
  * reloaded = If supported by the service, it will reload it's configuration file without restarting it's main thread. [1]

Exmaple:
* Restart the Apache service "httpd."
```
service: name=httpd state=restarted sleep=3
```

Sources:

1. "Ansible Service Module."

---
Sources:

* Lorin Hochstein *Ansible Up & Running* (Sebastopol: O'Reilly Media, Inc., 2015).
* "An Ansible Tutorial." Servers for Hackers. August 26, 2014. Accessed June 24, 2016. https://serversforhackers.com/an-ansible-tutorial
* "Intro to Playbooks." Ansible Docs. June 22, 2016. Accessed June 24, 2016.  http://docs.ansible.com/ansible/playbooks_intro.html
* "Ansible Frequently Asked Questions." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/faq.html
* "Ansible Inventory." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/intro_inventory.html
* "Ansible Variables." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/playbooks_variables.html
* "Ansible Best Practices." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/playbooks_best_practices.html
* "Ansible File Module." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/file_module.html
* "Ansible Template Module." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/template_module.html
* "Ansible Service Module." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/service_module.html