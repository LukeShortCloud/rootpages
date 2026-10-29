NixOS
=====

.. contents:: Table of Contents

Introduction
------------

NixOS is a declarative Linux distribution. It is recommended for advanced Linux users.

Features [1][2]:

-  Declarative configuration for files, packages, and services
-  Builds are reproducible and easily shareable
-  Install two or more versions of the same program
-  Automatic operating system backups called "generations"
-  Optional rolling release updates

Releases
--------

Every 6 months, a new NixOS major update is released and promoted to the "stable" branch. This happens in May (``YY.05``) and November (``YY.11``). They are tagged with the year and month. Each major release gets bug and security updates for 7 months. There is also an "unstable" rolling release branch of NixOS with the latest packages. [3]

Global Configuration
--------------------

Introduction
~~~~~~~~~~~~

The NixOS configuration is defined in ``/etc/nixos/configuration.nix``. After editing this file, run the command ``sudo nixos-rebuild switch``.

-  Configure a unique hostname (the default is ``nixos``).

   ::

      { config, pkgs, ... }:
      {
        networking.hostName = "<HOSTNAME>";
      }

-  Configure the time zone (for example, ``America/New_York``).

   ::

      { config, pkgs, ... }:
      {
        time.timeZone = "<COUNTRY>/<CITY>";
      }

-  Configure the locale (for example, ``en_US.UTF-8``).

   ::

      { config, pkgs, ... }:
      {
        i18n.defaultLocale = "<LOCALE>";
      }

-  Allow proprietary software.

   ::

      { config, pkgs, ... }:
      {
          nixpkgs.config.allowUnfree = true;
      }

   -  Or only allow specific proprietary packages. Unlike ``allowUnfree``, the lists from every module are merged. This allows each module to allow only the packages that it installs. [20]

      ::

         { config, pkgs, ... }:
         {
           nixpkgs.config.allowUnfreePackages = [
             "<PACKAGE_1>"
             "<PACKAGE_2>"
           ];
         }

-  Install NVIDIA proprietary grahpics driver. It is important to note that NixOS uses ``services.xserver`` to configure graphical settings regardless of if Xorg X11 or Wayland is used. [5]

   ::

      { config, pkgs, ... }:
      {
          nixpkgs.config.allowUnfree = true;
          # Latest driver.
          services.xserver.videoDrivers = [ "nvidia" ];
          # Or use a legacy driver.
          #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
          #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
          #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
      }

-  Enable 32-bit graphics drivers.

   ::

      { config, pkgs, ... }:
      {
          hardware.graphics.enable32Bit = true;
      }

-  Enable SSH access. Optionally configure a list of authorized public SSH keys and disable root access entirely.

   ::

      { config, pkgs, ... }:
      {
          services.openssh.enable = true;
          #users.users.<USER>.openssh.authorizedKeys.keys = [ "<SSH_KEY_PUBLIC>" ];
          #services.openssh.settings.PermitRootLogin = "no";
      }

-  Install a specific version of the Linux kernel. Otherwise, the latest long-term support (LTS) kernel is installed by default. [4][6]

   ::

      { config, pkgs, ... }:
      {
          boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
          # Or use the latest stable kernel.
          #boot.kernelPackages = pkgs.linuxPackages_latest;
      }

-  Configure kernel parameters, kernel tunables (sysctl), and the open files limit for user processes. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.kernelParams = [
          "usbhid.mousepoll=1"
        ];
        boot.kernel.sysctl = {
          "fs.file-max" = 524288;
          "vm.max_map_count" = 16777216;
        };
        systemd.user.extraConfig = "DefaultLimitNOFILE=524288";
      }

-  Enable compressed swap in RAM with zram. ``memoryPercent`` is the maximum amount of uncompressed data that can be stored as a percentage of the total RAM. It defaults to ``50``. [9]

   ::

      { config, pkgs, ... }:
      {
        zramSwap = {
          enable = true;
          algorithm = "lz4";
          memoryPercent = 200;
        };
      }

-  Only configure Linux kernel modules options on specific versions. For example, Linux kernel 6.19 enabled the ``amdgpu`` driver for older AMD dGPUs (GCN 1.0 and 1.1) by default. This configuration enables it correctly for older Linux kernel versions. [8]

   ::

      { config, lib, pkgs, ... }:
      {
        boot.extraModprobeConfig = lib.mkIf (lib.versionOlder config.boot.kernelPackages.kernel.version "6.19") ''
          options radeon si_support=0 cik_support=0
          options amdgpu si_support=1 cik_support=1
        '';
      }

-  Install CPU microcode updates.

   ::

      { config, pkgs, ... }:
      {
        hardware.cpu.amd.updateMicrocode = true;
        hardware.cpu.intel.updateMicrocode = true;
      }

-  Create a user account that has ``sudo`` access. The initial password is world-readable because a copy of the configuration is saved in ``/nix/store/``. Run ``passwd`` after the first login to change it. [4][9]

   ::

      { config, pkgs, ... }:
      {
        # Enable passwordless "sudo" usage.
        security.sudo.wheelNeedsPassword = false;
        users.users.<USER_NAME> = {
          extraGroups = [ "wheel" ];
          initialPassword = "<USER_PASSWORD>";
          isNormalUser = true;
        };
      }

-  Enable Bluetooth support. If a desktop environment is installed, related Bluetooth applications for it are also installed. [10]

   ::

      { config, pkgs, ... }:
      {
        # GNOME and KDE Plasma.
        hardware.bluetooth.enable = true;
        # Xfce also needs Blueman enabled.
        #services.blueman.enable = true;
      }

