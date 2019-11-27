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

Slicing
~~~~~~~

Slicing provides a way to look-up and return elements from an array, list, or tuple.

Return the variable at the given position, with the first element starting at 0.

::

   <VARIABLE>[<POSITION>]

Return the elements in the list until the given stop position.

::

   <VARIABLE>[:<STOP>]

Return the elements in the list between a start and stop position.

::

   <VARIABLE>[<START>:<STOP>]

Return the elements of a list from a start position until the end of the list.

::

   <VARIABLE>[<START>:]

By default, slicing will increment by one step. Different step increments can be used.

::

   <VARIABLE>[<START>:<STOP>:<STEP>]

Use negative integers for the position to get a reverse order. Below shows how to find the last item in a list.

::

   <VARIABLE>[-1]

Return a reverse order of the entire list by using a negative step.

::

   <VARIABLE>[::-1]

[7]

Lists that are created by referencing another list will be used as a pointer to that same memory location. This means that changes to a new list referencing the old list will also update the original list. Slicing can be used to do a shallow copy of a list into a new separate variable.

Example:

.. code-block:: python

   list_of_numbers = [1, 2, 3]
   other_list_of_numbers = list_of_numbers
   copy_list_of_numbers = list_of_numbers[:]
   list_of_numbers[0] = 4
   print(list_of_numbers)
   print(other_list_of_numbers)
   print(copy_list_of_numbers)

::

   [4, 2, 3]
   [4, 2, 3]
   [1, 2, 3]

Lists with nested lists inside them will require a deep copy of all of the sub-elements. Otherwise, the nested lists will still point to the memory allocation of their original lists. This concept applies to lists, arrays, and dictionaries. The ``copy`` library provides a ``deepcopy`` method to help address this.

::

   import copy

Methods:

-  copy = Shallow copy (one level deep).
-  deepcopy = Copy all nested structures.

Lists are not immutable and can be globally modified. Tuples should be provided to methods/functions as arguments (instead of lists) to garuntee that the original list is never changed.

[35]

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
   :header: Method, Description
   :widths: 20, 20

   "help()", "Shows human friendly help information about a library."
   "dir()", "Show all of the available functions from a library or object."
   "print()", "Shows a string to standard output."
   "input()", "Read standard input from a terminal."
   "type()", "Find what data type a variable is."
   "int()", "Convert to an integer."
   "str()", "Convert to a string."
   "list()", "Convert characters into a list."
   "tuple()", "Convert to a tuple."
   "len()", "Return the length of a string or list"

.. csv-table::
   :header: Example, Description
   :widths: 20, 20

   "help(math)", Show help information for the math library.
   "print('Hello world')", Display Hello World to the screen.
   "int('4')", Convert the string 4 into an integer.
   "str(1)", Convert the integer 1 into a string.
   "list('hello')", "Create a list of each character in the string hello (h, e, l, l, o)."
   "tuple(my_list_var)", Create an immutable list (tuple) from an existing list.

[7]

(String Object)
^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "upper()", "Convert all characters into upper-case (capitalized)"
   "lower()", "Convert all characters to be lower-case."
   "len()", "Return the number of characters in the string."
   "count()", "Return the number of times a character or string appears in a string."
   "split()", "Split a string into a list based on a specific character or string."
   "replace(<STRING1>, <STRING2>)", "Replace all occurrences of one string with another."
   "index()", "Return the index of a specific character."
   "remove(<INDEX>)", "Remove an item from the list at the specified index."
   "format()", "Replace {} placeholders in a string with items from a list (and convert them into strings)."

[8]

(List Object)
^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "len()", "Return the number of items in a list."
   "count()", "Return the number of times an item appears in a list."
   "sort()", "Sort the items in a list used the sorted() function."
   "reverse()", "Reverse the order of items in a list."
   "append()", "Append an item to a list."
   "index()", "Return the index of a specific item."
   "insert()", "Insert an item into a list at a specific index."
   "pop()", "Return an item from a specific position (the last position is default) and remove it from the list."
   "clear()", "Clear out all values from the list to make it empty."
   "join()", "Convert a list into a single string."

.. csv-table::
   :header: Example, Description
   :widths: 20, 20

   "','.join([""car"", ""truck""])", "Create the string ""car,truck"" from the list."

