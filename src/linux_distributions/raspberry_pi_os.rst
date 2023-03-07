Raspberry Pi OS
===============

.. contents:: Table of Contents

Downloads
---------

Official
~~~~~~~~

There are three official images provided for Raspberry Pi OS by the Raspberry Pi Foundation. [2] All of these are based on Debian. These are the main features of each: [3]

.. csv-table::
   :header: Image Name, Minimum SD Card Size, Desktop Environment, Office Suite
   :widths: 20, 20, 20, 20

   Raspberry Pi OS with desktop and recommended software, 16 GB, LXDE, LibreOffice
   Raspberry Pi OS with desktop, 8 GB, LXDE, None
   Raspberry Pi OS Lite, 4 GB, None, None

These images can be downloaded from `here <https://www.raspberrypi.com/software/operating-systems/>`__.

Unofficial
~~~~~~~~~~

These are third-party images that are not from the Raspberry Pi foundation:

-  `Arch Linux <https://archlinuxarm.org/>`__

   -  `Raspberry Pi 4 <https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4>`__

-  `Debian (upstream) <https://raspi.debian.net/tested-images/>`__
-  `Fedora <https://fedoraproject.org/wiki/Architectures/ARM/Raspberry_Pi>`__
-  `Manjaro <https://manjaro.org/download/#ARM>`__
-  openSUSE

    -  `Raspberry Pi 4 <https://en.opensuse.org/HCL:Raspberry_Pi4>`__

-  [Red Hat] Enterprise Linux

   -  `AlmaLinux <https://github.com/AlmaLinux/raspberry-pi>`__

-  `Ubuntu <https://ubuntu.com/download/raspberry-pi>`__

SSH
---

By default, SSH is disabled. Enable it to allow SSH access:

-  GUI = Raspberry Pi Configuration > Preferences > Interfaces> SSH: Enabled
-  CLI = ``sudo raspi-config`` > Interfacing Options > SSH: Yes > Ok > Finish
-  CLI headless = Mount the ``/boot/`` (first) partition and then create an empty directory called ``ssh`` in it. On the next boot, SSH will be enabled and started.

On Raspberry Pi OS >= 11 (Bullseye), the username and password must first be configured.

-  GUI = The GUI first-time setup wizard will prompt for a username and password.
-  CLI = The CLI first-time setup wizard will prompt for a username and password.
-  CLI headless

   -  Mount the ``/boot/`` (first) partition and then create a file called ``userconf.txt``. Add the username and password to the file by using the syntax ``<USERNAME>:<ENCRYPTED_PASSWORD>``. Use the command ``echo '<PASSWORD>' | openssl passwd -6 -stdin`` to generate the encrypted password. On the next boot, the user will be created. [18]

Run ``nmap -sP 192.168.1.0/24`` (or equivalent for the network address) to find the IP address that belongs to a "Raspberry Pi" device.

On Raspberry Pi OS <= 10 (Buster), log into the IP address of the Raspberry Pi using the default username ``pi`` and password ``raspberry``. [1]

Wi-Fi
-----

Starting with the release of the Raspberry Pi 3 Model B, the Raspberry Pi includes built-in Wi-Fi hardware. Connect to a Wi-Fi network using one of these methods [4]:

- GUI = Select the Wi-Fi icon in the top-right of the desktop.
- CLI = ``sudo raspi-config`` > Network Options > Wi-fi
- CLI headless =  Mount the ``/boot/`` (first) partition of Raspberry Pi OS. Then create a file called ``wpa_supplicant.conf`` in that directory with these contents below. Configure the country, SSID (Wi-Fi username), and PSK (Wi-Fi password). Upon the next boot, this file will be moved to the correct location and the Wi-Fi service will be enabled and started automatically.

   ::

      country=<TWO_LETTER_COUNTRY_CODE>
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
      network={
          ssid="<WIFI_USERNAME>"
          psk="<WIFI_PASSWORD>"
          key_mgmt=WPA-PSK
      }

A static IP address can be setup by using the DHCP daemon. [17]

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/dhcpcd.conf

::

   interface wlan0
   static ip_address=<IPV4_ADDRESS>/24
   static routers=<DEFAULT_GATEWAY>
   static domain_name_servers=<DNS_SERVER>

