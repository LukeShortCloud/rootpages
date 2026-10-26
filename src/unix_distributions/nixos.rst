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

-  Install a specific version of the Linux kernel. Otherwise, the latest long-term support (LTS) kernel is installed by default. [6]

   ::

      { config, pkgs, ... }:
      {
          boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
      }

[4]

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

      { config, pkgs, ... }
      {
        environment.systemPacks = with pkgs; [
          firefox
        ] ++ lib.optionals stdenv.isx86_64 [
          thermald
        ] ++ lib.optionals stdenv.isAarch64 [
          box64
        ];
      }

   ::

      { config, pkgs, ... }
      {
          programs.firefox.enable = true;
          services.thermald.enable = pkgs.stdenv.isx86_64;
      }

-  `Enable AppImage support. <https://nixos.org/manual/nixos/stable/#sec-custom-packages-prebuilt>`__

   ::

      { config, pkgs, ... }
      {
          programs.appimage.enable = true;
          programs.appimage.binfmt = true;
      }

-  `Enable Flatpak support. <https://nixos.org/manual/nixos/stable/#module-services-flatpak>`__

   ::

      { config, pkgs, ... }
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

      { config, pkgs, ... }
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

Flakes
------

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

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/unix_distributions/nixos.rst>`__

Bibliography
------------

1. "Declarative builds & deployments." Nix & NixOS. Accessed July 29, 2026. https://nixos.org/
2. "Introduction to NixOS." Medium - Omkar Chandorkar. May 27, 2020. Accessed July 29, 2026. https://medium.com/the-script-group/introduction-to-nixos-a9dac91399a7
3. "NixOS." endoflife.date. May 28, 2026. Accessed July 29, 2026. https://endoflife.date/nixos
4. "Version 26.05." NixOS Manual. Accessed October 26, 2026. https://nixos.org/manual/nixos/stable/
5. "services.xserver naming is confusing #94799." GitHub NixOS/nixpkgs. June 23, 2026. Accessed August 7, 2026. https://github.com/NixOS/nixpkgs/issues/94799
6. "Linux kernel." NixOS Wiki. Accessed August 7, 2026. https://nixos.wiki/wiki/Linux_kernel
7. "Nix-ld." Official NixOS Wiki. June 16, 2026. Accessed August 12, 2026. https://wiki.nixos.org/wiki/Nix-ld
8. "AMD GCN 1.0/1.1 GPUs Will Default To AMDGPU Driver In Linux 6.19, SMART POWER OLED Added." Phoronix. November 14, 2025. Accessed October 26, 2026. https://www.phoronix.com/news/Linux-6.19-AMDGPU-GCN-1.0-1.1
9. "Appendix A. Configuration Options." NixOS Manual. Accessed October 26, 2026. https://nixos.org/manual/nixos/stable/options
10. "Bluetooth." Official NixOS Wiki. May 10, 2026. Accessed October 26, 2026. https://wiki.nixos.org/wiki/Bluetooth
11. "Flakes." Official NixOS Wiki. October 25, 2026. Accessed October 26, 2026. https://wiki.nixos.org/wiki/Flakes
12. "nix flake." Nix Reference Manual. Accessed October 26, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake.html