[9]

(Dictionary Object)
^^^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "len(<DICT>)", "The native len() library will return the number of keys in a dictionary."
   "get(<KEY>)", "Return the value of a specified key."
   "<DICT>[<KEY>] = <VALUE>", "Change the given value at the specified key."
   "del <DICT>[<KEY>]", "Remove a key."
   "keys()", "Return all of the keys."
   "values()", Return all of the values."
   "pop(<KEY>)", "Return a key-value pair from a specific position (the last position is default) and remove it from the list."
   "items()", "Return a tuple of each key-value pair."
   "clear()", "Clear out all values from the dictionary to make it empty."

.. csv-table::
   :header: Example, Description
   :widths: 20, 20

   "len(car_models)", Return the number of items in the car_models list.
   "lightsabers[luke][color] = 'green'", Change the value of the nested variable "color" to "green".
   "del furniture_brands['comfyplus']", Delete the key comfyplus (and it s value) from the dictionary furniture_brands.

[10]

(File Object)
^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "open()", "Create a file object."
   "read()", "Read and return the entire file."
   "readlines()", "Read and return lines from a file, one at a time."
   "write()", "Write to a file object."
   "close()", "Close a file object."

[17]

fileinput
^^^^^^^^^

Read one or more files and perform special operations.

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "close()", "Close a fileinput object."
   "filelineno()", "Return the current line number of the file"
   "input(files=<LIST_OF_FILES>)", "Read a list of files as a single object."
   "input(backup=True)", "Create a backup of the original file as ""<FILE_NAME>.bak"""
   "input(inplace=True)", "Do not modify the original file until it the file object is closed. A copy of the original file is used."
   "input(openhook=fileinput.hook_compressed)", "Decompress and read gz and bz2 files."

[14]

json
^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "load(<FILE>)", "Load a JSON dictionary from a file."
   "loads(<STR>)", "Load a JSON dictionary from a string."
   "dump(<STR>)", "Load JSON as a string from a file."
   "dumps(<DICT>,  indent=4)", "Convert a JSON dictionary into a string and indent it to make it human readable."

[18]

logging
^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "input()", ""
   "debug()", ""
   "info()", ""
   "warning()", ""
   "error()", ""
   "critical()", ""
   "exception()", "Use for additional exception logging within an ""except"" block."
   "basicConfig()", "Create/start a new logger."
   "basicConfig(level=<LEVEL>)", "Set the logging level."
   "basicConfig(filename='<FILE_NAME>')", "Log to a file instead of standard output or input."
   "basicConfig(handlers=<LIST_OF_HANDLERS>)", "Configure multiple logging handlers during initialization."
   "FileHandler(<LOG_FILE>)", "The file logging handler."
   "StreamHandler()", "The stderr logging handler. This is the default handler."
   "TimedRotatingFileHandler()", "A logging handler that rotates the log file out for a new one over a specified amount of time."
   "setLevel()", "Log to a file instead of standard output or input."

.. csv-table::
   :header: Example, Description
   :widths: 20, 20

   "logging.setLevel(logging.INFO)", Set the logging mode to INFO.

[6]

os
^^

Operating system utilities.

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "listdir(<DEST>)", "Return a list of files in a directory."
   "makedirs(<LIST_OF_DIRS>)", "Recursively create a directory and sub-directories."
   "mknod(<DEST>, mode=<PERMISSIONS>)", "Create a file."
   "path.exists(<DEST>)", "Verify if a node exists."
   "path.isdir(<DEST>)", "Verify if a node is a directory."
   "path.isfile(<DEST>)", "Verify if a node is a file."
   "path.islink(<DEST>)", "Verify if a node is a link."
   "path.ismount(<DEST>)", "Verify if a node is a mount."
   "realpath(<DEST>)", "Return the full path to a file, including links."
   "remove(<DEST>)", "Delete a file."
   "rmdr(<DEST>)", "Delete a directory."
   "uname()", "Return the kernel information"

[16]

shutil
^^^^^^

