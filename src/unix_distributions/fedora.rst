Fedora
======

.. contents:: Table of Contents

Red Hat Enterprise Linux (RHEL)
-------------------------------

RHEL is a downstream distribution, based on Fedora, aimed at servers. There are various corporate and community distributions of Enterprise Linux (EL).

Comparison:

.. csv-table::
   :header: FEATURE, RHEL, Oracle Linux, AlmaLinux, Rocky Linux
   :widths: 20, 20, 20, 20, 20

   Years of support, >= 12 [1], 10, 10, 10
   Organization type, Profit, Profit, Non-profit [2], Profit
   Price, Free up to 16 servers [3], Free, Free, Free
   Optional paid support, Yes, Yes, Yes, Yes
   Btrfs support, No, Yes [4], No, No
   Old hardware support, No, No, Yes [44], No

Most popular EL distributions [29]:

1.  Rocky Linux
2.  RHEL
3.  AlmaLinux
4.  CentOS Stream
5.  Oracle Linux

Releases
--------

Fedora releases:

-  38

   -  `Flathub is no longer filtered to only show Fedora approved packages <https://fedoraproject.org/wiki/Changes/UnfilteredFlathub>`__.
   -  `Fedora Budgie Spin is a new workstation spin with the Budgie desktop environment <https://fedoramagazine.org/announcing-fedora-38/>`__.
   -  `Fedora Sericea is a new rpm-ostreee spin that uses the Sway window tiling manager <https://fedoramagazine.org/announcing-fedora-38/>`__.
   -  `Fedora Phosh is a new workstation spin that uses the Phosh desktop environment <https://fedoramagazine.org/announcing-fedora-38/>`__.

-  37

   -  `Raspberry Pi 4 is now the first Pi to be officially supported by Fedora <https://fedoramagazine.org/announcing-fedora-37/>`__.

-  35

   -  `Fedora Kinoite is a new rpm-ostree spin, the second behind Fedora Silverblue, that uses the KDE Plasma desktop environment <https://fedoramagazine.org/announcing-fedora-35/>`__.

-  34

   -  `Btrfs now uses Zstandard compression for new installs <https://fedoraproject.org/wiki/Changes/BtrfsTransparentCompression>`__.
   -  `PipeWire is now the default audio server <https://fedoramagazine.org/announcing-fedora-35/>`__.

-  33

   -  `Btrfs is now the default file system for new installs <https://fedoraproject.org/wiki/Changes/BtrfsByDefault>`__.

Set root Password
-----------------

As of Fedora 28, the ``root`` user password is disabled for security reasons. This means that traditional emergency mode will not work and instead result in this error [7]:

::

   Cannot open access to console, the root account is locked.
   See sulogin(8) man page for more details.
   
   Press Enter to continue.

Set the ``root`` password to be able to enter emergency mode if ever needed:

.. code-block:: sh

   $ sudo passwd root

If the password is not set and emergency mode needs to be accessed, Fedora provides a `guide <https://docs.fedoraproject.org/en-US/quick-docs/bootloading-with-grub2/#restoring-bootloader-using-live-disk>`__ on how to ``chroot`` into the file system from a recovery media. Then the password can be changed from there.

Remove Flathub Filter
---------------------

Starting with Fedora 38, the Flathub repository (used for installing community Flatpak packages) is no longer filtered to only be Fedora approved packages. [5] On Fedora 37 and older, the filter prevented installing popular packages such as Google Chrome. This filter can be removed. [6]

.. code-block:: sh

   $ flatpak remote-list
   Name    Options
   fedora  system,oci
   flathub system,filtered
   $ sudo flatpak remote-modify flathub --no-filter
   $ flatpak remote-list
   Name    Options
   fedora  system,oci
   flathub system

Disable Automatic System Updates
--------------------------------

Fedora will, at least, download package metadata by default and, at most, automatically install new packages. Updates can be disabled and handled manually instead.

-  Fedora (all):

   -  Disable GNOME Software Center from checking for updates and applying updates.

      .. code-block:: sh

         $ dconf write /org/gnome/software/allow-updates false
         $ dconf write /org/gnome/software/download-updates false

   -  Optionally also disable GNOME Software Center from starting on boot. [8]

      .. code-block:: sh

         $ sudo rm -f /etc/xdg/autostart/org.gnome.Software.desktop

-  Fedora Workstation [9]:

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/dnf/dnf.conf
      metadata_timer_sync=0
      $ sudo systemctl disable dnf-makecache.timer
      $ sudo systemctl disable dnf-automatic.timer

-  Fedora Silverblue [10]:

   .. code-block:: sh

      $ sudo vim /etc/rpm-ostreed.conf
      [Daemon]
      AutomaticUpdatePolicy=none
      $ sudo rpm-ostree reload
      $ sudo systemctl disable rpm-ostreed-automatic.timer

Workstation Upgrades
--------------------

-  Update to the latest minor version of Fedora. Reboot when finished to load the changes.

   .. code-block:: sh

      $ sudo dnf upgrade --refresh
      $ sudo reboot

-  Install the upgrade plugin.

   .. code-block:: sh

      $ sudo dnf install dnf-plugin-system-upgrade

-  Download the packages for the next major version or do a skip upgrade to the version after that. Skip upgrades are fully supported on Fedora Workstation.

   .. code-block:: sh

      $ sudo dnf system-upgrade download --releasever=<FEDORA_MAJOR_VERSION>

-  Install the upgraded packages. [30]

   .. code-block:: sh

      $ sudo dnf system-upgrade reboot

Rawhide
-------

Introduction
~~~~~~~~~~~~

Fedora Rawhide is a rolling release of Fedora, built daily, and designed for developers to test with. It uses packages that are built from git repositories, release candidates, etc. that are considered to be usable. [35]

Switch to and from Rawhide
~~~~~~~~~~~~~~~~~~~~~~~~~~

It is possible to switch from Fedora Rawhide back to a stable release. [36][37]

.. code-block:: sh

   $ export FEDORA_RELEASE=39
   $ sudo -E dnf distro-sync --releasever=${FEDORA_RELEASE} --refresh --disablerepo rawhide --enablerepo fedora --allowerasing --best

Alternatively, upgrade from a stable release to Fedora Rawhide.

.. code-block:: sh

   $ sudo dnf distro-sync --releasever=rawhide --refresh --disablerepo fedora --allowerasing --best

rpm-ostree (Fedora CoreOS and Fedora Atomic Desktops)
-----------------------------------------------------

Fedora CoreOS
~~~~~~~~~~~~~

Fedora CoreOS (FCOS) is a minimal operating system designed to run on servers. It is commonly used to run Kubernetes clusters such as OpenShift. It is a rolling release distribution and provides automatic updates. [42]


There are 3 update streams. Here they are in order of least frequently to most frequently updated [43]:

1. stable
2. testing = This provides the exact same package versions as Fedora Atomic Desktops and Fedora Workstations.
3. next
4. rawhide

Spins
~~~~~

Fedora provides installations with different desktop environments. These are known as spins. For rpm-ostree distributions, they have special code names listed below. [13][14] Fedora Silverblue was the first spin and was originally called Fedora Atomic Host. [15]

.. csv-table::
   :header: Fedora Spin, Desktop Environment
   :widths: 20, 20

   Silverblue, GNOME
   Kinoite, KDE Plasma
   Lazurite, LXQt [26]
   Onyx, Budgie [27]
   Sericea, Sway

Dual Booting
~~~~~~~~~~~~

Fedora Silverblue does not support customized partitions or sharing a drive with a different operating system. It is recommended to use the automated installer to install it onto its own storage device. [11]

Through the use of ``os-prober`` (which is part of a default installation), a GRUB menu will be generated with all of the detected operating systems on each drive. This allows for partial dual-boot support.

Two installations of Fedora Silverblue on the same system are also not supported and will lead to issues. [12]

RPM GPG Keys
~~~~~~~~~~~~

On Fedora Workstation, GPG keys used for signing RPMs and repositories need to be manually added to the trusted RPM database by running the command ``rpm --import <GPG_KEY>``. That command does not work on rpm-ostree distributions due to that database being in the read-only file system. Instead, all of the ``/etc/pki/rpm-gpg/RPM-GPG-KEY-*`` keys are automatically trusted. [31]

