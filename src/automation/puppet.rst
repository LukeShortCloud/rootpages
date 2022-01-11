Puppet
=======

.. contents:: Table of Contents

Introduction
------------

Puppet is an automation and configuration management tool. It can be used to push or pull updates to a system. At a minimum, a system needs the ``puppet-agent`` installed to utilize Puppet. A master server/cluster is not required.

This tool fundamentally relies on resources to manage the state of different things on a system. These resources can be bundled into classes, manifests, and modules. In ascending order, these are the various different sections that can make up a module.

-  Resource = Describes the desired state of something (file, package, service, etc.)

   -  Attributes = Properties that the resource should have (ex. permissions, state, etc.)

-  Class = A group of resources.
-  Manifest = The usage of classes. Default variables can be used or overridden here.
-  Module = A group of manifests.

Puppet is written in Ruby and supports the same data types, loops, and conditional statements that the programming language does.

Installation
------------

RHEL/CentOS 7:

-  Puppet 5 repository: ``$ sudo yum install https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm``
-  Puppet 4 repository [2]: ``$ sudo yum install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm``
-  Agent install: ``$ sudo yum install puppet-agent``
-  Master install: ``$ sudo yum install puppet-master``

Verify that Puppet was installed.

.. code-block:: sh

   $ /opt/puppetlabs/bin/puppet --version

[1]

Commands Usage
--------------

See: `Commands - Configuration Management - Puppet <../commands/configuration_management.html#puppet>`__.

Resources
---------

Resources define the state of something. The type, the name/title of the resource to manage, and key-value attributes of it's desired state must be defined. The title must be unique for each resource definition.

::

   RESOURCE_TYPE { RESOURCE_TITLE:
       ATTRIBUTE_KEY => ATTRIBUTE_VALUE,
   }

Most resources support an array of titles to manage. This is useful for creating and managing large sets of packages, services, users, etc.


::

   RESOURCE_TYPE { RESOURCE_TITLE:
       * => $attributes_dictionary
   }

A full list of available resource types and their attributes can be found `here <https://puppet.com/docs/puppet/5.5/type.html>`__.

cron
~~~~

Manage a crontab.

Attributes:

-  command = The command to run on the cron schedule.
-  ensure

   -  absent
   -  present

-  environment = Environment variables to export.
-  target = Specify the full path to a crontab file to manage.
-  user = The user's crontab that should be managed. Default: root.

Attributes, time:

-  hour
-  minute
-  month
-  weekday = The weekday name or integer from 0 to 7 (0 and 7 are both Sunday).
-  special = Specify a special cron schedule such as "annually" or "reboot".

[3]

exec
~~~~

Execute a command.

Attributes:

-  creates = Specify a file that the command should create.
-  cwd = The current working directory to execute the command from.
-  environment = Environment variables to export.
-  logoutput = Specify if Puppet should log the output or not. Set to false for resources that will display sensitive information. Set to on_failure to only log the output if the command failed to execute.
-  onlyif = Change the resource state if a command specified to ``onlyif`` succeeds. This is the opposite of ``unless``.
-  refresh = A different command to run if a notify event from another resource triggers this resource.
-  refreshonly = Only execute this resource if it was explicitly notified to run by another resource. Otherwise, do nothing.
-  returns = The expected return code. Default: 0.
-  timeout = The time, in seconds, before marking a command as failing. Default: 300.
-  tries = The number of times the command should be executed before considering it failed. Default: 1.
-  try_sleep = The number, in seconds, to pause between tries.
-  umask = Set a custom umask before execution.
-  unless = Change the resource state if a command specified to ``unless`` fails. This is the opposite of ``onlyif``.
-  {user|group} = The user or group to run the command as.

[3]

file
~~~~

Manage a file, directory, or symlink.

Attributes:

-  backup = If a backup of a file should be created or not. By default, files will backed up into a local "puppet" filebucket.
-  checksum = The checksum type to use. Default: md5.
-  checksum_value = The expected checksum hash of a file.
-  content = The exact text that the file should contain.
-  ensure

   -  absent
   -  directory = The resource should be a directory.
   -  link = The resource should be a symlink.
   -  present

