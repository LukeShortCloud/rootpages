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

Conditionals
------------

Control and Operators
~~~~~~~~~~~~~~~~~~~~~

+---------------------+---------------------------+
| Comparison Operator | Description               |
+=====================+===========================+
| ==                  | Equal to.                 |
+---------------------+---------------------------+
| !=                  | Not equal to.             |
+---------------------+---------------------------+
| >                   | Greater than.             |
+---------------------+---------------------------+
| <                   | Lesser than.              |
+---------------------+---------------------------+
| \>=                 | Greater than or equal to. |
+---------------------+---------------------------+
| <=                  | Lesser than or equal to.  |
+---------------------+---------------------------+

+-------------------+----------------------------------------------------------------+
| Identity Operator | Description                                                    |
+===================+================================================================+
| is                | Compares two memory addresses to see if they are the same.     |
+-------------------+----------------------------------------------------------------+
| is not            | Compares two memory addresses to see if they are not the same. |
+-------------------+----------------------------------------------------------------+

+------------------+------------------------------------+
| Logical Operator | Description                        |
+==================+====================================+
| and              | All booleans must be true.         |
+------------------+------------------------------------+
| or               | At least one boolean must be true. |
+------------------+------------------------------------+
| not              | No booleans can be true.           |
+------------------+------------------------------------+

+---------------------+------------------------------------------------------------------------------------------+
| Membership Operator | Description                                                                              |
+=====================+==========================================================================================+
| in                  | The first variable needs to exist as at least a substring or key in the second variable. |
+---------------------+------------------------------------------------------------------------------------------+
| not in              | The first variable must not be in the second variable.                                   |
+---------------------+------------------------------------------------------------------------------------------+

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

`Errata <https://github.com/ekultails/rootpages/commits/master/src/python.rst>`__
---------------------------------------------------------------------------------

Bibliography
------------

1. "PEP 0 -- Index of Python Enhancement Proposals (PEPs)." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/
2. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/pep-0008/
3. "Python Operators." Programiz. Accessed January 29, 2018. https://www.programiz.com/python-programming/operators
4. "Python break, continue and pass Statements." Tutorials Point. Accessed January 29, 2018. http://www.tutorialspoint.com/python/python_loop_control.htm
5. "Compound statements." Python Documentation. January 30, 2018. Accessed January 30, 2018. https://docs.python.org/3/reference/compound_stmts.html