Complex operations on files.

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "chown(<DEST>, user=<USER>, group=<GROUP>)", "Change the ownership of a file."
   "copyfile(<SRC>, <DEST>)", "Copy a file without any metadata."
   "copyfile2(<SRC>, <DEST>)", "Copy a file with most of it's metdata."
   "copyfileobj(<ORIGINAL>, <NEW>)", "Copy a file object."
   "copytree(<SRC>, <DEST>)", "Copy files from one directory to another."
   "disk_usage(<DEST>)", "Find disk usage information about the directory and it s contents."
   "get_archive_formats()", "View the available archive formats based on the libraries installed."
   "make_archive()", "Make a bztar, gztar, tar, xztar, or zip archive."
   "move(<SRC>, <DEST>)", "Move or rename a file."
   "rmtree(<DEST>)", "Recursively delete all files in a directory."
   "which(<CMD>)", "Return the default command found from the shell $PATH variable."

[15]

subprocess
^^^^^^^^^^

``subprocess`` handles the execution of shell commands on the file system. ``Popen()`` is the most versatile way to execute and manage commands. ``run()`` was introduced in Python 3.5 to provide a simple way to execute commands. ``*call()`` provides basic legacy functions for managing command execution as separate methods.

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   run(<CMD_STR>), "A combination of call, check_call, and check_output (added in Python 3.5)."
   call(<CMD_LIST>), "Run a command, wait for it to complete and return the return code."
   check_call(), "Run a command, wait until it is done, then return 0 or (if there was an error) raise an error exception."
   check_output(), Similar to check_call except it will return the standard output.
   "Popen(<CMD_LIST>, shell=True)", "Execute a command, track it s progress, optionally save the stdin/stdout/stderr, and save the return code."
   "Popen(<CMD_LIST>, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)", Run a command and capture the standard output and error as well as allow standard input to be sent to it.

[27]

(subprocess.Popen Object)
^^^^^^^^^^^^^^^^^^^^^^^^^

In Python >= 3.0, stdandard input/output/error is returned as bytes instead of strings. Use ``decode()`` to convert the bytes into a string.

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   communicate(), return a tuple of the standard output and standard error as bytes
   stdout(), return the standard output as bytes
   stderr(), return the standard error as bytes
   communicate(input=<STR>), send standard input to a command
   poll(), check if the process is still running
   wait(timeout=<INT>), wait until the process is finished and then return the return code and optionally timeout after a specified number of seconds
   returncode, get the return code of a completed command
   pid(), return the process ID
   terminate(), send SIGTERM to the process (gracefully stop it)
   kill(), send SIGKILL to the process (forcefully stop it)

[27]

urllib.parse
^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "quote(<STRING>)", "Replace special characters with escaped versions that are parsable by HTML."

urllib.request
^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "urlretrieve(<URL>, <FILE>)", "Download a file from an URL."
   "Request(url=<URL>, data=PARAMETERS, method=<HTTP_METHOD>)", "Create a Request object to define settings for a HTTP request."
   "urlopen(<urllib.request.Request object>)", "Establish a HTTP request connection to the remote server."
   "read().decode()", "Return the resulting text from the request."

[22]

(urllib.request.Request Object)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "ADD_HEADER(<KEY>, <VALUE>)", "Add a header to a request."

.. csv-table::
   :header: Example, Description
   :widths: 20, 20

   "<OBJECT>.ADD_HEADER(""CONTENT-TYPE"", ""APPLICATION/JSON"")", Set the application type to JSON.

[22]

External
~~~~~~~~

External libraries are not available on a default Python installation and must be installed via a package manager such as ``pip``.

requests
^^^^^^^^

Package: requests


.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "get(<URL>)", "Do a GET request on a URL."
   "get(headers=<HEADERS_DICT>)", "Provide a dictionary for custom headers."
   "get(auth=(<USER>, <PASS>))", "Provide basic HTTP authentication to the request."
   "get(params=<PARAMETERS>)", "Provide arguments to the GET request."

[21]

(requests Object)
^^^^^^^^^^^^^^^^^

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "status_code", "The HTTP status code of the request."
   "content()", "Return the resulting text output from the request."
   "json()", "Return the resulting dictionary of data from the request."

[21]

six.moves
^^^^^^^^^

Package: six

Functions from Python 3 backported for compatibility with both Python 2 and 3.

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "input()", "Capture standard input from an end-user."
   "map(<FUNCTION>, <LIST>)", "Execute a function on all items in a list."
   "reduce(<FUNCTION>, <LIST>)", "Execute a function on all items in a list and retun the cumulative sum."
   "SimpleHTTPServer()", "Create a simple HTTP server."

