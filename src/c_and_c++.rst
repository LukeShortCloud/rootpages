C and C++
=========

.. contents:: Table of Contents

Introduction
------------

C was created in 1972 as an easier and more portable alternative to
assembly language. It is a procedural and human readable language. [1] C
is ideal for some projects such as writing hardware drivers and
operating systems. C++ was created in 1979 as an enhanced version of C.
It is also backwards compatible with C. Conversely, C is not forward
compatible with C++.

Features of C++:

-  Object oriented programming
-  Exception handling
-  Better memory management

[2]

Most lines in C need to end with a semi-colon. The only exceptions are
for library inclusion and defining a function or conditional

Every C program requires the "main" function. It uses the data type
"int" (integer) because when the program ends, it returns a numerical
return code. The default is "0" for success.

If a developer wants to receive standard input from a user or provide
standard output, then the C standard input/out (stdio) library needs to
be included. This is not included by default to keep C program
dependencies explicit and minimal.

Comments can be placed throughout the code as a reminder of why
something is done a certain way. This is a human note to help any
developer working on the program to understand the reasoning for how the
program was coded. These comment blocks have to start with ``/*`` and
end with a ``*/``.

A simple C example is provided below:

.. code-block:: c

    #include <stdio.h>

    int main() {
        /* This will tell a user "Hello world" */
        printf("Hello world\n");
        return 0;
    }

On Linux, C programs can be compiled with the GNU C compiler (gcc) and
C++ programs with the GNU C++ compiler (g++).

.. code-block:: sh

    $ gcc hello.c -o hello
    $ ./hello
    Hello world

[3]

Tutorials
---------

This is an additional list of tutorials and reference guides for
becoming familiar with C and C++.

-  C

   -  Websites

      -  `Cprogramming.com <http://www.cprogramming.com/tutorial.html>`__

-  C++

   -  Websites

      -  `cplusplus.com <http://www.cplusplus.com/doc/tutorial/>`__
      -  `LearnCpp.com <http://www.learncpp.com/>`__

   -  Videos

      -  `The New
         Boston <https://www.thenewboston.com/videos.php?cat=16>`__

Data Types
----------

+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| Data              | Description                                                                                                    | Default `short` Size in Bits |
+===================+================================================================================================================+==============================+
| bool              | Boolean. A value of "true" or "false."                                                                         | 1                            |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| int               | Integer. A whole number.                                                                                       | 16                           |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| float             | Float. A decimal number.                                                                                       | 32                           |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| double            | Double. A longer and more precise number. This is due to allowing double the amount of bits than `float` does. | 64                           |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| char              | Character. A single character.                                                                                 | 8                            |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| char \*           | String. A collection of one or more characters at a pointer address.                                           |                              |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+
| std::string (C++) | String (from the "std" namespace). A collection containing one or more characters.                             | 16                           |
+-------------------+----------------------------------------------------------------------------------------------------------------+------------------------------+

Integers can be "signed" or "unsigned." An "unsigned" digit can be a
negative number.

Below shows how to create variables using these data types.

Syntax:

.. code-block:: c

    <DATA_TYPE> <VARIABLE_NAME> = <VALUE>;

Examples:

.. code-block:: c++

    bool boolean_var = "true";
    long unsigned int integer_var = "-100";
    float float_var = "100.99";
    double double_var = "99.99999999999999999999999999";
    char character = "a";
    char* simple_string = "yes";
    std::string string_var = "Hello world.";

[4]

Blank and/or dynamic variables can be created with the ``new``
functions. These will not be cleaned up and will result in the program
wasting RAM (a memory leak) if not handled correctly. In a class, a
destructor should be used to ``delete`` the variables when an object is
no longer in use. [5] On modern operating systems such as Linux, macOS,
and Windows, any leaked memory from a program will be cleaned up
automatically after the main process is complete.

Syntax:

.. code-block:: c

    <DATA_TYPE> <VARIABLE_NAME> = new <DATA_TYPE>;

.. code-block:: c

    <ARRAY_VARIABLE_NAME> = new <DATA_TYPE> [<SIZE>];

.. code-block:: c

    delete <VARIABLE_NAME>

.. code-block:: c

    delete[] <ARRAY_VARIABLE_NAME>

Arrays
~~~~~~

