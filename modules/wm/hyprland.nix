{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    cursor_shape = "block";
    enable_audio_bell = false;
    extraConfig = ''
      input {
          kb_layout = br
          kb_variant = nodeadkeys
          kb_model =
          kb_rules =
          follow_mouse = 1
          accel_profile = flat
          force_no_accel = true
          touchpad {
              natural_scroll = no
          }
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
    '';
  };
}
