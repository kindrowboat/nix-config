{ config, lib, pkgs, ... }:

{
  home.file.xinitrc = {
    target = ".xinitrc";
    text = ''
      clipmenud &
      pasystray &
      nm-applet &
      blueberry-tray &
      sleep 5 && ${pkgs.kdeconnect}/libexec/kdeconnectd &
      sleep 6 && kdeconnect-indicator &
      sleep 10 && nextcloud &

      awesome
    '';
  };
}
