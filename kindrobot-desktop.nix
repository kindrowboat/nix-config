{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.kindrobot = {
    home.packages = [
      pkgs.zsh
      pkgs.mu
      pkgs.source-code-pro
      pkgs.pass
      pkgs.barrier
      pkgs.keepassxc
      pkgs.nextcloud-client
      pkgs.obs-studio
      pkgs.zoom-us
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
  };
}
