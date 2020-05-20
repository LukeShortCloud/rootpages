Package Managers
================

.. contents:: Table of Contents

Commands
--------

These are the commands used for common operator tasks when handling packages.

.. csv-table::
   :header: Action, APT (Debian), DNF/YUM (Fedora), Pacman (Arch Linux), Zyyper (openSUSE)
   :widths: 20, 20, 20, 20, 20

   Install, apt-get install, dnf install, pacman -S, zypper search
   Uninstall, apt-get remove, dnf remove, pacman -Rns, zypper remove
   Update, apt-get update && apt-get upgrade, dnf update, pacman -Sy, zypper update
   Operating system upgrade, apt-get dist-upgrade, dnf distro-sync, pacman -Syyu, zypper dist-upgrade
   Search for a package based on it's name, apt-cache search, dnf search, pacman -Ss, zypper search
   Search for a package based on a file it has, apt-file search, dnf whatprovides, pacman -F, zypper --provides --match-exact

DEB
---

Repositories
~~~~~~~~~~~~

Adding a Repository
^^^^^^^^^^^^^^^^^^^

Debian repositories can be managed by editing the primary file
``/etc/apt/sources.list`` or by adding new files to the
``/etc/apt/sources.list.d/`` directory.

The syntax is:

::

    <SOURCE> <URL> <DEBIAN_RELEASE> <COMPONENT1> <COMPONENT2> <COMPONENT3>

Sources:

-  deb = Binary packages.
-  deb-src = Source packages.

The URL is assumed to have the path
``http://<DOMAIN>/<PATH_TO>/dists/<DEBIAN_RELEASE>`` available. The only
part of the URL required is the location where the top-level ``dists``
directory resides.

URL:

-  ``http://ftp.debian.org/debian/``

Debian releases (as of 2017-03):

-  ``oldstable`` or ``wheezy``
-  ``stable`` or ``jessie``
-  ``testing`` or ``stretch``
-  ``unstable`` or ``sid``

Components:

-  main = The primary packages of Debian.
-  contrib = These packages require dependencies that are not in the
   ``main`` section.
-  non-free = These packages are proprietary packages that are unable to
   be shipped with Debian due to license conflicts.

[1]

RPM
---

Repositories
~~~~~~~~~~~~

Repositories (sometimes called "repos") are a central location where
packages can easily be found and installed from.

Adding a Repository
^^^^^^^^^^^^^^^^^^^

On Red Hat based systems, the repositories are all defined as text files
with the ".repo" extension in this directory.

.. code-block:: sh

    $ sudo ls /etc/yum.repos.d/

Common options for repository files:

-  [] = This should be the first part of a repository, with the name being inside the brackets.
-  name = This should be similar to the name from the brackets. However, this friendly name can be different and is usually ignored.
-  baseurl = The location of the repository. Valid location types include "http://", "ftp://", and "file://" for using the local file system.
-  mirrorlist = Instead of a baseurl, a link to a list of repository mirrors can be given.
-  enabled = Enable or disable a repository with a "1" or "0". The default is value is "1". [2]
-  gpgcheck = Force a GPG encryption check against signed packages. Enable or disable with a "1" or "0".
-  gpgkey = Specify the path to the GPG key.

Variables for repository files:

-  ``$releasever`` = The RHEL release version. This is typically the major operating system versioning number such as "6" or "7".
-  ``$basearch`` = The CPU architecture. For most modern PCs this is typically either automatically filled in as "x86\_64" for 64-bit operating systems or "i386" for 32-bit. [3]

At the bare minimum, a repository file needs to include a name and a
baseurl.

.. code-block:: ini

    [example-repo]
    name=example-repo
    baseurl=file:///var/www/html/example-repo/

Here is an example repository file for the official CentOS 7 repository
using a mirrorlist.

.. code-block:: ini

    [base]
    name=CentOS-$releasever - Base
    mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
    #baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7


Creating a Repository
^^^^^^^^^^^^^^^^^^^^^

Any directory can be used as a repository to host RPMs. The standard naming convention used for RHEL based operating systems is ``el/$releasever/$basearch/`` where ``$releasever`` is the release version and ``$basearch`` is the CPU architecture. However, any directory can be used.

In this example, a default Apache web server will have the repository
access via the URL "http://localhost/el/7/x86\_64/." Be sure to
place your RPMs in this directory. [1]

.. code-block:: sh

    $ sudo yum install createrepo
    $ sudo mkdir -p /var/www/html/el/7/x86_64/

.. code-block:: sh

    $ sudo createrepo /var/www/html/el/7/x86_64/

The "createrepo" command will create 4 or 5 files.

-  repomd.xml = An index for the other repository metadata files.
-  primary.xml = Contains metadata for all packages including the name, version, architecture, file sizes, checksums, dependencies, etc.
-  filelists.xml = Contains the full listing of every directory and file.
-  other.xml = Holds a changelog of all the packages.
-  groups.xml = If a repository has a "group" that should install multiple packages, the group is specified here. By default, this file is not created when running "createrepo"without any arguments. [5]

If new packages are added and/or signed via a GPG key then the
repository cache needs to be updated again. [4]

.. code-block:: sh

    $ sudo createrepo --update /var/www/html/el/7/x86_64/

