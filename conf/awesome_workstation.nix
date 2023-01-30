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
  services.xserver.dpi = 180;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  programs.slock.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    mpc-cli
    mpd
    scrot
    unclutter
    xsel
  ];
}
