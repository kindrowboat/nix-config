{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager }: 
    {
      nixosConfigurations.tacotuesday = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: { 
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/workstation.nix
          ./box/tacotuesday.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/kindrobot-linux.nix
              ./home/email_accounts.nix
            ];
          }
        ];
      };
      nixosConfigurations.flippy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/workstation.nix
          ./box/flippy.nix
          ./app/virtualbox.nix
          ./app/teamviewer.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/kindrobot-linux.nix
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
          ./conf/workstation.nix
          ./box/y500.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot.imports = [
              ./home/kindrobot.nix
              ./home/kindrobot-linux.nix
              ./home/email_accounts.nix
            ];
          }
        ];
      };
      darwinConfigurations.wapple = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          })
          ./conf/darwin.nix
          ./conf/darwin_link_apps.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot = {
              imports = [
                ./home/kindrobot.nix
                ./home/email_accounts.nix
                ./home/darwin_link_apps.nix
              ];
              home.stateVersion = "22.11";
            };
          }
        ];
      };
    };
}
