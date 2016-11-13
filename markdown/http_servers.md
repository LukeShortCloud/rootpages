# HTTP Servers

* [Apache 2.4](#apache-2.4)
    * [Configuration](#apache---configuration)
    * [Virtual Hosts](#apache---virtual-hosts)
    * [Files, Directories, and Locations](#apache---files,-directories,-and-locations)
    * [Authentication](#apache---authentication)
    * [CGI](#apache---cgi)
    * [SELinux](#apache---selinux)
* Nginx
* Lighttpd


# Apache 2.4

The Apache HTTP Server Project is designed to provide a versatile open source HTTP and HTTPS web server. It has been one, and continues to be, one of peoples' favorite web servers. [1]

Source:

1. "The Number One HTTP Server On The Internet." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/


## Apache - Configuration

There is generally one primary Apache configuration file that then includes other possible configuration files.

RHEL/Fedora
```
/etc/http/conf/httpd.conf
```

Debian/Ubuntu
```
/etc/apache2/apache2.conf
```

Options:

* ServerRoot = Specify what directory Apache should use as a relative path.
    * Example: ServerRoot "/etc/httpd"
* Listen = What port (and optionally aaddress) Apache should listen on.
    * Example #1: Listen 127.0.0.1:80
    * Example #2: Listen 443
* User = The user that Apache should be run as.
    * Example: User apache
* Group = The group that Apache should be run with.
* ServerAdmin = Provide an e-mail address that will get e-mails when there are any errors.
* LogLevel = Specify how verbose logging should be.
    * error
    * warn
    * info
    * debug
* ErrorDocument = Provide a custom page for specific error numbers. This can either be text, a file, script, or redirect.
    * Example #1: ErrorDocument 500 "Contact your System Administrator for help. Thank you."
    * Examlpe #2: ErrorDocument 403 "/cgi-bin/you_didnt_say_the_magic_word.py"
* ErrorLog = The file to use for the error log.
* CustomLog = The file to use for logging Apache access information.
* IncludeOptional = Specify what directory (under ServerRoot) to load other configurations from.
    * Example: IncludeOptional conf.d/*.conf

[1]

Verify that the configuration is correct with one of these commands:
```
# apachectl configtest
```
```
# httpd -t
```

Source:

1. "Configure the /etc/httpd/conf/httpd.conf file." Securing and Optimizing Linux. 2000. Accessed October 1, 2016. http://www.tldp.org/LDP/solrhe/Securing-Optimizing-Linux-RH-Edition-v1.3/chap29sec245.html


## Apache - Virtual Hosts

A virtual host file is part of the configuration that is required for Apache to load a domain.

Syntax:
```
<VirtualHost *:80>
</VirtualHost>
```

Options:

* ServerName = The main domain name for the virtual host.
* ServerAlias = Other domains associated with the virtual host
* DocumentRoot = The directory where the domain loads its files from.
* DirectoryIndex = The main file that is loaded up in a directory, if found. Default: "index.html" or "index.htm."
* LogLevel, ErroLog, and CustomLog = Refer to the [Apache Configuration](#apache---configuration) section.

Example:
```
<VirtualHost 127.0.0.1:80>
  ServerName  rootpages.tld
  ServerAlias www.rootpages.tld
  DirectoryIndex index.html
  DocumentRoot /var/www/html/rootpages/
  LogLevel warn
  ErrorLog /var/log/httpd/rootpages_tld.error_log
  CustomLog /var/log/httpd/rootpages_tld.custom_log
</VirtualHost>
```

[1]

Source:

1. "Set up Apache virtual hosts on Ubuntu." Rackspace Network Support. July 8, 2016. Accessed October 1, 2016. https://support.rackspace.com/how-to/set-up-apache-virtual-hosts-on-ubuntu/


## Apache - Files, Directories, and Locations

Different settings can be used on items based on if a matched file, directory, or location is found. Regular expressions can be used to match different areas.

* File = Match a specific file name.
  * Syntax:
```
<File "/path/to/file.html">
</File>
```
* Directory = Match a specific directory name.
  * Syntax:
```
<Directory "/path/to/dir">
</Directory>
```
* Location = Match any location. This can be a directory, alias, or a redirect path.
  * Syntax:
```
<Location "/path/to/location">
</Location>
```

Options:

* Require = Set an access control list to allow certain hosts or IPs.
    * all = Apply the rule to all hosts.
    * host = Apply the rule to a specific host.
    * ip = Apply the rule to an IP address
        * granted = Allow the matched rule.
        * denied = Deny th ematched rule.
* Require not [all|host|ip] = Deny access to a host or IP. This should be configured after a Require rule. [1]
* Options = Specify attributes of the matched area. Enable an option with a "+" or disable it with "-". If no sign is present, Apache assumes it should be enabled. If at least one option requires a sign then all of the other options will need a sign.
    * All = Allow of the options.
    * ExecGI = Allow CGI scripts to be executed.
    * Includes = Allow HTML include functionality to include files server-side.
    * IncludesNOEXEC = The same as Includes but it does not allow HTML files to execute commands or scripts.
    * Indexes = Show the content of a directory if the DirectoryIndex is not found.
    * FollowSymLinks = Allow symlinks to different directories. [2]

A combination of a "Require all" or "Require not all" and then an explicit allow/deny list can only be used within a "RequireAll" block.
```
<Directory "/var/www/html">
    <RequireAll>
        Require all granted
        Require not ip 192.168.14.19
        Require not host server.hostname.tld
    </RequireAll>
</Directory>
```

Sources:

1. "Access Control." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/docs/2.4/howto/access.html
2. "Options Directive." Apache HTTP Server Project. Accessed October 1, 2016. http://httpd.apache.org/docs/2.4/mod/core.html#options


## Apache - Authentication

Locations can be secured by a username and password. Users can also be assigned to groups.

Create an Apache user.
```
# htpasswd -c /etc/httpd/conf.d/passwd <USER1>
```

Another user can be appended to this file by ommitting the "-c" create option.
```
# htpasswd /etc/httpd/conf.d/passwd <USER2>
```

A new file can be created to assign multiple users to a group.
```
# vim /etc/httpd/conf.d/group
<GROUP>: <USER1> <USER2>
```

Authentication can now be applied to any location. [1] The syntax is:

```
AuthType Basic
AuthName "Login Prompt Text"
AuthUserFile "/path/to/passwd/file"
AuthGroupFile "/path/to/group/file"
Require [user|group] <USER|GROUP>
```

Example #1:
```
<Directory "/var/www/html">
	AuthType Basic
    AuthName "Please Login"
    AuthUserFile "/etc/httpd/conf.d/joe_passwd"
    Require user joe
</Directory>
```

Example #2:
```
<File "/var/www/html/grades/spring_2016_grades.csv">
	AuthType Basic
    AuthName "Spring 2016 Class Login"
    AuthUserFile "/etc/httpd/conf.d/passwds"
    AuthGroupFile "/etc/httpd/conf.d/spring_2016"
    Require group spring_2016
</File>
```

Source:

1. "Authentication and Authorization." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/docs/2.4/howto/auth.html


## Apache - CGI

The common gateway interface (CGI) is a method of the web server executing a script and then sending the results to a web browser.

In the main configuration, the new CGI bin folder has to be aliased to /cgi-bin/. This way Apache knows that this should be a CGI folder.
```
ScriptAlias "/cgi-bin/" "/path/to/custom/cgi-bin/"
```

Then the directory can be configured. It needs to allow the execution of CGI, set everything in the folder to be executable via the cgi-script handler, and allow access to it.
```
<Directory "/path/to/custom/cgi-bin/">
    Options +ExecCGI
    SetHandler cgi-script
    Require all granted
</Directory>
```

All CGI scripts have to either be a binary or have a shebang that indicates the path to the binary that should execute the program. An example shebang is "#!/bin/bash." The program will also need to first print out "Content-type: text/html" so the web browser knows that it is a HTML page. An example is shown below.

```
#!/bin/bash
echo "Content-type: text/html"
echo "CGI Test Page"
```

All scripts should have readable and executable Unix permissions by the anonymous user ("other") access category.
```
# chmod -R o+rx /path/to/custom/cgi-bin/
```

[1]

Source:

1. "Apache Tutorial: Dynamic Content with CGI." Apache HTTP Server Project. Accessed October 1, 2016. https://httpd.apache.org/docs/2.4/howto/cgi.html


## Apache - SELinux

Red Hat Enterprise Linux and related distributions use SELinux as an extra layer of security. In this case, by having SELinux, this ensures that a compromised Apache cannot listen on non-standard ports or access directories outside of it's scope. There may be cases where an administrator needs to expand Apache's access so SELinux permissions will need to be modified.

Install the troubleshooting utilities:
```
# yum install setroubleshoot
```

View the current Apache ports allowed by SELinux:
```
# semanage port -l | grep ^http_port_t
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
```

Add a new allowed TCP port:
```
# semanage port -a -t http_port_t -p tcp <PORT_NUMBER>
```

Lookup the Apache SELinux file context permissions. It should be "httpd_sys_content_t."
```
# ls -lahZ /var/www/html/
drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 .
drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 ..
```

Permanetely fix SELinux permissions on a custom directory using the semanage tool and then apply the permissions by running restorecon:
```
# semanage fcontext -a -t httpd_sys_content_t "/path/to/custom/dir(/.*)?" 
# restorecon -Rv /path/to/custom/dir
```

Source:

1. https://wiki.centos.org/HowTos/SELinux