.. code-block:: sh

   $ sudo reboot

Upgrades
--------

Minor
~~~~~

Upgrading system packages to the latest minor release of Raspberry Pi OS is the same as upstream Debian.

.. code-block:: sh

   $ sudo apt-get update
   $ sudo apt-get dist-upgrade
   $ sudo reboot

For upgrading the Linux kernel and firmware, use the `rpi-update <https://github.com/raspberrypi/rpi-update>`__ command.

.. code-block:: sh

   $ sudo rpi-update
   $ sudo reboot

Projects
--------

LightShow Pi
~~~~~~~~~~~~

This projects creates a light show using GPU-accelerated mathematical equations to automatically figure out when to turn lights on and off. It processes the frequency of any given audio file to help determine that. It is commonly used for holiday house light shows.

Installation
^^^^^^^^^^^^

Requirements:

-  Raspberry Pi OS based on Debian 10 Buster

    -  Raspberry Pi OS based on Debian 11 Bullseye is not supported because the WiringPi Python project it relies on has been deprecated and does not work on newer versions of Debian.

-  Raspberry Pi 3 Model B+

    -  The Raspberry Pi 4 is only partially supported because it does not support GPU acceleration for the NumPy library it uses. [9]

Install LightShow Pi as the ``pi`` user [5]:

.. code-block:: sh

   $ cd ~
   $ git clone https://togiles@bitbucket.org/togiles/lightshowpi.git
   $ cd lightshowpi
   $ git checkout stable
   $ sudo ./install.sh
   $ echo 'export SYNCHRONIZED_LIGHTS_HOME=/home/pi/lightshowpi' >> ~/.bashrc
   $ sudo reboot

Usage
^^^^^

First, move to the LightShow Pi directory:

.. code-block:: sh

   $ cd ~/lightshowpi/

Verify that LightShow Pi can turn on and off all of the lights [6]:

.. code-block:: sh

   $ sudo python py/hardware_controller.py --state=flash
   $ sudo python py/hardware_controller.py --state=fade

Play one of the included sample songs to ensure the audio output is working:

.. code-block:: sh

   $ sudo python py/synchronized_lights.py --file=/home/pi/lightshowpi/music/sample/ovenrake_deck-the-halls.mp3

Play any song:

.. code-block:: sh

   $ sudo python py/synchronized_lights.py --file=<PATH_TO_AUDIO_FILE>

Play the included sample playlist:

.. code-block:: sh

   $ sudo python py/synchronized_lights.py --playlist=/home/pi/lightshowpi/music/sample/.playlist

Play any playlist:

.. code-block:: sh

   $ sudo python py/synchronized_lights.py --playlist=<PATH_TO_PLAYLIST>

Create a new playlist (avoid spaces in the path and MP3 file names):

   -  Syntax:

      .. code-block:: sh

         $ nano <PLAYLIST_NAME>
         <SONG_NAME_1><TAB><PATH_TO_FIRST_MP3>
         <SONG_NAME_2><TAB><PATH_TO_SECOND_MP3>

   -  Example:

      .. code-block:: sh

         $ nano hello_world.playlist
         Hello World    /home/pi/Music/hello_world.mp3
         Foo Bar    /home/pi/foo-bar.mp3

Automatically generate a playlist based on a directory of MP3 files (the new playlist file will be saved in the same directory as the music) [16]:

.. code-block:: sh

   $ python ./tools/playlist_generator.py
   Enter the full path to the folder of songs:

Start or stop the light show with the configured ``[lightshow] playlist_path``:

.. code-block:: sh

   $ sudo python bin/start_music_and_lights

.. code-block:: sh

   $ sudo python bin/start_music_and_lights

[7]

**Song Cache:**

A song needs to be played entirely at least once to build up a cache and will look different than the final result due to lagging behind from the large amount of processing power required. Play that song a second time to see the final result. [8] LightShow Pi runs NumPy in the background to generate a light show based on a song or playlist. This is even slower when GPU acceleration is disabled (such as on a Raspberry Pi 4 for compatibility purposes [9]). Most changes to the configuration file will also invalidate the cache and will require the song to be played again to recreate the cache.

