# Root Pages

[![Build Status](https://github.com/LukeShortCloud/rootpages/actions/workflows/main.yaml/badge.svg)](https://github.com/LukeShortCloud/rootpages/actions/workflows/main.yaml)

Root Pages is a collection of quick and easy-to-reference tutorials, examples, and guides primarily for Linux and other UNIX-like systems. The main goal of this project is to provide a more general purpose alternative to the "info" documents for System Administrators, Engineers, and Architects. Each page is a full guide to each topic. This makes it easy to navigate and search for content.

All Root Pages are written in the reStructuredText (RST) markup language. Sphinx is used for building the documentation into ePub, HTML, PDF, and other common document formats.

## Website

* Stable updates: https://rootpages.lukeshort.cloud/
* Latest development updates: https://rootpages.lukeshort.cloud/latest/

All commits to Root Pages are automatically tested via a GitHub Actions workflow. The latest successful build of the "main" branch is pushed to a Kubernetes cluster. Tags are published and a "stable" branch is updated quarterly.

## Install

Sphinx is a Python package that is required to compile Root Pages into different document formats. It is provided by most operating systems' package manager. The official installation guide can be found [here](http://www.sphinx-doc.org/en/stable/install.html).

Arch Linux:

```
$ sudo pacman -S make python-sphinx python-sphinx_rtd_theme
```

Debian:

```
$ sudo apt-get install make python3-sphinx python3-sphinx-rtd-theme
```

Fedora:

```
$ sudo dnf install make python3-sphinx python3-sphinx_rtd_theme
```

macOS:

```
$ brew install python3
$ pip3 install -U sphinx sphinx-rtd-theme
$ export PYTHON_VERSION="3.9"
$ export PATH="$PATH:${HOME}/Library/Python/${PTYHON_VERSION}/bin/"
```

openSUSE:

```
$ sudo zypper install python3-Sphinx python3-sphinx_rtd_theme
```

Some operating systems will install the `sphinx-build` binary with a different suffix to indicate that it is using Python 3. For ease of use, consider symlinking that to be `sphinx-build`.

```
$ sudo ln -s /usr/bin/sphinx-build-3* /usr/local/bin/sphinx-build
```

## Usage

Sphinx will save newly generated documents into the "build/" directory by default.

### Usage - Automatic

ePub:
```
$ make epub
```

HTML:
```
$ make html
```

HTML via the Docker Engine (all operating systems):

```
$ docker run --rm -v ${PWD}:/docs sphinxdoc/sphinx /bin/sh -c 'pip install sphinx_rtd_theme && make html'
```

PDF:
```
$ make latexpdf
```

Text:
```
$ make text
```

### Usage - Manual

The "sphinx-build" command is more flexible by being able to add additional command-line arguments to it. It also does not require the "make" system package to be able to process and execute the Makefile.

Specify the format that the reStructuredText should be transformed and output into, and both the source and build directories.

```
$ sphinx-build -b <OUTPUT_FORMAT> src/ build/
```

## Spell Checking

A custom dictionary is provided to do spell checking. However, the `hunspell` command does not reliably use every word in the dictionary so manual review is still required.

```
$ hunspell -l -d en_US -p ./hunspell_dictionary_root_pages.txt src/*/*.rst
```

## Translations

Root Pages can also be translated into a different language.

* Convert the documents' text into the gettext `*.pot` format.

```
$ make gettext
```

* Compile the `*.pot` files into the `*.po` format.

```
$ sphinx-intl update -p build/gettext -l <LOCALE>
```

* Translate the `*.po` files.
* Build the translated documentations.

```
$ make -e SPHINXOPTS="-D language='<LOCALE>'" html
```

## Contributing

Root Pages is a rolling release. As new information is committed, it is shortly pushed into master after a quick review for technical writing standards and correct citation usage.

All updates should be added to the reStructuredText files in the "src/" directory of this project. These documents are currently in English and translations are always welcome!

A few quick notes about technical documentation:

* Everything should be written in the third-person narrative.
* Sentences should be easy-to-read and quick to the point.
* Chicago style citation to sources are required for all pages except for linux_commands.
    * Linux Commands are assumed to reference the official manual and information pages provided by the software.
    * If assistance is required with the syntax of new citations, check out [Citation Machine](http://www.citationmachine.net/chicago).

Recommended text editors:

* Graphical User Interface (GUI):
    * [Atom](https://atom.io/) with these optional plugins:
        * [sphinx-preview](https://atom.io/packages/sphinx-preview). Hint: Open the rendered HTML preview page by pressing `CONTROL` + `ALT` + `o` together.
            * This requires the "brower-plus" plugin and that the current user have access to manage docker containers.
            * The ``docker`` container platform should be installed. The user running ``atom`` also needs privileges to manage docker containers.
        * [rst-snippets](https://atom.io/packages/rst-snippets). Hint: Create a generic Markdown or RST table outline and then press `CONTROL` + `ALT` + `t` together and then `ENTER` to automatically reformat it correctly.
* Command-Line Interface (CLI):
    * [Vim](https://github.com/vim/vim) with this plugin:
        * [vim-rst-tables plugin](https://github.com/nvie/vim-rst-tables).

RST header characters to use:

1. `=====`
2. `-----`
3. `~~~~~`
4. `^^^^^`
5. `'''''`
6. `&&&&&`

Any arguments or options that are required for a command or configuration are marked in **bold**.

### New Contributors

There are a lot of [issues open on GitHub that have the label "new content."](https://github.com/LukeShortCloud/rootpages/issues?q=is%3Aopen+is%3Aissue+label%3A%22new+content%22) These issues indicate that a new subject matter should be added into an existing document. These normally have at least one link to a source article that can be referenced or at least used as a starting point for further research.

### Quarterly Updates

Every three months, Root Pages is tagged as a milestone release. The four releases in a year are: `YYYY.01.01`, `YYYY.04.01`, `YYYY.07.01`, and `YYYY.10.01`. Quarterly updates minimize breakage to bookmarks and links compared to a rolling release model. Formatting, grammar, and spelling errors should be checked and corrected before each tagged release.

### Yearly Updates

The copyright year in `src/conf.py` needs to be updated.

## Legal

### License

Root Pages, and all of it's content, is provided under the GNU Free Documentation License (GFDL) v1.3. Additional disclaimers related to warranty and liability from the GPLv3 license are also applied to this project.

Files:

* LICENSE
* DISCLAIMER

### Plagiarism

Root Pages strives to provide proper citation to the original authors to give credit where due. If there are any reports of plagiarism, please [open a new GitHub issue](https://github.com/LukeShortCloud/rootpages/issues) for it to get addressed.
