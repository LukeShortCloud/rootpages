# Ansible 2

* [Introduction](#introduction)
* [Installation](#installation)
* [Configuration](#configuration)
    * [Inventory](#configuration---inventory)
        * [Variables](#configuration---inventory---variables)
    * [Vault Encryption](#configuration---vault-encryption)
* [Command Usage](#command-usage)
* [Playbooks](#playbooks)
    * [Directory Structure](#playbooks---directory-structure)
    * [Production and Staging](#playbooks---production-and-staging)
    * [Performance Tuning](#playbooks---performance-tuning)
    * [Jinja2 Templates](#playbooks---jinja2-templates)
        * [Loops](#playbooks---jinja2-templates---loops)
    * [Galaxy](#playbooks---galaxy)
        * [Dependencies](#playbooks---galaxy---dependencies)
    * [Containers](#playbooks---containers)
    * [Main Modules](#playbooks---main-modules)
        * [Async](#playbooks---main-modules---async)
        * Check Mode
        * [Ignore Errors](#playbooks---main-modules---ignore-errors)
        * [Include](#playbooks---main-modules---include)
        * [Include Role](#playbooks---main-modules---include-role)
        * [Include Variables](#playbooks---main-modules---include-variables)
        * [Gather Facts](#playbooks---main-modules---gather-facts)
        * [Loops](#playbooks---main-modules---loops)
        * [Prompts](#playbooks---main-modules---prompts)
        * [Roles](#playbooks---main-modules---roles)
        * [Run Once](#playbooks---main-modules---run-once)
        * [Register](#playbooks---main-modules---register)
        * Serial
        * [Set Fact](#playbooks---main-modules---set-fact)
        * [Tags](#playbooks---main-modules---tags)
        * [Wait For](#playbooks---main-modules---wait-for)
        * With First Found
        * [When](#playbooks---main-modules---when)
    * [Modules](#playbooks---modules)
        * [Command and Shell](#playbooks---modules---command-and-shell)
        * [Copy, Files, and Templates](#playbooks---modules---copy,-files,-and-templates)
        * [Cron](#playbooks---modules---cron)
        * [Debug](#playbooks---modules---debug)
        * [Git](#playbooks---modules---git)
        * [MySQL Database and User](#playbooks---modules---mysql-database-and-user)
        * [Service](#playbooks---modules---service)
        * Stat
        * Synchronize
        * [Package Managers](#playbooks---modules---package-managers)
            * [Yum](#playbooks---modules---package-managers---yum)
            * [Apt](#playbooks---modules---package-managers---apt)
    * [Galaxy Roles](#playbooks---galaxy-roles)
        * [Network Interface](#playbooks---galaxy-roles---network-interface)
* [Dashboards](#dashboards)
    * Ansible Tower
    * [Open Tower](#dashboards---open-tower)
    * [Semaphore](#dashboards---semaphore)
* [Python API](#python-api)
* [Bibliography](#bibliography)


# Introduction

Ansible is a utility for managing server deployments and updates. The project is well known for the ease of deploying updated configuration files, it's backwards compatible nature, as well as helping to automate infrastructures. [1] Ansible uses SSH to connect to server's remotely. If an Ansible task is ever re-run on a server, it will verify if the task is truly necessary (ex., if a package already exists). [2] Ansible can be used to create [Playbooks](#playbooks) to automate deployment of configurations and/or services.

Sources:

1. Hochstein, *Ansible Up & Running*, 2.
2. "An Ansible Tutorial."


# Installation

Ansible 2.2 only requires Python 2.4, 2.6, 2.7, or 3.5 on the local host. Python 3 support is still in development but should be stable within the next few releases. [1][2]

RHEL:
```
# yum install epel-release
# yum install ansible
```

Debian:
```
# apt-get install software-properties-common
# apt-add-repository ppa:ansible/ansible
# apt-get update
# apt-get install ansible
```

Source code:
```
# git clone git://github.com/ansible/ansible.git
# cd ansible/
# git branch -a | grep stable
# git checkout remotes/origin/stable-2.2
# git submodule update --init --recursive
# source ./hacking/env-setup
```

Source code updates:
```
# git pull --rebase
# git submodule update --init --recursive
```

[1]

Sources:

1. "Ansible Installation."
2. "Ansible 2.2.0 RC1 is ready for testing."


# Configuration


## Configuration - Inventory

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

Variables are created for a host and/or group using the tag ":vars". Then any custom variable can be defined and associated with a string. A host specifically can also have it's variables defined on the same line as it's Ansible inventory variables. A few examples are listed below. These can also be defined in seperate files as explained in [Configuration - Inventory - Variables](#configuration---inventory---variables).
```
examplehost ansible_user=toor ansible_host=192.168.0.1 custom_var_here=True
```
```
[examplegroup:vars]
domain_name=examplehost.tld
domain_ip=192.168.7.7
```

There are a large number of customizations that can be used to suit most server's access requirements.

Common Inventory Options:

* ansible_host = The IP address or hostname of the server.
* ansible_port = A custom SSH port (i.e., if not using the standard port 22).
* ansible_connection = These options specify how to log in to execute tasks.
    * ssh = Run commands over a remote SSH connection (default).
    * local = Run on the local system.
    * chroot = Run commands in a directory using chroot.
* ansible_user = The SSH user.
* ansible_pass = The SSH user's password. This is very insecure to keep passwords in plain text files so it is recommended to use SSH keys or pass the "--ask-pass" option to ansible when running tasks.
* ansible_ssh_private_key_file = Specify the private SSH key to use for accessing the server(s).
* ansible_ssh_common_args = Append additional SSH command-line arguments for sftp, scp, and ssh.
* ansible_{sftp|scp|ssh}_extra_args = Append arguments for the specified utility.
* ansible_python_interpreter = This will force Ansible to run on remote systems using a different Python binary. Ansible only supports Python 2 so on server's where only Python 3 is available, such as Arch Linux, a custom install of Python 2 can be used instead. [1]
* ansible_vault_password_file = Specify the file to read the Vault password from. [6]
* ansible_become = Set to "true" or "yes" to become a different user than the ansible_user once logged in.
    * ansible_become_method = Pick a method for switching users. Valid options are: sudo, su, pbrun, pfexec, doas, or dzdo.
    * ansible_become_user = Specify the user to become.
    * ansible_become_pass = Optionally ues a password to change users. [5]

Examples:
```
localhost ansible_connection=local
dns1 ansible_host=192.168.1.53 ansilbe_port=2222 ansible_become=true ansible_become_user=root ansible_become_method=sudo
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

Varialbes from other hosts or groups can also be referenced.

* Syntax:
```
{{ groupvars['<GROUPNAME>']['<VARIABLE>'] }}
{{ hostvars['<HOSTNAME>']['<VARIABLE>'] }}
```
```
${groupvars.<HOSTNAME>.<VARIABLE>}
${hostvars.<HOSTNAME>.<VARIABLE>}
```

* Example:
```
command: echo ${hostvars.db3.hostname}
```

Variables can be defined as a list or nested lists.

* Syntax:
```
<VARIABLE>: [ '<ITEM1>', '<ITEM2>', '<ITEM3>' ]
```
```
<VARIABLE>:
 - [ [ '<ITEMA>', '<ITEMB>' ] ]
 - [ [ '<ITEM1>', '<ITEM2>' ] ]
```

* Examples:
```
colors: [ 'blue', 'red', 'green' ]
```
```
cars:
 - [ 'sports', 'sedan' ]
 - [ 'suv', 'pickup' ]
```

Lists can be called by their array position, starting at "0." Alternatively they can be called by the subvariable name.

* Syntax:
```
{{ item.0 }}
```
```
{{ item.0.<SUBVARIABLE> }}
```

* Example:
```
members:
 - name: Frank
   contact:
    - address: "111 Puppet Drive"
    - phone: "1111111111"
```
```
 - debug: msg="Contact {{ item.name }} at {{ item.contact.phone }}"
   with_items:
    - {{ members }}
```

[4]

Using a variable for a variable name is not possible with Jinja templates. Only substitution for dictionary keys can be done with format substitution. [7]

Works
```
  - name: find interface facts
    debug:
      msg: "{{ hostvars[inventory_hostname]['ansible_%s' | format(item)] }}"
    with_items: "{{ ansible_interfaces }}"
```

Does Not Work
```
  - name: find interface facts
    debug:
      msg: "{{ ansible_%s| format(item)] }}"
    with_items: "{{ ansible_interfaces }}"
```

The order that variables take precedence in is listed below. The bottom locations get overriden by anything above them.

* extra vars
* task vars
* block vars
* role and include vars
* set_facts
* registered vars
* play vars_files
* play vars_prompt
* play vars
* host facts
* playbook host_vars
* playbook group_vars
* inventory host_vars
* inventory group_vars
* inventory vars
* role defaults

[2]

Sources:

1. "Ansible Inventory"
2. "Ansible Variables."
3. "Ansible Best Practices."
4. "Ansible Loops."
5. "Ansible Become (Privlege Escalation)"
6. "Ansible Vault."
7. "How to loop through interface facts."


## Configuration - Vault Encryption

Any file in a Playbook can be encrypted. This is useful for storing sensitive username and passwords securely. A password is used to open these files after encryption. All encrypted files in a Playbook should use the same password.


Vault Usage:

* Create a new encrypted file.
```
$ ansible-vault create <FILE>.yml
```

* Encrypt an existing plaintext file.
```
$ ansible-vault encrypt <FILE>.yml
```

* Viewing the contents of the file.
```
$ ansible-vault view <FILE>.yml
```

* Edit the encrypted file.
```
$ ansible-vault edit <FILE>.yml
```

* Change the password.
```
$ ansible-vault rekey <FILE>.yml
```

* Decrypt to plaintext.
```
$ ansible-vault decrypt <FILE>.yml
```

Playbook Usage:

* Run a Playbook, prompting the user for the Vault password.
```
$ ansible-playbook --ask-vault-pass <PLAYBOOK>.yml
```
* Run the Playbook, reading the file for the vault password.
```
$ ansible-playbook --vault-password-file <PATH_TO_VAULT_PASSWORD_FILE> <PLAYBOOK>.yml
```

[1]

Source:

1. "Ansible Vault."


## Command Usage
Refer to Root Page's "Linux Commands" guide in the "Deployment" section.


# Playbooks

Playbooks organize tasks into one or more YAML files. It can be a self-contained file or a large project organized in a directory. Official examples can he found here at [https://github.com/ansible/ansible-examples](https://github.com/ansible/ansible-examples).


## Playbooks - Directory Structure

A Playbook can be self-contained entirely into one file. However, especially for large projects, each segment of the Playbook should be split into separate files and directories.

Layout:
```
├── production/
│   ├── group_vars/
│   ├── host_vars/
│   └── inventory
├── staging/
│   ├── group_vars/
│   ├── host_vars/
│   └── inventory
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

Layout Explained:

* production/ = A directory that contains information about the Ansible-controlled hosts and inventory variables. This should be used for deploying to live production environments. Alternatively, simple Playbooks can use a "production" file to list all of the inventory servers there.
    * group_vars/ = Group specific variables. A file named "all" can be used to define global variables for all hosts.
    * host_vars/ = Host specific variables.
    * inventory = The main "production" inventory file.
* staging/ = The same as the "production/" directory except this is designed for running Playbooks in testing environments.
* roles/ = This directory should contain all of the different roles.
    *  general/ = A role name. This can be anything.
        * defaults/ = Define default variables. If any variables are defined elsewhere, these will be overriden.
            * main.yml = Each main.yml file is executed as the first file. Additional separation of operations can be split into different files that can be accessed via "include:" statements.
        * files/ = Store static files that are not modified.
        * handlers/ = Specify alias commands that can be called using the "notify:" method.
            * main.yml
        * meta/ = Specify role dependencies and Playbook information such as author, version, etc. These can be other roles and/or Playbooks.
            *  main.yml
        * tasks/
            * main.yml = The tasks' main file is executed first for the entire role.
        * templates/ = Store dynamic files that will be generated based on variables.
        * vars/ = Define role-specific variables.
            * main.yml
* site.yml = This is typically the default Playbook file to execute. Any name and any number of Playbook files can be used here to include different roles.


Examples:

* site.yml = This is generally the main Playbook file. It should include all other Playbook files required if more than one is used. [2]
```
 # FILE: site.yml
 ---
 include: nginx.yml
 include: php-fpm.yml
```
```
 # FILE: nginx.yml
 ---
 - hosts: webnodes
   roles:
     - common
     - nginx
```

* roles/`<ROLENAME>`/vars/main.yml = Global variables for a role.
```
 ---
 memcache_hosts=192.168.1.11,192.168.1.12,192.168.1.13
 ldap_ip=192.168.10.1
```

* group_vars/ and host_vars/ = These files define variables for hosts and/or groups. Details about this can be found in the [Variables](#configuration---inventory---variables) section.

* templates/ = Template configuration files for services. The files in here end with a ".j2" suffix to signify that it uses the Jinja2 template engine. [1]
```
<html>
<body>My domain name is {{ domain }}</body>
</html>
```

Sources:

1. "An Ansible Tutorial."
2. “Ansible Best Practices.”


## Playbooks - Production and Staging

Ansible best practices suggest having a separation between a production and staging inventory. Changes should be tested in the staging environment and then eventually ran on the production server(s).

### Scenario #1 - Use the Same Variables

A different invetory file can be created if all of the variables are the exact same in the production and staging environments. This will run the same Playbook roles on a different server.

Syntax:
```
├── production
├── staging
├── group_vars
│   ├── <GROUP>
├── host_vars
│   ├── <HOST>
```
```
$ ansible-playbook -i proudction <PLAYBOOK>.yml
```
```
$ ansible-playbook -i staging <PLAYBOOK>.yml
```

Example:
```
├── production
├── staging
├── group_vars
│   ├── web
│   ├── db
│   ├── all
├── host_vars
│   ├── web1
│   ├── web2
│   ├── db1
│   ├── db2
│   ├── db3
```

### Scenario #2 - Use Different Variables

In more complex scenarios, the inventory and variables will be different in production and staging. This requires further separation. Instead of using a "production" or "staging" inventory file, they can be split into directories. These directories contain their own group and host variables.

Syntax:
```
├── production
│   ├── group_vars
│   │   ├── <GROUP>
│   ├── host_vars
│   │   ├── <HOST>
│   └── inventory
```
```
├── staging
│   ├── group_vars
│   │   ├── <GROUP>
│   ├── host_vars
│   │   ├── <HOST>
│   └── inventory
```
```
$ ansible-playbook -i proudction <PLAYBOOK>.yml
```
```
$ ansible-playbook -i staging <PLAYBOOK>.yml
```

Example:
```
├── production
│   ├── group_vars
│   │   ├── web
│   │   ├── db
│   │   ├── all
│   ├── host_vars
│   │   ├── web1
│   │   ├── web2
│   │   ├── db1
│   │   ├── db2
│   │   ├── db3
│   └── inventory
```
```
├── staging
│   ├── group_vars
│   │   ├── web
│   │   ├── db
│   │   ├── all
│   ├── host_vars
│   │   ├── web1
│   │   ├── web2
│   │   ├── db1
│   │   ├── db2
│   │   ├── db3
│   └── inventory
```

Sources:

1. "Ansible Best Practices."
2. "Organizing Group Vars Files in Ansible."


## Playbooks - Performance Tuning

A few configuration changes can help to speed up the runtime of Ansible modules and Playbooks.

* /etc/ansible/ansible.cfg
    * forks = The number of parallel processes that are spun up for remote connections. The default is 5. This should be increased to a larger number to be able to run tasks on many hosts at the same time.
    * pipleining = Enable pipelining to bunble commands together that do not require a file transfer. [1]
    * gathering = Set this to "explicit" to only gather the necessary facts if when/if they are required by the Playbook. [2]

Sources:

1. "ANSIBLE PERFORMANCE TUNING (FOR FUN AND PROFIT)."
2. "Configuration file."


## Playbooks - Jinja2 Templates

* Variables defined in Ansible can be single variables, lists, and dictionaries. This can be referenced from the template.
  * Variable Syntax:
```
{{ dict.value }}
{{ dict['value'] }}
```

* Comments are template comments that will be removed when once a template has been generated.
  * Comment Syntax:
```
{# #}
```
  * Comment Example:
```
  {# this is a...
  	{% if ip is '127.0.0.1' %}
      	<html>Welcome to localhost</html>
      {% endif %}
  ...example comment #}
```

* Sometimes it is necessary to escape blocks of code, especially when dealing with JSON or other similar formats. Jinja will not render anything that is escaped.
  * Escaping Syntax:
```
''
```
```
{% raw %}
{% endraw %}
```
  * Escaping Examples:
```
  {{ 'hello world' }}
```
```
  {% raw %}
      {{ jinja.wont.replace.this }}
  {% endraw %}
```

Templates can extend other templates by replacing "block" elements. At least two files are required. This first file defines where the blocks will be. The second file specifies that it should extend the first file and then defines the same blocks full of content that will be replaced in the first file.

Syntax (file 1):
```
{% block <DESCRIPTIVE_NAME> %}{% endblock %}
```

Syntax (file 2):
```
{% extends "<FILE1>" %}
{% block <DESCRIPTIVE_NAME> %}
{% endblock %}
```

Parent (file 1) example:
```
<html>
<h1>{% block header %}{% endblock %}</h1>
<body>{% block body %}{% endblock %}</body>
</html>
```
Child (file 2) example:
```
{% extends "index.html" %}
{% block header %}
Hello World
{% endblock %}
{% block body %}
Welcome to the Hello World page!
{% endblock %}
```

### Playbooks - Jinja2 Templates - Loops

Loops can use standard comparison and/or logic operators.

Comparison Operators:

* `==`
* `!=`
* `>`
* `>=`
* `<`
* `=<`

Logic Operators:

* `and`
* `or`
* `not`

"For" loops can be used to loop through a list or dictionary.

Syntax:
```
{% for <VALUE> in {{ <LIST_VARIABLE> }} %}
{% endfor %}
```
```
{% for <KEY>, <VAULE> in {{ <DICTIONARY_VARIABLES> }} %}
{% endfor %}
```

Examples:
```
# /etc/hosts
{% for host in groups['ceph'] %}
hostvars[host]['private_ip'] hostvars[host]['ansible_hostname']
{% endfor %}
```
```
{% for count in range(1,4) %}
[{{ groups['db'][{{ count }}] }}]
type=server
priority={{ count }}
{% endfor %}
```

"For" loops have special variables that can be referenced relating to the index that the loop is on.

* loop.index = The current index of the loop, starting at 1.
* loop.index0 = The current index of the loop, starting at 0.
* loop.revindex = The same as "loop.index" but in reverse order.
* loop.revindex = The same as "loop.index0" but in reverse order.
* loop.first = This will be True if it is the first index.
* loop.last = This will be True if is it the last index.

"If" statements can be run if a certain condition is met.

Syntax:
```
{% if <VALUE> %}
{% endif %}
```
```
{% if <VALUE_1> %}
{% elif <VALUE_2> %}
{% else %}
{% endif %}
```

Example:
```
{% if {{ taco_day }} == "Tuesday" %}
	Taco day is on Tuesday.
{% else %}
    Taco day is not on a Tuesday.
{% endif %}
```

[1]

Source:

1. "Jinja Template Designer Documentation."


## Playbooks - Galaxy

Ansible Galaxy provides a way to easily manage local roles and remote Ansible Galaxy roles from [https://galaxy.ansible.com/](https://galaxy.ansible.com/). [1]

```
$ ansible-galaxy install <USER_NAME>.<ROLE_NAME>
```
```
$ ansible-galaxy install <USER_NAME>.<ROLE_NAME>,<VERSION>
```
```
$ ansible-galaxy install --roles-path <PATH> <USER_NAME>.<ROLE_NAME>
```

For a Playbook to work with Ansible Galaxy it is required to have the `meta/main.yml` file. This will define supported Ansible versions and systems, role dependencies, the license, and other useful information. [2]

```
galaxy_info:
  author:
  description:
  company:
  license:
  min_ansible_version:
  platforms:
   - name: <OS_NAME>
  versions:
   - <OS_VERSION>
  categories:
  dependencies:
    - { role: <ROLE_NAME> }
    - { role: <ROLE_NAME>, <VARIABLE>: <VALUE> }
```

Sources:

1. "Ansible Galaxy."
2. "Ansible Playbook Roles and Include Statements."


### Playbooks - Galaxy - Dependencies

Roles can define dependencies to other roles hosted remotely. By default, the Ansible Galaxy repository is used to pull roles from. Ansible Galaxy in itself uses GitHub.com as it's backend. Dependencies can be defined in `requirements.yml` or inside the role at `meta/main.yml`.

Install the dependencies by running:

```
$ ansible-galaxy install -r requirements.yml
```

* Dependency options:
    * src = The role to use. Valid formats are:
        * `<USER_NAME>.<ROLE_NAME>`
        * `https://github.com/<USER>/<ROLE_NAME>`
        * `git+https://github.com/<USER>/<ROLE_PROJECT_NAME>.git`
    * version = The branch, tag, or commit to use. Default: master.
    * name = Provide the role a new custom name.
    * scm = The supply chain management (SCM) tool to use. Currently only Git (git) and Mercurial (hg) are supported. This is useful for using projects that are not hosted on GitHub.com. Default: git.

Dependency syntax:

```
dependencies:
  - src: <USER_NAME>.<ROLE_NAME>
    version: <VERSION>
    name: <NEW_ROLE_NAME>
    scm: <SCM>
  - src: <USER_NAME2>.<ROLE_NAME2>
```


Dependency example:

```
- src: https://github.com/hux/starkiller
  version: 3101u9e243r90adf0a98avn4bmz
  name: new_deathstar
- src: https://example.tld/project
  scm: hg
  name: project
```

Git with SSH example (useful for GitLab):

```
- src: git+ssh://git@<DOMAIN>/<USER>/<PROJECT>.git
  version: 1.2.0
  scm: git
```

[1]


Source:

1. "Ansible Galaxy."


## Playbooks - Containers

The offical Ansible Container project aims to allow Playbooks to be deployed directly to Docker containers. This allows Ansible to orchestrate both infrastructure and applications.

Install Ansible Container into a Python virtual environment. This helps to separate Python packages provided by the operating system's package manager. [1]
```
$ virtualenv ansible-container
$ ansible-container/bin/pip install -U pip setuptools
$ ansible-container/bin/pip install ansible-container
```

Ansible Container Directory Structure:

* ansible/ = The "ansible-container" command should be run in the directory above "ansible."
    * container.yml = An Ansible file that mirrors Docker Compose syntax is used to define how to create the Docker container. Common settings include the image to use, ports to open, commands to run, etc.
    * requirements.txt = Python dependencies to install.
    * requirements.yml = Ansible dependencies to install from Ansible Galaxy.
    * ansible.cfg = Ansible configuration for the container.


container.yml
```
version: "2"
services:
  web:
    image: "ubuntu:trusty"
    ports:
      - "80:80"
    command: ["/usr/bin/dumb-init", "/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
    dev_overrides:
      environment:
        - "DEBUG=1"
```

All of the Docker Compose options as specified at [https://docs.docker.com/compose/compose-file/](https://docs.docker.com/compose/compose-file/).

Common options:

* version = The version of Docker Compose to use. Valid options are "1", "2", and "2.1."
* services = This is where various Docker containers can be defined. A unique name should be provided to each different container. These names are used as the hosts in the Playbook file.
```
services:
    https:
```
```
 - hosts: https
```
* ports = Specify the host node port to map to the container port.
```
ports:
 - "443:443"
```
* image = The Docker image to use.
```
image: "centos:7"
```
* command = Run a shell command, providing all of the arguments separated via a list. This is the default command run to start the container.

[2]

Sources:

1. "Ansible Container README."
2. "Ansible Container."


## Playbooks - Main Modules

Root Pages refers to generic Playbook-related modules as the "main modules." This is not to be confused with official naming of "core modules" which is a mixture of both the main and regular modules mentioned in this guide.


### Playbooks - Main Modules - Async

The "async" function can be used to start a detached task on a remote system. Ansible will then poll the server periodically to see if the task is complete (by default, it checks every 10 seconds). Optionally a custom poll time can be set.

Syntax:
```
async: <SECONDS_TO_RUN>
```

Example #1:
```
- command: bash /usr/local/bin/example.sh
  async: 15
  poll: 5
```

[1]

Source:

1. "Ansible Asynchronous Actions and Polling."


### Playbooks - Main Modules - Gather Facts

By default, Ansible will connect to all hosts related to a Playbook and cache information about them. This includes hostnames, IP addresses, the operating system version, etc.

Syntax:
```
gather_facts: <BOOLEAN>
```

If these variables are not required then gather_facts and be set to "False" to speed up a Playbook's run time. [1]

Example:
```
gather_facts: False
```

In other situations, information about other hosts may be required that are not being used in the Playbook. Facts can be gather about them before the roles in a Playbook are executed.

Example:
```
- hosts: squidproxy1,squidproxy2,squidproxy3
  gather_facts: True

- hosts: monitor1,monitor2
  roles:
   - common
   - haproxy
```

Source:

1. "Ansible Glossary."


### Playbooks - Main Modules - Loops

Loops are a great way to reuse modules with multiple items. Essentially these are "for" loops. These loops can even utilize flattened lists to run an action on multiple items at once.

Variable syntax:
```
{{ item }}
```

Loop syntax:
```
with_items:
  - <ITEM1>
  - <ITEM2>
  - <ITEM3>
```

Example:
```
package: name={{ item }} state=latest
with_items:
 - nginx
 - php-fpm
 - mysql
```

Flattened example:
```
---
# variables
web_services: [ 'nginx', 'httpd', 'mysql' ]
```
```
service: name={{ item }} state=restarted
with_flattened:
 - "{{ web_services }}"
```

[1]

Source:

1. "Ansible Loops."


### Playbooks - Main Modules - Include

Other task files and Playbooks can be included. The functions in them will immediately run. Variables can be defined for the inclusion as well. [1]

Syntax:
```
include:
```
```
include: <TASK>.yml <VAR1>=<VAULE1> <VAR2>=<VALUE2>
```

Example:
```
include: wine.yml wine_version=1.8.0 compression_format=xz download_util=wget
```

Source:

1. "Ansible Playbook Roles and Include Statements."


### Playbooks - Main Modules - Include Role

Starting in Ansible 2.2, other roles can be included in tasks.

Options:

* name = Name of the role to include.
* {defaults|tasks|vars}_from = Include a specific file from the role's defaults, tasks, or vars directory.
* private = Boolean. Specify if the variables from this role should be available to the rest of the Playbook (False) or not (True).

Syntax:
```
inlcude_role:
```

Example:
```
include_role: name=ldap task_from=rhel.yml
```

Source:

1. "Ansible include_role - Load and execute a role."


### Playbooks - Main Modules - Include Variables

Additional variables can be defined within a Playbook file. These can be openly added to the `include_vars` module via YAML syntax.

Options:

* file = Specify a filename to source variables from.
* name = Store variables from a file into a specified variable.

Syntax:
```
include_vars: <VARIABLE>
```

Examples:
```
- hosts: all
  include_vars:
   - gateway: "192.168.0.1"
   - netmask: "255.255.255.0"
  roles:
    - addressing
```
```
- hosts: all
  include_vars: file=monitor_vars.yml
  roles:
    - nagios
```

Source:

1. "Ansible include_vars - Load variables from files, dynamically within a task."


### Playbooks - Main Modules - Ignore Errors

Playbooks, by default, will stop running if it fails to run a command. If it's okay to continue then the "ignore_errors" option can be appeneded below the command. This will allow the Playbook to continue onto the next step.

Syntax:
```
ignore_errors: <BOOLEAN>
```

Example:
```
ignore_errors: yes
```

Source:

1. "Ansible Error Handling In Playbooks."


### Playbooks - Main Modules - Prompts

Prompts can be used to assign a user's input as a variable.

Syntax:
```
vars_prompt:
  - name: "<VARIABLE>"
    prompt: "<PROMPT TEXT>"
```

Options:

* confirm = Prompt the user twice and then verify that the input is the same.
* encrypt = Encrypt the text.
    * md5_crypt
    * sha256_crypt
    * sha512_crypt
* salt = Specify a string to use as a salt for encrypting.
* salt_size = Specify the length to use for a randomly generated salt. The default is 8.

Examples:
```
vars_prompt:
  - name: "zipcode"
    prompt: "Enter your zipcode."
```
```
vars_prompt:
  - name: "pw"
    prompt: "Password:"
    encrypt: "sha512_crypt"
    salt_size: 12
```

[1]

Source:

1. "Ansible Prompts."


### Playbooks - Main Modules - Run Once

In some situations a command should only need to be run on one node. A good example is when using a MariaDB Galera cluster where database changes will get synced to all nodes.

Syntax:
```
run_once: true
```

This can also be assigned to a specific node.
```
run_once:
delegate_to: <HOST>
```

[1]

Source:

1. "Ansible Delegation, Rolling Updates, and Local Actions."


### Playbooks - Main Modules - Roles

A Playbook consists of roles. Each role that needs to be run needs to be specified. [1] It's important to note that individual roles cannot call other roles. Instead, an "include" statement could be used to find the relative path. [2]

Syntax:
```
roles:
  - <ROLE1>
  - <ROLE2>
```

Example:
```
roles:
  - common
  - httpd
  - sql
```

Sources:

1. "Ansible Playbook Roles and Include Statements."
2. "Ansible: Include Role in a Role?"


### Playbooks - Main Modules - Register

The output of commands can be saved to a variable. The attributes that are saved are:

* changed = If something was ran, this would be set to "true."
* stdout = The standard output of the command.
* stdout_lines = The standard output of the command is separated by the newline characters into a list.
* stderr = The standard error of the command.

[1]

The result of an action is saved as one of these three values. They can then be referenced later.

* succeeded
* failed
* skipped

[3]

Syntax:
```
register: cmd_output
```

Example #1:
```
- command: echo Hello World
  register: hello
- debug: msg="We heard you"
  when: "'Hello World' in hello.stdout"
```
[2]

Example #2:
```
- copy: src=example.conf dest=/etc/example.conf
  register: copy_example
- debug: msg="Copying example.conf failed."
  when: copy_example|failed
```

[3]

Sources:

1. "Ansible - some random useful things."
2. "Ansible Error Handling In Playbooks."
3. "Ansible Conditionals."


### Playbooks - Main Modules - Set Fact

New variables can be defined set the "set_fact" module. These are added to the available variables/facts tied to a inventory host.

Syntax:
```
set_fact:
  <VARIABLE_NAME1>: <VARIABLE_VALUE1>
  <VARIABLE_NAME2>: <VARIABLE_VALUE2>
```

Example:
```
- set_fact:
    is_installed: True
    sql_server: mariadb
```

Sources:

1. "Ansible Set host facts from a task."


### Playbooks - Main Modules - Tags

Each task in a tasks file can have a tag associated to it. This should be appended to the end of the task. This is useful for debugging and separating tasks into specific groups. Here is the syntax:

Single tag syntax:
```
tags: <TAG>
```

Multiple tags syntax:
```
tags:
 - <TAG1>
 - <TAG2>
 - <TAG3>
```
Run only tasks with the defined tasks:
```
# ansible-playbook --tags <TAG1,TAG2,TAG3,etc.>
```
Example:
```
# head webserver.yml
---
- package: name=nginx state=latest
  tags:
   - yum
   - rpm
   - nginx
```
```
# ansible-playbook --tags yum webserver.yml webnode1
```

[1]

Source:

1. "Ansible Tags."


### Playbooks - Main Modules - Wait For

A condition can be searched for before continuing on to the next task.

Syntax:
```
wait_for:
```

Example:
```
wait_for: timeout=60
```

Common options:

* delay = How long to wait (in seconds) before running the wait_for check.
* path = A file to check.
* host = A host to check a connection to.
* port = A port to check on the specified host.
* connect_timeout = How long to wait (in seconds) before retrying the connection.
* search_regex = A regular expression string to match from either a port or file.
* state
    * started = Check for a open port.
    * stopped = Check for a closed port.
    * drained = Check for active connections to the port.
    * present = Check for a file.
    * absent = Verify a file does not exist.
* timeout = How long to wait (in seconds) before continuing on.

Source:

1. "Ansible wait_for - Waits for a condition before continuing."


### Playbooks - Main Modules - When

The "when" function can be uesd to specify that a sub-task should only run if the condition returns turn. This is similar to an "if" statement in programming langauges. It is usually the last line to a sub-task.

"When" Example:
```
- package: name=httpd state=latest
  when: ansible_os_family == "CentOS"
```
"Or" example:
```
when: ansible_os_family == "CentOS" or when: ansible_os_family == "Debian"
```
"And" example, using a cleaner style:
```
when: (ansible_os_family == "Fedora") and
      (ansible_distribution_major_version == "25")
```

[1]

Source:

1. "Ansible Conditionals."


## Playbooks - Modules


### Playbooks - Modules - Command and Shell

Both the command and shell modules provide the ability to run command line programs. The big difference is that shell provides a full shell enviornment where operand redirection and pipping works, along with loading up all of the shell variables. Conversely, command will not load a full shell environment so it will lack in features and functionality but it makes up for that by being faster and more efficent. [1]

Syntax:
```
command:
```
```
shell:
```

Common options:
* executable = Set the executable shell binary.
* chdir = Change directories before running the command.

Example:
```
- shell: echo "Hello world" >> /tmp/hello_world.txt
  args:
    executable: /bin/bash
```

Source:

1. "Ansible Command Module."
2. "Ansible Shell Module."


### Playbooks - Modules - Copy, Files, and Templates

The copy, file and template modules provide ways to managing and configuring various files. The file module is used to handle file creation/modification [1], templates are to be used when Ansible needs to fill in the variables [2] and copy is used for copying files and folders. Most of the attributes are the same between the three modules.

Syntax:
```
copy:
```
```
files:
```
```
templates:
```

Common options:

* src = Define the source file or template. If a full path is not given, Ansible will check in the roles/`<ROLENAME>`/files/ directory for a file or roles/`<ROLENAME>`/templates/ for a template. If the src path ends with a "/" then only the files within that directory will be copied (not the directory itself).
* dest (or path) = This is the full path to where the file should be copied to on the destination server.
* remote_src = If set to True, the source file will be found on the server Ansible is running tasks on (not the local machine). The default is False.
* owner = Set the user owner.
* group = Set the group owner.
* mode = Set the octal or symbolic permissions. If using octal, it has to be four digits. The first digit is generally the flag "0" to indicate no special permissions.
* setype = Set SELinux file permissions.
* state = Specify the state the file should be created in.
  * file = Copy the file.
  * link = Create a soft link shortcut.
  * hard = Create a hard link reference.
  * touch = Create an empty file.
  * directory = Create all subdirectories in the destination folder.
  * absent = Delete destination folders. [1]

* Example:
  * Copy a template from roles/`<ROLE>`/templates/ and set the permissions for the file.
```
template: src=example.conf.j2 dst=/etc/example/example.conf mode=0644 owner=root group=nobody
```

Sources:

1. "Ansible File Module."
2. "Ansible Template Module."


### Playbooks - Modules - Debug

The debug module is used for helping facilitate troubleshooting. It prints out specified information to standard output.

Syntax:
```
debug:
```

Options:
  * msg = Display a message.
  * var = Display a variable.
  * verbosity = Show more verbose information. The higher the number, the more verbose the information will be. [1]

* Example:
  * Print Ansible's hostname of the current server that the script is being run on.
```
debug: msg=The inventory host name is {{ inventory_hostname }}
```

Source:

1. "Ansible Debug Module."


### Playbooks - Modules - Cron

The cron module is used to manage crontab entries. Crons are scheduled/automated tasks that run on Unix-like systems.

Syntax:
```
cron:
```

Options:
* user = Modify the specified user's crontab.
* job = Provide a command to run when the cron reaches the correct
* minute
* hour
* weeekday = Specify the weekday as a number 0 through 6 where 0 is Sunday and 6 is Saturday.
* month
* day = Specify the day number in the 30 day month.
* backup = Backup the existing crontab. The "backup_file" variable provides the backed up file name.
    * yes
    * no
* state
    * present = add the crontab
    * absent = remove an existing entry
* special_time
    * reboot
    * yearly or annually
    * monthly
    * weekly
    * daily
    * hourly

Example #1:
```
cron: job="/usr/bin/wall This actually works" minute="*/1" user=ubuntu
```

Example #2:
```
cron: job="/usr/bin/yum -y update" weekday=0 hour=6 backup=yes
```

[1]

Source:

1. "Ansible cron - Manage cron.d and crontab entries."


### Playbooks - Modules - Git

Git is a utlity used for provisioning and versioning software. Ansible has built-in support for handling most Git-related tasks.

Syntax:
```
git:
```

Options:

* repo = The full path of the repository.
* dest = The path to place/use the repository
* update = Pull the latest version from the Git server. The default is "yes."
* version = Switch to a different branch or tag.
* ssh_opts = If using SSH, specify custom SSH options.
* force = Override local changes. The default is "yes."

Source:

1. "Ansible Git Module"


### Playbooks - Modules - Service

The service module is used to handle system services.

Syntax:

```
service:
```

Options:

* name = Specify the service name.
* enabled = Enable the service to start on boot or not. Valid options are "yes" or "no."
* sleep = When restarted a service, specify the amount of time (in seconds) to wait before starting a service after stopping it.
* state = Specify what state the service should be in.
  * started = Start the service.
  * stopped = Stop the service.
  * restarted = Stop and then start the service.
  * reloaded = If supported by the service, it will reload it's configuration file without restarting it's main thread. [1]

Example:

* Restart the Apache service "httpd."
```
service: name=httpd state=restarted sleep=3
```

Source:

1. "Ansible Service Module."


### Playbooks - Modules - MySQL Database and User

MySQL databases and users can be managed via Ansible. It requires the "MySQLdb" Python library and the "mysql" and "mysqldump" binaries.

MySQL Database Syntax:
```
mysql_db:
```

MySQL User Syntax:
```
mysql_user:
```

Options:
* name = Specify the database name. The word "all" can be used to control all databases.
* state
  * present = Create the database.
  * absent = Delete the database.
  * dump = Backup the database.
  * import = Import a database.
* target = Specify a dump or import location.
* config_file = Speicfy the user configuration file. Default: "~/.my.cnf." Alternatively, login credentials can be manually specified.
* login_host = The MySQL server's IP or hostname. Default: "localhost."
* login_user = The MySQL username to login as.
* login_password = The MySQL user's password.
* login_port = The MySQL port to connect to. Default: "3306."
* login_unix_socket = On Unix, a socket file can be used to connect to MySQL instead of a host and port.
* connection_timeout = How long to wait (in seconds) before closing the MySQL connection. The default is "30." [1]
* priv (mysql_user) = The privileges for the MySQL user. [2]

Example #1:
```
mysql_db: name=toorsdb state=present config_file=/secrets/.my.cnf
```

Example #2:
```
mysql_user: name=toor login_user=root login_password=supersecret priv=somedb.*:ALL state=present
```

Example #3:
```
mysql_user: name=maxscale host="10.0.0.%" priv="*.*:REPLICATION CLIENT,SELECT" password=supersecure123 state=present
```

Sources:

1. "Ansiblem mysql_db - Add or remove MySQL databases from a remote host."
2. "Ansible mysql_user - Adds or removes a user from a MySQL database."


### Playbooks - Modules - Package Managers

Ansible has the ability to add, remove, or update software packages. Almost every popular package manager is supported. [1] This can generically be handled by the "package" module or the specific module for the operating system's package manager.

Syntax:
```
package:
```

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

Yum Syntax:
```
yum:
```

Options:
* name = Specify the package name.
* state = Specify the package state.
  * {present|installed|latest} = Any of these will install the package.
  * {absent|removed} = Any of these will uninstall the package.
* enablerepo = Temporarily enable a repository.
* disablerepo = Temporarily disable a repository.
* disable_gpg_check = Disable the GPG check. The default is "no".
* conf_file = Specify a Yum configuration file to use. [1]

Example:
* Install the "wget" package with the EPEL repository enabled and disable GPG validation checks.
```
yum: name=wget state=installed enablerepo=epel disable_gpg_check=yes
```

Yum Repository Syntax:
```
yum_repository:
```

Options:
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

Example:
* Install the RepoForge Yum repository.
```
yum_repository: name=repoforge baseurl=http://apt.sw.be/redhat/el7/en/x86_64/rpmforge/ enabled=no description="Third-party RepoForge packages"
```

Sources:

1. "Ansible Yum Module."
2. "Ansible Yum Repository Module."


### Playbooks - Modules - Package Managers - Apt

Apt is used to install and manage packages on Debian based operating systems.

Options:

* name = The package name.
* state
    * present = Install the package.
    * latest = Update the package.
    * absent =  Uninstall the package.
    * build-dep = Install the build depedencies for the source code.
* update_cache = Update the Apt cache (apt-get update). Default: no.
* deb = Install a specified *.deb file.
* autoremove = Remove all dependencies that are no longer required.
* purge = Delete configuration files.
* install_recommends = Install recommended packages.
* upgrade
    * no = Do not upgrade any system packages (default).
    * yes  = Update all of the system packages (apt-get upgrade).
    * full = Update all of the system packages and uninstall older, conflicting packages (apt-get full-upgrade).
    * dist = Upgrade the operating system (apt-get dist-upgrade).

Source:

1. "apt - Manages apt-packages."


## Playbooks - Galaxy Roles

Unofficial community roles can be used within Playbooks. Most of these can be found on [Ansible Galaxy](https://galaxy.ansible.com/) or [GitHub](https://github.com/).


### Playbooks - Galaxy Roles - Network Interface

URL: https://github.com/MartinVerges/ansible.network_interface

The `network_interface` role was created to help automate the management of network interfaces on Debian and RHEL based systems. The most up-to-date and currently maintained fork of the original project is owned by the [GitHub user MartinVerges](https://github.com/MartinVerges).

The role can be passed any of these dictionaries to configure the network devices.

* network_ether_interfaces = Configure ethernet devices.
* network_bridge_interfaces = Configure bridge devices.
* network_bond_interfaces = Configure bond devices.
* network_vlan_interfaces = Configure VLAN devices.

Valid dictionary values:

* device = Required. This should define the device name to modify or create.
* bootproto = Required. `static` or `dhcp`.
* address = Required for `static`. IP address.
* netmask = Required for `static`. Subnet mask.
* cidr = For `static`. Optionally use CIDR notation to specify the IP address and subnet mask.
* gateway = The default gateway for the IP address.
* hwaddress = Use a custom MAC address.
* mtu = Specify the MTU packet size.
* vlan = Set to `True` for creating the VLAN devices.
* bond_ports = Required for bond interfaces. Specify the ethernet devices to use for the unified bond.
* bond_mode = For bond interfaces. Define the type of Linux bonding method.
* bridge_ports = Required for bridge interfaces. Specify the ethernet device(s) to use for the bridge.
* dns-nameserver = A Python list of DNS nameservers to use.

Here is an example.

* `eth0` is configured to use DHCP and has it's MTU set to 9000.
* `eth1` is added to the new bridge `br0` with the IP address `10.0.0.1` and the subnet mask of `255.255.255.0`.
* `eth2` and `eth3` are configured to be in a bond, operating in mode "6" (adapative load balancing).
* `bond0.10` and `bond0.20` are created as VLAN tagged devices off of the newly created bond.

```
- hosts: gluster01
  roles:
   - ansible.network_interfaces
     network_ether_interfaces:
      - device: eth0
        bootproto: dhcp
        mtu: 9000
     network_bridge_interfaces:
      - device: br0
        cidr: 10.0.0.1/24
        bridge_ports: [ "eth1" ]
     network_bond_interfaces:
      - device: bond0
        bootproto: static
        bond_mode: 6
        bond_ports: [ "eth2", "eth3" ]
     network_vlan_interfaces:
      - device: bond0.10
        vlan: True
        bootproto: static
      - device: bond0.20
        vlan: True
        bootproto: static
```

Source:

1. "network_interface."


# Dashboards

Various dashboards are available that provide a graphical user interface (GUI) and usually an API to help automate Ansible deployments. These can be used for user access control lists (ACLs), scheduling automated tasks, and having a visual representation of Ansible's deployment statistics.


## Dashboards - Open Tower

Red Hat is currently in the process of creating Open Tower, a free and open source version of Ansible Tower. As of December 2016, this has not been released yet. [1]

Source:

1. "The Open Tower Project."


## Dashboards - semaphore

semaphore was designed to be an unofficial open source altnerative to Ansible Tower. The latest release can be found at [https://github.com/ansible-semaphore/semaphore/releases](https://github.com/ansible-semaphore/semaphore/releases).

Installation
```
# curl -L https://github.com/ansible-semaphore/semaphore/releases/download/v2.0.4/semaphore_linux_amd64 > /usr/bin/semaphore
# /usr/bin/semaphore -setup
```
[1]

Source:

1. "semaphore Installation."



# Python API

Ansible is written in Python so it can be used programactically to run Playbooks. This does not provide a thread-safe interface and is subject to change depending on the needs of the actual Ansible utilies. It is recommended to use a RESTful API from a dashboard for other languages or more advanced tasks. Below is an example from the official documentation of using the Python library for Ansible 2 [1]:

```
#!/usr/bin/env python

import json
from collections import namedtuple
from ansible.parsing.dataloader import DataLoader
from ansible.vars import VariableManager
from ansible.inventory import Inventory
from ansible.playbook.play import Play
from ansible.executor.task_queue_manager import TaskQueueManager
from ansible.plugins.callback import CallbackBase

class ResultCallback(CallbackBase):
    """A sample callback plugin used for performing an action as results come in

    If you want to collect all results into a single object for processing at
    the end of the execution, look into utilizing the ``json`` callback plugin
    or writing your own custom callback plugin
    """
    def v2_runner_on_ok(self, result, **kwargs):
        """Print a json representation of the result

        This method could store the result in an instance attribute for retrieval later
        """
        host = result._host
        print json.dumps({host.name: result._result}, indent=4)

Options = namedtuple('Options', ['connection', 'module_path', 'forks', 'become', 'become_method', 'become_user', 'check'])
# initialize needed objects
variable_manager = VariableManager()
loader = DataLoader()
options = Options(connection='local', module_path='/path/to/mymodules', forks=100, become=None, become_method=None, become_user=None, check=False)
passwords = dict(vault_pass='secret')

# Instantiate our ResultCallback for handling results as they come in
results_callback = ResultCallback()

# create inventory and pass to var manager
inventory = Inventory(loader=loader, variable_manager=variable_manager, host_list='localhost')
variable_manager.set_inventory(inventory)

# create play with tasks
play_source =  dict(
        name = "Ansible Play",
        hosts = 'localhost',
        gather_facts = 'no',
        tasks = [
            dict(action=dict(module='shell', args='ls'), register='shell_out'),
            dict(action=dict(module='debug', args=dict(msg='{{shell_out.stdout}}')))
         ]
    )
play = Play().load(play_source, variable_manager=variable_manager, loader=loader)

# actually run it
tqm = None
try:
    tqm = TaskQueueManager(
              inventory=inventory,
              variable_manager=variable_manager,
              loader=loader,
              options=options,
              passwords=passwords,
              stdout_callback=results_callback,  # Use our custom callback instead of the ``default`` callback plugin
          )
    result = tqm.run(play)
finally:
    if tqm is not None:
        tqm.cleanup()
```

Sources:

1. http://docs.ansible.com/ansible/dev_guide/developing_api.html
2. https://serversforhackers.com/running-ansible-2-programmatically

---
## Bibliography

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
* "Ansible Debug Module." Ansible Documentation. June 22, 2016. Accessed July 17, 2016. http://docs.ansible.com/ansible/debug_module.html
* "Ansible Git Module." Ansible Documentation. June 22, 2016. Accessed July 30, 2016. http://docs.ansible.com/ansible/git_module.html
* "Ansible Tags." Ansible Documentation. August 05, 2016. Accessed August 13, 2016. http://docs.ansible.com/ansible/playbooks_tags.html
* "Ansible Prompts." Ansible Documentation. August 05, 2016. Accessed August 13, 2016. http://docs.ansible.com/ansible/playbooks_prompts.html
* "Ansible Using Lookups." Ansible Documentation. August 05, 2016. Accessed August 13, 2016. http://docs.ansible.com/ansible/playbooks_lookups.html
* "Ansible Loops." Ansible Documentation. August 05, 2016. Accessed August 13, 2016. http://docs.ansible.com/ansible/playbooks_loops.html
* "Ansible Conditionals." Ansible Documentation. August 24, 2016. Accessed August 27, 2016. http://docs.ansible.com/ansible/playbooks_conditionals.html
* "Ansible Error Handling In Playbooks." Ansible Documentation. August 24, 2016. Accessed August 27, 2016. http://docs.ansible.com/ansible/playbooks_error_handling.html
* "Ansible - some random useful things." Code Poets. August 4, 2014. Accessed August 27, 2016. https://codepoets.co.uk/2014/ansible-random-things/
* "Ansible Become (Privilege Escalation)." Ansible Documentation. August 24, 2016. Accessed August 27, 2016. http://docs.ansible.com/ansible/become.html
* "Ansible Delegation, Rolling Updates, and Local Actions." Ansible Documentation. September 1, 2016. Accessed September 11, 2016. http://docs.ansible.com/ansible/playbooks_delegation.html
* "Ansible Asynchronous Actions and Polling." Ansible Documentation. September 1, 2016. Accessed September 11, 2016. http://docs.ansible.com/ansible/playbooks_async.html
* "Ansible Set host facts from a task." Ansible Documentation. September 1, 2016. Accessed September 11, 2016. http://docs.ansible.com/ansible/set_fact_module.html
* "Ansible Playbook Roles and Include Statements." Ansible Documentation. March 31, 2017. Accessed April 4, 2017. http://docs.ansible.com/ansible/playbooks_roles.html
* "Ansible: Include Role in a Role?" StackOverflow. October 24, 2014. http://stackoverflow.com/questions/26551422/ansible-include-role-in-a-role
* "Ansible cron - Manage cron.d and crontab entries." Ansible Documentation. September 13, 2016. Accessed September 15, 2016. http://docs.ansible.com/ansible/cron_module.html
* "Ansible mysql_db - Add or remove MySQL databases from a remote host." Ansible Documentation. September 28, 2016. Accessed October 1, 2016. http://docs.ansible.com/ansible/mysql_db_module.html
* "Ansible mysql_user - Adds or removes a user from a MySQL database." Ansible Documentation. September 28, 2016. Accessed October 1, 2016. http://docs.ansible.com/ansible/mysql_user_module.html
* "Ansible Installation." Ansible Documentation. October 10, 2016. Accessed October 16, 2016. http://docs.ansible.com/ansible/intro_installation.html
* "Ansible 2.2.0 RC1 is ready for testing." Ansible Development Group. October 3, 2016. Accessed October 16, 2016. https://groups.google.com/forum/#!searchin/ansible-devel/python$203$20support%7Csort:relevance/ansible-devel/Ca07JSmyxIQ/YjFfbb8TAAAJ
* "Jinja Template Designer Documentation." Jinja2 Documentation. Accessed October 23, 2016. http://jinja.pocoo.org/docs/dev/templates/
* "Ansible Vault." Ansible Documentation. October 31, 2016. Accessed November 6, 2016. http://docs.ansible.com/ansible/intro_installation.html
* "Organizing Group Vars Files in Ansible." toja.io
sysadmin, devops and videotapes. Accessed November 6, 2016. http://toja.io/using-host-and-group-vars-files-in-ansible/
* "Ansible Glossary." Ansible Documentation. October 31, 2016. Accessed November 12, 2016. http://docs.ansible.com/ansible/intro_installation.html
* "Ansible Container README." Ansible GitHub. October, 2016. Accessed November 19, 2016. https://github.com/ansible/ansible-container
* "Ansible Container." Ansible Documentation. September 26, 2016. Accessed November 19, 2016 .http://docs.ansible.com/ansible-container/
* "Ansible apt - Manages apt-packages." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/apt_module.html
* "Ansible include_vars - Load variables from files, dynamically within a task." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/include_vars_module.html
* "Ansible include_role - Load and execute a role." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/include_role_module.html
* "Ansible wait_for - Waits for a condition before continuing." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/wait_for_module.html
* "The Open Tower Project." Ansible. Accessed December 4, 2016. https://www.ansible.com/open-tower
* "semaphore Installation." GitHub - ansible-semaphore/semaphore. July 25, 2016. Accessed December 3, 2016. https://github.com/ansible-semaphore/semaphore/wiki/Installation
* "How to loop through interface facts." Server Fault. March 7, 2016. Accessed December 8, 2016. http://serverfault.com/questions/762079/how-to-loop-through-interface-facts
* "Ansible Galaxy." Ansible Documentation. March 31, 2017. Accessed April 4, 2017. http://docs.ansible.com/ansible/galaxy.html
* "ANSIBLE PERFORMANCE TUNING (FOR FUN AND PROFIT)." Ansible Blog. July 10, 2014. Accessed January 25, 2017. https://www.ansible.com/blog/ansible-performance-tuning
* "Configuration file." Ansible Documentation. January 25, 2017. Accessed January 25, 2017. http://docs.ansible.com/ansible/intro_configuration.html
* "network_interface." MartinVerges GitHub. January 24, 2017. Accessed April 4, 2017. https://github.com/MartinVerges/ansible.network_interface