HTTP Servers
============

.. contents:: Table of Contents

Apache 2.4
----------

The Apache HTTP Server Project is designed to provide a versatile open
source HTTP and HTTPS web server. It is one of the top used web servers.
[1]

Configuration
~~~~~~~~~~~~~

There is generally one primary Apache configuration file that then
includes other possible configuration files.

Fedora file: /etc/http/conf/httpd.conf

Debian file: /etc/apache2/apache2.conf

Options:

-  ServerRoot = Specify what directory Apache should use as a relative
   path.

   -  Example: ServerRoot "/etc/httpd"

-  Listen = What port (and optionally address) Apache should listen on.

   -  Example #1: Listen 127.0.0.1:80
   -  Example #2: Listen 443

-  User = The user that Apache should be run as.

   -  Example: User apache

-  Group = The group that Apache should be run with.
-  ServerAdmin = Provide an e-mail address that will get e-mails when
   there are any errors.
-  LogLevel = Specify how verbose logging should be.

   -  error
   -  warn
   -  info
   -  debug

-  ErrorDocument = Provide a custom page for specific error numbers.
   This can either be text, a file, script, or redirect.

   -  Example #1: ErrorDocument 500 "Contact your System Administrator
      for help. Thank you."
   -  Example #2: ErrorDocument 403
      "/cgi-bin/you\_didnt\_say\_the\_magic\_word.py"

-  ErrorLog = The file to use for the error log.
-  CustomLog = The file to use for logging Apache access information.
-  IncludeOptional = Specify what directory (under ServerRoot) to load
   other configurations from.

   -  Example: IncludeOptional conf.d/\*.conf

[2]

Verify that the configuration is correct with one of these commands:

.. code-block:: sh

    $ sudo apachectl configtest

.. code-block:: sh

    $ sudo httpd -t

Virtual Hosts
~~~~~~~~~~~~~

A virtual host file is part of the configuration that is required for
Apache to load a domain.

Syntax:

::

    <VirtualHost *:80>
    </VirtualHost>

Options:

-  ServerName = The main domain name for the virtual host.
-  ServerAlias = Other domains associated with the virtual host
-  DocumentRoot = The directory where the domain loads its files from.
-  DirectoryIndex = The main file that is loaded up in a directory, if
   found. Default: "index.html" or "index.htm."
-  LogLevel, ErrorLog, and CustomLog = Refer to the `Apache
   Configuration <#apache---configuration>`__ section.

Example:

::

    <VirtualHost 127.0.0.1:80>
        ServerName  rootpages.tld
        ServerAlias www.rootpages.tld
        DirectoryIndex index.html
        DocumentRoot /var/www/html/rootpages/
        LogLevel warn
        ErrorLog /var/log/httpd/rootpages_tld.error_log
        CustomLog /var/log/httpd/rootpages_tld.custom_log
    </VirtualHost>

[3]

Files, Directories, and Locations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Different settings can be used on items based on if a matched file,
directory, or location is found. Regular expressions can be used to
match different areas.

-  File = Match a specific file name.
-  Syntax:

   ::

       <File "/path/to/file.html">
       </File>

-  Directory = Match a specific directory name.
-  Syntax:

   ::

       <Directory "/path/to/dir">
       </Directory>

-  Location = Match any location. This can be a directory, alias, or a
   redirect path.
-  Syntax:

   ::

       <Location "/path/to/location">
       </Location>

Options:

-  Require = Set an access control list to allow certain hosts or IPs.

   -  all = Apply the rule to all hosts.
   -  host = Apply the rule to a specific host.
   -  ip = Apply the rule to an IP address

      -  granted = Allow the matched rule.
      -  denied = Deny the matched rule.

-  Require not [all\|host\|ip] = Deny access to a host or IP. This
   should be configured after a Require rule. [4]
-  Options = Specify attributes of the matched area. Enable an option
   with a "+" or disable it with "-". If no sign is present, Apache
   assumes it should be enabled. If at least one option requires a sign
   then all of the other options will need a sign.

   -  All = Allow of the options.
   -  ExecGI = Allow CGI scripts to be executed.
   -  Includes = Allow HTML include functionality to include files
      server-side.
   -  IncludesNOEXEC = The same as Includes but it does not allow HTML
      files to execute commands or scripts.
   -  Indexes = Show the content of a directory if the DirectoryIndex is
      not found.
   -  FollowSymLinks = Allow symlinks to different directories. [5]

A combination of a "Require all" or "Require not all" and then an
explicit allow/deny list can only be used within a "RequireAll" block.

