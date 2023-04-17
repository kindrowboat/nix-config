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
  services.tumbler.enable = true;
  # services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.kindrobot.enableGnomeKeyring = true;
  programs.gnupg.agent.pinentryFlavor = "qt";
  environment.systemPackages = with pkgs; [
    acpi
    arandr
    arc-icon-theme
    blueberry
    clipmenu
    dmenu
    emojipick
    gcr
    gnome.gnome-keyring
    haskellPackages.greenclip
    i3lock-fancy-rapid
    mpc-cli
    mpd
    networkmanagerapplet
    pasystray
    pavucontrol
    picom
    pinentry-qt
    rofi
    scrot
    spectacle
    unclutter
    xclip
    xfce.ristretto
    xfce.xfce4-terminal
    xsel
    zathura
  ];
}
