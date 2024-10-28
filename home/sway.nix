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
  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = ["Fantasque Sans Mono"];
  };

  home.sessionVariables = {
    SWAY_SCREENSHOT_DIR = "$HOME/Pictures";
  };
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      workspaceAutoBackAndForth = true;
      #fonts = {
      #  names = [ "Fantasque Sans Mono" ];
      #  size = 20.0;
      #};
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;

        in
        lib.mkOptionDefault {
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+p" = "exec wofi --show run";
          "${modifier}+Period" = "exec wofi-emoji";
          "${modifier}+v" = "exec copyq menu";
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
        {command = "copyq";}
      ];
    };

    extraConfig = ''
      input "type:touchpad" {
        dwt enabled
        tap enabled
        middle_emulation enabled
      }

      for_window [ app_id="copyq" ] floating enable
      for_window [title="^Meet - .*"] floating enable, sticky enable, resize set width 250 px
      exec --no-startup-id gnome-keyring-daemon --start --components=secrets,ssh
      output eDP-1 background "${crust}" solid_color
      workspace_layout tabbed
      assign [app_id="vivaldi"] workspace 3
      assign [app_id="Slack"] workspace 4
      assign [app_id="chromium"] workspace 5
      exec vivaldi
      exec slack
      exec chromium
      workspace 2
      exec alacritty
      exec sleep 5 && nextcloud
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 30;  # Waybar height (to be removed for auto height)
        spacing = 4;  # Gaps between modules (4px)

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/scratchpad"
          "custom/media"
        ];

        modules-center = [
          "sway/window"
        ];

        modules-right = [
          "mpd"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "sway/language"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
        ];

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "sway/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = [ "" "" ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 5;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format= "{:%c}";
          interval = 1;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        "battery#bat2" = {
          bat = "BAT2";
        };

        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        custom = {
          media = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
          };
        };
      };
    };
    style =
      ''
        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, Fantasque Sans Mono, Helvetica, Arial, sans-serif;
            font-size: 16px;
        }

        window#waybar {
            background-color: ${surface0};
            border-bottom: 3px solid ${pink};
            color: ${text};
            transition-property: background-color;
            transition-duration: .5s;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        window#waybar.termite {
            background-color: ${overlay0};
        }

        window#waybar.chromium {
            background-color: ${text};
            border: none;
        }

        button {
            box-shadow: inset 0 -3px transparent;
            border: none;
            border-radius: 0;
        }

        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px ${pink};
        }

        #pulseaudio:hover {
            background-color: ${overlay0};
        }

        #workspaces button {
            padding: 0 5px;
            background-color: transparent;
            color: ${text};
        }

        #workspaces button:hover {
            background: ${overlay2};
        }

        #workspaces button.focused {
            background-color: ${surface1};
            box-shadow: inset 0 -3px ${lavender};
        }

        #workspaces button.urgent {
            background-color: ${red};
        }

        #mode {
            background-color: ${overlay1};
            box-shadow: inset 0 -3px ${text};
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
            color: ${text};
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            background-color: ${surface1};
        }

        #battery {
            background-color: ${sky};
            color: ${crust};
        }

        #battery.charging, #battery.plugged {
            background-color: ${green};
            color: ${crust};
        }

        @keyframes blink {
            to {
                background-color: ${text};
                color: ${crust};
            }
        }

        #battery.critical:not(.charging) {
            background-color: ${red};
            color: ${crust};
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
            background-color: ${red};
            color: ${crust};
        }

        #power-profiles-daemon.balanced {
            background-color: ${blue};
            color: ${crust};
        }

        #power-profiles-daemon.power-saver {
            background-color: ${green};
            color: ${crust};
        }

        label:focus {
            background-color: ${mantle};
        }

        #cpu {
            background-color: ${green};
            color: ${crust};
        }

        #memory {
            background-color: ${mauve};
            color: ${crust};
        }

        #disk {
            background-color: ${lavender};
            color: ${crust};
        }

        #backlight {
            background-color: ${blue};
            color: ${crust};
        }

        #network {
            background-color: ${peach};
            color: ${crust};
        }

        #network.disconnected {
            background-color: ${red};
        }

        #pulseaudio {
            background-color: ${yellow};
            color: ${crust};
        }

        #pulseaudio.muted {
            background-color: ${red};
            color: ${crust};
        }

        #wireplumber {
            background-color: ${maroon};
            color: ${crust};
        }

        #wireplumber.muted {
            background-color: ${red};
        }

        #custom-media {
            background-color: ${green};
            color: ${crust};
            min-width: 100px;
        }

        #custom-media.custom-spotify {
            background-color: ${green};
        }

        #custom-media.custom-vlc {
            background-color: ${peach};
        }

        #temperature {
            background-color: ${peach};
            color: ${crust};
        }

        #temperature.critical {
            background-color: ${red};
        }

        #tray {
            background-color: ${pink};
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: ${red};
        }

        #idle_inhibitor {
            background-color: ${green};
            color: ${crust};

        }

        #idle_inhibitor.activated {
            background-color: ${red};
            color: ${crust};
        }

        #mpd {
            background-color: ${teal};
            color: ${crust};
        }

        #mpd.disconnected {
            background-color: ${red};
        }

        #mpd.stopped {
            background-color: ${red};
        }

        #mpd.paused {
            background-color: ${teal};
        }

        #language {
            background: ${rosewater};
            color: ${crust};
            padding: 0 5px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state {
            background: ${green};
            color: ${crust};
            padding: 0;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state > label {
            padding: 0 5px;
        }

        #keyboard-state > label.locked {
            background: ${overlay2};
        }

        #scratchpad {
            background: ${overlay2};
        }

        #scratchpad.empty {
          background-color: transparent;
        }

        #privacy {
            padding: 0;
        }

        #privacy-item {
            padding: 0 5px;
            color: ${text};
        }

        #privacy-item.screenshare {
            background-color: ${peach};
        }

        #privacy-item.audio-in {
            background-color: ${green};
        }

        #privacy-item.audio-out {
            background-color: ${blue};
      }
    '';
  };

  home.packages = with pkgs; [
    bluetuith
    pulsemixer
    gnome.nautilus
    wofi-emoji
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      # colors = {
      #   primary = {
      #     background = base;
      #     foreground = text;
      #     dim_foreground = subtext1;
      #     bright_foreground = text;
      #   };
      #   cursor = {
      #     text = base;
      #     cursor = rosewater;
      #   };
      #   vi_mode_cursor = {
      #     text = base;
      #     cursor = lavender;
      #   };
      #   search = {
      #     matches = {
      #       foreground = base;
      #       background = subtext0;
      #     };
      #     focused_match = {
      #       foreground = base;
      #       background = green;
      #     };
      #   };
      #   footer_bar = {
      #     foreground = base;
      #     background = subtext0;
      #   };
      #   hints = {
      #     start = {
      #       foreground = base;
      #       background = peach;
      #     };
      #     end = {
      #       foreground = base;
      #       background = subtext0;
      #     };
      #   };
      #   selection = {
      #     text = base;
      #     background = rosewater;
      #   };
      #   normal = {
      #     black = surface1;
      #     red = red;
      #     green = green;
      #     yellow = yellow;
      #     blue = blue;
      #     magenta = pink;
      #     cyan = teal;
      #     white = lavender;
      #   };
      #   bright = {
      #     black = surface2;
      #     red = red;
      #     green = green;
      #     yellow = yellow;
      #     blue = blue;
      #     magenta = pink;
      #     cyan = teal;
      #     white = subtext0;
      #   };
      #   dim = {
      #     black = surface1;
      #     red = red;
      #     green = green;
      #     yellow = yellow;
      #     blue = blue;
      #     magenta = pink;
      #     cyan = teal;
      #     white = lavender;
      #   };
      #   indexed_colors = [
      #     { index = 16; color = peach; }
      #     { index = 17; color = rosewater; }
      #   ];
      # };
    };
  };

  programs.wofi = {
    enable = true;
    style = ''
      * {
        font-family: 'Inconsolata Nerd Font', monospace;
        font-size: 16px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;
        border: 0.16em solid ${lavender};
        border-radius: 0.1em;
        background-color: ${base};
        animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
          opacity: 0;
        }

        100% {
          opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: ${base};
        animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
          opacity: 0;
        }

        100% {
          opacity: 1;
        }
      }

      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: ${base};
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: ${base};
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: none;
        border-radius: 0.1em;
        color: ${text};
        background-color: ${base};
        animation: fadeIn 0.5s ease-in-out both;
      }

      #input image {
          border: none;
          color: ${red};
      }

      #input * {
        outline: 4px solid ${red}!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: ${text};
        animation: fadeIn 0.5s ease-in-out both;
      }

      #entry {
        background-color: ${base};
      }

      #entry arrow {
        border: none;
        color: ${lavender};
      }

      /* Selected Entry */
      #entry:selected {
        border: 0.11em solid ${lavender};
      }

      #entry:selected #text {
        color: ${mauve};
      }

      #entry:drop(active) {
        background-color: ${lavender}!important;
      }
      '';
    };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  # notifications
  services.mako = {
    enable = true;
    defaultTimeout = 10000;
  };

}
