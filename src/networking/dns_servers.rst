DNS
===

.. contents:: Table of Contents

Introduction to DNS
-------------------

A Domain Name System (DNS) provides human-friendly domain names that are
generally associated with an IP address or a string of text. There are
two types of DNS servers:

-  Authoritative = Serves its own DNS records. Generally most
   authoritative servers will rely on a recursive component to provide
   missing DNS records.
-  Recursive = Queries an external DNS server for records. These are
   usually then cached for a certain period of time.

It is important to note that every DNS record has to be associated with
a state of authority (SOA) record. This provides the primary
nameserver/resolver along with time to live (TTL) related information.

Domain Names
~~~~~~~~~~~~

Example of a Fully Qualified Domain Name (FQDN): ``www.google.com``

-  Top-level domain (TLD) = The end part of a domain name. Example: ``com``.
-  Second-level domain (SLD) = The name before the TLD. Example: ``google``.
-  Subdomain or third-level domain = The name before the SLD. Custom subdomains can be configured by the person who owns a domain name. Example: ``www``.

[7]

A person can buy a domain name which is a unique SLD determined by the person and is associated with a TLD that already exists. The full list of available TLD names can be found `here <https://data.iana.org/TLD/tlds-alpha-by-domain.txt>`__. A domain name is bought from a registrar. Any number of subdomains can be configured by the person who owns the domain name. A subdomain combined with a domain name is known as a FQDN.

**DNS Lookup Flow**

1. An end-user requests information for a FQDN by trying to visit the website in their web browser. Example: ``www.google.com``
2. A DNS resolver from ``/etc/resolv.conf`` is asked for information about it. Example resolvers: CloudFlare ``1.1.1.1`` or Google ``8.8.8.8``.
3. If the DNS resolver does not have the required information cached, it asks one of the 12 root level DNS servers (such as one from ICANN). The root level DNS server provides the name servers for the TLD DNS server.
4. The TLD DNS server provides the authoritative name server for the domain name. This is directed to the registrar that manages the domain name.
5. The authoritative name server provides the A or AAAA record (IP address) for ``www.google.com``.
6. The web browser connects to the IP address to load up the website.

::

   (1) End-user --> (2) Resolver DNS Server --> (3) Root Level DNS Server (ICANN)
       --> (4) TLD DNS Server --> (5) Registrar Authoritative DNS Server

[8]

Record Types
~~~~~~~~~~~~

These are the most common types of DNS records. [6]

-  SOA = Start of Authority. Required for all domain names. This record is handled by the domain hosting provider and it indicates that they control the domain name.
-  NS = Name server. A DNS server that handles setting and providing DNS entries for the domain.
-  A = IPv4 address.
-  AAAA = IPv6 address.
-  ALIAS = An alias to a completely different domain name. The A record of the domain name  is resolved instantly but losses geographical information.
-  CNAME = A canonical name. An alias to another domain name (including part of the same domain name, if desired). First the CNAME is resolved and then the A record is resolved.
-  MX = Mail exchange. Used for configuring e-mail with the domain.
-  PTR = Pointer. Associate an IP address with a domain name. Specify an IP address in the nibble address format (a reserved order).
-  TXT = Descriptive text. Commonly used to verify that the domain is valid.

PTR
^^^

PTR records require that the IP address be defined in the nibble format and end with a period. This special format is basically the IP address in reverse with special suffixes added. For helping to quickly get the format for long IPv6 addresses, use the ``ipv6calc`` command or `this site <http://rdns6.com/hostRecord>`__.

::

    <NIBBLE_IP4>.in-addr.arpa.

::

    <NIBBLE_IP6>.ip6.arpa.

Here is an example of converting addresses to nibble.

-  IPv4

   -  Address = 192.168.0.10
   -  Nibble address = 10.0.168.192.in-addr.arpa.

-  IPv6

   -  Address = FE8::56:CC7A:129B:7AAA (FE80:0000:0000:0000:056:CC7A:129B:7AAA)
   -  Nibble address = a.a.a.7.b.9.2.1.a.7.c.c.6.5.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa.

      .. code-block:: sh

          $ ipv6calc --out revnibbles.arp FE8::56:CC7A:129B:7AAA

CoreDNS
-------

CoreDNS is a cloud native DNS service that provides many plugins. It can be used as both an authoritative and recursive DNS server. It supports DNS ``dns://``, DNS over TLS ``tls://``, DNS over HTTPS ``https://``, and DNS over gRPC ``grpc://``.

All settings are configured via a configuration file named ``Corefile``. Different server blocks can be used for configuring different DNS zones. The default zone is ``.`` which is actually ``.:53`` to indicate that it will listen on port 53.

