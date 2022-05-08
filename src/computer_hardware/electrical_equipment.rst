Electrical Equipment
====================

.. contents:: Table of Contents

Wires
-----

Use-Cases
~~~~~~~~~

There are the three use-cases for electrical wires [3]:

-  Hot or Live = This is the source of electricity. Handle this wire with caution. It is recommended to disable the power source, if possible, when handling this wire.
-  Neutral = This completes an electrical circuit. It will only have power if a hot/live wire is connected.
-  Ground = For when the power may be unstable, power is redirected through this wire and literally into the ground to dissipate the energy.

Types
~~~~~

Wires have two physical types [4]:

-  Solid = A single piece of wire.

   -  Easier to solder.
   -  Less flexible.
   -  Easier to break.
   -  Easier to insert into holes and terminal connectors.

-  Stranded = A collection of smaller wires combined.

   -  Harder to solder.
   -  More flexible.
   -  Harder to break.
   -  Harder to insert into holes and terminal connectors.

Gauges
~~~~~~

A gauge is how thick a wire is. The lower the number, the bigger the thickness. Here are recommendations for what gauge wire to use based on the project:

-  22

   -  Breadboard, Arduino, Raspberry Pi, and other single-board devices. [4]

-  18

   -  House lights. [5]
   -  Small appliances. [5]
   -  Speakers. [6]

-  14

   -  House in-wall electrical wiring. [4]
   -  Speakers that require high power consumption and/or long wires. [6]

Colors
~~~~~~

Each country has a different standard for the purpose of each colored wire. In the United States of America, these are the standards [2]:

-  Hot

   -  **Black**
   -  Blue
   -  Brown
   -  Yellow
   -  Red = High voltage up to 240 volts.
   -  Orange = Very high voltage up to 480 volts.

-  Neutral

   -  **White** = High voltage up to 240 volts.
   -  Grey = Very high voltage up to 480 volts.

-  Ground

   -  **Green**
   -  Bare wire (no covering)

Relays
------

A relay is a switch that controls power being sent through a wire or circuit. It is either normally open (NO) or normally closed (NC) when there is power sent through a contact in relay. When there is no power through a contact, a NO gate will turn off and a NC gate will turn on.

There are two types of relays: electromechanical relays (EMR) and solid-state relays (SSR). EMR uses magnets to move a physical switch. SSR uses circuits to direct electricity.

EMR:

-  State of the relay is more reliable.

   -  It is either on or off.

-  Requires more power to change the state.
-  Slower switching.
-  More likely to break.
-  Replaceable parts.
-  Moving parts.

SSR:

-  State of the relay is less reliable.

   -  It is somewhere between on and off but leans towards one or the other.

-  Requires less power to change the state.
-  Faster switching.
-  Less likely to break.
-  Non-replaceable parts.
-  No moving parts.

[1]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/electrical_equipment.rst>`__

Bibliography
------------

1. "How Relays Work." Galco. Accessed September 24, 2021. https://www.galco.com/comp/prod/relay.htm
2. "Wiring Color Codes Chapter 2 - Color Codes." All About Circuits Electrical Textbook. Accessed May 8, 2022. https://www.allaboutcircuits.com/textbook/reference/chpt-2/wiring-color-codes-infographic/
3. "Eletrical Wiring Tips: What is Hot, Neutral, and Ground." Roman Electric. Accessed May 8, 2022. https://romanelectrichome.com/electrical-wiring-tips/
4. "Stock Up on Wire for Your Electronics Projects." dummies. March 26, 2016. Accessed May 8, 2022. https://www.dummies.com/article/technology/electronics/general-electronics/stock-up-on-wire-for-your-electronics-projects-180328/
5. "Fix a Lamp Cord." Family Handyman. August 28, 2019. Accessed May 8, 2022. https://www.familyhandyman.com/project/fix-a-lamp-cord/
6. "What Size Speaker Wire Is Right? The Right Gauge, Type, And More." Sound Certified. April 10, 2022. Accessed May 8, 2022. https://soundcertified.com/what-size-speaker-wire-guide/
