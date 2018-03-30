Monitoring
==========

.. contents:: Table of Contents

Monit
-----

Monit is a complete service monitoring software. It has a web interface
that is available by default on the localhost interface via port 2812.
It can detect if a service is down and restart it. Automatically alerts
can also be configured.

Configuration
~~~~~~~~~~~~~

Install monit:

RHEL

.. code-block:: sh

    $ sudo yum install epel-release
    $ sudo yum install monit

Ubuntu

.. code-block:: sh

    $ sudo apt-get install monit

Depending on your system, the main configuration file is one of these
two below. The default settings can be used. The configurations are not
case sensitive.

-  /etc/monitrc
-  /etc/monit.conf

The include directory for other configuration files will be on of these
two:

-  /etc/monit.d/
-  /etc/monit/conf.d/

[1]

Global configuration options:

-  SET DAEMON ``<SECONDs>``

    -  Specify the cycle time in seconds. After this many seconds, each service in the configuration will be polled.

-  SET ALERT ``<EMAIL>@<ADDRESS>``

    -  Send all alerts to this e-mail address.

-  SET MAILSERVER ``<HOSTNAME>`` [``<PORT>``] [USERNAME ``<USERNAME>``] [PASSWORD ``<PASSWORD>``]

    -  Define the mail server to use. This is typically localhost.

An example of a basic Nginx template is provided below. If the PID is
not found, then monit will continue to attempt to start it until the new
process is spawned.

Example:

::

    check process nginx with pidfile /var/run/nginx.pid
    start program = "/bin/systemctl start nginx"
    stop program = "/bin/systemctl stop nginx"

-  check system ``<NAME>``
-  Check system resources.
-  Checks:

   -  IF ``<RESOURCE>`` ``<OPERATOR>`` THEN ``<ACTION>``

-  check process ``<SERVICE_NAME>`` with pidfile ``<PATH_TO_PIDFILE>``
-  Verify that the PID is running.
-  Checks:

   -  IF CHANGED PID THEN ``<ACTION>``
   -  IF UPTIME ``<OPERATOR>`` value ``<TIME_UNIT>`` THEN ``<ACTION>``
   -  IF ``<RESOURCE>`` ``<OPERATOR>`` THEN ``<ACTION>``

-  check file ``<SERVICE_NAME>`` with path ``<PATH_TO_FILE>``
-  Verify a file exists with specific attributes. The "check directory"
   should be used instead if verifying a directory state.
-  Checks:

   -  IF FAILED UID ``<UID_OR_USERNAME>`` THEN ``<ACTION>``
   -  IF FAILED GID ``<GID_OR_GROUPNAME>`` THEN ``<ACTION>``
   -  IF FAILED PERMISSION ``<OCTAL_PERMISSION>`` THEN ``<ACTION>``
   -  IF SIZE ``<OPERATOR>`` ``<NUMBER>`` ``<SIZE_UNIT>`` THEN
      ``<ACTION>``
   -  IF CHANGED SIZE THEN ``<ACTION>``
   -  IF CHANGED [MD5\|SHA1] CHECKSUM THEN ``<ACTION>``
   -  IF FAILED [MD5\|SHA1] CHECKSUM [EXPECT ``<CHECKSUM>``] THEN
      ``<ACTION>``
   -  IF TIMESTAMP ``<OPERATOR>`` ``<TIME_VALUE>`` ``<TIME_UNIT>`` THEN
      ``<ACTION>``

-  check program ``<SERVICE_NAME>`` with ``<PATH_TO_SCRIPT>``
-  Execute a script and verify it's exit code.
-  Checks:

   -  IF STATUS ``<OPERATOR>`` ``<EXIT_CODE>`` THEN ``<ACTION>``

-  check host ``<HOSTNAME>`` WITH ADDRESS ``<IP_ADDRESS>``
-  Verify that the remote host is accessible.
-  Checks:

   -  IF FAILED PING[4\|6] [COUNT ``<NUMBER_VALUE>``] [SIZE
      ``<MTU_SIZE>``] [TIMEOUT ``<NUMBER_VALUE>`` ``<TIME_UNIT>``]
      [ADDRESS ``<IP_ADDRESS>``] THEN ``<ACTION>``
   -  IF FAILED PORT ``<PORT_NUMBER>`` [TYPE ``[TCP|UDP]``] [PROTOCOL
      ``<PROTOCOL>``]