Writable File System
~~~~~~~~~~~~~~~~~~~~

Most directories in a Fedora Atomic Desktop are read-only. Some are writable to help store persistent data for user files, configuration files, and locally installed programs. Here are all of the writable paths. [38][39]

.. csv-table::
   :header: Symlink, Writable Path
   :widths: 20, 20

   /home, /var/home
   /mnt, /var/mnt
   /opt, /var/opt
   /root, /var/roothome
   /srv, /var/srv
   /tmp, /var/tmp
   /usr/local, /var/usrlocal

.. csv-table::
   :header: Persistent Mount
   :widths: 20

   /boot
   /boot/efi
   /etc
   /var

Build
~~~~~

Treefile
^^^^^^^^

A treefile is a YAML text file that contains information about how to build the rpm-ostree distribution.

Common options [16][17]:

-  arch-include (map of lists of strings) = Treefiles to include if building for a specified CPU architecture.

   -  aarch64 (list of strings) = Arm.
   -  ppc64le (list of strings) = PowerPC.
   -  s390x (list of strings) =  IBM Z.
   -  x86_64 (list of strings) = AMD or Intel.

-  automatic_version_prefix (string) = The major version of the operating system.
-  default_target (string) = The default systemd target to boot into.
-  document (boolean) = Default: true. If documentation should be installed. If set to false, RPMs will be installed with the ``nodocs`` flag to not install documentation.
-  etc-group-members (list of strings) = A list of groups to create. It is recommended to create the ``wheel`` group for ``sudo`` users.
-  exclude-packages (list of strings) = A list of recommended packages to not install.
-  include (string) = Include another treefile.
-  metadata (map of strings) = Optional metadata that will appear when running the command ``rpm-ostree compose tree --print-metadata-json``.
-  modules (map of lists) = Modular stream repositories to enable.

   -  enable (list of strings) = Repositories to enable with the format of ``<MODULE_NAME>:<MODULE_VERSION>``. The actual repository configuration file to import needs to be defined at the top-level ``repos:`` list. [24][25]

-  mutate-os-release (string) = The major version of the operating system.
-  packages (list of strings) = A list of packages to install as part of the base distribution.
-  packages-``<CPU_ARCHITECTURE>`` (list of strings) = A list of packages to install as part of the base distribution if the specified CPU architecture is being used.
-  postprocess-script (string) = A post processing script to run after building the rpm-ostree distribution.
-  ref (string) = The reference URL for where the rpm-ostree compose can be downloaded from. For example, Fedora uses the the reference ``fedora/<MAJOR_VERSION>/${basearch}/silverblue``.
-  releasever (string) = The release version to use for RPM repositories.
-  repos (list of strings) = Repositories to enable. These repositories are sourced from a ``<REPOSITORY>.repo`` file that contains a valid RPM repository. For example, one of the repositories Fedora enables is from the ``fedora-<MAJOR_VERSION>.repo`` file.
-  selinux (boolean) = Default: true. If SELinux should be enabled.

Examples:

-  Use a modular stream repository to install a package.

   .. code-block:: yaml

      ---
      packages:
        - akmkod-nvidia
        - nvidia-driver
        - nvidia-driver-cuda
      modules:
        enable:
          - nvidia-driver:latest-dkms
      repos:
        - nvidia-x86_64

-  Unofficial Fedora Silvernobara 37 [18]:

   .. code-block:: yaml

      ---
      # File name: fedora-silvernobara.yaml
      include: fedora-silverblue.yaml
      ref: fedora/37/${basearch}/silvernobora
      rojig:
        name: fedora-silvernobora
        summary: "Fedora Silverblue with Project Nobora enhancements"
        license: MIT
      repos:
        - rpmfusion-nonfree
        - rpmfusion-nonfree-updates
        - rpmfusion-free
        - rpmfusion-free-updates
        - copr:copr.fedorainfracloud.org:gloriouseggroll:nobara:ml
        - copr:copr.fedorainfracloud.org:gloriouseggroll:nobara
        - copr:copr.fedorainfracloud.org:kylegospo:gnome-vrr
      packages:
      # Gaming related
        - gamescope
        - goverlay
        - mangohud
        - protonup-qt
        - vkBasalt
        - openal-soft
        - steam
        - obs-studio-gamecapture
        - obs-studio
        - vulkan-loader
        - vulkan-headers
        - mesa-libGLU
        - libglvnd
        - libdrm
      # utilities
        - lm_sensors
        - corectrl
        - ffmpeg
        - python3-pip

