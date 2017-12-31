SQL
===

-  `MariaDB <#mariadb>`__

   -  `Configuration <#mariadb---configuration>`__
   -  `Table Engines <#mariadb---table-engines>`__

      -  InnoDB
      -  MyISAM
      -  Aria
      -  `CassandraSE <#mariadb---table-engines---cassandrase>`__

   -  `Clustering <#mariadb---clustering>`__

      -  Galera
      -  `MaxScale <#mariadb---clustering---maxscale>`__

MariaDB
-------

MaraiDB - Configuration
~~~~~~~~~~~~~~~~~~~~~~~

RHEL Install [1]:

::

    # vim /etc/yum.repos.d/mariadb.repo
    [mariadb]
    name = MariaDB
    baseurl = http://yum.mariadb.org/10.1/centos7-amd64
    gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
    gpgcheck=1
    # yum install MariaDB-server MariaDB-client

Source:

1. "Installing MariaDB with yum." MariaDB Knowledgebase. Accessed
   October 16, 2016. https://mariadb.com/kb/en/mariadb/yum/

MariaDB - Table Engines
~~~~~~~~~~~~~~~~~~~~~~~

A full list of the available engines are provided at
https://mariadb.com/kb/en/mariadb/storage-engines.

MariaDB - Table Engines - CassandraSE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Cassandra Storage Engine (CassandraSE) is used to connect to a NoSQL
Cassandra cluster. This allows the relational management of MariaDB to
work with the fast and scalable Cassandra server. [1]

The Cassandra storage engine is missing from the official RHEL 7
repositories but can be installed from the RHEL 6 repository. [3]

::

    # yum install http://yum.mariadb.org/10.1/centos6-amd64/rpms/MariaDB-10.1.18-centos6-x86_64-cassandra-engine.rpm

-  As the root MariaDB user, load the Cassandra library.

   ::

       # mysql
       > install soname 'ha_cassandra.so';

-  Configure the default Cassandra rpc/client IP to connect to.

   ::

       > SET GLOBAL cassandra_default_thrift_host='<CASSANDRA_IP>'

-  The Cassandra table has to be created with the "COMPACT STORAGE"
   option. Otherwise, MariaDB will be unable to access the table
   properly.

   ::

       $ cqlsh
       > CREATE TABLE <NAME> (<VALUE1> <TYPE> PRIMARY KEY, <VALUE2> <TYPE>) WITH COMPACT STORAGE;

-  Create a Cassandra table within a database. MariaDB needs to know the
   keyspace and the column/table to map to as well as what IP address to
   use to connect to Cassandra.

   ::

       > CREATE TABLE <NAME> ENGINE=cassandra KEYSPACE="<KEYSPACE_NAME>" COLUMN_FAMILY="<COLUMN_FAMILY_NAME>";

[1][2]

Sources:

1. "Cassandra Storage Engine Overview." MariaDB Knowledgebase. Accessed
   October 16, 2016.
   https://mariadb.com/kb/en/mariadb/cassandra-storage-engine-overview/
2. "Cassandra Storage Engine Use Example." MariaDB Knowledgebase.
   Accessed October 16, 2016.
   https://mariadb.com/kb/en/mariadb/cassandra-storage-engine-use-example/
3. "Missing CentOS7 RPM:
   MariaDB-10.1.16-centos7-x86\_64-cassandra-engine.rpm?" MariaDB
   Knowledgebase. Accessed October 16, 2016.
   https://mariadb.com/kb/en/mariadb/missing-centos7-rpm-mariadb-10116-centos7-x86\_64-cassandra-enginerpm/

MariaDB - Clustering
~~~~~~~~~~~~~~~~~~~~

MariaDB - Clustering - Maxscale
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

MaxScale is a proxy that can load balance requests in different ways.
This is useful for specifying reads and writes to specific servers. [1]

Source:

1. "About MariaDB MaxScale." MariaDB Knowledgebase. Accessed October 16,
   2016.
   https://mariadb.com/kb/en/mariadb-enterprise/about-mariadb-maxscale/

MariaDB - Clustering - Maxscale - Configuration
'''''''''''''''''''''''''''''''''''''''''''''''

The latest version of MariaDB's MaxScale can be found at
https://mariadb.com/downloads/maxscale.

RHEL Install [1]:

::

    # yum install https://downloads.mariadb.com/MaxScale/2.0.1/rhel/7/x86_64/maxscale-2.0.1-1.rhel.7.x86_64.rpm

MaxScale requires the configuration of a listener that is associated
with a router that serves requests to/from a list of servers.

Listener options:

-  [NAME]
-  type=listener
-  service = Specify the back-end service to use. This is usually a
   router.
-  protocol=MySQLClient
-  address = Specify the address to listen on.
-  port=3306

Listener example:

::

    [listener]
    type=listener
    service="Read Write Service"
    protocol=MySQLClient
    port=3306

Router options:

-  [NAME]
-  type=service
-  router

   -  readconnroute = Load balance requests.
   -  readwritesplit = Send write requests to one node and read queries
      to all nodes.
   -  schemarouter = Shard databases. Requests to a particular database
      will be routed to a specific server.
   -  binlogrouter = Copy binary logs from servers other servers. If a
      backend server fails, MaxScale will replace it and serve read
      requests from the available binary log.

-  router\_options

   -  master = Write only.
   -  slave = Read only.
   -  master,slave = Read and write.

-  servers = A comma separated list of back-end servers.
-  user = Specify a MySQL user to connect as.
-  passwd = Specify the password for the MySQL user.

Example:

::

    [Read Write Service]
    type=service
    router=readwritesplit
    servers=server1,server2,server3
    user=maxscale
    passwd=123456

Server options:

-  [NAME]
-  type=server
-  address = Specify the address of the MySQL server.
-  port= Specify the MySQL port (default: 3306).
-  protocol=MySQLBackend

[2]

For replication, a maxscale MySQL user needs "REPLICATION SET" and
"SELECT" grants for all databases.

::

    GRANT REPLICATION SET, SELECT ON *.* TO 'maxscale'@'%' IDENTIFIED BY 'securepassword123';

In a master-slave configuration, at least two servers are required to be
running. This is because MaxScale is unsure if other nodes are present
and cannot determine if a server is a master or a slave. This will
prevent it from working properly and this error will occur for all
connections. [3] It is ideal to follow the quorum theory by having 3
servers to support a failed host properly.

::

    ERROR 1045 (28000): failed to create new session

Sources:

1. "MariaDB MaxScale Installation Guide." MariaDB Knowledgebase.
   Accessed October 22, 2016.
   https://mariadb.com/kb/en/mariadb-enterprise/mariadb-maxscale-14/mariadb-maxscale-installation-guide/
2. "MaxScale Configuration & Usage Scenarios." MariaDB Knowledgebase.
   Accessed October 22, 2016.
   https://mariadb.com/kb/en/mariadb-enterprise/mariadb-maxscale-14/maxscale-configuration-usage-scenarios/
3. "Issue with MaxScale when slaves are broken." MaxScale Google Groups.
   August 28, 2014. Accessed November 12, 2016.
   https://groups.google.com/forum/#!topic/maxscale/HK49D15s21s