::

    <Directory "/var/www/html">
        <RequireAll>
            Require all granted
            Require not ip 192.168.14.19
            Require not host server.hostname.tld
        </RequireAll>
    </Directory>

Authentication
~~~~~~~~~~~~~~

Locations can be secured by a username and password. Users can also be
assigned to groups.

Create an Apache user.

.. code-block:: sh

    $ sudo htpasswd -c /etc/httpd/conf.d/passwd <USER1>

Another user can be appended to this file by omitting the "-c" create
option.

.. code-block:: sh

    $ sudo htpasswd /etc/httpd/conf.d/passwd <USER2>

A new file can be created to assign multiple users to a group.

File: /etc/httpd/conf.d/group

::

    <GROUP>: <USER1> <USER2>

Authentication can now be applied to any location. [6] The syntax is:

::
    AuthType Basic
    AuthName "Login Prompt Text"
    AuthUserFile "/path/to/passwd/file"
    AuthGroupFile "/path/to/group/file"
    Require [user|group] <USER|GROUP>

Example #1:

::

    <Directory "/var/www/html">
        AuthType Basic
        AuthName "Please Login"
        AuthUserFile "/etc/httpd/conf.d/joe_passwd"
        Require user joe
    </Directory>

Example #2:

::

    <File "/var/www/html/grades/spring_2016_grades.csv">
        AuthType Basic
        AuthName "Spring 2016 Class Login"
        AuthUserFile "/etc/httpd/conf.d/passwds"
        AuthGroupFile "/etc/httpd/conf.d/spring_2016"
        Require group spring_2016
    </File>

CGI
~~~

The common gateway interface (CGI) is a method of the web server
executing a script and then sending the results to a web browser. The
default way to handle dynamic CGI programs is to use the "mod\_cgi"
module.

In the main configuration, the new CGI bin folder has to be aliased to
/cgi-bin/. This way Apache knows that this should be a CGI folder.

::

    ScriptAlias "/cgi-bin/" "/path/to/custom/cgi-bin/"

Then the directory can be configured. It needs to allow the execution of
CGI, set everything in the folder to be executable via the cgi-script
handler, and allow access to it.

::

    <Directory "/path/to/custom/cgi-bin/">
        Options +ExecCGI
        SetHandler cgi-script
        Require all granted
    </Directory>

All CGI scripts have to either be a binary or have a shebang that
indicates the path to the binary that should execute the program. An
example shebang is "#!/bin/bash." The program will also need to first
print out "Content-type: text/html" so the web browser knows that it is
a HTML page. An example is shown below.

.. code-block:: sh

    #!/bin/bash
    echo "Content-type: text/html"
    echo "CGI Test Page"

All scripts should have readable and executable Unix permissions by the
anonymous user ("other") access category.

.. code-block:: sh

    $ sudo chmod -R o+rx /path/to/custom/cgi-bin/

[7]

SELinux
~~~~~~~

Red Hat Enterprise Linux and related distributions use SELinux as an
extra layer of security. In this case, by having SELinux, this ensures
that a compromised Apache cannot listen on non-standard ports or access
directories outside of it's scope. There may be cases where an
administrator needs to expand Apache's access so SELinux permissions
will need to be modified.

Install the troubleshooting utilities:

.. code-block:: sh

    $ sudo yum install setroubleshoot

View the current Apache ports allowed by SELinux:

.. code-block:: sh

    $ sudo semanage port -l | grep ^http_port_t
    http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000

Add a new allowed TCP port:

.. code-block:: sh

    $ sudo semanage port -a -t http_port_t -p tcp <PORT_NUMBER>

Lookup the Apache SELinux file context permissions. It should be
"httpd\_sys\_content\_t."

.. code-block:: sh

    $ ls -lahZ /var/www/html/
    drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 .
    drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 ..

Permanently fix SELinux permissions on a custom directory using the
semanage tool and then apply the permissions by running restorecon:

.. code-block:: sh

    $ sudo semanage fcontext -a -t httpd_sys_content_t "/path/to/custom/dir(/.*)?"
    $ sudo restorecon -Rv /path/to/custom/dir

[8]

NGINX
-----

NGINX was originally designed to be a proxy server and had eventually
added the functionality of being a HTTP web server. For HTTP, it is
focused on high-performance static content handling. Dynamic scripts
must be processed by a different web server.

Configuration
~~~~~~~~~~~~~

