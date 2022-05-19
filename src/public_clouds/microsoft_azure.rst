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

Storage
-------

Storage Accounts
~~~~~~~~~~~~~~~~

Storage accounts provide a namespace to group and store related data. All data is encrypted at-rest by Storage Service Encryption (SSE) and is encrypted in-transit by HTTPS. Every storage account needs to have a unique name across all of Azure Storage. This is used to create a unique endpoint URL to access the various storage services: ``https://<STORAGE_ACCOUNT>.<STORAGE_SERVICE>.core.windows.net``. Each storage account needs to have a default account type, replication type, and access tier set by the cloud operator. [4]

Performance tiers and account types:

-  **Standard** [3]

   -  **General Purpose v2** = The default and recommended storage account for general usage. It provides the use of different replication and access tiers.
   -  **General Purpose v1** = The original storage account type in Azure. Microsoft has no plans to deprecate it yet. Does not support lifecycle management, replication, or access tiers other than "hot".

-  **Premium** = These all provide high-performance and low-latency storage. [4]

   -  **Premium block blobs**
   -  **Premium page blobs**
   -  **Premium file shares** = NFS is available as another supported file system it can manage.

Replication types [5]:

.. csv-table::
   :header: Type, Description, Outage it will withstand
   :widths: 20, 20, 20

   Locally Redundant Storage (LRS), 3 copies in a physical location., Server
   Zone-Redundant Storage (ZRS), 3 copies within a single region and different physical locations., Data center
   Geo-Redundant Storage (GRS), LRS in two different regions., Region
   Geo-Zone Gedundant Storage (GZRS), ZRS in one region and LRS is a second region., Region

Access tiers [6]:

.. csv-table::
   :header: Tier, Usage, Minimum Days of Storage
   :widths: 20, 20, 20

   Hot, Very active., 0
   Cold, Not very active., 30
   Archive, Backup., 180

For the archive access tier, ZRS and GZRS are not supported. [6]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/public_clouds/microsoft_azure.rst>`__

Bibliography
------------

1. "How to install the Azure CLI." Microsoft Docs. February 10, 2022. Accessed March 28, 2022.
2. "Microsoft Azure Pricing and Licensing: 6 Things You Should Know." sherweb. May 2, 2018. Accessed March 28, 2022. https://www.sherweb.com/blog/cloud-server/understanding-microsoft-azure-pricing/
3. "Azure Storage Options Explained." Skylines Academy. June 28, 2019. Accessed May 19, 2022. https://www.skylinesacademy.com/blog/2019/6/28/azure-storage-options-explained
4. "Storage account overview." Microsoft Docs - Azure Storage. April 28, 2022. Accessed May 19, 2022. https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
5. "Azure Storage redundancy." Microsoft Docs - Azure Storage. May 12, 2022. Accessed May 19, 2022. https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
6. "Hot, Cool, and Archive access tiers for blob data." Microsoft Docs - Azure Storage. May 12, 2022. Accessed May 19, 2022. https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
