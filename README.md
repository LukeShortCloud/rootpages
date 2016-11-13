# Root Pages

Root Pages is a collection of quick and easy-to-reference tutorials, examples, and guides primarily for Linux and other UNIX-like systems. The main goal of this project is to provide an expanded alternative to "info" and/or "man" pages.


## Usage

All Root Pages are written in the Markdown language and then compiled into HTML. For the command line there are the standard "elinks" and "lynx" web browsers. Generally Chromium (Chrome) or Ice Weasel (Firefox) will be available on graphical installations of Linux, too.

Install:
```
$ git clone https://github.com/ekultails/rootpages.git
$ cd rootpages/
$ bash install.sh
$ source ~/.bashrc
```

Uninstall:
```
$ bash uninstall.sh
```

Root Pages is handled by the "rp" utility. It will automatically detected which CLI web browser is installed. Supply the name of the guide and it will load up in the web browser.

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
dns_servers
file_systems
http_servers
mail_servers
monitoring
nosql
openstack
packages
security
sql
$ rp ansible.html
```

If a specific web browser is prefered, the "rp_browser" variable can be exported with the preferenced browser.

Example:
```
$ export rp_browser="firefox"
```

The only file that is not HTML or viewable via the "rp" command is currently the "linux_commands.xlsx" Excel spreadsheet. It is not formatted in CSV or TSV due to the unique styling that it uses to help organize different sections. A lot of good command line references can be found here.


## Development

Root Pages is a rolling release. As new information is commited, it is shortly pushed into master after a quick review for technical writing standards and correct citation usage.

All updates should be added to the Markdown files in the "markdown/" directory of this project. The recommended Markdown editor to use is [Haroopad](http://pad.haroopress.com/user.html). This is due to it's minimalist design, strong webpage support, cross platform nature, and the free price tag. Of course, any markdown editor can be used to contribute to these documents (even GitHub's!). These documents are currently in English but translations are always welcome!

A few quick notes about technical documentation:

* Everything should be written in the 3rd person.
* Sentences should be easy-to-read and quick to the point.
* Chicago style citation to sources is REQUIRED.
    * If assistance is requried with the syntax of new citations, check out [Citation Machine](http://www.citationmachine.net/chicago).

All updates should be made in the Markdown files with the ".md" extension. The "pandoc" markdown converter (installable by most common Linux package managers) is used to compile the latest documents into HTML. The "build.sh" Bash script was created to help faciliate that. It will place all of the newly updated HTML files into the "html/" directory. After any changes were made to the Markdown files, this should be run:
```
$ bash build.sh
```

Once the HTML files have finished generating, commit the changes and submit a pull request.


## Legal


### License - GPLv3

Root Pages and all of its content is provided under the GPLv3. Why? We believe that all information should be free information. Knowledge is power and we strongly believe that everyone deserves to learn and grow to their fullest potentional.


### Plagerism

Root Pages strives to provide proper citation to the original authors to give credit where due. If there are any reports of plagerism, please send an e-mail to ```ekultails``` ```at``` ```gmail.com``` to ensure it gets addressed accordingly.