The NGINX configuration file ``/etc/nginx/nginx.conf`` contains
different blocks defined by using brackets ``{}``. Each line in the file
(besides that brackets) must end in a semicolon ``;``. Comments can be
created with a pound ``#`` symbol. [1] Below are some of the more common
configuration settings.

-  main = This is not a block. It is outside of the "events" and "http"
   directives. These settings affect how the main NGINX process is
   spawned and handled.

   -  error\_log = The global error log file.
   -  load\_module = Load an external NGINX module.
   -  pid = The file to store the main process ID (PID) of NGINX.
   -  user = The user to run as.
   -  worker\_processes = The number of threads to spawn.

      -  auto = Automatically use the number of threads that the server
         has.

-  events = Settings that affect how the NGINX process handles each
   request.

   -  worker\_connections = The number of connections that can be
      handled by each worker process.

-  http = Global settings for the HTTP web server.

   -  disable\_symlinks

      -  off = Default. Follow symlinks.
      -  on = Do not follow symlinks.
      -  if\_not\_owner = Only follow a symlink if the destination file
         is owned by the same user.
      -  from = Only disable symlinks originating from a specific
         location.

   -  error\_log
   -  error\_page ``<CODE>`` ``<FILE>`` = The error page that should be
      used for a particular HTTP error code.
   -  root = The root directory to load up.

-  server = A virtual host definition. This defines what ports to listen
   on, what IP address or hostname to be associated with, on and
   locations to serve content from.

   -  error\_log
   -  error\_page
   -  etag = Turn MD5 checksum (etag) generation on or off.
   -  listen ``{<PORT>|<ADDRESS>:<PORT>}`` = The port and/or address to
      listen on for the virtual host.
   -  root
   -  server\_name = A list (separated by spaces) of domain names that
      the virtual host should respond to.
   -  try\_files $uri $uri/\ ``<FILE>`` = Specify the default file to
      load for any given request. Typically this is ``index.html``.

-  location = The URL path after a domain name that NGINX should load
   and how to handle it. For example, the location "/admin" would define
   what to do when a web browser accesses ``http://127.0.0.1/admin``.

   -  alias = A different path that the location should load.
   -  disable\_symlinks
   -  error\_log
   -  error\_page
   -  root
   -  try\_files

[10][11]

::

    # Main.
    events {
        # Connection process settings.
    }

    http {
        # Global HTTP settings.
        server {
            # Virtual host content.
            location <PATH> {
                # How to handle a path to a URL.
            }
        }
    }

[9]

Squid
-----

Squid is a caching proxy. It can cache content to RAM and/or a directory. These are the supported protocols that can be proxied and cached [14]:

-  FMP
-  FTP
-  Gopher
-  GSS-HTTP
-  HTTP
-  HTTPS
-  Multiling-HTTP
-  WAIS

There are some limiations with Squid proxy cache:

-  Does not natively work with content delivery networks (CDNs) that change the HTTP headers or DNS. That content will not be cached unless filter rules for a specific CDN are added.

   -  `Here <https://blog.thelifeofkenneth.com/2014/08/using-squid-storeids-to-optimize-steams.html>`__ is an example of how to configure a filter for the Steam CDN to work with Squid.

-  For HTTPS caching, it does not use the original SSL/TLS certificate from the website. Proxy clients will only see certificates that are dynamically created by Squid.

   - This requires setting up the CA of Squid on all proxy clients.

Configuration
~~~~~~~~~~~~~

The Squid configuration file is ``/etc/squid/squid.conf``. The configuration settings below are listed in order of when they should be defined from first to last. Size types can be defined as ``bytes``, ``KB``, or ``MB``.

-  ``acl localnet src <CIDR>`` = Networks that are allowed to use this Squid proxy.
-  ``acl SSL_ports port 443`` = Allow proxying with HTTPS. This also requires ``acl Safe_ports port 443`` to be set.
-  ``acl Safe_ports port <TCP_PORT>`` = The ports/services that will be proxied. Valid values are:

   -  ``21`` = FTP.
   -  ``70`` - Gopher.
   -  ``80`` = HTTP.
   -  ``210`` = WAIS.
   -  ``443`` = HTTPS.
   -  ``488`` = GSS-HTTP.
   -  ``591`` = FMP.
   -  ``777`` = Multiling-HTTP.
   -  ``1025-65535`` = Proxy any service on this range of unregistered ports.

-  ``acl CONNECT method CONNECT`` = This has to be defined after the ``acl Safe_ports port <TCP_PORT>`` rules. It allows connections to all of the ports defined by ``acl Safe_ports`` rules.
-  ``http_access [allow|deny] <HOST>`` = Define what hosts and ports are allowed to access this Squid proxy.

   -  Default:

      ::

         http_access deny !Safe_ports
         http_access deny CONNECT !SSL_ports
         http_access allow localhost manager
         http_access deny manager
         http_access allow localnet
         http_access allow localhost
         http_access deny all