Global settings set for a zone ``.:<PORT>`` will apply to all server blocks listening on that same port. This means that two or more ports can be configured and they can all have different default global settings.

Global settings:

::

   . {
      <PLUGIN> <PLUGIN_OPTIONS>
    }

Logging:

::

   . {
      health
      prometheus
      log
      errors
   }

Snippets can be defined by using ``(<SNIPPET_NAME>)`` and then imported into other server blocks.

::

   (logging) {
       log
       errors
   }

   . {
       import logging
   }

Foward DNS requests syntax:

::

   . {
      ; Forward requests to the specified DNS resolvers.
      forward <DOMAIN_NAME> <RESOLVER_IP_1> <RESOLVER_IP_2>
      ; Forward requests to resolvers specified in /etc/resolv.conf
      forward <DOMAIN_NAME> /etc/resolv.conf
      ; Forward all other requests to the specified resolvers.
      forward . <RESOLVER_IP_1> <RESOLVER_IP_2>
   }

Example forwarding to CloudFlare [9]:

::

   . {
       forward . tls://1.1.1.1 tls://1.0.0.1 {
           tls_servername tls.cloudflare-dns.com
           health_check 10s
       }
       log
       errors
   }

[10]

Authoratitive Server
~~~~~~~~~~~~~~~~~~~~

Use a separate file for each DNS zone. Define the file to use in the main ``Corefile``.

::

   <SLD>.<TLD> {
       file <DNS_ZONE_FILE>
   }

DNS zone file SOA syntax:

::

    $ORIGIN <SLD>.<TLD>.
    @    IN    SOA    <DNS_SERVER_FQDN>.    <EMAIL_USER>.<EMAIL_FQDN>. (
        <SERIAL_DATE>
        <SOA_REFRESH_SECONDS>
        <RETRY_DNS_RECORD_SECONDS>
        <RETRY_SOA_SECONDS>
        <TTL>
    )

Example:

::

   $ORIGIN foo.bar.
   ; <EMAIL_USER>.<EMAIL_FQDN> = joe@gmail.com, <SERIAL_DATE> = 2021-02-28 23:99, <SOA_REFRESH_SECONDS> = 2 hours, <RETRY_DNS_RECORDSECONDS> = 1 hour, <RETRY_SOA_SECONDS> = 2 weeks, <TTL> = 1 hour
   @    IN    SOA    coredns.example.com.    joe.gmail.com. (
       202102282399
       7200
       3600
       1209600
       3600
   )

DNS records can now be set using these values as a minimum.

Syntax:

::

   <SUBDOMAIN>    IN    <RECORD_TYPE>    <RECORD_VALUE>

Example:

::

   www    IN    A    192.168.1.1

[10]

Recursive Server
~~~~~~~~~~~~~~~~

CoreDNS does not natively support being a recursive/caching DNS server. For this functionality, recompile CoreDNS with the ``unbound`` plugin and then enable it in the configuration. The Unbound plugin requires using CGO which makes the binary non-portable across different operating system distributions.

Download CoreDNS and its dependencies for the Unbound plugin:

.. code-block:: sh

   $ sudo apt-get install golang libunbound-dev make
   $ export COREDNS_VER=1.8.3
   $ wget https://github.com/coredns/coredns/archive/v${COREDNS_VER}.tar.gz
   $ tar -x -v -f v${COREDNS_VER}.tar.gz
   $ cd coredns-${COREDNS_VER}

There is a `bug with the Unbound plugin <https://github.com/miekg/unbound/issues/13>`__ that prevents it from being compiled with newer versions of CoreDNS. Modify the ``Makefile`` and remove any mention of "CGO_ENABLED".

.. code-block:: sh

   $ vim Makefile

Compile CoreDNS with the Unbound plugin:

.. code-block:: sh

   $ echo "unbound:github.com/coredns/unbound" >> plugin.cfg
   $ go generate
   $ export CGO_ENABLED=1
   $ make

Verify that the recursive server works:

.. code-block:: sh

   $ vim Corefile

::

   . {
      unbound
      cache
      forward . 8.8.8.8 8.4.4.8
   }

.. code-block:: sh

   $ ./coredns &
   $ sudo apt-get install dnsutils
   $ dig @127.0.0.1 google.com | grep "Query time"
   ;; Query time: 34 msec
   $ dig @127.0.0.1 google.com | grep "Query time"
   ;; Query time: 1 msec

[11]

PowerDNS
--------