Arrays can be used to store multiple values for a certain type of data.
It is similar to defining a variable, except the number of elements (the
size) of the array needs to explicitly be defined. For more dynamic
arrays, use vectors instead.

Syntax:

.. code-block:: c

    <DAYA_TYPE> <ARRAY_VARIABLE_NAME> [<SIZE>] = { <VALUE_1>, <VALUE_2>, <VALUE_3> };

.. code-block:: c

    <ARRAY_VARIABLE_NAME> = new <DATA_TYPE> [<SIZE>];

Example:

.. code-block:: c++

    std::string first_array[3] = { "us", "uk", "de" };

    for (int count = 0; count < 3; count++) {
        cout << first_array[count];
    }

.. code-block:: c

    empty_array = new float [3];

[6]

Vectors (C++)
~~~~~~~~~~~~~

Vectors are very similar to arrays because they store multiple data
points. However, vectors provide more functionality. Memory cleanup is
automatic, additional functions exist for sorting and retrieving
information, and vectors can be resized.

Include:

.. code-block:: c++

    #include <vector>

Syntax:

.. code-block:: c++

    vector<<DATA_TYPE> <VARIABLE_NAME>;

.. code-block:: c++

    vector<<DATA_TYPE>> <VARIABLE_NAME> (<SIZE>);

Example:

.. code-block:: c++

    vector<int> restaurant_order_numbers (999);

.. code-block:: c++

    vector<std::string> (3);

[7]

Pointers
~~~~~~~~

Pointers refers to a location in memory and can store multiple values.
In C, this is useful because pointers can be used as array to create
things such as a string from multiple characters. A pointer can only be
associated with one data type and cannot be resized. For C++, it is
recommended to use vectors instead. Pointers will require manual memory
cleanup with a ``delete`` statement. [8]

There are a few different ways to define a pointer.

Syntax:

.. code-block:: c

    <DATA_TYPE> *<POINTER>

.. code-block:: c

    <DATA_TYPE>* <POINTER>;

.. code-block:: c

    <DATA_TYPE> * <POINTER>;

Example:

.. code-block:: c

    char *pointer_variable;

It is possible to get the pointer address of an existing variable.

Syntax:

.. code-block:: c

    &<VARIABLE_NAME>

Example:

.. code-block:: c++

    int *the_answer_to_life; // pointer int
    int answer = 42; // int
    the_answer_to_life = &answer; // point to the address location of the "answer" variable
    cout << *the_answer_to_life << endl; // 42

C and C++ do not provide a native way to see how many elements are in an
array. The most simple method is to find the size of one element in the
array and then the size of the entire array.

Example of founding the size of array ``x``:

.. code-block:: c

    char x[5] = {'h', 'e', 'l', 'l', 'o' };
    int x_array_size = sizeof(x) / sizeof(*x);

The GNU C Compiler (GCC) provides the "ARRAY\_SIZE" to do this
automatically. [9]

Example:

.. code-block:: c

    char x[5] = {'w', 'o', 'r', 'l', 'd' };
    int x_array_size = ARRAY_SIZE(x);

Structures and Unions
~~~~~~~~~~~~~~~~~~~~~

Both a "struct" and a "union" store multiple variables within themselves. A struct can have variables that are of different data types. The memory allocated to the struct is equal to the memory allocation of each variable within it combined. A union should only contain one data type. The union is only allocated memory for the data type that is the largest. This memory is shared between all variables which is why they should be the same type or else a variable might not contain it's full value when read. [10]

Structure syntax:

.. code-block:: c

  struct <NAME> {
      <DATA_TYPE_1> <VARIABLE_NAME_1>;
      <DATA_TYPE_2> <VARIABLE_NAME_2>;
      <DATA_TYPE_3> <VARIABLE_NAME_3>;
  } <NAME>

Union syntax:

.. code-block:: c

  union <NAME> {
      <DATA_TYPE_1> <VARIABLE_NAME_1>;
      <DATA_TYPE_1> <VARIABLE_NAME_2>;
      <DATA_TYPE_1> <VARIABLE_NAME_3>;
  } <NAME>

A variable in a struct or union can be referenced using it's name, a period, and then the actual variable name.

.. code-block:: c

  <STRUCT_OR_UNION_NAME>.<VARIABLE_NAME>;

