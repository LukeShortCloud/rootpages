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

A technical design document (TDD) verbosely explains exactly how a program will work (in present tense) and why the program is needed. All functions and APIs are explained including the expected input and output.

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

Each function/method in a program should have a test written for it. Whenever any part of a program's code is modified, all of these unit tests should be ran to confirm that they continue to work as intended.

Continuous Integration and Continuous Deployment
------------------------------------------------

CI/CD pipelines provide an automated workflow for deploying software updates. When updates to source code through a SCM are processed, unit tests are ran, and if they successed then the updated code gets published to the production environment. Applications such as Jenkins and GitLab provide CI/CD functionality.


`Errata <https://github.com/ekultails/rootpages/commits/master/src/devops.rst>`__
----------------------------------------------------------------------------------

Bibliography
------------

1. "Configuration Cheat Sheet." Gitea Documentaiton. Accessed July 10, 2018. https://docs.gitea.io/en-us/config-cheat-sheet/
