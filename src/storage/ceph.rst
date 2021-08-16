Ceph
====

.. contents:: Table of Contents

Introduction
------------

Ceph is a storage project that is sponsored by The Linux Foundation. It has developed a storage system that uses Reliable Autonomic Distributed Object Store (RADOS) to provide scalable, fast, and reliable software-defined storage by storing files as objects and calculating their location on the fly. Failovers will even happen automatically so no data is lost. By default, there are 3 replicas of each file stored on an OSD.

Vocabulary:

-  Object Storage Device (OSD) = The device that stores data.
-  OSD Daemon = Handles storing all user data as objects.
-  Ceph Block Device (RBD) = Provides a block device over the network,
   similar in concept to iSCSI.
-  Ceph Object Gateway = A RESTful API which works with Amazon S3 and
   OpenStack Swift.
-  Ceph Monitors (MONs) = Store and provide a map of data locations.
-  Ceph Metadata Server (MDS) = Provides metadata about file system
   hierarchy for CephFS. This is not required for RBD or RGW.
-  Ceph File System (CephFS) = A POSIX-compliant distributed file system
   with unlimited size.
-  Controlled Replication Under Scalable Hash (CRUSH) = Uses an
   algorithm to provide metadata about an object's location.
-  Placement Groups (PGs) = Object storage data.

Ceph monitor nodes have a master copy of a cluster map. This contains 5
separate maps that have information about data location and the
cluster's status. If an OSD fails, the monitor daemon will automatically
reorganize everything and provided end-user's with an updated cluster
map.

Cluster map:

-  Monitor map = The cluster fsid (uuid), position, name, address and
   port of each monitor server.

   -  ``$ sudo ceph mon dump``

-  OSD map = The cluster fsid, available pools, PG numbers, and OSDs
   current status.

   -  ``$ sudo ceph osd dump``

-  PG map = PG version, PG ID, ratios, and data usage statistics.

   -  ``$ sudo ceph pg dump``

-  `CRUSH map <#network---ceph---crush-map>`__ = Storage devices,
   physical locations, and rules for storing objects. It is recommended
   to tweak this for production clusters.
-  MDS map

   -  ``$ sudo ceph fs dump``

When the end-user asks for a file, that name is combined with it's PG ID
and then CRUSH hashes it to find the exact location of it on all of the
OSDs. The master OSD for that file serves the content. [1]

For OSD nodes, it is recommend that the operating system is on two disks in a RAID 1. All of the over disks can be used for OSD or journal/metadata services.

As of Luminous release, the new ``mgr`` (managers) monitoring service is required. It helps to collect metrics about the cluster. It should be running on all of the monitor nodes. https://docs.ceph.com/docs/luminous/release-notes/

The current back-end for handling data storage is FileStore. When data
is written to a Ceph OSD, it is first fully written to the OSD journal.
This is a separate partition that can be on the same drive or a
different drive. It is faster to have the journal on an SSD if the OSD
drive is a regular spinning-disk drive.

The new BlueStore back-end was released as a technology preview in the Ceph Jewel release. In the Luminous release, it had became the default data storage handler. This helps to overcome the double write penalty of FileStore by writing the the data to the block device first and then updating the metadata of the data's location. That means that in some cases, BlueStore is twice as fast as FileStore. All of the metadata is also stored in the fast RocksDB key-value store. File systems are no longer required for OSDs because BlueStore writes data directly to the block device of the hard drive. [2] It is recommended to have a 3:1 ratio for OSDS to BlueStore journals/metadata. The metadata drives should be a fast storage medium such as an SSD or NVMe.

``ceph-volume`` is a tool for automagically figuring out which disks to use for journals/metadata or OSDs. It replaces ceph-disk and supports BlueStore. It does not support loopback devices. The logic it normally follows is:

-  1 OSD per HDD
-  2 OSDs per SSD
-  HDD + SSD = HDD OSDs and SSD metadata

The optimal number of PGs is found be using this equation (replacing the number of OSD daemons and how many replicas are set). This number should be rounded up to the next power of 2. `PGCalc <https://ceph.io/pgcalc/>`__ is an online utility/calculator to help automatically determine this value.

::

    Total PGs = (<NUMBER_OF_OSDS> * 100) / <REPLICA_COUNT> / <NUMBER_OF_POOLS>

