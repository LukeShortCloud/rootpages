# Packages
* [DEB - Debian](#deb---debian)
* [RPM - RHEL](#rpm---rhel)
  * [Adding a Repository](#rpm---adding-a-repository)
  * [Creating a Repository](#rpm---creating-a-repository)
  * [Creating an RPM](#rpm---creating-an-rpm)
* [PKGBUILD - Arch](#pkgbuild---arch)

## DEB - Debian
## RPM - RHEL
### RPM - Adding a Repository
Repositories (someitmes called "repos") are a central location where packages can easily be found and installed from.

On Red Hat based systems, the repositories are all defined as text files with the ".repo" extension in this directory.
```
# ls /etc/yum.repos.d/
```

Here are some common options for repository files:
* [] = This should be the first part of a repository, with the name being inside the brackets.
* name = This should be similar to the name from the brackets. However, this friendly name can be different and is usually ignored.
* baseurl = The location of the repository. Valid location types include "http://", "ftp://", and "file://" for using the local file system.
* mirrorlist = Instead of a baseurl, a link to a list of repository mirrors can be given.
* enabled = Enable or disable a repository with a "1" or "0". The default is value is "1". [1]
* gpgcheck = Force a GPG encryption check against signed packages. Enable or disable with a "1" or "0".
* gpgkey = Specify the path to the GPG key.

Variables for repository files:
* $releasever = The RHEL release version. This is typically the major operating system versioning number such as "5" or "6".
* $basearch = The CPU architecture. For most modern PCs this is typically either automatically filled in as "x86_64" for 64-bit operating systems or "i386" for 32-bit. [2]

At the bare minimum, a repository file needs to include a name and a baseurl.
```
[example-repo]
name=example-repo
baseurl=file:///var/www/html/example-repo/
```

Here is an example repository file for the official CentOS 7 repository using a mirrorlist.
```
[base]
name=CentOS-$releasever - Base
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
```

Source:

1. "Fedora 24 System Administrator's Guide" Fedora Documentation. 2016. Accessed June 28, 2016. https://docs.fedoraproject.org/en-US/Fedora/24/html/System_Administrators_Guide/sec-Setting_repository_Options.html
2. "yum.conf - Configuration file for yum(8)." Die. Accessed June 28, 2016. http://linux.die.net/man/5/yum.conf

### RPM - Creating a Repository

Any directory can be used as a repository to host RPMs. The standard naming convention used for RHEL based operating systems is "centos/$releasever/$basearch/" where $releasever is the release version and $basearch is the CPU architecture. However, any directory can be used.

In this example, a default Apache web server will have the repository access via the URL "http://localhost/centos/7/x86_64/." Be sure to place your RPMs in this directory. [1]
```
# yum install createrepo
# mkdir -p /var/www/html/centos/7/x86_64/
```
```
# createrepo /var/www/html/centos/7/x86_64/
```

The "createrepo" command will create 4 or 5 files.
* repomd.xml = An index for the other repository metadata files.
* primary.xml = Contains metadata for all packages including the name, version, architecture, file sizes, checksums, dependencies, etc.
* filelists.xml = Contains the full listing of every directory and file.
* other.xml = Holds a changelog of all the packages.
* groups.xml = If a repository has a "group" that should install multiple packages, the group is specified here. By default, this file is not created when running "createrepo" without any arguments. [2]

If new packages are added and/or signed via a GPG key then the repository cache needs to be updated again. [1]
```
# createrepo --update /var/www/html/centos/7/x86_64/
```

Source:

1. "createrepo(8) - Linux man page." Die. Accessed June 28, 2016. http://linux.die.net/man/8/createrepo
2. "createrepo/rpm metadata." createrepo. Accessed June 28 2016. http://createrepo.baseurl.org/

### RPM - Creating an RPM

Create a SPEC file. This modified shell script contains all of the information about the program and on how to install and uninstall it. It is used to build the RPM.
The most common options are:
* Name = The name of the program.
* Version = The version of the package. Typically this is in the format of X.Y.Z (major.minor.bugfix) or ISO date format (for example, "2016-01-01").
* Release = Start with "1%{?dist}" for the first build of the RPM. Increase the number if the package is ever rebuilt. Start from "1%{?dist}" if a new version of the actual program is being built.
* Summary = One sentence describing the package. A period is not allowed at the end.
* BuildRoot = The directory that contains all of the RPM packages. The directory structure under here should mirror the files location in relation to the top-level root "/". For example, "/bin/bash" would be placed under "$RPM_BUILD_ROOT/bin/bash".
* BuildArch = The architecture that the program is meant to run on. This is generally either "x86_64" or "i386". If the code is not dependent on the CPU (for example, Java or bash scripts) then "noarch" can be used.
* Requires = List the RPM packages that are dependencies needed for your program to work.
* License = The license of the program.
* URL = A URL link to the program's or, if that is not available, the developer's website.

Sample SPEC file:
```
Name: My First RPM
Version: 1.0.0
Release: 1%{?dist}
Summary: This is my first RPM
License: GPLv3
URL: http://example.tld/
```
If you want to build the RPM, simply run:
```
# rpmbuild -bb <SPECFILE>.spec
```
In case you also want to build a source RPM (SRPM) run:
```
# rpmbuild -ba <SPECFILE>.spec
```

Source:

1. "How to create an RPM package." Fedora Project. June 22, 2016. Accessed June 28, 2016. http://fedoraproject.org/wiki/How_to_create_an_RPM_package

## PKGBUILD - Arch