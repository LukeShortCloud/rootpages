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

Services
~~~~~~~~

Here are all of the storage services provided by Azure [7]:

-  Blobs = Append (log), block (single object/file), and page (virtual disk drive) storage.

   -  Disks = Fully managed page blobs for virtual machines.

-  Files = SMB and/or NFS network storage.
-  Queues = Messaging queues.
-  Tables = NoSQL.

Disk
^^^^

Disks use blob storage in the back-end, are fully managed, and provide unique features over a standard blob.

Differences between Azure Disk and Azure Blob [13][14]:

.. csv-table::
   :header: Feature, Disk, Blob
   :widths: 20, 20, 20

   Back-end, Azure Blob (Page), Azure Blob (Page)
   File format, VHD, Any
   File system, NTFS, None
   Number of allowed mounts to a virtual machine, 1, Unlimited
   Storage Service Encryption (SSE), Yes, Yes
   Azure Disk Encryption, BitLocker (Windows) and DM-Crypt (Linux), None
   CDN, No, Yes

Disk types ranging from slow and cheap to fast and expensive [14]:

-  Standard HDD
-  Standard SSD
-  Premium SSD
-  Ultra disk

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

Access
^^^^^^

There are three types of access to Azure Storage:

-  Public Endpoint

   -  URL = ``<STORAGE_ACCOUNT>.<STORAGE_TYPE>.core.windows.net/<RESOURCE_NAME>``.

-  Restricted Access = The same public endpoint is used but access is restricted via a firewall.

   -  URL = ``<STORAGE_ACCOUNT>.<STORAGE_TYPE>.core.windows.net/<RESOURCE_NAME>``.

-  Private Endpoints = Requires the use of a private network and/or VPN to access.

   -  URL = ``<STORAGE_ACCOUNT>.privatelink.<STORAGE_TYPE>.core.windows.net/<RESOURCE_NAME>``. Microsoft recommends to always use the public endpoint URL, even when accessing the private endpoint, to prevent issues.

Access can be configured at the storage account level or the container level.

Change the default access settings for a storage account:

-  Azure Portal > Storage Accounts > (select an existing storage account) > Security + networking > Networking

   -  Firewalls and virtual networks

      -  Public network access: Enable from all network (default), Enabled from selected virtual networks and IP addresses, or Disabled
      -  Network Routing: Microsoft networking routing (default) or Internet routing
      -  Pubish route-specific endpoints: Microsoft networking routing and/or Internet routing

   -  Private endpoint connections
   -  Custom domain

Change the access level for all containers:

-  Azure Portal > Storage Accounts > (select an existing storage account) > Data storage > Containers > Change access level

Change the access level for a single container:

-  Azure Portal > Storage Accounts > (select an existing storage account) > Data storage > Containers > (select an existing container) > Change access level

[8]

Secure Access
'''''''''''''

All Azure Storage services use Storage Service Encryption (SSE) to secure data at-rest. In transit, HTTPS encryption is enforced by default.

Enforce secure access:

