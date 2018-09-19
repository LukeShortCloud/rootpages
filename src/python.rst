Python 3
========

.. contents:: Table of Contents

These notes target Python >= 3.6 and should also mostly apply to older versions of Python.

PEP
---

Python Enhancement Proposals (PEPs) are guidelines to improve Python
itself and developer's code. Each PEP is assigned a specific number. [1]

Style Guide for Python Code (PEP 8)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Each line in the code should not be longer than 80 characters.

   -  If it is, then keep it at 72 characters and wrap it down to the next line.

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
   -  Constant variable names, whose value will never change, should be all uppercase.
   -  Use underscores ``_`` to separate words.
   -  Not start with underscores.

      -  Unless they are private variables, then it needs to start with
         two underscores.

   -  Cannot be a number.

-  Conditional loops should:

   -  Have newlines before and after a conditional block.
   -  Have it's contents intended by 4 spaces.

Example:

.. code-block:: python

    if (phoneNumber == 999):
        
        if (callerID == "Frank"):
            print("Hello Frank.")
        else:
            print("Hello everyone else.")
    
    print("Welcome to work.")

-  Comments should:

   -  Start with a ``#`` and a space after that.
   -  Be full sentences.

[2]

Comments
--------

Comments are recommended in the code to help explain what is happening and being processed. They should be above the line of code it applies to and be in-line with it. There should be a single space between the "#" comment symbol and the sentence following it. All comments should be full and complete sentences.

.. code-block:: yaml

   print("Hello")

::

   Hello

All files, classes, methods, and functions should have a docstring. These are multi-line comments explaining their purpose. For functions and methods, it should also describe the arguments and returns it expects. If the function raises any exceptions, those should also be explained. [13]

Syntax:

.. code-block:: yaml

   """<DESCRIPTION>

   Args:
       <VARIABLE1> (<TYPE>): <DESCRIPTION>
       <VARIABLE2> (<TYPE>): <DESCRIPTION>

   Retruns:
       <VARIABLE1> (<TYPE>): <DESCRIPTION>
       <VARIABLE2> (<TYPE>): <DESCRIPTION>

   Raises:
       <EXCEPTION_TYPE1>: <DESCRIPTION>
       <EXCEPTION_TYPE2>: <DESCRIPTION>
   """

Example:

.. code-block:: yaml

   def calc_average(numbers):
       """Calculates an average from a list of numbers.

       Args:
          numbers (arr, int): An array or list of integers to average.

       Returns:
           average (int): The average of the numbers.
       """
       total = 0

       for number in numbers:
           total += number

       return total / len(numbers)

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

::

   Hello world

There are a few ways to handle long strings.

.. code-block:: python

   ("This sentence is"
    " actually just one line.")

.. code-block:: python

   "This is also one " + \
   "line."

.. code-block:: python

   """This sentence spands
   many
   many
   many
   lines."""

Dictionaries
~~~~~~~~~~~~

Dictionaries are a variable that provides a key-value store. It can be
used as a nested array of variables.

Example of defining and looping over a dictionary:

.. code-block:: python

   consoles = {'funbox': {'release_year': 2005}, 'funstation': {'release_year': 2006}}

   for console in consoles:
      print("The %s was released in %d." % (console, consoles[console]['release_year']))

   print(consoles)

::

   The funbox was released in 2005.
   The funstation was released in 2006.

Example replacing a key and value:

.. code-block:: python

    dictionary = {'stub_host': 123}
    # Replace a key.
    dictionary['hello_world'] = dictionary.pop('stub_host')
    # Replace a value.
    dictionary['hello_world'] = 456
    print(dictionary)

::

   {'hello_world': 456}

Common libraries for handling dictionaries include json and yaml.

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
        print("This FOR loop is now complete.")

::

   Consider buying a sedan.
   Consider buying a truck.
   Consider buying a van.
   This FOR loop is now complete.

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
        # If no other matches are found, execute this.

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

::

   You need a baker's dozen loafs of bread.

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

    while x < 3:
        x += 1
        print("Looping...")
    else:
        print("This WHILE loop is now complete.")

::

   Looping...
   Looping...
   Looping...
   This WHILE loop is now complete.

[5]

Standard Input and Output
-------------------------

Strings can be displayed to standard output.

