Authentication
==============

-  `Kerberos <#kerberos>`__

   -  `Server <#kerberos---server>`__
   -  `Client <#kerberos---client>`__

-  `OpenLDAP <#openldap>`__

   -  `Server <#openldap---server>`__

Kerberos
--------

Kerberos helps to facilitate a single sign-on and secure approach to
authenticating across multiple services. The Kerberos server is also
known as a Key Distribution Center (KDC) server that maintains a KDC
database of encrypted keys.

A client authenticates once to a KDC server with a username and
password. Once validated through a authentication service, an initial
"Ticket Granting Ticket" (TGT) is issued by the "Ticket Granting
Service" (TGS). This ticket contains information about the client
including their hostname, IP address, initial ticket creation time,
ticket expiration time, and more. When this client tries to access
access a remote resource (for example, FTP or SSH) the TGT's access
privileges are verified by the TGS and then a "Service Ticket" is
issued. The client then uses this service ticket to access the remote
resource.

Ports:

-  88/tcp+udp = Kerberos communication.
-  464/tcp+udp = Kerberos authentication.
-  749/tcp+udp = Kerberos administration.

[1]

Source:

1. Ghori, Asghar. *RHCSA & RHCE Red Hat Enterprise Linux 7: Training and
   Exam Preparation Guide (EX200 and EX300)*. 3rd ed. Toronto, Canada:
   Asghar Ghori, 2015.

Kerberos - Server
~~~~~~~~~~~~~~~~~

Install the Kerberos service.

RHEL:

::

    # yum install krb5-server krb5-workstation

Modify the example Kerberos configuration files and replace the domain
"example.com" with a different domain. This domain needs to be
resolvable on both the server and client computers.

::

    # vim /etc/krb5.conf
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
     default_realm = EXAMPLE.COM
     default_ccache_name = KEYRING:persistent:%{uid}

    [realms]
     EXAMPLE.COM = {
      kdc = kerberos.example.com
      admin_server = kerberos.example.com
     }

    [domain_realm]
     .example.com = EXAMPLE.COM
     example.com = EXAMPLE.COM

::

    # vim /var/kerberos/krb5kdc/kdc.conf
    [kdcdefaults]
     kdc_ports = 88
     kdc_tcp_ports = 88

    [realms]
     EXAMPLE.COM = {
      #master_key_type = aes256-cts
      acl_file = /var/kerberos/krb5kdc/kadm5.acl
      dict_file = /usr/share/dict/words
      admin_keytab = /var/kerberos/krb5kdc/kadm5.keytab
      supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal
     }

::

    # vim /var/kerberos/krb5kdc/kadm5.acl
    */admin@EXAMPLE.COM     *

On a new installation, create the KDC database and save the generated
master database password to a file called the "stash file." By default,
the database will be saved to ``/var/kerberos/krb5kdc/principal``.

::

    # kdb5_util create -s

Start and enable the Kerberos service to start on boot.

::

    # systemctl start krb5kdc
    # systemctl enable krb5kdc

Create an administrator account.

::

    # kadmin.local -q "addprinc root/admin"

Optionally start the remote "kadmin" administrator service.
Alternatively, the ``kadmin.local`` command be used exclusively for
manage Kerberos from the local system.

::

    # systemctl start kadmin

Log into the administrator account to manage accounts.

::

    # kadmin

It is also recommended to use a NTP service to keep time synchronized to
prevent authentication issues due to time drift.

[1]

Source:

1. "Kerberos KDC Quickstart Guide." Fedora Project Wiki. Februray 3,
   2010. Accessed September 11, 2017.
   https://fedoraproject.org/wiki/Kerberos\_KDC\_Quickstart\_Guide

Kerberos - Client
~~~~~~~~~~~~~~~~~

Install the Kerberos client utilities.

RHEL:

::

    # yum install krb5-workstation

The client should have the same domain and realm settings configured
that the server does. The easiest way to ensure this is to copy the
``/etc/krb5.conf`` file over.

When authenticating, the username has to be in lowercase and the domain
must be in uppercase. [1]

Syntax:

``<user>@<DOMAIN>``

Example:

``bob@ENTERPRISE.TLD``

Source:

1. "Infrastructure/Kerberos." Fedora Project Wiki. June 23, 2017.
   Accessed September 11, 2017.
   https://fedoraproject.org/wiki/Infrastructure/Kerberos

OpenLDAP
--------

The Lightweight Directory Access Protocol (LDAP) is a network protocol
for accessing user information. OpenLDAP is an open source
implementation of this protocol.

OpenLDAP supports storing user information in many relational database
management systems (RDMSs) including IBM db2, MariaDB/MySQL, MS SQL
Server, Oracle Database, PostgreSQL and more. [2]

Source:

1. 
2. https://linux.die.net/man/5/slapd-sql

OpenLDAP - Server
~~~~~~~~~~~~~~~~~

RHEL:

::

    # yum install compat-openldap openldap openldap-clients openldap-servers

For using a RDMS, install the required dependency:

::

    # yum install openldap-servers-sql

Enable and start the service.

::

    # systemctl enable slapd
    # systemctl start slapd

[1]

Source:

1. "Step By Step OpenLDAP Server Configuration On CentOS 7 / RHEL 7."
   ItzGeek. September 14, 2017. Accessed September 20, 2017.
   http://www.itzgeek.com/how-tos/linux/centos-how-tos/step-step-openldap-server-configuration-centos-7-rhel-7.html