Configuration
^^^^^^^^^^^^^

Copy the default configuration and then use the new overrides configuration for customizations. Do NOT modify the default configuration.

.. code-block:: sh

   $ cd ~/lightshowpi/
   $ cp config/defaults.cfg config/overrides.cfg
   $ nano config/override.cfg

Common configurations:

-  Disable GPU processing for Raspberry Pi 4 compatibility. [9]

   .. code-block:: ini

      [audio_processing]
      use_gpu = <BOOLEAN>

   -  ``use_gpu``

      -  ``False`` = Do not compute math equations using the graphics processor. This will be slower.
      -  ``True`` (default) = Compute math equations using the graphics processor. This will be faster.

-  Configure GPIO pins that are wired into a relay with lights plugged in. The pins layout will be different depending on the Raspberry Pi board.

   .. code-block:: ini

      [hardware]
      gpio_pins = <LIST_OF_INTEGERS>

   -  ``gpio_pins``

      -  Raspberry Pi 4 = ``8,9,7,0,2,3,12,13``.

-  Customize the frequency ranges automatically. This is the easiest way to configure the light show. LightShow Pi runs various math equations to automatically have each individual channel (light) turn on if a certain frequency is reached.

   .. code-block:: ini

      [audio_processing]
      min_frequency = <FLOAT>
      max_frequency = <FLOAT>

   -  ``min_frequency``

      -  Default = ``20``.
      -  Recommended = ``40``. [15]
      -  Recommended minimum = ``20``.
      -  Recommended maximum = ``200``. [10]

   -  ``max_frequency``

      -  Default = ``15000``.
      -  Recommended = ``12000``. [10]
      -  Recommended minimum = ``6000``. [10]
      -  Recommended maximum = ``20000``. [11][12]

-  Customize the frequency ranges manually. This gives direct control over which individual light will turn on when. This overrides both the ``min_frequency`` and ``max_frequency`` settings. This list needs to be one number longer than the number of ``gpio_pins`` because each channel is assigned a range between each set of defined values. For example, the first channel (light) will turn on if frequencies are between the first and second items in the list.

   .. code-block:: ini

      [audio_processing]
      custom_channel_frequencies = <LIST_OF_FLOATS>

   -  ``custom_channel_frequencies``

      -  Default = ``20.00,45.62,104.07,237.40,541.55,1235.36,6428.37,1466.05``. [11]
      -  Recommended = Use frequencies from each octave: ``0,125,250,500,1000,2000,4000,8000,16000``. [11][13]

-  Customize how quickly the lights turn on or off.

   .. code-block:: ini

      [lightshow]
      decay_factor = <FLOAT>
      attenuate_pct = <FLOAT>

   -  ``decay_factor`` = Controls the lights staying on longer. Lower values make the lights stay on for longer.

      -  Default = ``0`` (disabled).
      -  Recommended = ``0.10``. [15]
      -  Recommended value for lights to stay on longer = ``0.07``. [14]
      -  Recommended minimum = ``0.05``.
      -  Recommended maximum = ``0.20``.

   -  ``attenuate_pct`` = Controls the lights turning off faster. Higher values make the lights turn off faster.

      -  Default = ``0`` (disabled).
      -  Recommended = ``25``. [15]
      -  Recommended minimum = ``20``.
      -  Recommended maximum = ``50``.

-  Customize the time of the light show.

   .. code-block:: ini

      [lightshow]
      preshow_configuration = <DICTIONARY>

   -  ``preshow_configuration``

      -  Default = Keep lights on for 10 seconds before starting the show. When the show is over, keep the lights off for 1 second before starting the loop again.

         .. code-block:: ini

            [lightshow]
            preshow_configuration =
                {
                    "transitions": [
                        {
                            "type": "on",
                            "duration": 10,
                            "channel_control": {
                            }
                        },
                        {
                            "type": "off",
                            "duration": 1,
                            "channel_control": {
                            }
                        }
                    ],
                    "audio_file": null
                }