Common Repositories
^^^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: "Name", "Supported Operating Systems", "Official", "Description", "Links"
   :widths: 20, 20, 20, 20, 20

   CentOS Vault, CentOS, Yes, Old and unmaintained major and minor releases of CentOS, `CentOS Vault <http://vault.centos.org/>`__
   "Enterprise Linux Repository (ELRepo)", "CentOS, RHEL", "No", "The latest hardware drivers and Linux kernels. [8]", `Get started <http://elrepo.org/tiki/tiki-index.php>`__
   "Extra Packages for Enterprise Linux (EPEL)", "CentOS, RHEL", "Yes", "Packages from Fedora built for Enterprise Linux (RHEL) based operating systems. On EL <= 7, these require both the ``extras`` and ``optional`` repositories to be enabled. [6]", `Quickstart <https://fedoraproject.org/wiki/EPEL#Quickstart>`__
   "Inline with Upstream (IUS)", "CentOS, RHEL", "No", "The latest upstream software that is built for RHEL. IUS packages that can safely replace system packages will. IUS packages known to cause conflicts with operating system packages are installed in a separate location. [7]", `Setup <https://ius.io/setup>`__
   "Kernel Vanilla", "Fedora", "Yes", "Kernel packages for the latest stable and mainline Linux kernels. [11]", `How to use <https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories#How_to_use_these_repos>`__
   "RPM Fusion", "CentOS, Fedora, RHEL", "No", "Packages that Fedora does not ship by default (primarily due to license conflicts). [9]", `Configuration <https://rpmfusion.org/Configuration>`__
   "RPM Sphere", "Fedora", "No", "openSUSE packages that are not available in Fedora. [10]", `Install <https://rpmsphere.github.io/>`__
   "Wine", "Fedora", "Yes", "The latest stable, development, and staging packages for Wine.", `Installing <https://wiki.winehq.org/Fedora>`__

Red Hat Repositories
~~~~~~~~~~~~~~~~~~~~

Red Hat provides different repositories for Red Hat Enterprise Linux operating systems. Many of these provide access to licensed downstream software maintained by the company and obtained through subscriptions.

The "subscription-manager" command is used to manage these repositories.

.. code-block:: sh

    $ sudo subscription-manager repos --enable <RED_HAT_REPOSITORY>

Common repositories:

-  rhel-7-server-extras-rpms
-  rhel-7-server-optional-rpms
-  rhel-7-server-devtools-rpms = Developer Tools. Useful packages for software developers. The subscriptions that can enable this are listed `here <https://access.redhat.com/documentation/en-US/Red\_Hat_Developer\_Toolset/1/html/User\_Guide/sect-Red\_Hat_Developer\_Toolset-Subscribe.html>`_.
-  rhel-server-rhscl-7-rpms = Software Collections. Newer versions of software, usually aligning with upstream, are provided. They are installed into a prefix directory that is separate from the operating system libraries. [14]

Fedora
~~~~~~

Fedy
^^^^

Fedora, by default, only provides free and open source software (no proprietary packages). The graphical utility ``Fedy`` allows a user to easily install required packages for media codecs, Oracle Java, and other utilities and tweaks. Both the ``free`` and ``non-free`` RPMFusion repositories have to be installed first.

.. code-block:: sh

   $ sudo dnf install "https://dl.folkswithhats.org/fedora/$(rpm -E %fedora)/RPMS/fedy-release.rpm"
   $ sudo dnf install fedy
   $ fedy

[15]

Flatpak
-------

Flatpak is a sandbox solution that provides a universal application packaging format. It was first started by an employee from Red Hat in their spare time. Flatpak has a strong focus on portability, security, and effective space usage. [12] This package manager is available for most modern Linux distributions. [13]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/administration/package_managers.rst>`__
-  `< 2019.07.01 <https://github.com/ekultails/rootpages/commits/master/src/administration/packages.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/packages.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/packages.md>`__

Bibliography
------------

1. "SourcesList." Debian Wiki. March 22, 2017. Accessed March 28, 2017. https://wiki.debian.org/SourcesList
2. "Fedora 24 System Administrator's Guide" Fedora Documentation. 2016. Accessed June 28, 2016. https://docs.fedoraproject.org/en-US/Fedora/24/html/System\_Administrators\_Guide/sec-Setting\_repository\_Options.html
3. "yum.conf - Configuration file for yum(8)." Die. Accessed June 28, 2016. http://linux.die.net/man/5/yum.conf
4. "createrepo(8) - Linux man page." Die. Accessed June 28, 2016. http://linux.die.net/man/8/createrepo
5. "createrepo/rpm metadata." createrepo. Accessed June 28 2016. http://createrepo.baseurl.org/
6. "EPEL." Fedora Project. March 1, 2017. Accessed May 14, 2017. https://fedoraproject.org/wiki/EPEL
7. "IUS Community Project." IUS. May 5, 2017. Accessed May 14, 2017. https://ius.io/
8. "Welcome to the ELRepo Project." ELRepo. April 4, 2017. Accessed May 14, 2017. http://elrepo.org/tiki/tiki-index.php
9. "RPM Fusion." RPM Fusion. March 31, 2017. Accessed May 14, 2017. https://rpmfusion.org/RPM%20Fusion
10. "RPM Sphere." openSUSE Build Service. Accessed September 4, 2017. https://build.opensuse.org/project/show/home:zhonghuaren
11. "Kernel Vanilla Repositories." Fedora Project Wiki. February 28, 2017. Accessed September 8, 2017. https://fedoraproject.org/wiki/Kernel\_Vanilla\_Repositories
12. "About `Flatpak <#flatpak>`__." Flatpak. March 18, 2017. Accessed March 19, 2017. http://flatpak.org/
13. "Getting Flatpak." Flatpak. March 18, 2017. Accessed March 19, 2017. http://flatpak.org/getting.html
14. "Red Hat Developer Tools software repository not available." Red Hat Community Discussions. November 14, 2017. Accessed February 26, 2018. https://access.redhat.com/discussions/3155021
15. "Install codecs, software, and more…" Fedy - Tweak your Fedora. Accessed March 18, 2019. https://www.folkswithhats.org/
