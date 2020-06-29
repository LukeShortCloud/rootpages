Header 1
========

.. contents:: Table of Contents

Header 2
--------

The configuration for this example program has many arguments. [1]

Syntax:

.. code-block:: sh

    $ examplecommand

Common options shown via an unordered list [2]:

-  foo = Print out the word ``foo``.
-  bar = This will pour you a drink.
-  test = Run a specific test.

  -  integer = Print out integers.
  -  char = Print out characters.
  -  root = Print out the word ``foo`` only when ran the root user. Example:

-  This is a really realy really really reall really really really really really
   really long line for a list item.

   .. code-block:: sh

       $ sudo examplecommand test root
       foo

Ordered list:

1. open
2. source
3. wins

Header 3
~~~~~~~~

RST grid table:

+----------+----------+----------+
| Column 1 | Column 2 | Column 3 |
+==========+==========+==========+
| abc      | 123      | A3       |
+----------+----------+----------+
| def      | 456      | B3       |
+----------+----------+----------+
| ghi      | 789      | C3       |
+----------+----------+----------+

RST comma separated value (CSV) table:

.. csv-table::
   :header: Name, Description, Enabled
   :widths: 20, 20, 20

   Example, "There is a comma , in this sentence.", True
   Another Example, 123456, False
   Example #3, This is a long setence with no commas., True
   Ex, "This has working ""quotes"", Value

Header 4
^^^^^^^^

Header 5
''''''''

Header 6
&&&&&&&&

Troubleshooting
---------------

Tips
~~~~

Error Messages
~~~~~~~~~~~~~~

-  ``[WARN] Invalid parameter found.`` = A variable in the configuration is invalid. Review the configuration file for any issues.

Error Codes
~~~~~~~~~~~

-  0 = Success
-  1 = Failure

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/template.rst>`__

Bibliography
------------

1. "Article title." Example Website Name. January 1, 2018. Accessed January 2, 2018. https://example.tld
2. "Installation." Another Example Website Name. January 15, 2018. Accessed March 1, 2018. https://another.example.tld
