# Packages
* [RPM (RHEL)](#rpm-rhel)
  * [Creating an RPM](#rpm-rhel-creating)
    * [Overview](#rpm-rhel-creating-overview)
    * [](#rpm-rhel-creating-options)
* [DEB (Debian)](#deb-debian)
* [PKGBUILD (Arch)](#arch-pkgbuild)

## DEB (Debian) <a name="deb-debian"></a>
## RPM (RHEL) <a name="rpm-rhel"></a>
### RPM (RHEL) - Creating an RPM <a name="rpm-rhel-creating"></a>
#### RPM (RHEL) - Creating an RPM - Overview <a name="rpm-rhel-creating-overview"></a>
Create a SPEC file. This file contains all of the information about the program and on how to install and uninstall it. It is used to build the RPM.
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
http://fedoraproject.org/wiki/How_to_create_an_RPM_package
## PKGBUILD (Arch) <a name="arch-pkgbuild"></a>