[20]

yaml
^^^^

Package: PyYAML

.. csv-table::
   :header: Method, Description
   :widths: 20, 20

   "load(<STR>)", "Load a YAML dictionary from a string."
   "dump(<DICT>)", "Convert a YAML dictionary into a string."

[19]

Exceptions
----------

Exceptions are raised when an error is encountered. Instead of a program exiting, the end-user can capture the error and try to deal with the issue. The code in the "try" block is executed until an exception is encountered. Then the "except" block will be executed if an exception is found.

.. code-block:: python

   try:
       # try block
   except:
       # except block

Situations for specific exceptions can be defined.

.. code-block:: python

   try:
       # try block
   except <EXCEPTION_TYPE> as <VARIABLE>:
       # except block

The "else" block can be used to always run code if there is no exception. The "finally" block will always be executed.

.. code-block:: python

   try:
       # try block
   except:
       # except block
   else:
       # else block
   finally:
       # finally block

[24]

Common exceptions:

-  Exception = Any generic Python related exception.
-  ImportError = Library import exception.
-  LookupError = An issue looking up a key or value.
-  NameError = An undefined variable.
-  NotImplementedError = A user-defined exception stating that functionality has not been created yet.
-  OSError = Operating system error exception, including I/O.
-  SyntaxError = An exception related to the way the code is written. Normally this is related to missing imported libraries.
-  TypeError = Wrong data type exception.

The full diagram of each exception category can be found here `here <https://docs.python.org/3/library/exceptions.html#exception-hierarchy>`__.

[25]

Logging
-------

Logging provides a versatile way to keep track of what a program is doing and to assist developers with troubleshooting their code.

The basic initialization of a new logger:

.. code-block:: python

   import logging
   logging.basicConfig(level=logging.DEBUG)

The valid logging levels are listed below. Each level will also display logs that are more severe than itself.

-  DEBUG = Verbose information for the developers to troubleshoot a program.
-  INFO = Basic information about what the program is currently doing.
-  WARN = Warnings about unexpected behavior that do not affect the program from continuing to operate.
-  ERROR = Part of the program has failed to complete properly.
-  CRITICAL = A fatal issue that would result in a crash.

This will create a FileHandler (file) logger.

.. code-block:: python

   import logging
   logging.basicConfig(level=logging.DEBUG, filename="/tmp/program.log")

This will create both a FileHandler (file) and StreamHandler (standard error) logger. Logs will be sent to both of the handlers at the same time.

.. code-block:: python

   import logging
   logging.basicConfig(level=logging.DEBUG,
                       handlers=[logging.FileHandler("/tmp/program.log"),
                                 logging.StreamHandler()])

Log messages should be throughout the entire program where ever they would be most useful to a developer or end-user.

Syntax:

::

   logging.<LEVEL>("<MESSAGE>")

Examples:

.. code-block:: python

   try:
       connect_to_db_function(host, user, pass)
   except:
       logging.exception("The connection to the database was unable to be established!")

.. code-block:: python

   logging.info("Starting count to 100.")

   for count in range(1,101):
       logging.debug("Currently on {}".format(count))

[33][34]

Concurrency
-----------

Generators
~~~~~~~~~~

Instead of using ``return`` to provide an array or list of return values after a function is finished, a ``yield`` creates a generator object that pauses the function until another iteration is requested. This provides the latest return value immediately into the generator object instead of having to wait for all of the results to be returned at once. This is very memory efficient since only one small value is returned instead of a large collection of values.

Syntax:

.. code-block:: python

   yield <RETURN_VALUE>

Example usage of a generator:

.. code-block:: python

   def generator_count_example(start, finish):
   
       if min < max:
   
           for n in range(start, finish):
               yield n
   
   gen_obj = generator_count_example(0, 3)
   
   for value in gen_obj:
       print(value)

The ``next()`` method can be used to iterate the next item from a generator object.

Syntax:

.. code-block:: python

   next(<GENERATOR_OBJECT>)

Alternatively, all of the objects can be rendered out at once by converting the generator into a list. However, this removes the benefits of using a generator.

Syntax:

.. code-block:: python

   list(<GENERATOR_OBJECT>)

