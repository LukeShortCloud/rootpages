Laptops
=======

.. contents:: Table of Contents

Brands
------

Brands that provide Linux pre-installed:

-  `Dell <https://www.dell.com/support/contents/en-us/category/product-support/self-support-knowledgebase/operating-systems>`__ = RHEL, SLED, and Ubuntu.
-  `Lenovo <https://support.lenovo.com/us/en/solutions/pd031426>`__ = `Fedora <https://news.lenovo.com/pressroom/press-releases/lenovo-brings-linux-certification-to-thinkpad-and-thinkstation-workstation-portfolio-easing-deployment-for-developers-data-scientists/>`__, RHEL, SLED, and Ubuntu.
-  `Star Labs <https://starlabs.systems/>`__ = elementary OS, Linux Mint, Manjaro, MX Linux, Ubuntu, or Zorin OS.
-  `System76 <https://system76.com/>`__ = Pop!_OS and Ubuntu.
-  `TUXEDO Computers <https://www.tuxedocomputers.com/index.php>`__ = Manjaro, openSUSE, TUXEDO_OS, or Ubuntu.

Brands that provide Linux hardware support but do not pre-install an operating system:

-  `Framework <https://frame.work/>`__ = `Fedora <https://guides.frame.work/Guide/Fedora+35+Installation+on+the+Framework+Laptop/108?lang=en>`__, `Linux Mint <https://guides.frame.work/Guide/Mint+20.3+Installation+on+the+Framework+Laptop/110?lang=en>`__, `Manjaro <https://guides.frame.work/Guide/Manjaro+21.2.1+Installation+on+the+Framework+Laptop/111?lang=en>`__, and `Ubuntu <https://guides.frame.work/Guide/Ubuntu+21.10+Installation+on+the+Framework+Laptop/109?lang=en>`__.

Graphics Cards
--------------

NVIDIA
~~~~~~

For the best experience, get a laptop with at least an `Intel Coffee Lake (Intel Core >= 9000 series) CPU <https://ark.intel.com/content/www/us/en/ark/products/codename/97787/coffee-lake.html>`__ and a `NVIDIA Turing (GeForce RTX >= 2000 series) GPU <https://www.nvidia.com/en-us/geforce/turing/>`__. These are the minimum requirements for automatic power management of the graphics card which will greatly increase battery life. The integrated Intel GPU is used until an application is specifically ran with offloading to the NVIDIA GPU. [1]

Battery
-------

There are a few popular battery management utilities for Linux that are used to extend the battery life of a laptop. The most popular options are `auto-cpufreq <https://github.com/AdnanHodzic/auto-cpufreq>`__ and `TLP <https://github.com/linrunner/TLP>`__. Both programs will automatically change power profiles based on the current usage of the portable computer.

``auto-cpufreq`` is preferred as it has more features such as a turbo mode to increase the processor frequency/speed. These two programs are not compatible with each other.

Install:

-  Arch Linux:

   .. code-block:: sh

      $ yay -S auto-cpufreq

-  Other:

   .. code-block:: sh

      $ git clone https://github.com/AdnanHodzic/auto-cpufreq.git
      $ cd ./auto-cpufreq/
      $ sudo ./auto-cpufreq-installer

Enable and start the service:

   .. code-block:: sh

      $ sudo systemctl enable --now auto-cpufreq

[2]

Cooling
-------

A comparison was done between three different types of cooling methods for a laptop. These are differences in temperature (celsius) between each cooling method versus having the laptop on a desk. Using a cooling pad can provide the best results but, on average, a laptop stand is usually the best. [3]

.. csv-table::
   :header: Method, Min, Average, Max
   :widths: 20, 20, 20, 20

   Cooling Pad, -1.0, 3.4, 11
   Vacuum Cooler, -1.0, 3.4, 7.0
   Laptop Stand, 0.0, 3.6, 5.0

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/laptops.rst>`__

Bibliography
------------

1. "Chapter 22. PCI-Express Runtime D3 (RTD3) Power Management." NVIDIA Accelerated Linux Graphics Driver README and Installation Guide. Accessed December 30, 2020. https://us.download.nvidia.com/XFree86/Linux-x86_64/455.45.01/README/dynamicpowermanagement.html
2. "AdnanHodzic/auto-cpufreq." GitHub. January 9, 2022. Accessed February 5, 2022. https://github.com/AdnanHodzic/auto-cpufreq
3. "The ULTIMATE Laptop Cooling Comparison - Pad vs Vacuum vs Stand." YouTube - Jarrod'sTech. March 23, 2020. Accessed December 20, 2022. https://www.youtube.com/watch?v=tXvKiy65pwg
