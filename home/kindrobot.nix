{ config, home-manager, pkgs, ... }:
{
  home.stateVersion = "22.11";
  home.packages = [
    pkgs.age
    pkgs.htop
    pkgs.mosh
    pkgs.mu
    pkgs.neovim
    pkgs.pass
    pkgs.silver-searcher
    pkgs.tmux
    pkgs.wget
  ];
  home.file.doom-d = {
    source = ./doom.d;
    target = ".doom.d";
  };
  programs.git = {
    enable = true;
    userName = "Stef Dunlap";
    userEmail = "stef@kindrobot.ca";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;
  programs.command-not-found.enable = false;
  programs.fish.enable = true;
  programs.nix-index.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.75;
    };
  };
  programs.z-lua.enable = true;
}