By encapsulating a program in parenthesis, it creates a generator object. This is called a generator expression and is similar to the concept of list comprehensions.

Example:

.. code-block:: python

   number = ( n*4 for n in range(5) )
   next(number)

[36]

Threading
~~~~~~~~~

Threads can share variables between the original program and themselves. However, threads will not run in parallel. There is a lock on threads that only allows one to run at a time.

Example:

.. code-block:: python

   from threading import Thread
   from queue import Queue
   from random import randint

   q = Queue()
   threads = []

   def number_generator(max_int=5):
       q.put(randint(0, max_int) + 1)

   for item in range(0,3):
       t = Thread(target=number_generator, args=(11,))
       threads.append(t)
       t.start()

   while not q.empty():
       print(q.get())

[38]

Multiprocessing
~~~~~~~~~~~~~~~

Multiprocessing will run functions in true parallelism. However, the processes are truly independent of each other and do not share variables with the original program. There is no native locking mechanism for processes.

Example:

.. code-block:: python

   from multiprocessing import Queue, Process
   from random import randint

   q = Queue()
   processes = []

   def number_generator(max_int=5):
       q.put(randint(0, max_int) + 1)

   for item in range(0,3):
       p = Process(target=number_generator, args=(11,))
       processes.append(p)
       p.start()

   for process in processes:
       process.join()

   while not q.empty():
       print(q.get())

[39]

Object Oriented Programming
---------------------------

Object oriented programming (OOP) is the concept of creating reusable methods inside of a class. One or more objects can be created from a class.

Class syntax:

::

    class <ClassName>():

Classes have a few reserved and optional methods that can be used.

-  ``def __new__(cls)`` = A static method that can override metadata and attributes of the class before it is initialized.
-  ``def __init__(self)`` = A method that runs after ``__new__`` that initializes an object. It is commonly used to at least set variable values. This phase is fully executed before the object is first returned.
-  ``def __del__(self)`` = A method that runs when an object is being cleaned up or closed. Exceptions are ignored during this phase and the program will continue to exit if one is encountered.

[30]

Class initalization syntax:

::

    class <ClassName>():

        def __init__(self, <VARIABLE1>, <VARIABLE2>):
            self.<VARIABLE1> = <VARIABLE1>
            self.<VARIABLE2> = <VARIABLE2>

Methods are assumed to be passed the ``self`` variable to work with data from the object itself. If the method is generic in nature is can be marked as a static method as to not require ``self``. Class objects can be passed using ``cls`` if other class variables or methods need to be executed. Class and static methods should be defined by setting the relevant decorator above the method definition.

Method examples:

.. code-block:: python

        def get_name_from_object(self):
            print("The object name is {}.".format(self.name))

        @classmethod
        def get_name_from_class(cls):
            print("The default class name is {}.".format(cls.name))

        @staticmethod
        def simple_math():
            return 2+2

Using a class, multiple objects can be created and their methods called.

Object invocation syntax:

.. code-block:: python

    <object1> = <ClassName>
    <object1>.<method_name>()
    <object2> = <ClassName>
    <object2>.<method_name>()

Inheritance
~~~~~~~~~~~

A class can be created from one or more existing classes by passing them as arguments to the new class. This will inheirt variables and methods from those classes. This is useful if a new class will use similar methods from an existing class and also needs additional functionality added.

::

   class <NEW_CLASS>(<CLASS1>, <CLASS2>, <CLASS3>):

Methods can be set to be private for each class by setting by setting ``__<METHOD> = <METHOD>``. This will result in ``_<CLASS1>__<METHOD>`` and ``_<CLASS2>__<METHOD>`` methods being created for the class and it's inherited classes.

.. code-block:: python

    def get_name(self):
        return self.name

   __get_name = get_name

[31]

Testing
-------

Unit and Integration Tests
~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``unittest`` library can be used to run unit and integration tests. Below is a template of how a test class should be defined in Python. The class must utilize ``unittest.TestCase`` to handle tests. The ``setUp()`` method is used instead of ``__init__()`` for initializing a test object. The ``tearDown()`` method is always executed after every test. Test method names created by the developer must start with ``test_`` or else they will not be executed. Returns from the methods are ignored. The unit tests suite only checks to see if ``assert`` methods have succeeded or failed. When the tests are complete, a status report of the tests will be printed to the standard output.

