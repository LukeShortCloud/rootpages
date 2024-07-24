DevOps
======

.. contents:: Table of Contents

Definition
----------

The term "DevOps" was first used by Andrew Clay Shafer in 2009. It expands out to stand for development and operations. He defines it as "optimizing human performance and experience operating software, with software, and with humans." [15] Developers should be empowered with the tools they need to easily manage and scale up their application and infrastructure. The barriers for approvals and between departments should be lowered or removed to promote open communication between all departments within the company. Ideas should be able to become a reality quickly so that, if something fails, it fails fast. Then the developers can move onto figuring out a different solution. Adopting DevOps usually results in higher up-front resource and learning costs but also results in lower technical debt and higher scalability in the long-run. Jez Humble, from Chef, also states that "DevOps is not a goal, it is a never-ending process of continual improvement." [16]

DevOps can be categorized into 5 topics known as the CALMS [17]:

-  Culture = Everyone must be open to change. A lot of changes to workflows and tools are required to get the benefits of DevOps. For example, moving applications to microservices and/or serverless containers to help with scale.
-  Automation = Automation helps save time and allow resources to scale up easier and faster. This frees up Engineers to work on other work objectives. For example, use Ansible for configuration management.
-  Lean = Being able to accomplish more with less resources due to efficiency. For example, by using CI/CD).
-  Measurement = Measure performance, usage, and other relevant information to help better define and shape the future of the application. For example, use an Elasticsearch, Logstash, and Kibana (ELK) stack to monitor applications.
-  Sharing = Communication is the most important and hardest part of DevOps. Team members must be open to sharing ideas and working together on common goals.

Books
-----

These are books in order of highest to lowest recommendation of reading:

-  The DevOps Handbook
-  The Phoenix Project
-  The Unicorn Project

Methodologies
-------------

Agile
~~~~~

SCRUM

-  Sprints = A duration of time to complete a set of tasks (normally organized via a Kanban board). After this period of time, the team meets to talk about what worked, did not work, and any challenges or blockers encountered.
-  Kanban board = A board of tasks organized into three categories: "to do", "in progress", and "completed." Tasks in the "in progress" category have to be actively worked on. A major goal should be sorted into many small tasks that need to be accomplished to reach it.

Technical Design Document
-------------------------

A technical design document verbosely explains exactly how a program will work (in the present tense) and why the program is needed and precisely how it will be created. This also helps to define unit tests. The document should describe:

-  Project members and their role.
-  The purpose of the program.
-  Use cases. Examples of how the program will be consumed by end-users.
-  Technologies. The software and hardware technologies that the program will be using. These include the programming language, libraries, and the environment it will run on.
-  Functions and APIs. The expected inputs and outputs.
-  Database structure and data types.
-  User interface (UI). How the program should look and the expected inputs and outputs.
-  Milestones. The expected functionality and state of a specific version of the program and how long it should take to develop. Eventually the time estimates should be updated to reflect how much time it did take for development. These milestones could be alpha, beta, and stable milestones.
-  Revisions. The revision history for the document. It should only be updated after a milestone is reached or, if necessary, after a sprint. All changes to the document should be noted.

[2]

Integrated Development Environments (IDEs)
------------------------------------------

Integrated development environments are text editors that assist with programming. These usually provide syntax highlighting, styling recommendations, function recommendations/auto-complete, and shortcuts to quickly build and test applications.

Common IDEs:

-  All

   -  `Atom <https://ide.atom.io/>`__
   -  `Geany <https://www.geany.org/>`__
   -  `Visual Studio IDE <https://visualstudio.microsoft.com/>`__

-  Java

   -  `Eclipse <https://www.eclipse.org/getting_started/>`__

-  Python

   -  `PyCharm <https://www.jetbrains.com/pycharm/>`__

Visual Studio Code
~~~~~~~~~~~~~~~~~~

Terminal
^^^^^^^^

Visual Studio Code provides a built-in terminal to that opens a full shell for accessing CLI utilities. Open it by going to:

View > Terminal

[35]

Forks
^^^^^

