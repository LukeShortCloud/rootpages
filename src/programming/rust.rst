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
