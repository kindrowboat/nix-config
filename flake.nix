{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, vscode-server, lix-module }: 
    {
      nixosConfigurations.silverado = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: { 
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/awesome_workstation.nix
          ./box/silverado.nix
          ./app/caddy.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              (import ./home/awesome.nix { hdpi = false; })
              ./home/email_accounts.nix
            ];
          }
        ];
      };
      nixosConfigurations.tacotuesday = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: { 
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/awesome_workstation.nix
          ./box/tacotuesday.nix
          ./app/k3s.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              (import ./home/awesome.nix { hdpi = false; })
              ./home/email_accounts.nix
            ];
          }
        ];
      };
      nixosConfigurations.framework2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          nixos-hardware.nixosModules.framework-12th-gen-intel
          ./box/framework2.nix
          ./conf/awesome_workstation.nix
          ./conf/sway.nix
          ./conf/epson_perfection_v19.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              (import ./home/awesome.nix { hdpi = true; })
              ./home/sway.nix
              ./home/email_accounts.nix

            ];
          }
          lix-module.nixosModules.default
        ];
      };
      nixosConfigurations.y500 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/kde_workstation.nix
          ./box/y500.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/email_accounts.nix
            ];
          }
        ];
      };
      nixosConfigurations.wmft162 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/awesome_workstation.nix
          ./box/wmft162.nix
          ./app/minikube.nix
          ./app/mysql.nix
          ./app/k3s.nix
          ./app/gcloud.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              (import ./home/awesome.nix { hdpi = false; })
              ./home/email_accounts.nix
            ];
          }
        ];
      };
      nixosConfigurations.revenge = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/awesome_workstation.nix
          ./box/revenge.nix
          ./app/k3s.nix
          ./conf/1710_k8s.nix
          vscode-server.nixosModule
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".bak";
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              (import ./home/awesome.nix { hdpi = false; })
              ./home/email_accounts.nix
            ];
          }
          lix-module.nixosModules.default
        ];
      };
    };
}
