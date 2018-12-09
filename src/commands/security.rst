Security
========

.. contents:: Table of Contents

See also: Firewalls, Permissions

Anti-Virus
----------

clamscan
~~~~~~~~

A free and open source anti-virus command line utility. Run "freshclam" to update the anti-virus database.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-r", "recurisvely through folders"
   "-i", "only output infected files"
   "--move=<PATH>", "specify path to move infected files to"

Audit
-----

Package: audit

For Audit to work properly, the service needs to be started.

.. code-block:: sh

    $ sudo systemctl start auditctl

auditctl
~~~~~~~~

Log verbose modifications and access to a file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-w", "watch a file"
   "-p arwx", "watch for appending, reading, writing and executing of the file"

ausearch
~~~~~~~~

used after setting up auditctl on a file

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-f", "views log of a given file"
   "-t", "check for changes during a certain time"


Kerberos
--------

kadmin (Command)
~~~~~~~~~~~~~~~~

Package: krb5-workstation

Manage the Kerberos Distribution Center (KDC).

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-q", "run interactive commands"

kadmin (Interactive)
~~~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "?", "view the available commands"
   "addprinc <USER>", "create a new principal for a user"
   "addprinc host/<HOTSNAME>", "create a new principal to allow authentication from a server"
   "addprinc nfs/<HOSTNAME>", "create an NFS principal"
   "addprinc cifs/<HOSTNAME>", "create a CIFS/SMB principal"
   "addprinc ftp/<HOSTNAME>", "create a FTP principal"
   "ktadd host/<HOSTNAME>", "save the principal to the /etc/krb5.keytab file"
   "ktremove  host/<HOSTNAME>", "remove the principal from the keytab file"
   "delprinc", "delete a principal"
   "listprincs", "list principals"

klist
~~~~~

View authentication information about Kerberos.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "show the current ticket validation status"
   "-k", "show the contents of the /etc/krb5.keytab file"

kdestroy
~~~~~~~~

Revoke a user's Kerberos ticket.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "write zeros to the cached ticket file to securely remove it"

Local System
------------

Miscellaneous commands for managing security on local systems.

genkey
~~~~~~

Package: crypto-keys

Generate SSL/TLS certificates.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<DOMAIN_NAME>", "create a self-signed SSL"

gpg
~~~

Package: gnupg

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--output <NEW_FILE>.gpg --encrypt <FILE>", "encrypt a specified file, saving it as a new file"
   "--output <FILE> --decrypt <NEW_FILE>.gpg", "decrypt an encrypted file, saving it as a new file"

lastb
~~~~~

Package: util-linux

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "shows last failed login attempts"

lastlog
~~~~~~~

Package: shadow-utils

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "shows inform about the last logins"

sudo
~~~~

Package: sudo

Allow non-root accounts to temporarily run privileged commands.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-E", "keeps sudo enabled for the current shell session"

`History <https://github.com/ekultails/rootpages/commits/master/src/commands/security.rst>`__
---------------------------------------------------------------------------------------------
