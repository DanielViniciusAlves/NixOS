{ ... }:

{
  home.file = {
    ".scripts/worktree.sh".source = ./worktree.sh;
    ".zsh/completions/worktree.zsh" = {
      text = ''
        gwt() {
            bash ~/.scripts/worktree.sh
        }
      '';
    };
  };
}
