Webcams
=======

.. contents:: Table of Contents

DSLR
----

Photos
~~~~~~

For photos, use the `Entangle <https://entangle-photo.org/>`__ application. The DSLR needs to be connected to the computer via a USB cable and must NOT be mounted.

Videos
~~~~~~

The swiss-army-knife `Open Broadcaster Software (OBS) Studio <https://obsproject.com/>`__ provides a cross-platform way to stream DSLR output and use it for video recording and online conferencing. [1] This guide covers how to set it up for Arch Linux. Fedora currently has issues with compilation and does not have an official build available. [2]

OBS < 26.1 requires this plugin to enable the "virtual camera" feature that the Windows version of OBS has built-in. It is shipped as part of OBS Studio 26.1.

.. code-block:: sh

   $ yay -S obs-v4l2sink

All versions of OBS will require the ``v4l2loopback`` kernel module for faking a webcam device. The gPhoto plugin for OBS is required to stream the video from the DSLR itself.

.. code-block:: sh

   $ yay -S obs-gphoto v4l2loopback-dkms

Set the required kernel module options [3]:

-  video_nr = The number to use for the ``/dev/video<NUMBER>`` device name. Required for streaming more than one source. The default is ``/dev/video0``.
-  card_label = A nickname for the virtual webcam. Video conferencing software will use this as one of the possible input devices.
-  exclusive_caps=1 = Required for video conferencing software to detect the device as a webcam.

.. code-block:: sh

   $ echo 'options v4l2loopback video_nr=0 card_label="vcam" exclusive_caps=1' | sudo tee /etc/modprobe.d/v4l2.conf

Load the kernel module.

.. code-block:: sh

   $ sudo modprobe v4l2loopback

Set the kernel module to also load on boot.

.. code-block:: sh

   $ echo 'v4l2loopback' | sudo tee /etc/modules-load.d/v4l2.conf

In OBS, add a new Source:

::

   OBS Studio > Sources > + > gPhoto live preview capture

The DSLR must NOT be mounted for the live preview to work.

Create the virtual webcam device. It will now show up in online video conferencing software. [4]

::

   OBS Studio > Tools > v4l2sink > Start

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/computer_hardware/webcams.rst>`__

Bibliography
------------

1. "OBS Studio." Open Broadcast Software. Accessed November 29, 2020. https://obsproject.com/
2. "cant build on fedora 32 #42." GitHub CatxFish/obs-v4l2sink. September 18, 2020. Accessed November 29, 2020. https://github.com/CatxFish/obs-v4l2sink/issues/42
3. "Green-screen webcam on Linux." boombatower. April 14, 2020. Accessed November 29, 2020. https://blog.boombatower.com/2020/04/14/greenscreen-webcam-on-linux
4. "Has anyone successfully output from OBS to a live ZOOM conference on linux?" Open Broadcast Sofware Studio Support. October 3, 2020. Accessed November 29, 2020. https://obsproject.com/forum/threads/has-anyone-successfully-output-from-obs-to-a-live-zoom-conference-on-linux.117026/
