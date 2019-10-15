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

-  Videos:

   -  `Golang Tutorial - Learn the Go Programming Language <https://www.youtube.com/watch?list=PLSak_q1UXfPp971Hgv7wHCU2gDOb13gBQ&time_continue=14&v=6lBeN973T4Q>`__

Style Guide
-----------

The ``gofmt`` command will automatically format a Go source code file into the standard format. Other manual changes to for best practice on synatx usage can be found `here <https://github.com/golang/go/wiki/CodeReviewComments>`__.

Data Types
----------

-  ``bool`` = Boolean. Valid values: ``true`` or ``false``.
-  ``complex64``, ``complex128`` = Complex. A float that supports imaginary numbers.
-  ``float32``, ``float64`` = Float. Large decimal numbers.
-  ``int``, ``int8`` (or ``byte``), ``int16``, ``int32`` (or ``rune``), ``int64`` = Integer. By default, ``int`` will be 32-bit or 64-bit based on the operating system architecture.
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

A long string consistenting of spaces can be entered by using ``Scanf()`` and quoting the input.

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

If multiple variables share the same data type, they can be consildated by only mentioning the data type once.

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

Certain return variables can be ignored by using "_" as a place holder.

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

The ``switch`` statement is a simplified ``if`` statement to check the value of a variable. Only the first mathced case will be executed.

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

`History <https://github.com/ekultails/rootpages/commits/master/src/programming/golang.rst>`__
----------------------------------------------------------------------------------------------

Bibliography
------------

1. "Basic types." A Tour of Go. Accessed March 5, 2019. https://tour.golang.org/basics/11
2. "Golang Types." golangbot.com. February 19, 2017. Accessed March 5, 2019. https://golangbot.com/types/
3. "Package fmt." The Go Programming Language. Accessed March 5, 2019. https://golang.org/pkg/fmt/
4. "Functions." A Tour of Go. Accessed March 6, 2019. https://tour.golang.org/basics/4
5. "Golang Control Flow Statements: If, Switch and For." CalliCoder. January 29, 2018. Accessed March 8, 2019. https://www.callicoder.com/golang-control-flow/
6. "The Evolution of Go: A History of Success." QArea Blog. March 20, 2018. Accessed October 14, 2019. https://qarea.com/blog/the-evolution-of-go-a-history-of-success
