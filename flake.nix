{
  description = "";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; 
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      };
    in {
      nixosConfigurations.flippy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ config, pkgs, ... }: { 
            nixpkgs.overlays = [ overlay-unstable ];
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
              ./home/email_accounts.nix
            ];
          }
        ];
      };
    };
}
