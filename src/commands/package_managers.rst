Package Managers
================

.. contents:: Table of Contents

See also: Administrative, Shell

Arch Linux
----------

pacman
~~~~~~

The default package manager for Arch Linux that installs binaries from a xz compressed tarball that contains a pacman metadata file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-s", "search"
   "-l", "list"
   "-u", "update"
   "-Q", "query the local pacman database; show installed packages"
   "-Ql", "show files installed by a pkg"
   "-S", "install package"
   "-Ss", "search for a package"
   "-Sy", "system update"
   "-Syyu", "update all packages"
   "-Rns", "remove a package"
   "-Fo", "search for a file in installed packages"
   "-Fs", "search for a file in all repository packages"
   "-Fy", "update the file list database"
   "-w", "download the packages but do not install them"
   "--no-confirm", "automatically accept/confirm actions"

yay
~~~

Package manager for the Arch Linux User (AUR) repository. It automates installing and compiling community-provided source packages. It uses the same command line options as ``pacman``.

paccache
~~~~~~~~

Remove pacman cache.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-d", "run a dry-run by seeing how many files will be removed and space that will be saved"
   "-r", "clean out all of the cache from pacman"

makepkg
~~~~~~~

Build a pacman package using a ``PKGBUILD`` file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-c; --clean", "clean up left over files after a build"
   "-C; --cleanup", "clean up source files before starting a new build"
   "-d; --nodeps", "do not check for dependencies"
   "-i", "install the package after being built"
   "-s", "install missing dependencies using pacman"
   "--skippgpcheck", "skip GPG signed verification"

pkgfile
~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-s", "search for what pkg provides a file from the repositories"
   "--update", "update all of the repository information"

pacman-key
~~~~~~~~~~

Manage PGP keys used for validating package integrity.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--refresh-keys", "update the pacman PGP verification keys"

Debian
------

The default package manager for Debian is the Advanced Package Tool (Apt). It manages DEB package repositories.

apt-get
~~~~~~~

Manage packages from local and remote sources.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "changelog", "show the changelog for a package"
   "autoclean", "remove downloaded DEB files that no longer exist in any repository"
   "clean", "remove downloaded DEB files"
   "install", "installs program"
   "update", "updates repo info"
   "upgrade", "updates all packages"
   "dist-upgrade", "updates the OS to the latest version"
   "autoremove", "remove unused packages"
   "-t", "use a different Debian release to get packages"
   "download", "download the DEB package file"
   "--download-only source", "download the source code"
   "--compile", "compile from source code in repository"
   "-y, --yes", "answers yes to all prompts"
   "-q, --quiet", "suppresses changelog and question prompts"
   "build-dep", "install build dependencies for a package; this requires a source repository to be enabled"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-y -q install make", "automatically install the ""make"" package"

apt-cache
~~~~~~~~~~

Lookup utility based on information gathered from ``apt-get update``.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "search", "look for a package"
   "show", "show package information"
   "showpkg", "show dependencies"

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "search xfce", "search for the ""xfce"" package"

apt-file
~~~~~~~~

Find which remote packages provide a specific file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   update, update the local cache of files each remote package provides
   find, find a package that contains a certain file

dpkg
~~~~

Manage local DEB packages.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-i", "install a local DEB package"
   "--list", "shows all installed .debs"
   "-L", "shows where the package files have been installed to"
   "-c", "lists the files inside of a package"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-i python37.deb", "install a local Python 3.7 DEB package"

apt-mirror
~~~~~~~~~~~

Creates a local repository mirror of another repository. WARNING this will download over 100GB of data by default for Debian.

debootstrap
~~~~~~~~~~~

Create a directory with a Debian based operating system file system.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--arch {amd64|i386}", "select CPU architecture"

dh_make
~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-p <PROGRAM>_<VERSION>", "specify the program and version name"
   "-f", "specify the original source code file to create a org.tar.gz archive from"
   "--createorig", "create an original source tarball from the current directory"
   "--copyright", "specify a license to use for the program"
   "-r {old|dh7|cdbs}", "specify the format for rules to use"

mk-build-deps
~~~~~~~~~~~~~

Package: devscripts

Find and install build dependencies for DEB source packages.

dpkg-buildpackage
~~~~~~~~~~~~~~~~~

Build a DEB package.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-b", "do not build a source package"

snappy
~~~~~~