.. code-block:: python

   print("Hello world")

Substitutions can be done using "%s" for strings and "%d" for number data types. Alternatively, this can be done with the ``format()`` string method.

.. code-block:: python

   print("There are %d %s." % (3, "apples"))
   print("There are {} {}.".format(3, "apples"))
   print("There are {a} {b}.".format(b="apples", a=3))

::

   There are 3 apples.
   There are 3 apples.
   There are 3 apples.

Parts of a string can be printed by specifying an index range to use.

.. code-block:: python

   print("Hello world!"[0:5])
   print("Hello world!"[6:])
   print("Hello world!"[-1])

::

   Hello
   world!
   !

[23]

Standard input can be gathered from the end-user to be used inside a program.

.. code-block:: python

   stdin = input("What is your favorite color?\n")
   print("%s is such a great color!" % stdin)

::

   What is your favorite color?
   Blue
   Blue is such a great color!

Files
------

Files are commonly opened in read "r", write "w" (truncate the file and then open it for writing), read and write "+", or append "a" mode. Binary files can be opened by also using "b". [7]

Example binary read:

.. code-block:: python

   file_object = open("<FILE_PATH>", "rb")
   file_content = file_object.read()
   file_object.close()

Example text write:

.. code-block:: python

   message = ["Hello there!", "We welcome you to the community!", "Sincerely, Staff"]
   file_object = open("/app/letters/welcome.txt", "w")

   for line in message:
       file_content.write(line)

   file_object.close()

Python also supports a consolidated ``with`` loop that automatically closes the file.

Examples:

.. code-block:: python

   with open("<FILE_PATH>", "r") as file_object:
       file_content = file_object.read()

.. code-block:: python

   with open("/var/lib/app/config.json", "r") as app_config_file:
       app_config = json.load(app_config_file)

Text files with more than one line will contain newline characters. On UNIX-like systems this is ``\n`` and on Windows it is ``\r\n``. These can be removed using ``rstrip()``.

Example:

.. code-block:: python

   # Remove newlines characters for...
   # Windows
   line = line.rstrip('\r\n')
   # Linux
   line = line.rstrip('\n')

Common libraries for handling files include fileinput, io, shutil, and os.

Functions and Methods
---------------------

Functions group related usable code into a block. Everything in a function needs to be at least 4 spaces intended to the right.

Example:

.. code-block:: python

   def function():
       print("Hello world")

Functions can take arguments to use. The order that the variables are set in the funciton definition have to match when supplying a function these variables. Otherwise, the original variable name can be used to specify variables in a different order by using the syntax ``function(<ORIGINAL_VARIABLE_NAME>=<VALUE>)``. Arguments can also have default values at the function definition.

Example:

.. code-block:: python

   def function(day_of_month=1, phrase="Today is the %d day of the month."):
       print(phrase % day_of_month)

   phrase_to_use = "The best day of the month is on the %d."
   function(5, phrase_to_use)
   function(phrase="This overrides the default value and ignores positional assignment.\nDay: %d", day_of_month=14)

Functions in Python are assumed to return ``None`` unless it is explicitly set to something else. It is recommended to set functions to at least return a boolean of ``True`` or ``False`` depending on the success or failure of the function. When the function is finished running, it always returns a value that can be assigned or used. In Python, the return value can be any data type.

Example:

.. code-block:: python

   def calc_area(length, width):
       area = length * width
       return area

[11]

In object-oriented programming, functions with a class are called "methods". A class can optionally have a ``__init__`` function that initializes an object by running setup tasks. Every method must accept the argument ``self``. This refers to values that are specific to an individual object (and not the generic class).

Example:

.. code-block:: python

   class Example:

       def __init__(self, name):
           self.name = name

       def function(self):
           print(self.name)

   example = Example("Bob")
   example.function()

Static methods in a class should be explicitly defined to showcase that it has no usage of ``self``.

Example:

.. code-block:: python

   @staticmethod
   def function():
       print("Hello world")

Class methods should be explicitly defined to showcase that it has no usage of ``self``. However, these methods still require using variables and methods present in a class by using ``cls``.

Example:

.. code-block:: python

   @classmethod
   def function(cls):
       print("The default building height is %d meters." % cls.building_height)

[12]

