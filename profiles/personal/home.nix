{ pkgs, userSettings, ... }:

{
  imports =
    [
      ../../modules/nvim/nvim.nix
      ../../modules/tmux/tmux.nix
      ../../modules/shell/sh.nix
      ../../modules/terminal/kitty.nix
      ../../modules/wm/hyprland.nix
      ../../modules/gtk/gtk.nix
      ../../modules/nmtui.nix
    ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    lazygit
    cloudflared
    lua
    xorg.xev
    htop
    mongodb-compass
    bottom
    neofetch

    # Audio
    pulsemixer
    blueman
    playerctl

    # File manager
    nautilus
    yazi

    # Browser
    brave

    # Network
    networkmanagerapplet
  ];

  services.mpris-proxy.enable = true;
  programs.bottom.enable = true;

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "vim";
    DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
  };

  nixpkgs.config.allowUnfree = true;
}