Snappy manages portable Snap applications.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "info", "show operating system information"
   "install", ""
   "remove", ""
   "update", "update the system or a certain package"
   "rollback", "revert an update to the previous version"
   "search", "search for pkg"
   "list", "show installed pkgs"

Fedora
------

dnf
~~~

Dandified YUM (DNF) is the default package manager for Fedora >= 22. It is designed to use RPM package repositories, be faster than YUM, and rely on Python 3.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "repolist all", "shows all available repositories"
   "list", "shows all packages available"
   "list installed", "shows all installed packages"
   "search", "look for a package to install"
   "install", "install a package"
   "remove", "uninstall a package"
   "autoremove", "remove unneeded dependencies"
   repository-packages <REPO>, manage all packages relating to a certain repository
   repository-packages <REPO> remove, uninstall all packages that came from a specified repository
   "clean all", "removes DNF all cache, including packages"
   "clean packages", "remove cached packages (old, uninstalled, and/or downloaded packages)"
   "clean expire-cache", "set the cache to be expired on the next dnf usage; this allows ""dnf -C"" to still work against cached repository metadata"
   "grouplist", "shows all available groups of packages"
   "update", "update a specific package or all of the packages"
   "builddep", "install RPM dependencies from a spec file"
   "repoquery --deplist", "show package dependencies"
   "config-manager --set-enabled", "permanently enable a repository"
   "config-manager --set-disabled", "permanently disable a repository"
   "config-manager --add-repo <URL>", "add a new repository"
   "--security --sec-severity=Critical update", "only update packages with critical CVE patches"
   "--cacheonly, -C", "use the system cache for queries, do not update the remote metadata information"
   --repo <REPOSITORY_NAME>, temporarily only use the provided repository (disable all others)
   --enablerepo <REPOSITORY_NAME>, temporarily enable a repository if it is disabled
   --disablerepo <REPOSITORY_NAME>, temporarily enable a repository if it is enabled
   module list, list all modular packages along with their related streams and profiles
   module list --enabled, show enabled modular repositories
   module list --installed, list all installed modular repositories
   module install <PACKAGE>:<STREAM>, install a modular package using the default packages
   module install <PACKAGE>:<STREAM>/<PROFILE>, install a modular package using a specific profile of packages
   module info <PACKAGE>, show detailed information about all of the streams and profiles available

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   --enablerepo="*" install fuse-exfat, enable all repositories once for this command execution and install the fuse-exfat package
   module install perl:5.24, install an older supported version of Perl using modularity

yum
~~~

The default package manager for RHEL.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "search", "searches repo for pkgs"
   "list", "show all available packages"
   "list installed", "show installed packages and what repository they came from"
   "list available", "show packages available from repositories"
   "install", "install one or more RPMs"
   "uninstall", "uninstall one or more RPM"
   "check-update", "checks for available updates"
   "update", "updates al packages"
   "deplist", "list all of the files/binaries depdencies required for the RPM"
   "grouplist", "shows all available groups of packages"
   "groupinfo", "shows what packages are a part of the group"
   "groupinstall", "installs a group"
   "autoremove", "remove unused packages"
   "history", "shows yum transactions"
   "history new", "clear out yum's history"
   "history undo <NUMBER>", "under an action from Yum history"
   "repolist all", "show all available repositories"
   "repository-packages <REPONAME> list", "show all packages in a repository"
   "changelog", "show the change log for a package; requires the ""yum-plugin-changelog"""
   "--nogpgcheck", "skip the GPG signing check"
   "--enablerepo=", "enable a repository temporarily, if it's disabled"
   "--disablerepo=", "disable a repository temporarily"
   "--disablerepo=""*"" --enablerepo=", "temporarily disable all the repos except the ones specified to be enabled"
   "--disableexcludes=all", "disable all excluded packages (re-enable them) from the configuration files"
   "-y", "automatically proceed (do not ask for user input)"
   "--releasever=", "this will temporarily interpret the ""releasever"" variable in the repository files as a different operating system version"
   "check", "check for problems between yum and the rpm database"
   "--installroot", "install the package to another directory root that is not /"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "groupinstall ""Web Server""", "install the HTTP web server group of packages"
    "--releasever=7.5", "only install packages compiled on/for the 7.5 release"