code-server
'''''''''''

Minimum requirements:

-  2 CPU cores
-  1 GB RAM

code-server is a service developed by Coder that hosts a remote session of Microsoft Visual Studio Code. This allows developers to install their dependencies for their application development in a remote environment and are able to access it from anywhere.

Installation
&&&&&&&&&&&&

-  Package Manager

   -  Set a version to download from code-server's `GitHub release page <https://github.com/cdr/code-server/releases>`__.

      .. code-block:: sh

         $ export CODE_SERVER_VER="3.12.0"

   -  Fedora and EL:

      .. code-block:: sh

         $ curl -LO https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VER}/code-server-${CODE_SERVER_VER}-amd64.rpm

   -  Debian and Ubuntu:

      .. code-block:: sh

         $ curl -LO https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VER}/code-server_${CODE_SERVER_VER}_amd64.deb

-  Container

   -  The official code-server container is based on `Debian <https://github.com/coder/code-server/blob/main/ci/release-image/Dockerfile>`__.

      .. code-block:: sh

         $ {docker,podman} run --network host -it -p 127.0.0.1:8080:8080 -v "$PWD:/home/coder/project" -u "$(id -u):$(id -g)"codercom/code-server:latest

-  Ansible

   -  The `testcab/ansible-role-code-server <https://github.com/testcab/ansible-role-code-server>`__ project provides the most complete and up-to-date Ansible role for installing and configuring code-server.

[20]

Configuration
&&&&&&&&&&&&&

All of the configuration is handled via the ``coder-server`` binary.

Server process arguments:

-  --auth {password,none} = The password authentication to use for the web dashboard.
-  --bind-addr <IP>:<PORT> = Default: ``127.0.0.1:8080``. The address and port to bind to.
-  --cert = Default is ``false`` which will generate a self-signed certificate. The TLS certificate to use.
-  --cert-key = The TLS certificate key to use.
-  --config = The configuration file to use.
-  --open = Open the web browser when the server is started.
-  --password = Password for the web dashboard.
-  --proxy-domain = The domain to proxy ports through.
-  --socket = Create and use a UNIX socket instead of a network address and port.
-  --verbose
-  --version

Visual Studio Code arguments:

-  --disable-telemetry = Prevent metrics and usage from being sent to Microsoft.
-  --extensions-dir = The directory of where extensions will be installed to.
-  --force = Automatically accept all prompts for extension installations.
-  --install-extension <ID> = Install a new extension.
-  --list-extensions = List all of the installation extensions.
-  --show-versions = Show the extension versions.
-  --uninstall-extension <ID> = Uninstall an extension.
-  --user-data-dir = The directory that should store the user configuration settings for VS Code.

The default location for the configuration file at ``~/.config/code-server/config.yaml``. YAML key-value pairs can be provided for any of the ``code-server --help`` arguments. An example configuration file is provided below.

.. code-block:: yaml

   ---
   bind-addr: 127.0.0.1:8080
   auth: password
   password: 1746aeeb3c463b9aaa925fce
   cert: false

By default, code-server only listens to 127.0.0.1 (localhost) on port 8080. This can be changed to listen on all IP addresses on the system.

.. code-block:: sh

   $ code-server --bind-addr 0.0.0.0:8080

A password can be configured a few different ways.

.. code-block:: sh

   $ export PASSWORD='<PASSWORD>'

.. code-block:: sh

   $ code-server --password='<PASSWORD>'

[20]

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

Introduction
''''''''''''

GitHub was the first public git service and it is where the official code for the ``git`` program itself is stored and managed. GitHub Enterprise is a paid and supported solution for running private GitHub servers. https://github.com/

Patches can accessed by going to:

``https://github.com/<USER>/<PROJECT>/commit/<COMMIT_SHA>.patch``

Raw non-binary text files can be accessed by going to:

``https://raw.githubusercontent.com/<USER>/<PROJECT>/<COMMIT_SHA>/<PATH_TO_FILE>``

View commits from a specific author:

``https://github.com/openstack/openstack-ansible/commits?author=<USER>``

View SSH public keys for a specific user:

``https://github.com/<USER>.keys``

Issues Template
'''''''''''''''

GitHub allows creating one or more templates to use for GitHub Issues [49]:

-  Settings > Features > Issues > Set up templates

This will be saved to ``.github/ISSUE_TEMPLATE/<ISSUE_TEMPLATE_NAME_SNAKE_CASE>.md``.

Ask for information that will be helpful for troubleshooting bugs or investigating the addition of new features:

-  Short summary.
-  Exact error messasges.
-  Steps to replicate the issue.
-  Expected results.
-  Versions used.

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

-  Download an existing git project from GitHub using HTTP or SSH.

    .. code-block:: sh

       $ git clone https://github.com/<USER>/<PROJECT>.git

    .. code-block:: sh

       $ git clone git@github.com:<USER>/<PROJECT>.git

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

-  When managing a fork, the "upstream" repository should be configured to track changes from the original repository. Continue to use "origin" for the forked repository.

    .. code-block:: sh

       $ git remote add upstream https://github.com/<USER>/<PROJECT>.git
       $ git remote -v
       $ git fetch upstream
       $ git branch -a
       $ git checkout upstream/<UPSTREAM_BRANCH>

-  Delete all uncommitted local changes.

    .. code-block:: sh

       $ git reset --hard
       $ git clean -dfx

-  Update the patch for the current commit.

    .. code-block:: sh

       $ git add .
       $ git commit --amend --no-edit

[6]

-  Sync the ``master`` branch of a fork with the original upstream repository.

    .. code-block:: sh

       $ git fetch upstream
       $ git checkout origin/master
       $ git rebase upstream/master
       $ git push origin master

[14]

-  Find what tags a commit is in.

   .. code-block:: sh

      $  git tag --contains <COMMIT_HASH>

Messages
^^^^^^^^

Guidelines for ``git commit -m`` messages [19]:

-  Subject

   -  Use imperative statements that start with "Add", "Change", "Fix", Remove", etc.
   -  Do not end with a period because it is a title.
   -  Should be a maximum length of 50 characters.

-  Body

   -  Create a newline between the subject and the body.
   -  Each line should wrap around at 72 characters.

Common statements used in the body:

-  Resolves ``#<GITHUB_ISSUE>``
-  Authored-By: <FIRST_NAME> <LAST_NAME> <``<EMAIL>``> = Enclose the e-mail in ``< >``.
-  Co-Authored-By = The same as Authored-By, except they are not the originally creator of the patch.
-  Changed-Id: <RANDOM_UUID> = Used by Gerrit. A unique Change ID number associates the patch to a review. The review can then go through more than one revision of the patch based off of CI and user provided feedback.
-  Depends-On: <GERRIT_UUID> = Used by Gerrit. A patch that is required to merge first.
-  DNM = Do not merge. Normally this commit is to test something in CI.
-  RFC = Request for comments from other contributors.
-  WIP = Work in progress. The patch will continue to get further updates before it should be merged.

Conflicts
^^^^^^^^^^