Example:

.. code-block:: python

   import unittest
   
   
   class UnitTestClassName(unittest.TestCase):
   
       def setUp(self):
           # Prepare tests
   
       def test_method_name_here(self):
           # Create a test

       def test_integration_test_case(self):
           # Create another test
   
       def tearDown(self):
           # Cleanup
   
   if __name__ == '__main__':
       unittest.main()

Each test should have ``assert`` checks to verify that what is expected is being returned. The descriptions of each ``assert`` check can be found `here <https://docs.python.org/3/library/unittest.html#assert-methods>`__. If any of these methods return False, the test will be reported as failed.

-  assertEqual
-  assertNotEqual
-  assertTrue
-  assertFalse
-  assertIs
-  assertIsNot
-  assertIsNone
-  assertIsNotNone
-  assertIn
-  assertNotIn
-  assertIsInstance
-  assertNotIsInstance

[26]

Mock
~~~~

Mock can be used to mimic method calls and return values. This is useful for writing tests that complete faster and to clone the behavior of methods that may not work on different environments.

.. code-block:: python

   from unittest.mock import Mock

Common methods:

-  call = Execute a mocked method and provide a list of arguments to it.
-  call_args = A tuple of the last arguments used by the mocked method.
-  call_args_list = The list of arguments that were provided to every call of the mocked method.
-  method_calls = The of methods calls to a mocked class.
-  mock_calls = The list of each call, and the related arguments made to a mocked method.
-  return_value = A value the mocked method will always return.
-  configure_mock = Define a new attribute, such as a variable and it's value, for the mocked method.
-  side_effect = The side effect can be used to return one or more values from a mocked method.

   -  A function to run when mock is called.
   -  An exception that will be thrown if the mocked method is called.
   -  An iterable tuple of tuples for each call to the mocked method.

The ``patch`` method can be used as a decorator to override an existing method and provide faked results. Override settings can be configured at within the method itself. Replace ``<FILE>`` with the path to the library that should be mocked. For example, a class named ``Up`` with method ``foo`` in ``teleport/particules/beam.py`` would translate to the use of ``@patch(teleport.particules.Up.foo)``.

Syntax:

.. code-block:: python

   from unittest.mock import patch

   @patch('<FILE>.<CLASS>.<METHOD2>')
   @patch('<FILE>.<CLASS>.<METHOD1>', return_value=<VALUE1>)
   def func(<METHOD1>, <METHOD2>):
      <METHOD2>.return_value = <VALUE2>
      return <METHOD1>(), <METHOD2>()

Example:

.. code-block:: python

   # File name: mockexample.py

   from unittest.mock import patch

   def hello():
       return "hello"

   def world():
       return "world"

   @patch('mockexample.world')
   @patch('mockexample.hello', return_value="world")
   def say(hello, world):
       world.return_value = "hello"
       return hello, world

   print(say())

::

   world hello

Mock can also be used at any time by assigning as class or method as a Mock object. The expected mocked return values must be specified before the relevant methods are called. The example below will not actually delete the files.

Example:

.. code-block:: python

   from unittest.mock import Mock
   import os

   def cleanup():
       os.remove("/tmp/db.csv")
       os.remove("/tmp/config")
       return True

   def mock_cleanup():
       os.remove = Mock()
       # os.remove() should return None if completed successfully.
       os.remove.side_effect = ((None), (None))

       if cleanup():
           print("Cleanup complete.")

   mock_cleanup()

[37]

Debugging
~~~~~~~~~

The ``pdb`` library can help with debugging. By using the ``set_trace()`` method, it will pause the program at that point to let the programmer manually investigate the running Python program and it's state. By using the ``continue`` statement, the program will continue to execute from where it left off.

Example:

::

   # File name: /tmp/time_start_end.py

   import pdb
   from datetime import datetime
   from time import sleep

   time_start = datetime.now().isoformat()
   pdb.set_trace()
   print("Start time: {}".format(time_start))
   time_end= datetime.now().isoformat()
   pdb.set_trace()
   print("End time: {}".format(time_end))

