DNS
===

-  `Introduction to DNS <#introduction-to-dns>`__
-  BIND
-  Dnsmasq
-  `PowerDNS <#powerdns>`__
-  `PowerAdmin <#powerdns---poweradmin>`__
-  `gmysql <#powerdns---gmysql>`__

   -  `Records <#powerdns---gmysql---records>`__

-  Unbound

Introduction to DNS
-------------------

Domain Name Servers (DNS) provide friendly domain names that are
generally associated with an IP address or a string of text. There are
two types of DNS servers:

-  Authoritative = Serves it's own DNS records. Generally most
   authoritative servers will rely on a recursive component to provide
   missing DNS records.
-  Recursive = Queries an external DNS server for records. These are
   usually then cached for a certain period of time.

It is important to note that every DNS record has to be associated with
a state of authority (SOA) record. This provides the primary
nameserver/resolver along with time to live (TTL) related information.

PowerDNS
--------

The pdns service can be both an authoritative and recursive DNS server.
It supports a large number of backends that can be used for it's
authoritative server. [1] A few of the most popular backends are "bind"
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
-  serial = 0 for automatic serial creation (default). Not all backends
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

PowerDNS - PowerAdmin
~~~~~~~~~~~~~~~~~~~~~

PowerAdmin is the graphic control panel that can be installed and
accessed via a web browser.

PowerDNS - gmysql
~~~~~~~~~~~~~~~~~

The generic MySQL backend (gmysql) was created to allow any MySQL server
to store and serve records. [2] This is not to be confused with using
the MyDNS backend. [1]

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

::

    launch=gmysql
    gmysql-host=<MYSQL_HOST>
    gmysql-user=<MYSQL_USER>
    gmysql-dbname=pdns
    gmysql-password=<MYSQL_PASS>

PowerDNS - gmysql - Records
^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

PTR records require that the IP address be defined in the nibble format
and end with a period. This special format is basically the IP address
in reverse with special suffixes added to the end. For helping to
quickly get the format for long IPv6 addresses, use the "ipv6calc"
command or the site http://rdns6.com/hostRecord.

::

    <NIBBLE_IP4>.in-addr.arpa.
    <NIBBLE_IP6>.ip6.arpa.

Here is an example of converting addresses to nibble.

-  IPv4

   -  address = 192.168.0.10
   -  nibble address = 10.0.168.192.in-addr.arpa.

-  IPv6

   -  address = FE8::56:CC7A:129B:7AAA
      (FE80:0000:0000:0000:056:CC7A:129B:7AAA)
   -  nibble address =
      a.a.a.7.b.9.2.1.a.7.c.c.6.5.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa.

      ::

          $ ipv6calc --out revnibbles.arp FE8::56:CC7A:129B:7AAA

Sources:

1. "PowerDNS." PowerDNS Docs. Accessed July 7, 2016.
   https://doc.powerdns.com/md/
2. "PowerDNS Generic MySQL backend." PowerDNS Docs. Accessed July 7,
   2016.
   https://doc.powerdns.com/md/authoritative/backend-generic-mysql/
3. "PowerDNS How To's" PowerDNS Docs. Accessed July 7, 2016.
   https://doc.powerdns.com/md/authoritative/howtos/
4. "Supported Record Types. PowerDNS Docs. Accessed July 7, 2016.
   https://doc.powerdns.com/md/types/
5. "Start of Authority Resource Record (SOA RR)." zytrax open. Accessed
   July 7, 2016. http://www.zytrax.com/books/dns/ch8/soa.html
