{ pkgs, userSettings, ... }:

{
  imports =
    [
      ../../modules/nvim/nvim.nix
      ../../modules/tmux/tmux.nix
      ../../modules/shell/sh.nix
    ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  nixpkgs.config.allowUnfree = true;
}
