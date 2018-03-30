Mail Servers
============

.. contents:: Table of Contents

Mail transfer agents (MTAs) are servers that are used to receive local
e-mail and send outgoing e-mail.

Postfix
-------

Configuration options:

-  myhostname = The hostname of the mail server.

    -  Default: If a fully qualified domain name (FQDN) is configured on the Unix machine then Postfix will use that.

-  mynetworks = Define the networks that are allowed to send e-mails.

    -  Default: 127.0.0.0/8

-  mydestination = Define allowed destinations for e-mails.

    -  Default: ``$myhostname localhost.$mydomain localhost``

-  relayhost = Define the server to forward mail to. [1]

Null Client Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

In a null client configuration, mail is not accepted by the mail server.
It only forwards local e-mails to another MTA.

Example - Forward all e-mails from the localhost to the server at the
10.0.0.1 address.

.. code-block:: sh

    myhostname = server.rootpages.tld
    mydomain = rootpages.tld
    myorigin = $mydomain
    inet_interfaces = loopback-only
    mydestination =
    relayhost = 10.0.0.1

Gateway Configuration
~~~~~~~~~~~~~~~~~~~~~

In a gateway-client setup, mail is forwarded from the one or more
specified networks to another MTA.

Example - Forward all e-mails from localhost and from the 10.0.0.0/24
network to the 10.0.0.1 server.

.. code-block:: ini

    myhostname = server.example.com
    mydomain = example.com
    myorigin = $mydomain
    inet_interfaces = all
    mydestination = $myhostname localhost.$mydomain localhost $mydomain
    mynetworks = 10.0.0.0/24 127.0.0.0/8
    relayhost = 10.0.0.1

[2][3]

`Errata <https://github.com/ekultails/rootpages/commits/master/src/mail_servers.rst>`__
---------------------------------------------------------------------------------------

Bibliography
------------

1. "Postfix Basic Configuration." Postfix. Accessed October 1, 2016.
   http://www.postfix.org/BASIC\_CONFIGURATION\_README.html
2. "Postfix Standard Configuration." Postfix. Accessed October 1, 2016.
   http://www.postfix.org/STANDARD\_CONFIGURATION\_README.html
3. "Configure a system to forward all email to a central mail server."
   CertDepot. November 25, 2015. Accessed October 1, 2016.
   https://www.certdepot.net/rhel7-configure-system-forward-email-central-mail-server/
