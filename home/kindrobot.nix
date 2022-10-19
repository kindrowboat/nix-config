{ config, home-manager, pkgs, ... }:
{
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    age
    htop
    krita
    mosh
    neovim
    pass
    silver-searcher
    prusa-slicer
    tmux
    vscode
    wget
  ];
  home.file.doom-d = {
    source = ./doom.d;
    target = ".doom.d";
  };
  home.sessionPath = [ "$HOME/bin" ];
  home.file.bin = {
    source = ./bin;
  };
  programs.direnv.enable = true;
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
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      pkgs.mu
    ];
  };
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

