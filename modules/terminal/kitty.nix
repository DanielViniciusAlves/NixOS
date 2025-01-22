{ ... }:

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
      background_opacity = "0.5";
      window_padding_width = 5;
      mouse_hide_wait = "-1.0";
      shell_integration = "no-cursor";
    };
  };
}
