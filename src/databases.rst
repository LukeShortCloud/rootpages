Databases
=========

.. contents:: Table of Contents

SQL
---

MariaDB
~~~~~~~

Configuration
^^^^^^^^^^^^^

RHEL Install [1]:

.. code-block:: sh

    $ sudo vim /etc/yum.repos.d/mariadb.repo
    [mariadb]
    name = MariaDB
    baseurl = http://yum.mariadb.org/10.1/centos7-amd64
    gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
    gpgcheck=1
    $ sudo yum install MariaDB-server MariaDB-client

Table Engines
^^^^^^^^^^^^^

A full list of the available engines are provided at
https://mariadb.com/kb/en/mariadb/storage-engines.

CassandraSE
'''''''''''

The Cassandra Storage Engine (CassandraSE) is used to connect to a NoSQL
Cassandra cluster. This allows the relational management of MariaDB to
work with the fast and scalable Cassandra server. [2]

The Cassandra storage engine is missing from the official RHEL 7
repositories but can be installed from the RHEL 6 repository. [4]

.. code-block:: sh

    $ sudo yum install http://yum.mariadb.org/10.1/centos6-amd64/rpms/MariaDB-10.1.18-centos6-x86_64-cassandra-engine.rpm

-  As the root MariaDB user, load the Cassandra library.

   ::

       $ sudo mysql
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

[2][3]

Clustering
^^^^^^^^^^

Maxscale
''''''''

MaxScale is a proxy that can load balance requests in different ways.
This is useful for specifying reads and writes to specific servers. [5]

Configuration
&&&&&&&&&&&&&

The latest version of MariaDB's MaxScale can be found at
https://mariadb.com/downloads/maxscale.

RHEL Install [6]:

.. code-block:: sh

    $ sudo yum install https://downloads.mariadb.com/MaxScale/2.0.1/rhel/7/x86_64/maxscale-2.0.1-1.rhel.7.x86_64.rpm

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

.. code-block:: sh

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
      back-end server fails, MaxScale will replace it and serve read
      requests from the available binary log.

-  router\_options

   -  master = Write only.
   -  slave = Read only.
   -  master,slave = Read and write.

-  servers = A comma separated list of back-end servers.
-  user = Specify a MySQL user to connect as.
-  passwd = Specify the password for the MySQL user.

Example:

.. code-block:: sh

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

[7]

For replication, a maxscale MySQL user needs "REPLICATION SET" and
"SELECT" grants for all databases.

::

    GRANT REPLICATION SET, SELECT ON *.* TO 'maxscale'@'%' IDENTIFIED BY 'securepassword123';

In a master-slave configuration, at least two servers are required to be
running. This is because MaxScale is unsure if other nodes are present
and cannot determine if a server is a master or a slave. This will
prevent it from working properly and this error will occur for all
connections. [8] It is ideal to follow the quorum theory by having 3
servers to support a failed host properly.

::

    ERROR 1045 (28000): failed to create new session

NoSQL
-----

Cassandra
~~~~~~~~~

Configuration
^^^^^^^^^^^^^

RHEL Install [9][10]:

.. code-block:: sh

    $ sudo yum install java-1.8.0-openjdk

File: /etc/yum/repos.d/datastax.repo

.. code-block:: ini

    [datastax]
    name = DataStax Repo for Apache Cassandra
    baseurl = http://rpm.datastax.com/community
    enabled = 1
    gpgcheck = 0

.. code-block:: sh

    $ sudo yum install cassandra30
    $ sudo systemctl daemon-reload

Configuration options:

-  cluster\_name = The unique name for a cluster. Default: Test Cluster.
-  listen\_address = The IP address to listen on for clustering. Default: localhost.
-  listen\_interface = The network interface to listen on for clustering. Default: eth0.
-  rpc\_address = The IP address to listen on for client requests. Default: localhost.
-  rpc\_interface = The network interface to listen on for client requests. Default: eth1.
-  start\_rpc = Start the client service to allow incoming connections. Default: false.
-  disk\_optimization\_strategy = Specify the type of disk to optimize reads/writes for. Default: ssd.

   -  ssd = Solid state drivers.
   -  spinning = Spinning disk hard drives.

-  disk\_failure\_policy = The action to take when a disk is missing or in a failed state. Default: stop.

   -  best\_effort = Do not use the disk but attempt to respond to requests with any data available.
   -  die = Kill off all processes.
   -  ignore = Ignore any major I/O errors and provide failure responses to any requests.
   -  stop = Gracefully stop the service.

-  endpoint\_snitch = Select a snitch interface for clustering.

   -  CloudstackSnitch = Integrate with the Apache Cloudstack.
   -  Ec2Snitch = Cluster based on Amazon EC2 regions and compute availability zones.
   -  Ec2MultiRegionSnitch = Allows multiple Amazon EC2 regions to be used via public floating IPs.
   -  GoogleCloudSnitch = Cluster based on the Google Cloud Platform's regions and compute availability zones.
   -  GossipingPropertyFileSnitch = Cluster based on the datacenter and rack location. Recommended for a multidatacenter cluster.
   -  RackInferringSnitch = Similar to GossipingPropertyFileSnitch except that the datacenter is automatically determined by the 2nd octet of the IP and the rack is determined by the 3rd.
   -  SimpleSnitch = Cluster based on proximity, but datacenter and rack location does not matter. Recommended for clusters in one region.

-  seed\_provider = The IP addresses of Cassandra servers in other datacenters to replicate to. At least one node should be a seed provider in every datacenter. Not all nodes should be seed providers due to that leading to performance issues.

   -  class\_name: org.apache.cassandra.locator.SimpleSeedProvider

      -  parameters:

        -  seeds: "``<IP_ADDRESS_1>``", "``<IP_ADDRESS_2>``"

-  concurrent\_reads = Default: 32. Recommended: (16 \* ``<COUNT_OF_DISKS>``).
-  concurrent\_writes = Default: 32. Recommended: (16 \* ``<COUNT_OF_CPU_CORES>``).
-  concurrent\_counter\_writes = Default: 32. Recommended: 16 \* ``<COUNT_OF_DISKS>``).
-  concurrent\_batchlog\_writes = Default: 32. Recommended: (16 \* ``<COUNT_OF_CPUS>``).
-  concurrent\_materialized\_view\_writes = Default: 32. Recommended: Use less than the concurrent reads/writes.
-  incremental\_backups = Default: false. Choose whether or not to use incremental backups. When taking snapshots, hardlinks will be used to refer back to old data for efficient backups.
-  snapshot\_before\_compact = Default: false. Choose whether or not to automatically take backups before running a compaction.

[11]

`Errata <https://github.com/ekultails/rootpages/commits/master/src/databases.rst>`__
------------------------------------------------------------------------------------

Bibliography
------------

1. "Installing MariaDB with yum." MariaDB Knowledgebase. Accessed October 16, 2016. https://mariadb.com/kb/en/mariadb/yum/
2. "Cassandra Storage Engine Overview." MariaDB Knowledgebase. Accessed October 16, 2016. https://mariadb.com/kb/en/mariadb/cassandra-storage-engine-overview/
3. "Cassandra Storage Engine Use Example." MariaDB Knowledgebase. Accessed October 16, 2016. https://mariadb.com/kb/en/mariadb/cassandra-storage-engine-use-example/
4. "Missing CentOS7 RPM: MariaDB-10.1.16-centos7-x86\_64-cassandra-engine.rpm?" MariaDB Knowledgebase. Accessed October 16, 2016. https://mariadb.com/kb/en/mariadb/missing-centos7-rpm-mariadb-10116-centos7-x86\_64-cassandra-enginerpm/
5. "About MariaDB MaxScale." MariaDB Knowledgebase. Accessed October 16, 2016. https://mariadb.com/kb/en/mariadb-enterprise/about-mariadb-maxscale/
6. "MariaDB MaxScale Installation Guide." MariaDB Knowledgebase. Accessed October 22, 2016. https://mariadb.com/kb/en/mariadb-enterprise/mariadb-maxscale-14/mariadb-maxscale-installation-guide/
7. "MaxScale Configuration & Usage Scenarios." MariaDB Knowledgebase. Accessed October 22, 2016. https://mariadb.com/kb/en/mariadb-enterprise/mariadb-maxscale-14/maxscale-configuration-usage-scenarios/
8. "Issue with MaxScale when slaves are broken." MaxScale Google Groups. August 28, 2014. Accessed November 12, 2016. https://groups.google.com/forum/#!topic/maxscale/HK49D15s21s
9. "How To Install Cassandra on CentOS 7" liquidweb Knowledgebase. Accessed October 16, 2016. https://www.liquidweb.com/kb/how-to-install-cassandra-on-centos-7/
10. "Installing the DataStax Distribution of Apache Cassandra 3.x on RHEL-based systems." DataStax Distribution of Apache Cassandra 3 Documentation. October 14, 2016. Accessed October 16, 2016. http://docs.datastax.com/en/cassandra/3.x/cassandra/install/installRHEL.html
11. "The cassandra.yaml configuration file." DataStax Documentation. Accessed February 8, 2018. http://docs.datastax.com/en/cassandra/3.0/cassandra/configuration/configCassandra\_yaml.html