-  Set the NixOS release that the system was first installed with. This is set automatically by ``nixos-generate-config``. Never change it, even after upgrading to a newer release of NixOS. It does not control which version of nixpkgs is used. It only keeps the data of some services (such as databases) compatible. [9]

   ::

      { config, pkgs, ... }:
      {
        system.stateVersion = "<YY>.<MM>";
      }

-  Change the name of the operating system. It is shown in the boot menu, ``/etc/os-release``, and the TTY login. This is an internal option so it is not listed in the official options search. The ``ID`` in ``/etc/os-release`` stays as ``nixos``. [19]

   ::

      { config, pkgs, ... }:
      {
        system.nixos.distroName = "<DISTRO_NAME>";
      }

-  Use KMSCON instead of the Linux kernel virtual console. It provides better fonts, scaling, and Unicode support. [9]

   ::

      { config, pkgs, ... }:
      {
        services.kmscon = {
          enable = true;
          # Use the same keyboard layout as the desktop.
          useXkbConfig = true;
        };
      }

-  Enable printing. Optionally add Bluetooth printers, a virtual PDF printer, and discovery of network printers (mDNS). [9]

   ::

      { config, pkgs, ... }:
      {
        services.printing = {
          enable = true;
          drivers = [ pkgs.bluez ];
          cups-pdf = {
            enable = true;
            instances.pdf.settings.Out = "\${HOME}/PDF";
          };
        };
        services.avahi = {
          enable = true;
          nssmdns4 = true;
        };
      }

-  Enable firmware updates with ``fwupdmgr``. Optionally disable the timer that downloads the list of firmware updates in the background. [9]

   ::

      { config, pkgs, ... }:
      {
        services.fwupd.enable = true;
        systemd.timers.fwupd-refresh.enable = false;
      }

-  Use TLP for power management. ``pd.enable`` provides the same D-Bus API as power-profiles-daemon so desktop environments can still change the power profile. Power-profiles-daemon needs to be disabled. [9]

   ::

      { config, pkgs, ... }:
      {
        services.power-profiles-daemon.enable = false;
        services.tlp = {
          enable = true;
          pd.enable = true;
          settings = {
            CPU_BOOST_ON_AC = 1;
            CPU_BOOST_ON_BAT = 0;
          };
        };
      }

-  Support iPhone and iPad devices. ``usbmuxd`` is used for file transfers and USB tethering. [9]

   ::

      { config, pkgs, ... }:
      {
        services.usbmuxd.enable = true;
        environment.systemPackages = [ pkgs.libimobiledevice ];
      }

-  Support for most hardware. This adds storage and input drivers to the initramfs and installs all redistributable firmware. This is useful for a portable system that boots on different computers. [9]

   ::

      { config, pkgs, ... }:
      {
        hardware.enableAllHardware = true;
      }

-  Install the tools and kernel modules for additional file systems. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.supportedFilesystems = {
          cifs = true;
          exfat = true;
          nfs = true;
          ntfs = true;
          xfs = true;
        };
      }

-  The firewall is enabled by default. Optionally, use firewalld instead. It requires nftables. [9]

   ::

      { config, pkgs, ... }:
      {
        services.firewalld.enable = true;
        networking.nftables.enable = true;
        # The firewall settings application for KDE Plasma.
        environment.systemPackages = [ pkgs.kdePackages.plasma-firewall ];
      }

-  Enable AppArmor. Only programs that a NixOS module provides a profile for are confined. Most community AppArmor profiles need to be modified because NixOS uses different file paths. [9]

   ::

      { config, pkgs, ... }:
      {
        security.apparmor.enable = true;
      }

-  Install a static configuration file into ``/etc/``. Use ``.source`` for a file or ``.text`` for a string. Set ``.enable = false`` to remove a file that another module defines. Prefer a NixOS option for the setting if one exists. [9]

   ::

      { config, pkgs, ... }:
      {
        environment.etc."<PATH>".source = ./rootfs/etc/<PATH>;
        environment.etc."<PATH>".text = ''
          <CONTENTS>
        '';
      }

-  Build all Nix packages and system configurations but do not switch to the new build. ``<NAME>`` is usually the same as the hostname (which is ``nixos`` by default). [11]

   .. code-block:: sh

      $ nix build .#nixosConfigurations.<NAME>.config.system.build.toplevel

Experimental Nix Features
~~~~~~~~~~~~~~~~~~~~~~~~~

There are a lot of experimental features for Nixpkg. The two most commonly used are ``flakes`` and ``nix-command``. `View the full list here <https://nix.dev/manual/nix/2.18/contributing/experimental-features>`__.

-  Enable the most common experimental features using ``/etc/nixos/configuration.nix``.

   ::

      { config, pkgs, ... }:
      {
          nix.settings = {
            experimental-features = [
              "flakes"
              "nix-command"
            ];
          };
      }

Packages
~~~~~~~~

Search for packages with either ``nix search nixpkgs`` (where ``nixpkgs`` is the repository) or use the `official NixOS package search website <https://search.nixos.org/packages>`__. The website also shows useful configuration options.

-  View all available packages and what repository they come from.

   .. code-block:: sh

      $ nix-env -qaP '*' --description

-  Define packages to install globally.

   ::

      { config, pkgs, ... }:
      {
          environment.systemPackages = with pkgs; [
            <PACKAGE_1>
            <PACKAGE_2>
          ];
      }

-  Some packages are installed automatically if they support an ``enable`` configuration option. This is most useful for systemd services which will be installed and then enabled automatically.

   ::

      { config, pkgs, ... }:
      {
          environment.systemPackages = with pkgs; [
            firefox
          ];
      }

   ::

      { config, pkgs, ... }:
      {
          programs.firefox.enable = true;
      }