-  Official Fedora Silverblue 38 [17]:

   .. code-block:: yaml

      ---
      # File name: fedora-silverblue.yaml
      include: gnome-desktop-pkgs.yaml
      ref: fedora/38/${basearch}/silverblue
      rojig:
        name: fedora-silverblue
        summary: "Fedora Silverblue base image"
        license: MIT
      packages:
        - fedora-release-silverblue
        - desktop-backgrounds-gnome
        - gnome-shell-extension-background-logo
        - pinentry-gnome3
        # Does it really still make sense to ship Qt by default if we
        # expect people to run apps in containers?
        - qgnomeplatform
        # Include evince-thumbnailer otherwise PDF thumbnails won't work in Nautilus
        # https://github.com/fedora-silverblue/issue-tracker/issues/98
        - evince-thumbnailer
        # Include evince-previewer otherwise print previews are broken in Evince
        # https://github.com/fedora-silverblue/issue-tracker/issues/122
        - evince-previewer
        # Include totem-video-thumbnailer for video thumbnailing in Nautilus
        # https://pagure.io/fedora-workstation/issue/168
        - totem-video-thumbnailer
       
      repos:
        - fedora-38
        - fedora-38-updates

   .. code-block:: ini

      # File name: fedora-38.repo
      [fedora-38]
      name=Fedora 38 $basearch
      mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-38&arch=$basearch
      enabled=1
      gpgcheck=1
      metadata_expire=1d

   .. code-block:: ini

      # File name: fedora-38-updates.repo
      [fedora-38-updates]
      name=Fedora 38 $basearch Updates
      mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f38&arch=$basearch
      enabled=1
      gpgcheck=1
      metadata_expire=1d

   .. code-block:: yaml

      ---
      # File name: gnome-desktop-pkgs.yaml
      include: fedora-common-ostree.yaml
      packages:
        - ModemManager
        - NetworkManager-adsl
        - NetworkManager-openconnect-gnome
        - NetworkManager-openvpn-gnome
        - NetworkManager-ppp
        - NetworkManager-pptp-gnome
        - NetworkManager-ssh-gnome
        - NetworkManager-vpnc-gnome
        - NetworkManager-wwan
        - adobe-source-code-pro-fonts
        - at-spi2-atk
        - at-spi2-core
        - avahi
        - dconf
        - fprintd-pam
        - gdm
        - glib-networking
        - gnome-backgrounds
        - gnome-bluetooth
        - gnome-browser-connector
        - gnome-classic-session
        - gnome-color-manager
        - gnome-control-center
        - gnome-disk-utility
        - gnome-initial-setup
        - gnome-remote-desktop
        - gnome-session-wayland-session
        - gnome-session-xsession
        - gnome-settings-daemon
        - gnome-shell
        - gnome-software
        - gnome-system-monitor
        - gnome-terminal
        - gnome-terminal-nautilus
        - gnome-themes-extra
        - gnome-user-docs
        - gnome-user-share
        - gvfs-afc
        - gvfs-afp
        - gvfs-archive
        - gvfs-fuse
        - gvfs-goa
        - gvfs-gphoto2
        - gvfs-mtp
        - gvfs-smb
        - libcanberra-gtk3
        - libproxy-duktape
        - librsvg2
        - libsane-hpaio
        - mesa-dri-drivers
        - mesa-libEGL
        - nautilus
        - orca
        - polkit
        - rygel
        - systemd-oomd-defaults
        - tracker
        - tracker-miners
        - xdg-desktop-portal
        - xdg-desktop-portal-gnome
        - xdg-desktop-portal-gtk
        - xdg-user-dirs-gtk
        - yelp

   .. code-block:: yaml

      ---
      # File name: fedora-common-ostree.yaml
      ref: fedora/38/${basearch}/ostree-base
       
      automatic_version_prefix: "38"
      mutate-os-release: "38"
       
      include: fedora-common-ostree-pkgs.yaml
       
      # See https://github.com/coreos/bootupd
      # TODO: Disabled until we use use unified-core or native container flow
      # for the main build
      # arch-include:
      #   x86_64: bootupd.yaml
      #   aarch64: bootupd.yaml
       
      packages:
        # Do not include "full" Git as it brings in Perl
        - git-core
        # Explicitely add Git docs
        - git-core-doc
        - lvm2
        - rpm-ostree
        # Required for compatibility with old bootloaders until we have bootupd
        # See https://github.com/fedora-silverblue/issue-tracker/issues/120
        - ostree-grub2
        # Container management
        - buildah
        - podman
        - skopeo
        - toolbox
        # Provides terminal tools like clear, reset, tput, and tset
        - ncurses
        # Flatpak support
        - flatpak
        - xdg-desktop-portal
        # HFS filesystem tools for Apple hardware
        # See https://github.com/projectatomic/rpm-ostree/issues/1380
        - hfsplus-tools
        # Contains default ostree remote config to be used on client's
        # system for fetching ostree update
        - fedora-repos-ostree
        # the archive repo for more reliable package layering
        # https://github.com/coreos/fedora-coreos-tracker/issues/400
        - fedora-repos-archive
       
      selinux: true
      documentation: true
      boot-location: modules
      etc-group-members:
        - wheel
      tmp-is-dir: true
       
      ignore-removed-users:
        - root
      ignore-removed-groups:
        - root
      check-passwd:
        type: file
        filename: passwd
      check-groups:
        type: file
        filename: group
       
      default_target: graphical.target
       
      packages-aarch64:
        - grub2-efi
        - efibootmgr
        - shim
      packages-ppc64le:
        - grub2
      packages-x86_64:
        - grub2-efi-ia32
        - grub2-efi-x64
        - grub2-pc
        - efibootmgr
        - shim-ia32
        - shim-x64
       
      # Make sure the following are not pulled in when Recommended by other packages
      exclude-packages:
        - PackageKit
        # We can not include openh264. See https://fedoraproject.org/wiki/OpenH264
        - gstreamer1-plugin-openh264
        - mozilla-openh264
        - openh264
       
      postprocess:
        - |
          #!/usr/bin/env bash
          set -xeuo pipefail
       
          # Work around https://bugzilla.redhat.com/show_bug.cgi?id=1265295
          # From https://github.com/coreos/fedora-coreos-config/blob/testing-devel/overlay.d/05core/usr/lib/systemd/journald.conf.d/10-coreos-persistent.conf
          install -dm0755 /usr/lib/systemd/journald.conf.d/
          echo -e "[Journal]\nStorage=persistent" > /usr/lib/systemd/journald.conf.d/10-persistent.conf
       
          # See: https://src.fedoraproject.org/rpms/glibc/pull-request/4
          # Basically that program handles deleting old shared library directories
          # mid-transaction, which never applies to rpm-ostree. This is structured as a
          # loop/glob to avoid hardcoding (or trying to match) the architecture.
          for x in /usr/sbin/glibc_post_upgrade.*; do
              if test -f ${x}; then
                  ln -srf /usr/bin/true ${x}
              fi
          done
       
          # Remove loader directory causing issues in Anaconda in unified core mode
          # Will be obsolete once we start using bootupd
          rm -rf /usr/lib/ostree-boot/loader
      postprocess-script: "postprocess.sh"

   ::

      # File name: group
      root:x:0:
      bin:x:1:
      daemon:x:2:
      sys:x:3:
      adm:x:4:
      tty:x:5:
      disk:x:6:
      lp:x:7:
      mem:x:8:
      kmem:x:9:
      wheel:x:10:
      cdrom:x:11:
      mail:x:12:
      man:x:15:
      dialout:x:18:
      floppy:x:19:
      games:x:20:
      tape:x:33:
      video:x:39:
      ftp:x:50:
      lock:x:54:
      audio:x:63:
      nobody:x:99:
      users:x:100:
      utmp:x:22:
      utempter:x:35:
      ssh_keys:x:999:
      systemd-journal:x:190:
      dbus:x:81:
      polkitd:x:998:
      etcd:x:997:
      dip:x:40:
      cgred:x:996:
      tss:x:59:
      avahi-autoipd:x:170:
      rpc:x:32:
      sssd:x:993:
      dockerroot:x:986:
      rpcuser:x:29:
      nfsnobody:x:65534:
      kube:x:994:
      sshd:x:74:
      chrony:x:992:
      tcpdump:x:72:
      input:x:104:
      systemd-timesync:x:991:
      systemd-network:x:990:
      systemd-resolve:x:989:
      systemd-bus-proxy:x:988:
      cockpit-ws:x:987:

   ::

      # File name: passwd
      root:x:0:0:root:/root:/bin/bash
      bin:x:1:1:bin:/bin:/usr/sbin/nologin
      daemon:x:2:2:daemon:/sbin:/usr/sbin/nologin
      adm:x:3:4:adm:/var/adm:/usr/sbin/nologin
      lp:x:4:7:lp:/var/spool/lpd:/usr/sbin/nologin
      sync:x:5:0:sync:/sbin:/bin/sync
      shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
      halt:x:7:0:halt:/sbin:/sbin/halt
      mail:x:8:12:mail:/var/spool/mail:/usr/sbin/nologin
      operator:x:11:0:operator:/root:/usr/sbin/nologin
      games:x:12:100:games:/usr/games:/usr/sbin/nologin
      ftp:x:14:50:FTP User:/var/ftp:/usr/sbin/nologin
      nobody:x:99:99:Nobody:/:/usr/sbin/nologin
      dbus:x:81:81:System message bus:/:/usr/sbin/nologin
      polkitd:x:999:998:User for polkitd:/:/usr/sbin/nologin
      etcd:x:998:997:etcd user:/var/lib/etcd:/usr/sbin/nologin
      tss:x:59:59:Account used by the trousers package to sandbox the tcsd daemon:/dev/null:/usr/sbin/nologin
      avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/usr/sbin/nologin
      rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/usr/sbin/nologin
      sssd:x:995:993:User for sssd:/:/usr/sbin/nologin
      dockerroot:x:997:986:Docker User:/var/lib/docker:/usr/sbin/nologin
      rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/usr/sbin/nologin
      nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/usr/sbin/nologin
      kube:x:996:994:Kubernetes user:/:/usr/sbin/nologin
      sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/usr/sbin/nologin
      chrony:x:994:992::/var/lib/chrony:/usr/sbin/nologin
      tcpdump:x:72:72::/:/usr/sbin/nologin
      systemd-timesync:x:993:991:systemd Time Synchronization:/:/sbin/nologin
      systemd-network:x:991:990:systemd Network Management:/:/sbin/nologin
      systemd-resolve:x:990:989:systemd Resolver:/:/sbin/nologin
      systemd-bus-proxy:x:989:988:systemd Bus Proxy:/:/sbin/nologin
      cockpit-ws:x:988:987:User for cockpit-ws:/:/sbin/nologin

   .. code-block:: yaml

      ---
      # File name: fedora-common-ostree-pkgs.yaml
      packages:
        - NetworkManager
        - NetworkManager-bluetooth
        - NetworkManager-config-connectivity-fedora
        - NetworkManager-wifi
        - NetworkManager-wwan
        - abattis-cantarell-vf-fonts
        - acl
        - adwaita-qt5
        - alsa-ucm
        - alsa-utils
        - amd-gpu-firmware
        - atmel-firmware
        - attr
        - audit
        - b43-fwcutter
        - b43-openfwwf
        - basesystem
        - bash
        - bash-completion
        - bc
        - bind-utils
        - bluez-cups
        - btrfs-progs
        - bzip2
        - chrony
        - cifs-utils
        - colord
        - compsize
        - coreutils
        - cpio
        - cryptsetup
        - cups
        - cups-filters
        - curl
        - cyrus-sasl-plain
        - default-editor
        - dhcp-client
        - dnsmasq
        - e2fsprogs
        - ethtool
        - exfatprogs
        - fedora-bookmarks
        - fedora-chromium-config
        - fedora-flathub-remote
        - fedora-repos-modular
        - fedora-workstation-backgrounds
        - fedora-workstation-repositories
        - file
        - filesystem
        - firefox
        - firewalld
        - fpaste
        - fros-gnome
        - fwupd
        - gamemode
        - glibc
        - glibc-all-langpacks
        - glx-utils
        - gnupg2
        - google-noto-emoji-color-fonts
        - google-noto-naskh-arabic-vf-fonts
        - google-noto-sans-arabic-vf-fonts
        - google-noto-sans-armenian-vf-fonts
        - google-noto-sans-canadian-aboriginal-vf-fonts
        - google-noto-sans-cherokee-vf-fonts
        - google-noto-sans-cjk-ttc-fonts
        - google-noto-sans-ethiopic-vf-fonts
        - google-noto-sans-georgian-vf-fonts
        - google-noto-sans-gurmukhi-vf-fonts
        - google-noto-sans-hebrew-vf-fonts
        - google-noto-sans-lao-vf-fonts
        - google-noto-sans-math-fonts
        - google-noto-sans-mono-vf-fonts
        - google-noto-sans-sinhala-vf-fonts
        - google-noto-sans-thaana-vf-fonts
        - google-noto-sans-vf-fonts
        - google-noto-serif-vf-fonts
        - gstreamer1-plugins-bad-free
        - gstreamer1-plugins-good
        - gstreamer1-plugins-ugly-free
        - gutenprint
        - gutenprint-cups
        - hostname
        - hplip
        - hunspell
        - ibus-anthy
        - ibus-gtk3
        - ibus-gtk4
        - ibus-hangul
        - ibus-libpinyin
        - ibus-libzhuyin
        - ibus-m17n
        - ibus-typing-booster
        - intel-gpu-firmware
        - iproute
        - iptables-nft
        - iptstate
        - iputils
        - iwl100-firmware
        - iwl1000-firmware
        - iwl105-firmware
        - iwl135-firmware
        - iwl2000-firmware
        - iwl2030-firmware
        - iwl3160-firmware
        - iwl3945-firmware
        - iwl4965-firmware
        - iwl5000-firmware
        - iwl5150-firmware
        - iwl6000-firmware
        - iwl6000g2a-firmware
        - iwl6000g2b-firmware
        - iwl6050-firmware
        - iwl7260-firmware
        - iwlax2xx-firmware
        - jomolhari-fonts
        - kbd
        - kernel
        - kernel-modules-extra
        - khmer-os-system-fonts
        - less
        - liberation-mono-fonts
        - liberation-sans-fonts
        - liberation-serif-fonts
        - libertas-usb8388-firmware
        - libglvnd-gles
        - linux-firmware
        - logrotate
        - lohit-assamese-fonts
        - lohit-bengali-fonts
        - lohit-devanagari-fonts
        - lohit-gujarati-fonts
        - lohit-kannada-fonts
        - lohit-marathi-fonts
        - lohit-odia-fonts
        - lohit-tamil-fonts
        - lohit-telugu-fonts
        - lrzsz
        - lsof
        - man-db
        - man-pages
        - mdadm
        - mesa-dri-drivers
        - mesa-vulkan-drivers
        - mpage
        - mtr
        - nfs-utils
        - nss-altfiles
        - nss-mdns
        - ntfs-3g
        - ntfsprogs
        - nvidia-gpu-firmware
        - opensc
        - openssh-clients
        - openssh-server
        - paktype-naskh-basic-fonts
        - pam_afs_session
        - paps
        - passwd
        - passwdqc
        - pciutils
        - pinfo
        - pipewire-alsa
        - pipewire-gstreamer
        - pipewire-pulseaudio
        - pipewire-utils
        - plocate
        - plymouth
        - plymouth-system-theme
        - policycoreutils
        - policycoreutils-python-utils
        - procps-ng
        - psmisc
        - qemu-guest-agent
        - qgnomeplatform-qt5
        - qt5-qtbase
        - qt5-qtbase-gui
        - qt5-qtdeclarative
        - qt5-qtxmlpatterns
        - quota
        - realmd
        - rit-meera-new-fonts
        - rootfiles
        - rpm
        - rsync
        - samba-client
        - selinux-policy-targeted
        - setup
        - shadow-utils
        - sil-mingzat-fonts
        - sil-nuosu-fonts
        - sil-padauk-fonts
        - sos
        - spice-vdagent
        - spice-webdavd
        - sssd
        - sssd-common
        - sssd-kcm
        - stix-fonts
        - sudo
        - system-config-printer-udev
        - systemd
        - systemd-oomd-defaults
        - systemd-resolved
        - systemd-udev
        - tar
        - thai-scalable-waree-fonts
        - time
        - toolbox
        - tree
        - unzip
        - uresourced
        - usb_modeswitch
        - usbutils
        - util-linux
        - vazirmatn-vf-fonts
        - vim-minimal
        - wget
        - which
        - whois
        - wireplumber
        - words
        - wpa_supplicant
        - xorg-x11-drv-amdgpu
        - xorg-x11-drv-ati
        - xorg-x11-drv-evdev
        - xorg-x11-drv-fbdev
        - xorg-x11-drv-libinput
        - xorg-x11-drv-nouveau
        - xorg-x11-drv-qxl
        - xorg-x11-drv-wacom
        - xorg-x11-server-Xorg
        - xorg-x11-xauth
        - xorg-x11-xinit
        - zd1211-firmware
        - zip
        - zram-generator-defaults
      packages-x86_64:
        - alsa-sof-firmware
        - hyperv-daemons
        - mcelog
        - microcode_ctl
        - open-vm-tools-desktop
        - thermald
        - virtualbox-guest-additions
        - xorg-x11-drv-intel
        - xorg-x11-drv-openchrome
        - xorg-x11-drv-vesa
        - xorg-x11-drv-vmware
      packages-aarch64:
        - hyperv-daemons
        - open-vm-tools-desktop
        - xorg-x11-drv-armsoc
      packages-ppc64le:
        - lsvpd
        - powerpc-utils

   .. code-block:: sh

      #!/usr/bin/env bash
      # File name: postprocess.sh
      set -xeuo pipefail
      
      # Setup unit & script for readonly sysroot migration:
      # - https://fedoraproject.org/wiki/Changes/Silverblue_Kinoite_readonly_sysroot
      # - https://bugzilla.redhat.com/show_bug.cgi?id=2060976
      
      cat > /usr/lib/systemd/system/fedora-silverblue-readonly-sysroot.service <<'EOF'
      [Unit]
      Description=Fedora Silverblue Read-Only Sysroot Migration
      Documentation=https://fedoraproject.org/wiki/Changes/Silverblue_Kinoite_readonly_sysroot
      ConditionPathExists=!/var/lib/.fedora_silverblue_readonly_sysroot
      RequiresMountsFor=/sysroot /boot
      ConditionPathIsReadWrite=/sysroot
      
      [Service]
      Type=oneshot
      ExecStart=/usr/libexec/fedora-silverblue-readonly-sysroot
      RemainAfterExit=yes
      
      [Install]
      WantedBy=multi-user.target
      EOF
      
      chmod 644 /usr/lib/systemd/system/fedora-silverblue-readonly-sysroot.service
      
      cat > /usr/libexec/fedora-silverblue-readonly-sysroot <<'EOF'
      #!/bin/bash
      # Update an existing system to use a read only sysroot
      # See https://fedoraproject.org/wiki/Changes/Silverblue_Kinoite_readonly_sysroot
      # and https://bugzilla.redhat.com/show_bug.cgi?id=2060976
      
      set -euo pipefail
      
      main() {
          # Used to condition execution of this unit at the systemd level
          local -r stamp_file="/var/lib/.fedora_silverblue_readonly_sysroot"
      
          if [[ -f "${stamp_file}" ]]; then
              exit 0
          fi
      
          local -r ostree_sysroot_readonly="$(ostree config --repo=/sysroot/ostree/repo get "sysroot.readonly" &> /dev/null || echo "false")"
          if [[ "${ostree_sysroot_readonly}" == "true" ]]; then
              # Nothing to do
              touch "${stamp_file}"
              exit 0
          fi
      
          local -r boot_entries="$(ls -A /boot/loader/entries/ | wc -l)"
      
          # Ensure that we can read BLS entries to avoid touching systems where /boot
          # is not mounted
          if [[ "${boot_entries}" -eq 0 ]]; then
              echo "No BLS entry found: Maybe /boot is not mounted?" 1>&2
              echo "This is unexpected thus no migration will be performed" 1>&2
              touch "${stamp_file}"
              exit 0
          fi
      
          # Check if any existing deployment is still missing the rw karg
          local rw_kargs_found=0
          local count=0
          for f in "/boot/loader/entries/"*; do
              count="$(grep -c "^options .* rw" "${f}" || true)"
              if [[ "${count}" -ge 1 ]]; then
                  rw_kargs_found=$((rw_kargs_found + 1))
              fi
          done
      
          # Some deployments are still missing the rw karg. Let's try to update them
          if [[ "${boot_entries}" -ne "${rw_kargs_found}" ]]; then
              ostree admin kargs edit-in-place --append-if-missing=rw || \
                  echo "Failed to edit kargs in place with ostree" 1>&2
          fi
      
          # Re-check if any existing deployment is still missing the rw karg
          rw_kargs_found=0
          count=0
          for f in "/boot/loader/entries/"*; do
              count="$(grep -c "^options .* rw" "${f}" || true)"
              if [[ "${count}" -ge 1 ]]; then
                  rw_kargs_found=$((rw_kargs_found + 1))
              fi
          done
          unset count
      
          # If all deployments are good, then we can set the sysroot.readonly option
          # in the ostree repo config
          if [[ "${boot_entries}" -eq "${rw_kargs_found}" ]]; then
              echo "Setting up the sysroot.readonly option in the ostree repo config"
              ostree config --repo=/sysroot/ostree/repo set "sysroot.readonly" "true"
              touch "${stamp_file}"
              exit 0
          fi
      
          # If anything else before failed, we will retry on next boot
          echo "Will retry next boot" 1>&2
          exit 0
      }
      
      main "${@}"
      EOF
      
      chmod 755 /usr/libexec/fedora-silverblue-readonly-sysroot
      
      # Enable the corresponding unit
      systemctl enable fedora-silverblue-readonly-sysroot.service