-  Azure Portal > Storage Accounts > (select an existing storage account > Settings > Configuration

   -  Secure transfer required: Enabled (default)
   -  Allow Blob public access: Disabled
   -  Allow storage account key access: Disabled
   -  Minimum TLS version: Version 1.2 (default)

These are the different ways to securely access Azure Storage:

-  Access Keys are automatically generated when a storage account is created.
-  Shared Access Signature (SAS) can provide restricted access to specific users.
-  Azure AD authentication via Access Control (IAM) can be used to access storage.

**Access Keys**

There are two access keys. One is the current access key and the second is to allow rotating out the old and gradually replacing it.

-  Azure Portal > Storage Accounts > (select an existing storage account) > Security + networking > Access keys

**SAS**

Generate a SAS token for an entire storage account or a container.

-  Azure Portal > Storage accounts > (select an existing storage account) > Settings + network > Shared access signature > Generate SAS and connection string
-  Azure Portal > Storage accounts > (select an existing storage account) > Data storage > Containers > (select an existing container) > Settings > Shared access signature > Generate SAS token and URL

**Azure AD**

A storage account along with most storage objects, besides just containers, support Azure AD access based on role assignments.

-  Azure Portal > Storage accounts > (select an existing storage account) > Access Control (IAM)
-  Azure Portal > Storage accounts > (select an existing storage account) > Data storage > (select a storage type) > Access Control (IAM)
-  Azure Portal > Storage accounts > (select an existing storage account) > Data storage > (select a storage type) > (select an existing resource) > Access Control (IAM)

Utilities
'''''''''

There are two official and free tools for accessing Azure storage [9]:

-  AzCopy = CLI supported on Linux, macOS, and Windows.
-  Storage Explorer = GUI supported on Linux, macOS, and Windows.

   -  This uses AzCopy in the back-end.
   -  In the Azure Portal, a limited version of the Storage Explorer is provided:

      -  Azure Portal > Storage Accounts > (select an existing storage account) > Storage Explorer (preview)

   -  `Download <https://azure.microsoft.com/en-us/features/storage-explorer/>`__ and use the full Storage Explorer program for the full feature-rich experience.

Jobs
'''''

Azure Jobs provides a way to physically move a large amount of data between on-prem and the Azure cloud.

-  Azure Import Job steps (send drives to Microsoft):

   1.  Customer prepares disks using WAImportExport (this is only supported on Windows)
   2.  Create job
   3.  Customer ships drives to Microsoft
   4.  Check job status
   5.  Microsoft receives the disks
   6.  Check data in Azure Storage
   7.  Disks are shipped back to the customer

-  Azure Export Job steps (receive drives from Microsoft):

   1.  Create job
   2.  Microsoft prepares disks
   3.  Microsoft ships drives to the customer
   4.  Check job status
   5.  Customer receives the disks
   6.  Use WAImportExport to unlock the encrypted BitLocker disks and move the data to a different disk
   7.  Disks are shipped back to Microsoft

Create a job request:

-  Azure Portal > Import/export jobs > + Create

Costs for a job include:

-  Shipping fee to and from Microsoft
-  Per-drive handling fee
-  Import and export transaction fee

[10]

Object Replication
^^^^^^^^^^^^^^^^^^

Objects can be replicated across different Azure Subscriptions and regions. Object replication requires a general purpose v2 storage account.

Create a source storage account:

-  Azure Portal > Storage Accounts > + Create > Next: Networking > Next: Data Protection > Tracking

   -  Turn on versioning for blobs
   -  Turn on blob change feed

Create a destination storage account:

-  Azure Portal > Storage Accounts > + Create > Next: Networking > Next: Data Protection > Tracking

   -  Turn on versioning for blobs

Create a source and destination container:

-  Azure Portal > Storage Accounts > (select the source storage account) > Blob service > Containers > + Container > Create
-  Azure Portal > Storage Accounts > (select the destination storage account) > Blob service > Containers > + Container > Create

Create the replication policy:

-  Azure Portal > Storage Accounts > (select the source storage account) > Blob service > Object replication > + Set up replication rules

[11]

Lifecycle Management
^^^^^^^^^^^^^^^^^^^^

Lifecycle management helps to minimize costs by automating (1) the deletion or (2) archival of objects.

Create a lifecycle management rule to move objects after a specified number of days [12]:

-  Azure Portal > Storage Accounts > (select an existing storage account) > Blob service > Lifecycle Management > + Add a rule > Next

   -  if-then block

      -  If - Base blobs were - Last modified - More than (days ago)
      -  Then (select one)

         -  Move to cool storage
         -  Move to archive storage
         -  Delete the blob

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
7. "Introduction to Azure Storage." Microsoft Docs - Azure Storage. March 17, 2022. Accessed May 20, 2022. https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json
8. "Use private endpoints for Azure Storage." Microsoft Docs - Azure Storage. March 10, 2022. Accessed June 9, 2022. https://docs.microsoft.com/en-us/azure/storage/common/storage-private-endpoints
9. "Azure storage explorer." Azure Lessons. March 14, 2021. Accessed June 9, 2022. https://azurelessons.com/azure-storage-explorer/
10. "What is Azure Import/Export service?" Microsoft Docs - Azure Storage. March 15, 2022. Accessed June 9, 2022. https://docs.microsoft.com/en-us/azure/import-export/storage-import-export-service
11. "Azure Storage Object Replication." Tech Talk Corner. September 29, 2020. Accessed June 9, 2022. https://www.techtalkcorner.com/azure-storage-object-replication/
12. "Data Lifecycle Management in Azure Blob Storage." SQLShack. February 17, 2022. Accessed June 9, 2022. https://www.sqlshack.com/data-lifecycle-management-in-azure-blob-storage/
13. "Azure Blob storage vs Azure Drive." Stack Overflow. December 5, 2012. Accessed June 10, 2022. https://stackoverflow.com/questions/6295004/azure-blob-storage-vs-azure-drive
14. "Azure Storage Types: What are they?" ZiniosEdge. June 15, 2021. Accessed June 10, 2022. https://ziniosedge.com/azure-storage-types-what-are-they/