-  ``http_port <TCP_PORT> <OPTIONS>`` = The Squid proxy port to listen on. Other configuration options such as SSL/TLS certificates can be set here.

   -  Default:

      ::

         http_port 3128

-  ``cache_mem <SIZE> <SIZE_TYPE>`` = The total size of RAM cache for files.
-  ``cache_dir ufs <DIRECTORY> <SIZE_IN_MB> <FIRST_LEVEL_DIRECTORY_COUNT> <SECOND_LEVEL_DIRECTORY_COUNT>`` = The directory, size, and count of directories to use for caching content when the RAM cache becomes full. The most important values to tweak are the directory path and cache size.

   -  Default:

      ::

         cache_dir ufs /var/spool/squid 100 16 256

-  ``minimum_object_size <SIZE> <SIZE_TYPE>`` = The minimum file size to cache in RAM or in a directory.
-  ``maximum_object_size <SIZE> <SIZE_TYPE>`` = The maximum file size to cache in RAM or in a directory.
-  ``minimum_object_size_in_memory <SIZE> <SIZE_TYPE>`` = The minimum file size to cache in RAM.
-  ``maximum_object_size_in_memory <SIZE> <SIZE_TYPE>`` = The maximum file size to cache in RAM.
-  ``refresh_pattern [-i] <REGULAR_EXPRESSION> <MINIMUM_CACHE_TIME_IN_MINUTES> <PERCENTAGE_OF_CACHE_TIME> <MAXIMUM_CACHE_TIME_IN_MINUTES <OPTIONS>`` = Regular expression patterns that determine what files will be cached. [15] Use ``-i`` to ignore character casing.

   -  Default:

      ::

         refresh_pattern ^ftp:           1440    20%     10080
         refresh_pattern ^gopher:        1440    0%      1440
         refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
         refresh_pattern .               0       20%     4320

   -  Examples:

      -  ``refresh_pattern -i \.(bmp|eps|gif|ico|jpg|jpeg|jpegxl|jxl|png|tif|tiff|webp)$ 1440 90% 40320 override-expire ignore-no-cache ignore-no-store ignore-private`` = Cache all images for a minimum of 1 day and a maximum of 30 days. This also ignores cache headers received from the HTTP server and enforces new caching times.
      -  ``refresh_pattern -i \.(3gp|aac|au|avi|flac|flv|iso|m4a|mp3|mdi|mov|mp4|mpeg|ogg|qt|ram|swf|wav|wma|wmv|x-flv)$ 1440 90% 40320 override-expire ignore-no-cache ignore-no-store ignore-private`` = Cache all audio/video files.
      -  ``refresh_pattern -i \.(7z|7zip|arc|bcm|bin|br|brotli|bz2|bzip2|cpio|gz|gzip|pea|rar|raw|tar|tgz|wim|zip|xz|zst|zstd)$ 1440 90% 40320 override-expire ignore-no-cache ignore-no-store ignore-private`` = Cache all archives.
      -  ``refresh_pattern -i \.(cab|deb|dll|exe|msi|pkg|rpm|so|sys)$ 1440 90% 40320 override-expire ignore-no-cache ignore-no-store ignore-private`` = Cache executable, installer, and system files.
      -  ``refresh_pattern -i \.(doc|docx|fodg|fodp|fods|fodt|md|odf|odg|odp|ods|odt|pdf|ppt|pptx|rtf|txt|text|xls|xlsx)$ 1440 90% 40320 override-expire ignore-no-cache ignore-no-store ignore-private`` = Cache all documents.
      -  ``refresh_pattern -i \.(css|js|jsp|htm|html|rss|xml|yaml|yml)$ 1440 90% 40320 override-expire ignore-no-cache ignore-no-store ignore-private`` = Cache website files.
      -  ``refresh_pattern -i youtube.com/.* 1440 90% 40320`` = Cache all content on YouTube.
      -  ``refresh_pattern (/cgi-bin/|\?) 0 0% 0`` = Do not cache dynamic websites that use CGI to prevent issues with them.
      -  ``refresh_pattern . 1440 90% 40320`` = Cache everything. Squid cannot cache all types of content but it will cache what it can.

[16]

OpenSSL
-------

OpenSSL is a free and open source library for managing secure socket
layer (SSL) and Transport Layer Security (TLS) encryption. [12]

