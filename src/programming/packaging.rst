Packaging
=========

.. contents:: Table of Contents

GPG Keys
--------

Usage
~~~~~

Signing a binary package with a GPG key ensures that it has not been tampered with. DEB, PKGBUILD, and RPM packages all support signing with a GPG public and private key pair.

-  Create a GPG key pair. It will be saved to ``~/.gnupg/``. Either use the defaults by running ``gpg --gen-key`` or ``gpg --full-generate-key`` to configure all of the options including the encryption type, bit size, and expiration time.

   .. code-block:: sh

      $ gpg --gen-key
      Real name: <FIRST_NAME> <LAST_NAME>
      Email address: <EMAIL_ADDRESS>
      You selected this USER-ID:
          "<FIRST_NAME> <LAST_NAME> <EMAIL_ADDRESS>"

-  Find the GPG key ID and use it to generate a plaintext public key file. [31]

   .. code-block:: sh

      $ gpg --list-keys
      $ gpg --export --armor <GPG_KEY_ID> > ~/.gnupg/gpg-public-key.asc

-  Optionally send the GPG key to a remote server. Verify that it was uploaded. [41][42]

   .. code-block:: sh

      $ gpg --send-keys <GPG_KEY_ID>
      $ gpg --recv-keys <GPG_KEY_ID>

-  Unlock the private GPG key by using a password via standard input. [45]

   .. code-block:: sh

      $ echo "<PASSWORD>" | gpg --passphrase-fd 0

-  Export the private GPG key and then import it as a different user. [43]

   .. code-block:: sh

      $ gpg --list-secret-keys
      $ gpg --export-secret-keys <GPG_KEY_ID> > /tmp/gpg-private.key
      $ chown <OTHER_USER> /tmp/gpg-private.key
      $ su - <OTHER_USER>
      $ gpg --import /tmp/gpg-private.key
      $ rm -f /tmp/gpg-private.key

DEB (Debian)
------------

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

.. code-block:: sh

    $ sudo apt-get update
    $ sudo apt-get install devscripts dh-make dpkg-dev

Create a working build directory, download the source code, and then run
``dh_make``.

.. code-block:: sh

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

.. code-block:: sh

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

Macros
~~~~~~

Many macros exist for helping to build and install Debian packages.

``rule`` macros:

-  dh\_auto\_clean = ``make distclean``
-  dh\_auto\_configure = ``./configure`` with directory options for the
   specific Debian release.
-  dh\_auto\_build = ``make``
-  dh\_auto\_test = ``make test``
-  dh\_auto\_install =

   .. code-block:: sh

       make install DESTDIR=/<PATH_TO_>/<PACKAGE>-<VERSION>-revision/debian/<PACKAGE>

[3]

RPM (Red Hat)
-------------

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
-  License = The license of the program. If using a standard open source license, use the official abbreviation for it as defined by the `SPDX License List <https://spdx.org/licenses/>`__. Common open source licenses:

   -  ``Apache-1.0``, ``Apache-1.1``, or ``Apache-2.0``.
   -  ``BSD-1-Clause``, ``BSD-2-Clause``, ``BSD-3-Clause``, or ``BSD-4-Clause``.
   -  ``GPL-1.0-only``, ``GPL-1.0-or-later``, ``GPL-2.0-only``, ``GPL-2.0-or-later``, ``GPL-3.0-only`` or ``GPL-3.0-or-later``.
   -  ``MIT``.
   -  ``WTFPL``.

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
    License: GPL-3.0-only
    URL: http://example.tld/

If you want to build the RPM, simply run:

.. code-block:: sh

    $ sudo rpmbuild -bb <SPECFILE>.spec

In case you also want to build a source RPM (SRPM) run:

.. code-block:: sh

    $ sudo rpmbuild -ba <SPECFILE>.spec

Sections:

-  ``%description`` = **Required.** Provide a description of the program.
-  ``%prep`` = Define how to extract the source code for building.

   -  ``%setup`` = This macro can only happen during the ``%prep`` stage.
   -  ``%patch`` = Patch the source code with a provided patch file.

-  ``%build`` = This is where the program is built from the source code.
-  ``%install`` = Copy files to a directory structure under ``%{buildroot}`` that mirrors where their installed location. The ``%{buildroot}`` is the top-level directory of a typical Linux file system hierarchy.
-  ``%file`` = These are the files that should be copied over during installation. Permissions can also be set.

   -  ``%attr(<MODE>, <USER>, <GROUP>)`` = Define this in front of a file or folder to give it custom permissions.