::

   > /tmp/time_start_end.py(8)<module>()
   -> print("Start time: {}".format(time_start))
   (Pdb) time_start
   '2019-07-17T11:51:43.022303'
   (Pdb) time_end
   *** NameError: name 'time_end' is not defined
   (Pdb) continue
   Start time: 2019-07-17T11:51:43.022303
   > /tmp/time_start_end.py(12)<module>()
   -> print("End time: {}".format(time_end))
   (Pdb) time_end
   '2019-07-17T11:52:01.029841'
   (Pdb) continue
   End time: 2019-07-17T11:52:01.029841

[40]

PyPI Packaging
--------------

The Python Package Index (PyPI) provides a central location to upload Python packages that can be installed via ``pip``.

A ``__init__.py`` file needs to be created with at least the package name in the format ``name = "PACKAGE_NAME"``. This marks the directory as a Python package.

The ``setup.py`` file defines attributes for a package and how it will be installed.

-  author = The author's full name.
-  author_email = The author's e-mail address.
-  classifers = A list of custom classifers used by PyPI as defined `here <https://pypi.org/classifiers/>`__.

   -  ``"Programming Language :: Python :: 3 :: Only"`` = This package only supports Python 3.
   -  ``"Topic :: Documentation"`` = This package provides documentation focused functions.

-  description = A short description of the purpose of the package.
-  install_requires = A list of dependencies to install from PyPI.
-  name = The package name.
-  license = The license that the software is using.
-  long_description = A long description of the purpose of the package.
-  packages = A list of sub-packages bundled in this package. These can be dynamically found by using ``setuptools.find_packages()``.
-  scripts = A list of exectuable scripts that will be installed to the ``bin/`` directory.
-  url = The URL to the main website for the package.
-  version = The semantic package version.

.. code-block:: python

  #!/usr/bin/env python3

   import setuptools

   setuptools.setup(
       name="hello_world",
       version="1.2.3",
       author="Bob Smith"
   )

[28]

The recommended PyPI publishing utility is ``twine``. User credentials will need to be stored in ``~/.pypirc``.

.. code-block:: ini

   [distutils]
   # Enabled PyPI repository locations to manage.
   index-servers=
       testpypi
       pypi

   # The official PyPI test environment. Use this to test package updates before pushing to production.
   [testpypi]
   repository = https://test.pypi.org/legacy/
   username = <USER>
   password = <PASS>

   # The official PyPI production environment.
   [pypi]
   repository = https://upload.pypi.org/legacy/
   username = <USER>
   password = <PASS>

Build the source package tarball and then upload it to PyPI.

.. code-block:: shell

   $ python setup.py sdist
   $ twine upload -r pypi dist/<PACKAGE_TARBALL>

[29]

Virtual Environments
--------------------

Python virtual environments create an isolated installation of Python and it's libraries. This allows applications to be installed separately from one another to avoid conflicts with their dependencies and versions. Some operating systems heavily depend on Python and specific versions of software so updating packages via ``pip`` globally can lead to system instability.

In Python >= 3.3, the ``virtualenv`` library (sometimes also referred to as "venv") is part of the standard Python installation. It is used to create and manage these isolated environments.

Create a new environment:

.. code-block:: sh

   $ python3 -m virtualenv --help
   $ python3 -m virtualenv <PATH_TO_NEW_VIRTUAL_ENVIRONMENT>

Create a new environment using a specific Python version/binary installed on the system.

.. code-block:: sh

   $ python3 -m virtualenv -p /usr/bin/python2.7 <PATH_TO_NEW_VIRTUAL_ENVIRONMENT>

Create a new environment using symlinks to the original Python installation. New library installations will be overriden in the virtual environment. This is useful for operaitng systems that ship packages that are not available in PyPI such as ``python3-libselinux`` on Fedora.

.. code-block:: sh

   $ python3 -m virtualenv --system-site-packages <PATH_TO_NEW_VIRTUAL_ENVIRONMENT>

Activate an environment to use configure the shell to load up the different Python library directories. Deactivate it to return to the normal system Python.

.. code-block:: sh

   $ . <PATH_TO_VIRTUAL_ENVIRONMENT>/bin/activate
   (<VIRTUAL_ENVIRONMENT>)$ deactivate

For older operating systems, it is recommended to first update the ``pip`` and ``setuptools`` packages to the latest version. This will allow new libraries to install correctly.