-  Install packages based on the CPU architecture.

   ::

      { config, lib, pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          firefox
        ] ++ lib.optionals stdenv.hostPlatform.isx86_64 [
          thermald
        ] ++ lib.optionals stdenv.hostPlatform.isAarch64 [
          box64
        ];
      }

   ::

      { config, pkgs, ... }:
      {
          programs.firefox.enable = true;
          services.thermald.enable = pkgs.stdenv.hostPlatform.isx86_64;
      }

-  `Enable AppImage support. <https://nixos.org/manual/nixos/stable/#sec-custom-packages-prebuilt>`__

   ::

      { config, pkgs, ... }:
      {
          programs.appimage.enable = true;
          programs.appimage.binfmt = true;
      }

-  `Enable Flatpak support. <https://nixos.org/manual/nixos/stable/#module-services-flatpak>`__

   ::

      { config, pkgs, ... }:
      {
          services.flatpak.enable = true;
          xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
          xdg.portal.config.common.default = "gtk";
      }

   .. code-block:: sh

      $ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      $ flatpak update

[4]

-  Enable support for non-NixOS Linux binaries. The list of packages to get libraries from needs to be defined and is separate from the system packages. It is recommended to start with ``steam-run`` which includes many common libraries.

   ::

      { config, pkgs, ... }:
      {
          services.envfs.enable = true;
          programs.nix-ld = {
            enable = true;
            libraries = pkgs.steam-run.args.multiPkgs pkgs;
          };
      }

   -  If a library is still missing, search to see if a NixOS package provides it. For example, search for the ``libzstd.so.1`` Zstandard library file. [7]

      .. code-block:: sh

         $ nix run github:nix-community/nix-index-database lib/<LIBRARY_NAME>

      .. code-block:: sh

         $ nix run github:nix-community/nix-index-database lib/libzstd.so.1
         zstd.out                                              0 s /nix/store/9nizcmvz2699nkrbzxx8xsp5d8jp686w-zstd-1.5.7/lib/libzstd.so.1
         zstd.out                                        905,672 x /nix/store/9nizcmvz2699nkrbzxx8xsp5d8jp686w-zstd-1.5.7/lib/libzstd.so.1.5.7

-  Install Flatpaks declaratively with the third-party `nix-flatpak <https://github.com/gmodena/nix-flatpak>`__ NixOS module. It adds the ``services.flatpak.packages`` option. [22]

   ::

      {
        inputs = {
          nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
          nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=<VERSION>";
        };

        outputs = { self, nixpkgs, nix-flatpak, ... }: {
          nixosConfigurations.<NAME> = nixpkgs.lib.nixosSystem {
            modules = [
              nix-flatpak.nixosModules.nix-flatpak
              ./configuration.nix
            ];
          };
        };
      }

   ::

      { config, pkgs, ... }:
      {
        services.flatpak = {
          enable = true;
          packages = [
            { appId = "<FLATPAK_ID>"; origin = "flathub"; }
          ];
        };
      }

-  Add the Flathub remote without a network connection or a first-boot service. Flatpak adds every ``.flatpakrepo`` file in ``/etc/flatpak/remotes.d/`` as a system-wide remote. [21]

   .. code-block:: sh

      $ curl -L -o rootfs/etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo

   ::

      { config, pkgs, ... }:
      {
        services.flatpak.enable = true;
        environment.etc."flatpak/remotes.d/flathub.flatpakrepo".source = ./rootfs/etc/flatpak/remotes.d/flathub.flatpakrepo;
      }

Boot
~~~~

-  Use systemd-boot instead of GRUB. Limit the number of generations in the boot menu so the EFI partition does not run out of space. For a portable drive, do not modify the EFI variables of the computer. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.loader.systemd-boot = {
          enable = true;
          configurationLimit = <NUMBER_OF_GENERATIONS>;
        };
        boot.loader.efi.canTouchEfiVariables = false;
      }

-  Use systemd in the initramfs instead of the scripted initramfs. This is required for features such as growing partitions with ``systemd-repart`` during boot. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.initrd.systemd.enable = true;
      }

-  Unlock a LUKS encrypted partition during boot. The ``<MAPPER_NAME>`` is the name of the unlocked device in ``/dev/mapper/``. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.initrd.luks.devices.<MAPPER_NAME>.device = "/dev/disk/by-label/<LUKS_LABEL>";
      }

Storage
~~~~~~~

-  Mount a file system with custom options. Mounting by label (instead of UUID) allows the same image to boot from any drive. [9]

   ::

      { config, pkgs, ... }:
      {
        fileSystems."/" = {
          device = "/dev/disk/by-label/<LABEL>";
          fsType = "btrfs";
          options = [
            "compress-force=zstd:2"
            "noatime"
          ];
        };
      }

-  Reduce writes to the drive by using RAM (tmpfs) for ``/tmp/`` and for logs. Logs are lost after a reboot. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.tmp.useTmpfs = true;
        services.journald.storage = "volatile";
      }

-  Grow the root partition and file system to fill the drive during boot. ``systemd-repart`` only changes the partition table when there is free space. The partition definitions use the ``repart.d`` format. [9]

   ::

      { config, pkgs, ... }:
      {
        boot.initrd.systemd.enable = true;
        boot.initrd.systemd.repart.enable = true;
        systemd.repart.partitions = {
          "10-esp" = {
            Type = "esp";
          };
          "20-root" = {
            Type = "root";
          };
        };
        fileSystems."/".autoResize = true;
      }

