Go
==

.. contents:: Table of Contents

The open source ``Go`` programming language was created by Google in 2009 to get the speed of compiled C code while also having quality-of-life features of memory protection, garbage collection, and multiprocessing. The language is sometimes referred to as ``golang`` to avoid confusion with the English word "go." [6]

Tutorials
---------

-  Hands-on workshops:

   -  `A Tour of Go <https://tour.golang.org/welcome/1>`__

-  Best practices:

   -  `Effective Go <https://golang.org/doc/effective_go.html>`__

-  Code examples:

   -  `Go Cheat Sheet <https://github.com/a8m/go-lang-cheat-sheet>`__
   -  `Go by Example <https://gobyexample.com/>`__
   -  `Golang Training <https://github.com/go-training/training>`__
   -  `go-packages <https://github.com/radovskyb/go-packages>`__
   -  `Go Source Code <https://golang.org/src/>`__ = Contains a ``example_test.go`` file for each library.

-  Videos:

   -  `Golang Tutorial - Learn the Go Programming Language <https://www.youtube.com/watch?list=PLSak_q1UXfPp971Hgv7wHCU2gDOb13gBQ&time_continue=14&v=6lBeN973T4Q>`__

Installation
------------

`Download Go <https://golang.org/dl/>`__, extract it, add the new Go binary $PATH and load it. [11]

::

   $ wget https://dl.google.com/go/go<GO_VERSION>.<OPERATING_SYSTEM>-<CPU_ARCHITECTURE>.tar.gz
   $ tar -C /usr/local -x -z -f go<GO_VERSION>.<OPERATING_SYSTEM>-<CPU_ARCHITECTURE>.tar.gz
   $ echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
   $ . ~/.profile

Release Cycle
-------------

A new major ``1.Y`` release of Go comes out every 6 months. Every release gets updates for 1 year before being marked as end-of-life. The first 6 months, Go gets fixes for bugs and security issues. The second/last 6 months only get security fixes. [12] All Go 1 source code using the standard library is guaranteed to be backwards compatible for all ``1.Y`` releases. [13]

Style Guide
-----------

The ``gofmt`` command will automatically format a Go source code file into the standard format. Other manual changes to for best practice on synatx usage can be found `here <https://github.com/golang/go/wiki/CodeReviewComments>`__.

Data Types
----------

-  ``bool`` = Boolean. Valid values: ``true`` or ``false``.
-  ``complex64``, ``complex128`` = Complex. A float that supports imaginary numbers.
-  ``float32``, ``float64`` = Float. Large decimal numbers.
-  ``int``, ``int8`` (or ``byte``), ``int16``, ``int32`` (or ``rune``), ``int64`` = Integer. By default, ``int`` will be 32-bit or 64-bit based on the operating system architecture.
-  ``nil`` = An empty/null variable.
-  ``string`` = String. Alphanumeric UTF-8 values.
-  ``uint``, ``uint8``, ``uint16``, ``uint32``, ``uint64``, ``uintptr`` = Unsigned integer that only supports positive whole numbers.

Go will, by default, guess what data type the variable should be based on the value that is assigned to it.

.. code-block:: go

   var hello = "Hello world"

.. code-block:: go

   hello := "Hello world"

Variable data types can be explicitly defined by placing the type after the variable name.

.. code-block:: go

   var hello string = "Hello world"

Multiple empty variables can also be initialized at once.

.. code-block:: go

   var height, width, length int8

[1][2]

Standard Input and Output
-------------------------

The ``fmt`` library provides the functions for inputting and outputting strings.

.. code-block:: go

   import "fmt"

.. code-block:: go

   greeting := "Hello world"
   fmt.Print(greeting, ", how are you?\n")

``Printf`` will do more complex string formatting/substitution.

.. code-block:: go

   greeting := "Ahoy there matey"
   fmt.Printf("%v, how are ye?\n", greeting)