rpm
~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-i", "installs local pkg but does not replace it"
   "-U", "installs a package and immediately replaces the older version"
   "-U --oldpackage", "downgrade an RPM"
   "-q", "tells if a package is installed"
   "-qa", "shows all installed packages"
   "-ql", "shows all of the files from the installed package"
   "-qc", "lists configuration files from a package"
   "-qd", "list documentation files from a package"
   "-qi", "shows verbose package information"
   "-qf", "tells what package provides a given file"
   "-qR", "list dependencies"
   "-q --changelog", "shows changelog for a program"
   "-q --whatrequires", "show what packages depend on this package"
   "-p", "query an RPM that is not installed"
   "-e", "remove an RPM"
   "--nodeps", "ignore dependencies"
   "--justdb", "only modify the internal RPM database (do not modify the files installed by the RPM)"
   "-v", "verbose output"
   "-vv", "very verbose output for debugging the rpm program itself"
   "--rebuild", "builds a src.rpm package"
   "--eval %{OPTION}", "replace OPTION; shows details about the global variable to be used in an RPM spec file for building"
   "--root=", "specify the chroot directory to install a package to"

yum-complete-transaction
~~~~~~~~~~~~~~~~~~~~~~~~

Manage incomplete YUM processes. Those transactions are normally stopped from receiving a SIGKILL from an end-user pressing CTRL+c.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "finish installing the last canceled Yum transaction"
   "--cleanup-only", "remove all of the pending Yum transactions"

repoquery
~~~~~~~~~

Package: yum-utils

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--requires --resolves", "check for RPM dependencies of an RPM"
   "-l", "show the files that an RPM from a repository would install"

rpmbuild
~~~~~~~~

Package: rpm-build

Build RPM packages from a RPM spec file.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-ba", "build all (both the binary and source packages)"
   "-bb", "build only the binary package"
   "--define 'el5 1' --define 'el6 0'", "build a package for RHEL 5 and not 6"
   "--rebuild", "rebuild a source RPM, even if a compiled RPM already exists"

yum-builddep
~~~~~~~~~~~~

Package: yum-utils

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<SPEC_FILE>", "install the dependencies to build the source and binary RPM"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "nginx.spec", "install the dependencies for the NGINX RPM"

yumdownloader
~~~~~~~~~~~~~

Package: yum-utils

Download RPMs from a YUM repository.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --resolve, also download all of the dependency RPMs

centos-upgrade-tool-cli
~~~~~~~~~~~~~~~~~~~~~~~

Upgrade utility for CentOS 6 to 7 migrations.

fedup
~~~~~

Upgrade utility for Fedora for going to the next major version.

createrepo
~~~~~~~~~~

Create and manage a RPM repository from an existing folder.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "create an RPM repository in the specified directory"
   "--update", "update the repository cache containing all of the RPM information"
   "-s, --checksum", "specify the checksum algorithm; older RHEL <= 5 repos require ""sha"" for sha1"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "--update 7/x86_64/", "create an Enterprise Linux 7 64-bit repository"

subscription-manager
~~~~~~~~~~~~~~~~~~~~

This utility handles subscriptions to private Red Hat software repositories.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--username <USER> --password <PASS>", "provide RedHat.com credentials"
   --register --auto-attach, attempt to guess what subscription should be used
   --register --force, override the current subscription registration
   "list", "list current subscription details"
   "list --available", "show all available subscriptions"
   "register", "register with a specific subscription"
   "repo --list", "show all Red Hat repositories"
   "repos --list-enabled", "show enabled repositories"
   "repos --enable", "enable a repository"
   "repos --disable", "disable a repository"
   release --set <RHEL_VERSION>, set the RHEL version of packages to use

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   release --set 7.6, configure the RHEL 7.6 repositories

subscription-manager-gui
~~~~~~~~~~~~~~~~~~~~~~~~

GUI for managing Red Hat subscriptions.

scl
~~~

Package:

-  CentOS: centos-release-scl
-  RHEL: rhel-server-rhscl-7-rpms

The software collections suite (SCL) offers newer versions of major software. These are installed using YUM and can be found in the custom prefix ``/opt/rh/``.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "enable", "switch to using a different version of a software from the SCL"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "enable python36", "enable the Python 3.6 environment for use"

mock
~~~~

Cross compile RPMs for different RHEL based distributions and architectures.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-r", "specify the OS configuration file to use from /etc/mock/"
   "--init", "initialize a new chroot directory in /var/lib/mock/ for building the RPM"
   "--clean", "delete the initialized directory"
   "--buildsrpm --spec <SPEC_FILE> --sources <SOURCE_DIR>", "build a source RPM based on a SPEC file and source directory"
   "--rebuild", "rebuild a source RPM"
   "--yum-cmd", "run Yum commands in the chroot environment"
   "--dnf-cmd", ""
   "--shell /bin/bash", "open an interactive Bash shell in the chroot environment"
   "--postinstall", "install the RPM into the chroot after building it"
   "--scm-enable --scm-option method='git'", "use the SCM ""git"" for downloading a project for building"
   "--scm-option spec=<SPEC_FILE>", "use a specific spec file from a SCM project"
   "--scm-option branch=<BRANCH>", "the branch to checkout from a SCHM project"