.. code-block:: sh

   (<VIRTUAL_ENVIRONMENT>)$ pip install --upgrade pip setuptools

Commands can also be executed directly from the virtual environment without any activation.

.. code-block:: sh

   $ <PATH_TO_VIRTUAL_ENVIRONMENT>/bin/pip --version

[32]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/programming/python.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/python.rst>`__
-  `< 2018.01.01 <https://github.com/ekultails/rootpages/commits/master/markdown/python.md>`__

Bibliography
------------

1. "PEP 0 -- Index of Python Enhancement Proposals (PEPs)." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/
2. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide. Accessed August 26, 2018. https://www.python.org/dev/peps/pep-0008/
3. "Python Operators." Programiz. Accessed January 29, 2018. https://www.programiz.com/python-programming/operators
4. "Python break, continue and pass Statements." Tutorials Point. Accessed January 29, 2018. http://www.tutorialspoint.com/python/python_loop_control.htm
5. "Compound statements." Python 3 Documentation. January 30, 2018. Accessed January 30, 2018. https://docs.python.org/3/reference/compound_stmts.html
6. "Logging HOWTO." Python 3 Documentation. Accessed August 15, 2018. https://docs.python.org/3/howto/logging.html
7. "Built-in Functions." Python 3 Documentation. December 2, 2018. Accessed December 2, 2018. https://docs.python.org/3/library/functions.html
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
24. "Python Exceptions: An Introduction." Real Python. April 30, 2018. Accessed September 18, 2018. https://realpython.com/python-exceptions/
25. "Built-in Exceptions." Python 3 Documentation. Accessed September 18, 2018. https://docs.python.org/3/library/exceptions.html
26. "unittest - Unit testing framework. Python 3 Documentation. Accessed September 19, 2018. https://docs.python.org/3/library/unittest.html
27. "subprocess - Subprocess management." Python 3 Documentation. Accessed October 19, 2018. https://docs.python.org/3/library/subprocess.html#older-high-level-api
28. "Packaging Python Projects." Python Packaging User Guide. October 2, 2018. Accessed October 6, 2018. https://packaging.python.org/tutorials/packaging-projects/
29. "Migrating to PyPI.org." Python Packaging User Guide. October 2, 2018. Accessed October 6, 2018. https://packaging.python.org/guides/migrating-to-pypi-org/
30. "Data model." Python 3 Documentation. November 8, 2018. Accessed November 8, 2018. https://docs.python.org/3/reference/datamodel.html
31. "Classes." Python 3 Documentation. November 8, 2018. Accessed November 8, 2018. https://docs.python.org/3/tutorial/classes.html
32. "Installing packages using pip and virtualenv." Python Packaging User Guide. October 2, 2018. Accessed November 26, 2018. https://packaging.python.org/guides/installing-using-pip-and-virtualenv/
33. "logging — Logging facility for Python." Python 3 Documentation. November 29, 2018. Accessed November 29, 2018. https://docs.python.org/3/library/logging.html
34. "logging.handlers — Logging handlers." Python 3 Documentation. November 29, 2018. Accessed November 29, 2018. https://docs.python.org/3/library/logging.handlers.html/
35. "logging.handlers — Logging handlers." Python 3 Documentation. December 2, 2018. Accessed December 2, 2018. https://docs.python.org/3/library/copy.html
36. "LEARN TO LOOP THE PYTHON WAY: ITERATORS AND GENERATORS EXPLAINED." Hackaday. September 19, 2018. Accessed February 22, 2019. https://hackaday.com/2018/09/19/learn-to-loop-the-python-way-iterators-and-generators-explained/
37. "unittest.mock - mock object library." Python 3 Documentation. June 27, 2019. Accessed June 27, 2019. https://docs.python.org/3/library/unittest.mock.html
38. "Threading in Python." Linux Journal. January 24, 2018. Accessed July 10, 2019. https://www.linuxjournal.com/content/threading-python
39. "Multiprocesing in Python." Linux Journal. April 16, 2018. Accessed July 10, 2019. https://www.linuxjournal.com/content/multiprocessing-python
40. "pdb - The Python Debugger." Python 3 Documentation. Jul 19, 2019. Accessed July 19, 2019. https://docs.python.org/3/library/pdb.html
