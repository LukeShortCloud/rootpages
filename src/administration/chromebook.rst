Chromebook
==========

.. contents:: Table of Contents

Linux
-----

Crostini
~~~~~~~~

Crostini is an official set of technologies used to securely run Linux (using a LXC container) on ChromeOS. By default, it runs Debian 10 Buster as of ChromeOS 80. [3] It does not require developer mode. Enable it by going into ChromeOS settings and selecting ``Linux (Beta)``. [1]

File Sharing
^^^^^^^^^^^^

The ``Files`` app will list ``Linux files``. That will load the visible contents of the ``/home/$USER/`` directory in the container. Directories from the ChromeOS hypervisor, such as ``Downloads``, can also be shared with the container. In the ``Files`` app, right-click on the directory and select ``Share with Linux``. It will be available in the container at ``/mnt/chromeos/MyFiles/``. [2]

Bibliography
------------

1. "Running Custom Containers Under Chrome OS." Chromium OS Docs. Accessed March 2, 2020. https://chromium.googlesource.com/chromiumos/docs/+/master/containers_and_vms.md
2. "Issue 878324: Share Downloads with crostini container." Chromium Bugs. May 6, 2019. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=878324
3. "Issue 930901: crostini: support buster as the default container." Chromium Bugs. February 7, 2020. Accessed March 2, 2020. https://bugs.chromium.org/p/chromium/issues/detail?id=930901
