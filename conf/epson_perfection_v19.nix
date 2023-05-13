{ config, lib, pkgs, ... }:

{
  hardware.sane.enable = true;
  users.users.kindrobot.extraGroups = [ "scanner" "lp" ];
  hardware.sane.extraBackends = [ pkgs.epkowa ];
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };
  environment.systemPackages = with pkgs; [
    xsane
  ];
}
