Linux Security
==============

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

Passwords
~~~~~~~~~

Expiration
^^^^^^^^^^

Use the `passwd <https://man7.org/linux/man-pages/man1/passwd.1.html>`__ to force a password to be changed immediately.

.. code-block:: sh

   $ sudo passwd --expire <USER>

Or use `chage <https://man7.org/linux/man-pages/man1/chage.1.html>`__ to force a password change on a specified date.

.. code-block:: sh

   $ sudo chage --lastday <TWO_DIGIT_YEAR>-<TWO_DIGIT_MONTH>-<TWO_DIGIT_DAY> <USER>

Or use ``chage`` to force a password change after a specified number of days.

.. code-block:: sh

   $ sudo chage --maxdays <DAYS> <USER>

View details about password expiration for a user.

.. code-block:: sh

   $ sudo chage --list <USER>

sudo
~~~~

``sudo`` is a command used to provide elevated privileges in Linux so users can run commands as if they were the ``root`` user. It is similar to User Account Control (UAC) on Windows. It is installed by default on many Linux distributions except for a few such as Debian.

A normal user account can run commands as if they were the ``root`` user by using the syntax ``sudo <COMMAND> <ARGUMENTS>``.

The main configuration file is ``/etc/sudoers`` but it is recommended to create a new file ``/etc/sudoers.d/<FILE>`` for additional configurations. The permissions are very strict on these files and the configuration will not load if they are incorrect.

.. code-block:: sh

   $ sudo touch /etc/sudoers.d/example
   $ sudo chmod 0440 /etc/sudoers.d/example
   $ sudo chown root:root /etc/sudoers.d/example

Configuration options [12]:

-  ``<USERNAME> ALL=(ALL) <PATH_TO_COMMAND>`` = Allow a user to only run the specified command with ``sudo``.
-  ``<USERNAME> ALL=(ALL) NOPASSWD: ALL`` = Allow a user to run any command with ``sudo`` without entering their password.
-  ``<USERNAME> ALL=(ALL) ALL`` = Allow a user to run any command with ``sudo``.
-  ``%sudo ALL=(ALL) ALL`` = Allow all users in the ``sudo`` group to run any command with ``sudo``.
-  ``ALL ALL=(ALL) ALL`` = Allow every user to use sudo.
-  ``Defaults <KEY1>=<VALUE1>,<KEY2>=<VALUE2>`` = Configure default settings for all valid ``sudo`` users.
-  ``Defaults:<USERNAME> <KEY1>=<VALUE1>,<KEY2>=<VALUE2>`` = Configure default settings for a single specified ``sudo`` user.
-  ``Defaults passwd_tries=<VALUE>`` = Default: ``5``. The number of times to allow a password to be entered in before locking a user account
-  ``Defaults timestamp_timeout=<VALUE>`` = Default: ``15``. The number of minutes to wait before prompting a user to enter their password again. Set to ``0`` to always require a password. Set to ``-1`` to only ever require a password once.
-  ``Defaults timestamp_type=global,timestamp_timeout=<VALUE>`` = Setting the timestamp type to ``global`` makes the settings apply to all TTYs. This means that when a user enters a password in one TTY for ``sudo``, it will be valid for all other logged in sessions of the same user.

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

SSL/TLS Certificates
--------------------

SSL/TLS certificates provide a symmetric key-pair, similar to SSH keys. SSL is an older protocol that is vulnerable and no longer supported. It was succeeded by TLS.

A TLS cipher suite consist of 4 different algorithms: (1) the key exchange, (2) the authentication, (3) the bulk encyrption, and (4) message authentication code (MAC). A server defines what cipher suite it supports. A client that connects to a server negotiates for a cipher suite that it is compatible with and then uses that for securely connecting. [6]

-  Key exchange = Encrypt both of the symmetric keys.
-  Authentication = Sign and verify certificates.
-  Bulk encyrption = Encrypt data to and from a server. A key generated with this algorithm requires a password.
-  MAC = Checks the integrity of the data being sent and received.

Top algorithms [7]:

-  Key exchange:

   1. ECDHE
   2. RSA

-  Authentication:

   1. ECDSA
   2. RSA

-  Bulk encryption:

   1. AES256-GCM
   2. CHACHA20
   3. AES128-GCM
   4. AES256
   5. AES128

-  MAC:

   1. SHA384
   2. POLY1305
   3. SHA256

Certificate Creation
~~~~~~~~~~~~~~~~~~~~

Self-signed certificates and keys can be manually created. Web browsers and tools will show these as unverified since a trusted certificate authority (CA) did not sign the certificate. The benefit is that secure TLS connections can still be used.

-  Create a CA key.

   .. code-block:: sh

      $ openssl genrsa -out ca.key 4096

-  Create a root certificate.

   .. code-block:: sh

      $ openssl req -x509 -new -nodes -key ca.key -days 365 -out ca.crt -subj "/C=<COUNTRY_CODE>/ST=<STATE_NAME>/L=<CITY_NAME>/O=<ORGANIZATION_NAME>/OU=<ORGANIZATIONAL_UNIT_NAME>/CN=<FQDN>"

[8]

-  Create a symmetric key-pair. This file will be used as the private key file.

   .. code-block:: sh

      $ openssl genrsa -out cert.key 4096