-  ``%changelog`` = **Required.** Provide a change log for the RPM spec. The syntax for the change log is shown below.

   ::

      %changelog
      * <DAY_OF_THE_WEEK_NAME> <MONTH> <DAY_OF_THE_WEEK_NUMBER> <YEAR> <AUTHOR_FIRST_NAME> <AUTHOR_LAST_NAME> <<AUTHOR_EMAIL>> <RPM_VERSION>-<RPM_RELEASE>
      - <CHANGE_LOG_SENTENCE_1>
      - <CHANGE_LOG_SENTENCE_2>

[4]

Macros
~~~~~~

Macros are variables in the RPM spec file that are expanded upon
compilation of the RPM.

Some useful macros include:

-  ``%{patches}`` = An array of all of the defined patch files.
-  ``%{sources}`` = An array of all of the defined source files.

[5]

Directories
~~~~~~~~~~~

During the creation of an RPM there are a few important directories that
can and will be referenced.

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

[6]

Users and Groups
~~~~~~~~~~~~~~~~

Creating a user or group can be done one of two ways.

-  Dynamically = Let the system decide what user identification number
   (UID) and group ID (GID) to use.
-  Static = Specify a specific UID or GID number to use. This is useful
   for keeping permissions identical on multiple platforms.

The Fedora Project recommends using these standardized blocks of code to
accomplish these methods. [7]

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

Patches
~~~~~~~

Some applications may require patches to work properly. Patches should
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

.. code-block:: sh

    $ diff -u <ORIGINAL_FILE> <PATCHED_FILE> > <PATCH_NAME>.patch

If multiple files in a directory have been patched, a more comprehensive
patch file can be made.

.. code-block:: sh

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

.. code-block:: sh

    patch < %{_sourcedir}/<FILE_NAME>

[8]

Examples
~~~~~~~~

-  Use the summary as the description.

   ::

      Summary: This package provides program X

      %description
      %{summary}.

-  Automatically generate a change log either based on (1) a file or (2) git history. [14]

   ::

       %changelog
       %autochangelog

-  Manually create a change log.

   ::

      %changelog
      * Sat Dec 24 2020 Foo Bar <foobar@foobar.tld> 1.0-1
      - Initial RPM release

-  Automatically extract an archive and change into the directory of it. This assumes that both the archive name (without the extension) and the directory name will be exactly the same.

   ::

      %prep
      %autosetup -n <ARCHIVE>.<EXTENSION>

-  Automatically extract all archives but do not change directory during the ``%setup`` phase. This is useful for when the archive name is different from the extracted directory name. [15] For example, this is useful for GitHub downloads of source code.

   ::

      Source0: https://github.com/<USERNAME>/<PROJECT>/archive/<COMMIT>.zip

      %prep
      %setup -q -c

      %install
      cd <PROJECT>-<COMMIT>

-  Build a RPM with systemd support. This example will install a systemd service file to ``/lib/systemd/system/example.service`` and enabled it by default by using a preset file at ``/usr/lib/systemd/system-preset/10-example.preset``. [24][25][26]

   ::

      BuildRequires: systemd

      %install
      mkdir -p %{buildroot}%{_unitdir} %{buildroot}%{_presetdir}
      cp -v example.service %{buildroot}/%{_unitdir}
      echo "enable example.service" > %{buildroot}%{_presetdir}/10-example.preset

Building a RPM
~~~~~~~~~~~~~~

rpmbuild
^^^^^^^^

Install tools requires to build RPMs.

.. code-block:: sh

   $ sudo dnf install rpm-build rpmdevtools

Create all of the directories required for ``rpmbuild``.

.. code-block:: sh

   $ mkdir -p ~/rpmbuild/BUILD/
   $ mkdir ~/rpmbuild/BUILDROOT/
   $ mkdir ~/rpmbuild/RPMS/
   $ mkdir ~/rpmbuild/SOURCES/
   $ mkdir ~/rpmbuild/SRPMS/

Copy local source files to the ``~/rpmbuild/SOURCES/`` directory.

Download the required external source files using the ``spectool`` command. These will be saved to ``~/rpmbuild/SOURCES/``. The ``rpmbuild`` command cannot download source code. [17]

.. code-block:: sh

   $ spectool -g -R <RPM_SPEC_FILE>