When doing a ``git`` ``cherry-pick``, ``merge``, or ``rebase`` it is possible that there will be a merge conflict between a commit in the current branch and another commit that is being added in. The developer will have to go in and manually update the code. An example is shown below. In between the ``<<<<<<<`` and ``=======`` section is the code from the original branch. In between the ``=======`` and ``>>>>>>>`` is the code from the commit that is being added that is causing the conflict.

::

   <<<<<<< HEAD
   Hello world
   =======
   Hey world
   >>>>>>> c14d3657... commit message here

After resolving the conflict, add the commit back by doing a continue or a new commit.

.. code-block:: sh

   $ git add .
   $ git {cherry-pick|merge|rebase} --continue

[13]

Changing the Default Branch Name
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In some cases it may be desired to change the default branch name that is shown when visiting a git repository via a GUI or via the CLI when cloning it. In 2020, GitHub changed the default branch name "master" to "main" on all newly created projects. This was to promote more inclusion by avoiding historically racist terminology. [33]

-  Rename the "master" branch to "main".

   .. code-block:: sh

      $ git branch --move master main

-  Push the new "main" branch to the git server and set the upstream to follow changes that may now happen on the git server side.

   .. code-block:: sh

      $ git push --set-upstream origin main

-  Change the "HEAD" symbolic reference to point to "main" instead of "master".

   .. code-block:: sh

      $ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
      $ git branch --all | grep HEAD
      remotes/origin/HEAD -> origin/main

-  Go to the git server and change the default branch.

   -  GitHub: Settings > Branches > Switch to another branch > (select "main" from the drop-down menu) > Update > I understand, update the default branch.

-  Confirm everything is setup as intended. Then delete the "master" branch.

   .. code-block:: sh

      $ git push --delete origin master

[34]

Bare Repository
^^^^^^^^^^^^^^^

A bare clone of a repository only contains the git files and patches themselves. These files are what a normal ``git --clone`` command would place in a ``.git`` directory.

.. code-block:: sh

   $ git clone --bare <GIT_REPOSITORY_URL>.git
   $ ls -1
   <GIT_REPOSITORY_URL>.git

A mirror clone is similar except it keeps information about the original "origin" remote. [36]

.. code-block:: sh

   $ git clone --mirror <GIT_REPOSITORY_URL>.git
   $ ls -1
   <GIT_REPOSITORY_URL>.git

A bare clone can be converted back into a usable git repository. [37]

-  Recreate the ".git" directory.

   .. code-block:: sh

      $ mkdir .git
      $ mv branches ./.git/
      $ mv config ./.git/
      $ mv description ./.git/
      $ mv HEAD ./.git/
      $ mv hooks ./.git/
      $ mv info ./.git/
      $ mv objects ./.git/
      $ mv packed-refs ./.git/
      $ mv refs ./.git/

-  Configure git to no longer treat this as a bare clone.

   .. code-block:: sh

      $ git config --local --bool core.bare false

-  Reset the repository to restore usual files.

   .. code-block:: sh

      $ git reset --hard

Migrate a Git Repository
^^^^^^^^^^^^^^^^^^^^^^^^

Here is how to completely migrate all commits, branches, and tags from one git repository to a different one.

-  Download the repository and fetch all of the metadata about its branches and tags.

   .. code-block:: sh

      $ git clone <GIT_REPOSITORY_URL>
      $ cd <GIT_REPOSITORY>
      $ git fetch origin

-  Find all of the remote branches and then recreate all of them locally.

   .. code-block:: sh

      $ git branch --all
      $ git checkout --branch <ORIGIN_BRANCH> origin/<ORIGIN_BRANCH>

-  Configure the remote for the new repository.

   .. code-block:: sh

      $ git remote add origin2 git@github.com:<GIT_USER>/<GIT_REPOSITORY>.git

-  Push all branches and tags to the new remote.

   .. code-block:: sh

      $ git push --all origin2
      $ git push --tags origin2

-  View and delete the old remotes.

   .. code-block:: sh

      $ git remote --verbose
      $ git remote rm origin

-  Rename the new remote to be the default "origin" remote.

   .. code-block:: sh

      $ git remote rename origin2 origin

[38]

Download a Git Repository Archive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Instead of using ``git clone``, it may be desired to download an archive of just the source code without the git revision history. [47]

-  Branch = ``https://github.com/<GITHUB_USER_NAME>/<GITHUB_PROJECT>/archive/refs/heads/<BRANCH>.tar.gz``
-  Commit Hash = ``https://github.com/<GITHUB_USER_NAME>/<GITHUB_PROJECT>/archive/<COMMIT_HASH>.tar.gz``
-  Tag = ``https://github.com/<GITHUB_USER_NAME>/<GITHUB_PROJECT>/archive/refs/tags/<TAG>.tar.gz``

Versioning
----------

A software version scheme helps end-users and developers identify what release they are using. This is helpful for looking up documentation and understanding the current features and potential bugs in each release. Versions normally consist of a major, minor, patch/micro, and optionally a modifier to signify an alpha, beta, or rc (release candidate).

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

-  Syntax: ``YYYY.0M.0D``, ``YYYY-0M-0D``, ``YYYY.<RELEASE>``, ``YYYYMMDD.<COMMIT>``, etc.
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

Twelve-Factor App Methodology
-----------------------------

The twelve-factor methodology defines a set of standards to create cloud-native applications. These are microservices that can easily scale on cloud platforms.

Principles:

