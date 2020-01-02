OpenStack Developer
===================

.. contents:: Table of Contents

New Contributor
---------------

These are the steps required to sign up as a new OpenStack developer:

-  Sign up for an `Ubuntu One account <https://login.ubuntu.com/>`__.
-  Log into the `OpenDev Gerrit portal <https://review.opendev.org/>`__.
-  Agree to the `Individual Contributor License Agreement <https://review.opendev.org/#/settings/agreements>`__ (ICLA).
-  Add a `public SSH key to Gerrit <https://review.opendev.org/#/settings/ssh-keys>`__.

[1]

IRC
---

IRC is one of the few ways that OpenStack developers communicate with each other. The connection details to the Freenode service used by OpenStack are listed below.

-  Username: ``<LAUNCHPAD_USERNAME>``
-  Host: irc.freenode.net
-  SSL: Yes
-  Port: 6697

Once logged in for the first time, connect to an OpenStack channel such as ``#openstack`` to register an IRC account. [2]

::

   /msg nickserv register <NEW_IRC_PASSWORD> <EMAIL>

Useful links:

-  `IRC Channels <https://wiki.openstack.org/wiki/IRC>`__. Most channels are named ``#openstack-<PROJECT>``.
-  `IRC Logs <http://eavesdrop.openstack.org/irclogs/>`__
-  `Scheduled project meeting times and channels. <http://eavesdrop.openstack.org/>`__

Git
---

Gerrit
~~~~~~

-  Install the ``git-review`` via a system package or ``pip``.
-  Clone an `OpenStack repository from OpenDev <https://opendev.org/openstack>`__ with ``git clone https://opendev.org/openstack/<PROJECT>``.
-  Add the registered Gerrit username with ``git config --global gitreview.username <GERRIT_USER>``
-  Use ``git review -s`` to configure Gerrit for the repository and to ensure the local workstation can connect to it.
-  All reviews are posted on `review.opendev.org <https://review.opendev.org>`__.
-  Re-run all CI tests if there is a failure by posting a comment on the review with the word ``recheck`` in it.

   -  For the RDO/TripleO community, RDO specific CI jobs can be re-ran by commenting with ``check-rdo``.

-  For a patch to merge, it needs at least ``+2`` from Code-Reviews, a Verified label from CI, and a ``+1`` to Workflow from a core contributor.
-  Once a patch is merged into master, consider backporting it to previous stable branches with ``git cherry-pick -x``.

   -  It is preferred to backport sequentially from one release to the next (instead of directly from master) to help avoid merge conflicts.

Gerrit patches can be downloaded and applied to a localy environment. Find the patch to download by going to: ``Download`` > ``Patch-File`` > Copy and use the link to the base64 file.

.. code-block:: sh

   $ cd /usr/lib/python3.6/site-packages
   $ sudo patch -p1 < <(base64 --decode <(curl -s "https://review.opendev.org/changes/<GERRIT_NUMBER>/revisions/<COMMIT_HASH>/patch?download"))

Git messages
~~~~~~~~~~~~

When submitting a patch, the git commit message (from ``git commit -m``) can contain any of these valid tags:

-  DNM = Do not merge. This is normally used to manually run CI jobs.
-  WIP = Work-in-progress. This patch is not complete and possibly not working yet. It is not ready for reviews yet.
-  [Queens-only]
-  Closes-Bug: ``#<BUG_NUMBER>``
-  Resolves: ``rhbz#<BUG_NUMBER>``

   -  List a Red Hat Bugzilla that the patch resolves.

-  Partial-Bug:
-  Related-Bug:
-  Task:
-  Story:
-  Implements: blueprint ``<BLUEPRINT_NAME>``
-  Co-Authored-By: ``<FULL_NAME>`` ``<E_MAIL>``
-  Change-Id: ``<CHANGE_ID>``
-  Depends-On: ``<CHANGE_ID>``
-  Conflicts:

   -  Specify the path to each file that had a merge conflict that was manually resolved.

   ::

      Conflicts:
          path/to/conflicting/file.py
          path/to/conflicting/file2.py

Bugs
----

https://bugs.launchpad.net/openstack

Resources
---------

Paste:
https://docs.openstack.org/infra/system-config/paste.html
http://paste.openstack.org/

Etherpad:
https://etherpad.openstack.org/
https://docs.openstack.org/infra/system-config/etherpad.html

Story Board (project planning):
https://storyboard.openstack.org/

OpenStack Git repositories
https://opendev.org/openstack

Blueprints and Specs
--------------------

Blueprints = General outline (recommended to start with before a spec)
Specs = Technical overview of how to implement it (required).

Licenses
--------

Apache Software License v2.0 (ASL v2.0).

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/openstack/developer.rst>`__

Bibliography
------------

1. "Developer’s Guide." infra-manual (OpenStack Documentation). August 2, 2019. Accessed December 4, 2019. https://docs.openstack.org/infra/manual/developers.html
2. "Setup IRC." OpenStack Documentation Contributor Guide. December 19, 2019. Accessed January 2, 2020. https://docs.openstack.org/contributors/common/irc.html
