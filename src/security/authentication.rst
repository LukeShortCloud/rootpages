Authentication
==============

.. contents:: Table of Contents

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

Server
~~~~~~

Install the Kerberos service.

RHEL:

.. code-block:: sh

    $ sudo yum install krb5-server krb5-workstation

Modify the example Kerberos configuration files and replace the domain
"example.com" with a different domain. This domain needs to be
resolvable on both the server and client computers.

File: /etc/krb5.conf

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

File: /var/kerberos/krb5kdc/kdc.conf

.. code-block:: ini

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

File: /var/kerberos/krb5kdc/kadm5.acl

::

    */admin@EXAMPLE.COM     *

On a new installation, create the KDC database and save the generated
master database password to a file called the "stash file." By default,
the database will be saved to ``/var/kerberos/krb5kdc/principal``.

.. code-block:: sh

    $ sudo kdb5_util create -s

Start and enable the Kerberos service to start on boot.

.. code-block:: sh

    $ sudo systemctl start krb5kdc
    $ sudo systemctl enable krb5kdc

Create an administrator account.

.. code-block:: sh

    $ sudo kadmin.local -q "addprinc root/admin"

Optionally start the remote "kadmin" administrator service.
Alternatively, the ``kadmin.local`` command be used exclusively for
manage Kerberos from the local system.

.. code-block:: sh

    $ sudo systemctl start kadmin

Log into the administrator account to manage accounts.

.. code-block:: sh

    $ sudo kadmin

It is also recommended to use a NTP service to keep time synchronized to
prevent authentication issues due to time drift.

[2]

Client
~~~~~~

Install the Kerberos client utilities.

RHEL:

.. code-block:: sh

    $ sudo  yum install krb5-workstation

The client should have the same domain and realm settings configured
that the server does. The easiest way to ensure this is to copy the
``/etc/krb5.conf`` file over.

When authenticating, the username has to be in lowercase and the domain
must be in uppercase. [3]

Syntax:

``<user>@<DOMAIN>``

Example:

``bob@ENTERPRISE.TLD``

OpenLDAP
--------

The Lightweight Directory Access Protocol (LDAP) is a network protocol
for accessing user information. OpenLDAP is an open source
implementation of this protocol.

OpenLDAP supports storing user information in many relational database
management systems (RDMSs) including IBM db2, MariaDB/MySQL, MS SQL
Server, Oracle Database, PostgreSQL and more. [4]

Server
~~~~~~

RHEL:

.. code-block:: sh

    $ sudo yum install compat-openldap openldap openldap-clients openldap-servers

For using a RDMS, install the required dependency:

.. code-block:: sh

    $ sudo yum install openldap-servers-sql

Enable and start the service.

.. code-block:: sh

    $ sudo systemctl enable slapd
    $ sudo systemctl start slapd

[5]

FreeIPA
-------

FreeIPA provides a suite of services for authentication including LDAP, Kerberos, NTP, DNS, and a certificate management system. This is the upstream version of Red Hat Identity Management (IdM). [6]

For AD integration, the Scheme Compatibility plugin is required.

.. code-block:: sh

    $ ipa-adtrust-install --enable-compat
    $ ipa-server-upgrade
    $ ipa-compat-manage status

[7]

Commands
~~~~~~~~

-  Create a user.

   .. code-block:: sh

       $ ipa user-add <USER_NAME> --first <FIRST_NAME> --last <LAST_NAME> --cn "<CN>" --email <EMAIL_ADDRESS> --phone “(<AREA_CODE>) <PHONE>-<NUMBER>” --shell=/bin/bash --password --sshpubkey='ssh-rsa AAAABUQzaC1yc2EAAAADAQABAAABAQDVAl1fcau6/avTPNE5Sd1TXPwhoiHshVscgoGNj7ZU9hehAFQGZBMJfA5jM2SGy927t726snX0uZwDR7Teooeea8oa7spBn/gEGTzRnhKSdjGx/Z1PpgSb6fZek9TXNl32D/FgxxYpzOb4tZdcWr2dIr8tn1bsiqNhpDqTRkCvwstXKHkhyOqMttl9AAz0y2PQWk3c3DgRpnVCl8bcrySFlT8y7AxTPoCc3bpwDy2EirgOfsIx5Nvh7Ac85osxn1ilF+pJR+InGPmZXFHhyzZJeCSQTgI5+ym3l0bgbRAXV81A24GFdIpOozSoRmKDIE5xfcBSU36svLmwSFJWPLc2'

-  Create a group.

   .. code-block:: sh

       $ ipa group-add <GROUP_NAME>

-  Add a user to a group.

   .. code-block:: sh

       $ ipa group-add-member --users=<USER1> --users=<USER2> --users=<USER3>

-  Remove a user from a group.

   .. code-block:: sh

       $ ipa group-remove-member --users=<USER1> --users=<USER2> --users=<USER3>

How to create users and groups in Windows Active Directory:

-  Users: https://docs.microsoft.com/en-us/previous-versions/commerce-server/aa545262(v=cs.70)
-  Groups: https://docs.microsoft.com/en-us/previous-versions/commerce-server/aa545347%28v%3dcs.70%29

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/security/authentication.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/authentication.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/authentication.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/authentication.md>`__

Bibliography
------------

1. Ghori, Asghar. *RHCSA & RHCE Red Hat Enterprise Linux 7: Training and Exam Preparation Guide (EX200 and EX300)*. 3rd ed. Toronto, Canada: Asghar Ghori, 2015.
2. "Kerberos KDC Quickstart Guide." Fedora Project Wiki. February 3, 2010. Accessed September 11, 2017. https://fedoraproject.org/wiki/Kerberos\_KDC\_Quickstart\_Guide
3. "Infrastructure/Kerberos." Fedora Project Wiki. June 23, 2017. Accessed September 11, 2017. https://fedoraproject.org/wiki/Infrastructure/Kerberos
4. "slapd-sql(5) - Linux man page." die.net. Accessed February 8, 2018. https://linux.die.net/man/5/slapd-sql
5. "Step By Step OpenLDAP Server Configuration On CentOS 7 / RHEL 7." ItzGeek. September 14, 2017. Accessed September 20, 2017. http://www.itzgeek.com/how-tos/linux/centos-how-tos/step-step-openldap-server-configuration-centos-7-rhel-7.html
6. "About - FreeIPA." FreeIPA. Accessed April 25, 2018. https://www.freeipa.org/page/About
7. "ipa-adtrust-install (1) - Linux Man Page."  SysTutorials. Accessed June 19, 2018. https://www.systutorials.com/docs/linux/man/1-ipa-adtrust-install/
8. "V4/User Life-Cycle Management." FreeIPA. Accessed June 19, 2018. https://www.freeipa.org/page/V4/User\_Life-Cycle\_Management
