Rust
====

.. contents:: Table of Contents

Introduction
------------

Rust is faster and more power efficient than C++ [3] while also being more secure. It is designed to provide memory, null, thread, and type safety. The compiler refuses to build unsafe code and provides detailed hints on how to fix it. [4] Memory exploits alone lead to anywhere from 50-90% of all known vulnerabilities. [5][6]

Tutorials
---------

-  Books [1][2]:

   1.  `The Rust Programming Lanuage <https://doc.rust-lang.org/book/>`__ (also known as "The [Rust] Book") = Free.
   2.  `Rust Crash Course <https://www.amazon.com/Rust-Crash-Course-High-Performance-Next-Generation/dp/9355510950>`__ = Paid.
   3.  `Rust by Example <https://doc.rust-lang.org/stable/rust-by-example/>`__ = Free.
   4.  `Rust in Action <https://www.rustinaction.com/>`__ = Paid.
   5.  `Rust Design Patterns <https://rust-unofficial.github.io/patterns/>`__ = Free.
   6.  `The Rust Performance Book <https://nnethercote.github.io/perf-book/>`__ = Free.
   7.  `The Cargo Book <https://doc.rust-lang.org/cargo/guide/>`__ = Free.
   8.  `Rust Language Cheat Sheet <https://cheats.rs/>`__ = Free.

-  Hands-on workshops [2]:

   1.  `Experiment: Improving the Rust Book <https://rust-book.cs.brown.edu/>`__ = Free.
   2.  `rustlings <https://github.com/rust-lang/rustlings>`__ = Free.
   3.  `Exercism <https://exercism.org/>`__ = Free.

Installation
------------

It is recommended to install Rust in one of two ways. Either (1) globally for users to run Rust programs or (2) locally for a single user who needs to develop Rust programs and packages. The Rust project recommends the use of the second method [10] which can be installed by non-root users and will install the latest stable version.

-  Users of Rust programs:

   -  Arch Linux [7]:

      .. code-block:: sh

         $ sudo pacman -S rust

   -  Debian [8]:

      .. code-block:: sh

         $ sudo apt-get update
         $ sudo apt-get install rust cargo

   -  Fedora [9]:

      .. code-block:: sh

         $ sudo dnf install rust cargo

-  Developers of Rust programs:

   -  On Linux or macOS, install Rust. [10]

      .. code-block:: sh

         $ curl -sSf https://sh.rustup.rs | bash -s -- -y

   -  Load the local environment to be able to use the Rust tools. [11]

      .. code-block:: sh

         $ source ~/.cargo/env

   -  Verify that the installation succeeded.

      .. code-block:: sh

         $ which rustc
         ~/.cargo/bin/rustc
         $ rustc --version
         rustc 1.68.2 (9eb3afe9e 2023-03-27)

   -  When an update is available, Rust can be updated via the local ``rustup`` command. [56]

      .. code-block:: sh

         $ rustup update stable
         $ rustc --version
         rustc 1.71.0 (8ede3aae2 2023-07-12)

Style Guide
-----------

Variables
~~~~~~~~~

-  Variable names should use ``snake_case``.
-  Constant names should use ``SCREAMING_SNAME_CASE``. [35][36]

Comments
~~~~~~~~

Code comments are to help other developers working on the same project. It provides details about what is happening when the code itself may not be obvious. The are ignored by the compiler when building a binary program.

-  Create standard a single line or multiple lines comment.

   .. code-block:: rust

      // This is one a single line.

   .. code-block:: rust

      /* This
       * spans
       */ more than one line.

-  Create documentation. Documentation for a crate or module starts at the start of the source code file. It has both a single line and multiple lines syntax.

   .. code-block:: rust

      //! # New Library
      //!
      //! This new library provides advanced features.


   .. code-block:: rust

      /*! # New Library

       This new library provides advanced features. */

[47][48]

rustfmt
~~~~~~~

The ``rustfmt`` tool that will automatically format Rust code to be in a standardized style. It uses a style that is approved by the Rust project but can be configured for individual preference.

It is installed by default when installing Rust with ``rustup`` unless using the "minimal" toolchain. It can be installed by running this command:

.. code-block:: sh

   $ rustup component add rustfmt

``rustfmt`` is highly configurable allowing formatting to be adjusted or turned off on a per-rule basis by using a ``rustfmt.toml`` or ``.rustfmt.toml`` file. All of the available configuration options are listed `here <https://rust-lang.github.io/rustfmt/>`__.

-  Syntax:

   ::

      <RULE> = <VALUE>

-  Example:

   ::

      # Increase from the default value of 60.
      array_width = 80

Use the Rust formatter on a single file.

.. code-block:: sh

   $ rustfmt <RUST_SOURCE_FILE>.rs

Use the Rust formatter on an entire project.

.. code-block:: sh

   $ cargo fmt

[43][44]

Clippy
~~~~~~

Rust provides a limited linter that is automatically run when using ``rustc`` or ``cargo check``. Newer versions of Rust also ship with a separate and more advanced linter known as ``clippy``.

It is installed by default when installing Rust with ``rustup`` unless using the "minimal" toolchain. It can be installed by running this command:

.. code-block:: sh

   $ rustup component add clippy

Run the linter on a specific file.

.. code-block:: sh

   $ clippy-driver <RUST_SOURCE_FILE>.rs

Run the linter on an entire project.

.. code-block:: sh

   $ cargo clippy

`Here <https://rust-lang.github.io/rust-clippy/stable/index.html>`__ is a list of every lint rule along with its group and warning level.

Convert a lint error down to a warning.

-  Syntax:

   .. code-block:: rust

      $ cargo clippy -- -W clippy::<LINT_RULE>

-  Example:

   .. code-block:: rust

      $ cargo clippy -- -W clippy::possible_missing_comma

[45][46]

Data Types
----------

Overview
~~~~~~~~