-  Add udev rules. For example, set the I/O scheduler to BFQ for SATA, SD card, and USB drives and Kyber for NVMe drives. [9]

   ::

      { config, pkgs, ... }:
      {
        services.udev.extraRules = ''
          ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/scheduler}="bfq"
          ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="kyber"
        '';
      }

-  Take Btrfs snapshots of ``/home/`` with Snapper. ``/home/`` must be a Btrfs subvolume. The NixOS module does not create the ``.snapshots`` subvolume. The tmpfiles type ``v`` creates it if the root file system is Btrfs. Otherwise, it creates a normal directory. [9][24]

   ::

      { config, pkgs, ... }:
      {
        services.snapper = {
          snapshotInterval = "monthly";
          persistentTimer = true;
          configs.home = {
            SUBVOLUME = "/home";
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
            TIMELINE_LIMIT_MONTHLY = 5;
          };
        };
        systemd.tmpfiles.rules = [ "v /home/.snapshots 0750 root root -" ];
      }

   .. code-block:: sh

      $ sudo snapper -c home list

systemd
~~~~~~~

-  Create a systemd service. ``script`` is converted into a shell script for ``ExecStart``. ``path`` adds packages to the ``PATH`` of the service. ``wantedBy`` enables the service. [4][9]

   ::

      { config, pkgs, ... }:
      {
        systemd.services.<SERVICE> = {
          description = "<DESCRIPTION>";
          wantedBy = [ "multi-user.target" ];
          after = [ "local-fs.target" ];
          serviceConfig.Type = "oneshot";
          path = [ pkgs.util-linux ];
          script = ''
            lsblk
          '';
        };
      }

-  Install a service but do not start it at boot. Use ``lib.mkForce`` to override the ``wantedBy`` value from the NixOS module. [9]

   ::

      { config, lib, pkgs, ... }:
      {
        services.openssh.enable = true;
        systemd.services.sshd.wantedBy = lib.mkForce [ ];
      }

-  Use systemd units that are provided by a package. NixOS ignores the ``[Install]`` section of unit files because enabling a unit is stateful. Use ``wantedBy`` to enable it instead. ``overrideStrategy = "asDropin"`` makes NixOS create a drop-in file for the existing unit instead of a new unit file. [4][9]

   ::

      { config, pkgs, ... }:
      {
        systemd.packages = [ pkgs.<PACKAGE> ];
        systemd.services.<SERVICE> = {
          overrideStrategy = "asDropin";
          wantedBy = [ "multi-user.target" ];
        };
      }

Desktop Environments
~~~~~~~~~~~~~~~~~~~~

-  Install KDE Plasma 6 with the Plasma Login Manager. Plasma also installs PipeWire and the XDG desktop portals. [9]

   ::

      { config, pkgs, ... }:
      {
        services.desktopManager.plasma6.enable = true;
        services.displayManager.plasma-login-manager = {
          enable = true;
          settings.General.DisplayServer = "wayland";
        };
        # Use real-time priority for PipeWire to avoid audio crackling.
        security.rtkit.enable = true;
        # Phone integration. This also opens the required firewall ports.
        programs.kdeconnect.enable = true;
      }

-  Install a different variant of a program by changing the ``package`` option. [9]

   ::

      { config, pkgs, ... }:
      {
        programs.firefox = {
          enable = true;
          package = pkgs.firefox-esr;
        };
      }

Gaming
~~~~~~

-  Install Steam with GE-Proton and the Steam Deck "Game Mode" (Gamescope session) on the login screen. [9]

   ::

      { config, pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
          gamescopeSession.enable = true;
        };
      }

-  Install gaming tools. ``pkgsi686Linux`` provides the 32-bit version of a package. [9]

   ::

      { config, pkgs, ... }:
      {
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };
        programs.gamemode.enable = true;
        programs.gamescope.enable = true;
        environment.systemPackages = [
          pkgs.mangohud
          pkgs.pkgsi686Linux.mangohud
        ];
      }

-  Support more game controllers. [9]

   ::

      { config, pkgs, ... }:
      {
        # Steam Controller and Steam Deck.
        hardware.steam-hardware.enable = true;
        # Many other controllers.
        services.udev.packages = [ pkgs.game-devices-udev-rules ];
        hardware.uinput.enable = true;
        # Controllers built into gaming handhelds.
        services.inputplumber.enable = true;
        # The Xbox wireless USB dongle. This uses proprietary firmware.
        hardware.xone.enable = true;
      }

-  Host games for Moonlight with Sunshine. ``capSysAdmin`` is required for DRM/KMS screen capture. [9]

   ::

      { config, pkgs, ... }:
      {
        services.sunshine = {
          enable = true;
          autoStart = false;
          capSysAdmin = true;
          openFirewall = true;
        };
      }

Generations
-----------

Every ``nixos-rebuild switch`` creates a new generation of the system. Older generations can be booted from the boot menu or switched to. [4]

-  List the generations.

   .. code-block:: sh

      $ ls -l /nix/var/nix/profiles/system-*-link

-  Switch to the previous generation. [4]

   .. code-block:: sh

      $ sudo nixos-rebuild switch --rollback

-  Delete packages that are not used by any generation. Use ``-d`` to also delete all old generations. This removes the ability to roll back to them. [4]

   .. code-block:: sh

      $ sudo nix-collect-garbage
      $ sudo nix-collect-garbage -d

-  Use ``nh`` as an alternative to ``nixos-rebuild`` and ``nix-collect-garbage``. ``programs.nh.clean`` deletes old generations every week by default. ``programs.nh.flake`` sets the default flake so ``nh os switch`` does not need a path. [9][23]

   ::

      { config, pkgs, ... }:
      {
        programs.nh = {
          enable = true;
          clean = {
            enable = true;
            extraArgs = "--keep 5";
          };
          flake = "/etc/nixos";
        };
      }

   .. code-block:: sh

      $ nh os switch
      $ nh os switch <FLAKE_PATH> -H <NAME>