Libraries
---------

Libraries are a collection of code that help automate similar tasks. These can be imported to help out with developing a program.

.. code-block:: python

   import <LIBRARY>

If possible, only the relevant classes or functions that will be used should be imported.

.. code-block:: python

   from <LIBRARY>, import <CLASS1>, <CLASS2>

Libraries can even be imported with new names. This can avoid conflicts with anything that has the same name or to help with compatibility in some cases.

.. code-block:: python

   import lib123 as lib_123

Built-in
~~~~~~~~

These are methods that are natively available in a default installation of Python.

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "help()", "Shows human friendly help information about a library.", "help(math)"
   "dir()", "Show all of the available functions from a library or object.", ""
   "print()", "Shows a string to standard output.", "print('Hello world')"
   "input()", "Read standard input from a terminal", ""
   "type()", "Find what data type a variable is.", ""
   "int()", "Convert to an integer.", "int('4')"
   "str()", "Convert to a string", "str(1)"
   "list()", "Convert characters into a list.", "list('hello')"
   "tuple()", "Convert to a tuple", "tuple(my_list_var)"
   "len()", "Return the length of a string or list", ""

[7]

(String Objects)
^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "upper()", "Convert all characters into upper-case (capitalized)", ""
   "lower()", "Convert all characters to be lower-case.", ""
   "len()", "Return the number of characters in the string.", ""
   "count()", "Return the number of times a character or string appears in a string.", ""
   "split()", "Split a string into a list based on a specific character or string.", ""
   "replace(<STRING1>, <STRING2>)", "Replace all occurrences of one string with another.", ""
   "index()", "Return the index of a specific character.", ""
   "remove(<INDEX>)", "Remove an item from the list at the specified index.", ""
   "format()", "Replace {} placeholders in a string with items from a list (and convert them into strings).", ""

[8]

(List Objects)
^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "len()", "Return the number of items in a list.", ""
   "count()", "Return the number of times an item appears in a list.", ""
   "sort()", "Sort the items in a list used the sorted() function.", ""
   "reverse()", "Reverse the order of items in a list.", ""
   "append()", "Append an item to a list.", ""
   "index()", "Return the index of a specific item.", ""
   "insert()", "Insert an item into a list at a specific index.", ""
   "pop()", "Return an item from a specific position (the last position is default) and remove it from the list.", ""
   "clear()", "Clear out all values from the list to make it empty.", ""
   "join()", "Convert a list into a single string.", "','.join(list_variable)"

[9]

(Dictionary Objects)
^^^^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "len(<DICT>)", "The native len() library will return the number of keys in a dictionary.", "len(car_models)"
   "get(<KEY>)", "Return the value of a specified key.", ""
   "<DICT>[<KEY>] = <VALUE>", "Change the given value at the specified key.", "lightsabers[luke][color] = 'green'"
   "del <DICT>[<KEY>]", "Remove a key.", "del furniture_brands['comfyplus']"
   "keys()", "Return all of the keys.", ""
   "values()", Return all of the values.", ""
   "pop(<KEY>)", "Return a key-value pair from a specific position (the last position is default) and remove it from the list.", ""
   "items()", "Return a tuple of each key-value pair.", ""
   "clear()", "Clear out all values from the dictionary to make it empty.", ""

[10]

(File Objects)
^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "open()", "Create a file object.", ""
   "read()", "Read and return the entire file.", ""
   "readlines()", "Read and return lines from a file, one at a time.", ""
   "write()", "Write to a file object.", ""
   "close()", "Close a file object.", ""

[17]

fileinput
^^^^^^^^^

Read one or more files and perform special operations.

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "close()", "Close a fileinput object.", ""
   "filelineno()", "Return the current line number of the file", ""
   "input(files=<LIST_OF_FILES)", "Read a list of files as a single object.", ""
   "input(backup=True)", "Create a backup of the original file as ""<FILE_NAME>.bak""", ""
   "input(inplace=True)", "Do not modify the original file until it the file object is closed. A copy of the original file is used.", ""
   "input(openhook=fileinput.hook_compressed)", "Decompress and read gz and bz2 files.", ""

[14]

