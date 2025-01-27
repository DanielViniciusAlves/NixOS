{ userSettings, ... }:

let
  directory = "/home/" + userSettings.username + "/.wallpapers";
in
{
  home.file = {
    "${directory}/gruvbox.jpg".source = ./wallpapers/gruvbox.jpg;
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "${directory}/gruvbox.jpg" ];

      wallpaper = [
        ",${directory}/gruvbox.jpg"
      ];
    };
  };
}
