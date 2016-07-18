# Ansible 2
* [Configuration](#configuration)
  * [Inventory](#configuration---inventory)
    * [Variables](#configuration---inventory---variables)
* [Command Usage](#command-usage)
* [Playbooks](#playbooks)
  * [Directory Structure](#playbooks---directory-structure)
  * [Modules](#playbooks---modules)
    * [Command and Shell](#playbooks---modules---command-and-shell)
    * [Files and Templates](#playbooks---modules---files-and-templates)
    * [Service](#playbooks---modules---service)
    * [Package Managers](#playbooks---modules---package-managers)
      * [Yum](#playbooks---modules---package-managers---yum)

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

A Playbook can be self-contained entirely into one file. However, especially for large projects, each segment of the Playbook should be split into seperate files and directories.

* Layout:
```
├── roles/
│   └── general/
│       ├── defaults/
│       │   └── main.yml
│       ├── files/
│       ├── handlers/
│       │   └── main.yml
│       ├── meta/
│       │   └── main.yml
│       ├── tasks/
│       │   └── main.yml
│       ├── templates/
│       └── vars/
│           └── main.yml
└── site.yml
```

* Layout Explained:
```
├── roles/ = This directory should contain all of the different roles.
│   └── general/ = A role name. This can be anything.
│       ├── defaults/ = Define default variables. If any variables are defined elsewhere, these will be overriden.
│       │   └── main.yml = Each main.yml file is executed as the first file. Additional seperation of operations can be split into different files that can be accessed via "include:" statements.
│       ├── files/ = Store static files that are not modified.
│       ├── handlers/ = Specify alias commands that can be called using the "notify:" method.
│       │   └── main.yml
│       ├── meta/ = Specify role depdencies. These can be other roles and/or Playbooks.
│       │   └── main.yml
│       ├── tasks/
│       │   └── main.yml = The tasks' main file is executed first for the entire role.
│       ├── templates/ = Store dynamic files that will be generated based on variables.
│       └── vars/ = Define role-specific variables.
│           └── main.yml
└── site.yml = This is typically the default Playbook file to execute. Any name and any number of Playbook files can be used here to include different roles.
```

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

### Playbooks - Modules - Command and Shell

Both the command and shell modules provide the ability to run command line programs. The big difference is that shell provides a full shell enviornment where operand redirection and pipping works, along with loading up all of the shell variables. Conversely, command will not load a full shell environment so it will lack in features and functionality but it makes up for that by being faster and more efficent. [1]

Common options:
* executable = Set the executable shell binary.
* chdir = Change directories before running the command.

Example:
```
- shell: echo "Hello world" >> /tmp/hello_world.txt
  args:
    executable: /bin/bash
```

Sources:

1. "Ansible Command Module."
2. "Ansible Shell Module."

### Playbooks - Modules - Files and Templates
Both the file and template modules provide ways to managing and configuring various files. The file module is used to handle files that will not be modified [1] and templates are to be used when Ansible will fill in the variables. [2] Most of the attributes are the same between the two.

Common options:
* src = Define the source file or template. If a full path is not given, Ansible will check in the roles/`<ROLENAME>`/files/ directory for a file or roles/`<ROLENAME>`/templates/ for a template.
* dest (or path) = This is the full path to where the file should be copied to on the destination server.
* owner = Set the user owner.
* group = Set the group owner.
* mode = Set the octal or symbloc permissions. If using octal, it has to be four digits. The first digit is generally the flag "0" to indicate no special permissions.
* setype = Set SELinux file permissions.
* state = Specify the state the file should be created in.
  * file = Copy the file.
  * link = Create a soft link shortcut.
  * hard = Create a hard link reference.
  * touch = Create an empty file.
  * directory = Create all subdirectories in the destination folder.
  * absent = Delete destination folders. [1]

Example:
* Copy a template from roles/`<ROLE>`/templates/ and set the permissions for the file.
```
template: src=example.conf.j2 dst=/etc/example/example.conf mode=0644 owner=root group=nobody
```

Sources:

1. "Ansible File Module."
2. "Ansible Template Module."

### Playbooks - Modules - Service
The service module is used to handle system services.

Options:
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

### Playbooks - Modules - Package Managers

Ansible has the ability to add, remove, or update software packages. Almost every popular package manager is supported. [1] This can generically be handled by the "package" module or the specific module for the operating system's package manager.

Options:

* name = Specify the package name.
* state = Specify how to change the package state.
  * present = Install the package.
  * latest = Update the package (or install, if necessary).
  * absent = Uninstall the package.
* use = Specify the package manager to use.
  * auto = Automatically detect the package manager to use. This is the default.
  * apt = Use Debian's Apt package manager.
  * yum = Use Red Hat's yum package manager. [2]

Example:
  * Update the MariaDB package.
```
package: name=mariadb state=latest
```

Sources:

1. "Ansible Packaging Modules."
2. "Ansible Generic OS package manager."

### Playbooks - Modules - Package Managers - Yum

There are two commands to primarily handel Red Hat's Yum package manager: "yum" and "yum_repository."

* yum options:
  * name = Specify the package name.
  * state = Specify the package state.
    * {present|installed|latest} = Any of these will install the package.
    * {absent|removed} = Any of these will uninstall the package.
  * enablerepo = Temporarily enable a repository.
  * disablerepo = Temporarily disable a repository.
  * disable_gpg_check = Disable the GPG check. The default is "no".
  * conf_file = Specify a Yum configuration file to use. [1]

* yum example:
  * Install the "wget" package with the EPEL repository enabled and disable GPG validation checks.
```
yum: name=wget state=installed enablerepo=epel disable_gpg_check=yes
```

* yum_repository options:
  * name = Specify a name for the repository. This is only required if the file is being created (state=present) or deleted (state=absent).
  * baseurl = Provide the URL of the repository.
  * mirrorlist = Provide a URL to a mirrorlist repository instead of the baseurl.
  * description = Required. Provide a description of the repository.
  * enabled = Enable the repository permanently to be active. The default is "yes."
  * exclude = List packages that should be excluded from being accessed from this repository.
  * gpgcheck = Validate the RPMs with a GPG check. The default is "no."
  * gpgkey = Specify a URL to the GPG key.
  * state = Specify a state for the repository file.
    * present = Install the Yum repository file. This is the default.
    * absent = Delete the repository file. [2]

* yum_repository example:
  * Install the RepoForge Yum repository.
```
yum_repository: name=repoforge baseurl=http://apt.sw.be/redhat/el7/en/x86_64/rpmforge/ enabled=no description="Third-party RepoForge packages"
```

Sources:

1. "Ansible Yum Module."
2. "Ansible Yum Repository Module."


---
Sources:

* Lorin Hochstein *Ansible Up & Running* (Sebastopol: O'Reilly Media, Inc., 2015).
* "An Ansible Tutorial." Servers for Hackers. August 26, 2014. Accessed June 24, 2016. https://serversforhackers.com/an-ansible-tutorial
* "Intro to Playbooks." Ansible Documentation. June 22, 2016. Accessed June 24, 2016.  http://docs.ansible.com/ansible/playbooks_intro.html
* "Ansible Frequently Asked Questions." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/faq.html
* "Ansible Inventory." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/intro_inventory.html
* "Ansible Variables." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/playbooks_variables.html
* "Ansible Best Practices." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/playbooks_best_practices.html
* "Ansible File Module." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/file_module.html
* "Ansible Template Module." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/template_module.html
* "Ansible Service Module." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/service_module.html
* "Ansible Packaging Modules." Ansible Documentation. June 22, 2016. Access July 10, 2016. http://docs.ansible.com/ansible/list_of_packaging_modules.html
* "Ansible Generic OS package manager" Ansible Documentation. June 22, 2016. Access July 10, 2016. http://docs.ansible.com/ansible/package_module.html
* "Ansible Yum Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_module.html
* "Ansible Yum Repository Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_repository_module.html
* "Ansible Command Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_repository_module.html
* "Ansible Shell Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_repository_module.html