Packages
========

-  Source Code

   -  Makefile

-  `DEB (Debian) <#deb>`__

   -  `Repositories <#deb---repositories>`__

      -  `Adding a
         Repository <#deb---repositories---adding-a-repository>`__

   -  `Packaging <#deb---packaging>`__

      -  `Macros <#deb---packaging---macros>`__

-  `RPM (RHEL) <#rpm>`__

   -  `Repositories <#rpm---repositories>`__

      -  `Adding a
         Repository <#rpm---repositories---adding-a-repository>`__
      -  `Creating a
         Repository <#rpm---repositories---creating-a-repository>`__
      -  `Common
         Repositories <#rpm---repositories---common-repositories>`__

   -  `Packaging <#rpm---packaging>`__

      -  `Macros <#rpm---packaging---macros>`__

         -  `Directories <#rpm---packaging---macros---directories>`__

      -  `Users and Groups <#rpm---packaging---users-and-groups>`__
      -  `Patches <#rpm---packaging---patches>`__

-  `PKGBUILD (Arch) <#pkgbuild>`__

   -  `Packaging <#pkgbuild---packaging>`__

-  `Flatpak <#flatpak>`__
-  Snap

DEB
---

DEB - Repositories
~~~~~~~~~~~~~~~~~~

DEB - Repositories - Adding a Repository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Source:

1. "SourcesList." Debian Wiki. March 22, 2017. Accessed March 28, 2017.
   https://wiki.debian.org/SourcesList

DEB - Packaging
~~~~~~~~~~~~~~~

Official guides for building Debian packages:

-  https://wiki.debian.org/BuildingTutorial
-  https://www.debian.org/doc/manuals/maint-guide/
-  https://www.debian.org/doc/manuals/debmake-doc/ch04.en.html

A Debian package can be created by moving into the source code and
creating these files and/or directories.