Install build dependencies.

-  Fedora:

   .. code-block:: sh

      $ sudo dnf install 'dnf-command(builddep)'
      $ sudo dnf builddep <RPM_SPEC_FILE>

Optionally build the source RPM.

.. code-block:: sh

   $ rpmbuild -bs <RPM_SPEC_FILE>

Build the binary RPM(s). The RPM(s) will be stored at ``~/rpmbuild/RPMS/<CPU_ARCHITECTURE>/``.

.. code-block:: sh

   $ rpmbuild -bb <RPM_SPEC_FILE>

Mock
^^^^

Mock creates a chroot of a RPM-based Linux distribution. This allows for isolating build dependencies away from the host and building a RPM for more than one Linux distribution. Mock does not work within a container. Instead, use the standard ``rpmbuild -bb <SPEC_FILE>`` command to build a binary RPM from within a container.

Install tools required to build RPMs.

.. code-block:: sh

   $ sudo dnf install mock rpm-build rpmdevtools

Allow a non-root user to user Mock.

.. code-block:: sh

   $ sudo usermod -a -G mock <USER>

Initialize Mock for the same operating system release as the host or a specified one. Valid releases can be found at ``/etc/mock/<RELEASE>.cfg``.

.. code-block:: sh

   $ mock --init

.. code-block:: sh

   $ ls -1 /etc/mock/
   $ mock -r <RELEASE> --init

Download the required external source code using the ``spectool`` command. These will be saved to ``~/rpmbuild/SOURCES/``. The ``rpmbuild`` command cannot download source code. [17]

.. code-block:: sh

   $ spectool -g -R <RPM_SPEC_FILE>

Build a source RPM.

.. code-block:: sh

   $ rpmbuild -bs <RPM_SPEC_FILE>

Build the binary RPM(s). The RPM(s), along with the log files, will be stored at ``/var/lib/mock/<RELEASE>/result/``.

.. code-block:: sh

   $ mock ~/rpmbuild/SRPMS/<SOURCE_RPM_NAME>.src.rpm

[16]

GPG Signing
^^^^^^^^^^^

-  `Create <#creation>`__ a GPG key pair.

-  Import the GPG key on all of the systems that will install the signed RPMs.

   .. code-block:: sh

      $ sudo rpm --import ~/.gnupg/gpg-public-key.asc

-  Optionally set that GPG key as the default for signing. [32]

   .. code-block:: sh

      $ ${EDITOR} ~/.rpmmacros
      %_gpg_name <EMAIL_ADDRESS>

-  Install the RPM signing tool.

   .. code-block:: sh

      $ sudo dnf install rpm-sign

-  Use the default GPG key to sign an existing binary RPM.

   .. code-block:: sh

      $ rpm --addsign <BINARY_RPM>

-  Or define a GPG key to sign with.

   .. code-block:: sh

      $ rpm --define "_gpg_name <EMAIL_ADDRESS>" --addsign <BINARY_RPM>

-  Verify the GPG signature. [33]

   .. code-block:: sh

      $ rpm --checksig <BINARY_RPM>

-  Create a repository with the RPM package included and then sign the repository metadata.

   .. code-block:: sh

      $ creatrepo .
      $ gpg --detach-sign --armor repodata/repomd.xml

-  On a client system that will install these packages, configure the repository. [34]

  .. code-block:: ini

     [<REPOSITORY_NAME_SNAKE_CASE>]
     name=<REPOSITORY_NAME_HUMAN_FRIENDLY>
     baseurl=<REPOSITORY_URL>
     enabled=1
     gpgcheck=1
     gpgkey=<PUBLIC_GPG_KEY_URL>"

Fedora Packages
~~~~~~~~~~~~~~~

Fedora provides an automated system to download and build RPM packages using the ``fedpkg`` tool.

-  Install ``fedpkg``.

   .. code-block:: sh

      $ sudo dnf install fedpkg

-  Download the package repository.

   .. code-block:: sh

      $ fedpkg clone -a <GIT_REPOSITORY>
      $ cd <GIT_REPOSITORY>
      $ git checkout origin/f<FEDORA_MAJOR_VERSION>

-  Install build dependencies.

   .. code-block:: sh

      $ sudo dnf builddep <RPM_SPEC>

-  Optionally create a source RPM.  ``fedpkg srpm`` is a wrapper around ``rpmbuild -bs``. [30]

   .. code-block:: sh

      $ fedpkg srpm

