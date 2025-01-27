{ ... }:

{
  programs.kitty = {
    themeFile = "gruvbox-dark-hard";
    font = {
      name = "Monaspace Argon";
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
      cursor_shape = "block";
      enable_audio_bell = false;
      background_opacity = "0.85";
      window_padding_width = 5;
      mouse_hide_wait = "-1.0";
      shell_integration = "no-cursor";
    };
  };
}
