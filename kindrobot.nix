{ config, home-manager, pkgs, ... }:
{
  home.stateVersion = "22.11";
  home.packages = [
    pkgs.barrier
    pkgs.keepassxc
    pkgs.mu
    pkgs.nextcloud-client
    pkgs.obs-studio
    pkgs.pass
    pkgs.source-code-pro
    pkgs.zoom-us
    pkgs.zsh
  ];
  home.file.".emacs.d" = {
    # don't make the directory read only so that impure melpa can still happen for now
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "1ed08595bfee63ee88dcc282767c37f34c6c911c";
      sha256 = "1dajvj3z2vpak8h4q6wzqh0p0dlsy6xhwddcq5qlkfhkrsp1h5bj";
    };
  };
  accounts.email.accounts = {
    stef = {
      primary = true;
      address = "stef@kindrobot.ca";
      realName = "Stef Dunlap";
      userName = "stef@kindrobot.ca";
      passwordCommand = "pass show muw/stef@kindrobot.ca";
      imap.host = "imap.kindrobot.ca";
      smtp.host = "smpt.kindrobot.ca";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      mu.enable = true;
    };
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
  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  # };
}

