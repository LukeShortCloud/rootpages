Shell
======

.. contents:: Table of Contents

Environment Variables
---------------------

Environment variables are commonly used to configure settings for programs.

-  View the current environment variables.

   .. code-block:: sh

      $ env

-  View the value of a specific environment variable.

   .. code-block:: sh

      $ echo $<ENVIRONMENT_VARIABLE_KEY>

-  Temporarily set an environment variable.

   .. code-block:: sh

      $ export <KEY>=<VALUE>

-  Temporarily delete an environment variable.

   .. code-block:: sh

      $ unset <KEY>

-  Launch a program using an environment variable.

   .. code-block:: sh

      $ <KEY>=<VALUE> <PROGRAM>

   .. code-block:: sh

      $ env <KEY>=<VALUE> <PROGRAM>

-  Permanently set an environment variable globally.

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/environment
      <KEY>=<VALUE>

-  Permanently set an environment variable for the local user.

   .. code-block:: sh

      $ mkdir -p "${HOME}/.config/environment.d/"
      $ ${EDITOR} "${HOME}/.config/environment.d/<FILE_NAME>.conf"
      <KEY>=<VALUE>

Locale
------

A locale affects the language, calendar, currency, and other values used by the system.

View all locales.

.. code-block:: sh

   $ locale --all-locales

View all top-level keyboard configurations.

.. code-block:: sh

   $ localectl list-x11-keymap-layouts

Optionally view keyboard configuration variants.

.. code-block:: sh

   $ localectl list-x11-keymap-variants <KEYMAP>

Example of setting U.S.A. default values. [8][9]

.. code-block:: sh

   $ localectl set-locale LANG=en_US.utf8
   $ localectl set-locale LC_MESSAGES=C
   $ localectl set-keymap us

The keymap can also be set manually. [10]

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/vconsole.conf
   KEYMAP=us

ANSI Colors
-----------

The color of text and/or the background of text can be modified by using ANSI color codes. Use ``echo`` with escape codes enabled to display various different colors. The ``\033[0m`` escape code will reset the the TTY back to its original color scheme. Otherwise, the color settings will stay.

.. code-block:: sh

   $ echo -e "\033[32mHello green world\033[0m"

ANSI only officially supports 8 colors:

-  Black = ``\033[30m``
-  Red = ``\033[31m``
-  Yellow = ``\033[33m``
-  Green = ``\033[32m``
-  Cyan = ``\033[36m``
-  Blue = ``\033[34m``
-  Magenta = ``\033[35m``
-  White = ``\033[37m``

It also supports background colors [1]:

-  Black = ``\033[40m``
-  Red = ``\033[41m``
-  Yellow = ``\033[43m``
-  Green = ``\033[42m``
-  Cyan = ``\033[46m``
-  Blue = ``\033[44m``
-  Magenta = ``\033[45m``
-  White = ``\033[47m``

Most modern programs support 256 color codes for even more colors and variety. Use ``\033[38;5;<256_COLOR_CODE>m`` to display any of these colors. [2]

256 color codes:

-  0-7 = ANSI.
-  8-15 = High intensity.
-  16-231 = Wide range of colors.

   -  16 = Black.
   -  231 = White.

-  232-255 = Grayscale.

Reset codes [1][4]:

-  Text only = ``\033[39m``
-  Background only = ``\033[49m``
-  Text and background = ``\033[0m``

Understanding ANSI color codes:

-  Example (red background text): ``\033[41m``

   -  ``\033`` (octal) or ``\x1b`` (hexadecimal) is the escape sequence that denotes that this is an ANSI color code. [5]
   -  ``[`` or ``[0;`` by default means that no special stylization is applied. Alternatives include [3]:

      -  ``[1;`` = bold.
      -  ``[2;`` = low intensity.
      -  ``[3;`` = italicize.
      -  ``[4;`` = underline.
      -  ``[9;`` = high intensity.

   -  ``4`` denotes background color. Alternatives include:

      -  ``3`` = text color.
      -  ``10`` = high intensity background color.

   -  The last number ``1`` denotes the actual color.
   -  ``m`` denotes the end of the ANSI color code.

Zsh
---

Differences with Bash
~~~~~~~~~~~~~~~~~~~~~

-  Arrays are used differently.

   -  Bash:

      .. code-block:: sh

         CMD=(echo Hello world)
         ${CMD[*]}

   -  Zsh:

      .. code-block:: sh

         CMD=(echo Hello world)
         $CMD

-  If nothing is found with a wildcard ``*`` blob, then Zsh will fail and exit the script immediately. This is because Zsh itself tries to expand it instead of sending the wildcard to the application. Use ``setopt`` to make the behavior the same as Bash. [6]

   .. code-block:: sh

      setopt +o nomatch
      ls /tmp/foobar*

-  Zsh will always preserve newlines when outputting a variable. However, Bash will only preserve newlines when the variable is quoted. [7]

   .. code-block:: sh

      $ foobar=$(echo -e "foo\nbar")
      $ echo ${foobar}
      $ echo "${foobar}"

   ::

      foo bar
      foo
      bar

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/shell.rst>`__

Bibliography
------------

1. "How to change the color of your Linux terminal." Opensource.com. September 19, 2019. Accessed July 31, 2023. https://opensource.com/article/19/9/linux-terminal-colors
2. "Add Color with ANSI in JavaScript." CodeHS. Accessed June 30, 2024. https://codehs.com/tutorial/ryan/add-color-with-ansi-in-javascript
3. "The entire table of ANSI color codes working in C!" GitHub RabaDabaDoba/ANSI-color-codes.h. July 10, 2023. Accessed July 31, 2023. https://gist.github.com/RabaDabaDoba/145049536f815903c79944599c6f952a
4. "How to stop the effect of ANSI text color code or set text color back to default after certain characters?" Stack Overflow. April 21, 2023. Accessed July 31, 2023. https://stackoverflow.com/questions/43539956/how-to-stop-the-effect-of-ansi-text-color-code-or-set-text-color-back-to-default
5. "How do I print colored text to the terminal in Rust?" Stack Overflow. January 24, 2023. Accessed July 31, 2023. https://stackoverflow.com/questions/69981449/how-do-i-print-colored-text-to-the-terminal-in-rust
6. "Why zsh tries to expand * and bash does not?" Stack Overflow. May 7, 2022. Accessed February 20, 2024. https://stackoverflow.com/questions/20037364/why-zsh-tries-to-expand-and-bash-does-not
7. "How to preserve line breaks when storing command output to a variable? [duplicate]." Stack Overflow. August 9, 2023. Accessed February 20, 2024. https://stackoverflow.com/questions/22101778/how-to-preserve-line-breaks-when-storing-command-output-to-a-variable
8. "System Locale and Keyboard Configuration." Fedora User Docs. December 9, 2024. Accessed December 10, 2024. https://docs.fedoraproject.org/en-US/fedora/f40/system-administrators-guide/basic-system-configuration/System_Locale_and_Keyboard_Configuration/
9. "Locale." ArchWiki. December 1, 2024. Accessed December 10, 2024. https://wiki.archlinux.org/title/Locale
10. "Setting Keyboard Layout." Fedora CoreOS. February 7, 2024. Accessed December 10, 2024. https://docs.fedoraproject.org/en-US/fedora-coreos/sysconfig-setting-keymap/