-  check network ``<NETWORK_NAME>`` WITH INTERFACE ``<INTERFACE>``
-  Verify that an IP address exists on the local machine. This is useful
   for failover type load balancers.
-  Checks:

   -  IF FAILED LINK THEN ``<ACTION>``
   -  IF SATURATION ``<OPERATOR>`` ``<PERCENT>`` THEN ``<ACTION>``

-  check filesystem ``<FILE_SYSTEM_NAME>``\ with path
   ``<PATH_TO_DEVICE>``
-  Verify statistics about a file system.

   -  ``<PATH_TO_DEVICE>`` can be a block device, mount, or directory.

-  Checks:

   -  IF SPACE USAGE ``<OPERATOR>`` ``<SIZE_VALUE>`` ``<SIZE_UNIT>``
      THEN ``<ACTION>``
   -  IF SPACE FREE ``<OPERATOR>`` ``<SIZE_VALUE>`` ``<SIZE_UNIT>`` THEN
      ``<ACTION>``
   -  IF INODE USAGE ``<OPERATOR>`` ``<SIZE_VALUE>`` ``<SIZE_UNIT>``
      THEN ``<ACTION>``
   -  IF INODE FREE ``<OPERATOR>`` ``<SIZE_VALUE>`` ``<SIZE_UNIT>`` THEN
      ``<ACTION>``

Valid operators:

-  "<", "lt", or "less"
-  ">", "gt", or "greater"
-  "==", "eq", or "equal"
-  "!=", "ne", or "notequal"

Valid size units:

-  "B", or "byte"
-  "KB", or "kilobyte"
-  "MB", or "megabyte"
-  "GB", or "gigabyte"
-  "%", or "percent".

Valid time units:

-  "SECOND", or "SECONDS"
-  "MINUTE", or "MINUTES"
-  "HOUR", or "HOURS"
-  "DAY", or "DAYS"

Valid resources:

-  CPU([user\|system\|wait])
-  THREADS
-  CHILDREN
-  TOTAL MEMORY ``<SIZE_UNIT>``
-  The memory usage of the main process and all of the children.
-  MEMORY ``<SIZE_UNIT>``
-  The memory usage of just the main process. Alternatively this can
   monitor all of the server's memory usage.
-  SWAP ``<SIZE_UNIT>``
-  LOADAVG([1min\|5min\|15min])

Valid protocols:

-  dns
-  http
-  https
-  mysql
-  smtp

Valid actions:

-  "ALERT"
-  Send an e-mail alert.
-  "RESTART"
-  Run the restart function (or the stop and then start functions if the
   restart command is not specified). This will also send an e-mail
   alert.
-  "START"
-  Run the start service function.
-  "STOP"
-  Run the stop service function.
-  "EXEC"
-  Execute a specified script.
-  "UNMONITOR"
-  Stop monitoring the service.

[2]

Event Types:

-  1=checksum
-  2=resource
-  4=timeout
-  8=timestamp
-  16=size
-  32=connection
-  64=permission
-  128=UID
-  256=GID
-  512=nonexist
-  1024=invalid
-  2048=data
-  4096=exec
-  8192=fsflags
-  16384=icmp
-  32768=content
-  65536=instance
-  131072=action
-  262144=PID
-  524288=PPID
-  1048576=heartbeat
-  2097152=status
-  4194304=uptime [3]

`Errata <https://github.com/ekultails/rootpages/commits/master/src/monitoring.rst>`__
-------------------------------------------------------------------------------------

Bibliography
------------

1. "Installing Monit for Server Monitoring." Linode. October 15, 2015.
   Accessed November 22, 2016.
   https://www.linode.com/docs/uptime/monitoring/monitoring-servers-with-monit
2. "Mont Documentation." Accessed September 30, 2016.
   https://mmonit.com/monit/documentation/monit.html
3. "Monit Events." Accessed September 30, 2016.
   https://mmonit.com/documentation/http-api/Methods/Events
