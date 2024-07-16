{ hdpi ? false }: { config, lib, pkgs, ...}:
let
  hdpiBlurb = if hdpi then
    ''
    export GDK_SCALE="2"
    export GDK_DPI_SCALE="0.5"
    export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2"
    ''
  else
    "";
in
{
  home.file.xinitrc = {
    target = ".xinitrc";
    text = ''
      eval $(gnome-keyring-daemon --start --components=pkcs11,secrets)
      dbus-update-activation-environment --systemd DISPLAY
      ${hdpiBlurb}
      picom &
      greenclip daemon &
      pasystray &
      nm-applet &
      blueberry-tray &
      sleep 5 && ${pkgs.kdeconnect}/libexec/kdeconnectd &
      sleep 6 && kdeconnect-indicator &
      sleep 10 && nextcloud &

      exec awesome
    '';
  };
  home.packages = with pkgs; [
    rofi-systemd
    rofi-emoji
    rofi-file-browser
    rofi-calc
  ];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override { plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-file-browser
      pkgs.rofi-systemd
      pkgs.rofi-calc
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
