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
   -  `Learn Go Programming - Golang Tutorial for Beginners <https://www.youtube.com/watch?v=YS4e4q9oBaU&list=WL>`__

Installation
------------

`Download Go <https://golang.org/dl/>`__, extract it, add the new Go binary $PATH and load it. [11]

.. code-block:: sh

   $ export GO_VERSION="1.19.2"
   $ export GO_OS="linux"
   $ export GO_ARCH="amd64"

.. code-block:: sh

   $ wget https://dl.google.com/go/go${GO_VERSION}.${GO_OS}-${GO_ARCH}.tar.gz
   $ tar -C /usr/local -x -z -f go${GO_VERSION}.${GO_OS}-${GO_ARCH}.tar.gz
   $ echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
   $ . ~/.profile

Release Cycle
-------------

A new major ``1.Y`` release of Go comes out every 6 months. Every release gets updates for 1 year before being marked as end-of-life. The first 6 months, Go gets fixes for bugs and security issues. The second/last 6 months only get security fixes. [12] All Go 1 source code using the standard library is guaranteed to be backwards compatible for all ``1.Y`` releases. [13]

Documentation
-------------

The official documentation website for Go is `golang.org/doc/ <https://golang.org/doc/>`__. The unofficial website `godoc.org <https://godoc.org/>`__ provides documentation for many third-party libraries.

The `godoc <https://godoc.org/golang.org/x/tools/cmd/godoc>`__ tool can be used to run the official documentation at locally at ``127.0.0.1:6060``.

.. code-block:: sh

   $ go get golang.org/x/tools/cmd/godoc
   $ godoc

Go has a built in `go doc <https://golang.org/cmd/doc/>`__ command to show documentation from a package or a function within it.

.. code-block:: sh

   $ go doc <PACKAGE>.<SYMBOL>.<FUNCTION>

[16]

Style Guide
-----------

The ``gofmt`` command will automatically format a Go source code file into the standard format. The most common styling mistakes are documented in the `Go Code Review Comments page <https://github.com/golang/go/wiki/CodeReviewComments>`__ on the Go wiki.

.. code-block:: sh

   $ gofmt <FILE>.go # prints to stdout
   $ gofmt -d <FILE>.go # diff the original file and gofmt formatted output
   $ gofmt -w <FILE>.go # apply the format and overwrite the file

Lint
~~~~

Go provides a basic lint tool with ``golint``. It will look for common issues and print out warnings for any that it finds.

golangci-lint
^^^^^^^^^^^^^

A community project called ``golangci-lint`` adds even more lint checks and functionality compared to ``golint``.

Install [33]:

.. code-block:: sh

   $ VER="v1.39.0"
   $ curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/${VER}/install.sh | sh -s -- -b ~/.local/bin ${VER}

View the list of available linters and which ones are currently enabled or disabled. By default, over 50 linters are available. [35]

.. code-block:: sh

   $ golangci-lint linters

False-positives can be ignored by placing a ``//nolint`` comment above the code causing a lint warning. For warnings about the end of a function block ``{ }``, add the comment after the block because adding it before creates a new warning (the last line in a block should not be a comment or whitespace). [34]

Comments
~~~~~~~~

At least the main package needs to have a comment at the beginning to describe what it is and how it can be used. Package comments should start with ``// Package <PACKAGE>``. Comments for other parts of the code such as functions and variables should start with ``// <FUNCTION_NAME>``. [17]

Variables
~~~~~~~~~

-  Variables should be named using English words.
-  Use camelCase and avoid underscores.

   .. code-block:: go

      var foodRating int = 9

-  Constants should be all uppercase characters and use underscores.

   .. code-block:: go

      const MESSAGE_OF_THE_DAY string = "Unauthorized access is not allowed!"

-  Acronyms should be uppercase.

   .. code-block:: go

      var HTTPToken string = "123"

-  Group related variables together.

   .. code-block:: go

      var (
          foo := "hello"
          bar := "world"
      )