package-cleanup
~~~~~~~~~~~~~~~

Package: yum-utils

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--oldkernels", "remove all old kernel packages"

dnf system-uprade
~~~~~~~~~~~~~~~~~

Package: dnf-plugin-system-upgrade

Preform major Fedora upgrades

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--releasever", "target a specific major release version"
   "download", "download all of the RPMs to allow for an offline upgrade"

ostree
~~~~~~

Manage an ostree file system.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   admin pin <INDEX>, pin a certain index so that it will not be deleted/consolidated
   admin pin --unpin <INDEX>, unpin an index so it can be deleted/consolidated

rpm-ostree
~~~~~~~~~~

The default package manager for Fedora Silverblue. All updates require a system reboot.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   install <RPM>, install a RPM
   uninstall <RPM>, uninstall a RPM
   update, an alias for upgrade
   upgrade, update the base OS and any RPMs that are installed
   upgrade --check, check for updates
   override replace <RPM>, install a RPM that replaces a base image package
   override remove <RPM>, uninstall a RPM from the base image
   overridden reset <RPM>, uninstall the overridden RPM and install the base image package again
   status, show the commits of ostree
   deploy <COMMIT>, revert to an older version of the OS
   rollback, change the boot entry to boot from the last OS version
   rebase <REMOTE>:<BRANCH>, change or upgrade the base OS
   kargs --append=<CMDLINE_OPTION>, append GRUB's boot options for the kernel
   kargs --delete=<CMDLINE_OPTION, remove a boot option for the kernel
   kargs --replace=<KEY>=<OLD_VALUE>=<NEW_VALUE>, replace the value for an existing key
   kargs --editor, interactively edit the boot options for the kernel
   ex, use experimental features
   ex livefs --i-like-danger, layer the pending deployment changes to avoid a reboot

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   kargs --apend=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1, disable the proprietary Nvidia driver on boot
   rebase fedora/rawhide/x86_64/silverblue, switch the base OS to the rawhide (development) branch of Fedora
   rebase fedora-workstation:fedora/30/x86_64/silverblue, switch the base OS to Fedora 30

Flatpak
-------

flatpak
~~~~~~~

Flatpak is a universal package manager that works on most Linux operating systems by providing a standardized runtime environment.


.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   search <PACKAGE>, look for an installable package
   install, install a package
   install <REMOTE> <NAME>, install a package from a specific remote repository
   uninstall, uninstall a package
   uninstall --unused, uninstall unused runtimes
   update, update all Flatpaks
   update <PACKAGE>, update a specific package
   remotes, list all of the repositories
   remote-add <NAME> <URL>, add a new repository
   remote-delete <NAME>, delete a repository
   remote-ls <NAME>, view all fo the packages from a repository
   list, list all of the installed flatpaks
   run <NAME>, run a flatpak
   run --command=bash <NAME>, open a Bash shell in the flatpak for troubleshooting issues

FreeBSD
-------

pkg
~~~

The default package manager for FreeBSD >= 10.0.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "install", "install a package"
   "remove", "uninstall a package"
   "upgrade", "update the operating system"
   "search", "look for available packages"
   "info", "show installed packages"

freebsd-update
~~~~~~~~~~~~~~

FreeBSD upgrade utility.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "fetch", "update repository data"
   "install", "install the latest security patches"
   "rollback", "undo the security patch upgrades"
   "-r <RELEASE> upgrade", "upgrade to the specified operating system version"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-r 10.2-RELEASE upgrade", "upgrade to FreeBSD 10.2"

openSUSE
--------

zypper
~~~~~~

The default package manager for openSUSE to install packages from RPM repositories.

Package: zypper2

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "addrepo, ar <URL> <NAME>", download and add a new repository from a repo file
   dup --allow-vendor-change, switch the repository that existing packages come from and update them
   "install, in", "install a package"
   "repos", "list all available repositories"
   refresh, download the latest metadata from all enabled repositories
   "search --provides --match-exact", "search for a package that contains a certain file"
   "search", "search for available packages"