-  **debian/** = The top-level directory for the package.

   -  **changelog** = Required. A change log listing the updates for the
      package release itself, not the program.
   -  **control** = Required. This describes the package name, version,
      maintainer, dependencies, and more.
   -  **copyright** = Required. The licenses used for the package and
      source code.
   -  install = Optional. A text file listing extra files (not installed
      by ``make install``) that should be copied into the package.
   -  **rules** = Required. A Makefile that explains how to build and
      install the program before being packaged. In a default
      environment setup by the ``dh_make`` command this essentially runs
      ``./configure; make; make install`` in the directory that contains
      the ``debian/`` directory. The shebang at the top of the file
      should normally be ``#!/usr/bin/make -f``.
   -  patches/ = Optional. Files for patching the source code.
   -  {preinst\|postinst\|prerm\|postrm} = Optional. These are
      executable scripts that run before installation, after
      installation, before removable, or after removable. [1]

Install the required packaging dependencies.

::

    # apt-get update
    # apt-get install devscripts dh-make dpkg-dev

Create a working build directory, download the source code, and then run
``dh_make``.

::

    $ mkdir build
    $ cd build
    $ curl -O http://<URL_TO_SOURCE_CODE>
    $ tar -v -x -z -f <PROGRAM_NAME>-<VERSION>.tar.gz
    $ cd <PROGRAM_NAME>-<VERSION>
    $ dh_make -f ../<PROGRAM_NAME>-<VERSION>.tar.gz

This will create a ``debian/`` directory inside of the source code
directory. With a template of all of the files required to build the
source code. A copy tarball of the source code is also created as
``<PROGRAM_NAME>_<VERSION>.orig.tar.gz`` in the ``build`` directory.

The DEB package can now be built.

::

    $ dpkg-buildpackage

After building the package, a new source tarball will be created
containing the ``debian`` directory:
``<PROGRAM_NAME>_<VERSION>-<DEB_PACKAGE_RELEASE>.debian.tar.gz``. The
actual package will be named
``<PACKAGE_NAME>_<VERSION>-<DEB_PACKAGE_RELEASE>_<ARCHITECTURE>.deb``.

``changelog`` File Syntax:

::

    <PACKAGE_NAME> (<PROGRAM_VERSION>-<PACKAGE_REVISION>) ; urgency=<URGENCY_LEVEL>

      * <PACKAGE_REVISION_NOTES>

     -- <AUTHOR_FIRST_NAME> <AUTHOR_LAST_NAME> <<EMAIL>>  <DAY>, <DAY_NUMBER> <MONTH> <YEAR> <HH>:<MM>:<SS> <UTC_HOUR_OFFSET>

``changelog`` File Example:

::

    apache (2.4.0-2) stable; urgency=low

      * Second release

     -- Bob Smith <bob@smith.tld>  Mon, 22 Mar 2017 00:01:00 +0200

    apache (2.4.0-1) stable; urgency=low

      * Initial release

     -- Bob Smith <bob@smith.tld>  Mon, 22 Mar 2017 23:12:12 +0100

``control`` File Example [2]:

::

    Source: hello-debian
    Section: utils
    Priority: extra
    Maintainer: Full Name <yourname@example.com>
    Build-Depends: debhelper (>= 8.0.0)
    Standards-Version: 3.9.3
    Vcs-Git: git@github.com:streadway/hello-debian.git
    Vcs-Browser: http://github.com/streadway/hello-debian

    Package: hello-debian
    Section: utils
    Priority: extra
    Architecture: any
    Depends: ${shlibs:Depends}, ${misc:Depends}
    Description: Example package maintenance (under 60 chars)
     The build output from a repository listing the steps to setup a debian
     package in a long-format under 80 characters per line.

Sources:

1. "Chapter 7 - Basics of the Debian package management system." The
   Debian GNU/Linux FAQ. August 28, 2016. Accessed March 25, 2017.
   https://www.debian.org/doc/manuals/debian-faq/ch-pkg\_basics.en.html
2. "hello-debian README.md." streadway/hello-debian GitHub. March 24,
   2014. Accessed May 8, 2017. https://github.com/streadway/hello-debian

DEB - Packaging - Macros
^^^^^^^^^^^^^^^^^^^^^^^^

Many macros exist for helping to build and install Debian packages.

``rule`` macros:

-  dh\_auto\_clean = ``make distclean``
-  dh\_auto\_configure = ``./configure`` with directory options for the
   specific Debian release.
-  dh\_auto\_build = ``make``
-  dh\_auto\_test = ``make test``
-  dh\_auto\_install =

   ::

       make install DESTDIR=/<PATH_TO_>/<PACKAGE>-<VERSION>-revision/debian/<PACKAGE>

[1]

Source:

1. "Chapter 4. Required files under the debian directory." Debian New
   Maintainers' Guide. February 25, 2017. Accessed March 24, 2017.
   https://www.debian.org/doc/manuals/maint-guide/dreq.en.html

RPM
---

RPM - Repositories
~~~~~~~~~~~~~~~~~~

Repositories (sometimes called "repos") are a central location where
packages can easily be found and installed from.

RPM - Repositories - Adding a Repository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On Red Hat based systems, the repositories are all defined as text files
with the ".repo" extension in this directory.

::

    # ls /etc/yum.repos.d/

Here are some common options for repository files: \* [] = This should
be the first part of a repository, with the name being inside the
brackets. \* name = This should be similar to the name from the
brackets. However, this friendly name can be different and is usually
ignored. \* baseurl = The location of the repository. Valid location
types include "http://", "ftp://", and "file://" for using the local
file system. \* mirrorlist = Instead of a baseurl, a link to a list of
repository mirrors can be given. \* enabled = Enable or disable a
repository with a "1" or "0". The default is value is "1". [1] \*
gpgcheck = Force a GPG encryption check against signed packages. Enable
or disable with a "1" or "0". \* gpgkey = Specify the path to the GPG
key.

Variables for repository files: \* $releasever = The RHEL release
version. This is typically the major operating system versioning number
such as "5" or "6". \* $basearch = The CPU architecture. For most modern
PCs this is typically either automatically filled in as "x86\_64" for
64-bit operating systems or "i386" for 32-bit. [2]

At the bare minimum, a repository file needs to include a name and a
baseurl.

::

    [example-repo]
    name=example-repo
    baseurl=file:///var/www/html/example-repo/

Here is an example repository file for the official CentOS 7 repository
using a mirrorlist.

::

    [base]
    name=CentOS-$releasever - Base
    mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
    #baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

Sources:

1. "Fedora 24 System Administrator's Guide" Fedora Documentation. 2016.
   Accessed June 28, 2016.
   https://docs.fedoraproject.org/en-US/Fedora/24/html/System\_Administrators\_Guide/sec-Setting\_repository\_Options.html
2. "yum.conf - Configuration file for yum(8)." Die. Accessed June 28,
   2016. http://linux.die.net/man/5/yum.conf

RPM - Repositories - Creating a Repository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Any directory can be used as a repository to host RPMs. The standard
naming convention used for RHEL based operating systems is
"centos/:math:`releasever/`\ basearch/" where $releasever is the release
version and $basearch is the CPU architecture. However, any directory
can be used.

In this example, a default Apache web server will have the repository
access via the URL "http://localhost/centos/7/x86\_64/." Be sure to
place your RPMs in this directory. [1]

::

    # yum install createrepo
    # mkdir -p /var/www/html/centos/7/x86_64/

::

    # createrepo /var/www/html/centos/7/x86_64/

The "createrepo" command will create 4 or 5 files. \* repomd.xml = An
index for the other repository metadata files. \* primary.xml = Contains
metadata for all packages including the name, version, architecture,
file sizes, checksums, dependencies, etc. \* filelists.xml = Contains
the full listing of every directory and file. \* other.xml = Holds a
changelog of all the packages. \* groups.xml = If a repository has a
"group" that should install multiple packages, the group is specified
here. By default, this file is not created when running "createrepo"
without any arguments. [2]

If new packages are added and/or signed via a GPG key then the
repository cache needs to be updated again. [1]

::

    # createrepo --update /var/www/html/centos/7/x86_64/

Sources:

1. "createrepo(8) - Linux man page." Die. Accessed June 28, 2016.
   http://linux.die.net/man/8/createrepo
2. "createrepo/rpm metadata." createrepo. Accessed June 28 2016.
   http://createrepo.baseurl.org/

RPM - Repositories - Common Repositories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Repository Name                            | Supported Operating System(s) | Official | Description                                                                                                                                                                                                                    | Repository                                                                                                 |
+============================================+===============================+==========+================================================================================================================================================================================================================================+============================================================================================================+
| Enterprise Linux Repository (ELRepo)       | RHEL                          | No       | The latest hardware drivers and Linux kernels. [3]                                                                                                                                                                             | `RHEL6 <http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm>`__,                                |
|                                            |                               |          |                                                                                                                                                                                                                                | `RHEL7 <http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm>`__                               |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Extra Packages for Enterprise Linux (EPEL) | RHEL                          | Yes      | Packages from Fedora built for Red Hat Enterprise Linux (RHEL) based operating systems. [1]                                                                                                                                    | `RHEL6 <https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm>`__,                        |
|                                            |                               |          |                                                                                                                                                                                                                                | `RHEL7 <https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm>`__                         |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Inline with Upstream (IUS)                 | RHEL                          | No       | The latest upstream software that is built for RHEL. IUS packages that can safely replace system packages will. IUS packages known to cause conflicts with operating system packages are installed in a separate location. [2] | `RHEL 6 <https://rhel6.iuscommunity.org/ius-release.rpm>`__,                                               |
|                                            |                               |          |                                                                                                                                                                                                                                | `RHEL 7 <https://rhel7.iuscommunity.org/ius-release.rpm>`__,                                               |
|                                            |                               |          |                                                                                                                                                                                                                                | `CentOS 6 <https://centos6.iuscommunity.org/ius-release.rpm>`__,                                           |
|                                            |                               |          |                                                                                                                                                                                                                                | `CentOS 7 <https://centos7.iuscommunity.org/ius-release.rpm>`__                                            |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Kernel Vanilla                             | Fedora                        | Yes      | Kernel packages for the latest stable and mainline Linux kernels. [6]                                                                                                                                                          | `Fedora <https://repos.fedorapeople.org/repos/thl/kernel-vanilla.repo>`__                                  |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| RPM Fusion                                 | Fedora, RHEL                  | No       | Packages that Fedora does not ship by default (primarily due to license conflicts). [4]                                                                                                                                        | `Fedora26 <https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-26.noarch.rpm>`__,           |
|                                            |                               |          |                                                                                                                                                                                                                                | `Fedora27 <https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-27.noarch.rpm>`__,           |
|                                            |                               |          |                                                                                                                                                                                                                                | `RHEL6 <https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-6.noarch.rpm>`__,             |
|                                            |                               |          |                                                                                                                                                                                                                                | `RHEL7 <https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm>`__              |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| RPM Sphere                                 | Fedora                        | No       | openSUSE packages that are not available in Fedora. [5]                                                                                                                                                                        | `Fedora26 <http://download.opensuse.org/repositories/home:/zhonghuaren/Fedora_26/home:zhonghuaren.repo>`__ |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Wine                                       | Fedora                        | Yes      | The latest stable, development, and staging packages for Wine.                                                                                                                                                                 | `Fedora 26 <https://dl.winehq.org/wine-builds/fedora/26/winehq.repo>`__                                    |
+--------------------------------------------+-------------------------------+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+

Sources:

1. "EPEL." Fedora Project. March 1, 2017. Accessed May 14, 2017.
   https://fedoraproject.org/wiki/EPEL
2. "IUS Community Project." IUS. May 5, 2017. Accessed May 14, 2017.
   https://ius.io/
3. "Welcome to the ELRepo Project." ELRepo. April 4, 2017. Accessed May
   14, 2017. http://elrepo.org/tiki/tiki-index.php
4. "RPM Fusion." RPM Fusion. March 31, 2017. Accessed May 14, 2017.
   https://rpmfusion.org/RPM%20Fusion
5. "RPM Sphere." openSUSE Build Service. Accessed September 4, 2017.
   https://build.opensuse.org/project/show/home:zhonghuaren
6. "Kernel Vanilla Repositories." Fedora Project Wiki. February 28,
   2017. Accessed September 8, 2017.
   https://fedoraproject.org/wiki/Kernel\_Vanilla\_Repositories

RPM - Packaging
~~~~~~~~~~~~~~~

An RPM is built from a "spec" file. This modified shell script contains
all of the information about the program and on how to install and
uninstall it. It is used to build the RPM.

Common variables:

-  Name = The name of the program.

   -  ``%{name}``

-  Version = The version of the package. Typically this is in the format
   of X.Y.Z (major.minor.bugfix) or ISO date format (for example,
   "2016-01-01").

   -  ``%{version}``

-  Release = Start with "1%{?dist}" for the first build of the RPM.
   Increase the number if the package is ever rebuilt. Start from
   "1%{?dist}" if a new version of the actual program is being built.
-  Summary = One sentence describing the package. A period is not
   allowed at the end.
-  BuildRoot = The directory that contains all of the RPM packages. The
   directory structure under here should mirror the files location in
   relation to the top-level root "/". For example, "/bin/bash" would be
   placed under "$RPM\_BUILD\_ROOT/bin/bash".
-  BuildArch = The architecture that the program is meant to run on.
   This is generally either "x86\_64" or "i386." If the code is not
   dependent on the CPU (for example: Java programs, shell scripts,
   documentation, etc.) then "noarch" can be used.
-  Requires = List the RPM packages that are dependencies needed for
   your program to work.
-  License = The license of the program.
-  URL = A URL link to the program's or, if that is not available, the
   developer's website.
-  Source = A tarball of the source code. It should follow the naming
   standard of ``<RPM_NAME>-<RPM_PROGRAM_VERSION>.tar.gz``.

Sample SPEC file:

::

    Name: my-first-rpm
    Version: 1.0.0
    Release: 1%{?dist}
    Summary: This is my first RPM
    License: GPLv3
    URL: http://example.tld/

If you want to build the RPM, simply run:

::

    # rpmbuild -bb <SPECFILE>.spec

In case you also want to build a source RPM (SRPM) run:

::

    # rpmbuild -ba <SPECFILE>.spec

Sections:

-  ``%description`` = Provide a description of the program.
-  ``%prep`` = Define how to extract the source code for building.
-  ``%setup`` =
-  ``%build`` = This is where the program is built from the source code.
-  ``%install`` = Copy files to a directory structure under
   ``%{buildroot}`` that mirrors where their installed location. The
   ``%{buildroot}`` is the top-level directory of a typical Linux file
   system hierarchy.
-  ``%file`` = These are the files that should be copied over during
   installation. Permissions can also be set.

   -  ``%attr(<MODE>, <USER>, <GROUP>)`` = Define this in front of a
      file or folder to give it custom permissions.

Source:

1. "How to create an RPM package." Fedora Project. June 22, 2016.
   Accessed June 28, 2016.
   http://fedoraproject.org/wiki/How\_to\_create\_an\_RPM\_package

RPM - Packaging - Macros
^^^^^^^^^^^^^^^^^^^^^^^^

Macros are variables in the RPM spec file that are expanded upon
compilation of the RPM.

Some useful macros include:

-  ``%{patches}`` = An array of all of the defined patch files.
-  ``%{sources}`` = An array of all of the defined source files.

Source:

1. https://fedoraproject.org/wiki/How\_to\_create\_an\_RPM\_package

RPM - Packaging - Macros - Directories
''''''''''''''''''''''''''''''''''''''

During the creation of an RPM there are a few important directories that
can and will be refereneced.

-  %{topdir} = The directory that the RPM related files should be
   located. By default this is set to ``%{getenv:HOME}/rpmbuild``.
-  %{builddir} = The ``%{_topdir}/BUILD`` directory. This is where the
   compilation of the program should take place.
-  %{\_sourcedir} = The ``%{_topdir}/SOURCES`` directory. This is where
   patches, service files, and source code can be stored.
-  %{\_specdir} = The ``%{_topdir}/SPECS`` directory. This is where the
   SPEC file for the RPM should be stored.
-  %{\_srcrpmdir} = The ``%{_topdir}/SRPMS`` directory. This is where
   the optional source RPM will be compiled and stored to.
-  %{buildroot} = The ``%{_topdir}/BUILDROOT`` directory. This is the
   file system hierarchy of where the RPM files will actually be
   installed to. This is also set to the ``$RPM_BUILD_ROOT`` shell
   variable.

[1]

Source:

1. "Packaging:RPMMacros." Fedora Project Wiki. December 1, 2016.
   Accessed March 13, 2017.
   https://fedoraproject.org/wiki/Packaging:RPMMacros?rd=Packaging/RPMMacros

RPM - Packaging - Users and Groups
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Creating a user or group can be done one of two ways.

-  Dynamically = Let the system deciede what user identification number
   (UID) and group ID (GID) to use.
-  Static = Specify a specific UID or GID number to use. This is useful
   for keeping permissions identical on multiple platforms.

The Fedora Project recommends using these standardized blocks of code to
accomplish these methods. [1]

Dynamic:

::

    Requires(pre): shadow-utils
    [...]
    %pre
    getent group <GROUP_NAME> >/dev/null || groupadd -r <GROUP_NAME>
    getent passwd <USER_NAME> >/dev/null || \
        useradd -r -g <GROUP_NAME> -s /sbin/nologin \
        -c "<USER_DESCRIPTION>" <USER_NAME>
    exit 0

Static:

::

    Requires(pre): shadow-utils
    <OMITTED>
    %pre
    getent group <GROUP_NAME> >/dev/null || groupadd -f -g <GID> -r <GROUP_NAME>
    if ! getent passwd <USER_NAME> >/dev/null ; then
        if ! getent passwd <UID> >/dev/null ; then
          useradd -r -u <UID> -g <GROUP_NAME> -s /sbin/nologin -c "Useful comment about the purpose of this account" <USER_NAME>
        else
          useradd -r -g <GROUP_NAME> -s /sbin/nologin -c "<USER_DESCRIPTION>" <USER_NAME>
        fi
    fi
    exit 0

Source:

1. "Packaging: Users and Groups" Fedora Project. September 14, 2016.
   Accessed February 25, 2017.
   https://fedoraproject.org/wiki/Packaging:UsersAndGroups

RPM - Packaging - Patches
^^^^^^^^^^^^^^^^^^^^^^^^^

Some applications may require patches to work properly. Pathces should
be stored in the ``SOURCES`` directories. At the beginning of the spec
file, where the name and version information is defined, patch file
names can also be defined.

Usage:

::

    Patch<NUMBER>: <PATCH_FILE>

Example:

::

    Patch0: php-fpm_listen_port.patch
    Patch1: php_memory_limit.patch

These patches can then be referenced in the ``%setup`` phase (after
``%prep`` and before ``%build%``).

::

    %setup -q

A patched file can be created using the ``diff`` command.

::

    $ diff -u <ORIGINAL_FILE> <PATCHED_FILE> > <PATCH_NAME>.patch

If multiple files in a directory have been patched, a more comphrensive
patch file can be made.

::

    $ diff -urN <ORIGINAL_SOURCE_DIRECTORY>/ <PATCHED_SOURCE_DIRECTORY>/ > <PATCH_NAME>.patch

In the spec file, the ``%patch`` macro can be used. The ``-p1`` argument
strips off the top-level directory of the patch's path.

Syntax:

::

    %patch0 -p1
    %patch1 -p1

Example patch file:

::

    --- d20-1.0.0_patched/src/dice.h
    +++ d20-1.0.0/src/dice.h

A patch can also be made without the ``%patch`` macro by specifying the
location of the patch file.

::

    patch < %{_sourcedir}/<FILE_NAME>

[1]

Source:

1. "How to Create and Use Patch Files for RPM Packages." Bob Cromwell.
   March 20, 2017. Accessed March 20, 2017.
   http://cromwell-intl.com/linux/rpm-patch.html

PKGBUILD
--------

PKGBUILD - Packaging
~~~~~~~~~~~~~~~~~~~~

Arch Linux packages are design to be simple and easy to create. A
PKGBUILD file is compressed with a software's contents into a XZ
tarball. This can contain either the source code or compiled program.

Required Variables:

-  pkgname = Name of the software.
-  pkgver = Version of the software.
-  pkgrel = Version of the package (only increase if the PKGBUILD file
   has been modified and not the software).
-  arch = The architecture the software is built for. Any architecture
   that applies should be defined. Valid options: x86\_64, i686, arm
   (armv5), armv6h, armv7h, aarch64 (armv8 64-bit), or any.

Optional Variables:

-  pkgdesc = A brief description of the software.
-  url = The URL of the software's website.
-  license = The license of the software. Valid options: GPL, BSD, MIT,
   Apache, etc.
-  depends = List other package version dependencies.
-  optdepends = List optional dependencies and a brief description.
-  makedepends = List packages required to build the software from
   source.
-  provides = List tools that are provided by the package but do not
   necessarily have file names.
-  conflicts = List any conflicting packages.
-  replaces = List packages that this software should replace.

[1]

Functions

Required:

-  build()

   -  For building the software, PKGBUILD will need to move into the
      directory that the XZ tarball was extracted to. This is
      automatically generated as the "srcdir" variable. In most
      situations this should be the package name and version separated
      by a dash.

      ::

          $ cd "${srcdir}"

      OR

      ::

          $ cd "${pkgname}-${pkgver}"

-  package()

   -  These are the steps to copy and/or modify files from the "srcdir"
      to be placed in the "pkgdir" to represent where they will be
      installed on an end-user's system. This acts as the top-level
      directory of a Linux file system hierarchy.

      ::

          $ cd "${pkgdir}"

   -  An example of installing compiled source code using a Make file.

      ::

          $ make DESTDIR="${pkgdir}" install

      [2][3]

Sources:

1. "PKGBUILD." Arch Linux Wiki. October 26, 2016. Accessed November 19,
   2016. https://wiki.archlinux.org/index.php/PKGBUILD
2. "Creating packages." Arch Linux Wiki. July 30, 2016. Accessed
   November 19, 2016.
   https://wiki.archlinux.org/index.php/creating\_packages
3. "PKGBUILD(5) Manual Page." Arch Linux Man Pages. February 26, 2016.
   Accessed November 19, 2016.
   https://www.archlinux.org/pacman/PKGBUILD.5.html

Flatpak
-------

Flatpak is a sandbox solution that provides a universal application packaging format. It was first started by an employee from Red Hat in their spare time. Flatpak has a strong focus on portability, security, and effective space usage. [1] This package manager is available for most modern Linux distributions. [2]

Source:

1. "About `Flatpak <#flatpak>`__." Flatpak. March 18, 2017. Accessed
   March 19, 2017. http://flatpak.org/
2. "Getting Flatpak." Flatpak. March 18, 2017. Accessed March 19, 2017.
   http://flatpak.org/getting.html
