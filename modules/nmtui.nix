{ pkgs, ... }:

{
  home.file = {
    ".local/share/applications/nmtui.desktop" = {
      text = ''
          name = "jetbrains-rider";
          desktopName = "NMTUI";
          exec = "kitty -e nmtui";
          icon = "rider";
          type = "Application";
        };
      '';
    };
  };
}