Modules
-------

Introduction
~~~~~~~~~~~~

The ``/etc/nixos/configuration.nix`` file is a NixOS module. A module is a function that takes arguments (such as ``config``, ``lib``, and ``pkgs``) and returns an attribute set with up to three attributes:

-  ``imports`` = A list of other modules to load.
-  ``options`` = New options that this module declares.
-  ``config`` = Values for options that are declared by this module or other modules.

::

   { config, lib, pkgs, ... }:
   {
     imports = [
       ./<MODULE>.nix
     ];
     options = {
       # Option declarations.
     };
     config = {
       # Option definitions.
     };
   }

A module that does not declare any options can skip the ``config`` attribute and define options at the top-level. Every example in the "Global Configuration" section uses this abbreviated form.

The ``...`` in the function arguments is required. It allows NixOS to pass other arguments that the module does not use. [4]

Options
~~~~~~~

Declaring an option makes it available to be configured by every other module. It is invalid to define an option that has not been declared by any module.

-  Declare a custom service with an option to enable it, an option to change the package, and an option for the log level. The configuration is only applied when the service is enabled.

   ::

      { config, lib, pkgs, ... }:
      let
        cfg = config.services.<SERVICE>;
      in
      {
        options.services.<SERVICE> = {
          enable = lib.mkEnableOption "<SERVICE>";
          package = lib.mkPackageOption pkgs "<PACKAGE>" { };
          logLevel = lib.mkOption {
            type = lib.types.enum [ "debug" "info" "warn" "error" ];
            default = "info";
            description = "The log level for <SERVICE>.";
          };
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [ cfg.package ];
          systemd.services.<SERVICE> = {
            wantedBy = [ "multi-user.target" ];
            environment.LOG_LEVEL = cfg.logLevel;
            serviceConfig.ExecStart = "${lib.getExe cfg.package}";
          };
        };
      }

   -  Then enable it from any other module.

      ::

         { config, pkgs, ... }:
         {
           services.<SERVICE>.enable = true;
         }

-  Functions for declaring options:

   -  ``lib.mkEnableOption "<NAME>"`` = A boolean option that defaults to ``false``. Its description is "Whether to enable <NAME>."
   -  ``lib.mkPackageOption <PACKAGE_SET> "<PACKAGE>" { }`` = An option for the package that a module uses. The default is ``<PACKAGE_SET>.<PACKAGE>``. A different package set can be used, such as the packages from a flake. Package options are recommended over overlays because overlays make evaluation of nixpkgs significantly slower.
   -  ``lib.mkOption { type; default; example; description; }`` = Any other option. Common types include ``lib.types.bool``, ``str``, ``int``, ``ints.positive``, ``path``, ``package``, ``enum [ <VALUES> ]``, ``listOf <TYPE>``, ``attrsOf <TYPE>``, ``nullOr <TYPE>`` (the type or ``null``), and ``oneOf [ <TYPES> ]`` (any of the types).

-  Use ``lib.mkMerge`` to combine more than one ``lib.mkIf`` block. For example, install more packages when an option is set to a higher level. [4]

   ::

      { config, lib, pkgs, ... }:
      let
        cfg = config.services.<SERVICE>;
      in
      {
        options.services.<SERVICE> = {
          enable = lib.mkEnableOption "<SERVICE>";
          selection = lib.mkOption {
            type = lib.types.enum [ "minimal" "full" ];
            default = "minimal";
            description = "Which packages to install.";
          };
        };

        config = lib.mkIf cfg.enable (lib.mkMerge [
          {
            environment.systemPackages = [ pkgs.<PACKAGE_1> ];
          }
          (lib.mkIf (cfg.selection == "full") {
            environment.systemPackages = [ pkgs.<PACKAGE_2> ];
          })
        ]);
      }

-  Use ``assertions`` to stop the build with a clear error message when a configuration is not supported. Use ``warnings`` to show a message without stopping the build. [4]

   ::

      { config, lib, pkgs, ... }:
      {
        config = lib.mkIf config.services.<SERVICE>.enable {
          assertions = [
            {
              assertion = !config.hardware.nvidia.enabled;
              message = "<SERVICE> does not support the proprietary NVIDIA driver.";
            }
          ];
        };
      }

-  Use ``lib.mkIf`` instead of ``if`` for configuration that depends on an option. ``if config.services.<SERVICE>.enable then { ... } else { }`` fails with an "infinite recursion" error because the value of the option depends on the configuration being created. ``lib.mkIf`` moves the condition into each option definition instead. [4]

Priorities
~~~~~~~~~~

When two or more modules define the same option, NixOS merges the values. Lists (such as ``environment.systemPackages``) are combined. Other types (such as a string) cause an error if the values are different.

-  Use a priority to choose which value wins. The lowest number has the highest priority. All other definitions are discarded.

   .. csv-table::
      :header: Function, Priority, Description
      :widths: 20, 20, 20

      ``lib.mkForce <VALUE>``, 50, Override all regular definitions.
      ``<VALUE>``, 100, A regular definition.
      ``lib.mkDefault <VALUE>``, 1000, A default that any regular definition overrides. This is useful for shared modules.
      ``lib.mkOption { default = <VALUE>; }``, 1500, The default value of an option.
      ``lib.mkOverride <NUMBER> <VALUE>``, <NUMBER>, A custom priority.

   ::

      { config, lib, pkgs, ... }:
      {
        services.openssh.enable = lib.mkForce false;
        nix.gc.automatic = lib.mkDefault true;
      }

