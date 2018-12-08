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

A technical design document verbosely explains exactly how a program will work (in the present tense) and why the program is needed and precisely how it will be created. This also helps to define unit tests. The document should describe:

-  The purpose of the program.
-  Use cases. Examples of how the program will be consumed by end-users.
-  Technologies. The software and hardware technologies that the program will be using. These include the programming language, libraries, and the environment it will run on.
-  Functions and APIs. The expected inputs and outputs.
-  If applicable, the user interface (UI). How it should look and the expected inputs and outputs.
-  Milestones. The expected functionality and state of a specific version of the program and how long it should take to develop. Eventually the time estimates should be updated to reflect how much time it did take for development. These milestones could be alpha, beta, and stable milestones.
-  Revisions. The revision history for the document. It should only be updated after a milestone is reached or, if necessary, after a sprint. All changes to the document should be noted.

[2]

Integrated Development Environments
-----------------------------------

Integrated development environments are text editors that assist with programming. These usually provide syntax highlighting, styling recommendatins, function recommendations/auto-complete, and shortcuts to quickly build and test applications.

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

Git Services
~~~~~~~~~~~~

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

Git Workflow
~~~~~~~~~~~~

The "master" or "devel" branch is normally the primary and latest development branch. New features should be developed in a different branch. Once the feature is complete, it can be merged into the primary branch. It is recommended to create a pull/merge request (PR) with the Git service dashboard. This way other team members can review the changes before they are merged. All code should also be tested via a continuous integration (CI) pipeline and optionally deployed using continuous deployment (CD).

Users that only have read access to a git repository can fork it. This creates a copy of the repository for a user for development purposes. Feature branches can be worked on in the fork before being submitted to be merged into the original repository. [5]

Common git procedures:

-  Create a new local git project.

    .. code-block:: sh

       $ git init

-  Download an existing git project from GitHub.

    .. code-block:: sh

       $ git clone https://github.com/<USER>/<PROJECT>.git

-  View existing tags and branches.

    .. code-block:: sh

       $ git fetch --all
       $ git tag
       $ git branch -a

-  Switch to an existing branch, tag, or commit.

    .. code-block:: sh

       $ git checkout <BRANCH_TAG_OR_COMMIT>

-  Create a new branch and switch to it.

    .. code-block:: sh

       $ git checkout -b <NEW_BRANCH>

-  Save changes to a branch locally and push them to the remote origin server.

    .. code-block:: sh

       $ git add <FILE1> <FILE2> <FILE3>
       $ git commit -m "<DESCRIPTION_MESSAGE_OF_CHANGES>"
       $ git push origin <BRANCH>

-  View the git history.

    .. code-block:: sh

       $ git log

-  Merge a branch.

    .. code-block:: sh

       $ git checkout master
       $ git merge <FEATURE_BRANCH>
       $ git push origin master

-  Tag version releases.

    .. code-block:: sh

       $ git tag 0.9.1
       $ git push origin 0.9.1

-  Tags generally should not be deleted. However, if a tag was created by mistake or needs to be cleaned up for any other reason it can be removed from the local and remote git repository.

    .. code-block:: sh

       $ git tag --delete <TAG>
       $ git push --delete origin <TAG>

-  After a feature branch has been merged in, it can be deleted.

    .. code-block:: sh

       $ git branch --delete <BRANCH>
       $ git push origin --delete <BRANCH>

-  When managing a fork, the "upstream" branch should be configured to track changes from the original repository. This can now be referenced instead of "origin".

    .. code-block:: sh

       $ git remote add upstream https://github.com/<USER>/<PROJECT>.git
       $ git remote -v
       $ git fetch upstream
       $ git branch -a
       $ git checkout upstream/<UPSTREAM_BRANCH>

-  Delete all uncommitted local changes.

    .. code-block:: sh

       $ git reset --hard

[6]

Versioning
----------

A software version scheme helps end-users and developers identify what release they are using. This is helpful for looking up documentation and understanding the current features and potential bugs in each release. Versions normally consist of a major, minor, patch/micro, and optionally a modifier to signify an alpha, beta, or rc (release candidiate).

