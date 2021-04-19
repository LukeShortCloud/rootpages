Content Management Systems (CMSs)
=================================

.. contents:: Table of Contents

Introduction
------------

A CMS provides a framework to create a website without having to code it from scratch or even knowing HTML. It automates the process of creating new webpages and can use different themes and plugins. Most CMSs have search engine opitmizations (SEOs). The goal of a CMS is to make creating a website easy. [1]

Hugo
----

Installation
~~~~~~~~~~~~

Install the ``hugo`` package.

Create a new website:

.. code-block:: sh

   $ hugo new site <WEBSITE_NAME>

Unlike Jekyll, Hugo does not provide a default theme. Find and download a `Hugo theme from here <https://themes.gohugo.io/>`__. Extract it to the ``themes`` directory.

Configure the theme to be used.

.. code-block:: sh

   $ vim config.toml
   theme = "<THEME_DIRECTORY_NAME>"

Optionally create a new post on the website:

.. code-block:: sh

   $ hugo new <CATEGORY>/<POST_NAME>.md
   $ vim content/<CATEGORY>/<POST_NAME>.md
   ---
   title: "Example Post"
   date: 2021-01-01T12:00:00+00:00
   draft: false
   ---

Generate and serve the static website:

.. code-block:: sh

   $ hugo server

Access the website via ``http://127.0.0.1:1313/``.

[5]

Configuration
~~~~~~~~~~~~~

All of the configuration is handled by the ``config.toml`` file.

Settings:

-  baseURL (string) = The URL to the actual website. This is used when creating a static website with the ``hugo`` command (no arguments required).

   -  When running ``hugo server``, this value is temporarily set to ``http://127.0.0.1:1313/``.
   -  When building a static website, either change this to a URL or a ``file://`` path that points to the "public" folder.

-  languageCode (string) = The default language to use for the website.
-  **theme** (string) = The name of the theme to use. This will load up a theme ``themes/<THEME_NAME>/``.
-  **title** (string) = The name of the website to display.

Jekyll
------

Installation
~~~~~~~~~~~~

-  Install the dependencies:

   -  Arch Linux:

      .. code-block:: sh

         $ sudo pacman -Syy
         $ sudo pacman -S ruby base-devel

   -  Debian/Ubuntu:

      .. code-block:: sh

         $ sudo apt-get update
         $ sudo apt-get install build-essential ruby-full zlib1g-dev

   -  Fedora

      .. code-block:: sh

         $ sudo dnf install ruby ruby-devel openssl-devel redhat-rpm-config @development-tools

-  Export the environment variables to use local Ruby Gems.

   .. code-block:: sh

      $ export GEM_HOME="$HOME/gems"
      $ export PATH="$HOME/gems/bin:$PATH"

-  Install Jekyll.

   .. code-block:: sh

      $ gem install jekyll bundler

[2]

-  Create a new blog.

   .. code-block:: sh

      $ jekyll new <BLOG_NAME>

-  Start the blog in live reload mode to allow changes to automatically show up.

   .. code-block:: sh

      $ cd <BLOG_NAME>
      $ bundle exec jekyll serve --livereload

-  Access the webiste locally at ``http://127.0.0.1:35729`` for the live reload session. Otherwise, visit ``http://localhost:4000`` for the normal session.

[3]

Themes
~~~~~~

-  Find a theme from `here <https://jekyllrb.com/docs/themes/#pick-up-a-theme>`__.
-  Remove the default theme from the ``Gemfile``. The line starts with ``gem "minima"``.
-  Add the new theme to the ``Gemfile``.

   ::

      gem "<THEME_NAME>"

-  Install the new theme.

   .. code-block:: sh

      $ bundle install

-  Switch to the new theme in the ``_config.yml`` file.

   ::

      theme: <THEME_NAME>

[4]

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/http/cms.rst>`__

Bibliography
------------

1. "What Is a CMS and Why Should You Care?" HubSpot Blog. July 29, 2020. Accessed November 24, 2020. https://blog.hubspot.com/blog/tabid/6307/bid/7969/what-is-a-cms-and-why-should-you-care.aspx
2. "[Jekyll] Installation." Jekyll Documentation. Accessed November 25, 2020. https://jekyllrb.com/docs/installation/
3. "[Jekyll] Quickstart." Jekyll Documentation. Accessed November 25, 2020. https://jekyllrb.com/docs/
4. "[Jekyll] Themes." Jekyll Documentation. Accessed November 25, 2020. https://jekyllrb.com/docs/themes/
5. "Quick Start." Hugo. March 26, 2021. Accessed April 19, 2021. https://gohugo.io/getting-started/quick-start/