rpm-ostree compose
''''''''''''''''''

Once the treefiles have been created, the rpm-ostree distribution can be built. It is recommended to use either Fedora Silverblue or Fedora Workstation as the host operating system for the build since they provide the required dependencies. The ``rpm-ostree`` command has to be ran with elevated privileges or else it will not work properly.

-  Create a repository structure to host composed builds.

   .. code-block:: sh

      $ sudo ostree --repo=<REPOSITORY_DIRECTORY> init

-  Build the rpm-ostree distribution.

   .. code-block:: sh

      $ sudo rpm-ostree compose tree --unified-core --repo=<REPOSITORY_DIRECTORY> --cachedir=<CACHE_DIRECTORY> fedora-silverblue.yaml

-  Optionally, at a later date, check to see if there are updates available to the packages by running the command again without the cache.

   .. code-block:: sh

      $ sudo rpm-ostree compose tree --unified-core --repo=<REPOSITORY_DIRECTORY> --force-nocache fedora-silverblue.yaml

-  Update the repository with metadata about the new build.

   .. code-block:: sh

      $ sudo ostree summary --repo=<REPOSITORY_DIRECTORY> --update

-  The top-level directory that contains the repository directory needs to be hosted via a HTTP server.

-  If using an existing rpm-ostree distribuiton, it can switch to using the new build. It is recommended to pin the existing installation first. If SELinux will be enabled in the build, it also has to be enabled on the host.

   .. code-block:: sh

      $ sudo ostree remote add <NEW_REMOTE_NAME> http://<IP_ADDRESS>/repo --no-gpg-verify
      $ sudo ostree admin pin 0
      $ sudo ostree remote refs <NEW_REMOTE_NAME>
      $ sudo rpm-ostree rebase <NEW_REMOTE_NAME>:fedora/38/x86_64/silverblue