1. Codebase = All code is stored in a source control management (SCM) repository. There is only one application per SCM repository.
2. Dependencies = All dependencies and versions are clearly defined.
3. Config = Configuration are handled by a file or environment variables. Settings are not be hard-coded into the application.
4. Backing services = External applications that need to access this application should not rely on the source code. This application is treated as a service. For example, it could instead communicate via a RESTful HTTP endpoint.
5. Build, release, run = There are three distinct phases:

   -  Build = From the SCM repository, build the application.
   -  Release = Release the application packaged with its dependencies, documentation, and configurations.
   -  Run = Run the application after being configured.

6. Process = Do not store information in the application itself. Using a database backend for persistent storage. This allows the application to be stateless.
7. Port binding = The application binds itself to a network port and controls all incoming and outgoing data. There is no external web server, such as Apache, handling the requests.
8. Concurrency = Scalability is not bound to the hardware. It scales vertically on the cloud by handling requests spread out across many instances of the same application.
9. Disposability = The application can start and shutdown both quickly and gracefully.
10. Dev/prod parity = The development, staging, and production environments that the application runs in must be identical. Variations can lead to issues missed during testing.
11. Logs = Do not log to a file. Logs are sent to stdout/stderr to eventually be streamed to a dedicated logging service. This helps parse the information at scale.
12. Admin process = Separate code for administrative tasks from the application itself. This new related code scan reside in the same SCM as the application itself.

[21]

RESTful APIs
------------

Principles
~~~~~~~~~~

REpresentational State Transfer (REST) is a programming design on how to abstract client and server interactions. A program that implements the REST API design is considered to be a RESTful API. The most common protocol used for RESTful APIs is HTTP but the design principles are not limited to HTTP. An application that follows the REST principles will have improved "performance, scalability, simplicity, modifiability, visibility, portability and reliability." [25]

Keywords [27]:

-  Resource = An API object that exposes one or more methods.
-  Resource identifier = The name used to access the resource via an API.
-  Resource representation = The text (typically in a JSON format) with detailed information about what the resource should do.
-  Hypermedia = A response that provides detailed information about the resource method. [28]
-  MIME = Multi-Purpose Internet Mail Extensions. A standard of headers for transferring different types of data. [29]

    -  MIME-Version = The version of MIME to use.

        -  Content-Type = A HTTP header that specifies what the format of the resource representation.
        -  Content-Disposition = Specify if an attachment will be shown automatically (inline) or shown as a separate attachment (attachment).
        -  Content-Transfer-Encoding = The encoding for the data.

-  Headers = The metadata of a message that describe details of how it should be processed.
-  Request = A request from the client for information from the server.
-  Response = The response from the server replying back to a client request.
-  Content/media type or Multipurpose Internet Mail Extensions (MIME) = The type of content in the the request or response.
-  Hypertext = A HTTP link.
-  Session = Data stored about a specific client user which allows them to make unique requests.
-  Uniform Resource Identifier (URI) = The URI specifies what data to pull from a URL and/or a URN. [30]
-  Uniform Resource Locator (URL) = The URL is the connection type (typically HTTP) and path to the content to access. Example: ``http://foo.bar/example.html``.
-  Uniform Resource Name (URN) = The URN is the URL without the connection type and includes the resource. Example: ``foo.bar/example.html#blog``.
-  Query string = A query in an HTTP URI. The query is denoted by a ``?`` symbol. It provides an easy means of providing key-values to the API.
-  API version = The version of the API to use. This is commonly set via the use of a Header with ``API-Version`` specified.


Principles:

-  **Client-server** = The client and server components are completely separate programs.
-  **Stateless** = The client handles the session state and the database stores the application state. The API by itself does not have any knowledge of any states. The API also does not need to care about other requests, each request is handled independently/separately.
-  **Cacheable** = All requests sent back from the server need to be marked as cacheable or non-cacheable. Clients can re-use cacheable content as to lower the load on the server.
-  **Uniform interface** = Rules for how the client and server interact. [25]

   -  **Resource-based** = The resource the client interacts with is determined by the URI.
   -  **Modifications of resources through representations** = The client can retrieve enough information from the server to be able to modify existing data.
   -  **Self-descriptive message** = Everything required for the API to process the request is provided via a message from the client.
   -  **Hypermedia as the engine of application state** = The client and server separately ask for and send the state via different means.

      -  **Client** = Body contents, query-string parameters, requests headers, and/or the requested URI.
      -  **Server** = Body, response codes, and/or response headers.

-  **Microservices (or layered systems)** = Each component is isolated. The client cannot directly communicate with the database. It has to communicate with the API to retrieve and modify data.
-  **Versioning** = Determine how and why the API version would change. When making a breaking change, allow the original API version to be accessed and used (via a header or URI) for backwards compatibility. [25]
-  **Code on demand (optional)** = The server can provide executable code to the client to provide more feature temporarily.

REST API interactions normally have three different components:

::

   Client <---> API Server <---> Database

[24]

Common text-based document Content-Type headers for MIME [26]:

-  ``application/json``
-  ``application/msword``
-  ``application/sql``
-  ``application/vnd.openxmlformats-officedocument.wordprocessingml.document``
-  ``application/xml``
-  ``text/css``
-  ``text/html``
-  ``text/javascript``
-  ``text/plain``

HTTP Verbs
~~~~~~~~~~

These are the valid HTTP verbs that can be used when interacting with a HTTP web server. [22] The most common ones used in regards to RESTful APIs are DELETE, GET, PATCH, POST, and PUT. [23]

Read-only operations:

