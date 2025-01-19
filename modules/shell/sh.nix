{ pkgs, ... }:

let
  myAliases = { };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

  home.packages = with pkgs; [
    fzf
  ];

  programs.fzf = {
    enable = true;
    # keybindings = true;
    # fuzzyCompletion = true;
  };
}
