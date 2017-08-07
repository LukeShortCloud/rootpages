# Ansible 2

* [Introduction](#introduction)
* [Installation](#installation)
* [Configuration](#configuration)
    * [Main](#configuration---main)
    * [Inventory](#configuration---inventory)
        * [Variables](#configuration---inventory---variables)
    * [Vault Encryption](#configuration---vault-encryption)
* [Command Usage](#command-usage)
* [Playbooks](#playbooks)
    * [Directory Structure](#playbooks---directory-structure)
    * [Production and Staging](#playbooks---production-and-staging)
    * [Performance Tuning](#playbooks---performance-tuning)
    * [Jinja2 Templates](#playbooks---jinja2-templates)
        * [Variables](#playbooks---jinja2-templates---variables)
        * [Filters](#playbooks---jinja2-templates---filters)
        * [Comments](#playbooks---jinja2-templates---comments)
        * [Blocks](#playbooks---jinja2-templates---blocks)
        * [Loops](#playbooks---jinja2-templates---loops)
    * [Galaxy](#playbooks---galaxy)
        * [Dependencies](#playbooks---galaxy---dependencies)
    * [Containers](#playbooks---containers)
    * [Main Modules](#playbooks---main-modules)
        * [Assert](#playbooks---main-modules---assert)
        * [Async](#playbooks---main-modules---async)
        * [Check Mode](#playbooks---main-modules---check-mode)
        * [Gather Facts](#playbooks---main-modules---gather-facts)
        * [Handlers and Notify](#playbooks---main-modules---handlers-and-notify)
        * [Roles](#playbooks---main-modules---roles)
        * [Run Once](#playbooks---main-modules---run-once)
        * [Serial](#playbooks---main-modules---serial)
        * [Tags](#playbooks---main-modules---tags)
        * [Tasks](#playbooks---main-modules---tasks)
        * [Wait For](#playbooks---main-modules---wait-for)
        * [When](#playbooks---main-modules---when)
        * [Errors](#playbooks---main-modules---errors)
            * [Any Errors Fatal](#playbooks---main-modules---errors---any-errors-fatal)
            * [Failed When](#playbooks---main-modules---errors---failed-when)
            * [Ignore Errors](#playbooks---main-modules---errors---ignore-errors)
        * [Includes](#playbooks---main-modules---includes)
            * [Include](#playbooks---main-modules---includes---include)
            * [Include Role](#playbooks---main-modules---includes---include-role)
            * [Include Variables](#playbooks---main-modules---includes---include-variables)
        * [Loops](#playbooks---main-modules---loops)
            * [With First Found](#playbooks---main-modules---loops---with-first-found)
            * [With Flattened](#playbooks---main-modules---loops---with-flattened)
            * [With Items](#playbooks---main-modules---loops---with-items)
        * [Variables](#playbooks---main-modules---variables)
            * [Prompts](#playbooks---main-modules---variables---prompts)
            * [Register](#playbooks---main-modules---variables---register)
            * [Set Fact](#playbooks---main-modules---variables---set-fact)
    * [Modules](#playbooks---modules)
        * [Command and Shell](#playbooks---modules---command-and-shell)
        * [Copy, Files, Synchronize, and Templates](#playbooks---modules---copy,-files,-synchronize,-and-templates)
        * [Cron](#playbooks---modules---cron)
        * [Debug](#playbooks---modules---debug)
        * [Git](#playbooks---modules---git)
        * [MySQL Database and User](#playbooks---modules---mysql-database-and-user)
        * [Service](#playbooks---modules---service)
        * [Stat](#playbooks---modules---stat)
        * [Package Managers](#playbooks---modules---package-managers)
            * [Apt](#playbooks---modules---package-managers---apt)
            * [Yum](#playbooks---modules---package-managers---yum)
    * [Galaxy Roles](#playbooks---galaxy-roles)
        * [Network Interface](#playbooks---galaxy-roles---network-interface)
* [Dashboards](#dashboards)
    * [Ansible Tower](#dashboards---ansible-tower)
    * [Open Tower](#dashboards---open-tower)
    * [Semaphore](#dashboards---semaphore)
* [Python API](#python-api)
* [Bibliography](#bibliography)


# Introduction

Ansible is a simple utility for automating system administration tasks via SSH for UNIX-like operating systems. The only requirements are a SSH connection from a control node to a managed node and Python on both nodes. Ansible uses YAML syntax and does not require any knowledge of programming. [1]

There is also support for Windows modules via PowerShell, however, these are not currently documented in this guide. [2]

Sources:

1. "An Ansible Tutorial."
2. "Windows Support."


# Installation

Ansible 2.4 requires Python 2.6, 2.7, or >= 3.5 on both the control and managed nodes. Python 3 support is still in development but should be stable within the next few releases. [1][2]

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
# git checkout remotes/origin/stable-2.3
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


## Configuration - Main

All of the possible configuration files are listed below in the order that they are read. The last file overrides any previous settings.

* Configuration files:
    * `$ANSIBLE_CONFIG` = A command line variable containing the Ansible configuration settings.
    * `ansible.cfg` = If it is in the current directory, it will be used.
    * `~/.ansible.cfg` = The configuration file in a user's home directory.
    * `/etc/ansible/ansible.cfg` = The global configuration file.

* Common settings:
    * [default]
        * ansible_managed = String. The phrase that will be assigned to the `{{ ansible_managed }}` variable. This should generally reside at the top of a template file to indicate that the file is managed by Ansible.
        * ask_pass = Boolean. Default: False. Prompt the user for the SSH password.
        * ask_sudo_pass = Boolean. Default: False. Prompt the user for the sudo password.
        * ask_vault_pass = Boolean. Default: False. Prompt the user for the Ansible vault password.
        * command_warnings = Boolean. Default: True. Inform the user an Ansible module can be used instead of running certain commands.
        * deprecation_warnings = Boolean. Default: True. Show deprecated messages about features that will be removed in a future release of Ansible.
        * display_skipped_hosts = Boolean. Default: True. Show tasks that a skipped host would have run.
        * executable = String. Default: /bin/bash. The shell executable to use.
        * forks = Integer. Default: 5. The number of parallel processes used to run tasks on remote hosts. This is not how many hosts a Playbook or module can run on, that is handled by the "serial" module. This helps to increase the performance of many operations across a large number of remote hosts.
        * host_key_checking = Boolean. Default: True. Do not automatically accept warnings about leaving SSH fingerprints on a connection to a new host.
        * internal_poll_interval = Float. Default: 0.001. The number of seconds to wait before checking on the status of a module that is being executed.
        * inventory = String. Default: /etc/ansible/hosts. The default inventory file to find hosts from.
        * log_path = String. Default: none. The file to log Ansible's operations.
        * nocolor. Boolean. Default: 0. Do not format Ansible output with color.
        * nocows = Boolean. Default: 0. If the `cowsay` binary is present, a Playbook will output information using a cow.
        * hosts = String. Default: \*. The hosts to run a Playbook on if no host is specified. The default is to run on all hosts.
        * private_key_file = String. The private SSH key file to use.
        * remote_port = Integer. Default: 22. The SSH port used for remote connections.
        * remote_tmp = String. Default: ~/.ansible/tmp. The temporary directory on the remote server to save information to.
        * remote_user = String. Default: root. The default `ansible_user` to use for SSH access.
        * roles_path = String. The path to the location of installed roles.
        * sudo_exe = String. Default: sudo. The binary to run to execute commands as a non-privileged user.
        * sudo_user = String. Default: root. The user that sudo should run as.
        * timeout = Integer. Default: 10. The amount of time, in seconds, to wait for a SSH connection to a remote host.
        * vault_password_file = String. The default file to use for the Vault password.
    * [privilege_escalation]
        * become = Boolean. Default: False. This specifies if root level commands should be run by a privileged user.
        * become_method = String. Default: sudo. The method to run root tasks.
        * become_user = String. Default: root. The user to change to to run root tasks.
        * become_ask_pass = Boolean. Default: False. Ask the end-user for a password for the become method.
    * [ssh_connection]
        * ssh_args = String. Additional SSH arguments.
        * retries = Integer. Default: 0 (keep retrying). How many times should an SSH connection attempt to reconnect after a failure.
        * pipelining = Boolean. Default: False. Ansible modules can be combined and sent to the remote host via SSH to help save time and improve performance. This is disabled by default because `sudo` accounts usually have the "requiretty" option enabaled that is not compatible with pipelining.
        * ansible_ssh_executable = String. Default: ssh (found in the $PATH environment variable). The path to the `ssh` binary.

[1]

Source:

1. "Ansible Configuration file."


## Configuration - Inventory

Default file: /etc/ansible/hosts

The hosts file is referred to as the "inventory" for Ansible. Here servers and groups of servers are defined. Ansible can then be used to execute commands and/or Playbooks on these hosts. Groups are created by using brackets "[" and "]" to specify the name.

* Syntax:
```
  <SERVER1NAME> ansible_host=<SERVER1_HOSTNAME>
  
  [<GROUPNAME>]
  <SERVER1NAME>
```

* Example:
```
[dns-us]
dns-us01
dns-us02
dns-us03
```

A sequence of letters "[a:z]" or numbers "[0:9]" can be used to dynamically define a large number of hosts.

* Example:
```
[dns-us]
dns-us[01:03]
```

A group can also be created from other groups by using the ":children" tag.

* Example:
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
* ansible_python_interpreter = This will force Ansible to run on remote systems using a different Python binary. Ansible only supports Python 2 so on server's where only Python 3 is available a custom install of Python 2 can be used instead. [1]
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

Variables that Playbooks will use can be defined for specific hosts and/or groups. The file that stores the variables should reflect the name of the host and/or group. Global variables can be found in the `/etc/ansible/` directory.

* Inventory variable directories and files:
    * host_vars/
        * `<HOST>` = Variables for a host defined in the inventory file.
    * group_vars/
        * `<GROUP>`/
            * vars = Variables for this group.
            * vault = Encrypted Ansible vault variables. [3]
        * all = This file contains variables for all hosts.

It is assumed that the inventory variable files are in YAML format. Here is an example for a host variable file.

* Example:
```
 ---
domain_name: examplehost.tld
domain_ip: 192.168.10.1
hello_string: Hello World!
```

In the Playbook and/or template files, these variables can then be referenced when enclosed by double braces "{{" and "}}". [2]

* Example:
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
7. "Ansible Frequently Asked Questions."


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

* ansible.cfg
    * [defaults]
        * forks = The number of parallel processes that are spun up for remote connections. The default is 5. This should be increased to a larger number to be able to run tasks on many hosts at the same time.
        * pipleining = Enable pipelining to bundle commands together that do not require a file transfer. This is disabled by default because most sudo users are enforced to use the `requiretty` sudo option that pipelining is incompatible with. [1]
        * gathering = Set this to "explicit" to only gather the necessary facts if when/if they are required by the Playbook. [2]

Fact caching will help to cache host information. By only gathering the setup facts information once, this helps to speed up execution time if Ansible will need to run Playbooks on hosts multiple times. The supported types of fact caching are currently memory (none), file (json), and Redis.

All:

* ansible.cfg
    * [defaults]
        * gathering = smart
        * fact_caching = 86400
            * This will set the cache time to 1 day.

File (JSON):

* ansible.cfg
    * [defaults]
        * fact_caching = jsonfile
        * fact_caching_connection = `<TEMPORARY_DIRECTORY_TO_AUTOMATICALLY_CREATE>`

Redis:

* ansible.cfg
    * [defaults]
        * fact_caching = redis
            * As of Ansible 2.3, there is still no way of defining a custom IP and/or port of a Redis server. It is assumed to be running on localhost with the default port.

[3]

Sources:

1. "ANSIBLE PERFORMANCE TUNING (FOR FUN AND PROFIT)."
2. "Ansible Configuration file."
3. "Ansible Variables."


## Playbooks - Jinja2 Templates


### Playbooks - Jinja2 Templates - Variables

Variables defined in Ansible can be single variables, lists, and dictionaries. This can be referenced from the template.

* Syntax:
```
{{ <VARIABLE> }}
```
```
{{ <DICTIONARY>.<KEY> }}
{{ <DICTIONARY>['<KEY>'] }}
```
* Example:
```
{{ certification.name }}
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

* Works
```
  - name: find interface facts
    debug:
      msg: "{{ hostvars[inventory_hostname]['ansible_%s' | format(item)] }}"
    with_items: "{{ ansible_interfaces }}"
```

* Does Not Work
```
  - name: find interface facts
    debug:
      msg: "{{ ansible_%s| format(item)] }}"
    with_items: "{{ ansible_interfaces }}"
```


### Playbooks - Jinja2 Templates - Filters

In certain situations it is desired to apply filters to alert a variable or expression. The syntax for running Jinja filters is `<VARIABLE>|<FUNCTION>(<OPTIONAL_PARAMETERS>)`. Below are some of the more common functions.

* Convert to a different variable type.
```
{{ <VARIABLE>|string }}
```
```
{{ <VARIABLE>|list }}
```
```
{{ <VARIABLE>|int }}
```
```
{{ <VARIABLE>|float }}
```
```
{{ <VARIABLE>|bool }}
```

* Convert a list into a string and optionally separate each item by a specified character.
```
{{ <VARIABLE>|join("<CHARACTER>") }}
```

* Create a default variable if the variable is undefined.
```
{{ <VARIABLE>|default("<DEFAULT_VALUE>")
```

* Convert all characters in a string to lower or upper case.
```
{{ <VARIABLE>|lower }}
```
```
{{ <VARIABLE>|upper }}
```

* Round numbers.
```
{{ <VARIABLE>|round }}
```

* Escape HTML characters.
```
{{ <VARIABLE>|escape }}
```
```
{% autoescape true %}
<html>These HTML tags will be 
escaped and visable via a HTML browser.</html>
{% endautoescape %}
```

* String substitution.
```
{{ "%s %d"|format("I am this old:", 99) }}
```

* Find the first or last value in a list.
```
{{ <LIST>|first }}
```
```
{{ <LIST>|last }}
```

* Find the number of items in a variable.
```
{{ <VARIABLE>|length }}
```

[1]

Source:

1. "Jinja Template Designer Documentation."


### Playbooks - Jinja2 Templates - Comments

Comments are template comments that will be removed when once a template has been generated.

* Syntax:
```
{# #}
```

* Example:
```
{# this is a...
    {% if ip is '127.0.0.1' %}
        <html>Welcome to localhost</html>
    {% endif %}
...example comment #}
```

Sometimes it is necessary to escape blocks of code, especially when dealing with JSON or other similar formats. Jinja will not render anything that is escaped.

* Syntax:
```
''
```
```
{% raw %}
{% endraw %}
```

* Examples:
```
  {{ 'hello world' }}
```
```
  {% raw %}
      {{ jinja.wont.replace.this }}
  {% endraw %}
```


### Playbooks - Jinja2 Templates - Blocks

Templates can extend other templates by replacing "block" elements. At least two files are required. The first file creats a place holder block. The second file contains the content that will fill in that place holder.

* Syntax (file 1):
```
{% block <DESCRIPTIVE_NAME> %}{% endblock %}
```

* Syntax (file 2):
```
{% extends "<FILE1>" %}
{% block <DESCRIPTIVE_NAME> %}
{% endblock %}
```

* Example (file 1):
```
<html>
<h1>{% block header %}{% endblock %}</h1>
<body>{% block body %}{% endblock %}</body>
</html>
```

* Example (file 2):
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

* Syntax:
```
{% for <VALUE> in {{ <LIST_VARIABLE> }} %}
{% endfor %}
```
```
{% for <KEY>, <VAULE> in {{ <DICTIONARY_VARIABLES> }} %}
{% endfor %}
```

* Examples:
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

* Syntax:
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

* Example:
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
        * `<USER_NAME>.<ROLE_PROJECT_NAME>` = The user and project name to use from GitHub.
        * `https://github.com/<USER>/<ROLE_PROJECT_NAME>`
        * `git+https://github.com/<USER>/<ROLE_PROJECT_NAME>.git` = Explicitly use HTTPS for accessing GitHub.
        * `git+ssh://git@<DOMAIN>/<USER>/<ROLE_PROJECT_NAME>.git` = Use SSH for accessing GitHub.
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

Install Ansible Container into a Python virtual environment. This helps to separate Python packages provided by the operating system's package manager. Source the "activate" file to use the new Python environment. [1]
```
$ virtualenv ansible-container
$ source ansible-container/bin/activate
$ pip install -U pip setuptools
$ pip install ansible-container[docker,openshift]
```

* Ansible Container directory structure:
    * container.yml = An Ansible file that mirrors Docker Compose syntax is used to define how to create the Docker container. Common settings include the image to use, ports to open, commands to run, etc.
    * ansible-requirements.txt = Python dependencies to install for Ansible.
    * requirements.yml = Ansible dependencies to install from Ansible Galaxy.
    * ansible.cfg = Ansible configuration for the container.


Example `container.yml`:
```
version: "2"
services:
  web:
    from: "centos:7"
    ports:
      - "80:80"
    command: ["/usr/bin/dumb-init", "/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
    dev_overrides:
      environment:
        - "DEBUG=1"
```

All of the Docker Compose options as specified at [https://docs.docker.com/compose/compose-file/](https://docs.docker.com/compose/compose-file/).

Common `container.yml` options:

* version = The version of Docker Compose to use. Valid options are `1` or `2` since Ansible Container 0.3.0.
```
version: '2'
```
* settings = Project configuration settings.
    * conductor_base = The container to run Ansible from. This should mirror the development environment used for Ansible-Container.
```
  settings:
        conductor_base: centos:7
```
    * deployment_output_path = The directory mounted for placing the generated Ansible Playbook(s). Default: `./ansible-deployment`.
    * project_name = The name of the Ansible project. By default, this will use the name of the directory that the `container.yml` file is in.
* services = This is where one or more Docker containers are defined. A unique name should be provided to each different container. These names are used as the hosts in the Playbook file.
```
services:
    <GROUP_OR_HOST>:
```
```
service:
    mysql:
```
    * image = The Docker image to use for a service.
```
from: "<IMAGE>:<VERSION>"
```
```
from: "ubuntu:xenial"
```
    * roles = A list of Ansible roles to run on the contianer.
```
     roles:
       - <ROLE1>
       - <ROLE2>
```
    * ports = The hypervisor port to bind to and the container port to forward traffic to/from.
```
ports:
 - "4444:443"
```
    * expose = Similar to `ports` but the port forwarding is only done on the hypervisor's localhost address.
    * links = Directly connect container networks for container-to-container traffic.
    * command = Specify a shell command, providing all of the arguments separated via a list. This is the default command run to start the container. If this command stops then the container will be stopped.
```
command: ['<FULL_PATH_TO_CMD>', '<ARG1>', '<ARG2>', '<ARG3>']
```
    * entrypoint = Specify a shell command to run before starting the main `command`. This allows for checks to ensure dependencies are running.
    * depends_on = The services/containers that this container requires before starting. This helps to start services in a specific sequence.
    * volumes = Define all of the bind mounts from the hypervisor to the Docker container.
```
    volumes:
        - <HYPERVISOR_PATH_1>:<CONTAINER_PATH_1>
        - <HYPERVISOR_PATH_2>:<CONTAINER_PATH_2>
```
    * volumes_from = Mount some or all all the same mounts that another container is using.

The Docker container(s) can be created after the `container.yml` file is completed to describe the container deployment.

```
$ ansible-container build
```

[2]

Sources:

1. "Ansible Container README."
2. "Ansible Container."


## Playbooks - Main Modules

Root Pages refers to generic Playbook-related modules as the "main modules." This is not to be confused with official naming of "core modules" which is a mixture of both the main and regular modules mentioned in this guide.


### Playbooks - Main Modules - Assert

Assert is used to check if one or more statements is True. The module will fail if any statement returns False. Optionally, a message can be displayed if any operator comparisons return False.

Syntax:

```
- assert:
    that:
      - "<VALUE1> <COMPARISON_OPERATOR> <VALUE2>"
    msg: "<MESSAGE>"
```

Example:

```
- cmd: /usr/bin/date
  register: date_command
  ignore_errors: True

- assert:
    that:
      - "date_command.rc == 0"
      - "'2017' in date_command.stdout"
    msg: "Date either failed or did not return the correct year."
```

[1]

Source:

1. "Ansible assert - Asserts given expressions are true."


### Playbooks - Main Modules - Async

The "async" function can be used to start a detached task on a remote system. Ansible will then poll the server periodically to see if the task is complete (by default, it checks every 10 seconds). Optionally a custom poll time can be set. [1]

* Syntax:
```
async: <SECONDS_TO_RUN>
```

* Example:
```
 - command: bash /usr/local/bin/example.sh
    async: 15
    poll: 5
```

Source:

1. "Ansible Asynchronous Actions and Polling."


### Playbooks - Main Modules - Check Mode

A Playbook can run in a test mode with `--check`. No changes will be made. Optionally, the `--diff` argument can also be added to show exactly what would be changed.

* Syntax:
```
$ ansible-playbook --check site.yml
```
```
$ ansible-playbook --check --diff site.yml
```

In Ansible 2.1, the `ansible_check_mode` variable was added to verify if check mode is on or off. This can be used to forcefully run tasks even if check mode is on.

* Examples:
```
command: echo "Hello world"
when: not ansible_check_mode
```
```
 - name: Continue if this fails when check_mode is enabled
    stat: path=/etc/neutron/neutron.conf
    register: neutron_conf
    ignore_errors: "{{ ansible_check_mode }}"
```

In Ansible 2.2, the `check_mode` module can be forced to run during a check mode. [1]

* Syntax:
```
check_mode: no
```

* Example:
```
 - name: Install the EPEL repository
    yum: name=epel-release state=latest
    check_mode: no
```


Source:

1. "Ansible Check Mode ("Dry Run")."


### Playbooks - Main Modules - Gather Facts

By default, Ansible will connect to all hosts related to a Playbook and cache information about them. This includes hostnames, IP addresses, the operating system version, etc.

* Syntax:
```
gather_facts: <BOOLEAN>
```

If these variables are not required then gather_facts and be set to "False" to speed up a Playbook's run time. [1]

* Example:
```
gather_facts: False
```

In other situations, information about other hosts may be required that are not being used in the Playbook. Facts can be gather about them before the roles in a Playbook are executed.

* Example:
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


### Playbooks - Main Modules - Handlers and Notify

The `notify` function will run a handler defined in a list of `handlers` if the state of the module it's tied to changes. Optionally, a "listen" directive can be given to multiple handlers. This will allow them all to be executed at once (in the order that they were defined). Handlers cannot have the same name, only the same listen name. This is useful for checking if a configuration file changed and, if it did, then restart the service.

Syntax:

```
handlers:
  - name: <HANDLER_NAME>
    <MODULE>: <ARGS>
    listen: <LISTEN_HANDLER_NAME>

- <MODULE>: <ARGS>
  notify:
    - <HANDLER_NAME>
```

Example:

```
handlers:
  - name: restart nginx
    service: name=nginx state=restarted
    listen: "restart stack"
  - name: restart php-fpm
    service: name=php-fpm state=restarted
    listen: "restart stack"
  - name: restart mariadb
    service: name=mariadb state=restarted
    listen: "restart stack"

- template: src=nginx.conf.j2 dest=/etc/nginx/nginx.conf
  notify: restart stack
```

Source:

1. "Ansible Intro to Playbooks."


### Playbooks - Main Modules - Run Once

In some situations a command should only need to be run on one node. An example is when using a MariaDB Galera cluster where database changes will get synced to all nodes.

* Syntax:
```
run_once: true
```

This can also be assigned to a specific host.

* Syntax:
```
run_once:
delegate_to: <HOST>
```

[1]

Source:

1. "Ansible Delegation, Rolling Updates, and Local Actions."


### Playbooks - Main Modules - Roles

A Playbook consists of roles. Each role that needs to be run needs to be specified. [1] It's important to note that individual roles cannot call other roles. Instead, an "include" statement could be used to find the relative path. [2]

* Syntax:
```
roles:
  - <ROLE1>
  - <ROLE2>
```

* Example:
```
roles:
  - common
  - httpd
  - sql
```

Sources:

1. "Ansible Playbook Roles and Include Statements."
2. "Ansible: Include Role in a Role?"


### Playbooks - Main Modules - Serial

By default, Ansible will only run tasks on 5 hosts at once. This limit can be modified to run on a different number of hosts or a percentage of the amount of hosts. This is useful for running Playbooks on a large amount of servers. [1]

* Syntax:
```
serial: <NUMBER_OR_PERCENTAGE>
```

* Example:
```
 - hosts: web
    tasks:
     - name: Installing Nginx
       package: name=nginx state=present
       serial: 50%
```

Source:

1. "Delegation, Rolling Updates, and Local Actions."


### Playbooks - Main Modules - Tags

Each task in a tasks file can have a tag associated to it. This should be appended to the end of the task. This is useful for debugging and separating tasks into specific groups. Here is the syntax:

* Syntax:
```
tags:
 - <TAG1>
 - <TAG2>
 - <TAG3>
```

Run only tasks that include specific tags.
```
$ ansible-playbook --tags "<TAG1>,<TAG2>,<TAG3>"
```

Alternatively, skip specific tags.

```
$ ansible-playbook --skip-tags "<TAG1>,<TAG2>,<TAG3>"
```

* Example:
```
 $ head webserver.yml
 ---
   - package: name=nginx state=latest
     tags:
      - yum
      - rpm
      - nginx
```
```
$ ansible-playbook --tags "yum" site.yml webnode1
```

[1]

Source:

1. "Ansible Tags."


### Playbooks - Main Modules - Tasks

Playbooks can include specific task files or define and run tasks in the Playbook file itself. In Ansible 2.0, loops, variables, and other dynamic elements now work correctly.

* Syntax:
```
 - hosts: <HOSTS>
    tasks:
      - <MODULE>:
```

* Exmaple:
```
 - hosts: jenkins
    tasks:
      - debug:
          msg: "Warning: This will modify ALL Jenkins servers."
    roles:
      - common
      - docker
```

Source:

1. "Ansible include - include a play or task list."


### Playbooks - Main Modules - Wait For

A condition can be searched for before continuing on to the next task.

* Syntax:
```
wait_for:
```

* Example:
```
wait_for: timeout=60
```

* Common options:
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

The "when" function can be uesd to specify that a sub-task should only run if the condition returns turn. This is similar to an "if" statement in programming langauges. It is usually the last line to a sub-task. [1]

* "When" Example:
```
 - package: name=httpd state=latest
    when: ansible_os_family == "CentOS"
```

* "Or" example:
```
when: ansible_os_family == "CentOS" or when: ansible_os_family == "Debian"
```

* "And" example, using a cleaner style:
```
when: (ansible_os_family == "Fedora") and
      (ansible_distribution_major_version == "25")
```

Source:

1. "Ansible Conditionals."


### Playbooks - Main Modules - Errors

These modules handle Playbook errors.


#### Playbooks - Main Modules - Errors - Any Errors Fatal

By default, a Playbook will continue to run on all of the hosts that do not have any failures reported by modules. It is possible to stop the Playbook from running on all hosts once an error has occurred. [1]

* Syntax:
```
any_errors_fatal: true
```

* Example:
```
 - hosts: nfs_servers
    any_errors_fatal: true
    roles:
     - nfs
```

Source:

1. "Ansible Error Handling In Playbooks."


#### Playbooks - Main Modules - Errors - Failed When

In some situations, a error from a command or module may not be reported properly. This module can be used to force a failure based on a certain condition. [1]

* Syntax:
```
failed_when: <CONDITION>
```

* Example:
```
 - command: echo "Testing a failure. 123."
    register: cmd
    failed_when: "'123' in cmd.stdout"
```

Source:

1. "Ansible Error Handling In Playbooks."


#### Playbooks - Main Modules - Errors - Ignore Errors

Playbooks, by default, will stop running on a host if it fails to run a module. Sometimes a module will report a false-positive or an error will be expected. This will allow the Playbook to continue onto the next step. [1]

* Syntax:
```
ignore_errors: yes
```

* Example:
```
 - name: Even though this will fail, the Playbook will keep running.
    package: name=does-not-exist state=present
    ignore_errors: yes
```

Source:

1. "Ansible Error Handling In Playbooks."


### Playbooks - Main Modules - Includes

Include modules allow other elements of a Playbook to be called and executed.


#### Playbooks - Main Modules - Includes - Include

Other task files and Playbooks can be included. The functions in them will immediately run. Variables can be defined for the inclusion as well. [1]

* Syntax:
```
include:
```
```
include: <TASK>.yml <VAR1>=<VAULE1> <VAR2>=<VALUE2>
```

* Example:
```
include: wine.yml wine_version=1.8.0 compression_format=xz download_util=wget
```

Source:

1. "Ansible Playbook Roles and Include Statements."


#### Playbooks - Main Modules - Includes - Include Role

Starting in Ansible 2.2, other roles can be included in tasks.

* Options:
    * name = Name of the role to include.
    * {defaults|tasks|vars}_from = Include a specific file from the role's defaults, tasks, or vars directory.
    * private = Boolean. Specify if the variables from this role should be available to the rest of the Playbook (False) or not (True).

* Syntax:
```
inlcude_role:
```

* Example:
```
include_role: name=ldap task_from=rhel.yml
```

Source:

1. "Ansible include_role - Load and execute a role."


#### Playbooks - Main Modules - Includes - Include Variables

Additional variables can be defined within a Playbook file. These can be openly added to the `include_vars` module via YAML syntax.

* Options:
    * file = Specify a filename to source variables from.
    * name = Store variables from a file into a specified variable.

* Syntax:
```
include_vars: <VARIABLE>
```

* Examples:
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


### Playbooks - Main Modules - Loops

Loops can be used to iterate through lists and/or dictionaries.


### Playbooks - Main Modules - Loops - With First Found

Multiple file locations can be checked to see what file exists. The first file found in a given list will be returned to the task. [1]


* Syntax:
```
with_first_round:
  - <FLIE1>
  - <FILE2>
  - <FILE3>
```

* Example:
```
 - name: Copy over the first Nova configuration that is found
    copy: src={{ item }} dest=/etc/nova/ remote_src=true
    with_first_found:
      - "/root/nova.conf"
      - "/etc/nova_backup/nova.conf"
```


Source:

1. "Ansible Loops."


### Playbooks - Main Modules - Loops - With Flattened

Lists and dictionaries can be converted into one long string. This allows a task to run once with all of the arguments. This is especially useful for installing multiple packages at once. [1]

* Loop syntax:
```
with_flattened:
   - <LIST_OR_DICT>
   - <LIST_OR_DICT>
```

* Variable syntax:
```
{{ item }}
```

* Example:
```
 - set_fact: openstack_client_packages="[ 'python2-cinderclient', 'python2-glanceclient', python2-keystoneclient', 'python2-novaclient', 'python2-neutronclient' ]"

 - service: name={{ item }} state=restarted
    with_flattened:
     - "{{ openstack_client_packages }}"
     - python2-heatclient
     - [ 'python2-manilaclient', 'python2-troveclient' ]
```

Source:

1. "Ansible Loops."


### Playbooks - Main Modules - Loops - With Items

A task can be re-used with items in a list and/or dictionary. [1]

* Loop syntax:
```
with_items:
  - <ITEM1>
  - <ITEM2>
  - <ITEM3>
```

* List variable syntax:
```
{{ item }}
```

* Dictionary variable syntax:
```
{{ item.<INDEX_STARTING_AT_0> }}
```
```
{{ item.<KEY> }}
```

* List example:
```
 - service: name={{ item }} state=started enabled=true
    with_items:
     - nginx
     - php-fpm
     - mysql
```

* Dictionary example:
```
 - user: name={{ item.name }} group={{ item.group }} password={{ item.2 }} state=present
    with_items:
     - { name: "bob", group: "colab", passwd: "123456" }
     - { name: "sam", group: "colab", passwd: "654321" }
```

Source:

1. "Ansible Loops."


### Playbooks - Main Modules - Variables

These are modules relating to defining new variables.


#### Playbooks - Main Modules - Variables - Prompts

Prompts can be used to assign a user's input as a variable.

* Options:
    * confirm = Prompt the user twice and then verify that the input is the same.
    * encrypt = Encrypt the text.
        * md5_crypt
        * sha256_crypt
        * sha512_crypt
    * salt = Specify a string to use as a salt for encrypting.
    * salt_size = Specify the length to use for a randomly generated salt. The default is 8.

* Syntax:
```
vars_prompt:
  - name: "<VARIABLE>"
    prompt: "<PROMPT TEXT>"
```

* Examples:
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


#### Playbooks - Main Modules - Variables - Register

The output of modules and commands can be saved to a variable.

* Variable return values [1]:
    * backup_file = String. If a module creates a backup file, this is that file's name.
    * changed = Boolean. If something was changed after the module runs, this would be set to "true."
    * failed = Boolean. Shows if the module failed.
    * invocation = Dictionary. This describes the module used to run the operation as well as all of the arguments.
    * msg = String. A message that is optionally given to the end-user.
    * rc = Integer. The return code of a command, shell, or similar module.
    * stderr = String. The standard error of the command.
    * stderr_lines = List. The standard output of the command is separated by the newline characters into a list.
    * stdout = String. The standard output of the command.
    * stdout_lines = List.
    * results = List of dictionaries. If a loop was used, the results for each loop are stored as a new list item.
    * skipped = Boolean. If this module was skipped or not.

* Syntax:
```
register: <NEW_VARIABLE>
```

* Examples [2]:
```
 - command: echo Hello World
    register: hello
 - debug: msg="We heard you"
    when: "'Hello World' in hello.stdout"
```
```
 - copy: src=example.conf dest=/etc/example.conf
    register: copy_example
 - debug: msg="Copying example.conf failed."
    when: copy_example|failed
```


Sources:

1. "Ansible Return Values."
2. "Ansible Error Handling In Playbooks."


#### Playbooks - Main Modules - Variables - Set Fact

New variables can be defined set the "set_fact" module. These are added to the available variables/facts tied to a inventory host. [1]

* Syntax:
```
set_fact:
  <VARIABLE_NAME1>: <VARIABLE_VALUE1>
  <VARIABLE_NAME2>: <VARIABLE_VALUE2>
```

* Example:
```
 - set_fact:
      is_installed: True
      sql_server: mariadb
```

Source:

1. "Ansible Set host facts from a task."


## Playbooks - Modules


### Playbooks - Modules - Command and Shell

Both the command and shell modules provide the ability to run command line programs. The big difference is that shell provides a full shell enviornment where operand redirection and pipping works, along with loading up all of the shell variables. Conversely, command will not load a full shell environment so it will lack in features and functionality but it makes up for that by being faster and more efficent. [1][2]

* Syntax:
```
command:
```
```
shell:
```

* Common options:
    * executable = Set the executable shell binary.
    * chdir = Change directories before running the command.

* Example:
```
 - shell: echo "Hello world" >> /tmp/hello_world.txt
    args:
     executable: /bin/bash
```

Sources:

1. "Ansible Command Module."
2. "Ansible Shell Module."


### Playbooks - Modules - Copy, Files, Synchronize, and Templates

The copy, file and template modules provide ways to managing and configuring various files. The `files` module is used to handle file creation/modification on the remote host. [1] `Templates` are to be used when Ansible needs to find and replace variables [2]. `Copy` is used for copying files and folders either from the role or on the remote host. `Synchronize` is used as a wrapper around rsync to provide a more robust copy functionality. Most of the options and usage are the same between these four modules.

* Syntax:
```
copy:
```
```
file:
```
```
synchronize:
```
```
template:
```

* Common options:

    * src = Define the source file or template. If a full path is not given, Ansible will check in the roles/`<ROLENAME>`/files/ directory for a file or roles/`<ROLENAME>`/templates/ for a template. If the src path ends with a "/" then only the files within that directory will be copied (not the directory itself).
    * dest (or path) = This is the full path to where the file should be copied to on the destination server.
    * owner = Set the user owner.
    * group = Set the group owner.
    * setype = Set SELinux file permissions.


* Copy, file, and template options:
    * mode = Set the octal or symbolic permissions. If using octal, it has to be four digits. The first digit is generally the flag "0" to indicate no special permissions.

* Copy options:

    * remote_src = If set to `true`, the source file will be found on the server Ansible is running tasks on (not the local machine). The default is `false`.

* File options:
    * state = Specify the state the file should be created in.
        * file = Copy the file.
        * link = Create a soft link shortcut.
        * hard = Create a hard link reference.
        * touch = Create an empty file.
        * directory = Create all subdirectories in the destination folder.
        * absent = Delete destination folders.

* Synchronize options:
    * archive = Preserve all of the original file permissions. The default is `yes`.
    * delete = Remove files in the destination directory that do not exist in the source directory.
    * mode
        * push = Default. Copy files from the source to the destination directory.
        * pull = Copy files from the destination to the source directory.
    * recursive = Recursively copy contents of all sub-directories. The default is `no`.
    * rsync_opts = Provide additional `rsync` command line arguments.

* Example:
  * Copy a template from roles/`<ROLE>`/templates/ and set the permissions for the file.
```
template: src=example.conf.j2 dst=/etc/example/example.conf mode=0644 owner=root group=nobody
```

Sources:

1. "Ansible File Module."
2. "Ansible Template Module."
3. "Ansible copy - Copies files to remote locations."
4. "Ansible synchronize - A wrapper around rsync to make common tasks in your playbooks quick and easy."


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

Common options:

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


#### Playbooks - Modules - Package Managers - Apt

Apt is used to install and manage packages on Debian based operating systems.

Common options:

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


#### Playbooks - Modules - Package Managers - Yum

There are two commands to primarily handel Red Hat's Yum package manager: "yum" and "yum_repository."

Syntax:
```
yum:
```

Common options:

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

Common options:


* baseurl = Provide the URL of the repository.
* **description** = Required if `state=present`. Provide a description of the repository.
* enabled = Enable the repository permanently to be active. The default is "yes."
* exclude = List packages that should be excluded from being accessed from this repository.
* gpgcheck = Validate the RPMs with a GPG check. The default is "no."
* gpgkey = Specify a URL to the GPG key.
* includepkgs = A space seperated list of packages that can be used from this repository. This is an explicit allow list.
* mirrorlist = Provide a URL to a mirrorlist repository instead of the baseurl.
* **name** = Required. Specify a name for the repository. This is only required if the file is being created (state=present) or deleted (state=absent).
* reposdir = The directory to store the Yum configuration files. Default: `/etc/yum.repos.d/`.
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


### Playbooks - Modules - Stat

This module provides detailed information about a file, directory, or link. It was designed to be similar to the Unix commmand `stat`. All the information from this module can be saved to a variable and accessed as a from new `<VARIABLE>.stat` dictionary.

* Syntax:
```
stat: path=<FLIE>
register: <STAT_VARIABLE>
```

* Example:
```
 - stat: path=/root/.ssh/id_rsa
    register: id_rsa

 - file: path=/root/.ssh/id_rsa mode=0600 owner=root group=root
    when: id_rsa.stat.mode is not "0600"
```

* Options:
    * checksum_algorithm = The algorithm to use for finding the checksum.
        * sha1 (Default)
        * sha224
        * sha256
        * sha384
        * sha512
    * follow = Follow symbolic links.
    * get_checksum = If the SHA checksum should be generated.
    * get_md5 = Boolean. If the MD5 checksum should be generated.
    * path = Required. String. The full pth to the file.

* `stat` dictionary values:
    * {a|c|m}time = Float. The last time the file was either accessed, the metadata was created, or modified.
    * attributes = List. All of the file attributes.
    * charset = String. The text file encoding format.
    * checksum = String. The has of the path.
    * dev = Integer. The device the inode exists on.
    * {executable|readable|writeable} = Boolean. If the file is executable, readable, or writeable by the remote user that Ansible is running as.
    * exists = Boolean. If the file exists or not.
    * {gr|pw}_name = String. The name of the group or user owner.
    * isblk = Boolean. If the file is a block device.
    * ischr = Boolean. If the file is a character device for standard input or output.
    * isdir = Boolean. If the file is a directory.
    * isfifo = Boolean. If the file is a named pipe.
    * islink = Boolean. If the file is a symbolic link.
    * inode = Integer. The Unix inode number of the file.
    * isreg = Boolean. If the file is a regular file.
    * issock. Boolean. If the file is a Unix socket.
    * is{uid|gid} = Boolean. If the file is owned by the user or group that the remote Ansible user is running as.
    * lnk_source = String. The original path of the symbolic link.
    * md5 = String. The MD5 hash of the file.
    * mime_type = The "magic data" that specifies the file type.
    * mode = Octal Unix file permissions.
    * nlink. Integer. The number of links that are uesd to redirect to the original inode.
    * path = String. The full path to the file.
    * {r|w|x}usr = Boolean. If the user owner has readable, writeable, or executable permissions.
    * {r|w|x}grp = Boolean. If the group owner has readable, writeable, or executable permissions.
    * {r|w|x}oth = Boolean. If other users have readable, writeable, or executable permissions.
    * size = Integer. The size, in bytes, of the file.
    * {uid|gid} = Integer. The ID of user or group owner of hte file.

[1]

Source:

1. "Ansible stat - retrieve file or file system status."


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


## Dashboards - Ansible Tower

Ansible Tower is the official dashboard maintained by Red Hat. A free trial of it can be used to manage up to 10 servers for testing purposes only. A license can be bought to use Tower for managing more servers and to provide support.

Tower can be downloaded from here: https://www.ansible.com/tower-trial. At least a free trial license will be required which can be obtained here: https://www.ansible.com/license.

Once downloaded, it can be installed. This will at least setup a Nginx server and a virtual host for serving Ansible Tower via HTTP.

```
$ tar -x -z -v -f ansible-tower-setup-latest.tar.gz
$ cd ./ansible-tower-setup-<VERSION>/
```

Configure the passwords to use for the various services in the `inventory` file.

* admin_password
* pg_password
* rabbitmq_password

If using an existing PostreSQL and/or RabbitMQ installation, be sure to fill in the connection details to the same `inventory` file. Otherwise, Ansible Tower will install and configure those services on the local machine.

The "ansible" package needs to be available in a package repository. On RHEL systems, the Extra Packages for Enterprise Linux (EPEL) repository should be installed.

```
# yum -y install epel-release
```

Then install Ansible Tower using the setup shell script. This will run an Ansible Playbook to install Tower.

```
$ ./setup.sh
```

When the installation is complete, Ansible Tower can be acccessed by a web browser. The default username is "admin" and the password is the one set in the `inventory` file.

```
https://<SERVER_IP_OR_HOSTNAME>/
```

Source:

1. "Installing Ansible Tower."


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

An unofficial example can also be found at [https://serversforhackers.com/running-ansible-2-programmatically](https://serversforhackers.com/running-ansible-2-programmatically).

Source:

1. Ansible Python API.


---
## Bibliography

* "An Ansible Tutorial." Servers for Hackers. August 26, 2014. Accessed June 24, 2016. https://serversforhackers.com/an-ansible-tutorial
* "Intro to Playbooks." Ansible Documentation. August 4, 2017. Accessed August 6, 2017.  http://docs.ansible.com/ansible/playbooks_intro.html
* "Ansible Frequently Asked Questions." Ansible Documentation. April 21, 2017. Accessed April 23, 2017. http://docs.ansible.com/ansible/faq.html
* "Ansible Inventory." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/intro_inventory.html
* "Ansible Variables." Ansible Documentation. June 1, 2017. Accessed June 17, 2017. http://docs.ansible.com/ansible/playbooks_variables.html
* "Ansible Best Practices." Ansible Documentation. June 4, 2017. Accessed June 4, 2017. http://docs.ansible.com/ansible/playbooks_best_practices.html
* "Ansible File Module." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/file_module.html
* "Ansible Template Module." Ansible Documentation. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/template_module.html
* "Ansible Service Module." Ansible Docs. June 22, 2016. Accessed July 9, 2016. http://docs.ansible.com/ansible/service_module.html
* "Ansible Packaging Modules." Ansible Documentation. June 22, 2016. Access July 10, 2016. http://docs.ansible.com/ansible/list_of_packaging_modules.html
* "Ansible Generic OS package manager" Ansible Documentation. June 22, 2016. Access July 10, 2016. http://docs.ansible.com/ansible/package_module.html
* "Ansible Yum Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_module.html
* "Ansible Yum Repository Module." Ansible Documentation. June 1, 2017. Accessed June 17, 2017. http://docs.ansible.com/ansible/yum_repository_module.html
* "Ansible Command Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_repository_module.html
* "Ansible Shell Module." Ansible Documentation. June 22, 2016. Accessed July 10, 2016. http://docs.ansible.com/ansible/yum_repository_module.html
* "Ansible Debug Module." Ansible Documentation. June 22, 2016. Accessed July 17, 2016. http://docs.ansible.com/ansible/debug_module.html
* "Ansible Git Module." Ansible Documentation. June 22, 2016. Accessed July 30, 2016. http://docs.ansible.com/ansible/git_module.html
* "Ansible Tags." Ansible Documentation. April 21, 2017. Accessed April 22, 2017. http://docs.ansible.com/ansible/playbooks_tags.html
* "Ansible Prompts." Ansible Documentation. August 05, 2016. Accessed August 13, 2016. http://docs.ansible.com/ansible/playbooks_prompts.html
* "Ansible Using Lookups." Ansible Documentation. August 05, 2016. Accessed August 13, 2016. http://docs.ansible.com/ansible/playbooks_lookups.html
* "Ansible Loops." Ansible Documentation. April 12, 2017. Accessed April 13, 2017. http://docs.ansible.com/ansible/playbooks_loops.html
* "Ansible Conditionals." Ansible Documentation. April 12, 2017. Accessed April 13, 2017. http://docs.ansible.com/ansible/playbooks_conditionals.html
* "Ansible Error Handling In Playbooks." Ansible Documentation. August 24, 2016. Accessed August 27, 2016. http://docs.ansible.com/ansible/playbooks_error_handling.html
* "Ansible - some random useful things." Code Poets. August 4, 2014. Accessed August 27, 2016. https://codepoets.co.uk/2014/ansible-random-things/
* "Ansible Become (Privilege Escalation)." Ansible Documentation. August 24, 2016. Accessed August 27, 2016. http://docs.ansible.com/ansible/become.html
* "Ansible Delegation, Rolling Updates, and Local Actions." Ansible Documentation. April 12, 2017. Accessed April 13, 2017. http://docs.ansible.com/ansible/playbooks_delegation.html
* "Ansible Asynchronous Actions and Polling." Ansible Documentation. September 1, 2016. Accessed September 11, 2016. http://docs.ansible.com/ansible/playbooks_async.html
* "Ansible Set host facts from a task." Ansible Documentation. September 1, 2016. Accessed September 11, 2016. http://docs.ansible.com/ansible/set_fact_module.html
* "Ansible Playbook Roles and Include Statements." Ansible Documentation. March 31, 2017. Accessed April 4, 2017. http://docs.ansible.com/ansible/playbooks_roles.html
* "Ansible: Include Role in a Role?" StackOverflow. October 24, 2014. http://stackoverflow.com/questions/26551422/ansible-include-role-in-a-role
* "Ansible cron - Manage cron.d and crontab entries." Ansible Documentation. September 13, 2016. Accessed September 15, 2016. http://docs.ansible.com/ansible/cron_module.html
* "Ansible mysql_db - Add or remove MySQL databases from a remote host." Ansible Documentation. September 28, 2016. Accessed October 1, 2016. http://docs.ansible.com/ansible/mysql_db_module.html
* "Ansible mysql_user - Adds or removes a user from a MySQL database." Ansible Documentation. September 28, 2016. Accessed October 1, 2016. http://docs.ansible.com/ansible/mysql_user_module.html
* "Ansible Installation." Ansible Documentation. October 10, 2016. Accessed October 16, 2016. http://docs.ansible.com/ansible/intro_installation.html
* "Ansible 2.2.0 RC1 is ready for testing." Ansible Development Group. October 3, 2016. Accessed October 16, 2016. https://groups.google.com/forum/#!searchin/ansible-devel/python$203$20support%7Csort:relevance/ansible-devel/Ca07JSmyxIQ/YjFfbb8TAAAJ
* "Jinja Template Designer Documentation." Jinja2 Documentation. Accessed April 23, 2017. http://jinja.pocoo.org/docs/dev/templates/
* "Ansible Vault." Ansible Documentation. October 31, 2016. Accessed November 6, 2016. http://docs.ansible.com/ansible/intro_installation.html
* "Organizing Group Vars Files in Ansible." toja.io
sysadmin, devops and videotapes. Accessed November 6, 2016. http://toja.io/using-host-and-group-vars-files-in-ansible/
* "Ansible Glossary." Ansible Documentation. October 31, 2016. Accessed November 12, 2016. http://docs.ansible.com/ansible/intro_installation.html
* "Ansible Container README." Ansible GitHub. October, 2016. Accessed November 19, 2016. https://github.com/ansible/ansible-container
* "Ansible Container." Ansible Documentation. June 3, 2017. Accessed June 3, 2017. http://docs.ansible.com/ansible-container/
* "Ansible apt - Manages apt-packages." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/apt_module.html
* "Ansible include_vars - Load variables from files, dynamically within a task." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/include_vars_module.html
* "Ansible include_role - Load and execute a role." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/include_role_module.html
* "Ansible wait_for - Waits for a condition before continuing." Ansible Documentation. October 31, 2016. Accessed November 19, 2016. http://docs.ansible.com/ansible/wait_for_module.html
* "The Open Tower Project." Ansible. Accessed December 4, 2016. https://www.ansible.com/open-tower
* "semaphore Installation." GitHub - ansible-semaphore/semaphore. July 25, 2016. Accessed December 3, 2016. https://github.com/ansible-semaphore/semaphore/wiki/Installation
* "Ansible Galaxy." Ansible Documentation. March 31, 2017. Accessed April 4, 2017. http://docs.ansible.com/ansible/galaxy.html
* "ANSIBLE PERFORMANCE TUNING (FOR FUN AND PROFIT)." Ansible Blog. July 10, 2014. Accessed January 25, 2017. https://www.ansible.com/blog/ansible-performance-tuning
* "Ansible Configuration file." Ansible Documentation. April 17, 2017. Accessed April 20, 2017. http://docs.ansible.com/ansible/intro_configuration.html
* "network_interface." MartinVerges GitHub. January 24, 2017. Accessed April 4, 2017. https://github.com/MartinVerges/ansible.network_interface
* "Ansible synchronize - A wrapper around rsync to make common tasks in your playbooks quick and easy." Ansible Documentation. April 12, 2017. Accessed April 13, 2017. http://docs.ansible.com/ansible/synchronize_module.html
* "Ansible Check Mode ("Dry Run")." Ansible Documentation. April 12, 2017. Accessed April 13, 2017. http://docs.ansible.com/ansible/playbooks_checkmode.html
* "Ansible copy - Copies files to remote locations." Ansible Documentation. April 12, 2017. Accessed April 13, 2017. http://docs.ansible.com/ansible/copy_module.html
* "Ansible Return Values." Ansible Documentation. April 17, 2017. Accessed April 18, 2017. http://docs.ansible.com/ansible/common_return_values.html
* "Ansible include - include a play or task list." Ansible Documentation. April 17, 2017. Accessed April 19, 2017. https://docs.ansible.com/ansible/include_module.html
* "Ansible stat - retrieve file or file system status." Ansible Documentation. April 17, 2017. Accessed April 19, 2017. http://docs.ansible.com/ansible/stat_module.html
* "Installing Ansible Tower." Ansible Tower Documentation. April 18, 2017. Accessed April 23, 2017. http://docs.ansible.com/ansible-tower/latest/html/installandreference/tower_install_wizard.html
* "Ansible assert - Asserts given expressions are true." Ansible Documentatoin. August 4, 2017. Accessed August 6, 2017. http://docs.ansible.com/ansible/latest/assert_module.html
* "Ansible Windows Support." Ansible Documentatoin. August 4, 2017. Accessed August 7, 2017. http://docs.ansible.com/ansible/latest/intro_windows.html
* "Ansible Python API." Ansible Documentatoin. August 4, 2017. Accessed August 7, 2017. http://docs.ansible.com/ansible/dev_guide/developing_api.html