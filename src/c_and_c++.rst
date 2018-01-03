C and C++
=========

.. contents::

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

An simple C example is provided below:

::

    #include <stdio.h>

    int main() {
        /* This will tell a user "Hello world" */
        printf("Hello world\n");
        return 0;
    }

On Linux, C programs can be compiled with the GNU C compiler (gcc) and
C++ programs with the GNU C++ compiler (g++).

::

    $ gcc hello.c -o hello
    $ ./hello
    Hello world

[3]

Sources:

1. "The C Programming Language." University of Michigan. December 7,
   1992. Accessed November 2, 2017.
   http://groups.engin.umd.umich.edu/CIS/course.des/cis400/c/c.html
2. "Features of C++." Sitesbay. Accessed November 2, 2017.
   https://www.sitesbay.com/cpp/features-of-cpp
3. "Minimal standard c program." SlideShare. May 12, 2016. Accessed
   November 13, 2017.
   https://www.slideshare.net/SwainLoda/minimal-standard-c-program

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

+------+------+------+
| Data | Desc | ``sh |
| Type | ript | ort` |
|      | ion  | `/De |
|      |      | faul |
|      |      | t    |
|      |      | Size |
|      |      | (in  |
|      |      | Bits |
|      |      | )    |
+======+======+======+
| bool | Bool | 1    |
|      | ean. |      |
|      | A    |      |
|      | valu |      |
|      | e    |      |
|      | of   |      |
|      | "tru |      |
|      | e"   |      |
|      | or   |      |
|      | "fal |      |
|      | se." |      |
+------+------+------+
| int  | Inte | 16   |
|      | ger. |      |
|      | A    |      |
|      | whol |      |
|      | e    |      |
|      | numb |      |
|      | er.  |      |
+------+------+------+
| floa | Floa | 32   |
| t    | t.   |      |
|      | A    |      |
|      | deci |      |
|      | mal  |      |
|      | numb |      |
|      | er.  |      |
+------+------+------+
| doub | Doub | 64   |
| le   | le.  |      |
|      | A    |      |
|      | long |      |
|      | er   |      |
|      | and  |      |
|      | more |      |
|      | prec |      |
|      | ise  |      |
|      | numb |      |
|      | er   |      |
|      | due  |      |
|      | to   |      |
|      | allo |      |
|      | wing |      |
|      | doub |      |
|      | le   |      |
|      | the  |      |
|      | amou |      |
|      | nt   |      |
|      | of   |      |
|      | bits |      |
|      | as   |      |
|      | floa |      |
|      | t    |      |
|      | does |      |
|      | .    |      |
+------+------+------+
| char | Char | 8    |
|      | acte |      |
|      | r.   |      |
|      | A    |      |
|      | sing |      |
|      | le   |      |
|      | char |      |
|      | acte |      |
|      | r.   |      |
+------+------+------+
| char | Stri |      |
| \*   | ng.  |      |
|      | A    |      |
|      | coll |      |
|      | ecti |      |
|      | on   |      |
|      | of   |      |
|      | char |      |
|      | acte |      |
|      | rs   |      |
|      | at a |      |
|      | poin |      |
|      | ter  |      |
|      | addr |      |
|      | ess. |      |
+------+------+------+
| std: | Stri | 16   |
| :str | ng   |      |
| ing  | (fro |      |
| (C++ | m    |      |
| )    | the  |      |
|      | "std |      |
|      | "    |      |
|      | name |      |
|      | spac |      |
|      | e).  |      |
|      | A    |      |
|      | text |      |
|      | cont |      |
|      | aini |      |
|      | ng   |      |
|      | one  |      |
|      | or   |      |
|      | more |      |
|      | char |      |
|      | acte |      |
|      | rs.  |      |
+------+------+------+

Integers can be "signed" or "unsigned." An "unsigned" digit can be a
negative number.

Below shows how to assign/create variables using these data types.

Syntax:

::

    <DATA_TYPE> <VARIABLE_NAME> = <VALUE>;

Example:

::

    bool boolean_var = "true";
    long unsigned int integer_var = "-100";
    float float_var = "100.99";
    double double_var = "99.99999999999999999999999999";
    char character = "a";
    char* simple_string = "yes";
    std::string string_var = "Hello world.";

[1]

Blank and/or dynamic variables can be created with the ``new``
functions. These will not be cleaned up and will result in the program
wasting RAM (a memory leak) if not handled correctly. In a class, a
destructor should be used to ``delete`` the variables when an object is
no longer in use. [2] On modern operating systems such as Linux, macOS,
and Windows, any leaked memory from a program will be cleaned up
automatically after the main process is complete.

Syntax:

::

    <DATA_TYPE> <VARIABLE_NAME> = new <DATA_TYPE>;

::

    <ARRAY_VARIABLE_NAME> = new <DATA_TYPE> [<SIZE>];

