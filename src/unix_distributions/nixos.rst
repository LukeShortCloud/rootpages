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

-  Install a specific version of the Linux kernel. Otherwise, the latest long-term support (LTS) kernel is installed by default. [4][6]

   ::

      { config, pkgs, ... }:
      {
          boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
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
   -  ``lib.mkOption { type; default; example; description; }`` = Any other option. Common types include ``lib.types.bool``, ``str``, ``int``, ``path``, ``package``, ``enum [ <VALUES> ]``, ``listOf <TYPE>``, and ``attrsOf <TYPE>``.

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
13. "nix flake init." Nix Reference Manual. Accessed October 26, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake-init.html
14. "nix flake update." Nix Reference Manual. Accessed October 26, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-flake-update.html
15. "NixOS system configuration." Official NixOS Wiki. October 25, 2026. Accessed October 26, 2026. https://wiki.nixos.org/wiki/NixOS_system_configuration
16. "nixpkgs/flake.nix." GitHub NixOS/nixpkgs. July 24, 2026. Accessed October 26, 2026. https://github.com/NixOS/nixpkgs/blob/nixos-unstable/flake.nix
17. "nixpkgs/pkgs/stdenv/generic/default.nix." GitHub NixOS/nixpkgs. August 12, 2026. Accessed October 26, 2026. https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/stdenv/generic/default.nix
18. "nix build." Nix Reference Manual. Accessed October 26, 2026. https://nix.dev/manual/nix/2.35/command-ref/new-cli/nix3-build.html
