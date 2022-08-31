{
  description = "";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; 
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-doom-emacs }:
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
          ./configuration.nix
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kindrobot = import ./kindrobot.nix;
	  }
        ];
      };
    };
}
