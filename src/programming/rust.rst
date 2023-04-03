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

-  Hands-on workshops [2]:

   1.  `A Tour of Go <https://tourofrust.com/>`__ = Free.
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

[16][17]

Variable Declaration
~~~~~~~~~~~~~~~~~~~~

Rust can guess the correct data type to use for a variable.

.. code-block:: rust

   let <VARIABLE_NAME> = <VALUE>;

Otherwise, the data type can be explicitly set.

.. code-block:: rust

   let <VARIABLE_NAME>: <DATA_TYPE> = <VALUE>;

Arrays
~~~~~~

-  An array has a defined length.

   .. code-block:: rust

      let <VARIABLE_NAME>: [<DATA_TYPE>;<LENGTH>] = [<VALUE_1>, <VALUE_2>];

-  A slice has an undefined size.

   .. code-block:: rust

      let <VARIABLE_NAME> = [<VALUE_1>, <VALUE_2>];

-  A tuple is similar to an array but it can store more than on data type.

   .. code-block:: rust

      let <VARIABLE_NAME>: (<DATA_TYPE_1>, <DATA_TYPE_2>) = (<VALUE_1>, <VALUE_2>);

[16][17]

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

         fn <FUNCTION_NAME>(<PARAMETER_1_VARIABLE_NAME>: <PARAMETER_1_DATA_TYPE>, <PARAMETER_2_VARIaBLE_NAME>: <PARAMETER_2_DATA_TYPE>) {
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