-  One-off temporary variables should have a very simple name of around 3 characters or less.

   .. code-block:: go

      for i, n := range car_names {

[26]

Data Types
----------

Overview
~~~~~~~~

-  ``const`` = Constant. This declares that a variable value will never change. The variable can be of any data type.
-  ``bool`` = Boolean. Valid values: ``true`` or ``false``.
-  ``complex64``, ``complex128`` = Complex. A float that supports imaginary numbers.
-  ``float32``, ``float64`` = Float. Large decimal numbers.
-  ``int``, ``int8`` (or ``byte``), ``int16``, ``int32`` (or ``rune``), ``int64`` = Integer. By default, ``int`` will be 32-bit or 64-bit based on the operating system architecture.
-  ``nil`` = An empty/null variable.
-  ``string`` = String. Alphanumeric UTF-8 values. Strings that are written out using double quotes (``"``) only. Single quotes are reserved for defining a rune (single character) data type.
-  ``uint``, ``uint8``, ``uint16``, ``uint32``, ``uint64``, ``uintptr`` = Unsigned integer that only supports positive whole numbers.
-  ``iota`` = An integer that starts at zero. In a variable block declaration, each new ``iota`` variable adds one to the count. This is commonly used as a value for many variables in a ``const`` block. [32]
-  ``_`` = A null character. Anything assigned to this will be discarded. This is useful for loops because Go does not support creating variables that are not used.

Example ``iota`` usage:

.. code-block:: go

   package main
   
   import "fmt"
   
   const (
       foo = iota
       bar
   )

   const (
       _ = iota + 10
       oof
       rab
   )
   
   func main() {
       fmt.Printf("%v\n", foo)
       fmt.Printf("%v\n", bar)
       fmt.Printf("%v\n", oof)
       fmt.Printf("%v\n", rab)
   }

::

   0
   1
   11
   12

Variable Declaration
~~~~~~~~~~~~~~~~~~~~

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

Structs
~~~~~~~

Structs expose a way handle to handle related data that have different data types.

Syntax:

.. code-block:: go

   type <STRUCT_NAME> struct {
       <VAR1_NAME> <VAR1_TYPE>
       <VAR2_NAME> <VAR2_TYPE>
   }

   func main() {
       var <VAR0_NAME> <STRUCT_NAME> = <STRUCT_NAME>{<VAR1_VALUE>, <VAR2_VALUE>}
       <STRUCT_VAR>.<VAR1_NAME> = <NEW_VALUE>
   }

Example:

.. code-block:: go

   package main

   import "fmt"

   type Car struct {
       name string
       mpg int
   }

   func main() {
       // truck short declaration.
       truck := Car{"semitruck", 5}
       // truck long declaration.
       //var truck Car = Car{"semitruck", 5}
       fmt.Printf("The %v gets %v miles per gallon.\n", truck.name, truck.mpg)
       truck.mpg = 7
       fmt.Println("The new model coming out will get", truck.mpg, "miles per gallon.")
   }

::

   The semitruck gets 5 miles per gallon.
   The new model coming out will get 7 miles per gallon.

[18]

Arrays, Slices, and Maps
~~~~~~~~~~~~~~~~~~~~~~~~

Arrays have an index, store one data type, and have a fixed length. If the index will be dynamically changed then it is known as a slice. The declaration of a slice is similar to an array except the length is not specified.

Slices support using ``append()`` to add new elements to it. The ``len()`` function can be used to determine how many elements are in an array, slice, or map. [20]

Syntax:

.. code-block:: go

   var <ARRAY_NAME> [<LENGTH>]<DATA_TYPE> = [<LENGTH>]<DATA_TYPE>{<VALUE_1>, <VALUE_2>}
   var <SLICE_NAME> []<DATA_TYPE> = []<DATA_TYPE>{<VALUE1>, <VALUE2>}
   append(<SLICE_NAME>, <VALUE1>, <VALUE2>)
   len(<ARRAY_SLICE_OR_MAP>)

Define an array and automatically determine the number of elements in it by using ``[...]``:

.. code-block:: go

   var <ARRAY_NAME> [...]<DATA_TYPE> = [...]<DATA_TYPE>{<VALUE_1>, <VALUE_2>}

Valid ways to define a slice:

.. code-block:: go

   // Has a default value of "nil".
   var <SLICE_NAME> []<DATA_TYPE>
   // These two are empty.
   <SLICE_NAME> := []<DATA_TYPE>{}
   <SLICE_NAME> := make([]<DATA_TYPE>, 0)

Example usage of a slice:

.. code-block:: go

   package main
   
   import "fmt"
   
   func main() {
        // student_names is created as a slice.
   	var student_names []string = []string{"bob", "joe"}
   
   	fmt.Printf("Student names loops.\nLoop #1:\n")
   	for index := 0; index < len(student_names); index++ {
   		fmt.Println(index, student_names[index])
   	}
   
   	student_names[0] = "rob"
   	fmt.Println("Loop #2:")
   	for index, name := range student_names {
   		fmt.Println(index, name)
   	}
   
   	student_names = append(student_names, "sal")
   	fmt.Println("Loop #3:")
   	// If the index is not used, it must be assigned to the a null character.
   	// Go does not allow creating variables that will not be used.
   	for _, name := range student_names {
   		fmt.Println("*", name)
   	}
   
        fmt.Println("Length of student_names array:", len(student_names))

::

   Student names loops.
   Loop #1:
   0 bob
   1 joe
   Loop #2:
   0 rob
   1 joe
   Loop #3:
   * rob
   * joe
   * sal
   Length of student_names array: 3

Maps/hashes/dictionaries are unordered key-value stores that can mix and match different data types and have a dynamic length. A key and it's related value can be removed from a map using the ``delete()`` function. Maps do not support ``append()``. [19]

Syntax:

.. code-block:: go

   // Maps have to be initialized first so create an empty map like any other variable will not work.
   // The default value of it will be 'nil'.
   //var <MAP1_NAME> map[<KEY_DATA_TYPE>]<VALUE_DATA_TYPE>
   // Use 'make()' instead.
   var <MAP1_NAME> = make(map[<KEY_DATA_TYPE>]<VALUE_DATA_TYPE>)
   var <MAP2_NAME> = map[<KEY_DATA_TYPE>]<VALUE_DATA_TYPE>{
       <KEY1>: <VALUE1>,
       <KEY2>: <VALUE2>,
   }
   // Add a new key-pair to the map.
   <MAP1_NAME>[<KEY3>] = <VALUE3>
   // Delete an a key-pair from the map.
   delete(<MAP_NAME>, <KEY>)

Example:

.. code-block:: go

   var student_grades map[string]rune = map[string]rune{"joe": 'B', "sal": 'C'}
   student_grades["rob"] = 'A'
   delete(student_grades, "joe")
   fmt.Println("student_grades map:", student_grades)
   for name, grade := range student_grades {
       fmt.Println(name, "has earned a grade of", string(grade), "in the class.")
   }

::

   student_grades map: map[rob: 65 sal:67]
   sal has earned a grade of C in the class.
   rob has earned a grade of A in the class.

Check if an index exists in an array or map. The second return variable will be a true boolean if it exists.

.. code-block:: go

   name, exists = <MAP_NAME>[<INDEX>]

[21]

Pointers
~~~~~~~~

Go supports memory pointers for any data type.

.. code-block:: go

   package main

   import "fmt"

   func main() {
       x := 7
       // Create a pointer variable from an existing variable.
       // `y := &x` is also valid syntax.
       var y *int := &x
       fmt.Println("Value of x:", x)
       fmt.Println("Pointer location of x:", &x)
       fmt.Println("Deference pointer of x:", *&x)
       fmt.Println("Dereference y:", *y)
       fmt.Println("Value of y:", y)
   }

::

   Value of x: 7
   Pointer location of x: 0xc000014060
   Dereference pointer of x: 7
   Dereference y: 7
   Value of y: 0xc000014060

[18]

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

``Sprintf`` is used for formatting strings without printing to standard output.

.. code-block:: go

   soup := "garden vegetable"
   soup_msg := fmt.Sprintf("Today's soup is %v.", soup)
   fmt.Println(soup_msg)

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

Templating
----------

Go provides it's own templating domain specific language (DSL). These templates can be manipulated and rendered using the `text/template <https://golang.org/pkg/text/template/>`__ package.

Functions
~~~~~~~~~

Data interpretation:

-  call = Execute a specified function and optionally provide arguments to it.
-  index = Provide the value of a variable at a specified index.
-  len = Provide the length of a list or map variable.
-  slice = Provide the value of a variable slice.

Print:

-  html = Provide a HTML-escaped string.
-  js = Provide a JSON-escaped string.
-  urlquery = Provide a HTML-escaped URL string.
-  print = Print using ``fmt.Sprint()``.
-  printf = Print with formatting using ``fmt.Sprintf()``.
-  println = Print with newline characters using ``fmt.Sprintln()``.

Operators:

-  Binary/Comparison

   -  eq = Equal to.
   -  ne = Neither to.
   -  lt = Less than.
   -  le = Less than or equal to.
   -  gt = Greater than.
   -  ge = Greater than or equal to.

-  Logical

   -  and
   -  not
   -  or

[27]

Usage and Examples
~~~~~~~~~~~~~~~~~~

Create a no-operation comment.

::

   {{ /* <COMMENT> */ }}

Reference the value provided to the template.

::

   {{ . }}

Reference the value of a variable in a map provided to the template.

::

   {{ .<VARIABLE> }}
   {{ .<VARIABLE>.<KEY1>.<KEY2> }}

Use a binary or logical operator.

::

   {{ if <OPERATOR> <VARIABLE_1> <VARIABLE_2> }}

Check if a variable is defined (not ``nil``).

::

   {{ if .<VARIABLE> }}

Use an ``if`` conditional statement.

::

   {{ if <LOGIC> }}
   {{ else if <LOGIC> }}
   {{ else }}
   {{ end }}

Reference the value of the map, slice, or array at the specified index.

::

   {{ index .<VARIABLE> <INDEX> }}

Find the length of a variable.

::

   {{ len .<VARIABLE_LIST> }}

Save the length to a variable to be used later.

::

   {{ $var_length := len .<VARIABLE_LIST> }}

See if the length of the variable is 10.

::

   {{ if eq $var_length 10 }}

Loop through a list.

::

   {{ with .<VARIABLE_LIST> }}
       {{ range . }}
       {{ .Name }}
   {{ end }}

Define a template in one file and then use it in another.

::

  {{ define "<NESTED_TEMPLATE_NAME>" }}
  {{ end }}

::

   {{ template "<NESTED_TEMPLATE_NAME>" }}

Use a variable from another template.

::

   {{ template "<NESTED_TEMPLATE_NAME>" .<VARIABLE> }}

Loop through every field in each list item.

::

   {{ range .<VARIABLE_LIST> }}
       {{ .<KEY1> }}
       {{ .<KEY2> }}
   {{ end }}

[27][28][29]

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

Functions cannot specify default parameters/inputs. Instead, logic can be added to a function to see if a parameter is an empty variable. [25]

.. code-block:: go

   package main
   
   import "fmt"
   
   func main() {
       var msg string
       echo(msg)
   }
   
   func echo(msg string) {
   
       if msg == "" {
           msg = "Hello world!"
       }
   
       fmt.Println(msg)
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

With using a scanner from ``bfio``, more control can be had. For example, a file can be read line by line.

.. code-block:: go

   package main
   
   import(
          "bufio"
          "fmt"
          "os"
   )
   
   func main() {
        file := "example.txt"
   	file_open, err := os.Open(file)
   
   	if err != nil {
                fmt.Println("Error opening file:", file, "\n", err)
   	}
   	// Required to prevent an internal Go exception when the open file cannot be opened.
   	defer file_open.Close()
   
   	file_scanner := bufio.NewScanner(file_open)
  
        // Print out each line of the file.
        // Scanner.Scan() has a maximum size of 4096 bytes. Use bufio's ReadLine() instead for longer lines.
   	for file_scanner.Scan() {
   		fmt.Println(file_scanner.Text())
   	}
   
   	err = file_scanner.Err()
   
   	if err != nil {
                fmt.Println("Error reading file:", file, "\n", err)
   	}
   }

Logging
-------

The ``log`` package in Go provides a standardized way to manage logs. They are sent to standard error and each log is separated by a newline. Go has three main logging types by default: Print, Fatal, and Panic. [30]

-  Print = The standard call to output a log line.
-  Fatal = After logging, the program will execute ``os.Exit(1)`` which will exit immediately and return an error code of 1.
-  Panic = After logging, the program will execute ``panic()`` and try as much as possible to end all of its processes gracefully.

The default logger will use the format flag ``log.LstdFlags`` which is actually ``log.Ldate|log.Ltime`` to display the date and the time.

.. code-block:: go

   package main
   
   import (
           "log"
   )
   
   func main() {
           log.Println("Hello world")
   }

::

    2021/02/08 11:42:09 Hello world

Consider creating new and separate loggers for ``debug``, ``info``, ``warning``, ``error``, and ``critical``. Those are the log levels that Python uses. [31]

.. code-block:: go

   package main
   
   import (
           "log"
           "os"
   )
   
   func main() {
           warnLog := log.New(os.Stderr, "WARNING: ", log.Ldate|log.Ltime|log.Lshortfile)
           warnLog.Println("This is a test.")
   }

::

   WARNING: 2021/02/08 10:45:39 main.go:15: This is a test.

Log to a file by setting the output stream to an ``os.OpenFile()`` object.

.. code-block:: go

   package main
   
   import (
           "log"
           "os"
   )
   
   func main() {
           logFile, error := os.OpenFile("example.log",
                   os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0600)
           if error != nil {
                   log.Println(error)
           }
           defer logFile.Close()
   
           exampleLogger := log.New(logFile, "", log.LUTC|log.Ldate|log.Ltime|log.Lshortfile)
           exampleLogger.Print("This text will only appear in the example.log file.")
   }

.. code-block:: sh

   $ cat example.log
   2021/02/08 18:21:06 main.go:25: This text will only appear in the example.log file.

Testing
-------

Go natively supports tests with the ``testing`` library. When building binaries, tests are never included to keep them small.

Go tests should be created in a new file named after the primary file or package it will test: ``<FILE_TO_TEST>_test.go``. The tests are defined using the syntax ``func Test<FUNCTION_NAME>(*testing.T) {}``.

Example:

.. code-block:: go

   package hello

   import "fmt"

   func Greeting(phrase string) string {
       if phrase == "hello" {
           return "Hello world!"
       } else if phrase == "goodbye" {
           return "Goodbye cruel world!"
       } else {
           return "Not a valid phrase. Please use 'hello' or 'goodbye'."
       }
   }

   func main() {
       fmt.Println(Greeting("hello"))
       fmt.Println(Greeting("goodbye"))
       fmt.Println(Greeting("unknown"))
   }

.. code-block:: go

   package hello

   import "testing"

   func TestGreeting(t *testing.T) {
       greeting_hello := Greeting("hello")
       // This check is missing the "ld!" at the end of the phrase so it will fail.
       if greeting_hello != "Hello wor" {
           t.Error("Greeting(\"hello\") provided the wrong output:", greeting_hello)
       }
   }

Tests can be run within the current package directory, using a GitHub repository, or a single test file can be tested.

.. code-block:: sh

   $ go test
   $ go test github.com/<USER>/<PROJECT>
   $ go test <MAIN_FILE> <TEST_FILE>

Run a "short mode" test. This will set ``test.Short()`` to True and if then a Test function can end/return if ``t.Skip()`` is called.

.. code-block:: sh

   $ go test -short

.. code-block:: go

   func Test<FUNCTION_NAME>(t *testing.T) {
       if testing.Short() {
           t.Skip("Short mode detected. Skipping test.")
       }
   }

Show the percentage of test coverage.

.. code-block:: sh

   $ go test -cover

Alternatively, a graphical HTML page can be generated with the test coverage results.

.. code-block:: sh

   $ go test -cover -coverprofile=c.out
   $ go tool cover -html=c.out -o coverage.html

Go also supports special benchmark tests as defined using the syntax ``func Benchmark<FUNCTION_NAME>() {}``. These tests are not run by default.

.. code-block:: sh

   $ go test -bench

[14][15]

Go test functions that call the ``t.Parallel()`` function will be marked as being able to run in parallel mode. By default, the ``go test`` command will not run any tests in parallel and requires an additional environment variable or flag to be set.

.. code-block:: sh

   $ GOMAXPROCS=8 go test # method 1
   $ go test -parallel 8 # method 2
   $ go test -cpu=8 # method 3

Other libraries useful for testing:

-  testing/iotest = Functions for testing Readers and Writers.
-  testing/quick = Functions for doing assertations.
-  net/http/httptest = Functions for manipulating and helping test HTTP interactions.

[24]

Libraries
---------

All of the libraries and methods can be found at `https://golang.org/pkg/ <https://golang.org/pkg/>`__. The methods will list all of the possible input and output values.

Standard
~~~~~~~~

(Files)
^^^^^^^

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
'''''''''''''

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

log
^^^

-  Print[f|ln] = Log message. ``Print()`` will automatically add a newline after a log message if there is not one
-  Fatal[f|ln] = Log message and then ``os.Exit(1)``.
-  Panic[f|ln] = Log message and then ``panic()``.
-  SetFlags = Change the flags for the logger.
-  SetOutput = Change the I/O stream for the logger.
-  SetPrefix = Change the prefix for the logger.
-  Flags = Return the value of the flags.
-  Output = Return the value of the output.
-  Prefix = Return the value of the prefix.

[30]

(Logger Object)
'''''''''''''''

These are `methods <https://golang.org/pkg/log/#Logger>`__ that are valid for a ``Logger`` object type.

-  New = Create a new ``Logger()`` object.

   -  out io.Writer = The I/O stream to send logs to. Common values include ``os.Stderr`` or an object of ``os.OpenFile()``.
   -  prefix string = A prefix to use for every log message. This comes before the flags that are set.
   -  flag int = The ``log.<CONSTANT>`` flags to use for standardized date, time, and file name formatting. All of the available constants are listed `here <https://golang.org/pkg/log/#pkg-constants>`__. Common values include ``log.LstdFlags`` and ``log.LUTC|log.Ldate|log.Ltime|log.Lshortfile``.

-  Print[f|ln]
-  Fatal[f|ln]
-  Panic[f|ln]
-  SetFlags
-  SetOutput
-  SetPrefix
-  Flags
-  Output
-  Prefix

[30]

math
^^^^

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

strings
^^^^^^^

This library provides useful functions for manipulating and doing logic checks on strings. [23]

-  Builder = Efficiently create a new string.
-  Compare
-  Contains
-  ContainsAny
-  ContainsRune
-  Count
-  EqualFold
-  Fields
-  FieldsFunc
-  HasPrefix
-  HasSuffix
-  Index
-  IndexAny
-  IndexByte
-  IndexFunc
-  IndexRune
-  Join
-  LastIndex
-  LastIndexAny
-  LastIndexByte
-  LastIndexFunc
-  Map
-  NewReplacer
-  Repeat
-  Replace
-  ReplaceAll
-  Split
-  SplitAfter
-  SplitAfterN
-  SplitN
-  Title
-  ToLower
-  ToLowerSpecial
-  ToTitle
-  ToTitleSpecial
-  ToUpper
-  ToUpperSpecial
-  Trim
-  TrimFunc
-  TrimLeft
-  TrimLeftFunc
-  TrimPrefix
-  TrimRight
-  TrimRightFunc
-  TrimSpace
-  TrimSuffix

testing
^^^^^^^

Some functions are shared between ``type T`` (tests) and ``type B`` (benchmarks). Those are referred to as ``type TB`` functions.

type TB:

-  Error and Errorf = Log output and then Fail.
-  Fail = The current test is marked as failed but tests will continue to run.
-  FailNow = The current test is marked as failed and the program stops immediately.
-  Failed (bool) = If the current function has been marked as failed.
-  Fatal and Fatalf = Log output and then FailNow.
-  Helper = Mark a function as a helper function and not an actual test.
-  Log and Logf = Log output that will be displayed after all tests have succeeded.
-  Name = The current function that is being executed.
-  Skip and Skipf = Log output and then SkipNow.
-  SkipNow = Skip the current function test and continue on with the other tests.
-  Skipped (bool) = If a test was skipped.

type B:

-  ReportMetric (float64) = Report a custom metric.
-  StartTimer = Continue a timer after StopTimer was called.
-  StopTimer = Stop the test timer. When testing is started a timer always starts counting the time until told to stop.

Other ``testing`` functions:

-  Benchmark = Benchmark a single function.
-  BenchmarkResult (struct) = The full benchmark results.
-  Coverage (float64) = The percent of test coverage.
-  Short (bool) = If the ``go test -short`` flag is used.
-  Verbose (bool) = If the ``go test -v`` flag is used.

[14]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/go.rst>`__

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
14. "Package testing." The Go Programming Language. Accessed May 5, 2020. https://golang.org/pkg/testing/
15. "Golang basics - writing unit tests." Alex Ellis' Blog. February 9, 2017. Accessed April 30, 2020. https://blog.alexellis.io/golang-writing-unit-tests/
16. "Go Documentation: godoc, go doc, godoc.org, and go/doc—Which One’s Which?" Whipperstacker. September 30, 2015. Accessed May 1, 2020. http://whipperstacker.com/2015/09/30/go-documentation-godoc-godoc-godoc-org-and-go-doc/
17. "Effective Go." The Go Programming Language. Accessed May 1, 2020. https://golang.org/doc/effective_go.html
18. "More Types." A Tour of Go. Accessed May 3, 2020. https://tour.golang.org/moretypes/1
19. "proposal: extend the "append" built-in to work with maps #17350." GitHub golang/go Issues. October 31, 2017. Accessed May 10, 2020.  https://github.com/golang/go/issues/17350
20. "Understanding Arrays and Slices in Go." DigitalOcean. July 16, 2019. Accessed May 10, 2020. https://www.digitalocean.com/community/tutorials/understanding-arrays-and-slices-in-go
21. "Golang Maps by Example." CalliCoder. March 20, 2018. Accessed May 10, 2020. https://www.callicoder.com/golang-maps/
22. "Package bufio." The Go Programming Language. Accessed May 11, 2020. https://golang.org/pkg/bufio/
23. "Package strings." The Go Programming Language. Accessed May 12, 2020. https://golang.org/pkg/strings
24. "Lesser-Known Features of Go Test." Splice Blog. September 3, 2014. Accessed May 18, 2020. https://splice.com/blog/lesser-known-features-go-test/
25. "Default value in Go's method." Stack Overflow. September 7, 2018. Accessed May 19, 2020. https://stackoverflow.com/questions/19612449/default-value-in-gos-method
26. "Naming Rules." GitHub unknown/go-code-convention. November 6, 2015. Accessed May 26, 2020. https://github.com/unknwon/go-code-convention/blob/master/en-US/naming_rules.md
27. "Package template." The Go Programming Language. Accessed July 30, 2020. https://golang.org/pkg/text/template/
28. "Using Go Templates." Gopher Academy Blog. December 27, 2017. Accessed July 30, 2020. https://blog.gopheracademy.com/advent-2017/using-go-templates/
29. "Golang Templates Cheatsheet." Curtis Vermeeren. September 14, 2017. Accessed July 30, 2020. https://curtisvermeeren.github.io/2017/09/14/Golang-Templates-Cheatsheet
30. "Package log." The Go Programming Language. Accessed February 8, 2021. https://golang.org/pkg/log/
31. "Logging HOWTO." Python documentation. February 8, 2021. Accessed February 8, 2021. https://docs.python.org/3/howto/logging.html
32. "iota - Create Effective Constants in Golang." Medium. September 5, 2020. Accessed March 11, 2021. https://medium.com/swlh/iota-create-effective-constants-in-golang-b399f94aac31
33. "Install." golangci-lint. Accessed April 13, 2021. https://golangci-lint.run/usage/install/
34. "False Positives." golangci-lint. Accessed April 13, 2021. https://golangci-lint.run/usage/false-positives/
35. "Configuration." golangci-lint. Accessed April 19, 2021. https://golangci-lint.run/usage/configuration/
