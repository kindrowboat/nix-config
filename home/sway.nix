{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty"; 
      workspaceAutoBackAndForth = true;
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+p" = "exec wofi --show run";
      };
      bars = [{
	statusCommand = "${pkgs.i3status}/bin/i3status";
        trayOutput = "*";

      }];
    };
    extraConfig = ''
      input "type:touchpad" {
        dwt enabled
	tap enabled
	middle_emulation enabled
      }
    '';
  };
  home.packages = with pkgs; [
    bluetuith
    pulsemixer
  ];
  #programs.waybar.enable = true;
}
