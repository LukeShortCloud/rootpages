Python 3
========

.. contents:: Table of Contents

PEP
---

Python Enhancement Proposals (PEPs) are guidelines to improve Python
itself and developer's code. Each PEP is assigned a specific number. [1]

Source:

1. "PEP 0 -- Index of Python Enhancement Proposals (PEPs)." Python's
   Developer's Guide. Accessed November 15, 2017.
   https://www.python.org/dev/peps/

Style Guide for Python Code
~~~~~~~~~~~~~~~~~~~~~~~~~~~

PEP 8 is the "Style Guide for Python Code."

-  Class names should:

   -  Be capitalized.
   -  Have two new lines above it.
   -  Example:

::

    import os


    class Pep8():

-  Method and function should:

   -  Be named in all lowercase.
   -  Use underscores "``_``" to separate words in the name.
   -  Have it's contents intended by 4 spaces.
   -  Example:

::

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

::


    if (phoneNumber == 999):

        if (callerID is “Frank”):
            print(“Hello Frank.”)

    print("Hello everyone else.")

-  Comments should:

   -  Be full sentences.

[1]

Source:

1. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide.
   Accessed November 15, 2017. https://www.python.org/dev/peps/pep-0008/

Data Types
----------

Python automatically guesses what datatype a variable should be used
when it is defined. The datatype a variable is using can be found using
the ``type()`` function.

+------+------+------+
| Func | Name | Desc |
| tion |      | ript |
|      |      | ion  |
+======+======+======+
| chr  | char | one  |
|      | acte | lett |
|      | r    | er   |
|      |      | or   |
|      |      | numb |
|      |      | er   |
+------+------+------+
| str  | stri | word |
|      | ngs  | s    |
|      |      | or   |
|      |      | numb |
|      |      | ers  |
|      |      | defi |
|      |      | ned  |
|      |      | with |
|      |      | in   |
|      |      | sing |
|      |      | le   |
|      |      | or   |
|      |      | doub |
|      |      | le   |
|      |      | quot |
|      |      | es   |
+------+------+------+
| int  | inte | a    |
|      | ger  | whol |
|      |      | e    |
|      |      | numb |
|      |      | er   |
+------+------+------+
| floa | floa | a    |
| t    | t    | deci |
|      |      | mal  |
|      |      | numb |
|      |      | er   |
+------+------+------+
| bool | bool | a    |
| ean  | ean  | true |
|      |      | or   |
|      |      | fals |
|      |      | e    |
|      |      | valu |
|      |      | e;   |
|      |      | this |
|      |      | can  |
|      |      | be a |
|      |      | “1”  |
|      |      | or   |
|      |      | “0”, |
|      |      | or   |
|      |      | it   |
|      |      | can  |
|      |      | be   |
|      |      | “Tru |
|      |      | e”   |
|      |      | or   |
|      |      | “Fal |
|      |      | se”  |
+------+------+------+
| list | list | simi |
|      |      | lar  |
|      |      | to   |
|      |      | an   |
|      |      | arra |
|      |      | y,   |
|      |      | it   |
|      |      | is a |
|      |      | list |
|      |      | of   |
|      |      | mult |
|      |      | iple |
|      |      | vari |
|      |      | able |
|      |      | s    |
+------+------+------+
| dict | dict | a    |
|      | iona | list |
|      | ry   | that |
|      |      | has  |
|      |      | sub- |
|      |      | list |
|      |      | s    |
+------+------+------+
| tupl | tupl | a    |
| e    | e    | read |
|      |      | -onl |
|      |      | y    |
|      |      | list |
|      |      | that |
|      |      | cann |
|      |      | ot   |
|      |      | be   |
|      |      | modi |
|      |      | fied |
+------+------+------+

Variables defined outside of a function are global variables. Although
this practice is discouraged, these can be referenced using the
``global`` method. It is preferred to pass variables to a function and
return their new values.

Example:

.. code:: python

    var = "Hello world"

    def say_hello():
        global var
        print(var)

Dictionaries
~~~~~~~~~~~~

Dictionaries are a variable that provides a key-value store. It can be
used as a nested array of variables.

Example replacing a key:

.. code:: python

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
