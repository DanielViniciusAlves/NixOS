{ ... }:

{
  home.file = {
    ".scripts/session.lua".source = ./session.lua;
    ".zsh/completions/session.zsh" = {
      text = ''
        session() {
          lua ~/.scripts/session.lua "$@"
        }

        _lua_session_completions() {
          local -a completions
          completions=(
            "-load"
            "-new"
            "-stop"
            "-remove"
            "-create")

          _describe 'completions' completions 
        }

        compdef _lua_session_completions session
      '';
    };
  };
}