-  CONNECT = Connect to a tunnel or proxy server. Commonly used for HTTPS (SSL/TLS) connections.
-  GET = Retrieve data from the server.
-  HEAD = Only retrieve the header information (not the full data) from the server.
-  OPTIONS = Retrieve the support HTTP verbs from the server.
-  TRACE = View all of the additional request data that was sent and processed by the server.

Write operations:

-  DELETE = Delete data from the server.
-  PATCH = Partially modify existing data on the server.
-  POST = Append new data to the server. This is not idempotent as new data is always stored.
-  PUT = Replace existing data, or add new data if it does not exist, with this data. This is idempotent as the same data will not result in any change.

Big O Notation
--------------

The Big O Notation is used to explain the complexity and time required for a function to return in programming. The letter `O` represents the "order". The letter `N` presents the number of input values for the function. Programmers should try to refactor their code to achieve a scale of `O(1)` which is a constant time and can scale efficiently no matter how much input data is provided.

-  O(1) = The function will always take the same amount of time to return.
-  O(N) = Time to completion scales linearly based on the input given.
-  O(N^2) = Nested loops can cause exponential scaling issues.
-  O(2N) = Based on the amount of input given, it will take twice as long to return.

[18]

In some situations, modern programming languages provide `generators` that can help achieve O(1) by `yield` ing a return value as soon as one is available.

Testing
-------

All code should have ``unit`` and ``integration`` tests. Unit tests will run a test against each individual method to ensure they are all working as intended by returning the correct results. Integration tests will run multiple methods to ensure most, if not all, use-cases of a program continue to work. If any of the tests fail, then either a bug was introduced by new code or the tests need to be updated.

Continuous Integration and Continuous Deployment
------------------------------------------------

CI/CD pipelines provide an automated workflow for deploying software updates. When updates to source code through a SCM are processed, tests are ran, and if they successed then the updated code gets published to the production environment. Applications such as Jenkins and GitLab provide CI/CD functionality.

CI
~~

GitHub Actions
^^^^^^^^^^^^^^

