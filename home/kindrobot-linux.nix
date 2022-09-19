{ config, home-manager, pkgs, ... }:
{
  home.packages = [
    pkgs.barrier
    pkgs.keepassxc
    pkgs.libreoffice
    pkgs.mgba
    pkgs.nextcloud-client
    pkgs.obs-studio
    pkgs.slack
    pkgs.source-code-pro
    pkgs.zoom-us
    pkgs.zsh
  ];

  services.emacs.enable = true;
}
