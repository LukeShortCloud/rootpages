Microsoft Azure
===============

.. contents:: Table of Contents

Pricing
-------

Microsoft provides two different calculators to help estimate costs:

- `Pricing Calculator <https://azure.microsoft.com/en-us/pricing/calculator/>`__ = View the price of individual resources.
- `Total Cost of Ownership (TCO) calculator <https://azure.microsoft.com/en-us/pricing/tco/calculator/>`__ = View the price comparison between existing on-premises infrastructure and moving to the Microsoft Azure public cloud.

Resources have different costs based on many factors:

-  Subscription type = there are different plans including free, pay-as-you-go, Enterprise Agreement, and Cloud Solution Provider (CSP) that all affect costs.
-  Resource type = each resource has a different cost associated with it.
-  Resource usage = the amount of the resource that is used (for example, the amount of disk space used).
-  Meter usage = the amount of time the resource is on (for example, the amount of time a virtual machine is on).
-  Region = each region has different prices for the same types of resources.

[2]

For more documentation on how billing works, refer to the `Cost Management + Billing documentation <https://docs.microsoft.com/en-us/azure/cost-management-billing/>`__.

azure-cli (az)
--------------

**Installation:** [1]

-  `Arch Linux <https://aur.archlinux.org/packages/azure-cli>`__:

   .. code-block:: sh

      $ yay -S azure-cli

-  Debian:

   .. code-block:: sh

      $ curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

-  Fedora:

   .. code-block:: sh

      $ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
      $ sudo vim /etc/yum.repos.d/azure-cli.repo
      [azure-cli]
      name=Azure CLI
      baseurl=https://packages.microsoft.com/yumrepos/azure-cli
      enabled=1
      gpgcheck=1
      gpgkey=https://packages.microsoft.com/keys/microsoft.asc
      $ sudo dnf install azure-cli

-  macOS:

   .. code-block:: sh

      $ brew install azure-cli

-  Other:

   .. code-block:: sh

      $ curl -L https://aka.ms/InstallAzureCli | bash

For documentation on how to use the ``az`` command, refer to `here <https://docs.microsoft.com/en-us/cli/azure/>`__.

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/public_clouds/microsoft_azure.rst>`__

Bibliography
------------

1. "How to install the Azure CLI." Microsoft Docs. February 10, 2022. Accessed March 28, 2022.
2. "Microsoft Azure Pricing and Licensing: 6 Things You Should Know." sherweb. May 2, 2018. Accessed March 28, 2022. https://www.sherweb.com/blog/cloud-server/understanding-microsoft-azure-pricing/
