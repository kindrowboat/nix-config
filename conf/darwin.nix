{ config, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
      pkgs.alacritty
      pkgs.neovim
      pkgs.vim
      pkgs.gnupg
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc
    registry.nixpkgs.flake = inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    extraOptions = ''
      extra-platforms = aarch64-darwin
      experimental-features = nix-command flakes
    '';
  };

  # For home-manager to work.
  users.users.kindrobot.name = "kindrobot";
  users.users.kindrobot.home = "/Users/kindrobot"; 

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
