Fedora
======

.. contents:: Table of Contents

Red Hat Enterprise Linux (RHEL)
-------------------------------

RHEL is a downstream distribution, based on Fedora, aimed at servers.

.. csv-table::
   :header: FEATURE, RHEL, Oracle Linux, AlmaLinux, Rocky Linux
   :widths: 20, 20, 20, 20, 20

   Years of support, >= 12 [1], 10, 10, 10
   Organization type, Profit, Profit, Non-profit [2], Profit
   Price, Free up to 16 servers [3], Free, Free, Free
   Optional paid support, Yes, Yes, Yes, Yes
   Btrfs support, No, Yes [4], No, No

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

rpm-ostree (Fedora Silverblue)
------------------------------

Spins
~~~~~

Fedora provides installations with different desktop environments. These are known as spins. For rpm-ostree distributions, they have special code names listed below. [13][14] Fedora Silverblue was the first spin and was originally called Fedora Atomic Host. [15]

.. csv-table::
   :header: Fedora Spin, Desktop Environment
   :widths: 20, 20

   Silverblue, GNOME
   Kinoite, KDE Plasma
   Sericea, Sway

Dual Booting
~~~~~~~~~~~~

Fedora Silverblue does not support customized partitions or sharing a drive with a different operating system. It is recommended to use the automated installer to install it onto its own storage device. [11]

Through the use of ``os-prober`` (which is part of a default installation), a GRUB menu will be generated with all of the detected operating systems on each drive. This allows for partial dual-boot support.

Two installations of Fedora Silverblue on the same system are also not supported and will lead to issues. [12]

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
-  mutate-os-release (string) = The major version of the operating system.
-  packages (list of strings) = A list of packages to install as part of the base distribution.
-  packages-``<CPU_ARCHITECTURE>`` (list of strings) = A list of packages to install as part of the base distribution if the specified CPU architecture is being used.
-  postprocess-script (string) = A post processing script to run after building the rpm-ostree distribution.
-  ref (string) = The reference URL for where the rpm-ostree compose can be downloaded from. For example, Fedora uses the the reference ``fedora/<MAJOR_VERSION>/${basearch}/silverblue``.
-  releasever (string) = The release version to use for RPM repositories.
-  repos (list of strings) = Repositories to enable. These repositories are sourced from a ``<REPOSITORY>.repo`` file that contains a valid RPM repository. For example, one of the repositories Fedora enables is from the ``fedora-<MAJOR_VERSION>.repo`` file.
-  selinux (boolean) = Default: true. If SELinux should be enabled.

Examples:

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
^^^^^^^^^^^^^^^^^^

Once the treefiles have been created, the rpm-ostree distribution can be built. It is recommended to use either Fedora Silverblue or Fedora Workstation as the host operating system for the build since they provide the required dependencies. The ``rpm-ostree`` command has to be ran with elevated privileges or else it will not work properly.

-  Create a repository structure to host composed builds.

   .. code-block:: sh

      $ sudo ostree --repo=<REPOSITORY_DIRECTORY> init

-  Build the rpm-ostree distribution.

   .. code-block:: sh

      $ sudo rpm-ostree compose tree --unified-core --repo=<REPOSITORY_DIRECTORY> --cachedir=<CACHE_DIRECTORY> fedora-silverblue.yaml

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