-  Use ``lib.mkBefore`` or ``lib.mkAfter`` to change where a value is placed in a merged list. This does not change if the value is used. [4]

   ::

      { config, lib, pkgs, ... }:
      {
        boot.kernelModules = lib.mkBefore [ "kvm-intel" ];
      }

CPU Architecture
~~~~~~~~~~~~~~~~

-  Use ``pkgs.stdenv.hostPlatform`` to find information about the CPU architecture of the system. For example, ``pkgs.stdenv.hostPlatform.system`` returns a string such as ``x86_64-linux`` or ``aarch64-linux``. Do not use the older ``pkgs.stdenv.isx86_64`` and ``pkgs.stdenv.isAarch64`` attributes because they are deprecated and show a warning. Use ``pkgs.stdenv.hostPlatform.isx86_64`` and ``pkgs.stdenv.hostPlatform.isAarch64`` instead. [17]

   ::

      { config, lib, pkgs, ... }:
      {
        services.thermald.enable = pkgs.stdenv.hostPlatform.isx86_64;
        environment.systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isAarch64 [
          pkgs.box64
        ];
      }

Flakes
------

Introduction
~~~~~~~~~~~~

A flake is a directory with a ``flake.nix`` file. It defines ``inputs`` (dependencies such as nixpkgs and other flakes) and ``outputs`` (a function that returns packages, NixOS modules, NixOS configurations, and more). Nix pins the exact version of every input in a ``flake.lock`` file. Commit this file to git so that every build uses the same versions. [12]

The ``flakes`` and ``nix-command`` experimental features need to be enabled. Otherwise, add ``--extra-experimental-features 'nix-command flakes'`` to every ``nix`` command.

-  Create a default ``flake.nix`` file. This does not do git initialization (only flake).

   .. code-block:: sh

      $ nix --extra-experimental-features 'nix-command flakes' flake init

-  If a Flake is managed inside a local git repository, all files must be added with ``git add`` first (a ``git commit`` is not required). [11]
-  View tree-style information about attributes from a flake in the current git project directory.

   .. code-block:: sh

      $ nix --extra-experimental-features 'nix-command flakes' flake show

-  View that information when it is in a local git repository but has not been added with ``git add`` yet. [12]

   .. code-block:: sh

      $ nix --extra-experimental-features 'nix-command flakes' flake show path:.

-  Structure of a ``flake.nix`` file. Every input is passed as an argument to ``outputs``. ``self`` refers to this flake. [12]

   ::

      {
        description = "<DESCRIPTION>";

        inputs = {
          nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
          <INPUT> = {
            url = "<FLAKE_URL>";
            inputs.nixpkgs.follows = "nixpkgs";
          };
        };

        outputs = { self, nixpkgs, <INPUT>, ... }: {
          # Outputs.
        };
      }

   -  ``inputs.<INPUT>.inputs.nixpkgs.follows = "nixpkgs";`` makes the input use the same nixpkgs as this flake. This avoids downloading and evaluating more than one version of nixpkgs. [11][12]

-  Update all inputs to their latest versions. This updates the ``flake.lock`` file. [14]

   .. code-block:: sh

      $ nix flake update

-  Update only one input. [14]

   .. code-block:: sh

      $ nix flake update <INPUT>

Outputs
~~~~~~~

Common outputs [11]:

-  ``packages.<SYSTEM>.<PACKAGE>`` = A package for a specific system (such as ``x86_64-linux``). ``packages.<SYSTEM>.default`` is used when no package name is given.
-  ``nixosModules.<MODULE>`` = A NixOS module that other flakes can import. ``nixosModules.default`` is the default module.
-  ``nixosConfigurations.<NAME>`` = A full NixOS system.
-  ``templates.<TEMPLATE>`` = A directory that can be copied to create a new flake. ``templates.default`` is the default template.
-  ``devShells.<SYSTEM>.<NAME>`` = A development shell for ``nix develop``.

Examples:

-  Provide a package and a NixOS module.

   ::

      {
        inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

        outputs = { self, nixpkgs, ... }: {
          packages.x86_64-linux.<PACKAGE> = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/<PACKAGE>/package.nix { };
          nixosModules.default = ./modules/default.nix;
        };
      }

-  Build or run a package from the flake in the current directory.

   .. code-block:: sh

      $ nix build .#<PACKAGE>
      $ nix run .#<PACKAGE>

-  Provide a NixOS module that also imports NixOS modules from other flakes. Users of this module do not need to add those flakes as inputs. A module file that is imported more than once is only loaded once. [11][20]

   ::

      {
        inputs = {
          nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
          <INPUT>.url = "<FLAKE_URL>";
        };

        outputs = { self, nixpkgs, <INPUT>, ... }: {
          nixosModules.default = {
            imports = [
              ./modules/default.nix
              <INPUT>.nixosModules.default
            ];
          };
        };
      }

-  Provide checks. ``nix flake check`` evaluates every output and builds every derivation in ``checks.<SYSTEM>``. Use ``--no-build`` to only evaluate. [25]

   ::

      {
        inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

        outputs = { self, nixpkgs, ... }: {
          checks.x86_64-linux.<CHECK> = nixpkgs.legacyPackages.x86_64-linux.runCommand "<CHECK>" { } ''
            touch $out
          '';
        };
      }

   .. code-block:: sh

      $ nix flake check
      $ nix flake check --no-build

NixOS Configurations
~~~~~~~~~~~~~~~~~~~~

