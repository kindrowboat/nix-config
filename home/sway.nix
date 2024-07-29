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
  home.sessionVariables = {
    SWAY_SCREENSHOT_DIR = "$HOME/Pictures";
  };
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      workspaceAutoBackAndForth = true;
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;

        in
        lib.mkOptionDefault {
          "${modifier}+p" = "exec wofi --show run";
          "XF86AudioRaiseVolume" = "exec pulsemixer --change-volume +10";
          "XF86AudioLowerVolume" = "exec pulsemixer --change-volume -10";
          "XF86AudioMute" = "exec pulsemixer --toggle-mute";
	  "XF86MonBrightnessUp" = "exec light -A 5";
	  "XF86MonBrightnessDown" = "exec light -U 5";
	  "${modifier}+Print" = "exec sway-screenshot -m window";
	  "Print" = "exec sway-screenshot -m output";
          "${modifier}+Shift+Print" = "exec sway-screenshot -m region";
        };
      output = {
        eDP-1 = {
          scale = "1.5";
        };
      };
      bars = [];
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
      startup = [
        {command = "waybar";}
      ];
    };

    extraConfig = ''
      input "type:touchpad" {
        dwt enabled
        tap enabled
        middle_emulation enabled
      }

      bindsym Mod1+Tab workspace back_and_forth
      output eDP-1 background "${crust}" solid_color
    '';
  };

  programs.waybar = {
    enable = true;
    style = ''
    * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
    }

    window#waybar {
        background-color: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
    }

    window#waybar.hidden {
        opacity: 0.2;
    }

    /*
    window#waybar.empty {
        background-color: transparent;
    }
    window#waybar.solo {
        background-color: #FFFFFF;
    }
    */

    window#waybar.termite {
        background-color: #3F3F3F;
    }

    window#waybar.chromium {
        background-color: #000000;
        border: none;
    }

    button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each button name */
        border: none;
        border-radius: 0;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #ffffff;
    }

    /* you can set a style on hover for any module like this */
    #pulseaudio:hover {
        background-color: #a37800;
    }

    #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
    }

    #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
    }

    #workspaces button.focused {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button.urgent {
        background-color: #eb4d4b;
    }

    #mode {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #wireplumber,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #scratchpad,
    #power-profiles-daemon,
    #mpd {
        padding: 0 10px;
        color: #ffffff;
    }

    #window,
    #workspaces {
        margin: 0 4px;
    }

    /* If workspaces is the leftmost module, omit left margin */
    .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
    }

    /* If workspaces is the rightmost module, omit right margin */
    .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
    }

    #clock {
        background-color: #64727D;
    }

    #battery {
        background-color: #ffffff;
        color: #000000;
    }

    #battery.charging, #battery.plugged {
        color: #ffffff;
        background-color: #26A65B;
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }

    /* Using steps() instead of linear as a timing function to limit cpu usage */
    #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #power-profiles-daemon {
        padding-right: 15px;
    }

    #power-profiles-daemon.performance {
        background-color: #f53c3c;
        color: #ffffff;
    }

    #power-profiles-daemon.balanced {
        background-color: #2980b9;
        color: #ffffff;
    }

    #power-profiles-daemon.power-saver {
        background-color: #2ecc71;
        color: #000000;
    }

    label:focus {
        background-color: #000000;
    }

    #cpu {
        background-color: #2ecc71;
        color: #000000;
    }

    #memory {
        background-color: #9b59b6;
    }

    #disk {
        background-color: #964B00;
    }

    #backlight {
        background-color: #90b1b1;
    }

    #network {
        background-color: #2980b9;
    }

    #network.disconnected {
        background-color: #f53c3c;
    }

    #pulseaudio {
        background-color: #f1c40f;
        color: #000000;
    }

    #pulseaudio.muted {
        background-color: #90b1b1;
        color: #2a5c45;
    }

    #wireplumber {
        background-color: #fff0f5;
        color: #000000;
    }

    #wireplumber.muted {
        background-color: #f53c3c;
    }

    #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
    }

    #custom-media.custom-spotify {
        background-color: #66cc99;
    }

    #custom-media.custom-vlc {
        background-color: #ffa000;
    }

    #temperature {
        background-color: #f0932b;
    }

    #temperature.critical {
        background-color: #eb4d4b;
    }

    #tray {
        background-color: #2980b9;
    }

    #tray > .passive {
        -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
    }

    #idle_inhibitor {
        background-color: #2d3436;
    }

    #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
    }

    #mpd {
        background-color: #66cc99;
        color: #2a5c45;
    }

    #mpd.disconnected {
        background-color: #f53c3c;
    }

    #mpd.stopped {
        background-color: #90b1b1;
    }

    #mpd.paused {
        background-color: #51a37a;
    }

    #language {
        background: #00b093;
        color: #740864;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
    }

    #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
    }

    #keyboard-state > label {
        padding: 0 5px;
    }

    #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
    }

    #scratchpad {
        background: rgba(0, 0, 0, 0.2);
    }

    #scratchpad.empty {
      background-color: transparent;
    }

    #privacy {
        padding: 0;
    }

    #privacy-item {
        padding: 0 5px;
        color: white;
    }

    #privacy-item.screenshare {
        background-color: #cf5700;
    }

    #privacy-item.audio-in {
        background-color: #1ca000;
    }

    #privacy-item.audio-out {
        background-color: #0069d4;
    }
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

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

}
