Accessories
===========

.. contents:: Table of Contents

USB Ports
---------

Universal Serial Bus (USB) is a common connector for accessories. Real world speeds for USB are about 30% less than the theoretical maximum speeds.

.. csv-table::
   :header: Name (New), Name (Original), Maximum Theoretical Speed (Gbps), Real World Speed (Gbps), Real World Speed (MBps)
   :widths: 20, 20, 20, 20, 20


   USB 4, "", 40, 32, 4000
   USB 3.2 Gen 2x2, USB 3.2, 20, 16, 2000
   USB 3.2 Gen 2x1, USB 3.1 and USB 3.1 Gen 2, 10, 7.2, 900
   USB 3.2 Gen 1x2, "", 10, 7.2, 900
   USB 3.2 Gen 1, USB 3.0 and USB 3.1 Gen 1, 5, 3.2, 400
   USB 2.0, "", 0.480, "", ""
   USB 1.1 Hi-Speed, "", 0.012, "", ""
   USB 1.1 Low Speed, "", 0.0015, "", ""

[2]

As of USB 4, Thunderbolt 4 is natively supported with all cables and interfaces. All Thunderbolt 3 interfaces are USB type-C but not all USB type-C interfaces are Thunderbolt. All Thunderbolt 4 interfaces are USB 4 and vice-versa. [3]

USB Devices
-----------

Polling Frequency
~~~~~~~~~~~~~~~~~

The polling frequency of a USB device can be set based on the type of device it is:

-  jspoll = Joystick (gamepad)
-  kbpoll = Keyboard
-  mousepoll = Mouse

An interval of time in miliseconds is configurable for the polling frequency. The default interval is 10ms. Linux uses this equation to calculate the frequency (Hz) that it should use for checking input from a device: ``<RATE> Hz = 1000 / <INTERVAL> ms``. A lower interval will make a device more responsive but it will also use more processing power.

Here is how to change the pollling frequency:

-  Temporary

   -  Syntax:

      .. code-block:: sh

         $ echo "<INTERVAL>" | sudo tee /sys/module/usbhid/parameters/<DEVICE>

   -  Example (250 Hz USB mouse):

      .. code-block:: sh

         $ echo "4" | sudo tee /sys/module/usbhid/parameters/mousepoll

-  Permanent

   -  Syntax:

      .. code-block:: sh

         $ sudo vim /etc/default/grub
         GRUB_CMDLINE_LINUX_DEFAULT="usbhid.<DEVICE>=<INTERVAL>"
         $ sudo grub-mkconfig -o /boot/grub/grub.cfg

   -  Example (500 Hz USB keyboard):

      .. code-block:: sh

         $ sudo vim /etc/default/grub
         GRUB_CMDLINE_LINUX_DEFAULT="usbhid.kbpoll=2"
         $ sudo grub-mkconfig -o /boot/grub/grub.cfg

[4]

Gamepads
~~~~~~~~

A gamepad is a game controller that usually has thumbsticks, triggers, and buttons.

Top gamepads [1]:

1.  Xbox 360 Controller
2.  PS4 Controller
3.  Xbox One Controller
4.  PS3 Controller
5.  Steam Controller

Xbox Controllers
^^^^^^^^^^^^^^^^

The Linux kernel natively provides a ``xpad`` driver for wired original Xbox, Xbox 360, and Xbox One controllers. However, the Xbox One controller support conflicts with the new and improved ``xone`` driver. It is recommended to use ``xpad-noone`` instead of ``xpad`` to remove the overlapping support of Xbox One controllers. Otherwise, there were be problems with driver conflicts. [5] Bluetooth controllers natively work and do not require any additional setup.

-  Install ``xpad-noone`` and block the usage of ``xpad``.

   .. code-block:: sh

      $ sudo git clone https://github.com/medusalix/xpad-noone /usr/src/xpad-noone-1.0
      $ sudo dkms install -m xpad-noone -v 1.0 -k $(uname -r)
      $ echo -e "\nblacklist xpad\n" | sudo tee -a /etc/modprobe.d/xbox-controllers.conf
      $ sudo rmmod xpad
      $ sudo modprobe xpad-noone

-  Install the modern ``xone-dkms`` driver for handling Xbox One and Xbox Series controllers.

   -  Arch Linux:

      .. code-block:: sh

         $ yay -S xone-dkms-git
         $ sudo modprobe xone-wired

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/accessories.rst>`__

Bibliography
------------

1. "Controller Gaming on PC." Steam Blog. September 25, 2018. Accessed August 17, 2021. https://steamcommunity.com/games/593110/announcements/detail/1712946892833213377
2. "USB 3.2 Speed Comparison & Drive Benchmark." Everything USB. November 2019. Accessed August 25, 2021. https://www.everythingusb.com/speed.html
3. "USB 3, USB 4, Thunderbolt, & USB-C --- everything you need to know." AppleInsider. August 24, 2020. Accessed August 25, 2021. https://appleinsider.com/articles/20/08/24/usb-3-usb-4-thunderbolt-usb-c----everything-you-need-to-know
4. "Mouse polling rate." Arch Wiki. January 25, 2022. Accessed February 11, 2022. https://wiki.archlinux.org/title/mouse_polling_rate
5. "Added information about xpad-noone #15." GitHub medusalix/xone. August 27, 2022. Accessed February 16, 2023. https://github.com/medusalix/xone/pull/15