PEM files can either be a single certificate or a full encapsulation of
all related certificates and keys. This is useful for distributing an
SSL by using only one file.

A minimal PEM file can contain just a certificate. If using a
self-signed SSL, both the certificate and then the key can be included.
For SSLs issued from a Certificate Authority (CA), the full syntax
should be used to include all of the necessary content. It includes the
domain's certificate (MY CERTIFICATE), the certificates from the CA
bundle (INTERMEDIATE CERTIFICATE and ROOT CERTIFICATE), and then then
domain's certificate key (RSA PRIVATE KEY).

Minimal Syntax:

.. code-block:: sh

    -----BEGIN MY CERTIFICATE-----
    -----END MY CERTIFICATE-----

Full Self-signed Syntax:

.. code-block:: sh

    -----BEGIN MY CERTIFICATE-----
    -----END MY CERTIFICATE-----
    -----BEGIN RSA PRIVATE KEY-----
    -----END RSA PRIVATE KEY-----

Full Verified Syntax:

.. code-block:: sh

    -----BEGIN MY CERTIFICATE-----
    -----END MY CERTIFICATE-----
    -----BEGIN INTERMEDIATE CERTIFICATE-----
    -----END INTERMEDIATE CERTIFICATE-----
    -----BEGIN INTERMEDIATE CERTIFICATE-----
    -----END INTERMEDIATE CERTIFICATE-----
    -----BEGIN ROOT CERTIFICATE-----
    -----END ROOT CERTIFICATE-----
    -----BEGIN RSA PRIVATE KEY-----
    -----END RSA PRIVATE KEY-----

[13]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/http/http_servers.rst>`__
-  `< 2020.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/http_servers.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/http_servers.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/http_servers.md>`__

Bibliography
------------

1. "The Number One HTTP Server On The Internet." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/
2. "Configure the /etc/httpd/conf/httpd.conf file." Securing and Optimizing Linux. 2000. Accessed October 1, 2016. http://www.tldp.org/LDP/solrhe/Securing-Optimizing-Linux-RH-Edition-v1.3/chap29sec245.html
3. "Set up Apache virtual hosts on Ubuntu." Rackspace Network Support. July 8, 2016. Accessed October 1, 2016. https://support.rackspace.com/how-to/set-up-apache-virtual-hosts-on-ubuntu/
4. "Access Control." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/docs/2.4/howto/access.html
5. "Options Directive." Apache HTTP Server Project. Accessed October 1, 2016. http://httpd.apache.org/docs/2.4/mod/core.html#options
6. "Authentication and Authorization." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/docs/2.4/howto/auth.html
7. "Apache Tutorial: Dynamic Content with CGI." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/docs/2.4/howto/cgi.html
8. "HowTos SELinux." CentOS Wiki. February 26, 2017. Accessed May 7, 2017. https://wiki.centos.org/HowTos/SELinux
9. "NGINX Beginner’s Guide." NGINX Documentation. April 18, 2017. Accessed May 7, 2017. https://nginx.org/en/docs/beginners\_guide.html
10. "`NGINX <#nginx>`__ Core functionality." NGINX Documentation. April 18, 2017. Accessed May 7, 2017. https://nginx.org/en/docs/ngx\_core\_module.html
11. "`NGINX <#nginx>`__ Module ngx\_http\_core\_module." NGINX Documentation. April 18, 2017. Accessed May 7, 2017. https://nginx.org/en/docs/http/ngx\_http\_core\_module.html
12. "Welcome to OpenSSL!" Accessed November 27, 2016. https://www.openssl.org/
13. "HAProxy Comodo SSL." Stack Overflow. August 31, 2013. Accessed November 27, 2016. http://stackoverflow.com/questions/18537855/haproxy-comodo-ssl
14. "40 Squid Caching Proxy Server." SUSE Documentation. Accessed August 16, 2022. https://documentation.suse.com/sles/15-SP1/html/SLES-all/cha-squid.html
15. "How to cache all data with squid (Facebook, videos, downloads and .exe) on QNAP." Super User. July 4, 2019. Accessed August 17, 2022. https://superuser.com/questions/728995/how-to-cache-all-data-with-squid-facebook-videos-downloads-and-exe-on-qnap
16. "Chapter 3. Configuring the Squid caching proxy server." Red Hat Customer Portal. Accessed August 17, 2022. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/deploying_web_servers_and_reverse_proxies/configuring-the-squid-caching-proxy-server_deploying-web-servers-and-reverse-proxies
