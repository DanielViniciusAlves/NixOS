{ pkgs, ... }:

let
  myAliases = { };
in
{
  imports = [
    ../../scripts/session/session.nix
    ../../scripts/worktree/worktree.nix
  ];

  home.packages = with pkgs; [
    fzf
    screen
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab.plugin.zsh";
      }

      {
        name = "zsh-git-prompt";
        src = pkgs.zsh-git-prompt;
        file = "share/zsh-git-prompt/zshrc.sh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "mix" "fzf" ];
    };

    initExtra = ''
      PROMPT="%U%F{33}%n%f%u@%U%F{195}%m%f%u %F{6}✘  %F{195}%~%f
      %F{33}→%f "

      RPROMPT='$(git_super_status)'

      source "$HOME/.zsh/plugins/zsh-fzf-tab/share/fzf-tab/fzf-tab.plugin.zsh"
      source "$HOME/.zsh/completions/session.zsh"
      source "$HOME/.zsh/completions/worktree.zsh"

      bindkey '^N' up-line-or-search
      bindkey '^P' down-line-or-search
    '';
  };

  home.file = { };

  programs.fzf = {
    enable = true;
    # keybindings = true;
    # fuzzyCompletion = true;
  };
}
