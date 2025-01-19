{ pkgs, ... }:

let
  myAliases = { };
in
{
  home.packages = with pkgs; [
    fzf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-git-prompt";
        src = pkgs.zsh-git-prompt;
        file = "share/zsh-git-prompt/zshrc.sh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "" ];
    };

    initExtra = ''
      PROMPT="%U%F{33}%n%f%u@%U%F{4}%m%f%u %F{6}✘  %F{195}%~%f
      %F{33}→%f "

      RPROMPT='$(git_super_status)'

      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward
    '';

  };

  home.file = { };

  programs.fzf = {
    enable = true;
    # keybindings = true;
    # fuzzyCompletion = true;
  };
}
