Amazon Web Services (AWS)
=========================

.. contents:: Table of Contents

AWS CLI
-------

**Installation:**

-  Arch Linux:

   .. code-block:: sh

      $ sudo pacman -S aws-cli

-  Debian:

   .. code-block:: sh

      $ sudo apt-get install awscli

-  Fedora

   .. code-block:: sh

      $ sudo dnf install awscli2

-  Other:

   .. code-block:: sh

      $ wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
      $ unzip awscli-exe-linux-x86_64.zip
      $ sudo ./aws/install
      $ /usr/local/bin/aws version
      $ rm -r -f ./aws/ ./awscli-exe-linux-x86_64.zip

[1][2]

**Configuration:**

Before using the AWS CLI, it needs login information for an existing account. [3]

.. code-block:: sh

   $ aws configure
   AWS Access Key ID [None]: <AWS_ACCESS_KEY_ID>
   AWS Secret Access Key [None]: <AWS_SECRET_ACCESS_KEY>
   Default region name [None]: <AWS_SSO_REGION>
   Default output format [None]: None

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/public_clouds/amazon_web_services.rst>`__

Bibliography
------------

1. "Install or update the latest version of the AWS CLI." AWS Documentation. Accessed August 28, 2023. https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
2. "How to install aws cli on Linux." nixCraft. January 27, 2023. Accessed August 28, 2023. https://www.cyberciti.biz/faq/how-to-install-aws-cli-on-linux/
3. "How to Install and Configure AWS CLI on Linux." DevOpsCube. December 7, 2022. Accessed August 28, 2023. https://devopscube.com/install-configure-aws-cli-linux/