-  force = Allow the removable of old symlinks and directories.
-  group = The group that should own the file.
-  mode = The octal UNIX permissions mode.
-  owner = The user that should own of the file.
-  purge = Remove files and directories from the destination that are not found in the source directory.
-  recurse (ensure => directory) = If nested directories should also be copied.
-  replace = Replace a file if the contents do not match. Default: true.
-  source = A source file (path or URL) that should be copied to the specified destination.
-  target (ensure => link) = Where the symlink should point to.
-  validate_cmd = The command to run to validate the syntax of a file. Use "%" to indicate the file name from this resource.

Attributes, SELinux:

-  selinux_ignore_defaults
-  selrange
-  selrole
-  selrole
-  seluser

[3]

group
~~~~~

Manage UNIX-like groups.

Attributes:

-  ensure

   -  absent
   -  present

-  gid = The group ID number.
-  members = Users that should be in the group.

[3]

host
~~~~

Manage host entries in ``/etc/hosts``.

-  ensure

   -  absent
   -  present

-  comment = A comment about the hostname entry will be placed near it.
-  host_aliases = An array of all of the desired aliases for the host.
-  ip = The IPv4 or IPv6 address that the host aliases should resolve to.
-  target = The hosts file to modify. Default: /etc/hosts.

[3]

mount
~~~~~

Manage file system mounts including ``/etc/fstab`` entries.

Attributes:

-  atboot = If the device should be mounted on boot.
-  device = The device to mount.
-  dump = Set the file system dump value. Default: 0.
-  ensure

   -  absent
   -  mounted
   -  present or defined
   -  unmounted

-  fstype = The file system type.
-  options = Options for the mount.
-  pass = The number of reboot passes before a file system is re-checked for consistency.
-  remounts = If the mount supports the remount option. If not, Puppet will manually unmount and then mount the device again if required.
-  target = The path to the partition table file. Default: /etc/fstab.

[3]

notify
~~~~~~

Log additional information to the puppet-agent log.

Attributes:

-  message = The message to log.
-  withpath = Show the full path to the manifest that contains this resource.

[3]

package
~~~~~~~

Manage system packages.

Attributes:

-  ensure

   -  absent
   -  latest = Update the package.
   -  held = A package will only be updated if another package resource requires it to be.
   -  present or installed
   -  purged = Uninstall the package and delete the related configuration files.
   -  <VERSION> = Specify the exact package version that should be present.

-  install_options = An array of additional arguments to use with the package manager during installations.
-  reinstall_on_refresh = If the package should be reinstalled when activated by a fresh event. Default: false.
-  provider = The package manager to use.
-  source = A full path to a package to install.
-  uninstall_options = An array of additional arguments to use with the package during uninstalls.

[3]

service
~~~~~~~

Manage system services.

Attributes:

-  binary = For systems that do not use a service management system (such as Upstart or systemd), specify the full path to the binary to use for the service.
-  ensure

   -  running or true
   -  stopped or false

-  enable = If the service should be enabled to start on boot.
-  hasstatus = If the service supports checking it's status. If not, Puppet will look for the resource name from the running processes.
-  hasrestart = If the service supports restarting itself.
-  pattern = Specify a custom pattern for doing the status check (if hasstatus is set to false).
-  restart = Manually specify a custom restart command for the service.
-  start = Manually specify a custom start command for the service.
-  status = Manually specify a custom status command for the service.
-  stop = Manually specify a custom stop command for the service.

[3]

ssh_authorized_keys
~~~~~~~~~~~~~~~~~~~

Manage authorized SSH public keys.

Attributes:

-  ensure

   -  absent
   -  present

-  key = The public key to use.
-  options = Specify custom SSH options.
-  target = The path to the authorized keys file. Default: ${user}/.ssh/authorized_keys.
-  type = The type of encryption used for the public key.
-  user = The user whose public keys should be managed.

[3]

user
~~~~

Manage user accounts.

Attributes:

-  ensure

   -  absent
   -  present
   -  role

-  expiry = The expiration date for the account.
-  gid = The group ID.
-  groups = An array of groups that the user should be added to.
-  home = The full path to the user's home directory.
-  password = The user's password.
-  password_max_age = The number of days before the user's password expires.
-  password_min_age = The number of days a user has to use their current password before changing it.
-  password_warn_days = The number of days to warn a user before their password expires.
-  shell = The shell for the user.
-  uid = The user ID.

[3]

yumrepo
~~~~~~~

Manage Yum repositories.

Attributes:

-  ensure

   -  absent
   -  present

