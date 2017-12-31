`Wine <#wine>`__
================

-  `User <#user>`__

   -  Commands
   -  `Environment Variables <#user---environment---variables>`__
   -  Registry

-  Developer

   -  Mailing Lists
   -  Resources
   -  Winetricks

-  Frameworks

   -  Ansible Playgames
   -  PlayOnLinux

Wine Is Not an Emulator (Wine) is a compatibility layer that translates
Windows systems calls into native POSIX system calls. This provides a
fast way to run Windows programs natively on UNIX-like systems. [1]

The ReactOS project is a free and open source operating system built
from scratch. The main goal is to mirror the Windows NT operating
systems. Work on recreating Windows libraries (DLLs) is shared between
ReactOS and the Wine project. [2]

Both projects are clean-room reversed engineered to prevent legal
issues. [3]

Source:

1. "WineHQ." WineHQ. October 20, 2017. Accessed October 29, 2017.
   https://www.winehq.org/
2. "Wine." ReactOS Wiki. April 28, 2017. Accessed October 29, 2017.
   https://www.reactos.org/wiki/WINE
3. "Clean Room Guidelines." WineHQ. February 13, 2016. Accessed October
   29, 2017. https://wiki.winehq.org/Clean\_Room\_Guidelines

User
----

This user guide is aimed at explaining how to use Wine, and related
tools, to run Windows programs on Linux.

User - Environment Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Environment variables can be set by using the "export" Linux shell
command or specifying the variables before a Wine command.

Examples:

::

    $ export WINEPREFIX="/home/windowsguy/wine_prefix"
    $ winecfg

::

    $ WINEPATH="c:/program_dir" wine setup.exe