Programming Languages
---------------------

Many programming languages also provide official package managers to manage application dependency.

Python
~~~~~~

pip
'''

Python package manager.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "{list|freeze}", "shows installed packages"
   "search", "look for a package from the pip repository"
   "show", "show installed package details"
   "install", "install a package"
   "install -U", "update a package"
   "install --pre", "install an unstable pre-release of a software"
   "install <PKG>==<MAJOR>.<MINOR>.*", "install the latest patch version of a software"
   "install <PKG>==", "show all available package versions"
   "install <PKG>==<VERSION>", "install the specified version of a package"
   "install -r requirementx.txt", "install dependencies for a package"
   "install --force-reinstall", "reinstall a package"
   "uninstall", "remove an installed package"
   "-E <VIRTUALENV_DIR>", "run tasks on a virtual environment"
   "TMPDIR=<DIR>", "set this as an environment variable) use a different directory, other than /tmp, for building Pip packages"
   "--user", "install or remove Python packages for the current user from ~/.local"

python setup.py
'''''''''''''''

Manually install a Python package from its source code.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   --help-commands, show all of the available subcommands
   --help, show help information only for the main command
   develop, install the dependencies only and use the library in its existing location (do not fully install it)
   install, install the package to the system
   install --prefix=/usr, change the installation prefix
   register, register a new Python package with PyPi
   upload, upload the new Python package to PyPi
   upload --sign, sign and upload the new Python package to PyPi
   --build, build the package in the "build" directory

virtualenv (python3 -m virtualenv)
''''''''''''''''''''''''''''''''''

Create and manage isolated Python environments.

Activate: ``$ . <VIRTUALENV_PATH>/bin/activate``
Deactivate: ``$ deactivate``

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<PATH>", "create a new Python virtual environment"
   "--python=<PYTHON_BINARY>", "specify the Python version to use"
   "--system-site-packages", "link to existing system packages in a read-only manner"

uncompyle6
''''''''''

Decompile Python bytecode into human readable code.

Ruby
~~~~

gem
~~~

Ruby-language package manager

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-l", "query local packages; this is the default"
   "-r", "query remote packages"
   "dependency -r", "search for the dependencies of a package"
   "<PACKAGE> -v <VERSION>", "install a specific version of a Gem package"

fpm
---

The Effing Package Manager is an easy user-focused universal package manager. 

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--name", "package name"
   "--verison", "application version"
   "--iteration", "package version/release"
   "-a", "the CPU architecture that the application can run on"
   "--description", "the description of the application"
   "--license", "the name of the license that the application uses"
   "--depends", "package dependencies of the application"
   "--replaces", "packages that this package will replace"
   "--conflicts", "packages that this package conflicts with"
   "-s", "the source to use for building a new package"
   "-t", "the target package to create or convert to"
   "-C", "change to the source directory before building the package"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-s dir -t rpm ~/myapp/ --name hello-world --version 2.1.5 --iteration 1","create a package from myapp and mark the software release as version 2.1.5 and the package release verison as 1"

Source Code
-----------

This utilities assist with building software from the source code.

./configure
~~~~~~~~~~~

The ``configure`` script defines how to compile a program.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--prefix=", "new installation directory"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "--prefix=/opt/python27", "set a custom directory to install Python to before compiling it"

make
~~~~

Build and install software using a provided ``Makefile``.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-j <PROCESSES>", "spawn the specified number of child <PROCESSES> child processes for more efficient and faster compiling; recommended to use the number of CPU threads on the system"
   "-mtune=native", "compiles the code specifically for your CPU, making programs more efficient and faster"
   "k, --keep-going", disregard errors and keep compiling until a fatal error occurs
   "clean", "remove previously compiled source code"
   "dist", "build a tarball that can be used for building an RPM"
   "test", "run tests to verify that the software was created successfully"
   "install", "copy the program to the file system"
   "install --backup", "backup original files if they exist"

gcc
~~~

GNU C compiler.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-std=c{90|99|11}", "compile using a ANSI C standard, based on the year it was released"
   "-march=native", "compile the code against the current processor's ABIs for the fastest performance; the binary will not be portable to other systems"
   -Werror, all warnings will be treated as errors so a build will fail if there is a warning

g++
~~~

GNU C++ compiler.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-std=c++{98|03|11|14|17}", "compile using a ANSI C++ standard, based on the year it was released"

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/commands/package_managers.rst>`__
-  `< 2019.01.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_commands/package_managers.rst>`__