``Println`` can do standard default formatting by adding spaces between variables and strings along with adding a newline character at the end of the print statement.

``Scan()`` is used to get a single string (space and newline delimited). The input will be stored to a pointer address.

.. code-block:: go

   var greeting string
   /// Example input: "Hey"
   fmt.Scan(&string)
   fmt.Printf("%v, how are ye?\n", greeting)

A long string consisting of spaces can be entered by using ``Scanf()`` and quoting the input.

.. code-block:: go

   var greeting string
   // Example input: "Hello everyone"
   fmt.Scan("%q", &string)
   fmt.Printf("%v, how are ye?\n", greeting)

Common formats:

-  %v = The value of a variable.
-  %q = A double quoted string.
-  %p = The pointer address of a variable.
-  %T = The data type of a variable.

[3]

Arithmetic Math
---------------

These basic arithmetic operators are available to be used without any external libraries:

-  Add = ``+``
-  Subtract = ``-``
-  Multiply = ``*``
-  Divide = ``/``
-  Remainder = ``%``

A number can become the opposite sign (negative or positive) by placing a ``-`` in front of the variable name. [8] For more advanced functionality, use the `math <https://golang.org/pkg/math/>`__ library.

Functions
---------

All ``Go`` programs must define a package name and the ``main()`` function. Below is a minimal example of how a program looks. Run the code with ``go run <FILE>.go`` or build a portable binary and run it by executing ``go build <FILE>.go && ./<FILE>``.

.. code-block:: go

   package main
   
   import "fmt"
   
   func main() {
       fmt.Print("This is a simple Go program.\n")
   }

User defined functions need a name, input variables and their types, as well as the return data type.

.. code-block:: go

   func <FUNCTION_NAME>(<VARIABLE> <DATA_TYPE>) <RETURN_DATA_TYPE> {
   }

If multiple variables share the same data type, they can be consolidated by only mentioning the data type once.

.. code-block:: go

   func <FUNCTION_NAME>(<VARIABLE1>, <VARIABLE2> <DATA_TYPE>) <RETURN_DATA_TYPE> {
   }

Example:

.. code-block:: go

   func divide_two_numbers(a, b float32) float32 {
       return a / b
   }

Multiple return datas can be defined within parentheses.

.. code-block:: go

   func <FUNCTION_NAME>(<VARIABLE> <DATA_TYPE>) (<RETURN_DATA_TYPE1>, <RETURN_DATA_TYPE2>) {
   }

Specific local variables can also be returned.

.. code-block:: go

   func <FUNCTION_NAME>(<VARIABLE> <DATA_TYPE>) <RETURN_VARIABLE> <RETURN_DATA_TYPE> {
   }

[4]

Certain return variables can be ignored by using "_" as a place holder. In this example, ``varOne`` will be set to ``1``.

.. code-block:: go

   func returnTwoThings() (int, int) {
       return 1, 2
   }

   func getTwoThings() (int) {
       varOne, _ := returnTwoThings()
   }

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
   :header: Logical Operator, Description
   :widths: 20, 20

   &&, All booleans must be true.
   ||, At least one boolean must be true.
   !, No booleans can be true.

Control statements for loops:

-  break = Stop the current loop.
-  continue = Move onto the next iteration of the loop.

[5]

For
~~~

The ``for`` loop optionally creates a local variable, does a comparison, and increments it at the end of the current iteration.

.. code-block:: go

   for <VARIABLE_INITIALIZATION>; <COMPARISON>; <INCREMENT> {
   }

Example:

.. code-block:: go

   for x := 0; x < 3; x++ {
       fmt.Println(x)
   }

While loops can be created by using a basic for loop.

.. code-block:: go

   for <COMPARISON> {
       <INCREMENT>
   }

Example:

.. code-block:: go

   x := 0

   for x < 3{
       x += 1
   }

An infinite loop can be defined by not using any arguments for the loop.

.. code-block:: go

   for {
   }

