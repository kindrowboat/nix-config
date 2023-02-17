{ config, lib, pkgs, ... }:

{
  home.file.xinitrc = {
    target = ".xinitrc";
    text = ''
      picom &
      greenclip daemon &
      pasystray &
      nm-applet &
      blueberry-tray &
      sleep 5 && ${pkgs.kdeconnect}/libexec/kdeconnectd &
      sleep 6 && kdeconnect-indicator &
      sleep 10 && nextcloud &

      awesome
    '';
  };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override { plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-file-browser
    ]; };
    font = "Fantasque Sans Mono 20";
    extraConfig = {
      modi = "drun,emoji";
    };
  };
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
	"image/png" = [ "org.xfce.ristretto.desktop" ];
	"image/gif" = [ "org.xfce.ristretto.desktop" ];
	"image/jpeg" = [ "org.xfce.ristretto.desktop" ];
	"image/svg+xml" = [ "org.xfce.ristretto.desktop" ];
	"application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}
