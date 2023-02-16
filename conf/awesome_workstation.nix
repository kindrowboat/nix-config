{ config, pkgs, ... }:

{
  imports = [./workstation.nix];
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks # is the package manager for Lua modules
      luadbi-mysql # Database abstraction layer
    ];
  };
  programs.gnupg.agent.pinentryFlavor = "qt";
  programs.slock.enable = true;
  environment.systemPackages = with pkgs; [
    acpi
    arandr
    arc-icon-theme
    blueberry
    clipmenu
    dmenu
    emojipick
    mpc-cli
    mpd
    networkmanagerapplet
    pasystray
    pinentry-qt
    scrot
    spectacle
    unclutter
    xclip
    xsel
  ];
}