Scope
~~~~~

-  Local = Defined within a function. This cannot be referenced by
   another function.
-  Global = Defined outside of the main function. This can be used by
   any function.
-  Static = There is only one static variable that is shared between
   different objects from the same class. The keyword ``static`` must be
   used when defining the variable.
-  Constant = This variable is set once and cannot be changed. The keyword
   ``const`` must be used when defining the variable. [11]
- Final (C++) = This is exactly like a Constant and it also extends to classes and objects in that their parent virtual functions cannot be overridden. Use the keyword ``final``. [12]

Conditionals
------------

Operators
~~~~~~~~~

Conditional statements require comparison operators. If the outcome of
the operator is true then the conditional will execute.

+-----------------------+----------------------------+
| Comparison Operator   | Description                |
+=======================+============================+
| ==                    | Equal                      |
+-----------------------+----------------------------+
| !=                    | Not Equal                  |
+-----------------------+----------------------------+
| <                     | Less than                  |
+-----------------------+----------------------------+
| >                     | Greater than               |
+-----------------------+----------------------------+
| <=                    | Less than or Equal to      |
+-----------------------+----------------------------+
| >=                    | Greater than or Equal to   |
+-----------------------+----------------------------+

Using logical operators allows for multiple statements to be compared.

+--------------------+----------------------------------------+
| Logical Operator   | Description                            |
+====================+========================================+
| !                  | The statement must be false.           |
+--------------------+----------------------------------------+
| &&                 | Both statements must be true.          |
+--------------------+----------------------------------------+
| \|\|               | At least one statement must be true.   |
+--------------------+----------------------------------------+

[13]

If
~~

If statements execute a task if an expression of comparing two or more
things is returned as true.

Syntax:

.. code-block:: c

    if (<TRUE_STATEMENT>) {
        // <DO_SOMETHING_1>
    } else if (<TRUE_STATEMENT>) {
        // <DO_SOMETHING_2>
    } else {
        // <DO_SOMETHING_3>
    }

Example:

