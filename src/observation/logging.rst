Logging
=======

.. contents:: Table of Contents

Overview
--------

Logging is the process of collecting metrics from a server and logging them. For managing a large number of server deployments, these logs should be sent to a database server. The database can be queried by a monitoring program to help track down issues and optionally visualize the data.

::

[Log collector] --> [Database] --> [Monitoring dashboard with API and/or UI]

Collectors:

-  `Apache Flume <https://flume.apache.org/>`__
-  `collectd <https://collectd.org/>`__
-  `fluentd <https://www.fluentd.org/>`__
-  `Logstash <https://www.elastic.co/logstash>`__
-  `Telegraf <https://www.influxdata.com/time-series-platform/telegraf/>`__

collectd
--------

collectd gathers and distributes metrics of a running system. A full list of metric collection plugins that collectd supports can be found `here <https://collectd.org/wiki/index.php/Table_of_Plugins>`__. [1]

collectd is available in most major repositories. [2]

CentOS and RHEL:

.. code-block:: sh

   $ sudo yum install epel-release
   $ sudo yum install collectd

Debian and Ubuntu:

.. code-block:: sh

   $ sudo apt-get install collectd

By default, collectd gathers information about the CPU utilization (``cpu``) and ``load``, network ``interface`` bandwidth, and ``memory`` usage. The hostname and desired plugins should be defined in the ``/etc/collectd.conf`` configuration file at a minimum.

::

   Hostname <FQDN>
   LoadPlugin <PLUGIN>

Define a database server that the network plugin should send the logs to. This can be InfluxDB, Logstash, or any other logging database. Alternatively, the ``dbi`` plugin can be used to connect to many different database back-ends directly.

::

   <Plugin network>
     Server "<DB_ADDRESS>" "<DB_PORT>"
   </Plugin>

Start the service.

.. code-block:: sh

   $ sudo systemctl start collectd

[3]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/observation/logging.rst>`__

Bibliography
------------

1. "collectd – The system statistics collection daemon." collectd.org. Accessed July 9, 2020. https://collectd.org/
2. "[collectd] Download." collectd.org. Accessed July 9, 2020. https://collectd.org/download.shtml
3. "Monitoring Linux performance with Grafana." August 28, 2017. Accessed July 9, 2020. https://opensource.com/article/17/8/linux-grafana