-  Build the RPM package using local host dependencies.

   .. code-block:: sh

      $ fedpkg local

-  Build the RPM using Mock to isolate build dependencies.

   .. code-block:: sh

      $ fedpkg mockbuild

-  Build the RPM and manually set the release (for example, to ``f38``) if the git repository is not on a standard branch.

   .. code-block:: sh

      $ fedpkg --release f38 local

[18]

Repositories
~~~~~~~~~~~~

Creating a Repository
^^^^^^^^^^^^^^^^^^^^^

Any directory can be used as a repository to host RPMs. The standard naming convention used for RHEL based operating systems is ``el/$releasever/$basearch/`` where ``$releasever`` is the release version and ``$basearch`` is the CPU architecture. However, any directory can be used.

In this example, a default Apache web server will have the repository access via the URL "http://localhost/el/7/x86\_64/." Be sure to place your RPMs in this directory. [27]

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
-  groups.xml = If a repository has a "group" that should install multiple packages, the group is specified here. By default, this file is not created when running "createrepo"without any arguments. [28]

If new packages are added and/or signed via a GPG key then the repository cache needs to be updated again. [29]

.. code-block:: sh

    $ sudo createrepo --update /var/www/html/el/7/x86_64/

Fedora Copr
^^^^^^^^^^^

Fedora Copr is a free build system and repository for RPM-based Linux distributions. The source code of a RPM can be provided in one of many ways for it to be built and hosted:

-  URL = The URL to the source RPM.
-  Upload = Manually upload a source RPM.
-  Source code management (SCM) = The URL to a SCM repository that hosts the source RPM files. It will be built with one of the selected tools:

   -  rpkg (default) = Fedora Copr requires any source code that would normally be downloaded to be uploaded as "lookaisde" cache. [19][20]
   -  Tito = Requires Tito to manage the version of the RPM insteaad of the spec file.
   -  Makefile = Runs ``make srpm``. Only works for the root directory of the project.

-  Custom script = Provide a shell script to build the SRPM. No Internet access, no chroot, and no package manager are provided for this build type.

[21]

Upload a SRPM
'''''''''''''

-  Generate a Fedora Copr token from `here <https://copr.fedorainfracloud.org/api/>`__. This token is randomly generated and is only valid for 6 months. That provides the contents of the configuration file that should be stored at ``~/.config/copr``.

-  Install the CLI client for Fedora Copr.

   .. code-block:: sh

      $ sudo dnf install copr-cli

-  Optionally create a new project if one does not already exist.

   .. code-block:: sh

      $ copr-cli create --chroot fedora-<FEDORA_MAJOR_VERSION>-i386 --chroot fedora-<FEDORA_MAJOR_VERSION>-x86_64 <PROJECT_NAME>