-  Define a NixOS system with ``nixpkgs.lib.nixosSystem``. ``nixos-rebuild switch`` uses ``/etc/nixos/flake.nix`` instead of ``/etc/nixos/configuration.nix`` if it exists. [15]

   ::

      {
        inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

        outputs = { self, nixpkgs, ... }: {
          nixosConfigurations.<NAME> = nixpkgs.lib.nixosSystem {
            modules = [
              ./configuration.nix
            ];
          };
        };
      }

   -  The ``system`` argument for ``nixosSystem`` (such as ``system = "x86_64-linux";``) is a legacy option. The CPU architecture is already set by ``nixpkgs.hostPlatform`` in the generated ``hardware-configuration.nix`` file. [16]

-  ``nixos-rebuild`` uses the hostname of the current system to find which ``nixosConfigurations.<NAME>`` to use. Use a different configuration by adding ``#<NAME>``. [15]

   .. code-block:: sh

      $ sudo nixos-rebuild switch --flake /etc/nixos#<NAME>

-  Use ``specialArgs`` to pass extra arguments to every module. For example, pass all of the flake inputs. Then a module can import NixOS modules from other flakes. [15][16]

   ::

      {
        inputs = {
          nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
          <INPUT>.url = "<FLAKE_URL>";
        };

        outputs = { self, nixpkgs, ... }@inputs: {
          nixosConfigurations.<NAME> = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./configuration.nix
            ];
          };
        };
      }

   ::

      { config, pkgs, inputs, ... }:
      {
        imports = [
          inputs.<INPUT>.nixosModules.default
        ];
      }

-  Build a system that is based on another flake's NixOS module. ``inputs.nixpkgs.follows = "<INPUT>/nixpkgs";`` makes this flake use the same nixpkgs as the other flake. This keeps the system on the version of nixpkgs that the other flake was tested with. [12]

   ::

      {
        inputs = {
          <INPUT>.url = "<FLAKE_URL>";
          nixpkgs.follows = "<INPUT>/nixpkgs";
        };

        outputs = { self, nixpkgs, <INPUT>, ... }: {
          nixosConfigurations.<NAME> = nixpkgs.lib.nixosSystem {
            modules = [
              <INPUT>.nixosModules.default
              ./configuration.nix
            ];
          };
        };
      }

-  Use ``extendModules`` to create a variant of an existing NixOS configuration with more modules. This avoids repeating the list of modules. [20]

   ::

      {
        inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

        outputs = { self, nixpkgs, ... }: {
          nixosConfigurations.<NAME> = nixpkgs.lib.nixosSystem {
            modules = [
              ./configuration.nix
            ];
          };
          nixosConfigurations.<NAME>-<VARIANT> = self.nixosConfigurations.<NAME>.extendModules {
            modules = [
              { services.openssh.enable = nixpkgs.lib.mkForce false; }
            ];
          };
        };
      }

Templates
~~~~~~~~~

A template is a directory that is copied to create a new flake. This is useful for sharing a starting configuration, such as a ``flake.nix`` and ``configuration.nix`` for a new NixOS system. [13]

-  Define a template. The ``welcomeText`` is shown after the template is copied and supports Markdown.

   ::

      {
        outputs = { self, ... }: {
          templates = {
            <TEMPLATE> = {
              path = ./templates/<TEMPLATE>;
              description = "<DESCRIPTION>";
              welcomeText = ''
                # <TITLE>
                Run `sudo nixos-rebuild switch` to apply the configuration.
              '';
            };
            default = self.templates.<TEMPLATE>;
          };
        };
      }

-  List the templates provided by a flake.

   .. code-block:: sh

      $ nix flake show <FLAKE_URL>

-  Create a new flake in the current directory from a template. Existing files are not overwritten. Without ``-t``, the default template from the official ``templates`` flake is used. [13]

   .. code-block:: sh

      $ nix flake init -t <FLAKE_URL>#<TEMPLATE>

Flake References
~~~~~~~~~~~~~~~~

A flake reference (``<FLAKE_URL>``) is the location of a flake. It is used for inputs and for commands such as ``nix build`` and ``nix flake init``. [12]

.. csv-table::
   :header: Reference, Description
   :widths: 20, 20

   ``github:<OWNER>/<REPOSITORY>``, The default branch of a GitHub repository.
   ``github:<OWNER>/<REPOSITORY>?ref=<BRANCH>``, A specific branch or tag of a GitHub repository.
   ``git+https://<DOMAIN>/<OWNER>/<REPOSITORY>?ref=<BRANCH>``, A git repository over HTTPS.
   ``git+ssh://git@<DOMAIN>/<OWNER>/<REPOSITORY>.git?ref=<BRANCH>``, A git repository over SSH. This works with private repositories by using the SSH key of the current user.
   ``git+file://<ABSOLUTE_PATH>``, A local git repository. Only files added with ``git add`` are used.
   ``path:<DIRECTORY>``, A local directory. All files are used even if they are not tracked by git.

-  Test a local copy of an input instead of the version in ``flake.lock``. This does not change the ``flake.lock`` file. [18]

   .. code-block:: sh

      $ nix build --override-input <INPUT> path:<DIRECTORY> .#nixosConfigurations.<NAME>.config.system.build.toplevel

-  Do not store large files (such as disk images) inside of a flake directory that is used with ``path:``. The entire directory is copied into the Nix store during every evaluation, even files that are ignored by ``.gitignore``. [12]

-  Build or run a package from the version of nixpkgs that is pinned in a flake's ``flake.lock`` file. ``--inputs-from`` makes ``nixpkgs`` refer to that version instead of the latest version. [18]

   .. code-block:: sh

      $ nix build --no-link --print-out-paths --inputs-from git+file://$(pwd) nixpkgs#<PACKAGE>

Building Images
---------------

There are different ways to build a disk image of a NixOS system.