Example:

::

    OSD count = 30, replica count = 3, pool count = 1
    Run the calculations: 1000 = (30 * 100) / 3 / 1
    Find the next highest power of 2: 2^10 = 1024
    1000 =< 1024
    Total PGs = 1024

With Ceph's configuration, the Placement Group for Placement purpose
(PGP) should be set to the same PG number. PGs are the number of number
of times a file should be split. This change only makes the Ceph cluster
rebalance when the PGP count is increased.

-  New pools:

File:  /etc/ceph/ceph.conf

.. code-block:: ini

       [global]
       osd pool default pg num = <OPTIMAL_PG_NUMBER>
       osd pool default pgp num = <OPTIMAL_PG_NUMBER>

-  Existing pools:

.. code-block:: sh

    $ sudo ceph osd pool set <POOL> pg_num <OPTIMAL_PG_NUMBER>
    $ sudo ceph osd pool set <POOL> pgp_num <OPTIMAL_PG_NUMBER>

Cache pools can be configured used to cache files onto faster drives.
When a file is continually being read, it will be copied to the faster
drive. When a file is first written, it will go to the faster drives.
After a period of time of lesser use, those files will be moved to the
slow drives. [3]

For testing, the "cephx" authentication protocols can temporarily be
disabled. This will require a restart of all of the Ceph services.
Re-enable ``cephx`` by setting these values from "none" to "cephx." [4]

File: /etc/ceph/ceph.conf

.. code-block:: ini

    [global]
    auth cluster required = none
    auth service required = none
    auth client required = none

Releases
--------

Starting with the Luminous 12 release, all versions are supported for two years. A new release comes out every year. [13]

-  ``<RELEASE_NAME> <RELEASE_NUMBER> = <RELEASE_DATE>``
-  Luminous 12 = 2017-02
-  Mimic 13 = 2018-05
-  Nautilus 14 = 2019-03
-  Octopus 15 = 2020-03

Installation
------------

Ceph Requirements:

-  Fast CPU for OSD and metadata nodes.
-  1GB RAM per 1TB of Ceph OSD storage, per OSD daemon.
-  1GB RAM per monitor daemon.
-  1GB RAM per metadata daemon.
-  An odd number of monitor nodes (starting at least 3 for high
   availability and quorum). [5]

Quick
~~~~~

This example demonstrates how to deploy a 3 node Ceph cluster with both
the monitor and OSD services. In production, monitor servers should be
separated from the OSD storage nodes.

-  Create a new Ceph cluster group, by default called "ceph."

   .. code-block:: sh

       $ sudo ceph-deploy new <SERVER1>

-  Install the latest LTS release for production environments on the
   specified servers. SSH access is required.

   .. code-block:: sh

       $ sudo ceph-deploy install --release jewel <SERVER1> <SERVER2> <SERVER3>

-  Initialize the first monitor.

   .. code-block:: sh

       $ sudo ceph-deploy mon create-initial <SERVER1>

-  Install the monitor service on the other nodes.

   .. code-block:: sh

       $ sudo ceph-deploy mon create <SERVER2> <SERVER3>

-  List the available hard drives from all of the servers. It is
   recommended to have a fully dedicated drive, not a partition, for
   each Ceph OSD.

   .. code-block:: sh

       $ sudo ceph-deploy disk list <SERVER1> <SERVER2> <SERVER3>

-  Carefully select the drives to use. Then use the "disk zap" arguments
   to zero out the drive before use.

   .. code-block:: sh

       $ sudo ceph-deploy disk zap <SERVER1>:<DRIVE> <SERVER2>:<DRIVE> <SERVER3>:<DRIVE>

-  Prepare and deploy the OSD service for the specified drives. The
   default file system is XFS, but Btrfs is much feature-rich with
   technologies such as copy-on-write (CoW) support.

   .. code-block:: sh

       $ sudo ceph-deploy osd create --fs-type btrfs <SERVER1>:<DRIVE> <SERVER2>:<DRIVE> <SERVER3>:<DRIVE>

-  Verify it's working.

   .. code-block:: sh

       $ sudo ceph status

[6]

ceph-ansible (<= Octopus)
~~~~~~~~~~~~~~~~~~~~~~~~~

