# C++

* Introduction
* [Tutorials](#tutorials)
* [Data Types](#data-types)
    * [Arrays](#data-types---arrays)
    * [Vectors](#data-types---vectors)
    * [Pointers](#data-types---pointers)
    * [Scope](#data-types---scope)
* [Conditionals](#conditionals)
    * [Operators](#conditionals---operators)
    * [If](#conditionals---if)
    * [Switch](#conditionals---switch)
    * [For](#conditionals---for)
    * [While](#conditionals---while)
* [Input and Output](#input-and-output)
    * [Terminal](#input-and-output---terminal)
    * File
* Functions
    * Scope
* Templates
* Libraries
* Object Oriented
* Differences Between C and C++


# Tutorials

This is an additional list of tutorials and reference guides for becoming familiar with C++.

* Websites
    * [cplusplus.com](http://www.cplusplus.com/doc/tutorial/)
    * [Cprogramming.com](http://www.cprogramming.com/tutorial.html)
    * [LearnCpp.com](http://www.learncpp.com/)
* Videos
    * [The New Boston](https://www.thenewboston.com/videos.php?cat=16 )


# Data Types

| Data Type | Description | `short`/Default Size (in Bits) | `long` Size (in Bits) |
| --- | --- | --- |
| bool | Boolean. A value of "true" or "false." | 1 | N/A |
| int | Integer. A whole number. | 16 | 32 |
| float | Float. A decimal number. | 32 | N/A |
| double | Double. A longer and more precise number. | 64 | 80 |
| char | Character. A single character. | 8 | N/A |
| std::string | String (from the "std" namespace). A text containing one or more characters. | 16 | N/A |

Integers can be "signed" or "unsigned." An "unsigned" digit can be a negative number.

Below shows how to assign/create variables using these data types.

Syntax:

```
<DATA_TYPE> <VARIABLE_NAME> = <VALUE>;
```

Example:

```
bool boolean_var = "true";
long unsigned int integer_var = "-100";
float float_var = "100.99";
double double_var = "99.99999999999999999999999999";
char character = "a";
std::string string_var = "Hello world.";
```

[1]

Blank and/or dynamic variables can be created with the `new` functions. These will not be cleaned up and will result in the program wasting RAM (a memory leak) if not handled correctly. In a class, a destructor should be used to `delete` the variables when an object is no longer in use. [2] On modern operating systems such as Linux, macOS, and Windows, any leaked memory from a program will be cleaned up automatically after the main process is complete.

Syntax:

```
<DATA_TYPE> <VARIABLE_NAME> = new <DATA_TYPE>;
```
```
<ARRAY_VARIABLE_NAME> = new <DATA_TYPE> [<SIZE>];
```
```
delete <VARIABLE_NAME>
```
```
delete[] <ARRAY_VARIABLE_NAME>
```

Sources:

1. "Fundamental types. C++ reference. May 14, 2017. Accessed May 21, 2017. http://en.cppreference.com/w/cpp/language/types
2. "Preventing Memory Leaks in C++ Code." Department of Radio Engineering K 13137 CTU FEE Prague. Accessed May 21, 2017. http://radio.feld.cvut.cz/Docs4Soft/ptolemy/prog_man.html/ptlang.doc7.html


## Data Types - Arrays

Arrays can be used to store multiple values for a certian type of data. It is similar to defining a variable, except the number of elements (the size) of the array needs to explicitly be defined. For more dynamic arrays, use vectors instead.

Syntax:

```
<DAYA_TYPE> <ARRAY_VARIABLE_NAME> [<SIZE>] = { <VALUE_1>, <VALUE_2>, <VALUE_3> };
```
```
<ARRAY_VARIABLE_NAME> = new <DATA_TYPE> [<SIZE>];
```

Example:

```
std::string first_array[3] = { "us", "uk", "de" };
for (int count = 0; count < 3; count++) {
	cout << first_array[count];
}
```
```
empty_array = new float [3];
```


[1]

Source:

1. "C++ Arrays." Tutorials Point. Accessed May 21, 2017. https://www.tutorialspoint.com/cplusplus/cpp_arrays.htm


# Data Types - Vectors

Vectors are very similar to arrays because they store multiple data points. However, vectors provide more functionality. Memory cleanup is automatic, additional functions exist for sorting and retrieving information, and vectors can be resized.

Include:
```
#include <vector>
```

Syntax:

```
vector<<DATA_TYPE> <VARIABLE_NAME>;
```
```
vector<<DATA_TYPE>> <VARIABLE_NAME> (<SIZE>);
```

Example:

```
vector<int> resturant_order_numbers (999);
```
```
vector<std::string> (3);
```

[1]

Source:

1. "C++ Vectors." Cal-linux Tutorials. Accessed May 21, 2017. https://cal-linux.com/tutorials/vectors.html


# Data Types - Pointers

Pointers refers to a location in memory and can store multiple values. In C, this is useful because pointers can be used as arrays. A pointer can only be associated with one data type and cannot be resized. For C++, it is recommended to use vectors instead. Pointers will require manual memory cleanup with a `delete` statement.

There are a few different ways to define a pointer.

Syntax:

```
<DATA_TYPE> *<POINTER>
```
```
<DATA_TYPE>* <POINTER>;
```
```
<DATA_TYPE> * <POINTER>;
```

Example:

```
char *pointer_variable;
```

It is possible to get the pointer address of an existing variable.

Syntax:

```
&<VARIABLE_NAME>
```

Example:

```
int *the_answer_to_life; // pointer int
int answer = 42; // int
the_answer_to_life = &answer; // point to the address location of the "answer" variable
cout << *the_answer_to_life << endl; // 42
```

[1]

Source:

1. "Pointers, References and Dynamic Memory Allocation." Nanyang Technoligcal University. Accessed May 21, 2017. https://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp4_PointerReference.html


# Data Types - Scope

* Local = Defined within a function. This cannot be referenced by another function.
* Global = Defined outside of the main function. This can be used by any function.
* Static = There is only one static variable that is shared between different objects from the same class. The keyword `static` must be used when defining the variable.
* Final = This variable is set once and cannot be changed. The keyword `final` must be used when defining the variable. [1]

Source:

1. "Variables in C++." Studytonight. Accessed May 21, 2017. http://www.studytonight.com/cpp/variables-scope-details.php


# Conditionals


## Conditionals - Operators

Conditional statements require comparison operators. If the outcome of the operator is true then the conditional will execute.

| Comparison Operator | Description |
| --- | --- |
| == | Equal |
| != | Not Equal |
| < | Less than |
| > | Greater than |
| <= | Less than or Equal to |
| >= | Greater than or Equal to |

Using logical operators allows for multiple statements to be compared.

| Logical Operator | Description |
| --- | --- |
| ! | The statement must be false. |
| && | Both statements must be true. |
| &#124;&#124; | At least one statement must be true. |

[1]

Source:

1. "[C++] Operators." cpluspluss.com. Accessed May 21, 2017. http://www.cplusplus.com/doc/tutorial/operators/


## Conditionals - If

If statements execute a task if an expression of comparing two or more things is returned as true.

Syntax:

```
if (<TRUE_STATEMENT>) {
    // <DO_SOMETHING_1>
} else if (<TRUE_STATEMENT>) {
    // <DO_SOMETHING_2>
} else {
    // <DO_SOMETHING_3>
}
```

Example:

```
if ( number_of_cats_owned > 9 ) {
    cat_lover = true;
```
```
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
```

[1]

Source:

1. "Lesson 2: If statements in C++." Cprogramming.com. Accessed May 21, 2017. http://www.cprogramming.com/tutorial/lesson2.html


## Conditionals - Switch

Switches provide a good way to execute a task based on a specific value of a variable. If a switch condition is met, it is a good idea to a "break" statement to exit the switch. For more complex comparisons, use "if" conditionals instead of the "switch."

Syntax:

```
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
```

Example:

```
int number_of_forks = 3;
switch(number_of_forks) {
  case 1 : cout << "There is one fork.";
  case 2 : cout << "There are two forks.";
  case 3 : cout << "There are three forks.";
  default: cout << "There are too few or too many forks on the table.";
}
```

[1]

Source:

1. "[C++] switch statement." C++ reference. March 6, 2017. Accessed May 21, 2017. http://en.cppreference.com/w/cpp/language/switch


## Conditionals - For

For loops initialize a variable, check if a compairison of an expression is true, and then increments the initalized variable. This is useful for running a loop a specific number of times.

Syntax:

```
for ( <INITIALIZE>; <COMPAIRISON>; <INCREMENT>) {
    // <DO_SOMETHING>
}
```

Example:

```
count << "The countdown started."
for ( int count = 10; 0 < count ; --count) {
    cout << count;
}
```

[1]

Source:

1. "C++ for loop." Tutorials Point. Accessed May 21, 2017. https://www.tutorialspoint.com/cplusplus/cpp_arrays.htm


## Conditionals - While

While statements can be used to continually run a task while a statement is true. A "do-while" statement uses the same concept but garuntees that the tasks will be run at least once.

Syntax:

```
while (<EXPRESSION>) {
    // <DO_SOMETHING>
}
```
```
do {
    // <DO_SOMETHING>
} while (<EXPRESSION)
```

Example:

```
std::string every_fruit = { "apples", "bananas", "oranges"}
std::string fruit = new std::string();
while (fruit != "orange") {
    fruit = every_fruit[random_number];
    cout << "This fruit is: " << fruit << endl;
}
```

[1]

Source:

1. "C++ while and do...while Loop." Progamiz. Accessed May 21, 2017. https://www.programiz.com/cpp-programming/do-while-loop


# Input and Output


# Input and Output - Terminal

Text from a terminal can either be displayed (standard output) and/or saved as a variable (standard input). C++ can even use C standard input/output functions since they are compatible.

| Name | Type | Language |
| --- | --- | --- |
| printf | Output | C |
| cout | Output | C++ |
| scanf | Input | C |
| cin | Input | C++ |

Syntax:

```
cout << "<TEXT>";
```
```
printf("<TEXT>");
```
```
scanf("<FORMATER>", <VARIABLE>);
```
```
cin >> <VARIABLE>;
```

Example:

```
string w = "world";
printf("Hello %s", string w  );
```

[1]

Source:

1. "C++ Programming Language Stream IO and File IO." Nanyang Technoligcal University. May, 2013. Accessed May 21, 2017. http://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp10_io.html