`Wine <#wine>`__
================

.. contents:: Table of Contents

Wine Is Not an Emulator (Wine) is a compatibility layer that translates
Windows systems calls into native POSIX system calls. This provides a
fast way to run Windows programs natively on UNIX-like systems. [1]

The ReactOS project is a free and open source operating system built
from scratch. The main goal is to mirror the Windows NT operating
systems. Work on recreating Windows libraries (DLLs) is shared between
ReactOS and the Wine project. [2]

Both projects are clean-room reversed engineered to prevent legal
issues. [3]

User
----

This user guide is aimed at explaining how to use Wine, and related
tools, to run Windows programs on Linux.

Environment Variables
~~~~~~~~~~~~~~~~~~~~~

Environment variables can be set by using the "export" Linux shell
command or specifying the variables before a Wine command.

Examples:

.. code-block:: sh

    $ export WINEPREFIX="/home/user/wine_prefix"
    $ winecfg

.. code-block:: sh

    $ WINEPATH="c:/program_dir" wine setup.exe

+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| Name             | Description                                                                                                                                                                                       | Default               |
+==================+===================================================================================================================================================================================================+=======================+
| WINEPREFIX       | A directory where Wine should create and use an isolated Windows environment.                                                                                                                     | `$HOME/.wine`         |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINESERVER       | The "wineserver" binary to use.                                                                                                                                                                   | `/usr/bin/wineserver` |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINELOADER       | The "wine" binary to use for launching new Windows processes.                                                                                                                                     | `/usr/bin/wine`       |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINEDEBUG        | The debug options to use for logging.                                                                                                                                                             |                       |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINEDLLPATH      | The directory to load builtin Wine DLLs.                                                                                                                                                          | `/usr/lib64/wine`     |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINEDLLOVERRIDES | A list Wine DLLs that should be overridden. If a DLL fails to load it will attempt to load another DLL (if applicable). By default, all operating system DLLs will only use Wine's built-in DLLs. |                       |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINEPATH         | Additional paths to append to the Windows PATH variable.                                                                                                                                          |                       |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINEARCH         | The Windows architecture to use. Valid options are "win32" or "win64."                                                                                                                            | `win64`               |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| DISPLAY          | The X11 display to run Windows programs in.                                                                                                                                                       |                       |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| AUDIODEV         | The audio device to use.                                                                                                                                                                          | `/dev/dsp`            |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| MIXERDEV         | The device to use for mixer controls.                                                                                                                                                             | `/dev/mixer`          |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| MIDIDEV          | The MIDI sequencer device to use.                                                                                                                                                                 | `/dev/sequencer`      |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+
| WINE             | This variable is only used for Winetricks. The full path to the Wine binary to use.                                                                                                               | `/usr/bin/wine`       |
+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------+

[4]

WINEDEBUG can be configured to log, or not log, specific information.
Specify the log level class, if it should be added "+" or removed "-",
and the channel to use.

Syntax:

.. code-block:: sh

    WINEDEBUG=<CLASS1>[+|-]<CHANNEL1>,<CLASS2>[+|-]<CHANNEL2>

Example:

.. code-block:: sh

    WINEDEBUG=warn+all

Classes:

-  err
-  warn
-  fixme
-  trace

Common channels:

-  all = All debug information.
-  heap = All memory access activity.
-  loaddll = Every time a DLL is loaded.
-  message = Windows Event Log messages.
-  msgbox = Whenever a message box is displayed.
-  olerelay = DCOM specific calls.
-  relay = Calls between builtin or native DLLs.
-  seh = Windows exceptions (Structured Exception Handling).
-  server = RPC communication to wineserver.
-  snoop = Calls between native DLLS.
-  synchronous = Use X11's synchronous mode.
-  tid = Provides the process ID from where each call came from.
-  timestamp = Provides a timestamp for each log.

The full list of debug channels can be found at
https://wiki.winehq.org/Debug\_Channels.

WINEDLLOVERRIDES can be configured to use DLLs provided by Wine and/or
Windows DLLs. There are two different types of DLLs in Wine:

-  b = Builtin Wine DLLs.
-  n = Native Windows DLLs.

Syntax:

.. code-block:: sh

    WINEDLLOVERRIDES="<DLL1_OR_PATH_TO_DLL1>=[n|b],[b|n];<DLL2_OR_PATH_TO_DLL2>=[n|b],[b|n]"

Example:

.. code-block:: sh

    WINEDLLOVERRIDES="shell32=n,b"

The override can set to only run native, native then builtin, or builtin
then native DLLs.

[5]

`Errata <https://github.com/ekultails/rootpages/commits/master/src/wine.rst>`__
-------------------------------------------------------------------------------

Bibliography
------------

1. "WineHQ." WineHQ. October 20, 2017. Accessed October 29, 2017. https://www.winehq.org/
2. "Wine." ReactOS Wiki. April 28, 2017. Accessed October 29, 2017. https://www.reactos.org/wiki/WINE
3. "Clean Room Guidelines." WineHQ. February 13, 2016. Accessed October 29, 2017. https://wiki.winehq.org/Clean\_Room\_Guidelines
4. "Wine User's Guide." WineHQ. September 15, 2017. Accessed October 29, 2017. https://wiki.winehq.org/Wine\_User%27s\_Guide
5. "Debug Channels." WineHQ. November 13, 2016. Accessed October 29, 2017. https://wiki.winehq.org/Debug\_Channels