json
^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "load(<FILE>)", "Load a JSON dictionary from a file.", ""
   "loads(<STR>)", "Load a JSON dictionary from a string.", ""
   "dump(<STR>)", "Load JSON as a string from a file.", ""
   "dumps(<DICT>,  indent=4)", "Convert a JSON dictionary into a string and indent it to make it human readable.", ""

[18]

logging
^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "input()", "", ""
   "debug()", "Verbose information for developers.", ""
   "info()", "General information about the program's activity.", ""
   "warning()", "Notification of an unexpected event that did not affect the program currently.", ""
   "error()", "One more functions failed to execute properly.", ""
   "critical()", "A fatal issue has occurred that will cause the program to crash.", ""
   "exception()", "Python encountered a fatal error.", ""
   "basicConfig(level=<LEVEL>)", "Set the logging level.", ""
   "basicConfig(filename='<FILE_NAME>')", "Log to a file instead of standard output or input.", ""
   "FileHandler()", "The file to log to.", ""
   "setLevel()", "Log to a file instead of standard output or input.", "logging.setLevel(logging.INFO)"

[6]

os
^^

Operating system utilities.

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "listdir(<DEST>)", "Return a list of files in a directory.", ""
   "makedirs(<LIST_OF_DIRS>)", "Recursively create a directory and sub-directories.", ""
   "mknod(<DEST>, mode=<PERMISSIONS>)", "Create a file.", ""
   "path.exists(<DEST>)", "Verify if a node exists.", ""
   "path.isdir(<DEST>)", "Verify if a node is a directory.", ""
   "path.isfile(<DEST>)", "Verify if a node is a file.", ""
   "path.islink(<DEST>)", "Verify if a node is a link.", ""
   "path.ismount(<DEST>)", "Verify if a node is a mount.", ""
   "realpath(<DEST>)", "Return the full path to a file, including links.", ""
   "remove(<DEST>)", "Delete a file.", ""
   "rmdr(<DEST>)", "Delete a directory.", ""
   "uname()", "Return the kernel information", ""

[16]

shutil
^^^^^^

Complex operations on files.

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "chown(<DEST>, user=<USER>, group=<GROUP>)", "Change the ownership of a file.", ""
   "copyfile(<SRC>, <DEST>)", "Copy a file without any metadata.", ""
   "copyfile2(<SRC>, <DEST>)", "Copy a file with most of it's metdata.", ""
   "copyfileobj(<ORIGINAL>, <NEW>)", "Copy a file object.", ""
   "copytree(<SRC>, <DEST>)", "Copy files from one directory to another.", ""
   "disk_usage(<DEST>)", "Find disk usage information about the directory and it s contents.", ""
   "get_archive_formats()", "View the available archive formats based on the libraries installed.", ""
   "make_archive()", "Make a bztar, gztar, tar, xztar, or zip archive.", ""
   "move(<SRC>, <DEST>)", "Move or rename a file.", ""
   "rmtree(<DEST>)", "Recursively delete all files in a directory.", ""
   "which(<CMD>)", "Return the default command found from the shell $PATH variable.", ""

[15]

urllib.parse
^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "quote(<STRING>)", "Replace special characters with escaped versions that are parsable by HTML.", ""

urllib.request
^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "urlretrieve(<URL>, <FILE>)", "Download a file from an URL.", ""
   "Request(url=<URL>, data=PARAMETERS, method=<HTTP_METHOD>)", "Create a Request object to define settings for a HTTP request.", ""
   "urlopen(<urllib.request.Request object>)", "Establish a HTTP request connection to the remote server.", ""
   "read().decode()", "Return the resulting text from the request.", ""

[22]

(urllib.request.Request Object)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "add_header(<KEY>, <VALUE>)", "Add a header to a request.", "<OBJECT>.add_header(""Content-type"", ""application/json"")"

[22]

External
~~~~~~~~

External libraries are not available on a default Python installation and must be installed via a package manager such as ``pip``.

requests
^^^^^^^^

Package: requests


.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "get(<URL>)", "Do a GET request on a URL.", ""
   "get(headers=<HEADERS_DICT>)", "Provide a dictionary for custom headers.", ""
   "get(auth=(<USER>, <PASS>))", "Provide basic HTTP authentication to the request.", ""
   "get(params=<PARAMETERS>)", "Provide arguments to the GET request.", ""