The pdns service can be both an authoritative and recursive DNS server.
It supports a large number of back-ends that can be used for it's
authoritative server. [1] A few of the most popular back-ends are "bind"
(BIND) due to it's large usage in the Linux community and "gmysql"
(MySQL) due to it's scalability.

This is the SOA format that pdns uses. At the bare minimum, the
nameserver and email should be defined. [3]

::

    nameserver email serial refresh retry expire ttl

SOA options:

-  nameserver = The DNS server that should host the zone information.
   This value should normally mirror one of the NS records used for the
   zone (if applicable).
-  email = The administrator's e-mail.
-  serial = 0 for automatic serial creation (default). Not all back-ends
   support automatic serials, such as bind. gmysql supports it. If using
   automatic serial numbers, place the number here. If any records are
   updated, the serial should also be updated.
-  refresh = When DNS servers should check for DNS updates (in seconds).
-  retry = How long to wait (in seconds) to recheck the zone after a
   failed refresh.
-  expire = How long (in seconds) before this zone should longer be
   queried for a failed retry. This value only applies to slave DNS
   servers.
-  ttl = How long (in seconds) a record is allowed to be cached by
   another DNS server. [5]

PowerAdmin
~~~~~~~~~~

PowerAdmin is the graphic control panel that can be installed and
accessed via a web browser.

gmysql
~~~~~~

The generic MySQL back-end (gmysql) was created to allow any MySQL server
to store and serve records. [2] This is not to be confused with using
the MyDNS back-end. [1]

This is the recommend InnoDB table schema to use. [2]

