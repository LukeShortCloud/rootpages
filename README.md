# Root Pages

Root Pages is a collection of quick and easy-to-reference tutorials, examples, and guides primarily for Linux and other UNIX-like systems. The main goal of this project is to provide a more general purpose alternative to the "info" documents for System Adminstrators and Engineers. Each page is a full guide to each topic making it easy to navigate and search for content.


## Usage

All Root Pages are written in the Markdown language and then compiled into HTML. For the command line there are the standard "elinks" and "lynx" web browsers. Generally Chromium (Chrome) or Ice Weasel (Firefox) will be available on graphical installations of Linux, too.

Install:
```
$ git clone https://github.com/ekultails/rootpages.git
$ cd rootpages/
$ bash build.sh
$ bash install.sh
$ source ~/.bashrc
```

Uninstall:
```
$ bash uninstall.sh
```

Update/reinstall:
```
$ bash reinstall.sh
```

Root Pages is handled by the "rp" utility. It will automatically detect an available CLI web browser. Supply the name of the guide and it will load up in the web browser.

Examples:
```
$ rp --help
Usage:
       	--list 	List the available Root Pages guides
       	[TOPIC]   	View the Root Pages topic
       	--help 	Print out the command usage
$ rp --list
ansible
bootloaders
clustering
c++
dns_servers
file_systems
http_servers
linux
linux_commands
mail_servers
monitoring
networking
nosql
openstack
packages
security
sql
virtualization
$ rp ansible
```

If a specific web browser is prefered, the "rp_browser" variable can be exported with the preferenced browser.

Example:
```
$ export rp_browser="firefox"
```

The "linux_commands" section is currently not supported by the "rp" command. These are HTML files generated from a Google Sheets document that can be manually viewed via a web browser. These are planned to be converted from Google Sheets into Markdown so they can be maintained enitrely through the Root Pages project.


## Development

Root Pages is a rolling release. As new information is commited, it is shortly pushed into master after a quick review for technical writing standards and correct citation usage.

All updates should be added to the Markdown files in the "markdown/" directory of this project. Any markdown editor can be used to contribute to these documents (even GitHub's built-in editor!). These documents are currently in English but translations are always welcome!

A few quick notes about technical documentation:

* Everything should be written in the 3rd person.
* Sentences should be easy-to-read and quick to the point.
* Chicago style citation to sources is REQUIRED.
    * If assistance is requried with the syntax of new citations, check out [Citation Machine](http://www.citationmachine.net/chicago).

All updates should be made in the Markdown files with the ".md" extension. The "pandoc" markdown converter (installable by most common Linux package managers) is used to compile the latest documents into HTML. The "build.sh" Bash script was created to help faciliate that. It will place all of the newly updated HTML files into the "html/" directory.
```
$ bash build.sh
```


## Legal


### License

Root Pages, and all of it's content, is provided under the GNU Free Documentation License (FDL) v1.3. Additional disclaimers related to warranty and liability from the GPLv3 licence are also applied to this project.

Files:

* LICENSE
* DISCLAIMER


### Plagerism

Root Pages strives to provide proper citation to the original authors to give credit where due. If there are any reports of plagerism, please [open a new GitHub issue](https://github.com/ekultails/rootpages/issues) for it to get addressed.