[21]

(requests Object)
^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "status_code", "The HTTP status code of the request.", ""
   "content()", "Return the resulting text output from the request.", ""
   "json()", "Return the resulting dictionary of data from the request.", ""

[21]

six.moves
^^^^^^^^^

Package: six

Functions from Python 3 backported for compatibility with both Python 2 and 3.

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "input()", "Capture standard input from an end-user.", ""
   "map(<FUNCTION>, <LIST>)", "Execute a function on all items in a list.", ""
   "reduce(<FUNCTION>, <LIST>)", "Execute a function on all items in a list and retun the cumulative sum.", ""
   "SimpleHTTPServer()", "Create a simple HTTP server.", ""

[20]

yaml
^^^^

Package: PyYAML

.. csv-table::
   :header: Method, Description, Example
   :widths: 20, 20, 20

   "load(<STR>)", "Load a YAML dictionary from a string.", ""
   "dump(<DICT>)", "Convert a YAML dictionary into a string.", ""

[19]

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
2. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide. Accessed August 26, 2018. https://www.python.org/dev/peps/pep-0008/
3. "Python Operators." Programiz. Accessed January 29, 2018. https://www.programiz.com/python-programming/operators
4. "Python break, continue and pass Statements." Tutorials Point. Accessed January 29, 2018. http://www.tutorialspoint.com/python/python_loop_control.htm
5. "Compound statements." Python 3 Documentation. January 30, 2018. Accessed January 30, 2018. https://docs.python.org/3/reference/compound_stmts.html
6. "Logging HOWTO." Python 3 Documentation. Accessed August 15, 2018. https://docs.python.org/3/howto/logging.html
7. "Built-in Functions." Python 3 Documentation. Accessed September 14, 2018. https://docs.python.org/3/library/functions.html
8. "string - Common string operations." Python 3 Documentation. Accessed August 25, 2018. https://docs.python.org/3/library/string.html
9. "Data Structures." Python 3 Documentation. Accessed August 25, 2018. https://docs.python.org/3/tutorial/datastructures.html
10. "Data Structures." Python 3 Documentation. Accessed August 25, 2018. https://docs.python.org/3/library/stdtypes.html
11. "A Beginner's Python Tutorial/Functions." Wikibooks. February 8, 2018. Accessed September 11, 2018. https://en.wikibooks.org/wiki/A_Beginner's_Python_Tutorial/Functions
12. "Difference between @staticmethod and @classmethod in Python." Python Central. February 2, 2013. Accessed September 11, 2018. https://www.pythoncentral.io/difference-between-staticmethod-and-classmethod-in-python/
13. "Google Python Style Guide." June 16, 2018. Accessed September 12, 2018. https://github.com/google/styleguide/blob/gh-pages/pyguide.md
14. "fileinput - Iterate over lines from multiple input streams." Python 3 Documentation. Accessed September 14, 2018. https://docs.python.org/3/library/fileinput.html
15. "shutil - High-level file operations." Python 3 Documentation. Accessed September 14, 2018. https://docs.python.org/3/library/shutil.html
16. "os -Miscellaneous operating system interfaces." Python 3 Documentation. Accessed September 14, 2018. https://docs.python.org/3/library/os.html
17. "Input and Output." Python 3 Documentation. Accessed September 14, 2018. https://docs.python.org/3/tutorial/inputoutput.html
18. "json - JSON encoder and decoder." Python 3 Documentation. Accessed September 15, 2018. https://docs.python.org/3/library/json.html
19. "PyYAML Documentation." PyYAML. Accessed September 15, 2018. https://pyyaml.org/wiki/PyYAMLDocumentation
20. "Six: Python 2 and 3 Compatibility Library." Python Hosted. Accessed September 15, 2018 https://pythonhosted.org/six/
21. "Requests: HTTP for Humans." Requests Documentation. Accessed September 17, 2018. http://docs.python-requests.org/en/master/
22. "urllib.request - Extensible library for opening URLs." Python 3 Documentation. Accessed September 17, 2018. https://docs.python.org/3/library/urllib.request.html#module-urllib.request
23. "PEP 3101 -- Advanced String Formatting." September 14, 2008. Accessed September 17, 2018. https://www.python.org/dev/peps/pep-3101/
