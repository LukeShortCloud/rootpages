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

::

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

.. csv-table::
   :header: Function, Name, Description
   :widths: 20, 20, 20

   chr, Character, One alphanumeric character.
   str, String, One or more characters.
   int, Integer, A whole number.
   float, Float, A decimal number.
   bool, Boolean, "A true or false value. This can be a ``1`` or ``0``, or it can be ``True`` or ``False``."
   list, List, An array of values of any data type. This is more flexbile than an array.
   tuple, Tuple, "A read-only list that cannot be modified."
   arr, Array, A collection of values that have the same data type. This is more memory efficent than a list.
   dict, Dictionary, "A list of nested variables of any data type."

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

Conditionals
------------

Control and Operators
~~~~~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Comparison Operator, Description
   :widths: 20, 20

   "==", Equal to.
   "!=", Not equal to.
   ">", Greater than.
   "<", Less than.
   ">=", Greater than or equal to.
   "<=", Lesser than or equal to.

.. csv-table::
   :header: Identity Operator, Description
   :widths: 20, 20

   is, Compares two memory addresses to see if they are the same.
   is not, Compares two memory addresses to see if they are not the same.

.. csv-table::
   :header: Logical Operator, Description
   :widths: 20, 20

   and, All booleans must be true.
   or, At least one boolean must be true.
   not, No booleans can be true.

.. csv-table::
   :header: Membership Operator, Descriptoin
   :widths: 20, 20

   in, The first variable needs to exist as at least a substring or key in the second variable.
   not in, The first variable must not be in the second variable.

[3]

Control statements for loops [4]:

-  break = Stops the most outer loop that is currently in progress.
-  continue = Skips the inner loop once.
-  pass = This does nothing and is only meant to be a place holder.
-  else = After all iterations of a loop are over, the else block is executed. This is specifically for "for" and "while" loops (not "if" statements).

For
~~~

For loops will iterate through each element in a variable. This is normally an array, list, or dictionary.

Syntax:

.. code-block:: python

    for <VALUE> in <LIST_OR_DICTIONARY>:
        # Insert code to use <VALUE> here.

The "else" statement can be used to always execute code after the "for" loop has iterated through each element.

Example:

.. code-block:: python

    cars = ["sedan", "truck", "van"]

    for car in cars:
        print("Consider buying a %s." % car)
    else:
        print("This FOR loop is now completed.")

[5]

If
~~

If statements will check different comparisons and execute the first code block that is matched. The first comparison is defined as "if" and other comparisons after that can be defined using "elif." The "else" block will be executed if nothing else was matched. In Python, there is no traditional "switch" conditional so an "if" statement must be used instead.

Syntax:

.. code-block:: python

    if <COMPARISON_STATEMENT_1>:
        # Execute if this statement is True.
    elif <COMPARISON_STATEMENT_2>:
        # Execute if this statement is True.
    else:
        # If not other matches are found, execute this.

Example:

.. code-block:: python

    bread_required = 13

    if bread_required == 12:
        print("You need a dozen loafs of bread.")
    elif bread_required == 13:
        print("You need a baker's dozen loafs of bread.")
    elif bread_required == 1:
        print("You need one loaf of bread.")
    else:
        print("You need %d loafs of bread." % bread_required)

[5]

While
~~~~~

While statements will continue to loop until the condition it is checking becomes False.

Syntax:

.. code-block:: python

    while <COMPARISON_STATEMENT_OR_BOOLEAN_VARIABLE>:
        # Insert code to use while the statement is true.

The "while" statement can be used to always execute code after the loop has completed.

Example:

.. code-block:: python

    x = 0

    while x < 10:
        x += 1
        print("Looping...")
    else:
        print("This WHILE loop is now completed.")

[5]


Libraries
---------

Logging
~~~~~~~

``import logging``

-  logging.debug() = Verbose information for developers.
-  logging.info() = General information about the program's activity.
-  logging.warning() = Notification of an unexpected event that did not affect the program currently.
-  logging.error() = One more functions failed to execute properly.
-  logging.critical() = A fatal issue has occurred that will cause the program to crash.
-  logging.exception() = Python encountered a fatal error.

Logging levels can be configured using ``logging.basicConfig(level=<LEVEL>)``. It can also output to a file instead of standard output/error by using ``logging.basicConfig(filename="<FILE_NAME>")``.

[6]

Object Oriented Programming
---------------------------

Object oriented programming (OOP) is the concept of creating reusable methods inside of a class. One or more objects can be created from a class.

Class syntax:

::

    class <ClassName>():

Classes can optionally have a "``__init__``" method that is always ran when a new object is created from the class. This is useful for setting up variables and running other initalization methods if required.

Class initalization syntax:

::

    class <ClassName>():

        def __init__(self, <VARIABLE1>, <VARIABLE2>):
            self.<VARIABLE1> = <VARIABLE1>
            self.<VARIABLE2> = <VARIABLE2>

Every method has to be defined to require at least the "self" variable which contains all of the local object variables.

Method syntax:

.. code-block:: python

        def <method_name>(self):

Using a class, multiple objects can be created and their methods called.

Object invocation syntax:

.. code-block:: python

    <object1> = <ClassName>
    <object1>.<method_name>()
    <object2> = <ClassName>
    <object2>.<method_name>()

`Errata <https://github.com/ekultails/rootpages/commits/master/src/python.rst>`__
---------------------------------------------------------------------------------

Bibliography
------------

1. "PEP 0 -- Index of Python Enhancement Proposals (PEPs)." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/
2. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/pep-0008/
3. "Python Operators." Programiz. Accessed January 29, 2018. https://www.programiz.com/python-programming/operators
4. "Python break, continue and pass Statements." Tutorials Point. Accessed January 29, 2018. http://www.tutorialspoint.com/python/python_loop_control.htm
5. "Compound statements." Python 3 Documentation. January 30, 2018. Accessed January 30, 2018. https://docs.python.org/3/reference/compound_stmts.html
6. "Logging HOWTO." Python 3 Documentation. Accessed August 15, 2018. https://docs.python.org/3/howto/logging.html