-  Optionally, extract the public key from it.

   .. code-block:: sh

      $ openssl rsa -in cert.key -pubout -out cert.pub

-  Create a certificate signing request (CSR). This will be used by a CA to sign the certificate.

   .. code-block:: sh

      $ openssl req -new -key cert.key -out cert.csr -subj "/C=<COUNTRY_CODE>/ST=<STATE_NAME>/L=<CITY_NAME>/O=<ORGANIZATION_NAME>/OU=<ORGANIZATIONAL_UNIT_NAME>/CN=<FQDN>"

[9]

-  Create a self-signed certificate signed by the CA.

   .. code-block:: sh

      $ openssl x509 -req -in cert.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out cert.crt -days 365

[8]

-  Verify that the information for the certificate is correct.

   .. code-block:: sh

      $ openssl x509 -noout -text -in cert.crt

[9]

Trusted Certificate Authorities
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Custom certificate authorities (CAs) can be added as known trusted CAs.

Arch Linux [10]:

.. code-block:: sh

   $ sudo cp ca.crt /etc/ca-certificates/trust-source/anchors/
   $ sudo update-ca-trust

Debian [11]:

.. code-block:: sh

   $ sudo cp ca.crt /usr/local/share/ca-certificates/
   $ sudo update-ca-certificates

Fedora [11]:

.. code-block:: sh

   $ sudo cp ca.crt /etc/pki/ca-trust/source/anchors/
   $ sudo update-ca-trust

Encryption
----------

HashiCorp Vault
~~~~~~~~~~~~~~~

Installation
^^^^^^^^^^^^

Install the CLI tool for HashiCorp Vault. [13] It can be used as a client or server.

-  Linux:

   .. code-block:: sh

      $ export VAULT_VER=1.13.0
      $ wget "https://releases.hashicorp.com/vault/${VAULT_VER}/vault_${VAULT_VER}_linux_amd64.zip"
      $ unzip vault_${VAULT_VER}_linux_amd64.zip
      $ sudo mv ./vault /usr/local/bin/
      $ vault --version

-  macOS:

   .. code-block:: sh

      $ export VAULT_VER=1.13.0
      $ wget "https://releases.hashicorp.com/vault/${VAULT_VER}/vault_${VAULT_VER}_darwin_amd64.zip"
      $ unzip vault_${VAULT_VER}_darwin_amd64.zip
      $ sudo mv ./vault /usr/local/bin/
      $ vault --version

Start the server in "dev" mode.

.. code-block:: sh

   $ vault server -dev

Verify that the server is working. [14]

.. code-block:: sh

   $ export VAULT_ADDR="http://127.0.0.1:8200"
   $ vault status

Log in manually or by exporting the token as an environment variable.

.. code-block:: sh

   $ vault login

.. code-block:: sh

   $ export VAULT_TOKEN=<VAULT_ROOT_TOKEN>

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/security/linux_security.rst>`__
-  `< 2021.10.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/security.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/security.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/security.md>`__

Bibliography
------------

1. "Understanding Linux File Permissions." Linux.com. May 18, 2010. Accessed October 22, 2016. https://www.linux.com/learn/understanding-linux-file-permissions
2. "Kerberos." Ubuntu Documentation. November 18, 2014. Accessed September 25, 2016. https://help.ubuntu.com/community/Kerberos
3. "Configuring Your Firewall to Work With Kerberos V5." Accessed September 25, 2016. https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-admin/Configuring-Your-Firewall-to-Work-With-Kerberos-V5.html
4. "CentOS 7 Configure Kerberos KDC and Client." theurbanpengiun. September 5, 2016. Accessed September 25, 2016. https://www.youtube.com/watch?v=7Q-Xx0I8PXc
5. "Principal names and DNS." MIT Kerberos Documentation. Accessed October 22, 2016. https://web.mit.edu/kerberos/krb5-1.13/doc/admin/princ\_dns.html
6. "A Beginner’s Guide to TLS Cipher Suites." Namecheap Blog. December 22, 2020. Accessed March 21, 2021. https://www.namecheap.com/blog/beginners-guide-to-tls-cipher-suites/
7. "Recommendations for TLS/SSL Cipher Hardening." The Acunetix Blog. April 10, 2019. Accessed March 21, 2021. https://www.acunetix.com/blog/articles/tls-ssl-cipher-hardening/
8. "How to Create Your Own SSL Certificate Authority for Local HTTPS Development." WP Migrate DB Pro. June 23, 2020. Accessed March 21, 2021. https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/
9. "OpenSSL Quick Reference Guide." DigiCert. Accessed March 21, 2021. https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm
10. "User:Grawity/Adding a trusted CA certificate." Arch Linux Wiki. June 16, 2020. Accessed April 30, 2021. https://wiki.archlinux.org/index.php/User:Grawity/Adding_a_trusted_CA_certificate
11. "How To Set Up and Configure a Certificate Authority (CA) On Debian 10." Digital Ocean Community Tutorials. April 2, 2020. Accessed April 30, 2021. https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-10
12. "sudoers(5) - Linux man page." die.net. July 16, 2012. Accessed October 19, 2022. https://linux.die.net/man/5/sudoers
13. "Install Vault." HashiCorp Developer. Accessed March 12, 2023. https://developer.hashicorp.com/vault/downloads
14. "Starting the Server." HasiCorp Developer. Accessed March 12, 2023. https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dev-server
