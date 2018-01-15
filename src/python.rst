Python 3
========

.. contents:: Table of Contents

PEP
---

Python Enhancement Proposals (PEPs) are guidelines to improve Python
itself and developer's code. Each PEP is assigned a specific number. [1]

Style Guide for Python Code
~~~~~~~~~~~~~~~~~~~~~~~~~~~

PEP 8 is the "Style Guide for Python Code."

-  Class names should:

   -  Be capitalized.
   -  Have two new lines above it.
   -  Example:

.. code-block:: python

    import os


    class Pep8():

-  Method and function should:

   -  Be named in all lowercase.
   -  Use underscores "``_``" to separate words in the name.
   -  Have it's contents intended by 4 spaces.
   -  Example:

.. code-block:: python

    def hello_world():
        print("Hello world")

-  Variables names should:

   -  Have the first letter be lowercase.
   -  Contain no underscores "``_``."

      -  Unless they are private variables, then it needs to start with
         two underscores.

   -  Cannot be a number.

-  Conditional loops should:

   -  Have newlines before and after a conditional block.
   -  Have it's contents intended by 4 spaces.

Example:

.. code-block:: python

    if (phoneNumber == 999):

        if (callerID is “Frank”):
            print(“Hello Frank.”)
        else:
            print("Hello everyone else.")

    print("Welcome to work.")

-  Comments should:

   -  Be full sentences.

[2]

Data Types
----------

Python automatically guesses what data type a variable should be used
when it is defined. The datatype a variable is using can be found using
the ``type()`` function.

+----------+------------+----------------------------------------------------------------------------------+
| Function | Name       | Description                                                                      |
+==========+============+==================================================================================+
| chr      | character  | One alphanumeric character.                                                      |
+----------+------------+----------------------------------------------------------------------------------+
| str      | string     | One or more characters.                                                          |
+----------+------------+----------------------------------------------------------------------------------+
| int      | integer    | A whole number.                                                                  |
+----------+------------+----------------------------------------------------------------------------------+
| float    | float      | A decimal number.                                                                |
+----------+------------+----------------------------------------------------------------------------------+
| boolean  | boolean    | a true or false value; this can be a “1” or “0”, or it can be “True” or “False." |
+----------+------------+----------------------------------------------------------------------------------+
| list     | list       | A list of multiple variables that is similar to an array.                        |
+----------+------------+----------------------------------------------------------------------------------+
| dict     | dictionary | An array of arrays.                                                              |
+----------+------------+----------------------------------------------------------------------------------+
| tuple    | tuple      | A read-only list that cannot be modified.                                        |
+----------+------------+----------------------------------------------------------------------------------+

Variables defined outside of a function are global variables. Although
this practice is discouraged, these can be referenced using the
``global`` method. It is preferred to pass variables to a function and
return their new values.

Example:

.. code-block:: python

    var = "Hello world"

    def say_hello():
        global var
        print(var)

Dictionaries
~~~~~~~~~~~~

Dictionaries are a variable that provides a key-value store. It can be
used as a nested array of variables.

Example replacing a key:

.. code-block:: python

    dictionary = {'stub_host': '123'}
    dictionary['hello_world'] = dictionary.pop('stub_host')
    print(dictionary)

JSON libraries:

-  json.load = Load a JSON dictionary from a file.
-  json.loads = Load a JSON dictionary from a string.
-  json.dump = Load JSON as a string from a file.
-  json.dumps = Convert a JSON dictionary into a string.

YAML libraries:

-  yaml.load = Load a YAML dictionary from a string.
-  yaml.dump = Convert a YAML dictionary into a string.

Bibliography
------------

1. "PEP 0 -- Index of Python Enhancement Proposals (PEPs)." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/
2. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/pep-0008/
