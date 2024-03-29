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
   "--snippet <MODULE>", "provide a YAML template for available options in the module and a brief explanation of each possible option"
   -t lookup -l, show all Ansible lookups
   -t lookup <LOOKUP>, show documentation about a specific lookup

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
   encrypt_string, encrypt a string instead of a file
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

molecule
~~~~~~~~

Package: python3-molecule

A testing framework for Ansible that uses virtual test environments.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   init role -r, create a new role with support for Molecule
   test, "create the test environments, run tests, and then destroy the environment"
   test -s <SCENARIO>, run a full test on a specific scenario
   test --parallel, run tests in parallel
   test --destroy never, run tests but do not destroy the environment when done
   test --all, run a full test on all of the scenarios in the molecule/ directory
   test -d <DRIVER>, run tests with a different driver
   create, create the environment
   destroy, delete the environment
   converge, create the environment and run all of the tests
   login, log into the environment

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

Puppet
-------

All of the Puppet binaries, including Ruby related ones, are installed into ``/opt/puppetlabs/puppet/bin/``.

facter
~~~~~~

Package: puppet-agent

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", display the system facts
   "<FACT>", display a specific fact and it's nested values
   -p, display the system and puppet facts
   -j, output to JSON
   -y, output to YAML
   parser validate, validate a manifest file

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   disks -y, show all of the facts about disks and output them into YAML

puppet
~~~~~~

Package: puppet-agent

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   apply --noop --show_diff <MANIFEST>.pp, run in a dry-run and show the differences of what would have been changed
   --version, show the Puppet version

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/commands/configuration_management.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_commands/configuration_management.rst>`__