[17][18]

Container
^^^^^^^^^

A Containerfile can be used to create an Open Container Initiative (OCI) image for use as the root file system.

::

   FROM <CONTAINER_REGISTRY>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_NAME>:<CONTAINER_TAG>

The base container image to start with needs to have ``rpm-ostree`` installed and configured. Either use an existing image or use a Treefile to build a new base image.

bootc images should only be used when using `bootc <https://github.com/containers/bootc>`__ for deployment instead of traditional OSTree deployments. Otherwise, there are slight differences that can cause issues. bootc mounts the root file system as ``rw`` (not ``ro``). [48] The root file system ``/`` is also shown as being an OverlayFS mount (instead of the root partition) with a small amount of storage space. That leads to incorrect reporting of available free space.

**Existing Images**

Minimal images [45]:

-  CentOS Stream = quay.io/centos-bootc/centos-bootc:stream9
-  Fedora = quay.io/fedora/fedora-bootc:40
-  Fedora CoreOS (following the latest stable Fedora Atomic Desktop version) = quay.io/fedora/fedora-coreos:testing

Images with desktop enviornments:

-  Fedora Atomic Desktop with GNOME = quay.io/fedora/fedora-silverblue
-  Fedora Atomic Desktop with KDE Plasma = quay.io/fedora/fedora-kinoite

In the Containerfile, set one of those images to be the ``FROM`` value. It is recommended to end each ``RUN`` command with ``&& ostree container commit``. DNF and RPM commands can be re-enabled by using ``RUN rpm-ostree cliwrap install-to-root /`` which will translate those to rpm-ostree commands. Real-world examples of how to customize these containers with rpm-ostree can be found `here <https://github.com/coreos/layering-examples>`__.

Some ``rpm-ostree`` arguments such as ``kargs`` do not work in a Containerfile. For that instance, it is recommended to use a `Kickstart file <../virtualization/virtual_machines.html#kickstart-file>`__ to provide defaults kernel boot arguments by using ``bootloader --location=mbr --boot-drive=vda --append="<KEY>=<VALUE>"``. [49]

**Treefile**

Treefiles for Fedora-based distributions are available in these locations:

-  bootc images:

   -  CentOS Stream = https://gitlab.com/redhat/centos-stream/containers/bootc
   -  Fedora = https://gitlab.com/fedora/bootc/base-images

-  Fedora Atomic Desktop images = https://pagure.io/workstation-ostree-config
-  Fedora CoreOS images = https://github.com/coreos/fedora-coreos-config/tree/testing-devel/manifests

Build a container image archive.

-  First build:

   .. code-block:: sh

      $ rpm-ostree compose image --initialize --format=ociarchive <TREEFILE>.yaml <CONTAINER_NAME>.ociarchive

-  Next builds:

   .. code-block:: sh

      $ rpm-ostree compose image --initialize-mode=if-not-exists --format=ociarchive <TREEFILE>.yaml <CONTAINER_NAME>.ociarchive

Build a container image and then push it to a container registry. [46]

-  First build:

   .. code-block:: sh

      $ rpm-ostree compose image --initialize --format=registry <TREEFILE>.yaml <CONTAINER_REGISTRY>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_NAME>:<CONTAINER_TAG>

-  Next builds:

   .. code-block:: sh

      $ rpm-ostree compose image --initialize-mode=if-not-exists --format=registry <TREEFILE>.yaml <CONTAINER_REGISTRY>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_NAME>:<CONTAINER_TAG>

It is possible to convert an ostree repository to a container image [46] but not the other way around. [47]

.. code-block:: sh

   $ ostree container encapsulate --repo=<OSTREE_REPOSITORY_PATH> <OSTREE_REFERENCE> docker://<CONTAINER_REGISTRY>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_NAME>:<CONTAINER_IMAGE>

**Authentication**

Three files are supported by rpm-ostree for authentication to a private container registry [46][53]:

-  Temporary

   -  /run/ostree/auth.json

-  Permanent

   -  /etc/ostree/auth.json
   -  /usr/lib/ostree/auth.json

Create this file manually by running:

.. code-block:: sh

   $ sudo podman login --authfile /run/ostree/auth.json <CONTAINER_REGISTRY>

**Kickstart**

With a container image, it can be used with Kickstart to automatically install the operating system.

::

   ostreecontainer --no-signature-verification --url <CONTAINER_REGISTRY>/<CONTAINER_REGISTRY_PROJECT>/<CONTAINER_NAME>:<CONTAINER_IMAGE>