-  baseurl = The full path or URL to the repository.
-  enabled = If the repository should be enabled.
-  exclude = A string of packages that should be ignored from this repository.
-  gpgcheck = If GPG verification checks should be enabled.
-  gpgkey = The full path or URL to the GPG key.
-  includepkgs = A string of packages that should be explicitly included as part of this repository. Ignore the rest.
-  mirrorlist = The URL that contains a list of mirror repositories.
-  mirrorlist_expire = The amount of time, in seconds, before the list of mirrors expires.
-  priority = The priority of the packages in this repository.
-  retries = The number of failed attempts for packages from this repository that is allowed.
-  sslverify = If Yum should verify SSL certificates.

[3]

Metaparameters
--------------

These special attributes can be used with any resource. [4]

Require order:

-  before = Before.
-  require = After.

Refresh order:

-  notify = Before.
-  subscribe = After.

[5]

before
~~~~~~

Specify that another resource has to apply this resource before that resource can run.

Syntax:

::

   RESOURCE_TYPE { RESOURCE_TITLE:
       before => Resource["RESOURCE_DEPENDENCY"],
   }

Example:

::

   package { "docker":
      ensure => installed,
      before => Service["docker"],
   }

   service { "docker":
       ensure => running,
       enable => true,
   }

[4]

notify
~~~~~~

Notify other resources that their state should be changed in the current resource's state changes.

Syntax:

::

   RESOURCE_TYPE { RESOURCE_TITLE:
       notify => Resource["RESOURCE_DEPENDENCY"],
   }

Example:

::

   package { "docker":
      ensure => installed,
      notify => Service["docker"],
   }

   service { "docker":
       ensure => running,
       enable => true,
   }

When requiring a dependency, that resource dependency must be capitalized and then provided the name of that resource.

[4]

require
~~~~~~~

By default, Puppet will parse each resource definition in the order they were defined. Specific orders and dependencies can be set by requiring that one or more resources be completed first before handling the current resource.

Syntax:

::

   RESOURCE_TYPE { RESOURCE_TITLE:
       require => Resource["RESOURCE_DEPENDENCY"],
   }

Example:

::

   package { "docker":
      ensure => installed,
   }

   service { "docker":a
       ensure => running,
       enable => true,
       require => Package['docker'],
   }

[4]

subscribe
~~~~~~~~~

Watch for a change to another resource. If that resource changes then this resource will refresh.

Syntax:

::

   RESOURCE_TYPE { RESOURCE_TITLE:
       subscribe => Resource["RESOURCE_DEPENDENCY"],
   }

Example:

::

   package { "docker":
      ensure => installed,
   }

   service { "docker":
       ensure => running,
       enable => true,
       subscribe => Package["docker"],
   }

[4]

Nodes
-----

Resources can be configured to only run on specific nodes.

Syntax:

::

   node "NODE_HOSTNAME" {
       RESOURCE_TYPE { RESOURCE_TITLE:
           require => Resource["RESOURCE_DEPENDENCY"],
       }
   }

Example:

::

   node "db0" {
       package { "mariadb":
           ensure => installed,
       }
   }

[4]

Functions
---------

The full list of built-in functions in Puppet can be found `here <https://puppet.com/docs/puppet/5.5/function.html>`__. These help to deal with common use cases and/or processing data.

Variables
---------

Puppet uses Facter to find facts about a system. By running the ``facter`` command, it will display all of the facts gathered by the system. Those facts can be accessed inside Puppet using the ``$facts`` dictionary.

Additional custom Facter scripts can be added to ``/opt/puppetlabs/facter/facts.d/``. The output should be in a Ruby-compatible key-value format.

::

   KEY=VALUE

or

::

   KEY => VALUE

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/automation/puppet.rst>`__

Bibliography
------------

1. "About Puppet Platform and its packages." Puppet Documentation. Accessed December 12, 2018. https://puppet.com/docs/puppet/5.5/puppet_platform.html
2. "Installing Puppet agent: Linux." Puppet Documentation. Accessed December 12, 2018. https://puppet.com/docs/puppet/4.10/install_linux.html
3. "Resource Type Reference (Single-Page)." Puppet Documentation. Accessed December 12, 2018. https://puppet.com/docs/puppet/5.5/type.html
4. "Language: Resources." Puppet Documentation. Accessed December 12, 2018. https://puppet.com/docs/puppet/5.5/lang_resources.html
5. "Language: Relationships and ordering." Puppet Documentation. Accessed December 12, 2018. https://puppet.com/docs/puppet/5.5/lang_relationships.html