[5]

If
~~

``if`` statements are used to run through multiple comparisons and can optionally have a default block.

.. code-block:: go

   if <COMPARISON> {
   }

.. code-block:: go

   if <COMPARISON> {
   } else {
   }

.. code-block:: go

   if <COMPARISON1> {
   } else if <COMPARISON2> {
   } else {
   }

[5]

Switch
~~~~~~

The ``switch`` statement is a simplified ``if`` statement to check the value of a variable. Only the first matched case will be executed.

.. code-block:: go

   switch <VARIABLE> {
       case <CASE1>: {
       }
       case <CASE2>, <CASE3>: {
       }
       default: {
       }
   }

Comparisons can also be checked where a case will be matched if a boolean returns True.

.. code-block:: go

   switch {
       case <COMPARISON1>: {
       }
       case <COMPARISON2>: {
       }
       default: {
       }
   }

[5]

File Input and Output
---------------------

File handling is done via the ``io/ioutil`` library. The two main methods are ``ReadFile`` and ``WriteFile``. Information read and written from/to uses as an array of the ``bytes`` data type.

.. code-block:: go

   package main

   import (
       "io/ioutil"
   )

The ``ReadFile`` method will first return the file text in an array of bytes and, if there was a failure, it will also return an error as a string.

Syntax:

.. code-block:: go

   text_bytes, error := ioutil.ReadFile(<FILE_NAME>)

The ``WriteFile`` method will only return an error message if it fails. Otherwise, a variable assigned to it will be kept as having a ``nil`` value.

Syntax:

.. code-block:: go

   error := ioutil.WriteFile(<FILE_NAME>, <INPUT_BYTES>, <FILE_MODE_PERMISSIONS>)

Example:

.. code-block:: go

   package main
   
   import (
       "fmt"
       "io/ioutil"
   )
   
   func main() {
       file := "hello_world.txt"
       text := []byte("Hello world")
       error := ioutil.WriteFile(file, text, 0644)
   
       if error != nil {
           fmt.Println(error)
       } else {
           fmt.Println("The file was written successfully.")
       }
   
       read_text_bytes, error := ioutil.ReadFile(file)
       read_text_string := string(read_text_bytes)
   
       if error != nil {
           fmt.Println(error)
       } else {
           fmt.Printf("The file says: \n%v\n", read_text_string)
       }
   }

::

   The file was written successfully.
   The file says:
   Hello world

More advanced operations for files (such as appending text, truncating, renaming/relocating, etc.) are handled via the ``os`` library.

.. code-block:: go

   import "os"

For appending to a file, the ``os.OpenFile`` method should be used. It provides more advanced options than the simpler ``os.Open`` and ``ioutil.ReadFile`` methods.

.. code-block:: go

   OpenFile(<FILE_NAME>, <ATTRIBUTES>, <PERMISSIONS>)

Here is the list of valid attributes for opening the file.

-  os.O_APPEND = Append to an existing file.
-  os.O_CREATE = Create a new file.
-  os.O_RDONLY = Read.
-  os.O_RDWR = Read and write.
-  os.O_TRUNC = Truncate a file / empty it.
-  os.O_WRONLY = Write.

Multiple attributes can be combined using an OR ``|`` statement. The ``os`` file methods also require the object to be manually closed (something that is done automatically with the ``ioutil`` methods).

.. code-block:: go

   text_file, error = OpenFile("example.txt", os.O_CREATE|os.O_APPEND, 0644)
   text_file.WriteString("This is a new line of text!\n")
   text_file.close()

[7]

Libraries
---------

All of the libraries and methods can be found at `https://golang.org/pkg/ <https://golang.org/pkg/>`__. The methods will list all of the possible input and output values.

(Files)
~~~~~~~

These are the methods related to examining and manipulating files.

