{ pkgs, ... }:

{
  programs.kitty = {
    themeFile = "gruvbox-dark-hard";
    font = {
      name = "Monaspace Argon";
      size = 12;
    };
    settings = {
      cursor_shape = "block";
      enable_audio_bell = false;
    };
  };
}