.. code-block:: c

    if ( number_of_cats_owned > 9 ) {
        cat_lover = true;

.. code-block:: c

    if ( number_of_dogs_owned == 0 ) {
        dog_lover = false;
        dog_owner = false;
    } else if ( number_of_dogs_owned > 9 ) {
        dog_lover = true;
        dog_owner = true;
    } else {
        dog_lover = false;
        dog_owner = true;
    }

[14]

Switch
~~~~~~

Switches provide a good way to execute a task based on a specific value
of a variable. If a switch condition is met, it is a good idea to a
"break" statement to exit the switch. For more complex comparisons, use
"if" conditionals instead of the "switch."

Syntax:

.. code-block:: c

    switch(<VARIABLE>) {
        case <VALUE_1> : <DO>;
                         <SOMETHING>;
                         <HERE>;
                         break;
        case <VALUE_2> : <DO_SOMETHING_HERE>;
                         break;
        default: <DO_SOMETHING_HERE>;
                 break;
    }

Example:

.. code-block:: c++

    int number_of_forks = 3;
    switch(number_of_forks) {
      case 1 : cout << "There is one fork.";
      case 2 : cout << "There are two forks.";
      case 3 : cout << "There are three forks.";
      default: cout << "There are too few or too many forks on the table.";
    }

[15]

For
~~~

For loops initialize a variable, check if a comparison of an expression
is true, and then increments the initialized variable. This is useful
for running a loop a specific number of times.

Syntax:

.. code-block:: c

    for ( <INITIALIZE>; <COMPARISON>; <INCREMENT>) {
        // <DO_SOMETHING>
    }

Example:

.. code-block:: c++

    count << "The countdown started.";

    for ( int count = 10; 0 < count ; --count) {
        cout << count;
    }

[16]

While
~~~~~

While statements can be used to continually run a task while a statement
is true. A "do-while" statement uses the same concept and guarantees
that the tasks will be run at least once.

Syntax:

.. code-block:: c

    while (<EXPRESSION>) {
        // <DO_SOMETHING>
    }

.. code-block:: c

    do {
        // <DO_SOMETHING>
    } while (<EXPRESSION)

Example:

.. code-block:: c++

    std::string every_fruit = { "apples", "bananas", "oranges"}
    std::string fruit = new std::string();

    while (fruit != "orange") {
        fruit = every_fruit[random_number];
        cout << "This fruit is: " << fruit << endl;
    }

[17]

Libraries
---------

stdlib
~~~~~~

-  abort = End the current program immediately without running cleanup tasks defined by `atexit`.
-  abs = Find the absolute (positive) value of an integer.
-  atof = Convert a string to a float number.
-  atoi = Convert a string into an integer number.
-  atol = Convert a string into a long number.
-  calloc = Initialize the memory to 0, as a placeholder, and expand it if this function is executed.
-  delay = Pause the program for a specified number of seconds.
-  div = A division math function.
-  exit = End the current program immediately.
-  free = Free memory that was manually allocated by calloc, malloc, and/or realloc.
-  getenv = Lookup a given environment variable from the shell.
-  malloc = Manually allocate memory if this function is executed.
-  perror = Display the last error that occurred.
-  putenv = Modify an existing environment variable's value.
-  rand = Generate a random number, based on the `srand` seed.
-  realloc = Reallocate memory to a new position in RAM so that it can either be increased or decreased in size.
-  setenv = Set an environment variable for the shell.
-  srand = Seed the random number generator. This number will affect what pseudo random numbers that are generated by `rand`.
-  strtod = Convert a string to a double number.
-  strtol = Convert a string to a long number.
-  system = Execute other system programs.

[22]

Input and Output
----------------

Terminal
~~~~~~~~

Text from a terminal can either be displayed (standard output) and/or
saved as a variable (standard input). C++ can even use C standard
input/output functions since they are compatible.

+----------+----------+------------+
| Name     | Type     | Language   |
+==========+==========+============+
| printf   | Output   | C          |
+----------+----------+------------+
| cout     | Output   | C++        |
+----------+----------+------------+
| scanf    | Input    | C          |
+----------+----------+------------+
| cin      | Input    | C++        |
+----------+----------+------------+

Syntax:

.. code-block:: c++

    cout << "<TEXT>";

.. code-block:: c

    printf("<TEXT>");

.. code-block:: c

    scanf("<FORMATER>", <VARIABLE>);

.. code-block:: c++

    cin >> <VARIABLE>;

Example:

.. code-block:: c

    string w = "world";
    printf("Hello %s\n", string w  );

[18]

Argument Parsing
''''''''''''''''

Command-line arguments, given to a compiled program, are stored into two variables: an int `argc` and a char array `argv`. The "argc" variable contains the number of command line arguments that were given to the program, including itself. The "argv" variable contains an array of strings that are the actual arguments. These two variables have to be defined as function arguments for the "main" function. [19]

Example:

.. code-block:: c

    #include <stdio.h>

    int main(int argc, char *argv[])
    {
        printf("There are %d arguments.\n", argc);
        printf("The program name is: %s\n", argv[0]);
        printf("The first command-line argument is: %s\n", argv[1]);
    }

.. code-block:: sh

    $ gcc example.c -o example
    $ ./example 123
    There are 2 arguments.
    The program name is: ./example
    The first command-line argument is: 123

Files
~~~~~

Files use the "FILE" data type. In C, there are 9 different functions that can be used for reading and writing contents of a file.

- fgetc/fputc
- fgets/fputs
- fread/fwrite

Using fread and frwrite is preferred for larger files due to the performance improvement of not having to read or write contents of the storage device constantly. Instead, a buffer is used to read or write many characters at once. Use fgetc and fputc for processing smaller files faster. [20] The `fopen()` and `fclose()` functions are used to open and close a file.

fopen requires two arguments: the file name and the mode to open it in.

Valid modes [21]:

- a = Append write.
- a+ = Read and append write.
- r = Read.
- r+ = Read and write.
- w = Write and remove the contents of the file.
- w+ = Read and then remove the contents of the file before writing.

Syntax:

.. code-block:: c

    fopen("<FILE_NAME>", "<MODE>");

When a file is done being read and/or written to then it needs to be closed to prevent a memory leak.

Syntax:

.. code-block:: c

    fclose(<FILE_VARIABLE>);

fgetc example:

.. code-block:: c

    #include <stdio.h>

    int main() {
        FILE *file_to_read;
        char buffer;

        file_to_read = fopen("/etc/hosts", "r");

        if (file_to_read == NULL) {
            perror("Unable to read the file.\n");
        } else {
            printf("The file was read.\n");
        }

        while ( (buffer=fgetc(file_to_read)) != EOF) {
            printf("%c", buffer);
        }

        fclose(file_to_read);
    }

`Errata <https://github.com/ekultails/rootpages/commits/master/src/c_and_c++.rst>`__
------------------------------------------------------------------------------------

Bibliography
------------

1. "The C Programming Language." University of Michigan. December 7, 1992. Accessed November 2, 2017. http://groups.engin.umd.umich.edu/CIS/course.des/cis400/c/c.html
2. "Features of C++." Sitesbay. Accessed November 2, 2017. https://www.sitesbay.com/cpp/features-of-cpp
3. "Minimal standard c program." SlideShare. May 12, 2016. Accessed November 13, 2017. https://www.slideshare.net/SwainLoda/minimal-standard-c-program
4. "Fundamental types. C++ reference. May 14, 2017. Accessed May 21, 2017. http://en.cppreference.com/w/cpp/language/types
5. "Preventing Memory Leaks in C++ Code." Department of Radio Engineering K 13137 CTU FEE Prague. Accessed May 21, 2017. http://radio.feld.cvut.cz/Docs4Soft/ptolemy/prog\_man.html/ptlang.doc7.html
6. "C++ Arrays." Tutorials Point. Accessed May 21, 2017. https://www.tutorialspoint.com/cplusplus/cpp\_arrays.htm
7. "C++ Vectors." Cal-linux Tutorials. Accessed May 21, 2017. https://cal-linux.com/tutorials/vectors.html
8. "Pointers, References and Dynamic Memory Allocation." Nanyang Technoligcal University. Accessed May 21, 2017. https://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp4\_PointerReference.html
9. "GCC \*is\* wonderful: a better ARRAY\_SIZE macro." Zubplot. January 4, 2015. Accessed December 3, 2017. http://zubplot.blogspot.com/2015/01/gcc-is-wonderful-better-arraysize-macro.html
10. "Difference between a Structure and a Union." Stack Overflow. July 13, 2014. Accessed January 2, 2018. https://stackoverflow.com/questions/346536/difference-between-a-structure-and-a-union
11. "Variables in C++." Studytonight. Accessed May 21, 2017. http://www.studytonight.com/cpp/variables-scope-details.php
12. "C++ final specifier." GeeksForGeeks. January 4, 2017. https://www.geeksforgeeks.org/c-final-specifier/
13. "[C++] Operators." cpluspluss.com. Accessed May 21, 2017. http://www.cplusplus.com/doc/tutorial/operators/
14. "Lesson 2: If statements in C++." Cprogramming.com. Accessed May 21, 2017. http://www.cprogramming.com/tutorial/lesson2.html
15. "[C++] switch statement." C++ reference. March 6, 2017. Accessed May 21, 2017. http://en.cppreference.com/w/cpp/language/switch
16. "C++ for loop." Tutorials Point. Accessed May 21, 2017. https://www.tutorialspoint.com/cplusplus/cpp\_arrays.htm
17. "C++ while and do...while Loop." Progamiz. Accessed May 21, 2017. https://www.programiz.com/cpp-programming/do-while-loop
18. "C++ Programming Language Stream IO and File IO." Nanyang Technological University. May, 2013. Accessed May 21, 2017. http://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp10\_io.html
19. "C Tutorial – More on Functions." CodingUnit Programming Tutorials. Accessed January 11, 2018. https://www.codingunit.com/c-tutorial-more-on-c-functions
20. "Disk I/O in C – avoid fgetc/fputc." Left 404. March 17, 2011. Accessed January 12, 2018. http://left404.com/2011/03/17/disk-io-in-c-avoid-fgetcfputc/
21. "File Handling in C with Examples (fopen, fread, fwrite, fseek)." The Geek Stuff. July 9, 2012. Accessed January 13, 2018. https://www.thegeekstuff.com/2012/07/c-file-handling
22. "C – stdlib.h library functions." Fresh2Refresh. Accessed January 31, 2018. https://fresh2refresh.com/c-programming/c-function/c-stdlib-h-library-functions/
