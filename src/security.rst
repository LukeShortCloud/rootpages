Security
========

.. contents:: Table of Contents

Permissions
-----------

User, Group, and Other
~~~~~~~~~~~~~~~~~~~~~~

Normal Linux file permissions are grouped into three categories: owner,
group, and other users access. Permissions can be defined for what the
user, group, or anyone else can do to the file. This can be defined with
letters or numbers.

-  read (r,4) = Read access.
-  write (w,2) = Write access.
-  execute (x,1) = Executable access.

The addition of these numbers makes up the entire access. For example,
"rwx" would equal "777." [1]

::

    -rwxr-xr--. 1 root bob 0 Oct 22 13:11 example_file.txt

::

    user (root): rwx = 7
    group (bob): r-x = 5
    other: r-- = 4

These permissions can be modified with the "chmod" command.

Example (numbers):

.. code-block:: sh

    $ chmod 775

Example (letters):

.. code-block:: sh

    $ chmod g+w,o+x

[1]

Authentication
--------------

Kerberos
~~~~~~~~

Kerberos provides authentication for services over a network. A Kerberos
server provides remote users with a "ticket" to use after they log in.
This ticket is used to validate authentication with various services
including FTP, SSH, NFS, etc. [2]

Ports:

-  88 TCP/UDP
-  464 TCP/UDP
-  749 TCP/UDP
-  6620 TCP/UDP
-  6621 TCP/UDP
-  6623 TCP/UDP [3]

Configuration
^^^^^^^^^^^^^

The Kerberos sever is referred to as the Kerberos Distribution Center
(KDC). These packages will need to be installed for the service:

RHEL:

.. code-block:: sh

    $ sudo yum install krb5-server krb5-workstation pam_krb5

Debian:

.. code-block:: sh

    $ sudo apt-get install krb5-kdc krb5-admin-server libpam-krb5

The principal database needs to be generated. First replace
"EXAMPLE.COM" with the domain to be used. For this example, the realm
"ROOTPAGES.TLD" will be used.

-  /var/kerberos/krb5kdc/kdc.conf

.. code-block:: ini

    [kdcdefaults]
    kdc_ports = 88
    kdc_tcp_ports = 88
    [realms]
    ROOTPAGES.TLD = {
     #master_key_type = aes256-cts
     acl_file = /var/kerberos/krb5kdc/kadm5.acl
     dict_file = /usr/share/dict/words
     admin_keytab = /var/kerberos/krb5kdc/kadm5.keytab
     supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal
    }

-  /var/kerberos/krb5kdc/adm5.acl

   ::

       */admin@ROOTPAGES.TLD   *

The principal is made by running the command below. It will create a new
database and associated files for the realm "ROOTPAGES.TLD."

.. code-block:: sh

    $ sudo kdb5_util create -s -r ROOTPAGES.TLD

Uncomment all of the lines in /etc/krb5.conf and then replace all
references to "example.com" and EXAMPLE.COM" with the server's domain
name/realm. [3] For testing, "rdns=false" and
"ignore\_acceptor\_hostname=true" in the "[libdefaults]" section should
be used to prevent DNS issues. [5]

.. code-block:: ini

    [logging]
    default = FILE:/var/log/krb5libs.log
    kdc = FILE:/var/log/krb5kdc.log
    admin_server = FILE:/var/log/kadmind.log

    [libdefaults]
    dns_lookup_realm = false
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true
    rdns = false
    default_realm = ROOTPAGES.TLD
    default_ccache_name = KEYRING:persistent:%{uid}

    [realms]
    ROOTPAGES = {
     kdc = kdc.rootpages.tld
     admin_server = kdc.rootpages.tld
    }

    [domain_realm]
    .rootpages.tld = ROOTPAGES.TLD
    rootpages.tld = ROOTPAGES.TLD

Start the KDC service.

.. code-block:: sh

    $ sudo systemctl start krb5kdc

Optionally, the admin authentication service can be started to allow
remote management.

.. code-block:: sh

    $ sudo systemctl start kadmin

Now define the root user and KDC host as allowed principals.

.. code-block:: sh

    $ sudo kadmin.local -p root/admin

::

    kadmin: addprinc root/admin
    kdamin: addprinc -randkey host/kdc.rootpages.tld

Additional Kerberos users can also be created.

::

    kadmin: addprinc <USER>

Allow Kerberos authentication via SSH.

File: /etc/ssh/sshd_config

::

    GSSAPIAuthentication yes
    GSSAPICleanupCredentials yes

File: /etc/ssh/ssh_config

::

    Host *
       GSSAPIAuthentication yes
       GSSAPIDelegateCredentials yes

.. code-block:: sh

    $ sudo systemctl reload sshd

Allow remote authentication through this KDC.

.. code-block:: sh

    $ sudo authconfig --enablekrb5 --update

Verify that the authentication works.

.. code-block:: sh

    $ sudo su - <USER>
    $ kinit <USER>
    $ klist

[2][4]

`Errata <https://github.com/ekultails/rootpages/commits/master/src/security.rst>`__
-----------------------------------------------------------------------------------

Bibliography
------------

1. "Understanding Linux File Permissions." Linux.com. May 18, 2010. Accessed October 22, 2016. https://www.linux.com/learn/understanding-linux-file-permissions
2. "Kerberos." Ubuntu Documentation. November 18, 2014. Accessed September 25, 2016. https://help.ubuntu.com/community/Kerberos
3. "Configuring Your Firewall to Work With Kerberos V5." Accessed September 25, 2016. https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-admin/Configuring-Your-Firewall-to-Work-With-Kerberos-V5.html
4. "CentOS 7 Configure Kerberos KDC and Client." theurbanpengiun. September 5, 2016. Accessed September 25, 2016. https://www.youtube.com/watch?v=7Q-Xx0I8PXc
5. "Principal names and DNS." MIT Kerberos Documentation. Accessed October 22, 2016. https://web.mit.edu/kerberos/krb5-1.13/doc/admin/princ\_dns.html