::

    CREATE DATABASE IF NOT EXISTS pdns;

    CREATE TABLE pdns.domains (
      id                    INT AUTO_INCREMENT,
      name                  VARCHAR(255) NOT NULL,
      master                VARCHAR(128) DEFAULT NULL,
      last_check            INT DEFAULT NULL,
      type                  VARCHAR(6) NOT NULL,
      notified_serial       INT DEFAULT NULL,
      account               VARCHAR(40) DEFAULT NULL,
      PRIMARY KEY (id)
    ) Engine=InnoDB;

    CREATE UNIQUE INDEX name_index ON pdns.domains(name);

    CREATE TABLE pdns.records (
      id                    INT AUTO_INCREMENT,
      domain_id             INT DEFAULT NULL,
      name                  VARCHAR(255) DEFAULT NULL,
      type                  VARCHAR(10) DEFAULT NULL,
      content               VARCHAR(64000) DEFAULT NULL,
      ttl                   INT DEFAULT NULL,
      prio                  INT DEFAULT NULL,
      change_date           INT DEFAULT NULL,
      disabled              TINYINT(1) DEFAULT 0,
      ordername             VARCHAR(255) BINARY DEFAULT NULL,
      auth                  TINYINT(1) DEFAULT 1,
      PRIMARY KEY (id)
      CONSTRAINT `records_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE
    ) Engine=InnoDB;

    CREATE INDEX nametype_index ON pdns.records (name,type);
    CREATE INDEX domain_id ON pdns.records (domain_id);
    CREATE INDEX recordorder ON pdns.records (domain_id, ordername);

    CREATE TABLE pdns.supermasters (
      ip                    VARCHAR(64) NOT NULL,
      nameserver            VARCHAR(255) NOT NULL,
      account               VARCHAR(40) NOT NULL,
      PRIMARY KEY (ip, nameserver)
    ) Engine=InnoDB;

    CREATE TABLE pdns.comments (
      id                    INT AUTO_INCREMENT,
      domain_id             INT NOT NULL,
      name                  VARCHAR(255) NOT NULL,
      type                  VARCHAR(10) NOT NULL,
      modified_at           INT NOT NULL,
      account               VARCHAR(40) NOT NULL,
      comment               VARCHAR(64000) NOT NULL,
      PRIMARY KEY (id)
    ) Engine=InnoDB;

    CREATE INDEX comments_domain_id_idx ON pdns.comments (domain_id);
    CREATE INDEX comments_name_type_idx ON pdns.comments (name, type);
    CREATE INDEX comments_order_idx ON pdns.comments (domain_id, modified_at);

    CREATE TABLE pdns.domainmetadata (
      id                    INT AUTO_INCREMENT,
      domain_id             INT NOT NULL,
      kind                  VARCHAR(32),
      content               TEXT,
      PRIMARY KEY (id)
    ) Engine=InnoDB;

    CREATE INDEX domainmetadata_idx ON pdns.domainmetadata (domain_id, kind);

    CREATE TABLE pdns.cryptokeys (
      id                    INT AUTO_INCREMENT,
      domain_id             INT NOT NULL,
      flags                 INT NOT NULL,
      active                BOOL,
      content               TEXT,
      PRIMARY KEY(id)
    ) Engine=InnoDB;

    CREATE INDEX domainidindex ON pdns.cryptokeys (domain_id);

    CREATE TABLE pdns.tsigkeys (
      id                    INT AUTO_INCREMENT,
      name                  VARCHAR(255),
      algorithm             VARCHAR(50),
      secret                VARCHAR(255),
      PRIMARY KEY (id)
    ) Engine=InnoDB;

    CREATE UNIQUE INDEX namealgoindex ON pdns.tsigkeys (name, algorithm);

Then make sure that the pdns service is configured via the ``pdns.conf``
file to connect to the MySQL server.

.. code-block:: ini

    launch=gmysql
    gmysql-host=<MYSQL_HOST>
    gmysql-user=<MYSQL_USER>
    gmysql-dbname=pdns
    gmysql-password=<MYSQL_PASS>

Records
^^^^^^^

After pdns is configured to use gmysql, a domain zones can be added.
This requires that a information about the domain is added to the
``pdns.domains`` table and then a SOA record needs to be created in
``pdns.records`` referencing the domain's ``id`` number. [3]

::

    mysql> USE pdns;
    mysql> INSERT INTO domains (name, type) values ('<DOMAIN_NAME>', 'NATIVE');
    mysql> INSERT INTO records (domain_id, name, content, type, ttl) VALUES (1, '<DOMAIN_NAME>', 'localhost <DOMAIN_ADMIN_EMAIL_ADDRESS> 0', 'SOA', 86400);

Once the SOA record is created then normal DNS records can be created
and served. For the records tables, the most important columns are:

-  name = The domain name that will correspond to a record. This record
   should never end with a "."
-  type = The type of DNS record. This can be SOA, A, AAAA, MX, SRV,
   PTR, etc.
-  content = What the name should resolve to when queried.

In this example, NS records and an A record is added for the domain
``test.tld``.

::

    mysql> INSERT INTO records (domain_id, name, content, type, ttl)
    VALUES (1,'test.tld','dns1.nameserver.tld', 'NS', 86400);
    mysql> INSERT INTO records (domain_id, name, content, type, ttl)
    VALUES (1, 'test.tld', 'dns2.nameserver.tld', 'NS', 86400);
    mysql> INSERT INTO records (domain_id, name, content, type, ttl)
    VALUES (1, 'www.test.tld', '192.168.0.10', 'A', 3600);

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/networking/dns_servers.rst>`__
-  `< 2021.04.01 <https://github.com/ekultails/rootpages/commits/master/src/http/dns_servers.rst>`__
-  `< 2020.01.01 <https://github.com/ekultails/rootpages/commits/master/src/administration/dns_servers.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/dns_servers.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/dns_servers.md>`__

Bibliography
------------

1. "PowerDNS." PowerDNS Docs. Accessed July 7, 2016. https://doc.powerdns.com/md/
2. "PowerDNS Generic MySQL backend." PowerDNS Docs. Accessed July 7, 2016. https://doc.powerdns.com/md/authoritative/backend-generic-mysql/
3. "PowerDNS How To's" PowerDNS Docs. Accessed July 7, 2016. https://doc.powerdns.com/md/authoritative/howtos/
4. "Supported Record Types. PowerDNS Docs. Accessed July 7, 2016. https://doc.powerdns.com/md/types/
5. "Start of Authority Resource Record (SOA RR)." zytrax open. Accessed July 7, 2016. http://www.zytrax.com/books/dns/ch8/soa.html
6. "Simple DNS Plus." DNS Record types. Accessed February 25, 2021. https://simpledns.plus/help/dns-record-types
7. "What’s in a Domain Name: Sub, Second-Level, Top-Level and Country Code Domains." Hover Blog. December 24, 2020. Accessed February 26, 2021. https://hover.blog/whats-a-domain-name-subdomain-top-level-domain/
8. "What is DNS and the DNS Hierarchy." Interserver Tips. August 22, 2016. Accessed February 26, 2021. https://www.interserver.net/tips/kb/dns-dns-hierarchy/
9. "forward." CoreDNS Plugins. January 28, 2021. Accessed March 1, 2021. https://coredns.io/plugins/forward/
10. "CoreDNS Manual." CoreDNS: DNS and Service Discovery. September 28, 2019. Accessed March 1, 2021. https://coredns.io/manual/toc/
11. "unbound." CoreDNS External Plugins. April 27, 2018. Accessed March 1, 2021. https://coredns.io/explugins/unbound/