For authenticating to a private repository, create the ``auth.json`` file as a ``%pre`` step. Use ``/etc/ostree/auth.json`` to permanently store the login credentials or ``/run/ostree/auth.json`` to temporarily store the login credentials during the installation.

User Management
~~~~~~~~~~~~~~~

Fedora Atomic Desktop uses ``nss-altfiles`` to manage users and groups. Configurations are specified in ``/usr/lib/`` instead of ``/etc/``. Traditional commands such as ``useradd`` and ``groupadd`` do not work.

Two files are managed by ``nss-altfiles``:

-  ``/etc/passwd``

   -  ``/usr/lib/passwd``

-  ``/etc/group``

   -  ``/usr/lib/group``

Sometimes these files can drift from each other. If a new package was installed that adds a user and/or group, they need to be manually added to the relevant ``/etc/[group|passwd]`` configuration file. [50][51][52]

.. code-block:: sh

   $ grep <USER> /usr/lib/passwd | sudo tee -a /etc/passwd

.. code-block:: sh

   $ grep <GROUP> /usr/lib/group | sudo tee -a /etc/group

The full list of UIDs and GIDs used by Fedora can be found `here <https://pagure.io/setup/blob/master/f/uidgid>`__. Avoid creating any new users or groups with these IDs.

When using ``rpm-ostree compose``, this is the default configuration used by Fedora to manage users and groups:

.. code-block:: yaml

   ignore-removed-users:
     - root
   ignore-removed-groups:
     - root
   check-passwd:
     type: file
     filename: passwd
   check-groups:
     type: file
     filename: group

It requires a ``passwd`` and ``group`` file to be fully configured and then it will copy them to ``/usr/lib/``.

Reset
~~~~~

rpm-ostree allows resetting the packages to the default installed ones.

Remove layered packages:

.. code-block:: sh

   $ sudo rpm-ostree uninstall --all

Remove overridden packages:

.. code-block:: sh

   $ sudo rpm-ostree override reset --all

Reset all packages:

.. code-block:: sh

   $ sudo rpm-ostree reset

[32][33]

Reset the persistent configuration, database files, and users [34]:

