# Python 3

* [PEP](#pep)
    * [Style Guide for Python Code](#pep---style-guide-for-python-code)
* [Data Types](#data-types)
    * [Dictionaries](#data-types---dictionaries)
* Conditional Statements
    * If
    * For
    * While
* Libraries
* Errors
    * Exceptions
    * Logging
    * Unit Tests
* Input and Output
    * stdin and stdout
    * Files
    * Network
* Object Orientended Programming
* Virtual Environments


# PEP

Python Enhancement Proposals (PEPs) are guidelines to improve Python itself and developer's code. Each PEP is assigned a specific number. [1]

Source:

1. "PEP 0 -- Index of Python Enhancement Proposals (PEPs)." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/


## PEP - Style Guide for Python Code

PEP 8 is the "Style Guide for Python Code."

* Class names should:
    * Be capitalized.
    * Have two new lines above it.
    * Example:

```
import os


class Pep8():
```

* Method and function should:
    * Be named in all lowercase.
    * Use underscores "`_`" to separate words in the name.
    * Have it's contents intended by 4 spaces.
    * Example:

```
def hello_world():
    print("Hello world")
```

* Variables names should:
    * Have the first letter be lowercase.
    * Contain no underscores "`_`."
        * Unless they are private variables, then it needs to start with two underscores.
    * Cannot be a number.
* Conditional loops should:
    * Have newlines before and after a conditional block.
    * Have it's contents intended by 4 spaces.


Example:

```

if (phoneNumber == 999):

    if (callerID is “Frank”):
        print(“Hello Frank.”)

print("Hello everyone else.")
```

* Comments should:
    * Be full sentences.

[1]

Source:

1. "PEP 8 -- Style Guide for Python Code." Python's Developer's Guide. Accessed November 15, 2017. https://www.python.org/dev/peps/pep-0008/


# Data Types

Python automatically guesses what datatype a variable should be used when it is defined. The datatype a variable is using can be found using the `type()` function.

| Function | Name | Description |
| --- | --- | --- |
| chr | character | one letter or number
| str | strings | words or numbers defined within single or double quotes
| int | integer | a whole number
| float | float | a decimal number
| boolean | boolean | a true or false value; this can be a “1” or “0”, or it can be “True” or “False”
| list | list | similar to an array, it is a list of multiple variables
| dict | dictionary | a list that has sub-lists
| tuple | tuple | a read-only list that cannot be modified

Variables defined outside of a function are global variables. Although this practice is discouraged, these can be referenced using the `global` method. It is preferred to pass variables to a function and return their new values.

Example:

```python
var = "Hello world"

def say_hello():
    global var
    print(var)
```


## Data Types - Dictionaries

Dictionaries are a variable that provides a key-value store. It can be used as a nested array of variables.

Example replacing a key:

```python
dictionary = {'stub_host': '123'}
dictionary['hello_world'] = dictionary.pop('stub_host')
print(dictionary)
```

JSON libraries:

* json.load = Load a JSON dictionary from a file.
* json.loads = Load a JSON dictionary from a string.
* json.dump = Load JSON as a string from a file.
* json.dumps = Convert a JSON dictionary into a string.

YAML libraries:

* yaml.load = Load a YAML dictionary from a string.
* yaml.dump = Convert a YAML dictionary into a string.