-  `io.ioutil <https://golang.org/pkg/io/ioutil/>`__

   -  NopCloser
   -  ReadAll
   -  ReadDir
   -  ReadFile
   -  TempDir
   -  TempFile
   -  WriteFile

-  `os <https://golang.org/pkg/os/>`__

   -  Chown
   -  Chmod
   -  Chtimes
   -  Create
   -  Chdir
   -  FileInfo
   -  Getwd
   -  IsExist
   -  IsNotExist
   -  IsPathSeparator
   -  Lchown
   -  Link
   -  Mkdir
   -  MkdirAll
   -  Open
   -  OpenFile
   -  Readlink
   -  Remove
   -  RemoveAll
   -  Rename
   -  SameFile
   -  Stat
   -  Symlink
   -  TempDir
   -  Truncate
   -  UserCacheDir
   -  UserConfigDir
   -  UserHomeDir

(File Object)
^^^^^^^^^^^^^

These are `methods <https://golang.org/pkg/os/#File>`__ that are valid for a ``File`` object/data type.

-  Create
-  NewFile
-  Open
-  OpenFile
-  Chdir
-  Chmod
-  Chown
-  Close
-  Fd
-  Name
-  Read
-  ReadAt
-  Readdir
-  Readdirnames
-  Seek
-  SetDeadline
-  SetReadDeadline
-  SetWriteDeadline
-  Stat
-  Sync
-  SyscallConn
-  Truncate
-  Write
-  WriteAt
-  WriteString

math
~~~~

-  Abs = Absolute value.
-  Max = Maximum. Return the bigger number.
-  Min = Minimum. Return the smaller number.
-  Power = Exponential power.
-  Round = Round to the nearest whole number.
-  Sqrt = Square root.
-  `rand <https://golang.org/pkg/math/rand/>`__ = The random number generation library. [9]

   -  Seed = The seed used for helping to generate different random numbers. Defaults to 1.
   -  New(<SEED>) = Create a new ``rand`` object, optionally providing a seed.
   -  ``<NUMBER_DATA_TYPE>`` = The random library supports creating a random number in any related data type. For example, ``Int()``.

[10]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/programming/go.rst>`__

Bibliography
------------

1. "Basic types." A Tour of Go. Accessed March 5, 2019. https://tour.golang.org/basics/11
2. "Golang Types." golangbot.com. February 19, 2017. Accessed March 5, 2019. https://golangbot.com/types/
3. "Package fmt." The Go Programming Language. Accessed March 5, 2019. https://golang.org/pkg/fmt/
4. "Functions." A Tour of Go. Accessed March 6, 2019. https://tour.golang.org/basics/4
5. "Golang Control Flow Statements: If, Switch and For." CalliCoder. January 29, 2018. Accessed March 8, 2019. https://www.callicoder.com/golang-control-flow/
6. "The Evolution of Go: A History of Success." QArea Blog. March 20, 2018. Accessed October 14, 2019. https://qarea.com/blog/the-evolution-of-go-a-history-of-success
7. "Working with Files in Go." DevDungeon. August 23, 2015. Accessed October 15, 2019. https://www.devdungeon.com/content/working-files-go
8. "How To Do Math in Go with Operators." How To Code in Go. May 15, 2019. Accessed March 19, 2020. https://www.digitalocean.com/community/tutorials/how-to-do-math-in-go-with-operators
9. "Package math." The Go Programming Language. Accessed March 19, 2020. https://golang.org/pkg/math/
10. "Package rand." The Go Programming Language. Accessed March 19, 2020. https://golang.org/pkg/math/rand/
11. "Getting Started." The Go Programming Language. Accessed April 28, 2020. https://golang.org/doc/install
12. "Go Release Cycle." GitHub golang/go. January 18, 2019. Accessed April 28, 2020. https://github.com/golang/go/wiki/Go-Release-Cycle
13. "Go 1 and the Future of Go Programs." The Go Programming Language. Accessed April 28, 2020. https://golang.org/doc/go1compat
