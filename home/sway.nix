{ config, lib, pkgs, ... }:
let
  # Catppuccin Mocha
  rosewater = "#f5e0dc";
  flamingo = "#f2cdcd";
  pink = "#f5c2e7";
  mauve = "#cba6f7";
  red = "#f38ba8";
  maroon = "#eba0ac";
  peach = "#fab387";
  yellow = "#f9e2af";
  green = "#a6e3a1";
  teal = "#94e2d5";
  sky = "#89dceb";
  sapphire = "#74c7ec";
  blue = "#89b4fa";
  lavender = "#b4befe";
  text = "#cdd6f4";
  subtext1 = "#bac2de";
  subtext0 = "#a6adc8";
  overlay2 = "#9399b2";
  overlay1 = "#7f849c";
  overlay0 = "#6c7086";
  surface2 = "#585b70";
  surface1 = "#45475a";
  surface0 = "#313244";
  base = "#1e1e2e";
  mantle = "#181825";
  crust = "#11111b";
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      workspaceAutoBackAndForth = true;
      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
      ];
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;

        in
        lib.mkOptionDefault {
          "${modifier}+p" = "exec wofi --show run";
        };
      bars = [{

        statusCommand = "${pkgs.i3status}/bin/i3status";
        trayOutput = "*";
        colors = {
          background = base;
          separator = mauve;
          focusedSeparator = mauve;
          statusline = text;
          focusedStatusline = text;
          focusedWorkspace = {
            border = base;
            background = base;
            text = pink;
          };
          activeWorkspace = {
            border = base;
            background = base;
            text = rosewater;
          };
          inactiveWorkspace = {
            border = base;
            background = base;
            text = surface1;
          };
          urgentWorkspace = {
            border = base;
            background = maroon;
            text = base;
          };
          bindingMode = {
            border = base;
            background = base;
            text = surface1;
          };
        };
      }];
      colors = {
        focused = {
          childBorder = lavender;
          background = base;
          text = text;
          indicator = rosewater;
          border = lavender;
        };
        focusedInactive = {
          childBorder = overlay0;
          background = base;
          text = text;
          indicator = rosewater;
          border = overlay0;
        };
        unfocused = {
          childBorder = overlay0;
          background = base;
          text = text;
          indicator = rosewater;
          border = overlay0;
        };
        urgent = {
          childBorder = peach;
          background = base;
          text = peach;
          indicator = overlay0;
          border = peach;
        };
        placeholder = {
          childBorder = overlay0;
          background = base;
          text = text;
          indicator = overlay0;
          border = overlay0;
        };
        background = base;
      };
    };


    extraConfig = ''
      input "type:touchpad" {
        dwt enabled
        tap enabled
        middle_emulation enabled
      }

      output eDP-1 background "${crust}" solid_color
    '';
  };
  home.packages = with pkgs; [
    bluetuith
    pulsemixer
  ];
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      color_good = green;
      color_degraded = yellow;
      color_bad = red;
      interval = 1;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = base;
          foreground = text;
          dim_foreground = subtext1;
          bright_foreground = text;
        };
        cursor = {
          text = base;
          cursor = rosewater;
        };
        vi_mode_cursor = {
          text = base;
          cursor = lavender;
        };
        search = {
          matches = {
            foreground = base;
            background = subtext0;
          };
          focused_match = {
            foreground = base;
            background = green;
          };
        };
        footer_bar = {
          foreground = base;
          background = subtext0;
        };
        hints = {
          start = {
            foreground = base;
            background = peach;
          };
          end = {
            foreground = base;
            background = subtext0;
          };
        };
        selection = {
          text = base;
          background = rosewater;
        };
        normal = {
          black = surface1;
          red = red;
          green = green;
          yellow = yellow;
          blue = blue;
          magenta = pink;
          cyan = teal;
          white = lavender;
        };
        bright = {
          black = surface2;
          red = red;
          green = green;
          yellow = yellow;
          blue = blue;
          magenta = pink;
          cyan = teal;
          white = subtext0;
        };
        dim = {
          black = surface1;
          red = red;
          green = green;
          yellow = yellow;
          blue = blue;
          magenta = pink;
          cyan = teal;
          white = lavender;
        };
        indexed_colors = [
          { index = 16; color = peach; }
          { index = 17; color = rosewater; }
        ];
      };
    };
  };
}
