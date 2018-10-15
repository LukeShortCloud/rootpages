Configuration Management
========================

.. contents:: Table of Contents

See also: Administrative, LFH, Shell

Ansible
-------

ansible
~~~~~~~~

Package: ansible

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "all", "connect to all nodes"
   "-m <MODULE> -a '<ARG1>=<VALUE1>'", "run an Ansible module and then provide it arguments"
   "-m ping", "run the ping module to see if Ansible can connect to the inventory"
   "-m shell -a '<SHELL_COMMAND>'", "use the shell module to execute shell commands remotely with use all of the given arguments"
   "-m setup", "show all facts for one host"
   "--ssh-extra-args=''", "specify additional SSH options"
   "-u <USER>", "connect as a specific user"
   "--sudo", "run Ansible tasks via sudo as that user"
   "-e", "specify extras variables in YAML or JSON format"
   "-f", "the number of forked processes to use to run tasks on multiple hosts; the default is to run on 5 hosts at a time; this is similar to the 'serial' module"
   "<GROUP> --list-hosts", "list all hosts in a given inventory group"

ansible-config
~~~~~~~~~~~~~~

Package: ansible >= 2.4

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "view", "view the full configuration file"
   "dump", "view all of the configuration settings that are loaded"
   "list", "view all the available configuration settings and their descriptions"

ansible-doc
~~~~~~~~~~~

Package: ansible

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-l", "list all of the available modules"
   "<MODULE>", "show documentation about a specified <MODULE>"
   "--snippet <MODULE>", "provide a YAML template for available options in the module and a brief explaination of each possible option"

ansible-playbook
~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-i <INVENTORY_FILE>", "specify an inventory (host/group) file"
   "-vvv", "verbose debug logging"
   "--list-tags", "list the tags in the Playbook"
   "--list-hosts", "list all of the hosts that the Playbook will run on"
   "--tags", "run only tasks with a certain tag keyword"
   "--skip-tags", "skip tasks that contain a certain tag"
   "--step", "run a Playbook task-by-task, asking the user if they want to continue"
   "--start-at-task", "start at a specific subtask"
   "--limit <HOST_OR_GROUP>", "limit the Playbook to only run on specific hosts"
   "--limit @<FILE>", "limit the Playbook to only run on specific hosts listed in a file"
   "-e, --extra-vars", "define new or overriding variables"
   "-e @<FILE>", "use variables from a specified file"
   "--diff", "show file and template changes if they replace an existing file"
   "--check", "run a test of the Playbook without making any changes to the remote system"
   "--syntax-check", "verify the syntax of the Playbook"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-e '{""enable_nginx"": true}'", "pass a boolean variable, this can only be done using JSON"

ansible-tower-service
~~~~~~~~~~~~~~~~~~~~~

Package: ansible-tower

Manage all of the Ansible Tower services on a single node.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "status", "show the status for all of the Ansible Tower services"
   "start", ""
   "stop", ""
   "restart", ""

ansible-vault
~~~~~~~~~~~~~

Package: ansible

Use Ansible to manage file encryption for playbooks.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "create", "create a new encrypted file"
   "view", "open an encrypted file as read-only"
   "edit", "open an encrypted file to write"
   "--ask-vault-pass", "display a prompt to get the password from stdin"
   "--vault-password-file <FILE>", "specify the file containing the password"

awx-manage
~~~~~~~~~~~

Package: ansible-tower

The awx-manage command was formerly known as tower-manage. It is used to show and modify internal information about Ansible Tower.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<ARGUMENT> --help", "show the help information for any of tower-manage argument"
   "changepassword <USER>", "change the password for a user"
   "createsuperuser", "create a new administrator user"
   "inventory_import --source=<FILE> --inventory-name=<EXISTING_INVENTORY>", "import a inventory file to an existing Tower inventory"
   "list_instances", "show all Ansible Tower hosts"
   "dbshell", "connect to the PostgreSQL server and open a interactive shell"

setup.sh
~~~~~~~~

Package: ansible-tower-setup-latest.tar.gz

The "setup.sh" script is part of the Ansible Tower setup tarball that is used for installation.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-b", "run the Playbook to backup Tower as a tarball in the current directory"
   "-r", "restore a backup of Tower"

tower-cli
~~~~~~~~~

Package: python2-ansible-tower-cli

A CLI for interfacing with the Ansible Tower API.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "config {host|username|password}", "define the login credentials for accessing Tower"
   "config", "view the configuration file that is being used"
   "--help", "show the available commands"
   "<ARG> --help", "show the help output for a specific argument"
   "--monitor", "show Job output"
   "job_template callback", "provision a Template to the local server"

`Errata <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/configuration_management.rst>`__
------------------------------------------------------------------------------------------------------------------

Bibliography
------------

References:

-  Ansible
  
   -  ansible
   
      -  http://docs.ansible.com/ansible/intro_installation.html#installation
      -  http://docs.ansible.com/ansible/intro_getting_started.html
   
   -  ansible-playbook
   
      -  http://docs.ansible.com/ansible/playbooks_checkmode.html
   
   -  ansible-galaxy
   
      -  http://docs.ansible.com/ansible/galaxy.html