.. csv-table::
   :header: Name, Data Type
   :widths: 20, 20

   i8, 8-bit integer.
   u8, 8-bit unsigned integer.
   i16, 16-bit integer.
   u16, 16-bit unsigned integer.
   i32, 32-bit integer.
   u32, 32-bit unsigned integer.
   i64, 64-bit integer.
   u64, 64-bit unsigned integer.
   i128, 128-bit integer.
   u128, 128-bit unsigned integer.
   isize, Integer the size of the CPU architecture.
   usize, Unsigned integer the size of the CPU architecture.
   f32, 32-bit float.
   f64, 64-bit float.
   bool, Boolean of ``true`` or ``false``.
   char, Character.
   &str, A pointer to a string of characters. [18]
   Vec<T>, A vector with data type ``T`` defined. [31]

[16][17]

Variable Declaration
~~~~~~~~~~~~~~~~~~~~

-  Rust can guess the correct data type to use for a variable.

   .. code-block:: rust

      let <VARIABLE_NAME> = <VALUE>;

-  Otherwise, the data type can be explicitly set.

   .. code-block:: rust

      let <VARIABLE_NAME>: <DATA_TYPE> = <VALUE>;

-  By default, all variables are immutable and cannot be changed. Create a mutable variable.

   .. code-block:: rust

      let mut <VARIABLE_NAME> = <VALUE>;

-  Constants are immutable and global variables that must be defined outside of a function. [35]

   .. code-block:: rust

      const <VARIABLE_NAME> = <VALUE>;

Arrays
~~~~~~

-  An array has a defined length.

   .. code-block:: rust

      let <VARIABLE_NAME>: [<DATA_TYPE>;<LENGTH>] = [<VALUE_1>, <VALUE_2>];

-  A tuple is similar to an array but it can store more than on data type.

   .. code-block:: rust

      let <VARIABLE_NAME>: (<DATA_TYPE_1>, <DATA_TYPE_2>) = (<VALUE_1>, <VALUE_2>);

-  A slice is a portion of an existing array, tuple, or vector. It supports a dynamic length.

   -  Syntax:

      .. code-block:: rust

         let slice: &[<DATA_TYPE>] = &<ARRAY_TUPLE_OR_VECTOR_NAME>[<INDEX_RANGE>];

   -  Example:

      .. code-block:: rust

         let young_age_milestones: [i8; 4] = [12, 16, 18, 21];
         let last_young_age_milestone: &[i8] = &young_age_milestones[2..4];
         println!("{:?}", last_young_age_milestone);

      ::

         [18, 21]

[16][17]

-  A vector has an undefined size until the Rust program runs.

   -  Create a vector using a method.

      .. code-block:: rust

         let mut example_vector: Vec<i8> = Vec::new();
         example_vector.push(1);
         example_vector.push(2);
         example_vector.push(3);
         println!("{:?}", example_vector);

      ::

         [1, 2, 3]

   -  Create a vector using a macro.

      .. code-block:: rust

         let mut example_vector = vec![1, 2, 3];
         println!("{:?}", example_vector);

      ::

         [1, 2, 3]

[31]

Strings
~~~~~~~

Rust will automatically create a string as a pointer location to a collection of two or more ``char`` s. All characters use UTF-8.

-  Create a string. By default, the size of the pointer is immutable and cannot be changed.

   .. code-block:: rust

      let <VARIABLE>: &str = "<STRING>";

-  Create a mutable string that can change its memory size. If this memory size is never changed, the Rust compiler will provide a warning.

   .. code-block:: rust

      let mut <VARIABLE>: &str = "<STRING>";

-  Slice a string by specifying the index to start at and the index to stop before getting to.

   .. code-block:: rust

      let gnb: &str = "good and bad";
      println!("{}", &gnb[0..4]);
      println!("{}", &gnb[1..3]);

   ::

      good
      oo

-  Add two strings together. The first string needs to be converted to a string object and the second string needs to be a pointer.

   .. code-block:: rust

      let foo: &str = "Foo";
      let bar: &str = "Bar";
      let foobar = foo.to_string() + &bar;
      println!("{}", &foobar);

   ::

      FooBar

[18][19]

Structs and Enums
~~~~~~~~~~~~~~~~~

A ``struct`` is a custom data type. It can hold zero or many variables of different data types.

-  Create a ``struct`` that uses every data type in Rust.

   .. code-block:: rust

      // Enable the ability to debug the output of this new data type.
      #[derive(Debug)]
      struct ExampleData {
          example_bool: bool,
          example_char: char,
          example_i8: i8,
          example_i16: i16,
          example_i32: i32,
          example_i64: i64,
          example_u8: u8,
          example_u16: u16,
          example_u32: u32,
          example_u64: u64,
          example_f32: f32,
          example_f64: f64,
          example_string: String,
          example_array: [i32; 2],
          example_tuple: (i32, f64),
          example_option: Option<String>,
          example_enum: ExampleEnum,
      }
      
      #[derive(Debug)]
      enum ExampleEnum {
          Variant1,
          Variant2(i32),
          Variant3 { field1: String, field2: u32 },
      }
      
      fn main() {
          let data = ExampleData {
              example_bool: false,
              example_char: 'C',
              example_i8: -16,
              example_i16: -1024,
              example_i32: -1_000_000,
              example_i64: -8_000_000_000,
              example_u8: 42,
              example_u16: 1024,
              example_u32: 1_000_000,
              example_u64: 8_000_000_000,
              example_f32: 3.14,
              example_f64: 3.14159265359,
              example_string: String::from("This is a string!"),
              example_array: [1, 2],
              example_tuple: (42, 3.14),
              example_option: Some(String::from("Optional field")),
              example_enum: ExampleEnum::Variant1,
          };

          println!("{:?}", data);
      }

   ::

      ExampleData { example_bool: false, example_char: 'C', example_i8: -16, example_i16: -1024, example_i32: -1000000, example_i64: -8000000000, example_u8: 42, example_u16: 1024, example_u32: 1000000, example_u64: 8000000000, example_f32: 3.14, example_f64: 3.14159265359, example_string: "This is a string!", example_array: [1, 2], example_tuple: (42, 3.14), example_option: Some("Optional field"), example_enum: Variant1 }