-  ``image.repart`` = Build a disk image with ``nix build`` using ``systemd-repart``. It does not need root access or a virtual machine. [4]

   ::

      { config, modulesPath, ... }:
      {
        imports = [ "${modulesPath}/image/repart.nix" ];
        image.repart = {
          name = "<IMAGE_NAME>";
          partitions = {
            "esp" = {
              repartConfig.Type = "esp";
            };
            "root" = {
              storePaths = [ config.system.build.toplevel ];
              repartConfig = {
                Type = "root";
                Label = "nixos";
              };
            };
          };
        };
      }

-  ``nixos-rebuild build-image`` = Build an image for a virtualization platform or cloud provider. Run it without arguments to list the image variants. [4]

   .. code-block:: sh

      $ nixos-rebuild build-image --image-variant <VARIANT>

-  ``nixos-install`` = Install NixOS into a mounted disk image (using a loop device) the same way as on a real computer. ``--system`` installs a system that was already built instead of building it. This requires root access. It can be run inside of a privileged container. [26]

   .. code-block:: sh

      $ nix build .#nixosConfigurations.<NAME>.config.system.build.toplevel
      $ sudo nixos-install --root <MOUNT_DIRECTORY> --system ./result --no-root-passwd --no-channel-copy

-  Run Nix inside of a container with the official ``nixos/nix`` container image. Enable the experimental features in ``/etc/nix/nix.conf``.

   ::

      FROM docker.io/nixos/nix:<VERSION>
      RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/nixos.rst>`__

Bibliography
------------

1. "Declarative builds & deployments." Nix & NixOS. Accessed July 29, 2026. https://nixos.org/
2. "Introduction to NixOS." Medium - Omkar Chandorkar. May 27, 2020. Accessed July 29, 2026. https://medium.com/the-script-group/introduction-to-nixos-a9dac91399a7
3. "NixOS." endoflife.date. May 28, 2026. Accessed July 29, 2026. https://endoflife.date/nixos
4. "Version 26.05." NixOS Manual. Accessed October 29, 2026. https://nixos.org/manual/nixos/stable/
5. "services.xserver naming is confusing #94799." GitHub NixOS/nixpkgs. June 23, 2026. Accessed August 7, 2026. https://github.com/NixOS/nixpkgs/issues/94799
6. "Linux kernel." NixOS Wiki. Accessed August 7, 2026. https://nixos.wiki/wiki/Linux_kernel
7. "Nix-ld." Official NixOS Wiki. June 16, 2026. Accessed August 12, 2026. https://wiki.nixos.org/wiki/Nix-ld
8. "AMD GCN 1.0/1.1 GPUs Will Default To AMDGPU Driver In Linux 6.19, SMART POWER OLED Added." Phoronix. November 14, 2025. Accessed October 26, 2026. https://www.phoronix.com/news/Linux-6.19-AMDGPU-GCN-1.0-1.1
9. "Appendix A. Configuration Options." NixOS Manual. Accessed October 29, 2026. https://nixos.org/manual/nixos/stable/options
10. "Bluetooth." Official NixOS Wiki. May 10, 2026. Accessed October 26, 2026. https://wiki.nixos.org/wiki/Bluetooth
11. "Flakes." Official NixOS Wiki. October 25, 2026. Accessed October 29, 2026. https://wiki.nixos.org/wiki/Flakes
12. "nix flake." Nix Reference Manual. Accessed October 29, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake.html
13. "nix flake init." Nix Reference Manual. Accessed October 26, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake-init.html
14. "nix flake update." Nix Reference Manual. Accessed October 26, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake-update.html
15. "NixOS system configuration." Official NixOS Wiki. October 25, 2026. Accessed October 26, 2026. https://wiki.nixos.org/wiki/NixOS_system_configuration
16. "nixpkgs/flake.nix." GitHub NixOS/nixpkgs. July 24, 2026. Accessed October 26, 2026. https://github.com/NixOS/nixpkgs/blob/nixos-unstable/flake.nix
17. "nixpkgs/pkgs/stdenv/generic/default.nix." GitHub NixOS/nixpkgs. August 12, 2026. Accessed October 26, 2026. https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/stdenv/generic/default.nix
18. "nix build." Nix Reference Manual. Accessed October 29, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-build.html
19. "nixpkgs/nixos/modules/misc/version.nix." GitHub NixOS/nixpkgs. May 24, 2026. Accessed October 29, 2026. https://github.com/NixOS/nixpkgs/blob/nixos-26.05/nixos/modules/misc/version.nix
20. "Version 26.05." Nixpkgs Reference Manual. Accessed October 29, 2026. https://nixos.org/manual/nixpkgs/stable/
21. "Flatpak Command Reference." Flatpak documentation. Accessed October 29, 2026. https://docs.flatpak.org/en/latest/flatpak-command-reference.html
22. "nix-flatpak." GitHub gmodena/nix-flatpak. October 10, 2026. Accessed October 29, 2026. https://github.com/gmodena/nix-flatpak
23. "nh/docs/README.md." GitHub nix-community/nh. October 24, 2026. Accessed October 29, 2026. https://github.com/nix-community/nh/blob/master/docs/README.md
24. "tmpfiles.d." systemd. Accessed October 29, 2026. https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
25. "nix flake check." Nix Reference Manual. Accessed October 29, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake-check.html
26. "nixpkgs/pkgs/by-name/ni/nixos-install/nixos-install.sh." GitHub NixOS/nixpkgs. April 2, 2026. Accessed October 29, 2026. https://github.com/NixOS/nixpkgs/blob/nixos-26.05/pkgs/by-name/ni/nixos-install/nixos-install.sh