::

    delete <VARIABLE_NAME>

::

    delete[] <ARRAY_VARIABLE_NAME>

Sources:

1. "Fundamental types. C++ reference. May 14, 2017. Accessed May 21,
   2017. http://en.cppreference.com/w/cpp/language/types
2. "Preventing Memory Leaks in C++ Code." Department of Radio
   Engineering K 13137 CTU FEE Prague. Accessed May 21, 2017.
   http://radio.feld.cvut.cz/Docs4Soft/ptolemy/prog\_man.html/ptlang.doc7.html

Data Types - Arrays
~~~~~~~~~~~~~~~~~~~

Arrays can be used to store multiple values for a certain type of data.
It is similar to defining a variable, except the number of elements (the
size) of the array needs to explicitly be defined. For more dynamic
arrays, use vectors instead.

Syntax:

::

    <DAYA_TYPE> <ARRAY_VARIABLE_NAME> [<SIZE>] = { <VALUE_1>, <VALUE_2>, <VALUE_3> };

::

    <ARRAY_VARIABLE_NAME> = new <DATA_TYPE> [<SIZE>];

Example:

::

    std::string first_array[3] = { "us", "uk", "de" };
    for (int count = 0; count < 3; count++) {
        cout << first_array[count];
    }

::

    empty_array = new float [3];

[1]

Source:

1. "C++ Arrays." Tutorials Point. Accessed May 21, 2017.
   https://www.tutorialspoint.com/cplusplus/cpp\_arrays.htm

Data Types - Vectors (C++)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Vectors are very similar to arrays because they store multiple data
points. However, vectors provide more functionality. Memory cleanup is
automatic, additional functions exist for sorting and retrieving
information, and vectors can be resized.

Include:

::

    #include <vector>

Syntax:

::

    vector<<DATA_TYPE> <VARIABLE_NAME>;

::

    vector<<DATA_TYPE>> <VARIABLE_NAME> (<SIZE>);

Example:

::

    vector<int> restaurant_order_numbers (999);

::

    vector<std::string> (3);

[1]

Source:

1. "C++ Vectors." Cal-linux Tutorials. Accessed May 21, 2017.
   https://cal-linux.com/tutorials/vectors.html

Data Types - Pointers
~~~~~~~~~~~~~~~~~~~~~

Pointers refers to a location in memory and can store multiple values.
In C, this is useful because pointers can be used as array to create
things such as a string from multiple characters. A pointer can only be
associated with one data type and cannot be resized. For C++, it is
recommended to use vectors instead. Pointers will require manual memory
cleanup with a ``delete`` statement.

There are a few different ways to define a pointer.

Syntax:

::

    <DATA_TYPE> *<POINTER>

::

    <DATA_TYPE>* <POINTER>;

::

    <DATA_TYPE> * <POINTER>;

Example:

::

    char *pointer_variable;

It is possible to get the pointer address of an existing variable.

Syntax:

::

    &<VARIABLE_NAME>

Example:

::

    int *the_answer_to_life; // pointer int
    int answer = 42; // int
    the_answer_to_life = &answer; // point to the address location of the "answer" variable
    cout << *the_answer_to_life << endl; // 42

C and C++ do not provide a native way to see how many elements are in an
array. The most simple method is to find the size of one element in the
array and then the size of the entire array.

Example of founding the size of array ``x``:

::

    char x[5] = {'h', 'e', 'l', 'l', 'o' };
    int x_array_size = sizeof(x) / sizeof(*x);

The GNU C Compiler (GCC) provides the "ARRAY\_SIZE" to do this
automatically.

Example:

::

    char x[5] = {'w', 'o', 'r', 'l', 'd' };
    int x_array_size = ARRAY_SIZE(x);

[2]

Sources:

1. "Pointers, References and Dynamic Memory Allocation." Nanyang
   Technoligcal University. Accessed May 21, 2017.
   https://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp4\_PointerReference.html
2. "GCC \*is\* wonderful: a better ARRAY\_SIZE macro." Zubplot. January
   4, 2015. Accessed December 3, 2017.
   http://zubplot.blogspot.com/2015/01/gcc-is-wonderful-better-arraysize-macro.html

Data Types - Structs and Unions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Both a "struct" and a "union" store multiple variables within themselves. A struct can have variables that are of different data types. The memory allocated to the struct is equal to the memory allocation of each variable within it combined. A union should only contain one data type. The union is only allocated memory for the data type that is the largest. This memory is shared between all variables which is why they should be the same type or else a variable might not contain it's full value when read. [1]

`struct` syntax:

::

  struct <NAME> {
      <DATA_TYPE_1> <VARIABLE_NAME_1>;
      <DATA_TYPE_2> <VARIABLE_NAME_2>;
      <DATA_TYPE_3> <VARIABLE_NAME_3>;
  } <NAME>

`union` syntax:

