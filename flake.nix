{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    vscode-server.url = "github:msteen/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, vscode-server }: 
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
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/awesome.nix
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
          ./conf/1710_k8s.nix
          ./conf/nextcloud_and_nfs.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
	      ./home/awesome.nix
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
          #./conf/awesome_workstation.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel
          ./box/framework2.nix
          ./conf/awesome_workstation.nix
          ./conf/sway.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/awesome.nix
              ./home/sway.nix
              ./home/email_accounts.nix

            ];
          }
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
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/awesome.nix
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
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/awesome.nix
              ./home/email_accounts.nix
            ];
          }
        ];
      };
    };
}
