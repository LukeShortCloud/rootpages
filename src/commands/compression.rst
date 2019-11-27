Compression
===========

.. contents:: Table of Contents

bzip
----

bzip2
~~~~~

Package: bzip2

Files with the ".bz2" extension are compressed.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-v", "verbosely display output"

cpio
----

cpio
~~~~

Package: cpio

``cpio`` means copy input/output. This format is used for RPMs.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-id", "extract files AND directories"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "rpm2cpio httpd.rpm | cpio -id", "extract files and directories from the Apache RPM"

dtrx
----

dtrx
~~~~

Do the right extract (dtrx) is a universal compression utility for all formats. By default it runs in an interactive mode.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-m", "extract metadata from '.rpms', '.deb', or '.gem' packages"

gzip
----

gzip
~~~~

Package: gzip

Files with the ".gz" extension use gzip compression

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-d", "decompress a file"
   "-r", "recursively compress files"
   "-v", "verbosely display output"

pigz
~~~~

``pigz`` provides automatic multi-threaded compression and decompression for ``gzip``. See ``gzip`` for possible arguments.

rar
---

rar
~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-v", "verbosely display output"

unrar
~~~~~

star
----

This archive tool provides the ability to retain special ACL permissions.

star
~~~~

Package: star

``star`` provides extra capabilities to ``tar`` that allow for properly storing various types of attributes.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-x", "extract"
   "-v", "verbosely"
   "-f=", "provide the full file path to the '.star' archive"
   "-xattr", "preserve extended attributes such as SELinux permissions"

tar
---

tar
~~~

Package: tar

Files with the ".tar" extension are archived (not compressed).

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20
   
   "-x", "extracts a tar file"
   "-k", "do not delete existing files"
   "-c", "create a tar file"
   "-f", "use archive file"
   "-t", "lists files inside a tar file"
   "-T", "specify a file of directory/file names to tar"
   "-v", "verbosely display output"
   "-z", "compresses the archive using gzip to make a .tar.gz file"
   "-J", "uses xz compression"
   "-C", "specify the directory to extract to"
   "--selinux", "keep SELinux permissions"
   "--acls", "keep ACLs"
   "--xattrs", "keep extended attributes"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20
   
   "-zcvf /home /root/home_backup.tar.gz", "create a backup of the home directory"

xz
--

xz
~~

Package: xz

Best for compressing text files (saves the most space).

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-z, --compress", "compress files"
   "-d, --decompress", "decompress files"
   "--threads 0", "use the number of hyperthreads available from the CPU for faster processing"
   "-0", "fast compression, takes less time"
   "-9", "high compression, takes longer"

zip
---

unzip
~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   -d <DEST_DIR>, specify a destination directory to extract to
   -j, decompress files to the current working directory
   -l, list contents of the archive

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   -j <ZIP_FILE> <PATH_TO_COMPRESSED_FILE>, decompress a specific file and save it to the current working directory

jar
~~~

Package: java-openjdk

Jar files are Java applications that are compressed using ``zip``.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "cf", "create a Jar archive"
   "xf", "extract a Jar archive"

zip
~~~

Packag: zip

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-v", "verbosely display output"
   "-r", "recursively; for directories"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "-r root_archive.zip /root/", "create a zip archive of the root user home directory"

History
-------

-  `Latest <https://github.com/ekultails/rootpages/commits/master/src/commands/compression.rst>`__
-  `< 2019.01.01 <https://github.com/ekultails/rootpages/commits/master/src/linux_commands/compression.rst>`__
