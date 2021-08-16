OpenStack Contributor
=====================

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

Gerrit patches can be downloaded and applied to a local environment. Find the patch to download by going to: ``Download`` > ``Patch-File`` > Copy and use the link to the base64 file.

.. code-block:: sh

   $ cd /usr/lib/python3.6/site-packages
   $ sudo patch -p1 < <(base64 --decode <(curl -s "https://review.opendev.org/changes/<GERRIT_NUMBER>/revisions/<COMMIT_HASH>/patch?download"))

Git Messages
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

Release Notes
~~~~~~~~~~~~~

Any major change to an OpenStack project requires a release note. The categories which can be specified in a release note are:

-  critical
-  deprecations
-  features
-  fixes
-  issues
-  other
-  prelude
-  security
-  upgrade

Install the required `reno <https://pypi.org/project/reno/>`__ Python library.

.. code-block:: sh

   $ pip install --user reno

Create a new release note using a prefix. The prefix should be either the subject of the change or the Launchpad bug number in the format of ``bug-<LAUNCHPAD_BUG_NUMBER>``.

.. code-block:: sh

   $ reno new <PREFIX>
   Created new notes file in releasenotes/notes/<PREFIX>-<UUID>.yaml

Edit the release note with contents about the major change.

.. code-block:: sh

   $ vim releasenotes/notes/<PREFIX>-<UUID>.yaml

[6]

Bugs
----

The bug tracker system used is Canonical's Launchpad. Generic OpenStack issues can be reported to ``https://bugs.launchpad.net/openstack``. Project specific issues can be found at ``https://bugs.launchpad.net/<OPENSTACK_PROJECT>``.

Each bug has specific attributes:

-  Affects = The OpenStack project that is affected.
-  Status = The current status of the bug.

   -  Confirmed
   -  Fix Committed
   -  Fix Released
   -  In Progress
   -  Incomplete
   -  Invalid
   -  New
   -  Opinion
   -  Triaged
   -  Won't Fix

-  Importance = The importance/priority of the bug.

   -  Critical
   -  High
   -  Medium
   -  Low
   -  Wishlist

-  Assigned to = The owner of the bug.
-  Milestone = The next development release that this is targeted to be fixed in.

[3]

Resources
---------

These are various services that are helpful for collaboration and sharing.

-  `Story Board <https://storyboard.openstack.org/>`__ = Project planning.
-  `Paste <http://paste.openstack.org/>`__ = Paste large code blocks. `Back-end documentation <https://docs.openstack.org/infra/system-config/paste.html>`__.
-  `Etherpad <https://etherpad.openstack.org/>`__ = Collaborative online document. `Back-end documentation <https://docs.openstack.org/infra/system-config/etherpad.html>`__.
-  `OpenDev Git Repositories <https://opendev.org/openstack>`__ = All of the OpenStack services source code.

Specification and Blueprint
---------------------------

A specification (spec) and blueprint are required for any new large feature or code refactoring. The specification is a detailed document explaining the work that needs to be done and the impact it will have on the project. [4] Some considerations are impacts to the API, security, notifications, end user, performance, etc. A full example of a spec can be found `here <https://specs.openstack.org/openstack/nova-specs/specs/train/implemented/train-template.html>`__. Blueprints are created as a more generalized version of a specification. The progress of the new feature is tracked by mentioning the blueprint in related git commit messages.

Licenses
--------

OpenStack is a collection of various different projects that use software licenses that are approved by the Open Source Initiative (OSI). It is recommended that new projects use the Apache Software License v2.0 (ASL v2.0). For supporting the Contributor License Agreement (CLA), a license such as ASL v2.0, BSD, or MIT must be used. [5]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/main/src/openstack/developer.rst>`__

Bibliography
------------

1. "Developer’s Guide." infra-manual (OpenStack Documentation). August 2, 2019. Accessed December 4, 2019. https://docs.openstack.org/infra/manual/developers.html
2. "Setup IRC." OpenStack Documentation Contributor Guide. December 19, 2019. Accessed January 2, 2020. https://docs.openstack.org/contributors/common/irc.html
3. "Bugs." OpenStack Documentation Project Team Guide. June 28, 2018. Accessed January 2, 2020. https://docs.openstack.org/project-team-guide/bugs.html
4. "Blueprints and specifications." OpenStack Documentation Contributor Guide. January 2, 2020. Accessed January 2, 2020. https://docs.openstack.org/doc-contrib-guide/blueprints-and-specs.html
5. "Licensing requirements." OpenStack Governance. July 18, 2017. Accessed January 2, 2020. https://governance.openstack.org/tc/reference/licensing.html
6. "Working with Release Notes." keystone OpenStack Documentation. May 31, 2019. Accessed May 29, 2020. https://docs.openstack.org/keystone/train/contributor/release-notes.html