.. code-block:: sh

   $ sudo rm -r -f /var/*
   $ sudo rsync -rlv --delete --exclude fstab /usr/etc/ /etc/

Upgrades
~~~~~~~~

Introduction
^^^^^^^^^^^^

Unlike Fedora Workstation [19], rpm-ostree distributions do not officially support skip upgrades of going from X to X+2 because it is untested.

-  Minor update of a rpm-ostree distribution:

   .. code-block:: sh

      $ sudo rpm-ostree update

-  Minor update with packages in testing [41]:

   .. code-block:: sh

      $ sudo rpm-ostree rebase fedora:fedora/<FEDORA_MAJOR_VERSION>/x86_64/testing/silverblue

-  Major upgrade of Fedora Silverblue [20]:

   .. code-block:: sh

      $ sudo rpm-ostree rebase fedora:fedora/<FEDORA_MAJOR_VERSION>/x86_64/silverblue

After an upgrade, clear the local cache. [40]

.. code-block:: sh

   $ sudo rpm-ostree cleanup --base --repomd

rpm-ostree distributions have issues upgrading when there are third-party RPMs installed that are versioned for a specific version of Fedora. This can be worked around by doing an update that will also uninstall the old package and then re-install the new package.

-  Minor update of Fedora [21][22]:

   .. code-block:: sh

      $ sudo rpm-ostree update \
          --uninstall rpmfusion-free-release --uninstall rpmfusion-nonfree-release --uninstall google-chrome-stable \
          --install rpmfusion-free-release --install rpmfusion-nonfree-release --install google-chrome-stable

-  Major upgrade of Fedora Silverblue [23]:

   .. code-block:: sh

      $ sudo rpm-ostree rebase fedora:fedora/<FEDORA_MAJOR_VERSION_NEW>/x86_64/silverblue \
         --uninstall rpmfusion-free-release-<FEDORA_MAJOR_VERSION_ORIGINAL>-1.noarch \
         --uninstall rpmfusion-nonfree-release-<FEDORA_MAJOR_VERSION_ORIGINAL>-1.noarch \
         --install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-<FEDORA_MAJOR_VERSION_NEW>.noarch.rpm \
         --install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-<FEDORA_MAJOR_VERSION_NEW>.noarch.rpm

ostree Remotes
^^^^^^^^^^^^^^

All remote update servers have their configuration files stored at ``/etc/ostree/remotes.d/<REMOTE>.conf``. Here are the contents of the default Fedora remote configuration file ``fedora.conf``:

.. code-block:: ini

   [remote "fedora"]
   url=https://ostree.fedoraproject.org
   gpg-verify=true
   gpgkeypath=/etc/pki/rpm-gpg/
   contenturl=mirrorlist=https://ostree.fedoraproject.org/mirrorlist

A custom remote server can be added by either using the CLI or manually adding a configuration file.

-  CLI [28]:

   .. code-block:: sh

      $ sudo ostree remote add --set=gpg-verify=false <REMOTE_NAME> '<REMOTE_REPO_URL>'

-  Configuration file:

   .. code-block:: ini

      [remote "<REMOTE_NAME>"]
      url=<REMOTE_REPO_URL>
      gpg-verify=false

rpm-ostree Developer
~~~~~~~~~~~~~~~~~~~~

Build the latest ``rpm-ostree`` RPMs for testing purposes.

.. code-block:: sh

   $ git clone https://github.com/coreos/rpm-ostree.git
   $ cd ./rpm-ostree/packaging/
   $ sudo dnf install dnf-plugins-core rpm-build
   $ sudo dnf builddep rpm-ostree.spec
   $ make -f Makefile.dist-packaging rpm

Install the ``rpm-ostree`` and ``rpm-ostree-libs`` RPMs.

-  Fedora Workstation:

   .. code-block:: sh

      $ sudo dnf install ./x86_64/rpm-ostree-<VERSION>.rpm ./x86_64/rpm-ostree-libs-<VERSION>.rpm

-  Fedora Atomic Desktop:

   .. code-block:: sh

      $ sudo rpm-ostree override replace ./x86_64/rpm-ostree-<VERSION>.rpm ./x86_64/rpm-ostree-libs-<VERSION>.rpm

bootc
-----

Introduction
~~~~~~~~~~~~

bootc is the successor to rpm-ostree and uses many of the same technologies and codebase. The biggest change is that package management is now handled by the native package manager for the Linux distribution. It is recommended to use a Containerfile to customize the operating system. A list of operating systems using bootc can be found `here <https://github.com/containers/bootc/blob/main/ADOPTERS.md>`__.

.. csv-table::
   :header: COMPARISON, bootc, rpm-ostree
   :widths: 20, 20, 20

   Distro-agnostic, Yes\*, No
   Base image type, OCI container image, OSTree
   OSTree extensions, Internal (merged), External
   Read-only root, Yes (composefs forces read-only on boot), Partial (``ostree admin unlock --hotfix`` allows persistent changes)
   Temporary writable root (``bootc usroverlay``), Yes, Yes (``ostree admin unlock``)
   Persistent mounts, ``/etc`` and ``/var``, ``/etc`` and ``/var``
   Rollback, Yes (``bootc rollback``), Yes (``rpm-ostree rollback``)
   Kernel boot arguments, ``bootc install --karg``, ``rpm-ostree kargs``
   User management, nss-altfiles, nss-altfiles
   Package layering, Containerfile, ``rpm-ostree install``
   Efficient updates, No (requires `zstd:chunked <https://github.com/containers/bootc/issues/509>`__ support), Yes

\*bootc will eventually support more Linux distributions besides the Fedora family. It currently has dependencies on the following that will eventually be dropped so that any Linux distribution can be used:

-  bootupd (GRUB and RPM)
-  OCI container image built using OSTreefiles

    -  No longer required as of `bootc 1.1.3 <https://github.com/containers/bootc/releases/tag/v1.1.3>`__.

Verify if a system is using ``bootc``. The output should be similar to this [54]:

.. code-block:: sh

    $ sudo bootc status --format=json | jq -r .spec.image
    {
      "image": "<IMAGE>",
      "transport": "registry",
      "signature": "containerPolicy"
    }

Otherwise, non-bootc systems will show:

.. code-block:: sh

   $ sudo bootc status
   System is not deployed via bootc.

Package Layering
~~~~~~~~~~~~~~~~~

bootc requires a Containerfile to make customizations such as installing new packages. It only manages container updates via an OCI container image and does not have any deep package manager integration. In the future, the DNF 5 client will be updated to support package layering with bootc. A prototype implementation can be found `here <https://github.com/ericcurtin/dnf-bootc>`__. It creates a Containerfile and appends package management operations to it. [55][56]

``rpm-ostree install`` technically works with ``bootc`` but it actually prevents system upgrades from working. It is recommended to use a Containerfile instead. [57]

Copy the container image used by bootc for the deployment into the local Podman container images. Then it can be used to create a custom local image. [58]

.. code-block:: sh

   $ sudo bootc image copy-to-storage

Verify that the image was copied.

.. code-block:: sh

   $ sudo podman images | grep "localhost/bootc"

Create a ``Containerfile``. Use the new ``localhost/bootc`` image to make customizations. It is best practice to clean cached files from the package manager if it is used. Finally, verify that the container is ``bootc`` compatible by running a lint check. [59]

::

   FROM localhost/bootc
   RUN dnf -y install <PACKAGE> && dnf clean all
   RUN bootc container lint

Build the container image and provide it any tag name.

.. code-block:: sh

   $ sudo podman build --tag <TAG> .

Update the file system using the local Podman image. Then reboot for the changes to take affect. [58]

.. code-block:: sh

   $ sudo bootc switch --transport containers-storage localhost/<TAG>

bootc Image Creation
~~~~~~~~~~~~~~~~~~~~

bootc Image Build
^^^^^^^^^^^^^^^^^

Support operating systems for ``bootc-image-builder`` can be found `here <https://github.com/osbuild/bootc-image-builder/tree/main/bib/data/defs>`__.

Install and configure ``podman-machine`` first.

.. code-block:: sh

   $ sudo dnf install podman-machine
   $ podman machine init --rootful --now
   $ podman machine start

Create the required output directory.

.. code-block:: sh

   $ mkdir output

Create the configuration. At a minimum, a user should be configured.

.. code-block:: sh

   $ ${EDITOR} config.toml
   [[customizations.user]]
   name = "<USER_NAME>"
   password = "<<USER_PASSWORD>"
   key = "<SSH_KEY_PUBLIC>"
   groups = ["wheel"]

Build the image. If no ``--type`` is provided, then ``qcow2`` is used by default. [60]

.. code-block:: sh

   $ export BOOTC_IMAGE=quay.io/fedora/fedora-silverblue:41
   $ sudo -E podman pull ${BOOTC_IMAGE}
   $ sudo podman run \
       --rm \
       -it \
       --privileged \
       --pull=newer \
       --security-opt label=type:unconfined_t \
       -v ./config.toml:/config.toml:ro \
       -v ./output:/output \
       -v /var/lib/containers/storage:/var/lib/containers/storage \
       quay.io/centos-bootc/bootc-image-builder:latest \
       --type raw \
       --local \
       ${BOOTC_IMAGE}

Detailed information about the build is be saved to ``output/manifest-raw.json``.

The image file will be stored in one of these locations based on the ``--type`` used to build it.

.. csv-table::
   :header: Path, Type
   :widths: 20, 20

   output/bootiso/disk.iso, ``anaconda-iso``
   output/gce/image.tar.gz, ``gce``
   output/image/disk.raw, ``ami`` or ``raw``
   output/qcow2/disk.qcow2, ``qcow2``
   output/vmdk/disk.vmdk, ``vmdk``
   output/vpc/disk.vhd, ``vhd``

Troubleshooting
---------------

Errors
~~~~~~

Error when trying to install a package with ``rpm-ostree``.

-  Syntax:

   ::

      - cannot install both <NEW_PACKAGE> from <RPM_REPOSITORY> and <OLD_PACKAGE> from @System

-  Example:

   ::

      - cannot install both mesa-filesystem-24.0.9-1.fc40.i686 from updates and mesa-filesystem-24.0.5-1.fc40.i686 from @System

Solution:

-  Upgrade the package. This returns a non-zero exit code so in a Containerfile it needs to be set to always return true.

   .. code-block:: sh

      $ sudo rpm-ostree override replace --experimental --from repo=<RPM_REPOSITORY> <PACKAGE>

   ::

      RUN rpm-ostree override replace --experimental --from repo=<RPM_REPOSITORY> <PACKAGE> || true

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/fedora.rst>`__
-  `< 2023.04.01 <https://github.com/LukeShortCloud/rootpages/commits/main/src/linux_distributions/fedora.rst>`__

Bibliography
------------

1. "Red Hat Enterprise Linux Life Cycle." Red Hat Customer Portal. Accessed July 14, 2022. https://access.redhat.com/support/policy/updates/errata
2. "The AlmaLinux OS Foundation." AlmaLinux Wiki. Accessed July 14, 2022. https://wiki.almalinux.org/Transparency.html#we-strive-to-be-transparent
3. "No-cost Red Hat Enterprise Linux Individual Developer Subscription: FAQs." Red Hat Developer. February 5, 2021. Accessed July 14, 2022. https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux
4. "Get Started With the Btrfs File System on Oracle Linux." Oracle Help Center. Accessed July 14, 2022. https://docs.oracle.com/en/learn/btrfs-ol8/index.html
5. "Fedora 38 To Get Rid Of Its Flathub Filtering, Allowing Many More Apps On Fedora." Phoronix. February 6, 2023. Accessed February 6, 2023. https://www.phoronix.com/news/Fedora-38-Unfiltered-Flathub
6. "What "filter" was in place for flathub?" Reddit r/Fedora. May 1, 2022. Accessed February 6, 2023. https://www.reddit.com/r/Fedora/comments/rv43uv/what_filter_was_in_place_for_flathub/
7. "Cannot open access to console, the root account is locked in emergency mode (dracut emergency shell)." Ask Fedora. November 21, 2021. Accessed February 18, 2023. https://ask.fedoraproject.org/t/cannot-open-access-to-console-the-root-account-is-locked-in-emergency-mode-dracut-emergency-shell/2010
8. "How to disable Gnome Software autostart." Reddit r/gnome. October 22, 2022. Accessed February 18, 2023. https://www.reddit.com/r/gnome/comments/gn8rs4/how_to_disable_gnome_software_autostart/
9. "How can I disable automatic updates CHECKING?" Reddit r/Fedora. January 26, 2023. Accessed February 18, 2023. https://www.reddit.com/r/Fedora/comments/p10a5o/how_can_i_disable_automatic_updates_checking/
10. "How to enable automatic system updates in Fedora Silverblue." barnix. May 26, 2020. Accessed February 18, 2023. https://barnix.io/how-to-enable-automatic-update-staging-in-fedora-silverblue/
11. "Installing Fedora Silverblue." Fedora Documentation. September 3, 2022. Accessed February 18, 2023. https://docs.fedoraproject.org/en-US/fedora-silverblue/installation/#known-limitations
12. "Installing Silverblue, side-by-side." Fedora People asamalik. April 13, 2019. Accessed February 18, 2023. https://asamalik.fedorapeople.org/fedora-docs-translations/en-US/fedora-silverblue/installation-dual-boot/
13. "Fedora Kinoite: A fascinating take on the operating system." TechRepublic. December 22, 2021. Accessed February 28, 2023. https://www.techrepublic.com/article/fedora-kinoite-a-fascinating-take-on-the-operating-system/
14. "Changes/Fedora Sway Spin." Fedora Project Wiki. December 19, 2022. Accessed February 28, 2023. https://fedoraproject.org/wiki/Changes/Fedora_Sway_Spin
15. "Fedora Atomic Host will now become Fedora Core OS." Destacados. Accessed February 28, 2023. https://blog.desdelinux.net/en/fedora-atomic-host-ahora-pasara-a-ser-fedora-core-os/
16. "Treefile reference." November 15, 2022. Accessed February 28, 2023. https://coreos.github.io/rpm-ostree/treefile/
17. "workstation-ostree-config." Fedora Pagure. February 16, 2023. Accessed February 28, 2023. https://pagure.io/workstation-ostree-config/tree/f38
18. "VinnyVynce/silvernobara." GitHub. November 28, 2022. Accessed February 28, 2023. https://github.com/VinnyVynce/silvernobara/tree/f37
19. "Upgrading Fedora Using DNF System Plugin." Fedora Documentation. May 4, 2023. Accessed August 17, 2023. https://docs.fedoraproject.org/en-US/quick-docs/dnf-system-upgrade/#sect-how-many-releases-can-i-upgrade-across-at-once
20. "Updates, Upgrades & Rollbacks." Fedora Documentation. August 17, 2023. Accessed August 17, 2023. https://docs.fedoraproject.org/en-US/fedora-silverblue/updates-upgrades-rollbacks/
21. "How does Silverblue handle installation and updating of local rpm files?" Reddit r/Fedora. December 11, 2022. Accessed August 17, 2023. https://www.reddit.com/r/Fedora/comments/zj024l/how_does_silverblue_handle_installation_and/
22. "Layered rpms do not get updated from repositories #1978." GitHub coreos/rpm-ostree. December 13, 2022. Accessed August 17, 2023. https://github.com/coreos/rpm-ostree/issues/1978
23. "[Fedora Silverblue] Rebase from F36 to F37 stops on error and hangs ( _g_dbus_worker_do_read_cb) #4150." GitHub coreos/rpm-ostree. March 23, 2023. Accessed August 17, 2023. https://github.com/coreos/rpm-ostree/issues/4150
24. "Extensions." rpm-ostree. March 28, 2022. Accessed August 17, 2023. https://coreos.github.io/rpm-ostree/extensions/
25. "Add support for modules #2760." GitHub coreos/rpm-ostree. April 23, 2023. Accessed August 17, 2023. https://github.com/coreos/rpm-ostree/pull/2760
26. "Rename LXQt variant to Fedora Lazurite." Fedora Pagure workstation-ostree-config. April 21, 2023. Accessed Septmeber 8, 2023. https://pagure.io/workstation-ostree-config/c/4930d909b66d92aae4612fcfd4389b9e64ae4323?branch=f38
27. "Fedora Onyx." Fedora Project Wiki. May 25, 2023. Accessed September 15, 2023. https://fedoraproject.org/wiki/Changes/Fedora_Onyx
28. "Rebasing to New Versions." Fedora Documentation. September 15, 2023. Accessed September 15, 2023. https://docs.fedoraproject.org/en-US/iot/rebasing/
29. "Rocky Linux Is the Most Preferred Enterprise Linux Distribution." Linuxiac. October 5, 2023. Accessed October 16, 2023. https://linuxiac.com/rocky-linux-is-the-most-preferred-enterprise-linux-distribution/
30. "Upgrading Fedora Using DNF System Plugin." Fedora Documentation. May 4, 2023. Accessed October 23, 2023. https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/
31. "rpm-ostree - Man Page." ManKier. Accessed November 28, 2023. https://www.mankier.com/1/rpm-ostree
32. "Chapter 6. Managing Atomic Hosts." Red Hat Customer Portal. Accessed January 17, 2024. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/installation_and_configuration_guide/managing_atomic_hosts
33. "Removing Layered Packages." Fedora Docs. January 17, 2024. Accessed January 17, 2024. https://docs.fedoraproject.org/en-US/iot/remove-layered/
34. "Factory reset with OSTree #1793." GitHub ostreedev/ostree. April 27, 2023. Accessed January 17, 2024. https://github.com/ostreedev/ostree/issues/1793
35. "Rawhide." Fedora Documentation. February 13, 2024. Accessed February 13, 2024. https://docs.fedoraproject.org/en-US/releases/rawhide/
36. "From rawhide to stable." Fedora Discussion. August 20, 2023. Accessed February 13, 2024. https://discussion.fedoraproject.org/t/from-rawhide-to-stable/87694
37. "Proper or correct way to upgrade Rawhide using dnf." FedoraForum.org. May 22, 2023. Accessed February 13, 2024. https://forums.fedoraforum.org/showthread.php?330535-Proper-or-correct-way-to-upgrade-Rawhide-using-dnf
38. "Technical Information." Fedora Docs. April 21, 2024. Accessed April 21, 2024. https://docs.fedoraproject.org/en-US/fedora-silverblue/technical-information/
39. "The pieces of Fedora Silverblue." Fedora Magazine. May 15, 2020. Accessed April 21, 2024. https://fedoramagazine.org/pieces-of-fedora-silverblue/
40. "Fedora Silverblue 40 rebase fails due to rpm GPG signature error in qt5-qtquickcontrols?" Fedora Discussion. April 30, 2024. Accessed May 2, 2024. https://discussion.fedoraproject.org/t/fedora-silverblue-40-rebase-fails-due-to-rpm-gpg-signature-error-in-qt5-qtquickcontrols/114832
41. "Trying out the pre-relese of Fedora 38 a bit early, with Silverblue." Fedora Discussion. March 5, 2023. Accessed May 4, 2024. https://discussion.fedoraproject.org/t/trying-out-the-pre-relese-of-fedora-38-a-bit-early-with-silverblue/47277/1
42. "Fedora CoreOS (FCOS)." OKD 4. Accessed May 22, 2024. https://docs.okd.io/latest/architecture/architecture-rhcos.html
43. "Major Changes in Fedora CoreOS." Fedora Docs. May 22, 2024. Accessed May 22, 2024. https://docs.fedoraproject.org/en-US/fedora-coreos/major-changes/
44. "General Availability of AlmaLinux 9.4 Stable!" AlmaLinux OS. May 6, 2024. Accessed June 3, 2024. https://almalinux.org/blog/2024-05-06-announcing-94-stable/
45. "Getting Started with Fedora/CentOS bootc." Fedora Docs. June 3, 2024. Accessed June 3, 2024. https://docs.fedoraproject.org/en-US/bootc/getting-started/
46. "ostree native containers." rpm-ostree. Accessed June 3, 2024. https://coreos.github.io/rpm-ostree/container/
47. "containers: support converting existing base images? #11." GitHub ostreedev/ostree-rs-ext. May 21, 2024. Accessed June 3, 2024. https://github.com/ostreedev/ostree-rs-ext/issues/11
48. "check composefs compat when rebasing #632." GitHub containers/bootc. June 25, 2024. Accessed July 24, 2024. https://github.com/containers/bootc/issues/632
49. "Support default kernel arguments #479." GitHub ostreedev/ostree. June 11, 2021. Accessed July 24, 2024. https://github.com/ostreedev/ostree/issues/479
50. "Drop requirement on nss-altfiles, use systemd sysusers #49." GitHub coreos/rpm-ostree. March 6, 2024. Accessed August 5, 2024. https://github.com/coreos/rpm-ostree/issues/49
51. "How does /etc/{passwd,group} relate to /usr/lib/{passwd,group} in Silverblue?" Fedora Discussion. May 19, 2022. Accessed August 5, 2024. https://discussion.fedoraproject.org/t/how-does-etc-passwd-group-relate-to-usr-lib-passwd-group-in-silverblue/78301
52. "NSS altfiles module." GitHub aperezdc/nss-altfiles. May 10, 2024. Accessed August 5, 2024. https://github.com/aperezdc/nss-altfiles
53. "Secrets (e.g. container pull secrets)." bootc. Accessed December 18, 2024. https://containers.github.io/bootc/building/secrets.html
54. "Package manager integration." bootc. Accessed December 18, 2024. https://containers.github.io/bootc/package-managers.html
55. "Questions about bootc and rpm-ostree." Fedora Discussion. November 6, 2024. Accessed December 18, 2024. https://discussion.fedoraproject.org/t/questions-about-bootc-and-rpm-ostree/132021/12
56. "Local package layering story with bootc & dnf5." GitLab fedora/bootc. September 24, 2024. Accessed December 18, 2024. https://gitlab.com/fedora/bootc/tracker/-/issues/4
57. "Relationship with other projects." bootc. Accessed December 18, 2024. https://containers.github.io/bootc/relationships.html
58. "bootc image." bootc. Accessed December 18, 2024. https://containers.github.io/bootc/experimental-bootc-image.html
59. "man bootc-container-lint." bootc. Accessed December 18, 2024. https://containers.github.io/bootc/man/bootc-container-lint.html
60. "osbuild/bootc-image-builder." GitHub. December 10, 2024. Accessed December 30, 2024. https://github.com/osbuild/bootc-image-builder