Semantic (SemVer)
~~~~~~~~~~~~~~~~~

-  Syntax: ``<MAJOR>.<MINOR>.<PATCH>``, ``X.Y.Z``
-  Example: ``1.21.0``

SemVer sections:

-  Major = Only changes when huge backwards compatibility breaking changes are introduced.
-  Minor = New features are added.
-  Patch = Bug and/or security update.

After some development time, a new software version is released and the major, minor, and/or patch are updated to align with what kind of updates were added. The positions of the version are sometimes referred to as ``X.Y.Z``. [9]

Calendar Versioning (CalVer)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Syntax: ``YYYY.0M.0D``, ``YYYY-0M-0D``, ``YYYY.<RELEASE>``, etc.
-  Example: ``2018.11.29``

Large projects or projects with rolling releases can signify the date of release by using CalVer. Normally this is the ISO date of actual published release date. It can be expressed in many different ways with the most common showing the year, month, and day. [10]

GitVersion
~~~~~~~~~~

-  Syntax: ``<MAJOR>.<MINOR>.<PATCH>+<NUMBER_OF_COMMITS_SINCE_LAST_RELEASE>``
-  Example: ``4.21.9+11``

This is aimed towards use with automated build systems. Developers can keep track of how many commits there are since the last release while also providing a more stream-lined way for end-users to test development builds and accurately report back their version/build. [11]

Unofficial
~~~~~~~~~~

These are unofficial versioning schemes that do not have a popular and/or published standard.

-  ``<MAJOR>.<MINOR>.<COMMIT_HASH>``
-  ``<MAJOR>.<MINOR>.<NUMBER_OF_COMMITS>.r<COMMIT_HASH>``
-  ``YYMM0M.<COMMIT_HASH>``
-  ``<COMMIT_HASH>``

Object Oriented Programming
---------------------------

OOPs allow for a modular approach to programming. A ``class`` is designed to be a template. Multiple ``objects`` can be created from a single class when the objects will have similar attributes such as variables and methods (functions).

Common OOP Languages:

-  C++
-  Java
-  PHP
-  Python

Testing
-------

All code should have ``unit`` and ``integration`` tests. Unit tests will run a test against each individual method to ensure they are all working as intended by returning the correct results. Integration tests will run multiple methods to ensure most, if not all, use-cases of a program continue to work. If any of the tests fail, then either a bug was introduced by new code or the tests need to be updated.

Continuous Integration and Continuous Deployment
------------------------------------------------

CI/CD pipelines provide an automated workflow for deploying software updates. When updates to source code through a SCM are processed, tests are ran, and if they successed then the updated code gets published to the production environment. Applications such as Jenkins and GitLab provide CI/CD functionality.

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

CD
~~

Fedora Copr
^^^^^^^^^^^

Fedora Copr is a build system that builds RPMs for RPM based operating systems such as Fedora, Mageia, and openSUSE. Only the latest RPMs are kept. Older versions are deleted after 14 days. The ``copr-cli`` utility can be used to help add continuous delievery to a CI/CD pipeline. [7]

Generate an API token from `here <https://copr.fedoraproject.org/api/>`__. Use the credentials provided to create a new configuration at ``~/.config/copr``. For CD, this file should be encrypted with a tool such as ``travis encrpt-file`` and stored in the SCM repository.

.. code-block:: ini

   [copr-cli]
   username = <USER>
   login = <COPR_PROVIDED_LOGIN>
   token = <COPR_PROVIDED_TOKEN>
   copr_url = https://copr.fedoraproject.org

Create a new Copr project.

.. code-block:: sh

   $ copr-cli create --chroot <OPERATING_SYSTEM_1> --chroot <OPERATING_SYSTEM_2> --chroot <OPERATING_SYSTEM_3> <NEW_PROJECT_NAME>

Upload a source RPM to be built. This should be part of the CD process.

.. code-block:: sh

   $ copr-cli build <PROJECT_NAME> <PATH_OR_URL_TO_SRPM>

Optionally enable the Copr repository using DNF.