+------+------+------+
| Name | Desc | Defa |
|      | ript | ult  |
|      | ion  |      |
+======+======+======+
| WINE | A    | ``$H |
| PREF | dire | OME/ |
| IX   | ctor | .win |
|      | y    | e``  |
|      | wher |      |
|      | e    |      |
|      | Wine |      |
|      | shou |      |
|      | ld   |      |
|      | crea |      |
|      | te   |      |
|      | and  |      |
|      | use  |      |
|      | an   |      |
|      | isol |      |
|      | ated |      |
|      | Wind |      |
|      | ows  |      |
|      | envi |      |
|      | ronm |      |
|      | ent. |      |
+------+------+------+
| WINE | The  | ``/u |
| SERV | "win | sr/b |
| ER   | eser | in/w |
|      | ver" | ines |
|      | bina | erve |
|      | ry   | r``  |
|      | to   |      |
|      | use. |      |
+------+------+------+
| WINE | The  | ``/u |
| LOAD | "win | sr/b |
| ER   | e"   | in/w |
|      | bina | ine` |
|      | ry   | `    |
|      | to   |      |
|      | use  |      |
|      | for  |      |
|      | laun |      |
|      | chin |      |
|      | g    |      |
|      | new  |      |
|      | Wind |      |
|      | ows  |      |
|      | proc |      |
|      | esse |      |
|      | s.   |      |
+------+------+------+
| WINE | The  |      |
| DEBU | debu |      |
| G    | g    |      |
|      | opti |      |
|      | ons  |      |
|      | to   |      |
|      | use  |      |
|      | for  |      |
|      | logg |      |
|      | ing. |      |
+------+------+------+
| WINE | The  | ``/u |
| DLLP | dire | sr/l |
| ATH  | ctor | ib64 |
|      | y    | /win |
|      | to   | e``  |
|      | load |      |
|      | buil |      |
|      | tin  |      |
|      | Wine |      |
|      | DLLs |      |
|      | .    |      |
+------+------+------+
| WINE | A    |      |
| DLLO | list |      |
| VERR | Wine |      |
| IDES | DLLs |      |
|      | that |      |
|      | shou |      |
|      | ld   |      |
|      | be   |      |
|      | over |      |
|      | ridd |      |
|      | en.  |      |
|      | If a |      |
|      | DLL  |      |
|      | fail |      |
|      | s    |      |
|      | to   |      |
|      | load |      |
|      | it   |      |
|      | will |      |
|      | atte |      |
|      | mpt  |      |
|      | to   |      |
|      | load |      |
|      | anot |      |
|      | her  |      |
|      | DLL  |      |
|      | (if  |      |
|      | appl |      |
|      | icab |      |
|      | le). |      |
|      | By   |      |
|      | defa |      |
|      | ult, |      |
|      | all  |      |
|      | oper |      |
|      | atin |      |
|      | g    |      |
|      | syst |      |
|      | em   |      |
|      | DLLs |      |
|      | will |      |
|      | only |      |
|      | use  |      |
|      | Wine |      |
|      | 's   |      |
|      | buil |      |
|      | t-in |      |
|      | DLLs |      |
|      | .    |      |
+------+------+------+
| WINE | Addi |      |
| PATH | tion |      |
|      | al   |      |
|      | path |      |
|      | s    |      |
|      | to   |      |
|      | appe |      |
|      | nd   |      |
|      | to   |      |
|      | the  |      |
|      | Wind |      |
|      | ows  |      |
|      | ``PA |      |
|      | TH`` |      |
|      | vari |      |
|      | able |      |
|      | .    |      |
+------+------+------+
| WINE | The  | ``wi |
| ARCH | Wind | n64` |
|      | ows  | `    |
|      | arch |      |
|      | itec |      |
|      | ture |      |
|      | to   |      |
|      | use. |      |
|      | Vali |      |
|      | d    |      |
|      | opti |      |
|      | ons  |      |
|      | are  |      |
|      | "win |      |
|      | 32"  |      |
|      | or   |      |
|      | "win |      |
|      | 64." |      |
+------+------+------+
| DISP | The  |      |
| LAY  | X11  |      |
|      | disp |      |
|      | lay  |      |
|      | to   |      |
|      | run  |      |
|      | Wind |      |
|      | ows  |      |
|      | prog |      |
|      | rams |      |
|      | in.  |      |
+------+------+------+
| AUDI | The  | ``/d |
| ODEV | audi | ev/d |
|      | o    | sp`` |
|      | devi |      |
|      | ce   |      |
|      | to   |      |
|      | use. |      |
+------+------+------+
| MIXE | The  | ``/d |
| RDEV | devi | ev/m |
|      | ce   | ixer |
|      | to   | ``   |
|      | use  |      |
|      | for  |      |
|      | mixe |      |
|      | r    |      |
|      | cont |      |
|      | rols |      |
|      | .    |      |
+------+------+------+
| MIDI | The  | ``/d |
| DEV  | MIDI | ev/s |
|      | sequ | eque |
|      | ence | ncer |
|      | r    | ``   |
|      | devi |      |
|      | ce   |      |
|      | to   |      |
|      | use. |      |
+------+------+------+
| WINE | This | ``/u |
|      | vari | sr/b |
|      | able | in/w |
|      | is   | ine` |
|      | only | `    |
|      | used |      |
|      | for  |      |
|      | Wine |      |
|      | tric |      |
|      | ks.  |      |
|      | The  |      |
|      | full |      |
|      | path |      |
|      | to   |      |
|      | the  |      |
|      | Wine |      |
|      | bina |      |
|      | ry   |      |
|      | to   |      |
|      | use. |      |
+------+------+------+

[1]

WINEDEBUG can be configured to log, or not log, specific information.
Specify the log level class, if it should be added "+" or removed "-",
and the channel to use.

Syntax:

::

    WINEDEBUG=<CLASS1>[+|-]<CHANNEL1>,<CLASS2>[+|-]<CHANNEL2>

Example:

::

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

::

    WINEDLLOVERRIDES="<DLL1_OR_PATH_TO_DLL1>=[n|b],[b|n];<DLL2_OR_PATH_TO_DLL2>=[n|b],[b|n]"

Example:

::

    WINEDLLOVERRIDES="shell32=n,b"

The override can set to only run native, native then builtin, or builtin
then native DLLs.

[2]

Sources:

1. "Wine User's Guide." WineHQ. September 15, 2017. Accessed October 29,
   2017. https://wiki.winehq.org/Wine\_User%27s\_Guide
2. "Debug Channels." WineHQ. November 13, 2016. Accessed October 29,
   2017. https://wiki.winehq.org/Debug\_Channels