::

  union <NAME> {
      <DATA_TYPE_1> <VARIABLE_NAME_1>;
      <DATA_TYPE_1> <VARIABLE_NAME_2>;
      <DATA_TYPE_1> <VARIABLE_NAME_3>;
  } <NAME>

A variable in a struct or union can be referenced using it's name, a period, and then the actual variable name.

::

  <STRUCT_OR_UNION_NAME>.<VARIABLE_NAME>;

Source:

1. "Difference between a Structure and a Union." Stack Overflow. July 13, 2014. Accessed January 2, 2018. https://stackoverflow.com/questions/346536/difference-between-a-structure-and-a-union

Data Types - Scope
~~~~~~~~~~~~~~~~~~

-  Local = Defined within a function. This cannot be referenced by
   another function.
-  Global = Defined outside of the main function. This can be used by
   any function.
-  Static = There is only one static variable that is shared between
   different objects from the same class. The keyword ``static`` must be
   used when defining the variable.
-  Final = This variable is set once and cannot be changed. The keyword
   ``final`` must be used when defining the variable. [1]

Source:

1. "Variables in C++." Studytonight. Accessed May 21, 2017.
   http://www.studytonight.com/cpp/variables-scope-details.php

Conditionals
------------

Conditionals - Operators
~~~~~~~~~~~~~~~~~~~~~~~~

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

[1]

Source:

1. "[C++] Operators." cpluspluss.com. Accessed May 21, 2017.
   http://www.cplusplus.com/doc/tutorial/operators/

Conditionals - If
~~~~~~~~~~~~~~~~~

If statements execute a task if an expression of comparing two or more
things is returned as true.

Syntax:

::

    if (<TRUE_STATEMENT>) {
        // <DO_SOMETHING_1>
    } else if (<TRUE_STATEMENT>) {
        // <DO_SOMETHING_2>
    } else {
        // <DO_SOMETHING_3>
    }

Example:

::

    if ( number_of_cats_owned > 9 ) {
        cat_lover = true;

::

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

[1]

Source:

1. "Lesson 2: If statements in C++." Cprogramming.com. Accessed May 21,
   2017. http://www.cprogramming.com/tutorial/lesson2.html

Conditionals - Switch
~~~~~~~~~~~~~~~~~~~~~

Switches provide a good way to execute a task based on a specific value
of a variable. If a switch condition is met, it is a good idea to a
"break" statement to exit the switch. For more complex comparisons, use
"if" conditionals instead of the "switch."

Syntax:

::

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

::

    int number_of_forks = 3;
    switch(number_of_forks) {
      case 1 : cout << "There is one fork.";
      case 2 : cout << "There are two forks.";
      case 3 : cout << "There are three forks.";
      default: cout << "There are too few or too many forks on the table.";
    }

[1]

Source:

1. "[C++] switch statement." C++ reference. March 6, 2017. Accessed May
   21, 2017. http://en.cppreference.com/w/cpp/language/switch

Conditionals - For
~~~~~~~~~~~~~~~~~~

For loops initialize a variable, check if a comparison of an expression
is true, and then increments the initialized variable. This is useful
for running a loop a specific number of times.

Syntax:

::

    for ( <INITIALIZE>; <COMPAIRISON>; <INCREMENT>) {
        // <DO_SOMETHING>
    }

Example:

::

    count << "The countdown started."
    for ( int count = 10; 0 < count ; --count) {
        cout << count;
    }

[1]

Source:

1. "C++ for loop." Tutorials Point. Accessed May 21, 2017.
   https://www.tutorialspoint.com/cplusplus/cpp\_arrays.htm

Conditionals - While
~~~~~~~~~~~~~~~~~~~~

While statements can be used to continually run a task while a statement
is true. A "do-while" statement uses the same concept and guarantees
that the tasks will be run at least once.

Syntax:

::

    while (<EXPRESSION>) {
        // <DO_SOMETHING>
    }

::

    do {
        // <DO_SOMETHING>
    } while (<EXPRESSION)

Example:

::

    std::string every_fruit = { "apples", "bananas", "oranges"}
    std::string fruit = new std::string();
    while (fruit != "orange") {
        fruit = every_fruit[random_number];
        cout << "This fruit is: " << fruit << endl;
    }

[1]

Source:

1. "C++ while and do...while Loop." Progamiz. Accessed May 21, 2017.
   https://www.programiz.com/cpp-programming/do-while-loop

Input and Output
----------------

Input and Output - Terminal
~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

::

    cout << "<TEXT>";

::

    printf("<TEXT>");

::

    scanf("<FORMATER>", <VARIABLE>);

::

    cin >> <VARIABLE>;

Example:

::

    string w = "world";
    printf("Hello %s\n", string w  );

[1]

Source:

1. "C++ Programming Language Stream IO and File IO." Nanyang
   Technological University. May, 2013. Accessed May 21, 2017.
   http://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp10\_io.html