An ``enum`` is a collection of ``struct`` s into a single data type.

-  Create a new ``enum`` data type.

   .. code-block:: rust

      fn main() {
          #[derive(Debug)]
          enum Car {
              Car,
              CarMake(String),
              CarModel(String),
              CarYear(i32),
              CarReleaseYears([i32; 2]),
          }
      
          let honda_civic_car = Car::Car;
          let honda_civic_car_make = Car::CarMake(String::from("Honda"));
          let honda_civic_car_model = Car::CarModel(String::from("Civic"));
          let honda_civic_car_year = Car::CarYear(2023);
          let honda_civic_car_release_years = Car::CarReleaseYears([2022, 2023]);
      
          println!("{:?}, {:?}, {:?}, {:?}, {:?}",
              honda_civic_car, honda_civic_car_make, honda_civic_car_model, honda_civic_car_year, honda_civic_car_release_years);
      }

   ::

      Car, CarMake("Honda"), CarModel("Civic"), CarYear(2023), CarReleaseYears([2022, 2023])

[30]

Both ``enum`` and ``struct`` can be created as empty void variables. Each void ``struct`` is considered a different type of data and is known as a zero-sized type (ZST). However, all empty ``enum`` variables are type-less. A ``struct`` is more efficient when it comes to resolving traits compared to an ``enum``. [58][59]

-  Create an empty ``enum`` and ``struct``.

   .. code-block:: sh

      struct EmptyStruct {}
      enum EmptyEnum {}

A ``struct`` can have default values set.

-  Create a variable with all or some default values set.

   .. code-block:: rust

      #[derive(Debug)]
      struct Car {
          manual_transmission: bool,
          year: i16,
          top_speed: i8,
      }

      // This implementation name must be "Default".
      impl Default for Car {
          // This function name must be "default".
          fn default () -> Car {
              Car{manual_transmission: false, year: 2023, top_speed: 88}
          }
      }

      fn main() {
        let car_default_all = Car::default();
        let car_default_some = Car{manual_transmission: true, ..Default::default()};
      }

An ``Option`` is a special type of ``enum``. [61] It is a way to store value of ``None`` or any specific data type and check if a value exists while avoiding panics. [62]

-  Create and use an ``Option`` variable.

   .. code-block:: rust

      fn main() {
          let number_of_students: Option<i8> = Some(3);
          //let number_of_students: Option<i8> = None;

          match number_of_students {
              Some(num) => println!("There are {} students here.", num),
              None => println!("There are no students here."),
          }
      }

Standard Input and Output
-------------------------

Introduction
~~~~~~~~~~~~

-  Use the built-in macro ``println!("")`` to print messages to standard output.

   .. code-block:: rust

      fn main() {
          println!("Star Wars: Andor");
      }

   ::

      Star Wars: Andor

-  Read from stanard input using the built-in ``std::io`` library. [40][41]

   .. code-block:: rust

      use std::io;
      
      fn main() {
          println!("Who are you?");
          let mut name = String::new();
          io::stdin().read_line(&mut name).expect("Unable to read from standard input");
          name.pop();
          println!("Your name is {}.", name);
      }

   ::

      Your name is Andor
      .

-  Standard input captures all newlines characters. These can be removed by using the built-in string function ``<STRING>.pop()`` to remove the last character. [42]

   .. code-block:: rust

      fn remove_newline_characters(string_name: &mut String) {
          // Linux uses "\n" for the newline character.
          if string_name.ends_with('\n') {
              string_name.pop();
              // Windows uses "\r\n" for the newline character.
              if string_name.ends_with('\r') {
                  string_name.pop();
              }
          }
      }

ANSI Color Codes
~~~~~~~~~~~~~~~~

