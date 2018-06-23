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
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   "-M", "open a file in immutable (read-only) mode", ""
   "-x", "encrypt a file", ""
   "-d", "compare and edit two files in diff mode", ""

vim (Interactive)
~~~~~~~~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation, Example
   :widths: 20, 20, 20

   ":q!", "quit without saving changes", ""
   ":wq", "save and quit", ""
   ":x", "save and quit", ""
   "ZZ", "save and quit", ""
   ":set number", "show line numbers", ""
   ":set nu", "", ""
   ":set nonumber", "turn off line numbers", ""
   ":set nonu", "", ""
   ":split", "split vim into two horizontal screens", ""
   ":vsplit", "split vim into two vertical screens", ""
   ":recover", "reload the edited file from an old '.swp' file (from a VIM crash)", ""
   ":prev", "open up the last file that was opened by VIM", ""
   ":so %", "", ""
   ":source %", "install a Vim plugin", ""
   ":set nowrap", "disable text wrapping", ""
   ":set list", "show space and tab characters", ""
   ":set no list", "do not show space and tab characters", ""
   ":changes", "show changes in the current file", ""
   "y", "move cursor to the front of the line", ""
   "d", "cut line", ""
   "p", "paste after the cursor", ""
   "u", "undo", ""
   "CTRL+r", "redo (un-undo)", ""
   ".", "redo previous command again", ""
   "/", "search for a certain string", ""
   "n", "search for the next result", ""
   "N (Shift+n)", "show the previous search result", ""
   ":sh", "opens up a new shell session", ""
   ":ab", "this sets an abbreviation; when used it will transform into the setence you specify after the keyword", ":ab hello Hello, how are you?"
   "di", "deletes until everything on the line until it reaches the delimiter", "di."
   "dd", "delete the current line", ""
   ":%Tohtml", "turns the text file into a fully usable HTML file", ""
   "gg", "go to first line of the file", ""
   "G", "go to the last line of the file", ""
   "[[shift]] g", "", ""
   "s/find/replace/g", "a sed-like find and replace for the current line only", ""
   "%s/find/replace/g", "a sed-like find and replace for the entire file", ""
   "CTRL+v", "visual line select mode; select columns and rows", ""
   "CTRL+SHIFT+w (then select an arrow key)", "move to that specified vim screen", ""
   "V (SHIFT + v)", "select multiple lines", ""
   "> (Shift + .)", "tab selected text", ""
   "^", "", ""
   "$", "move cursor to the end of the line", ""
   "gt", "switch between screens", ""
   "SHIFT+UP", "scroll the page up", ""
   "SHIFT+DOWN", "scroll the page down", ""
   "SHIFT+U", "set all selected characters to be upper case", ""
   "CTRL+O (CTRL + SHIFT + o)", "jump back to the previous place you were on", ""

`Errata <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/text_editors.rst>`__
------------------------------------------------------------------------------------------------------

Bibliography
------------

-  Vim

      -  Vim (Interactive)

         -  http://www.vim.org/
         -  http://vim.wikia.com/wiki/Copy,_cut_and_paste
         -  http://vim.wikia.com/wiki/Undo_and_Redo
         -  http://xmodulo.com/useful-vim-commands.html
         -  http://stackoverflow.com/questions/105721/how-to-move-to-end-of-line-in-vim
         -  http://vim.wikia.com/wiki/Jumping_to_previously_visited_locations
         -  http://vim.wikia.com/wiki/See_the_tabs_in_your_file
         -  http://vim.wikia.com/wiki/List_changes_to_the_current_file
