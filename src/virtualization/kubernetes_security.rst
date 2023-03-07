Kubernetes Security
===================

.. contents:: Table of Contents

User Accounts
-------------

Role-Based Access Control (RBAC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

RBAC is enabled by default on a Kubernetes cluster by the ``kube-apiserver``.

.. code-block:: sh

   $ kube-apiserver --authorization-mode=RBAC

There are four APIs that configure RBAC. Roles define what verbs (actions) are allowed. RoleBindings assign a Role to a user or, group or service account.

Namespaced APIs:

-  Role
-  RoleBinding

Non-namespaced APIs:

-  ClusterRole
-  ClusterRoleBinding

Common verbs:

-  create
-  delete
-  get (read)
-  update

Find out if the current user, or a different user, can run a specific command.

.. code-block:: sh

   $ kubectl auth can-i <VERB> <API>

.. code-block:: sh

   $ kubectl auth can-i <VERB> <API> --as=<USER>

Commands can be run as a specific user or group:

.. code-block:: sh

   $ kubectl --as=<USER>

.. code-block:: sh

   $ kubectl --as-group=<GROUP>

[1]

Creating Certificates and Users
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A user is defined using the "common name" (CN) subject in a TLS certificate. The certificate is used instead of a password to authenticate to a Kubernetes cluster. Basic/password authentication was removed in Kubernetes 1.19. [4] The certificate must be signed by the Kubernetes certificate authority (CA).

-  Create a public and private key-pair for a new user.

   .. code-block:: sh

      $ openssl genrsa -out <USER>.key 4096

-  Create a certificate signing request for the new user.

   -  Normal user:

      .. code-block:: sh

         $ openssl req -new -key <USER>.key -subj "/CN=<USER>" -out <USER>.csr

   -  Administrative user. Only use this if the certificate will be manually signed. The ``CertificateSigningRequest`` (CSR) API does not allow creating objects with the organization field set to "system:masters". Instead, create a normal user above and apply administrative privileges as part of the CSR and [Cluster]RoleBinding objects.

      .. code-block:: sh

         $ openssl req -new -key <USER>.key -subj "/CN=<USER>/O=system:masters" -out <USER>.csr

-  Create and sign the certificate either manually using the Kubernetes certificate authority (found on the Control Plane Nodes) or using the Kubernetes CSR API.

   -  Manually:

      .. code-block:: sh

         $ openssl x509 -req -in <USER>.csr -CA ca.crt -CAkey ca.key -out <USER>.crt

   -  CSR API:

      -  Use ``base64`` to encode the certificate key file into a string.

         .. code-block:: sh

            $ base64 -w 0 <USER>.csr

      -  Create a CSR object. Refer to `examples from the Kubernetes Development documentation about CSR <kubernetes_development.html#certificatesigningrequest>`__.

         .. code-block:: yaml

            ---
            apiVersion: certificates.k8s.io/v1
            kind: CertificateSigningRequest
            metadata:
              name: <NEW_USER>
            spec:
              request: |
                <BASE64_ENCODED_CERTIFICATE_SIGNING_REQUEST>
              signerName: kubernetes.io/kube-apiserver-client
              # Optionally define the amount of time until the certificate should expire.
              #expirationSeconds:
              groups:
              - system: authenticated
              usages:
              - client auth

      -  The CSR will be in a ``Pending`` state until manually approved by an administrator user.

         .. code-block:: sh

            $ kubectl get csr <CSR_OBJECT_NAME>
            $ kubectl certificate approve <CSR_OBJECT_NAME>

      -  Extract the certificate file. If the CSR was valid, a ``csr.status.certificate`` field will be populated with the ``base64`` encoded certificate file.

         .. code-block:: sh

            $ kubectl get csr <CSR_OBJECT_NAME> --template={{.status.certificate}} | base64 -d > <USER>.crt

-  Unless the certificate was created manually with the ``/O=system:masters`` privileges, a [Cluster]Role and [Cluster]RoleBinding must be created for the user to assign permissions.
-  Find or create a role to use that will define the permissions the user has to the cluster.

    -  Find and use an existing ClusterRole (this can be used for a RoleBinding, not just a ClusterRoleBinding). For an administrator account, use ``cluster-admin`` for full access to everything or ``admin`` for full access only to the default APIs.

       .. code-block:: sh

          $ kubectl get clusterroles

   -  Or create a new [Cluster]Role.

      .. code-block:: sh

         $ kubectl create [cluster]role <ROLE_NAME> --verb=<VERB_1>,<VERB_2> --resource=<API_1>,<API_2>

-  Create a [Cluster]RoleBinding to grant the user those permissions.

   .. code-block:: sh

      $ kubectl create [cluster]rolebinding --[cluster]role=<ROLE_NAME> --user=<USER> <ROLEBINDING_NAME>

[1][5]

-  Finally a user can authenticate to the cluster either via ``kubectl`` or manually via an HTTP request through a tool such as ``curl``. Verify that the new account is working as expected.

   1.  ``$HOME/.kube/config`` file.
   2.  ``curl``:

      2a.  Syntax: ``curl --cert <USER>.crt --key <USER>.key --cacert ca.crt https://<CONTROL_PLANE_IP>:6443/``
      2b.  Example: ``curl --cert <USER>.crt --key <USER>.key -k https://127.0.0.1:6443/api/v1/namespaces/default/pods/``

Automatic TLS Certificate Creation with cert-manager
----------------------------------------------------

cert-manager provides a set of APIs that assist in the manual and automatic creation of TLS certificates.

cert-manager.io/v1 APIs:

-  Certificate = Create a CertificateRequest and, if it processes correctly, a Secret object will be created containing the TLS certificate.
-  CertificateRequest = A request to cert-manager (either manually from the Certificate API or automatically by specifying ``ingress.metadata.annotations: cert-manager.io/clusterissuer: <CLUSTER_ISSUER>``) to automatically create a certificate.
-  ClusterIssuer = A cluster-wide provider of certificates. Common Issuers include selfSigned, CA, and ACME (Let's Encrypt).
-  Issuer = Namespaced Issuers.

acme.cert-manager.io/v1 APIs (used automatically by the CertificateRequest API):

-  Challenge = A DNS or HTTP challenge for ACME to prove that the domain is owned by the person making the request for a signed certificate.
-  Order = A request to ACME for a new certificate.

[3]

cert-manager installation [2]:

.. code-block:: sh

   $ helm repo add jetstack https://charts.jetstack.io
   $ helm repo update
   $ helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.2.0 --create-namespace --set installCRDs=true
   $ kubectl --namespace cert-manager get pods

The process of managing certificates:

1.  Create a [Cluster]Issuer object once.
2.  Create a Certificate object using a [Cluster]Issuer for each domain that requires TLS encryption.
3.  Use the Certificate(s) in an Ingress or Gateway object(s).

Secrets Encryption at Rest
--------------------------

By default, Secret objects are unencrypted base64 strings stored in the etcd database. Kubernetes natively supports encrypting any API resource objects including Secrets. Every Control Plane Node needs to have these same changes made to be able to read and write encrypted Secrets.

Generate a base64-encoded key/password to be used for encrypting the Secrets.

.. code-block:: sh

   $ echo -n <PASSWORD> | base64

.. code-block:: sh

   $ echo -n password | base64
   cGFzc3dvcmQ=

Create a manifest for the EncryptionConfiguration API. Configure AES encryption for new Secret objects and allow old unencrypted Secrets to continue to work by using the no-operation ``identity`` provider. For information on the specification and usage of this special API, refer to the `EncryptionConfiguration documentation <kubernetes_development.html#encryptionconfiguration>`__.

.. code-block:: sh

   $ sudo touch /etc/kubernetes/encryption-configuration.yaml
   $ sudo chmod 0600 /etc/kubernetes/encryption-configuration.yaml
   $ sudo vim /etc/kubernetes/encryption-configuration.yaml

.. code-block:: yaml

   ---
   kind: EncryptionConfiguration
   apiVersion: apiserver.config.k8s.io/v1
   resources:
     - resources:
         - secrets
       providers:
         - aescbc:
             keys:
               - name: firstkey
                 secret: cGFzc3dvcmQ=
         - identity: {}

Add the ``--encryption-provider-config`` argument pointing to that manifest file for the ``kube-apiserver`` command.

.. code-block:: sh

   $ sudo vim /etc/kubernetes/manifests/kube-apiserver.yaml

.. code-block:: yaml

   spec:
     containers:
     - command:
       - kube-apiserver
       - --encryption-provider-config=/etc/kubernetes/encryption-configuration.yaml

Then add the ``pod.spec.volumes`` and the related ``pod.spec.containers.volumeMounts``.

.. code-block:: yaml

     volumes:
     - hostPath:
         path: /etc/kubernetes/encryption-configuration.yaml
         type: File
       name: encryption-configuration

.. code-block:: yaml

       volumeMounts:
       - mountPath: /etc/kubernetes/encryption-configuration.yaml
         name: encryption-configuration
         readOnly: true

The ``kubelet`` system service should pick up on the changes to the configuration file and recreate the Pod. If the EncryptionConfiguration is ever changed, move the ``kube-apiserver.yaml`` manifest to a different directory temporarily and then move it back. This will cause it to recreate the Pod without changing the manifest file itself.

.. code-block:: sh

   $ sudo mv /etc/kubernetes/manifests/kube-apiserver.yaml /etc/kubernetes/kube-apiserver.yaml
   $ sudo mv /etc/kubernetes/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml

After making all of the above changes on each Control Plane Node, re-create all Secret objects in Kubernetes. These will use the first EncryptionConfiguration provider listed which is now the AES encryption provider.

.. code-block:: sh

   $ kubectl get secrets --all-namespaces -o json | kubectl replace -f -

[6]

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/virtualization/kubernetes_security.rst>`__

Bibliography
------------

1. "Authenticating." Kubernetes Documentation. February 27, 2021. Accessed March 31, 2021. https://kubernetes.io/docs/reference/access-authn-authz/authentication/
2. "Kubernetes." cert-manager Documentation. March 8, 2021. Accessed March 31, 2021. https://cert-manager.io/docs/installation/kubernetes/
3. "API reference docs." cert-manager Documentation. January 1, 2021. Accessed March 31, 2021. https://cert-manager.io/docs/reference/api-docs/
4. "basic auth is deprecated." Kubernetes Master Charm Bugs. October 2, 2021. Accessed March 31, 2021. https://bugs.launchpad.net/charm-kubernetes-master/+bug/1841226
5. "Using RBAC Authentication." Kubernetes Documentation. February 11, 2021. Accessed March 31, 2021. https://kubernetes.io/docs/reference/access-authn-authz/rbac/
6. "Encrypting Secret Data at Rest." Kubernetes Documentation. May 30, 2020. Accessed July 21, 2021. https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/