The ceph-ansible project is used to deploy and update Ceph clusters using Ansible. It is deprecated and replaced by `cephadm <https://docs.ceph.com/docs/master/cephadm/>`__.

.. code-block:: sh

    $ sudo git clone https://github.com/ceph/ceph-ansible/
    $ sudo cd ceph-ansible/

Configure the Ansible inventory hosts file. This should contain the SSH
connection details to access the relevant servers.

Inventory hosts:

-  [mons] = Monitors for tracking and locating object storage data.
-  [osds] = Object storage device nodes for storing the user data.
-  [mdss] = Metadata servers for CephFS. (Optional)
-  [rwgs] = RADOS Gateways for Amazon S3 or OpenStack Swift object
   storage API support. (Optional)

Example inventory:

.. code-block:: ini

    ceph_monitor_01 ansible_host=192.168.20.11
    ceph_monitor_02 ansible_host=192.168.20.12
    ceph_monitor_03 ansible_host=192.168.20.13
    ceph_osd_01 ansible_host=192.168.20.101 ansible_port=2222
    ceph_osd_02 ansible_host=192.168.20.102 ansible_port=2222
    ceph_osd_03 ansible_host=192.168.20.103 ansible_port=2222

    [mons]
    ceph_monitor_01
    ceph_monitor_02
    ceph_monitor_03

    [osds]
    ceph_osd_01
    ceph_osd_02
    ceph_osd_03

Copy the sample configurations and modify the variables.

.. code-block:: sh

    $ sudo cp site.yml.sample site.yml
    $ sudo cd group_vars/
    $ sudo cp all.yml.sample all.yml
    $ sudo cp mons.yml.sample mons.yml
    $ sudo cp osds.yml.sample osds.yml

Common variables:

-  group\_vars/all.yml = Global variables.

   -  ceph\_origin = Specify how to install the Ceph software.

      -  upstream = Use the official repositories.
      -  Upstream related variables:

         -  ceph\_dev: Boolean value. Use a development branch of Ceph
            from GitHub.
         -  ceph\_dev\_branch = The exact branch or commit of Ceph from
            GitHub to use.
         -  ceph\_stable = Boolean value. Use a stable release of Ceph.
         -  ceph\_stable\_release = The release name to use. The LTS
            "jewel" release is recommended.

      -  distro = Use repositories already present on the system.
         ceph-ansible will not install Ceph repositories with this
         method, they must already be installed.

   -  ceph\_release\_num = If "ceph\_stable" is not defined, use any
      specific major release number.

      -  9 = infernalis
      -  10 = jewel
      -  11 = kraken

-  group\_vars/osds.yml = Object storage daemon variables.

   -  devices = A list of drives to use for each OSD daemon.
   -  osd\_auto\_discovery = Boolean value. Default: false. Instead of
      manually specifying devices to use, automatically use any drive
      that does not have a partition table.
   -  OSD option #1:

      -  journal\_collocation = Boolean value. Default: false. Use the
         same drive for journal and data storage.

   -  OSD option #2:

      -  raw\_multi\_journal = Boolean value. Default: false. Store
         journals on different hard drives.
      -  raw\_journal\_devices = A list of devices to use for
         journaling.

   -  OSD option #3:

      -  osd\_directory = Boolean value. Default: false. Use a specified
         directory for OSDs. This assumes that the end-user has already
         partitioned the drive and mounted it to
         ``/var/lib/ceph/osd/<OSD_NAME>`` or a custom directory.
      -  osd\_directories = The directories to use for OSD storage.

   -  OSD option #4:

      -  bluestore: Boolean value. Default: false. Use the new and
         experimental BlueStore file store that can provide twice the
         performance for drives that have both a journal and OSD for
         Ceph.

   -  OSD option #5:

      -  dmcrypt\_journal\_collocation = Use Linux's "dm-crypt" to
         encrypt objects when both the journal and data are stored on
         the same drive.

   -  OSD option #6:

      -  dmcrypt\_dedicated\_journal = Use Linux's "dm-crypt" to encrypt
         objects when both the journal and data are stored on the
         different drives.

Finally, run the Playbook to deploy the Ceph cluster.

