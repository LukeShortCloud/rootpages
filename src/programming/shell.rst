Shell
======

.. contents:: Table of Contents

ANSI Colors
-----------

The color of text and/or the background of text can be modified by using ANSI color codes. Use ``echo`` with escape codes enabled to display various different colors.

.. code-block:: sh

   $ echo -e "\033[32mHello green world\033[0m"

Basic text colors:

-  Black = ``\033[30m``
-  Blue = ``\033[34m``
-  Cyan = ``\033[36m``
-  Green = ``\033[32m``
-  Magenta/Purple = ``\033[35m``
-  Orange = ``\033[33m``
-  Red = ``\033[31m``
-  White = ``\033[37m``

Basic background colors [1]:

-  Black = ``\033[40m``
-  Blue = ``\033[44m``
-  Cyan = ``\033[46m``
-  Green = ``\033[42m``
-  Magenta/Purple = ``\033[45m``
-  Orange = ``\033[43m``
-  Red = ``\033[41m``
-  White = ``\033[47m``

Notice that gray is not a valid ANSI color. [2]

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

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/shell.rst>`__

Bibliography
------------

1. "How to change the color of your Linux terminal." Opensource.com. September 19, 2019. Accessed July 31, 2023. https://opensource.com/article/19/9/linux-terminal-colors
2. "The entire table of ANSI color codes." GitHub iamnewton/bash-colors.md. February 20, 2023. Accessed July 31, 2023. https://gist.github.com/iamnewton/8754917
3. "The entire table of ANSI color codes working in C!" GitHub RabaDabaDoba/ANSI-color-codes.h. July 10, 2023. Accessed July 31, 2023. https://gist.github.com/RabaDabaDoba/145049536f815903c79944599c6f952a
4. "How to stop the effect of ANSI text color code or set text color back to default after certain characters?" Stack Overflow. April 21, 2023. Accessed July 31, 2023. https://stackoverflow.com/questions/43539956/how-to-stop-the-effect-of-ansi-text-color-code-or-set-text-color-back-to-default
5. "How do I print colored text to the terminal in Rust?" Stack Overflow. January 24, 2023. Accessed July 31, 2023. https://stackoverflow.com/questions/69981449/how-do-i-print-colored-text-to-the-terminal-in-rust
