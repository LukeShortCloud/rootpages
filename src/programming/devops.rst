DevOps
======

.. contents:: Table of Contents

Methodologies
-------------

Agile
~~~~~

SCRUM

-  Sprints = A duration of time to complete a set of tasks (normally organized via a Kanban board). After this period of time, the team meets to talk about what worked, did not work, and any challenges or blockers encountered.
-  Kanban board = A board of tasks organized into three categories: "to do", "in progress", and "completed." Tasks in the "in progress" category have to be actively worked on. A major goal should be sorted into many small tasks that need to be accomplished to reach it.

Technical Design Document
--------------------------

A technical design document (TDD) verbosely explains exactly how a program will work (in the present tense) and why the program is needed and precisely how it will be created. This also helps to define unit tests. The TDD should describe:

-  The purpose of the program.
-  Use cases. Examples of how the program will be consumed by end-users.
-  Technologies. The software and hardware technologies that the program will be using. These include the programming language, libraries, and the environment it will run on.
-  Functions and APIs. The expected inputs and outputs.
-  If applicable, the user interface (UI). How it should look and the expected inputs and outputs.
-  Milestones. The expected functionality and state of a specific version of the program and how long it should take to develop. Eventually the time estimates should be updated to reflect how much time it did take for development. These milestones could be alpha, beta, and stable milestones.
-  Revisions. The revision history for the TDD. The document should only be updated after a milestone is reached or, if necessary, after a sprint. All changes to the document should be noted.

[2]

Integrated Development Environments
-----------------------------------

Integrated development environments are text editors that assist wit h programming. These usually provide syntax highlighting, styling recommendatins, function recommendations/auto-complete, and shortcuts to quickly build and test applications.

Common IDEs:

-  All

   -  `Atom <https://ide.atom.io/>`__
   -  `Geany <https://www.geany.org/>`__
   -  `Visual Studio IDE <https://visualstudio.microsoft.com/>`__

-  Java

   -  `Eclipse <https://www.eclipse.org/getting_started/>`__

-  Python

   -  `PyCharm <https://www.jetbrains.com/pycharm/>`__

Source Control Management
-------------------------

Source control management helps to version control source code files and assist with team developments of new features and bug fixes.

Common SCMs:

-  Git
-  Mercury (hg)
-  Subversion (svn)


Git
~~~

Developers can use these resources to learn how to properly use git: https://try.github.io/

GitHub
^^^^^^

GitHub was the first public git service and it is where the official code for the ``git`` program itself is stored and managed. GitHub Enterprise is a paid and supported solution for running private GitHub servers. https://github.com/

Patches can accessed by going to:

``https://github.com/<USER>/<PROJECT>/commit/<COMMIT_SHA>.patch``

Raw non-binary text files can be accessed by going to:

``https://raw.githubusercontent.com/<USER>/<PROJECT>/<COMMIT_SHA>/<PATH_TO_FILE>``

View commits from a specific author:

``https://github.com/openstack/openstack-ansible/commits?author=<USER>``

GitPrep
^^^^^^^

GitPrep is an open source portable git server written in Perl.

`Installation Guide <https://github.com/yuki-kimoto/gitprep/blob/master/README.md>`__

Gitea
^^^^^

Gitea is an open source community supported fork of the Gogs git server written in Go. It supports a variety of different database and cache back-ends. [1]

Databases:

-  MSSQL
-  MySQL
-  PostgreSQL
-  SQLite3

Caches:

-  Memcache
-  Memory
-  Redis

`Installation Guide <https://docs.gitea.io/en-us/install-from-binary/>`__

Object Oriented Programming
---------------------------

OOPs allow for a modular approach to programming. A ``class`` is designed to be a template. Multiple ``objects`` can be created from a single class when the objects will have similar attributes such as variables and methods (functions).

Common OOP Languages:

-  C++
-  Java
-  PHP
-  Python

Unit Testing
------------

Every function or method in a program needs a related test. Each unit test should be written at the same time as the function itself is. Whenever any part of a program's code is modified, all of these unit tests should be ran to confirm that each part of the program continues to work as intended.

Continuous Integration and Continuous Deployment
------------------------------------------------

CI/CD pipelines provide an automated workflow for deploying software updates. When updates to source code through a SCM are processed, unit tests are ran, and if they successed then the updated code gets published to the production environment. Applications such as Jenkins and GitLab provide CI/CD functionality.

CI
~~

Travis CI
^^^^^^^^^

Travis CI is a free continous integration service for open source git projects.

Travis supports Ubuntu and macOS virtual machine environments for testing code. Other operatings system can be used via defining how to setup and use docker containers. [3]

The ``.travis.yml`` file in the root directory of a git project defines the environment to test on, how to set it up, and how to run tests. All of the configuration options can be found `here <https://docs.travis-ci.com/user/customizing-the-build/>`__. Example configurations for different languages can be found `here <https://docs.travis-ci.com/user/language-specific/>`__.

Specify the language environment to use.

.. code-block:: yaml

   language: <PROGRAM_LANGUAGE>
   <PROGRAM>_LANGUAGE>:
     - "<VERSION1>"
     - "<VERSION2>"

Python example:

.. code-block:: yaml

   language: python
   python:
     - "2.7"
     - "3.6"
     - "3.7-dev"

Install dependencies before running tests.

.. code-block:: yaml

   sudo: required
   dist: <UBUNTU_DISTRO>
   before_install:
     - sudo apt-get update
     - sudo apt-get install -y <PACKAGE1> <PACKAGE2>

Describe how to install the application. Python example:

.. code-block:: yaml

   install:
     - pip install -r requirements.txt
     - pip install .

If the program does not need to be installed, this step can be skipped.

.. code-block:: yaml

   install: true

Define the test script to run. Example:

.. code-block:: yaml

   script:
     - ./tests.py

By default, commits on any branch (except gh-pages) will be tested. This can be configured to only track specific branches or exclude specific branches.

.. code-block:: yaml

   branches:
     only:
     - <BRANCH1>
     - <BRANCH2>

.. code-block:: yaml

   branches:
     except:
     - <BRANCH1>
     - <BRANCH2>

The order that tasks are executed in from a Travis CI file:

-  apt addons
-  cache components
-  **before_install**
-  **install**
-  **before_script**
-  **script**
-  before_cache
-  **after_success**, **after_failure**
-  before_deploy
-  deploy
-  after_deploy
-  **after_script**

[4]

`Errata <https://github.com/ekultails/rootpages/commits/master/src/programming/devops.rst>`__
---------------------------------------------------------------------------------------------

Bibliography
------------

1. "Configuration Cheat Sheet." Gitea Documentaiton. Accessed July 10, 2018. https://docs.gitea.io/en-us/config-cheat-sheet/
2. "Why Writing Software Design Documents Matters." Toptal. Accessed September 3, 2018. https://www.toptal.com/freelance/why-design-documents-matter
3. "Build Environment Overview." Travis CI Docs. Accessed September 11, 2018. https://docs.travis-ci.com/user/reference/overview/
4. "Customizing the Build." Travis CI Docs. Accessed September 11, 2018. https://docs.travis-ci.com/user/customizing-the-build/