Rust does not support the traditional octal escape sequences commonly used with ANSI color codes. Instead, use hexadecimal. For example, a blue octal color code of ``\033[34m`` should be rewritten as a hexadecimal code of ``\x1b[34m``. A full guide on the usage of ANSI can be found `here <shell.html#ansi-colors>`__. Alternatively, use the `colored <https://docs.rs/colored/latest/colored/>`__ create to make color coding even easier and the code more readable. [57]

Functions
---------

Examples
~~~~~~~~

-  Create a minimal Rust program.

   -  Example:

      .. code-block:: rust

         fn main() {
             println!("This is a simple Rust program!");
         }

      -  Build the source file and then run the resulting binary. [12]

         .. code-block:: sh

            $ rustc <FILE>.rs
            $ ./<FILE>
            This is a simple Rust program!

-  Create a function that returns a value.

   -  Syntax:

      .. code-block:: rust

         fn <FUNCTION_NAME>() -> <RETURN_DATA_TYPE> {
             <RETURN_VALUE>
         }

   -  Example:

      .. code-block:: rust

         fn main() {
             let x = foobar();
             println!("foobar returned {x}")
         }
         
         fn foobar() -> i8 {
             3
         }

-  Create a function that uses parameters.

   -  Syntax:

      .. code-block:: rust

         fn <FUNCTION_NAME>(<PARAMETER_1_VARIABLE_NAME>: <PARAMETER_1_DATA_TYPE>, <PARAMETER_2_VARIABLE_NAME>: <PARAMETER_2_DATA_TYPE>) {
         }

   -  Example:

      .. code-block:: rust

         fn main() {
             display_numbers(1, 2)
         }
         
         fn display_numbers(foo: i16, bar: i16) {
             println!("foo = {foo} and bar = {bar}");
         }

[13]

Macros
~~~~~~

Macros are denoted by a ``!`` or ``?``. [14] At compile time, the macro is replaced by actual code. It is faster than a traditional function and reduces the need to write duplicate code. The most common built-in macros in Rust are ``panic!``, ``println!``, and ``vec!``. [15]

-  Print line macro:

   .. code-block::  rust

      println!("{}", foobar);

-  Print line macro expanded at compile time [14]:

   .. code-block:: rust

      {
          ::std::io::_print(::core::fmt::Arguments::new_v1(
              &["", "\n"],
              &match (&foobar,) {
                  (arg0,) => [::core::fmt::ArgumentV1::new(
                      arg0,
                      ::core::fmt::Display::fmt,
                  )],
              },
          ));
      };

It is possible to create new custom macros using ``macro_rules!``.

-  Create a macro that does not require any parameters. [15]

   .. code-block:: rust

      macro_rules! <NEW_MACRO_NAME> {
          () => {
              // Add logic here.
          }
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

[20]

.. csv-table::
   :header: Logical Operator, Description
   :widths: 20, 20

   &&, All booleans must be true.
   ||, At least one boolean must be true.
   !, No booleans can be true.

[21]

Control statements for loops [22]:

-  break = Stop the current loop.
-  continue = Move onto the next iteration of the loop.

For
~~~

The ``for`` loop is used to iterate over an existing array or a dynamic range of numbers.

-  Create a loop with an existing array.

   -  Syntax:

      .. code-block:: rust

         for <ITEM> in <ARRAY> {
             // Add logic for using the "<ITEM>" variable.
         }

   -  Example:

      .. code-block:: rust

         let vegetables = ["asparagus", "broccoli", "carrot"];
         for veg in vegetables {
             println!("{}", veg);
         }

      ::

         asparagus
         broccoli
         carrot

-  Create a loop using a dynamic range of integers.

   -  Syntax:

      .. code-block:: rust

         for <INTEGER> in <RANGE_INTEGER_START>..<RANGE_INTEGER_END> {
             // Add logic for using the "<INTEGER>" variable.
         }

   -  Example:

      .. code-block:: rust

         for x in 0..2 {
             println!("{x}");
         }

      ::

         0
         1

-  Create a loop that goes through a specific range of array indexes.

   -  Syntax:

      .. code-block:: rust

         for <ITEM_INDEX> in <RANGE_INTEGER_START>..<RANGE_INTEGER_END> {
             // Add logic for using the "<ARRAY>[<ITEM_INDEX>]" variable.
         }

   -  Example:

      .. code-block:: rust

         let vegetables = ["asparagus", "broccoli", "carrot"];
         for x in 1..3 {
             println!("{}", vegetables[x]);
         }

      ::

         broccoli
         carrot

[23]

-  Create a loop that iterates through both the index and item in the array.

   -  Syntax:

      .. code-block:: rust

         for (<INDEX>, <ITEM>) in <ARRAY>.iter().enumerate() {
             // Add logic for using the "<INDEX>" and "<ITEM>" variables.
         }

   -  Example:

      .. code-block:: rust

         let vegetables = ["asparagus", "broccoli", "carrot"];
         for (n, veg) in vegetables.iter().enumerate() {
             println!("Index = {}, Vegetable = {}", n, veg);
         }

      ::

         Index = 0, Vegetable = asparagus
         Index = 1, Vegetable = broccoli
         Index = 2, Vegetable = carrot

[24]

If
~~

In Rust, ``if`` statement blocks all need to return the same data type. [26]

-  Syntax:

   .. code-block:: rust

      if <COMPARISON_1> {
          // Add logic here.
      } else if <COMPARISON_2> {
          // Add logic here.
      }
      else {
          // Add logic here.
      }

-  Example:

   .. code-block:: rust

      let cost: f32 = 2.99;
      if cost < 3.0 {
          println!("This costs less than $3!")
      } else if cost > 3.0 {
          println!("This costs more than $3!")
      }
      else {
          println!("This costs exactly $3!")
      }

   ::

      This costs less than $3!

While
~~~~~

Unlike most other programming languages, Rust has the increment for a ``while`` loop inside and at the end of a block. [25]


-  Create an incrementing loop.

   -  Syntax:

      .. code-block:: rust

         while <COMPARISON> {
             // Add logic here.
             // Increment the variable used for the loop.
         }

   -  Example:

      .. code-block:: rust

         let mut count: i8 = 0;
         while count < 5 {
             println!("{count}");
             count += 1;
         }

      ::

         0
         1
         2
         3
         4

-  Create an infinite loop. Use ``break`` to end the loop at any time.

   -  Syntax:

      .. code-block:: rust

         while true {
             // Add logic here.
         }

Match
~~~~~

A Rust ``match`` is the same as ``switch/case`` in other programming langauges. [27]

-  Syntax:

   .. code-block:: rust

      match <VARIABLE> {
          <EXPECTED_VALUE_1> => <ADD_LOGIC_HERE>,
          <EXPECTED_VALUE_2> => <ADD_LOGIC_HERE>,
      }

-  Example:

   .. code-block:: rust

      let xbox_release_year: i16 = 2005;
      match xbox_release_year {
          2001 | 2002 | 2003 | 2004 => println!("Original Xbox"),
          2005 ..= 2012 => println!("Xbox 360"),
          2013 ..= 2019 => println!("Xbox One"),
          2020 => println!("Xbox Series"),
          _ => println!("Invalid year."),
      }

   ::

      Xbox 360

File Input and Output
---------------------

File handling is done via the ``std::fs`` library.

-  Read a file.

   .. code-block:: rust

      use std::fs;
      
      fn main() {
          // Store the entire file contents as a single string.
          let contents = fs::read_to_string("<FILE_NAME>").expect("Failed to open file");
          // Store each individual character into a vector.
          //let contents = fs::read("<FILE_NAME>").expect("Failed to open file");
          println!("{}", contents);
      }

-  Write to a file.

   .. code-block:: rust

      use std::fs;
      
      fn main() {
          let contents = "<STRING>";
          fs::write("<FILE_NAME>", contents).expect("Failed to write to file");
      }

-  Append to a file and use advanced operations with ``std::fs::OpenOptions::new()``.

   .. code-block:: rust

      use std::fs;
      use std::io::Write;
      
      fn main() {
          let contents = "<STRING>\n";
          let mut f = fs::OpenOptions::new().append(true).create(true).open("<FILE_NAME>").expect("Failed to open file");
          f.write_all(contents.as_bytes()).expect("Failed to write to file");
      }

[32][33]

Cargo and Crates Packaging
--------------------------

Cargo is the official package manager for Rust dependencies. It installs packages known as crates. All of the available crates can be found `here <https://crates.io/>`__.

-  Create a skeleton directory for a new Rust project. This will automatically create a "Hello, world!" program, ``Cargo.toml`` package configuration file, and a git initialized directory.

   .. code-block:: sh

      $ cargo new <PROJECT_NAME>
      $ tree -a <RPOJECT_NAME>/
      <PROJECT_NAME>/
      ├── Cargo.toml
      ├── .git
      │   ├── config
      │   ├── description
      │   ├── HEAD
      │   ├── hooks
      │   │   ├── applypatch-msg.sample
      │   │   ├── commit-msg.sample
      │   │   ├── fsmonitor-watchman.sample
      │   │   ├── post-update.sample
      │   │   ├── pre-applypatch.sample
      │   │   ├── pre-commit.sample
      │   │   ├── pre-merge-commit.sample
      │   │   ├── prepare-commit-msg.sample
      │   │   ├── pre-push.sample
      │   │   ├── pre-rebase.sample
      │   │   ├── pre-receive.sample
      │   │   ├── push-to-checkout.sample
      │   │   └── update.sample
      │   ├── info
      │   │   └── exclude
      │   ├── objects
      │   │   ├── info
      │   │   └── pack
      │   └── refs
      │       ├── heads
      │       └── tags
      ├── .gitignore
      └── src
          └── main.rs
      
      11 directories, 20 files

-  The ``Cargo.toml`` file contains important information about the name, version, and dependencies of a package. The edition is the version and format of the ``Cargo.toml`` itself. Valid editions include: ``2015``, ``2018``, and ``2021``.

   .. code-block:: sh

      $ cat <PROJECT_NAME>/Cargo.toml

   .. code-block:: ini

      [package]
      name = "<PROJECT_NAME>"
      version = "0.1.0"
      edition = "2021"
      
      # See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
      
      [dependencies]

-  Add dependencies to a ``Cargo.toml`` file.

   .. code-block:: ini

      [dependencies]
      <CRATE_PACKAGE> = "<VERSION>"

-  Install dependencies from a local ``Cargo.toml`` file.

   .. code-block:: sh

      $ cargo install --path .

-  Update all locally installed dependencies or just a specific create.

   .. code-block:: sh

      $ cargo update

   .. code-block:: sh

      $ cargo update -p <CRATE_PACKAGE>

-  Automatically download the dependencies and build a Rust program. By default, this uses ``target/debug``. It is also possible to build with the ``target/release`` profile that includes performance optimizations. [34]

   .. code-block:: sh

      $ cargo build

   .. code-block:: sh

      $ cargo build --release

-  Run the built program.

   .. code-block:: sh

      $ cargo run

-  Remove built binaries.

  .. code-block:: sh

     $ cargo clean

[28][29]

-  As of Rust 1.69.0, debug builds provide minimal debugging information to make builds faster by default. This can be re-enabled to help troubleshoot build issues. [56]

   .. code-block:: sh

      $ cat <PROJECT_NAME>/Cargo.toml

   .. code-block:: yaml

      [profile.dev.build-override]
      debug = true

      [profile.release.build-override]
      debug = true

Logging
-------

Rust does not provide a built-in logging library. Instead, the popular and easy-to-use ``log`` crate is recommended. It prints all logs to standard error (not standard output) by default. The log levels are color-coded, show the date and time, show the log level, and show which binary the log is coming from.

-  Install the ``log`` crate and its dependency of ``env_logger`` by specifying them in the ``Cargo.toml`` file.

   .. code-block:: ini

      [dependencies]
      log = "0.4"
      env_logger = "0.9"

-  Create a simple program to use all of the log levels. By default, only the error logs will be printed out.

   .. code-block:: rust

      use log::*;
      
      fn main() {
          // Start the logger.
          env_logger::init();
          // Use various logging functions.
          debug!("Starting main function.");
          info!("Function started successfully.");
          warn!("Configuration mismatch. Ignoring.");
          error!("Unable to fix a problem!");
          trace!("There was a problem on line X.");
      }

   .. code-block:: sh

      $ cargo run
      [2023-04-30T18:11:19Z ERROR logging] Unable to fix a problem!

   -  Set the log output to be "trace" to see every level of logs. Alternatively, the log level can be set to the name of the main binary.

      .. code-block:: sh

         $ cd target/debug/
         $ RUST_LOG=trace ./logging
         [2023-04-30T18:11:47Z DEBUG logging] Starting main function.
         [2023-04-30T18:11:47Z INFO  logging] Function started successfully.
         [2023-04-30T18:11:47Z WARN  logging] Configuration mismatch. Ignoring.
         [2023-04-30T18:11:47Z ERROR logging] Unable to fix a problem!
         [2023-04-30T18:11:47Z TRACE logging] There was a problem on line X.
         $ RUST_LOG=logging ./logging
         [2023-04-30T18:13:22Z DEBUG logging] Starting main function.
         [2023-04-30T18:13:22Z INFO  logging] Function started successfully.
         [2023-04-30T18:13:22Z WARN  logging] Configuration mismatch. Ignoring.
         [2023-04-30T18:13:22Z ERROR logging] Unable to fix a problem!
         [2023-04-30T18:13:22Z TRACE logging] There was a problem on line X.

[54][55]

Testing
-------

Rust uses various ``assert_*`` macros to compare the output of a function against an expected result.

Built-in macros [51]:

-  ``assert!``
-  ``assert_eq!``
-  ``assert_ne!``

`claim <https://crates.io/crates/claim>`__ crate macros [53]:

-  ``assert_err!``
-  ``assert_ge!``
-  ``assert_gt!``
-  ``assert_le!``
-  ``assert_lt!``
-  ``assert_matches!``
-  ``assert_none!``
-  ``assert_ok!``
-  ``assert_ok_eq!``
-  ``assert_pending!``
-  ``assert_some!``
-  ``assert_some_eq!``
-  ``assert_ready!``
-  ``assert_ready_eq!``
-  ``assert_ready_err!``
-  ``assert_ready_ok!``

Unit tests (not integration tests) go into the bottom of the same file that contains the Rust code that is being tested. Define a "tests" module and add the annotation ``#[cfg(test)]``. That makes it so that running ``$ cargo build`` will not build the tests. Instead, use ``$ cargo test`` to build and run tests. Every unit test function needs to have the ``#[test]`` annotation. All other functions used for setup should not have that annotation.

.. code-block:: rust

   #[cfg(test)]
   mod tests {
       fn initial_tests_setup() {
           // Add non-test code here.
       }

       #[test]
       fn first_unit_test() {
           // Add test code here.
       }
   }

Integration tests should go into ``tests/integration_tests.rs``. All other non-unit tests should also go into separate files in the ``tests/`` directory. Since these files are dedicated to tests, they do not need to be wrapped into a "tests" module.

.. code-block:: rust

   #[test]
   fn first_integration_test() {
       // Add test code here.
   }

Any tests that take too long to run or are considered flaky should have the annotation ``#[ignore]`` above the function and after the ``#[test]`` annotation. These tests will not be run by default.

.. code-block:: rust

   #[test]
   #[ignore]
   fn very_time_consuming_integration_test() {
       // Add test code here.
   }

Tests can be written in one of two ways. It can either use an ``assert_*`` macro or a custom ``Result<Type, Error>`` can be returned.

.. code-block:: rust

   #[test]
   fn expect_one() -> Result<(), String> {
       let foobar_output = foobar();
       assert_eq!(foobar_output, 1);
   }

.. code-block:: rust

   #[test]
   fn expect_one() -> Result<(), String> {
       let foobar_output = foobar();
       if foobar_output == 1 {
           Ok(())
       } else {
           Err(String::from("This function should always return one!"))
       }
   }

Commands to run tests with ``cargo``:

-  ``cargo build`` = Build a production binary without tests.
-  ``cargo test`` = Run all tests.
-  ``cargo test -- --show-output`` = Run all tests and show output of all tests including ones that passed successfully.
-  ``cargo test -- integration_tests`` = Only run the integration tests.
-  ``cargo test <FUNCTION_NAME>`` = Only run the specified test.
-  ``cargo test -- --ignored`` = Run all tests including ones marked as ignored.
-  ``cargo test -- --test-threads=1`` = Run one test at a time. The default is to run tests in parallel.

[52][53]

Libraries
---------

Serde
~~~~~

Serde provides a standardized library to serialize and deserialize common formats, such as JSON and YAML, within Rust. The name comes from a combination of the two words ``ser`` ialize and ``de`` serialize. [37]

Serde YAML
^^^^^^^^^^

-  Add Serde YAML as a dependency in the ``Cargo.toml`` file of the project.

   .. code-block:: ini

      [dependencies]
      serde = { version = "1.0", features = ["derive"] }
      serde_yaml = "0.9"

-  Read various different data types from a YAML file.

   .. code-block:: yaml

      ---
      foo: "bar"
      pi: 3.14
      counting_up:
      - 1
      - 2
      - 3
      # Data type: Vec<Vec<i16>>
      star_trek_years:
      - [1987, 1993, 1995]
      - [2009, 2013, 2016]
      # Data type: bool
      today_will_be_a_good_day: true

   .. code-block:: rust

      use serde::{Deserialize, Serialize};
      use serde_yaml::{self};
      
      #[derive(Debug, Serialize, Deserialize)]
      struct YamlConfig {
          foo: String,
          pi: f32,
          counting_up: Vec<i8>,
          star_trek_years: Vec<Vec<i16>>,
          today_will_be_a_good_day: bool,
      }
      
      fn main() {
          let yaml_file = std::fs::File::open("example.yml").expect("Failed to open file");
          let yaml_values: YamlConfig = serde_yaml::from_reader(yaml_file).expect("Faild to load values");
          println!("{:?}", yaml_values);
      }

   ::

      YamlConfig { foo: "bar", pi: 3.14, counting_up: [1, 2, 3], star_trek_years: [[1987, 1993, 1995], [2009, 2013, 2016]], today_will_be_a_good_day: true }

-  Read a specific value from a YAML file. This is useful for pulling information from a map.

   .. code-block:: yaml

      ---
      star_trek:
        captain: "kirk"
        starship: "enterprise"
        year: 1966

   .. code-block:: rust

      use serde::{Deserialize, Serialize};
      use serde_yaml::{Value, Mapping};
      
      #[derive(Debug, Deserialize)]
      struct YamlConfig {
          star_trek: Mapping,
      }
      
      fn main() {
          let yaml_file = std::fs::File::open("example2.yml").expect("Failed to open file");
          let yaml_values: YamlConfig = serde_yaml::from_reader(yaml_file).expect("Faild to load values");
          let captain = yaml_values.star_trek.get(&Value::String("captain".to_string())).unwrap().as_str().unwrap();
          let starship = yaml_values.star_trek.get(&Value::String("starship".to_string())).unwrap().as_str().unwrap();
          let year = yaml_values.star_trek.get(&Value::String("year".to_string())).unwrap().as_i64().unwrap();
          println!("{}, {}, {}", captain, starship, year);
      }

   ::

      kirk, enterprise, 1966

[38][39]

Error Handling
--------------

Most built-in Rust functions return an ``enum`` data type that contains one of two values: (1) the data type of a successful run or (2) an error message as a string.

.. code-block:: rust

   enum Result<Type, Error> {
       Ok(Type),
       Err(Error),
   }

If ``Result::Err`` is returned, it uses the macro ``panic!("{}", Error);`` to end the program and print out an error message.

A function can be called with ``.expect()`` appended to it. If there is an error, this will override the panic error message and provide a new custom one.

.. code-block:: rust

   use std::fs::File;

   let file = File::open("foobar.txt").expect("Could not open file");

The ``?`` operator is used to end a function immediately if there is an error. Unlike a panic, the program will not exit. It will return the error code as part of a ``enum Result<>`` data type.

.. code-block:: rust

   use std::io;
   use std::fs::File;

   fn read_foobar() -> Result<String, io::Error> {
       let file = File::open("foobar.txt")?;
       println!("Looks like the file was opened. What a great day!");
       Ok(String::from("The file was opened successfully!"))
   }

   fn main() {
       let foobar = read_foobar();
       println!("{:?}", foobar);
       println!("This program has now completed with no panics!");
   }

-  Success message:

   ::

      Looks like the file was opened. What a great day!
      Ok("The file was opened successfully!")
      This program has now completed with no panics!

-  Failure message:

   ::

      Err(Os { code: 2, kind: NotFound, message: "No such file or directory" })
      This program has now completed with no panics!

[49][50]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/rust.rst>`__

Bibliography
------------

1. "Best Book to learn rust." Reddit r/rust. October 9, 2022. Accessed March 30, 2023. https://www.reddit.com/r/rust/comments/sjclfb/best_book_to_learn_rust/
2. "It's been 20 days since I started learning rust as my first language. Terrible experience. Should I move forward?" Reddit r/rust. October 5, 2022. Accessed March 30, 2023. https://www.reddit.com/r/rust/comments/q10obs/its_been_20_days_since_i_started_learning_rust_as/
3. “Python sucks in terms of energy efficiency - literally.” The Next Web. November 24, 2021. Accessed March 30, 2023. https://thenextweb.com/news/python-progamming-language-energy-analysis
4. "Why Safe Programming Matters and Why a Language Like Rust Matters." Okta Developer. March 18, 2022. Accessed March 30, 2023. https://developer.okta.com/blog/2022/03/18/programming-security-and-why-rust#rusts-safety-guarantee
5. "Memory Unsafety in Apple's Operating Systems." langui.sh. July 23, 2019. Accessed March 30, 2023. https://langui.sh/2019/07/23/apple-memory-safety/
6. "Queue the Hardening Enhancements." Google Security Blog. May 9, 2019. Accessed March 30, 2023. https://security.googleblog.com/2019/05/queue-hardening-enhancements.html
7. "Rust." ArchWiki. February 23, 2023. Accessed March 30, 2023. https://wiki.archlinux.org/title/rust
8. "Rust." Debian Wiki. March 24, 2023. Accessed March 30, 2023. https://wiki.debian.org/Rust
9. "Rust." Fedora Developer Portal. Accessed March 30, 2023. https://developer.fedoraproject.org/tech/languages/rust/rust-installation.html
10. "Install Rust." Rust Programming Language. Accessed March 30, 2023. https://www.rust-lang.org/tools/install
11. "How to Install Rust and Cargo on Ubuntu and Other Linux Distributions." It's FOSS. March 29, 2023. Accessed March 30, 2023. https://itsfoss.com/install-rust-cargo-ubuntu-linux/
12. "Hello World." Rust By Example. Accessed March 31, 2023. https://doc.rust-lang.org/rust-by-example/hello.html
13. "Functions." The Rust Programming Language. Accessed March 31, 2023. https://doc.rust-lang.org/book/ch03-03-how-functions-work.html
14. "Why does the println! function use an exclamation mark in Rust?" Stack Overflow. November 22, 2021. Accessed March 31, 2023. https://stackoverflow.com/questions/29611387/why-does-the-println-function-use-an-exclamation-mark-in-rust
15. "Rust Macro." Programiz. Accessed March 31, 2023. https://www.programiz.com/rust/macro
16. "Data Types." The Rust Programming Language. Accessed April 1, 2023. https://doc.rust-lang.org/book/ch03-02-data-types.html
17. "An Overview of Rust’s Built-In Data Types." MakeUseOf. February 19, 2023. Accessed April 1, 2023. https://www.makeuseof.com/rust-data-types-built-in-overview/
18. "Storing UTF-8 Encoded Text with Strings." The Rust Programming Language. Accessed April 3, 2023. https://doc.rust-lang.org/book/ch08-02-strings.html
19. "How to Use Strings in Rust." Linux Hint. 2022. Accessed April 3, 2023. https://linuxhint.com/strings-in-rust/
20. "Rust Comparison Operators." Electronics Reference. Accessed April 3, 2023. https://electronicsreference.com/rust/rust-operators/comparison-operators/
21. "Logical Operators." CodinGame. Novembe 29, 2022. Accessed April 3, 2023. https://www.codingame.com/playgrounds/54888/rust-for-python-developers---operators/logical-operators
22. "Rust Control Structures and How to Use Them." MakeUseOf. March 11, 2023. Accessed April 3, 2023. https://www.makeuseof.com/rust-program-control-structures-how-to-use/?newsletter_popup=1
23. "Arrays and for loops." Comprehensive Rust. Accessed April 4, 2023. https://google.github.io/comprehensive-rust/exercises/day-1/for-loops.html
24. "How to iterate over an array in Rust?" Hacker Touch. March 12, 2023. Accessed April 4, 2023. https://www.hackertouch.com/how-to-iterate-over-an-array-in-rust.html
25. "Rust - While Loop." GeeksforGeeks. March 2, 2022. Accessed April 5, 2023. https://www.geeksforgeeks.org/rust-while-loop/
26. "if/else." Rust By Example. Accessed April 6, 2023. https://doc.rust-lang.org/rust-by-example/flow_control/if_else.html
27. "Rust - Switch." W3schools. Accessed April 7, 2023. https://www.w3schools.io/languages/rust-match/
28. "Getting started with the Rust package manager, Cargo." opensource.com. March 3, 2020. Accessed April 12, 2023. https://opensource.com/article/20/3/rust-cargo
29. "Rust from the beginning, project management with Cargo." DEV Community. July 5, 2022. Accessed April 12, 2023. https://dev.to/azure/rust-from-the-beginning-project-management-with-cargo-5017
30. "What is an enum in Rust?" Educative. Accessed April 14, 2023. https://www.educative.io/answers/what-is-an-enum-in-rust
31. "Rust - Vectors." GeeksforGeeks. July 1, 2022. Accessed April 15, 2023. https://www.geeksforgeeks.org/rust-vectors/
32. "What's the de-facto way of reading and writing files in Rust 1.x?" Stack Overflow. May 4, 2022. Accessed April 17, 2023. https://stackoverflow.com/questions/31192956/whats-the-de-facto-way-of-reading-and-writing-files-in-rust-1-x
33. "How to read and write files in Rust." opensource.com. January 2, 2023. Accessed April 17, 2023. https://opensource.com/article/23/1/read-write-files-rust
34. "Hello, Cargo!" The Rust Programming Language. Accessed April 18, 2023. https://doc.rust-lang.org/book/ch01-03-hello-cargo.html
35. "Rust: let vs const." Nicky blogs. September 21, 2020. Accessed April 18, 2023. https://nickymeuleman.netlify.app/garden/rust-let-const
36. "Snake Case VS Camel Case VS Pascal Case VS Kebab Case – What's the Difference Between Casings?" freeCodeCamp Programming Tutorials. November 29, 2022. Accessed April 18, 2023. https://www.freecodecamp.org/news/snake-case-vs-camel-case-vs-pascal-case-vs-kebab-case-whats-the-difference/
37. "Overview." Serde. Accessed April 19, 2023. https://serde.rs/
38. "Serde YAML." GitHub dtolnay/serde-yaml. April 5, 2023. Accessed April 19, 2023. https://github.com/dtolnay/serde-yaml
39. "How to read and write YAML in Rust with Serde." TMS Developer Blog. September 8, 2021. Accessed April 19, 2023. https://tms-dev-blog.com/how-to-read-and-write-yaml-in-rust-with-serde/
40. "Standard I/O in Rust." GeeksforGeeks. March 17, 2021. Accessed April 21, 2023. https://www.geeksforgeeks.org/standard-i-o-in-rust/
41. "Rust - Input Output." tutorialspoint. Accessed April 21, 2023. https://www.tutorialspoint.com/rust/rust_input_output.htm
42. "rust - Remove single trailing newline from String without cloning." Stack Overflow. January 25, 2023. Accessed April 21, 2023. https://stackoverflow.com/questions/37888042/remove-single-trailing-newline-from-string-without-cloning
43. "rustfmt." GitHub rust-lang/rustfmt. April 1, 2023. Accessed April 23, 2023. https://github.com/rust-lang/rustfmt/
44. "Configuring Rustfmt." Rustfmt. Accessed April 23, 2023. https://rust-lang.github.io/rustfmt/
45. "Usage." Clippy Documentation. Accessed April 23, 2023. https://doc.rust-lang.org/nightly/clippy/usage.html
46. "Linting in Rust with Clippy." LogRocket Blog. February 24, 2023. Accessed April 23, 2023. https://blog.logrocket.com/rust-linting-clippy/
47. "Comments and Docs." Rust By Practice. Accessed April 23, 2023. https://practice.rs/comments-docs.html
48. "Rust Language Cheat Sheet." Rust Language Cheat Sheet. April 19, 2023. Accessed April 23, 2023. https://cheats.rs/
49. "Error Handling In Rust - A Deep Dive." Luca Palmieri. May 13, 2021. Accessed April 26, 2023. https://www.lpalmieri.com/posts/error-handling-rust/
50. "Recoverable Errors with Result." Experiment: Improving the Rust Book. Accessed April 26, 2023. https://rust-book.cs.brown.edu/ch09-02-recoverable-errors-with-result.html
51. "Create std." Rust. Accessed April 29, 2023. https://doc.rust-lang.org/std/#macros
52. "Writing Automated Tests." The Rust Programming Language. Accessed April 29, 2023. https://doc.rust-lang.org/book/ch11-00-testing.html
53. "Assertion macros for Rust." SVARTALF. March 13, 2020. Accessed April 29, 2023. https://svartalf.info/posts/2020-03-13-assertion-macros-for-rust/
54. "Logging in Rust." Medium. April 11, 2021. Accessed April 30, 2023. https://medium.com/nerd-for-tech/logging-in-rust-e529c241f92e
55. "Comparing logging and tracing in Rust." LogRocket Blog. May 27, 2022. Accessed April 30, 2023. https://blog.logrocket.com/comparing-logging-tracing-rust/
56. "Announcing Rust 1.69.0." Rust Blog. April 20, 2023. Accessed July 30, 2023. https://blog.rust-lang.org/2023/04/20/Rust-1.69.0.html
57. "How do I print colored text to the terminal in Rust?" Stack Overflow. January 24, 2023. Accessed July 31, 2023. https://stackoverflow.com/questions/69981449/how-do-i-print-colored-text-to-the-terminal-in-rust
58. "Exotically Sized Types." The Rustonomicon. Accessed August 3, 2023. https://doc.rust-lang.org/nomicon/exotic-sizes.html
59. "Enum vs structs implementing a trait." Reddit r/rust. May 13, 2020. Accessed August 3, 2023. https://www.reddit.com/r/rust/comments/ghk31y/enum_vs_structs_implementing_a_trait/
60. "Initialising Empty Structs in Rust." GitHub ChrisWellsWood/empty_rust_structs.md. June 5, 2019. Accessed August 4, 2023. https://gist.github.com/ChrisWellsWood/84421854794037e760808d5d97d21421
61. "Rust: Using Options by example." Ameya's blog. October 23, 2017. Accessed August 7, 2023. https://www.ameyalokare.com/rust/2017/10/23/rust-options.html
62. "Option and Result." Easy Rust. Accessed August 7, 2023. https://dhghomon.github.io/easy_rust/Chapter_31.html#option-and-result
