# Packages
* [RPM (RHEL)](#rpm-rhel)
  * [Creating an RPM](#creating-an-rpm)
* [DEB (Debian)](#deb-debian)
* [PKGBUILD (Arch)](#arch-pkgbuild)

## DEB (Debian) <a name="deb-debian"></a>
## RPM (RHEL) <a name="rpm-rhel"></a>
### Creating an RPM
Create a SPEC file. This file contains all of the information about the program and on how to install and uninstall it. It is used to build the RPM.
The most common options are: 
* Name = The name of the program.
* Version = The version of the package. Typically this is in the format of X.Y.Z (major.minor.bugfix) or ISO date format (for example, "2016-01-01").
* Release = Start with "1%{?dist}" for the first build of the RPM. Increase the number if the package is ever rebuilt. Start from "1%{?dist}" if a new version of the actual program is being built.
* Summary = One sentence describing the package. A period is not allowed at the end.
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
Sources:
http://fedoraproject.org/wiki/How_to_create_an_RPM_package
## PKGBUILD (Arch) <a name="arch-pkgbuild"></a>