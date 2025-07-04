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

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    lazygit
    lua
    xorg.xev
    htop

    # Fonts
    cascadia-code

    # Ollama
    ollama
    open-webui
  ];

  services.ollama = {
    enable = true;
    loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b" ];
  };

  services.open-webui = {
    enable = true;
  };

  fonts.fontconfig.enable = true;
  programs.bottom.enable = true;

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  nixpkgs.config.allowUnfree = true;
}
