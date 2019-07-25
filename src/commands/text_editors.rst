Text Editors
============

.. contents:: Table of Contents

See also: Shell

Vim
---

vim (Command)
~~~~~~~~~~~~~

Vi IMproved (Vim) is an text with advanced features based on the original Vi.

Package: vim

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-M", "open a file in immutable (read-only) mode"
   "-x", "encrypt a file"
   "-d", "compare and edit two files in diff mode"

vim (Interactive)
~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   ":q!", "quit without saving changes"
   ":wq", "save and quit"
   ":x", "save and quit"
   "ZZ", "save and quit"
   ":set number", "show line numbers"
   ":set nu", ""
   ":set nonumber", "turn off line numbers"
   ":set nonu", ""
   ":<NUMBER>", "go to the specified line number"
   ":split", "split vim into two horizontal screens"
   ":vsplit", "split vim into two vertical screens"
   ":vsplit <FILE>", "split vim into two vertical screens and open a different file in the new screen"
   "CTRL + w + ARROW_KEY", "move to that specified vim screen"
   ":recover", "reload the edited file from an old '.swp' file (from a VIM crash)"
   ":prev", "open up the last file that was opened by VIM"
   ":so %", ""
   ":source %", "install a Vim plugin"
   ":set nowrap", "disable text wrapping"
   ":set list", "show space and tab characters"
   ":set no list", "do not show space and tab characters"
   ":changes", "show changes in the current file"
   "y", "move cursor to the front of the line"
   "d", "cut line"
   "p", "paste after the cursor"
   "u", "undo"
   "CTRL+r", "redo (un-undo)"
   ".", "redo previous command again"
   "/", "search for a certain string"
   "n", "search for the next result"
   "N (Shift+n)", "show the previous search result"
   ":shell, :sh", "opens up a new shell session"
   ":ab", "this sets an abbreviation; when used it will transform into the setence you specify after the keyword"
   "di", "deletes until everything on the line until it reaches the delimiter"
   "dd", "delete the current line"
   ":%Tohtml", "turns the text file into a fully usable HTML file"
   "gg", "go to first line of the file"
   "G", "go to the last line of the file"
   "s/find/replace/g", "a sed-like find and replace for the current line only"
   "%s/find/replace/g", "a sed-like find and replace for the entire file"
   "CTRL+v", "visual line select mode; select columns and rows"
   "V (SHIFT + v)", "select multiple lines"
   "> (Shift + .)", "tab selected text"
   "^", "move cursor to the start of the line"
   "$", "move cursor to the end of the line"
   "gt", "switch between screens"
   "SHIFT+UP", "scroll the page up"
   "SHIFT+DOWN", "scroll the page down"
   "SHIFT+U", "set all selected characters to be upper case"
   "CTRL+O (CTRL + SHIFT + o)", "jump back to the previous place you were on"
   ":noh, :nohlsearch", "clear the last search result highlights"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   ":ab hello Hello, how are you?", "set ""hello"" as an alias"
   "\di.", "delete all text on a line until it reaches a period"

`History <https://github.com/ekultails/rootpages/commits/master/src/commands/text_editors.rst>`__
-------------------------------------------------------------------------------------------------