GitHub Actions is a CI/CD platform hosted by GitHub. It runs all workflows defined in ``.github/workflows/*.yaml`` files in a git repository. The primary workflow file is normally named ``.github/workflows/main.yaml``. A workflow file can define one or more jobs. The workflow runs when at least one event is matched.

Workflow file syntax:

.. code-block:: yaml

   ---
   name: <WORKFLOW_NAME>
   on:
     <EVENT_1>:
     <EVENT_2>:
   jobs:
     <JOB_1>:
     <JOB_2>:

Common events:

-  on (map)

   -  create = When a branch or tag is created.
   -  page_build = When code is pushed to the GitHub Pages "gh-pages" branch.
   -  pull (map)

      -  branches (list of strings) = A list of branches to run on.
      -  branches-ignore (list of strings) = A list of branches to not run on.

   -  pull_request (map)

      -  types (list of strings) = The event taken on the pull request (PR).

         -  assigned
         -  edited
         -  labeled
         -  opened
         -  ready_for_review

   -  push (map) = When code is pushed to a branch or tag. Wildcards ``**`` and negative ``!`` expressions can be used.

      -  branches (list of strings)
      -  branchs-ignore (list of strings)
      -  tags (list of strings)
      -  tags-ignore (list of strings)

   -  release
   -  schedule (list)

      -  cron (string) = A crontab string to use for the schedule.

   -  workflow_call (map) = Set as an empty map to allow this workflow to be called from other workflows.
   -  workflow_dispatch (map) [51][52] = Allow a workflow to be run manually using the GitHub Actions webpage or the ``gh`` CLI.

      -  inputs (map) = A list of inputs that can be provided to the workflow before it is ran.

         -  ``<INPUT_NAME>`` (map) = Configuration of what is expected for the input.

            -  default (string) = The default value for the variable.
            -  description (string) = An optional description.
            -  options (list of strings) = Values to provide in a drop-down list. Only one can be selected by the user. Available when ``on.workflow_dispatch.inputs.<INPUT_NAME>.type`` is set to ``choice``.
            -  required (boolean) = If this variable is required to be set.
            -  type (string) = ``boolean``, ``choice``, ``enviornment``, or ``string``.

   -  workflow_run (map) = Workflows to monitor. Using ``on.workflow_run`` only works on the default branch. [42] For testing, it is possible to temporarily change the default branch in the GitHub settings of the repository. Instead of using this, it is recommended to use ``jobs.<JOB>.uses`` to run workflows from another file. [43]

      -  workflows (list of strings) = The workflow ``name`` to use.
      -  types (list of strings) = The status of the workflow.

         -  completed = Wait for the workflow to be completed.

[31]

Common job attributes:

-  jobs (map)

   -  ``<JOB_NAME>`` (map) = Provide a name for the job.

      -  container (map) = Specify a container to run the CI job in.

         -  defaults (map) = Default settings.
         -  env (map) = Shell environment variables.

            -  ``<KEY>`` (string) = ``<VALUE>``

         -  image (string)
         -  options (string)
         -  ports (list of integers)
         -  volumes (list of strings)

      -  if (boolean) = Only run this job if this condition is true.

         -  ${{ always() && !cancelled() && needs.<JOB>.result == 'success' }} = Only run if the specified job was not cancelled and it succeeds. [44]

      -  needs (list of strings) = List other jobs that must be completed before this job starts. By default, without this, all jobs run in parallel at the same time.
      -  **runs-on** (string)

         -  macos-[11|12|13|latest]
         -  self-hosted = A custom CI environment can be setup and used.
         -  ubuntu-[20.04|22.04|latest]
         -  windows-[2019|2022|latest]

      -  services (map) = Specify one or more containers to run. Refer to ``jobs.<JOB_NAME>.container`` for the usage.
      -  steps (list of maps)

          -  env (string)
          -  name (string) = Describe what the step is doing.
          -  run (string) = The command(s) to run.
          -  uses (string) = An action to use from another file, branch, container, or git repository.
          -  working-directory (string) = The working directory to use for this step.

      -  uses (string) = The full path to another GitHub workflow to run: ``<GIT_USER_NAME>/<GIT_PROJECT_NAME>/.github/workflows/build.yml@<BRANCH_TAG_OR_COMMIT_HASH>``. This requires the specified workflow to have ``on.workflow_call`` set.

[32]

----

**Examples:**

A job running in a container:

.. code-block:: yaml

   jobs:
     container-example:
       runs-on: ubuntu-20.04
       container:
         image: busybox:latest

A job running in a virtual machine:

.. code-block:: yaml

   jobs:
     virtual-machine-example:
       runs-on: ubuntu-20.04

A job that runs on specified branches.

.. code-block:: yaml

   ---
   name: Run only on the main branch
   on:
     push:
       branches:
         - main

A job that runs on all branches except for specificed branches. [50]

.. code-block:: yaml

   ---
   name: Run on all branches except foobar
   on:
     push:
       branches-ignore:
         - foobar

.. code-block:: yaml

   ---
   name: Run on all branches except foobar
   on:
     push:
       branches:
         - '**'
         - !foobar

A job step that uses a different directory. By default, the directory is reset on every step. [45][46]

.. code-block:: yaml

   ---
   name: Change directory with cd
   jobs:
     change_directory:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - name: Change directory and run command
           run: |
             cd ${GITHUB_WORKSPACE}
             git log

.. code-block:: yaml

   ---
   name: Change directory with working-directory
   jobs:
     change_directory:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - name: Change directory and run command
           working-directory: ${{ env.GITHUB_WORKSPACE }}
           run: git log

.. code-block:: yaml

   ---
   name: Change directory with a custom working-directory set as default
   jobs:
     change_directory:
       runs-on: ubuntu-latest
       defaults:
         run:
           working-directory: ${{ env.GITHUB_WORKSPACE }}
       steps:
         - uses: actions/checkout@v3
         - name: Run command
           run: git log

A job that runs a workflow from another workflow file. It is recommended to use ``jobs.<JOB>.uses`` instead of ``on.workflow_run.workflows`` since (1) this does not require the GitHub Actions workflow to be in the default branch, (2) it is easier, and (3) it allows other ``on`` parameters to work. [42][43]

.. code-block:: yaml

   ---
   # File: .github/workflows/build.yml
   name: Build
   on:
     push:
       branches:
         - '*'
     workflow_call:
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - name: Build
           run: echo Building

.. code-block:: yaml

   ---
   # File: .github/workflows/upload.yml
   name: Upload
   on:
     push:
       branches:
         - '*'
   jobs:
     build:
       uses: <GIT_USER_NAME>/<GIT_PROJECT_NAME>/.github/workflows/build.yml@<BRANCH_TAG_OR_COMMIT_HASH>
     upload:
       runs-on: ubuntu-latest
       steps:
         - name: Upload
           run: echo Uploading

A job that runs only if another job succeeds. [44]

.. code-block:: yaml

   ---
   name: Run two jobs
   on:
     push:
       branches:
         - '*'
   jobs:
     first_job:
       runs-on: ubuntu-latest
       steps:
         - name: Trigger a failure
           run: false
     second_job:
       runs-on: ubuntu-latest
       needs:
         - first_job
       if: ${{ always() && !cancelled() && needs.first_job.result == 'success' }}
       steps:
         - name: Trigger a success
           run: true


A job that only runs if a specific folder (or sub-folder) was modified.

.. code-block:: yaml

   ---
   name: Run only if files are modified in the foobar folder or its sub-folders
   on:
     push:
       paths:
         - 'foobar/**'

A job that can be manually triggered. Using the GitHub repository website, navigate to: Actions > (select the workflow on the left) > Run workflow > Run workflow. [53]

.. code-block:: yaml

   ---
   on:
     workflow_dispatch:

Travis CI
^^^^^^^^^

Travis CI is a free continuous integration service for open source git projects.

Travis supports Ubuntu and macOS virtual machine environments for testing code. Other operating systems can be used via defining how to setup and use docker containers. [3]

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

Fedora Copr is a build system that builds RPMs for RPM based operating systems such as Fedora, Mageia, and openSUSE. Only the latest RPMs are kept. Older versions are deleted after 14 days. The ``copr-cli`` utility can be used to help add continuous delivery to a CI/CD pipeline. [7]

Generate an API token from `here <https://copr.fedoraproject.org/api/>`__. Use the credentials provided to create a new configuration at ``~/.config/copr``. For CD, this file should be encrypted with a tool such as ``travis encrypt-file`` and stored in the SCM repository.

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

Development Environments
------------------------

An application's life-cycle should go through various stages of testing. At a minimum, it is recommended to have 3 different environments. More environments can be added based on the testing requirements of the application. Ideally everything should be automated and promoted via a CI/CD pipeline.

-  Development (Dev) or Sandbox = Developers have little to no restrictions on the environment and can test new features and bug fixes quickly. It should loosely resemble production.
-  Pre-production (Pre-prod), Quality Assurance (QA), or Staging = Updates from Development are applied to an environment that mirrors production as much as possible but is not public facing.
-  Production (Prod) or Live = If the update works correctly in pre-production then it is promoted to production as-is. If it does not work, then the update needs to be re-worked in the Development environment again.

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
   ``()``, Put a group of characters inside parentheses to create a group. Regex characters can then try to match against this group (instead of a single character).
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

Choosing a Programming Language
-------------------------------

Use Case
~~~~~~~~

This is an extremely biased list of the best programming language for each use case.

-  Artificial intelligence (AI) and machine learning (ML) = 1. Python 2. R 3. Java
-  Easiest to learn = 1. Python 2. Ruby
-  Firmware = 1. C
-  Portability = 1. Go 2. Java 3. C#
-  Speed [40]

   -  Fastest = 1. C 2. C++ 3. Rust 4. Go 5. Java
   -  Slowest = 1. Lua 2. Ruby 3. Python 4. Perl 5. PHP

-  Web development

   -  Back-end = 1. Go 2. PHP 3. Java
   -  Front-end = 1. HTML 2. JavaScript

Popularity
~~~~~~~~~~

These are the top most active programming languages on GitHub in the year 2022 [41]:

1.  Python
2.  Java
3.  JavaScript
4.  C++
5.  Go
6.  TypeScript
7.  PHP
8.  Ruby
9.  C
10.  C#

Energy Efficiency
~~~~~~~~~~~~~~~~~

Here is the descending order of programming languages based on their energy efficiency [39]:

1.  C
2.  Rust
3.  C++
4.  Ada
5.  Pascal
6.  Erland
7.  Go
8.  Lisp
9.  Haskell
10.  Chapel
11.  Fortran
12.  Java
13.  C#
14.  Swift
15.  F#
16.  Dart
17.  OCaml
18.  Racket
19.  TypeScript
20.  JavaScript
21.  Python
22.  PHP
23.  Hack
24. Ruby
25.  Perl
26.  Lua
27.  JRuby

Learning a New Programming Language
-----------------------------------

These are the most important concepts to learn when studying a new language, listed in ascending order.

-  Data types
-  Console/tty input and output
-  Creating a basic ``main()`` function
-  Compiling and running code
-  Code comments
-  Function definitions
-  Relational, arithmetic, assignment, unary, and bitwise operators
-  Loops and conditionals
-  Find and use a standardized code styling along with best practices for the language
-  Figure out common design patterns for the language
-  Exception/error handling
-  Testing via fake and real unit and functional tests
-  Common libraries:

   -  Logging
   -  CLI argument parsing
   -  File input and output
   -  Math
   -  HTTP URL request handling

-  Multi-threading
-  Object-oriented usage (if applicable)
-  Packaging (if applicable)

   -  Most programming languages support a package manager for dependencies such as dep (Go), mvn/Maven (Java), npm (Node.js), pip/PyPI (Python), etc.

-  Graphical user interface (GUI) framework

After learning the basics, `Exercism <https://exercism.org/>`__ provides hands-on tutorials with human feedback.

Troubleshooting
---------------

Errors
~~~~~~

Error ``fatal: early EOF`` when downloading a large git repository:

::

    $ git clone https://src.fedoraproject.org/rpms/kernel.git
    Cloning into 'kernel'...
    remote: Enumerating objects: 96449, done.
    remote: Counting objects: 100% (11902/11902), done.
    remote: Compressing objects: 100% (4260/4260), done.
    fetch-pack: unexpected disconnect while reading sideband packet
    fatal: early EOF
    fatal: fetch-pack: invalid index-pack output
    Could not execute clone: Failed to execute command.

Solutions [48]:

-  The Internet connection is not stable. Try using an Ethernet connection or using a different Internet connection.
-  The default git buffer size is 1 MiB. Configure it to be 100 MiB instead.

   .. code-block:: sh

      $ git config --global http.postBuffer 104857600

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/devops.rst>`__
-  `< 2018.07.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/devops.rst>`__

Bibliography
------------

1. "Configuration Cheat Sheet." Gitea Documentation. Accessed July 10, 2018. https://docs.gitea.io/en-us/config-cheat-sheet/
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
13. "Resolving a merge conflict using the command line." GitHub Help. Accessed March 1, 2019. https://help.github.com/en/articles/resolving-a-merge-conflict-using-the-command-line
14. "Syncing a fork." GitHub Help. Accessed March 19, 2019. https://help.github.com/en/articles/syncing-a-fork
15. "the end of the beginning - devopsdays Denver 2017." SlideShare. April 10, 2017. Accessed June 10, 2019. https://www.slideshare.net/littleidea/the-end-of-the-beginning-devopsdays-denver-2017
16. "10 Deep DevOps Thoughts From Chef’s Jez Humble." New Relic Blog. April 28, 2015. Accessed June 10, 2019. https://blog.newrelic.com/technology/devops-jez-humble/
17. "Using CALMS to Assess an Organization’s DevOps." DevOps.com. May 25, 2018. Accessed June 10, 2019. https://devops.com/using-calms-to-assess-organizations-devops/
18. "A beginner's guide to Big O notation." Rob-Bell.net. June 23, 2009. Accessed July 9, 2019. https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/
19. "How to Write a Git Commit Message." Chris Beams. August 31, 2014. Accessed May 26, 2020. https://chris.beams.io/posts/git-commit/
20. "cdr/code-server." GitHub. August 10, 2020. Accessed August 10, 2020. https://github.com/cdr/code-server
21. "The Twelve-Factor App." 12factor.net. 2017. Accessed October 21, 2020. https://12factor.net/
22. "HTTP request methods." MDN web docs. Accessed November 6, 2020 https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
23. "Using HTTP Methods for RESTful Services." REST API Tutorial. Accessed November 6, 2020. https://www.restapitutorial.com/lessons/httpmethods.html
24. "What is REST." REST API Tutorial. Accessed November 6, 2020. https://restfulapi.net/
25. "RESTful API Basic Guidelines." RestCase. September 6, 2016. Accessed November 6, 2020. https://blog.restcase.com/restful-api-basic-guidelines/
26. "Common MIME types." MDN Web Docs. September 15, 2020. Accessed December 29, 2020. https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
27. "Resources." Thoughts on RESTful API Design. 2011. Accessed December 29, 2020. https://restful-api-design.readthedocs.io/en/latest/resources.html
28. "What Is Hypermedia?" SmartBeat. 2020. Accessed December 29, 2020. https://smartbear.com/learn/api-design/what-is-hypermedia/
29. "What is MIME ( Multi-Purpose Internet Mail Extensions )." InterServer Tips. September 22, 2016. Accessed December 29, 2020. https://www.interserver.net/tips/kb/mime-multi-purpose-internet-mail-extensions/
30. Difference between URL, URI and URN - Interview Questions." Java 67. Accessed December 29, 2020. https://www.java67.com/2013/01/difference-between-url-uri-and-urn.html
31. "Events that trigger workflows." GitHub Docs. 2021. Accessed March 23, 2021. https://docs.github.com/en/actions/reference/events-that-trigger-workflows
32. "Workflow syntax for GitHub Actions." GitHub Docs. 2023. Accessed May 2, 2023. https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions
33. "GitHub to replace 'master' with 'main' starting next month." ZDNet. September 19, 2020. Accessed September 24, 2021. https://www.zdnet.com/article/github-to-replace-master-with-main-starting-next-month/
34. "5 steps to change GitHub default branch from master to main." Steven M. Mortimer. July 23, 2020. Accessed September 24, 2021. https://stevenmortimer.com/5-steps-to-change-github-default-branch-from-master-to-main/
35. "Integrated Terminal." Visual Studio Code. October 7, 2021. Accessed October 11, 2021. https://code.visualstudio.com/docs/editor/integrated-terminal
36. "What's the difference between git clone --mirror and git clone --bare." Stack Overflow. October 23, 2021. Accessed March 30, 2022. https://stackoverflow.com/questions/3959924/whats-the-difference-between-git-clone-mirror-and-git-clone-bare
37. "How do I convert a bare git repository into a normal one (in-place)?" Stack Overflow. July 28, 2021. Accessed March 30, 2022. https://stackoverflow.com/questions/10637378/how-do-i-convert-a-bare-git-repository-into-a-normal-one-in-place
38. "Moving git repository and all its branches, tags to a new remote repository keeping commits history." GitHub niksumeiko/git.migrate. October 27, 2021. Accessed March 30, 2022. https://gist.github.com/niksumeiko/8972566
39. "Python sucks in terms of energy efficiency - literally." The Next Web. November 24, 2021. Accessed August 16, 2022. https://thenextweb.com/news/python-progamming-language-energy-analysis
40. "Which programs are faster?" The Computer Language Benchmarks Game. Accessed August 31, 2022. https://sschakraborty.github.io/benchmark/which-programs-are-fastest.html
41. "Github Language Stats." GitHut 2.0. 2022. Accessed September 2, 2022. https://madnight.github.io/githut/#/pull_requests/2022/1
42. "GitHub Actions: add more details for "workflow_run" event #799." GitHub github/docs. October 6, 2022. Accessed May 2, 2023. https://github.com/github/docs/issues/799
43. "Dependencies Between Workflows on Github Actions." Stack Overflow. May 8, 2022. Accessed May 2, 2023. https://stackoverflow.com/questions/58457140/dependencies-between-workflows-on-github-actions
44. "How to run github action job after all conditional jobs, even it's didn't ran?" Stack Overflow. February 2, 2022. Accessed May 2, 2023. https://stackoverflow.com/questions/70959792/how-to-run-github-action-job-after-all-conditional-jobs-even-its-didnt-ran
45. "Running actions in another directory." Stack Overflow. December 9, 2021. Accessed May 3, 2023. https://stackoverflow.com/questions/58139175/running-actions-in-another-directory
46. "Use working-directory for entire job #25742." GitHub Community. March 21, 2023. Accessed May 3, 2023. https://github.com/orgs/community/discussions/25742
47. "Downloading source code archives." GitHub Docs. Accessed May 16, 2023. https://docs.github.com/en/repositories/working-with-files/using-files/downloading-source-code-archives
48. "Github - unexpected disconnect while reading sideband packet." Stack Overflow. July 19, 2023. Accessed July 19, 2023. https://stackoverflow.com/questions/66366582/github-unexpected-disconnect-while-reading-sideband-packet
49. "Configuring issue templates for your repository." GitHub Docs. Accessed August 12, 2023. https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository
50. "GitHub Actions: how to target all branches EXCEPT master?" Stack Overflow. December 18, 2023. Accessed December 29, 2023. https://stackoverflow.com/questions/57699839/github-actions-how-to-target-all-branches-except-master
51. "Events that trigger workflows." GitHub Docs. Accessed April 21, 2024. https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows
52. "Manually Trigger a GitHub Action with workflow_dispatch." DEV Community This is Learning. January 10, 2023. Accessed April 21, 2024. https://dev.to/this-is-learning/manually-trigger-a-github-action-with-workflowdispatch-3mga
53. "Manually running a workflow." GitHub Docs. Accessed April 21, 2024. https://docs.github.com/en/actions/using-workflows/manually-running-a-workflow