.. code-block:: sh

    $ sudo ansible-playbook -i production site.yml

[7]

CRUSH Map
---------

CRUSH maps are used to keep track of OSDs, physical locations of
servers, and it defines how to replicate objects.

These maps are divided into four main parts:

-  Devices = The list of each OSD daemon in the cluster.
-  Bucket Types = Definitions that can group OSDs into groups with their
   own location and weights based on servers, rows, racks, datacenters,
   etc.
-  Bucket Instances = A bucket instance is created by specifying a
   bucket type and one or more OSDs.
-  Rules = Rules can be defined to configure which bucket instances will
   be used for reading, writing, and/or replicating data.

A binary of the configuration must be saved and then decompiled before
changes can be made. Then the file must be recompiled for the updates to
be loaded.

.. code-block:: sh

    $ sudo ceph osd getcrushmap -o <NEW_COMPILED_FILE>
    $ sudo crushtool -d <NEW_COMPILED_FILE> -o <NEW_DECOMPILED_FILE>
    $ sudo vim <NEW_DECOMPILED_FILE>`
    $ sudo crushtool -c <NEW_DECOMPILED_FILE> -o <UPDATED_COMPILED_FILE>
    $ sudo ceph osd setcrushmap -i <UPDATED_COMPILED_FILE>

Devices
~~~~~~~

Devices must follow the format of ``device <COUNT> <OSD_NAME>``. These
are automatically generated but can be adjusted and new nodes can be
manually added here.

::

    # devices
    device 0 osd.0
    device 1 osd.1
    device 2 osd.2

Bucket Types
~~~~~~~~~~~~

Bucket types follow a similar format of ``type <COUNT> <TYPE_NAME>``.
The name of the type can be anything. The higher numbered type always
inherits the lower numbers. The default types include:

::

    # types
    type 0 osd
    type 1 host
    type 2 chassis
    type 3 rack
    type 4 row
    type 5 pdu
    type 6 pod
    type 7 room
    type 8 datacenter
    type 9 region
    type 10 root

Bucket Instances
~~~~~~~~~~~~~~~~

Bucket instances are used to group OSD configurations together.
Typically these should define physical locations of the OSDs.

::

    <CUSTOM_BUCKET_TYPE> <UNIQUE_BUCKET_NAME> {
        id <UNIQUE_NEGATIVE_NUMBER>
        weight <FLOATING_NUMBER>
        alg <BUCKET_TYPE>
        hash 0
        item <OSD_NAME> weight <FLOATING_NUMBER>
    }

-  ``<CUSTOM_BUCKET_TYPE>`` = Required. This should be one of the
   user-defined bucket types.
-  ``<UNIQUE_BUCKET_NAME>`` = Required. A unique name that describes the
   bucket.
-  id = Required. A unique negative number to identify the bucket.
-  weight = Optional. A floating/decimal number for all of the weight of
   all of the OSDs in this bucket.
-  alg = Required. Choose which Ceph bucket type/method that is used to
   read and write objects. This should not be confused with the
   user-defined bucket types.

   -  Uniform = Assumes that all hardware in the bucket instance is
      exactly the same so all OSDs receive the same weight.
   -  List = Lists use the RUSH algorithm to read and write objects in
      sequential order from the first OSD to the last. This is best
      suited for data that does not need to be deleted (to avoid
      rebalancing).
   -  Tree = The binary search tree uses the RUSH algorithm to
      efficiently handle larger amounts of data.
   -  Straw = A combination of both "list" and "tree." One of the two
      bucket types will randomly be selected for operations. Replication
      is fast but rebalancing will be slow.

-  hash = Required. The hashing algorithm used by CRUSH to lookup and
   store files. As of the Jewel release, only option "0" for "rjenkins1"
   is supported.
-  item = Optional. The OSD name and weight for individual OSDs. This is
   useful if a bucket instance has hard drives of different speeds.

Rules
~~~~~

By modifying the CRUSH map, replication can be configured to go to a
different drive, server, chassis, row, rack, datacenter, etc.

::

    rule <RULE_NAME> {
        ruleset <RULESET>
        type <RULE_TYPE>
        min_size <MINIMUM_SIZE>
        max_size <MAXIMUM_SIZE>
        step take <BUCKET_INSTANCE_NAME>
        step <CHOOSE_OPTION>
        step emit
    }

-  ``<RULE_NAME>``
-  ruleset = Required. An integer that can be used to reference this
   ruleset by a pool.
-  type = Required. Default is "replicated." How to handle data
   replication.

   -  replicated = Data is replicated to different hard drives.
   -  erasure = This a similar concept to RAID 5. Data is only
      replicated to one drive. This option helps to save space.

-  min\_size
-  max\_size
-  step take
-  step emit = Required. This signifies the end of the rule block.

[8]

Repair
------

Ceph automatically runs through a data integrity check called
"scrubbing." This checks the health of each placement group (object).
Sometimes these can fail due to inconsistencies, commonly a mismatch in
time on the OSD servers.

In this example, the placement group "1.28" failed to be scrubbed. This
object exists on the 8, 11, and 20 OSD drives.

-  Check the health information.

   -  Example:

      .. code-block:: sh

          $ sudo ceph health detail
          HEALTH_ERR 1 pgs inconsistent; 1 scrub errors
          pg 1.28 is active+clean+inconsistent, acting [8,11,20]
          1 scrub errors

-  Manually run a repair.

   -  Syntax:

      .. code-block:: sh

          $ sudo ceph pg repair <PLACEMENT_GROUP>

   -  Example:

      .. code-block:: sh

          $ sudo ceph pg repair 1.28

-  Find the error:

   -  Syntax:

      .. code-block:: sh

          $ sudo grep ERR /var/log/ceph/ceph-osd.<OSD_NUMBER>.log

   -  Example:

      .. code-block:: sh

          $ sudo grep ERR /var/log/ceph/ceph-osd.11.log
          2017-01-12 22:27:52.626252 7f5b511e8700 -1 log_channel(cluster) log [ERR] : 1.27 shard 12: soid 1:e4c200f7:::rbd_data.a1e002238e1f29.000000000000136d:head candidate had a read error

-  Find the bad file.

   -  Syntax:

      .. code-block:: sh

          $ sudo find /var/lib/ceph/osd/ceph-<OSD_NUMBER>/current/<PLACEMENT_GROUP>_head/ -name '*<OBJECT_ID>*' -ls

   -  Example:

      .. code-block:: sh

          $ sudo find /var/lib/ceph/osd/ceph-11/current/1.28_head/ -name "*a1e002238e1f29.000000000000136d*"
          /var/lib/ceph/osd/ceph-11/current/1.28_head/DIR_7/DIR_2/DIR_3/rbd\udata.b3e012238e1f29.000000000000136d__head_EF004327__1

-  Stop the OSD.

   -  Syntax:

      .. code-block:: sh

          $ sudo systemctl stop ceph-osd@<OSD_NUMBER>.service

   -  Example:

      .. code-block:: sh

          $ sudo systemctl stop ceph-osd@11.service

-  Flush the journal to save the current files cached in memory.

   -  Syntax:

      .. code-block:: sh

          $ sudo ceph-osd -i <OSD_NUMBER> --flush-journal

   -  Example:

      .. code-block:: sh

          $ sudo ceph-osd -i 11 --flush-journal

-  Move the bad object out of it's current directory in the OSD.

   -  Example:

      .. code-block:: sh

          $ sudo mv /var/lib/ceph/osd/ceph-11/current/1.28_head/DIR_7/DIR_2/DIR_3/rbd\\udata.b3e012238e1f29.000000000000136d__head_EF004327__1 /root/ceph_osd_backups/

-  Restart the OSD.

   -  Syntax:

      .. code-block:: sh

          $ sudo systemctl restart ceph-osd@<OSD_NUMBER>.service

   -  Example:

      .. code-block:: sh

          $ sudo systemctl restart ceph-osd@11.service

-  Run another placement group repair.

   -  Syntax:

      .. code-block:: sh

          $ sudo ceph pg repair <PLACEMENT_GROUP>

   -  Example:

      .. code-block:: sh

          $ sudo ceph pg repair 1.28

[9]

libvirt
-------

Virtual machines that are run via the libvirt front-end can utilize
Ceph's RADOS block devices (RBDs) as their main disk.

-  Add the network disk to the available devices in the Virsh
   configuration.

   .. code-block:: xml

       <devices>
       <disk type='network' device='disk'>
           <source protocol='rbd' name='<POOL>/<IMAGE>'>
               <host name='<MONITOR_IP>' port='6789'/>
           </source>
           <target dev='vda' bus='virtio'/>
       </disk>
       ...
       </devices>

-  Authentication is required so the Ceph client credentials must be
   encrypted by libvirt. This encrypted hash is called a "secret."

-  Create a Virsh template that has a secret of type "ceph" with a
   description for the end user. Optionally specify a UUID for this
   secret to be associated with or else one will be generated. Example file: ceph-secret.xml

   .. code-block:: xml

       <secret ephemeral='no' private='no'>
       <uuid>51757078-7d63-476f-8524-5d46119cfc8a</uuid>
       <usage type='ceph'>
           <name>The Ceph client key</name>
       </usage>
       </secret>

-  Define a blank secret from this template.

   .. code-block:: sh

       $ sudo virsh secret-define --file ceph-secret.xml

-  Verify that the secret was created.

   .. code-block:: sh

       $ sudo virsh secret-list

-  Set the secret to the Ceph client's key. [10]

   .. code-block:: sh

       $ sudo virsh secret-set-value --secret <GENERATED_UUID> --base64 $(ceph auth get-key client.<USER>)

-  Finally, the secret needs to be referenced as type "ceph" with either
   the "usage" (description) or "uuid" or the secret element that has
   been created. [11]

   .. code-block:: xml

       <devices>
       <disk type='network' device='disk'>
       ...
       <auth username='<CLIENT>'>
         <secret type='ceph' usage='The Ceph client key'/>
       </auth>
       ...
       <disk>
       ...
       </devices>

CephFS
------

CephFS has been stable since the Ceph Jewel 10.2.0 release. This now
includes repair utilities, including fsck. For clients, it is
recommended to use a Linux kernel in the 4 series, or newer, to have the
latest features and bug fixes for the file system. [12]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/storage/ceph.rst>`__
-  `< 2019.07.01 <https://github.com/ekultails/rootpages/commits/main/src/administration/file_systems.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/main/src/file_systems.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/main/markdown/file_systems.md>`__