-  Upload a source RPM and build a binary RPM. This command will not exit until a build either succeeds or fails. [22]

   .. code-block:: sh

      $ copr-clir build <PROJECT_NAME> ~/rpmbuild/SRPMS/*.src.rpm

-  Optionally enable the repository to install the built packages. [23]

   .. code-block:: sh

      $ sudo dnf install 'dnf-command(copr)'
      $ sudo dnf copr enable <USER_NAME>/<PROJECT_NAME>

Troubleshooting
~~~~~~~~~~~~~~~

Error Messages
^^^^^^^^^^^^^^

-  The ``custom_macro`` macro does not exist. Find and install it to ``/usr/lib/rpm/macros.d/``.
-  Alternatively, if the message complains about a native macro instead, it could be used in the wrong section.

.. code-block:: sh

   $ rpmbuild

::

   + echo foo bar
   + %custom_macro
   /var/tmp/rpm-tmp.0Sev9I: line 324: fg: no job control
   error: Bad exit status from /var/tmp/rpm-tmp.0Sev9I (%prep)

[12]

----

Error when building a RPM stating that an ambigous Python shebang is not allowed.

::

   *** ERROR: ambiguous python shebang in /usr/bin/<PYTHON_FILE>: #!/bin/env python. Change it to python3 (or python2) explicitly.

Solution:

-  RPM builds will fail with an error if the shebang of a Python program does not explicility use "python2" or "python3" ("python" is not allowed). Update the source code either during the ``%prep`` (recommended) or ``%install`` phase.

   ::

      %prep
      sed -i s'/env\ python/env\ python3/'g %{buildroot}/usr/bin/<PYTHON_FILE>

PKGBUILD (Arch Linux)
---------------------

Creating a PKGBUILD
~~~~~~~~~~~~~~~~~~~

PKGBUILD File
^^^^^^^^^^^^^

Arch Linux packages are design to be simple and easy to create. A
PKGBUILD file is compressed with a software's contents into a XZ
tarball. This can contain either the source code or compiled program.

Syntax:

::

   <KEY>="<STRING_VALUE>"
   <KEY>=("<ARRAY_VALUE_0>"
          "<ARRAY_VALUE_1>")

   <FUNCTION>() {
       <FUNCTION_LOGIC_LINE_1>
       <FUNCTION_LOGIC_LINE_2>
   }

Required variables:

-  ``pkgname`` = String. Name of the software.
-  ``pkgver`` = String. Version of the software.
-  ``pkgrel`` = String. Version of the package (only increase if the PKGBUILD file has been modified and not the software).
-  ``arch`` = Array. The architecture the software is built for. Any architecture that applies should be defined. Valid options: ``x86_64``, ``i686``, ``arm`` (armv5), ``armv6h``, ``armv7h``, ``aarch64`` (armv8 64-bit), or ``any``.

Optional variables:

-  pkgdesc = A brief description of the software.
-  url = The URL of the software's website.
-  license = The license of the software. Valid options: ``custom:<CUSTOM_LICENSE_NAME>``, ``unknown``, GPLv2, BSD, MIT, Apache, etc.
-  depends = List other package version dependencies.
-  optdepends = List optional dependencies and a brief description.
-  makedepends = List packages required to build the software from source.
-  provides = List tools that are provided by the package but do not necessarily have file names.
-  conflicts = List any conflicting packages.
-  replaces = List packages that this software should replace.

[9]

**Functions**

Required:

-  build()

   -  For building the software, PKGBUILD will need to move into the
      directory that the XZ tarball was extracted to. This is
      automatically generated as the "srcdir" variable. In most
      situations this should be the package name and version separated
      by a dash.

      .. code-block:: sh

          $ cd "${srcdir}"

      OR

      .. code-block:: sh

          $ cd "${pkgname}-${pkgver}"

-  package()

   -  These are the steps to copy and/or modify files from the "srcdir"
      to be placed in the "pkgdir" to represent where they will be
      installed on an end-user's system. This acts as the top-level
      directory of a Linux file system hierarchy.

      .. code-block:: sh

          $ cd "${pkgdir}"

   -  An example of installing compiled source code using a Make file.

      .. code-block:: sh

          $ make DESTDIR="${pkgdir}" install

[10][11]

GPG Signing
^^^^^^^^^^^

-  `Create <#creation>`__ a GPG key pair. Even if this key is added and signed by the ``pacman-key`` command later on, the local user needs access to the GPG key. Otherwise, ``makepkg`` or ``repo-add`` will complain that the GPG key ID does not exist. [35]
-  Import a GPG key.

   -  Use a public GPG key file:

      .. code-block:: sh

         $ sudo pacman-key --add ~/.gnupg/gpg-public-key.asc

   -  Use a public GPG key from a server:

      .. code-block:: sh

         $ sudo pacman-key --recv-keys <GPG_KEY_ID>

-  Verify that the key has been imported.

   .. code-block:: sh

      $ pacman-key --list-keys

-  Load the key and then verify that it has been imported. [36] Otherwise, installing packages with the GPG key will result in this error: ``error: <PACKAGE>: signature from "<FIRST_NAME> <LAST_NAME> <EMAIL_ADDRESS>" is unknown trust``.

   .. code-block:: sh

      $ sudo pacman-key --init
      $ sudo pacman-key --lsign-key <GPG_KEY_ID>

**Build and Sign Packages**

-  Configure ``makepkg`` to sign packages by default.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/makepkg.conf
      BUILDENV=(!distcc color !ccache check sign)
      PACKAGER="<FIRST_NAME> <LAST_NAME> <EMAIL_ADDRESS>"
      GPGKEY="<GPG_KEY_ID>"

-  Or manually run ``makepkg --sign --key <GPG_KEY_ID>``.

-  Force the repository metadata to be updated to use the GPG key. [37][38][39]

   .. code-block:: sh

      $ repo-add --verify --sign <PKGBUILD_REPOSITORY_NAME>.db.tar.gz ./*.pkg*

**Sign Existing Packages**

-  Create a detached GPG signature. This command only works for a single package at a time. Pacman requires using no armor for the GPG signing which creates a binary ``*.sig`` file. Using armor plaintext ``*.asc`` signatures is not supported.

   .. code-block:: sh

      $ gpg --detach-sign --no-armor <PACKAGE>

-  Force the repository metadata to be updated to use the GPG key. [40]

   .. code-block:: sh

      $ repo-add --verify --sign <PKGBUILD_REPOSITORY_NAME>.db.tar.gz ./*.pkg*

**Verify the GPG Key Works** [38]

-  By default, Pacman requries that packages need to be signed with a GPG key but the databse does not.

   .. code-block:: ini

      SigLevel = Required DatabaseOptional

-  Require the database to also be signed.

   .. code-block:: ini

      [<PKGBUILD_REPOSITORY_NAME>]
      SigLevel = Required

-  Require a GPG key but do not check if it is authentic or expired.

   .. code-block:: ini

      [<PKGBUILD_REPOSITORY_NAME>]
      SigLevel = Required DatabaseOptional TrustAll

AUR Submission
~~~~~~~~~~~~~~

The Arch Linux User (AUR) repository allows developers to easily upload their own packages. Here are the steps on how to submit a new package to the AUR.

**SSH Key Pair**

Create a unique SSH key pair to use for interacting with the AUR.

.. code-block:: sh

   $ ssh-keygen -t ed25519 -b 4096 -f ~/.ssh/aur
   $ vim ~/.ssh/config
   Host aur.archlinux.org
     IdentityFile ~/.ssh/aur
     User aur

**Create the AUR Git Repository**

Clone a repository with the desired AUR package name. Once files are committed and pushed, this package will be instantly available on the AUR.

.. code-block:: sh

   $ git clone ssh://aur@aur.archlinux.org/<NEW_AUR_PACKAGE_NAME>.git

**Files**

Every AUR git repository needs to contain at least 2 files:

-  PKGBUILD = The PKGBUILD explains how to download and build the source code.
-  .SRCINFO = Information about what packages the PKGBUILD will provide. Generate this by running ``makepkg --printsrcinfo > .SRCINFO``.

    -  Every time the PKGBUILD metadata has been updated, this file needs to be regenerated and committed to the git repository.

Optional files:

-  .gitignore = Ignore build files and directories such as ``pkg`` and ``src``.
-  LICENSE = The license for the PKGBUILD. This is generally the same as the software that it builds.

There should not be any binary or source code hosted in the AUR git repository.

[13]

Troubleshooting
~~~~~~~~~~~~~~~

Error when trying to build a signed PKGBUILD:

.. code-block:: sh

   $ makepkg --sign --key <GPG_KEY_ID>
   ==> ERROR: The key <GPG_KEY_ID> does not exist in your keyring.

Solution:

-  The GPG key exists for a different user. [35] Export the private GPG key and then import it as a different user. [43]

   .. code-block:: sh

      $ gpg --list-secret-keys
      $ gpg --export-secret-keys <GPG_KEY_ID> > /tmp/gpg-private.key
      $ chown <OTHER_USER> /tmp/gpg-private.key
      $ su - <OTHER_USER>
      $ gpg --import /tmp/gpg-private.key
      $ rm -f /tmp/gpg-private.key

----

Permission errors when running commands that require entering a password to unlock the private GPG key:

.. code-block:: sh

   $ gpg --import <GPG_KEY_FILE>.asc
   gpg: key 1c424e039f4444af: "<FIRST_NAME> <LAST_NAME> <EMAIL_ADDRESS>" not changed
   gpg: key 1c424e039f4444af/bec914517aa203f3: error sending to agent: Permission denied
   gpg: key 1c424e039f4444af/bec914517aa203f3: error sending to agent: Permission denied
   gpg: error reading '<GPG_KEY_FILE>.asc': Permission denied
   gpg: import from '<GPG_KEY_FILE>.asc' failed: Permission denied
   gpg: Total number processed: 0
   gpg:              unchanged: 1
   gpg:       secret keys read: 1

Solutions:

-  GPG needs to be able to access the TTY to get standard input for the GPG key password. The easiest way to do this is to start a ``screen`` or ``tmux`` session. Then run the ``gpg --import`` command again. [44]
-  Pass the password to the GPG command by using standard input. [45]

   .. code-block:: sh

      $ echo "<PASSWORD>" | gpg --import --passphrase-fd 0 <GPG_KEY_FILE>.asc

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/packaging.rst>`__
-  `< 2019.07.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/administration/packages.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/packages.rst>`__
-  `< 2018.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/markdown/packages.md>`__

Bibliography
------------

1. "Chapter 7 - Basics of the Debian package management system." The Debian GNU/Linux FAQ. August 28, 2016. Accessed March 25, 2017. https://www.debian.org/doc/manuals/debian-faq/ch-pkg\_basics.en.html
2. "hello-debian README.md." streadway/hello-debian GitHub. March 24, 2014. Accessed May 8, 2017. https://github.com/streadway/hello-debian
3. "Chapter 4. Required files under the debian directory." Debian New Maintainers' Guide. February 25, 2017. Accessed March 24, 2017. https://www.debian.org/doc/manuals/maint-guide/dreq.en.html
4. "How to create an RPM package." Fedora Project. June 22, 2016. Accessed June 28, 2016. http://fedoraproject.org/wiki/How\_to\_create\_an\_RPM\_package
5. "Creating RPM packages." Fedora Docs Site. May 16, 2020. Accessed May 16, 2020. https://docs.fedoraproject.org/en-US/quick-docs/creating-rpm-packages/index.html
6. "Packaging:RPMMacros." Fedora Project Wiki. December 1, 2016. Accessed March 13, 2017. https://fedoraproject.org/wiki/Packaging:RPMMacros?rd=Packaging/RPMMacros
7. "Packaging: Users and Groups" Fedora Project. September 14, 2016. Accessed February 25, 2017. https://fedoraproject.org/wiki/Packaging:UsersAndGroups
8. "How to Create and Use Patch Files for RPM Packages." Bob Cromwell. March 20, 2017. Accessed March 20, 2017. http://cromwell-intl.com/linux/rpm-patch.html
9. "PKGBUILD." Arch Linux Wiki. October 26, 2016. Accessed November 19, 2016. https://wiki.archlinux.org/index.php/PKGBUILD
10. "Creating packages." Arch Linux Wiki. July 30, 2016. Accessed November 19, 2016. https://wiki.archlinux.org/index.php/creating\_packages
11. "PKGBUILD(5) Manual Page." Arch Linux Man Pages. February 26, 2016. Accessed November 19, 2016. https://www.archlinux.org/pacman/PKGBUILD.5.html
12. "RPM spec patch application fails." Stack Overflow. August 22, 2016. Accessed March 27, 2020. https://stackoverflow.com/questions/39052950/rpm-spec-patch-application-fails
13. "AUR submission guidelines." Arch Linux Wiki. February 20, 2022. Accessed April 5, 2022. https://wiki.archlinux.org/title/AUR_submission_guidelines
14. "Using the %autochangelog Macro." rpmautospec. 2021. Accessed April 12, 2023. https://docs.pagure.org/Fedora-Infra.rpmautospec/autochangelog.html
15. "RPM Spec file %setup macro when you don't know the root name?" Unix & Linux Stack Exchange. April 2, 2020. Accessed April 12, 2023. https://unix.stackexchange.com/questions/577441/rpm-spec-file-setup-macro-when-you-dont-know-the-root-name
16. "How do I get rpmbuild to download all of the sources for a particular .spec?" Stack Overflow  April 25, 2020. Accessed April 12, 2023. https://stackoverflow.com/questions/33177450/how-do-i-get-rpmbuild-to-download-all-of-the-sources-for-a-particular-spec
17. "Building RPM packages with mock." packagecloud. May 10, 2015. Accessed April 12, 2023. https://blog.packagecloud.io/building-rpm-packages-with-mock/
18. "Building a custom kernel." Fedora Project Wiki. August 16, 2022. Accessed April 12, 2023. https://fedoraproject.org/wiki/Building_a_custom_kernel
19. "rpmbuild: better react on lookaside cache failure? #391." GitHub fedora-copr/copr. January 10, 2023. Accessed May 5, 2023. https://github.com/fedora-copr/copr/issues/391
20. "COPR fedoraproject.org builder refuses to download sources specified in my .spec file." Stack Overflow. October 4, 2022. Accessed May 5, 2023. https://stackoverflow.com/questions/71805959/copr-fedoraproject-org-builder-refuses-to-download-sources-specified-in-my-spec
21. "User Documentation." Copr Buildsystem. Accessed May 5, 2023. https://docs.pagure.org/copr.copr/user_documentation.html
22. "Copr command line interface." Fedora Developer Portal. Accessed May 5, 2023. https://developer.fedoraproject.org/deployment/copr/copr-cli.html
23. "Using the DNF software package manager." Fedora Documentation. October 15, 2022. Accessed May 5, 2023. https://docs.fedoraproject.org/en-US/quick-docs/dnf/
24. "systemd.preset." systemd. Accessed May 16, 2023. https://www.freedesktop.org/software/systemd/man/systemd.preset.html
25. "RPM Packaging Guide." RPM Packaging Guide. February 20, 2023. Accessed May 16, 2023. https://rpm-packaging-guide.github.io/
26. "Packaging:Systemd." Fedora Project Wiki. January 25, 2018. Accssed May 16, 2023. https://fedoraproject.org/wiki/Packaging:Systemd
27. "SourcesList." Debian Wiki. March 22, 2017. Accessed March 28, 2017. https://wiki.debian.org/SourcesList
28. "createrepo/rpm metadata." createrepo. Accessed June 28 2016. http://createrepo.baseurl.org/
29. "createrepo(8) - Linux man page." Die. Accessed June 28, 2016. http://linux.die.net/man/8/createrepo
30. "#11 fedpkg should allow adding options to rpmbuild command line." Pagure.io. May 11, 2018. Accessed July 28, 2023. https://pagure.io/fedpkg/issue/11
31. "How to export and import keys with GPG." Linux Hint. 2021. Accessed August 14, 2023. https://linuxhint.com/export-import-keys-with-gpg/
32. "Signing and Creating a Repository for RPM Packages." CDOT Wiki. July 17, 2017. Accessed August 14, 2023. https://hussainaliakbar.github.io/signing-and-verifying-rpm-packages/
33. "Signing and Verifying RPM Packages." Hussain Ali Akbar. April 25, 2018. Accessed August 14, 2023. https://wiki.cdot.senecacollege.ca/wiki/Signing_and_Creating_a_Repository_for_RPM_Packages
34. "Creating and hosting your own rpm packages and yum repo." Earthly. June 24, 2021. Accessed August 14, 2023. https://earthly.dev/blog/creating-and-hosting-your-own-rpm-packages-and-yum-repo/
35. "SOLVED: makepkg fails at signing package." Arch Linux Forums. May 25, 2012. Accessed August 16, 2023. https://bbs.archlinux.org/viewtopic.php?id=142128
36. "pacman-key Command Examples." The Geek Diary. Accessed August 16, 2023. https://www.thegeekdiary.com/pacman-key-command-examples/
37. "DeveloperWiki:Package signing." ArchWiki. September 25, 2022. Accessed August, 2023. https://wiki.archlinux.org/title/DeveloperWiki:Package_signing
38. "pacman/Package signing." ArchWiki. August 13, 2023. Accessed August 19, 2023. https://wiki.archlinux.org/title/Pacman/Package_signing
39. "Pacman Package Signing – 1: Makepkg and Repo-add." Allan McRae. August 7, 2011. Accessed August 16, 2023. http://allanmcrae.com/2011/08/pacman-package-signing-1-makepkg-and-repo-add/
40. "pacman-sign-guide." GitHub Gist elieux/guide.md. October 4, 2015. Accessed August 16, 2023. https://gist.github.com/elieux/fad9451bbfc4ddb5cde7
41. "Create Personal Arch Linux Package Repository via GitHub Pages." sainnhe's blog. February 23, 2021. Accessed August 19, 2023. https://www.sainnhe.dev/post/create-personal-arch-linux-package-repository/
42. "Create a key to sign your packages." ArcoLinuxIso. September 11, 2020. Accessed August 19, 2023. https://www.arcolinuxiso.com/create-a-key-to-sign-your-packages/
43. "GPG: Extract private key and import on different machine." makandra cards. January 1, 2016. Accessed August 19, 2023. https://makandracards.com/makandra-orga/37763-gpg-extract-private-key-and-import-on-different-machine
44. "Add documentation for configuring GnuPG #33." GitHub. coolacid/docker-misp. November 4, 2022. Accessed August 19, 2023. https://github.com/coolacid/docker-misp/issues/33
45. "How to use Gnupg's passphrase-fd argument?" Stack Overflow. March 26, 2019. Accessed August 19, 2023. https://stackoverflow.com/questions/19895122/how-to-use-gnupgs-passphrase-fd-argument