-  Change the default playlist.

   .. code-block:: ini

      [lightshow]
      playlist_path = <STRING>

   -  ``playlist_path``

      -  Default = ``$SYNCHRONIZED_LIGHTS_HOME/music/sample/.playlist``.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/raspberry_pi_os.rst>`__

Bibliography
------------

1. "Remote Access." Raspberry Pi Documentation. August 22, 2021. Accessed August 24, 2021. https://www.raspberrypi.org/documentation/computers/remote-access.html
2. "Operating system images." Raspberry Pi. Accessed August 24, 2021. https://www.raspberrypi.org/software/operating-systems/
3. "Hands on with the new Raspberry Pi OS release: Here's what you need to know." ZDNet. December 10, 2020. Accessed August 24, 2021.
4. "How To Configure WiFi on Raspberry Pi: Step By Step Tutorial." Latest Open Tech From Seed. 2021. Accessed May 12, 2022. https://www.seeedstudio.com/blog/2021/01/25/three-methods-to-configure-raspberry-pi-wifi
5. "Download and Install." LightShow Pi. Accessed May 12, 2022. https://www.lightshowpi.org/download-and-install/
6. "Configuring and Testing Your Hardware." Accessed May 12, 2022. https://www.lightshowpi.org/configuring-and-testing-your-hardware/
7. "Play Music." LightShow Pi. Accessed May 12, 2022. https://www.lightshowpi.org/configuring-and-testing-your-hardware/
8. "Custom frequencies." Reddit r/LightShowPi. November 24, 2018. Accessed May 12, 2022. https://www.reddit.com/r/LightShowPi/comments/9zub3h/custom_frequencies/
9. "Unable to enable V3D. Please check your firmware is up to date. Segmentation fault." Bitbucket Todd Giles / LightShow Pi. November 11, 2021. Accessed May 13, 2022. https://bitbucket.org/togiles/lightshowpi/issues/118/unable-to-enable-v3d-please-check-your
10. "I finally completed the setup for the frequencies, even I could get the channel 8 to work I had to use min_freq to 10 and max_freq to 1200 and that shouldn’t be right. I have a feeling that adding another 8 channel SSR the program would register the frequency better. Thoughts?" Reddit r/LightShowPi. December 19, 2018. Accessed May 13, 2022. https://www.reddit.com/r/LightShowPi/comments/9wk134/i_finally_completed_the_setup_for_the_frequencies/
11. "Fine tuning of my lightshowpi - custom channel frequencies, attenuate, min/max frequency." Reddit r/LightShowPi. November 2, 2019. Accessed May 13, 2022. https://www.reddit.com/r/LightShowPi/comments/dkkmn4/fine_tuning_of_my_lightshowpi_custom_channel/
12. "THE FREQUENCY SPECTRUM, INSTRUMENT RANGES, AND EQ TIPS." The National STEM Guitar Project. 2003. Accessed May 13, 2022. https://www.guitarbuilding.org/wp-content/uploads/2014/06/Instrument-Sound-EQ-Chart.pdf
13. "Sound - Frequency, Wavelength and Octave." Engineering ToolBox. 2003. Accessed May 13, 2022. https://www.engineeringtoolbox.com/sound-frequency-wavelength-d_56.html
14. "lights are very blinky. how can i slow them down?" Reddit r/LightShowPi. December 13, 2020. Accessed May 13, 2022. https://www.reddit.com/r/LightShowPi/comments/kcn0oy/lights_are_very_blinky_how_can_i_slow_them_down/
15. "Custom channel frequencies, attenuate, min/max frequency." Reddit r/LightShowPi. December 19, 2021. Accessed May 13, 2022. https://www.reddit.com/r/LightShowPi/comments/rcrgh5/custom_channel_frequencies_attenuate_minmax/
16. "Creating a Playlist for your LightShowPi (easy mode)." LightShowPi KB. December 8, 2017. Accessed May 14, 2022. https://lspkb.blogspot.com/2017/12/creating-playlist-for-your-lightshowpi.html
17. "How Do I Set a Static IP Address on Raspberry Pi?" MUO - Technology, Simplified. March 12, 2022. Accessed October 9, 2022. https://www.makeuseof.com/raspberry-pi-set-static-ip/
18. "An update to Raspberry Pi OS Bullseye." Raspberry Pi. April 7, 2022. Accessed December 21, 2022. https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/
