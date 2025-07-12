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
      ../../modules/network/network.nix
    ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    lazygit
    xorg.xev
    htop
    bottom
    neofetch
    obsidian

    # Audio
    pulsemixer
    blueman
    playerctl

    # File manager
    nautilus

    # Browser
    brave

    # Network
    networkmanagerapplet

    # Languages
    lua
    jdk21
    maven
    nodejs_24
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
