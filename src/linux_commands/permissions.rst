Permissions
===========

.. contents:: Table of Contents

See also: Firewalls, Security

Users and Groups
----------------

su
~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "\- <USER>", "invokes their bash profile"
   "<USER> -c", "runs a command as the user"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "\- root", "switch to the root user"
   "bob -c 'crontab -l'", "view the crontab for a user by executing a single command as that user"

sg
~~

Temporarily change the current user's primary group.

id
~~

Show user and group information about a user.

groupmems
~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-g <GROUP> -l", "show the members in a group"

useradd
~~~~~~~

Create a new user.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-d", "specify different home directory; default is /home/$USER"
   "-e <DATE>", "specify when the account expires"
   "-f", "specify when the password expires"
   "-G", "adds the user to additional groups"
   "-m", "creates home dir using /etc/skel files"
   "-u", "provide a custom UID"
   "-g", "provide a custom GID"
   "-p", "specifiy an encrypted password"
   "-s", "choose their default shell"
   "-Z", "set the SELinux user for the user's login"

usermod
~~~~~~~

Modify an existing user.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-l", "change the username"
   "-L", "lock an account"
   "-U", "unlock an account"
   "-a -G <GROUP> <USER>", "add a user to a group"
   "-g", "change a user's default group"
   "-Z", "add an SELinux user to the user's login"
   "-Z """"", "removes an SELinux user from the user's login"

userdel
~~~~~~~

Delete users.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-r", "remove all home and mail related files"

passwd
~~~~~~

Manage the password for a user.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--stdin", "use a password from piped standard input"
   "-d", "delete a user's password and make the account usable without a password"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "echo 'newpass' | passwd --stidn", "non-interactively set a password for a user"

groupadd
~~~~~~~~

Create a new group.

groupmod
~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-n", "rename the group"
   "-g", "change the GID"

groupdel
~~~~~~~~

Delete a group.

gpasswd
~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<GROUP>", "change the password for a group"

chage
~~~~~

Manage password expiration.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-l", "list a specified user's account and password expirations"
   "-E YYYY-MM-DD", "set an expiration date for the account"
   "-M", "set the maximum amount of days before a user's password is required to change"

pwck
~~~~

Check for any syntax errors in the /etc/passwd and /etc/shadow. Also verifies if user home directories exist.

vipw
~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-p", "edit the /etc/passwd file; creates a lock file to prevent changes from ""user*"" commands"
   "-s", "edit the /etc/shadow file"
   "-g", "edit the /etc/group file"

authconfig-tui
~~~~~~~~~~~~~~

Terminal user-interface for managing LDAP authentication.

capabilities
~~~~~~~~~~~~

Used to modify special root-specific permissions for files.

Ownership
---------

stat
~~~~

Package: coreutils

Display detailed access and modify time stamp details, full sticky permissions, and some file attributes.

chown
~~~~~

Package: coreutils

Change the user and/or group ownership of a file or directory.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<USER>.<GROUP>", "change file ownership"

chmod
~~~~~

Package: coreutils

Change the octal permissions for user/group/other (ugo) access to a file or directory.

-  + = Add permissions.
-  - = Remove permissions.
-  = = Set exact permissions.

-  a = Modify permissions for user, group, and other (all of them).
-  u = User only.
-  g = Group only.
-  o = Other only.

-  r = Read.
-  w = Write.
-  x = Executable.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "a+X", "modify all users permissions to provide X permission (r, w, and/or x)"
   "u+s OR 4XXX", "setuid; files with this permission are executed as the owner; replace ""XXX"""
   "g+s OR 2XXX", "setgid; folders will create files owned to its group; files with this permission are executed as the group; replace ""XXX"""
   "o+t OR 1XXX", "sticky bit; replace ""XXX"""

getfacl
~~~~~~~

Package: acl

Displays all of the access control lists tied to the file or directory.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-R", "recursively"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-pR /home", "show extended ACLs for all files and directories under /home"

setfacl
~~~~~~~

Package: acl

Change access control lists.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-m u:<USER>:rwx", "give the user full permissions, even if they do not own the file"
   "-m g:<GROUP>:rw", "give the group read and write permissions"
   "-b", "remove all ACLs from the file"

umask
~~~~~

Set the defeault file and folder permissions for creation. The default is 666 for files and 777 for directories. The input value is then substracted from the respective number.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "022", "666 - 022 = 644 permissions for files; 777 - 022 = 755 for folders"
   "-S", "shows symbolic permissions"

lsattr
~~~~~~

List file attributes.

chattr
~~~~~~

Package: e2fsprogs

Change file attributes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "+a", "makes the file appendable only"
   "+C", "disables copy-on-write (CoW) on a file, if CoW is available on the file system"
   "+i", "makes files immutables; it cannot be modified or deleted"
   "+u", "makes a file undeletable"
   "-R", "recursively through multiple files"
   "-V", "output is verbose"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-R +a /var/log*", "make logs only appendable, they cannot be truncated"

setfattr
~~~~~~~~

Package: attr

Create and modify custom file attributes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-n", "provide a name for a new attribute"
   "-v", "provide the value for that attribute"
   "-x", "delete an attribute based on it's name"

SELinux
-------

getenforce
~~~~~~~~~~

View the current SELinux mode.

setenforce
~~~~~~~~~~

Temporarily change the current SELinux mode.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "0", "permissive"
   "1", "enforcing"

sealert
~~~~~~~

Package: setroubleshoot-server

View SELinux warnings and suggested workarounds.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-a", "specify an SELinux audit log"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-a /var/log/audit/audit.log", "view SELinux warnings from the default log file"

semanage
~~~~~~~~

Package: policycoreutils-python-utils

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-h", "show helpful information about the current semanage option"
   "boolean -l", "list SELinux file policies and their status"
   "boolean -m --on", "turn on a SELinux policy"
   "port -l", "list SELinux port policies and their status"
   "port -m -t <POLICY> -p <PROTO> <PORT>", "add an extra port to the specified policy"
   "{enforcing|permissive} -a", "temporarily enable or disable SELinux for a specified context"
   "login -l", "shows SELinux users"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "fcontext", "use the file context permissions..."
   "-a", "...and add a new permission..."
   "-t ", "..with the specified SELinux type and then provide the file to change"

chcon
~~~~~

Temporarily modify SELinux file or directory permissions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-R", "recursively apply new SELinux permissions"
   "--reference=", "copy the SELinux permissions from the referenced file or directory"

restorecon
~~~~~~~~~~

Restore SELinux file permissions.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-R", "recursively apply original SELinux permissions"

setsebool
~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-P", "make changes permanent"

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-P httpd_use_nfs on", "allow Apache to utilize NFS mounts for serving HTTP content"

`History <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/permissions.rst>`__
------------------------------------------------------------------------------------------------------

Bibliography
------------

-  Users and Groups

   -  useradd

      -  https://www.lifewire.com/create-users-useradd-command-3572157

   -  chage

      -  http://www.certdepot.net/sys-change-passwords-and-adjust-password-aging/

   -  chmod

      -  http://www.computerhope.com/unix/uchmod.htm

   -  setfacl

      -  http://www.certdepot.net/sys-manage-acl/

   -  setfattr

      -  https://wiki.archlinux.org/index.php/File_permissions_and_attributes

   -  chcon

      -  http://www.certdepot.net/selinux-diagnose-policy-violations/