Bibliography
------------

1. Karan Singh *Learning Ceph* (Birmingham, UK: Packet Publishing, 2015)
2. "Ceph Jewel Preview: a new store is coming, BlueStore." Sebastien Han. March 21, 2016. Accessed December 5, 2018. https://www.sebastien-han.fr/blog/2016/03/21/ceph-a-new-store-is-coming/
3. "CACHE POOL." Ceph Documentation. Accessed January 19, 2017. http://docs.ceph.com/docs/jewel/dev/cache-pool/
4. "CEPHX CONFIG REFERENCE." Ceph Documentation. Accessed January 28, 2017. http://docs.ceph.com/docs/master/rados/configuration/auth-config-ref/
5. "INTRO TO CEPH." Ceph Documentation. Accessed January 15, 2017. http://docs.ceph.com/docs/jewel/start/intro/
6. "Ceph Deployment." Ceph Jewel Documentation. Accessed January 14, 2017. http://docs.ceph.com/docs/jewel/rados/deployment/
7. "ceph-ansible Wiki." ceph-ansible GitHub. February 29, 2016. Accessed January 15, 2017. https://github.com/ceph/ceph-ansible/wiki
8. "CRUSH MAPS." Ceph Documentation. Accessed January 29, 2017. http://docs.ceph.com/docs/master/rados/operations/crush-map/
9. "Ceph: manually repair object." April 27, 2015. Accessed January 15, 2017. http://ceph.com/planet/ceph-manually-repair-object/
10. "USING LIBVIRT WITH CEPH RBD." Ceph Documentation. Accessed January 27, 2017. http://docs.ceph.com/docs/master/rbd/libvirt/
11. "Secret XML." libvirt. Accessed January 27, 2017. https://libvirt.org/formatsecret.html
12. "USING CEPHFS." Ceph Documentation. Accessed January 15, 2017. http://docs.ceph.com/docs/master/cephfs/
13. "Ceph Releases (general)". Ceph Documentation. July 27, 2020. Accessed August 13, 2020. https://docs.ceph.com/docs/master/releases/general/