.. code-block:: sh

   $ sudo dnf install dnf-plugins-core
   $ sudo dnf copr enable <COPR_USER>/<PROJECT_NAME>
   $ sudo dnf install <PROJECT_RPM>

[8]

Regular Expression
------------------

Regular expressions (regex) are a set of characters that can be used to search for patterns in a string. This is useful for finding if a certain string exists within a string and to do substitutions with. Most programming languages adopt the Perl specification of regex.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   ``\``, Escape character. Do not parse the next character as regex.
   ``.``, One wild card character that is not a newline.
   ``?``, Match the character before this zero or one time.
   ``+``, Match the character before this one or more times.
   ``^``, Beginning of a line.
   ``$``, The end of a line.
   ``()``, Put a group of characters inside paranthesis to create a group. Regex characters can then try to match against this group (instead of a single character).
   ``|``, Or (the character before or after this).
   ``[]``, One character specified in the brackets.
   ``[A-Z]`` or ``[0-9]``, Match any range of characters by specifying a start and stop letter or number.
   ``[a-zA-Z0-9]``, Any alphanumeric character.
   ``[^]``, Any character except the ones specified (the inverse).
   ``\s``, One whitespace (space or tab) character.
   ``\S``, One non-whitespace character.
   ``( )``, One space character.
   ``\d``, One digit.
   ``[0-9]``, One digit.
   ``\D``, One non-digit.
   ``[^0-9]``, One non-digit.
   ``\w``, One word (a collection of alphabetical characters)
   ``\W``, One non-word.
   ``[\n]``, One newline character.
   ``^$``, One blank line.

.. csv-table::
   :header: Example RegEx, Example Matches
   :widths: 20, 20

   ``h.``, "h1, ha, hb"
   ``abc.+``, "abcd, abc0, acdZ"
   ``[abcd]``, "a, b, c, d"
   ``[X-Z]``, "X, Y, Z"
   ``[2-5]``, "2, 3, 4, 5"
   ``(cats)*``, "cats, catscats, (or nothing is matched)"
   ``^(cat|dog)$``, "cat, dog"
   ``[^helo]``, """ world"" (from ""hello world"")"
   ``(bl|h|m)ouse``, "blouse, house, mouse"
   ``"([^]+)"``, "(Everything between the two quotes)"
   ``That's pretty( ugly)?``, "That's pretty, That's pretty ugly"

[12]

`History <https://github.com/ekultails/rootpages/commits/master/src/programming/devops.rst>`__
----------------------------------------------------------------------------------------------

Bibliography
------------

1. "Configuration Cheat Sheet." Gitea Documentaiton. Accessed July 10, 2018. https://docs.gitea.io/en-us/config-cheat-sheet/
2. "Why Writing Software Design Documents Matters." Toptal. Accessed September 3, 2018. https://www.toptal.com/freelance/why-design-documents-matter
3. "Build Environment Overview." Travis CI Docs. Accessed September 11, 2018. https://docs.travis-ci.com/user/reference/overview/
4. "Customizing the Build." Travis CI Docs. Accessed September 11, 2018. https://docs.travis-ci.com/user/customizing-the-build/
5. "Comparing Workflows. Atlassian Git Tutorial. Accessed October 15, 2018. https://www.atlassian.com/git/tutorials/comparing-workflows
6. "git - the simple guide." rogerdudler GitHub Pages. Accessed October 15, 2018. http://rogerdudler.github.io/git-guide/
7. "User Documentation." COPR documentation. Accessed October 19, 2018. https://docs.pagure.org/copr.copr/user_documentation.html
8. "Copr command line interface." Fedora Developer Portal. Accessed October 19, 2018. https://developer.fedoraproject.org/deployment/copr/copr-cli.html
9. "Semantic Versioning 2.0.0." Semantic Versioning. Accessed December 1, 2018. https://semver.org/
10. "Calendar Versioning." CalVer. Accessed December 2, 2018. https://calver.org/
11. "Version Incrementing." GitVersion Read the Docs. Accessed December 1, 2018. https://gitversion.readthedocs.io/en/latest/more-info/version-increments/
12. "perlre." Perl Programming Documentation. Accessed December 7, 2018. http://perldoc.perl.org/perlre.html
