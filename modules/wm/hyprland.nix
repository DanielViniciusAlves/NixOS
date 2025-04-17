{ userSettings, pkgs, ... }:

{
  home.packages = with pkgs; [
    wofi
    font-awesome
    waybar
    hyprshot
    hyprlock
    hypridle
    hyprpaper
    swaynotificationcenter
    libnotify
  ];

  imports = [
    ./rofi/rofi.nix
    ./waybar/waybar.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$Menu" = "rofi -show drun";
      "$mod" = "SUPER";

      general = {
        layout = "dwindle";
        gaps_in = 5;
        border_size = 2;
        resize_on_border = true;
        extend_border_grab_area = 5;
        border_part_of_window = false;
        no_border_on_floating = false;
        "col.active_border" = "rgb(a89984)";
        "col.inactive_border" = "0x00000000";
      };

      windowrule = [
        "float, rofi"
        "float, blueman"
      ];

      exec-once = [
        "waybar"
        "blueman-applet"
        # "blueman-adapters"
        "hyprctl setcursor Bibata-Modern-Ice 20"
        "swaync"
        "hypridle"
        "hyprpaper"

        # Workspaces
        "hyprctl dispatch exec 'kitty --hold neofetch'"
        "hyprctl dispatch exec 'kitty pulsemixer'"
        "hyprctl dispatch exec 'kitty btm --theme gruvbox'"

        "hyprctl dispatch exec \"[workspace 2 silent] kitty --hold zsh -c 'lua /home/${userSettings.username}/.scripts/session.lua -l'\""

        "hyprctl dispatch exec '[workspace 3 silent] brave'"

        # "hyprctl dispatch exec '[workspace 5 silent] mongodb-compass'"
      ];

      bindle = [
        ",XF86AudioRaiseVolume,  exec, pulsemixer --change-volume +5"
        ",XF86AudioLowerVolume,  exec, pulsemixer --change-volume -5"
        ",XF86AudioMute,        exec, pulsemixer --toggle-mute"
      ];

      bindl = [
        ",XF86AudioPlay,    exec, playerctl play-pause"
        ",XF86AudioStop,    exec, playerctl pause"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        [
          # System bindings
          "$mod, w, exec, brave"
          "$mod, return, exec, $terminal"
          "$mod, d, exec, $Menu"
          "$mod, e, exec, rofi -show run"
          "$mod, q, killactive"
          "$mod SHIFT, e, exit"
          "$mod, o, togglefloating"
          "$mod, f, exec, $fileManager"

          # Audio bindings
          "$mod, v, exec, kitty -e pulsemixer"

          # Switch focus
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"

          # Move window position
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, l, movewindow, r"

          # Resize window
          "$mod CTRL, up, resizeactive, 0 -80"
          "$mod CTRL, down, resizeactive, 0 80"
          "$mod CTRL, left, resizeactive, -80 0"
          "$mod CTRL, right, resizeactive, 80 0"

          # Screenshot
          ",Print, exec, hyprshot -m region"
          "$mod, Print, exec, hyprshot -m window"

          # Lock screen
          "$mod CTRL, m, exec, hyprlock"

        ]
        ++ (
          builtins.concatLists (builtins.genList
            (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      decoration = {
        rounding = 0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;

          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      monitor = [
        "HDMI-A-1,1920x1080,0x0,1"
        "DP-1,1920x1080,0x0,1"
        "eDP-1,1920x1200,320x1080,1"
      ];

    };
    extraConfig = "
        workspace=1,monitor:eDP-1
        workspace=2,monitor:HDMI-A-1
        workspace=3,monitor:HDMI-A-1
        workspace=4,monitor:HDMI-A-1
        workspace=5,monitor:HDMI-A-1
    ";
  };
}

