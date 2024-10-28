{ config, pkgs, ... }:
let
  pname = "cursor";
  version = "0.42.3";
  appKey = "230313mzl4w4u92";
  buildKey = "2409052yfcjagw2";
in {
  home.packages = with pkgs; [
    appimage-run
    (pkgs.appimageTools.wrapType2 {
      name = "cursor";
      src = pkgs.fetchurl {
        url = "https://lesbians.kindrobot.ca/~kindrobot/cursor/cursor-0.42.3x86_64.AppImage";
        hash = "sha256-GWkilBlpXube//jbxRjmKJjYcmB42nhMY8K0OgkvtwA=";
      };
    })
  ];
}

