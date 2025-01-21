{ ... }:

{
  home.file = {
    ".scripts/biptt_db.lua".source = ./biptt_db.lua;
    ".zsh/completions/biptt_db.zsh" = {
      text = ''
        biptt_db() {
          lua ~/.scripts/biptt_db.lua "$@"
        }

        _lua_biptt_db_completions() {
          local -a completions
          completions=(
            "start"
            "stop"
          )

          _describe 'completions' completions 
        }

        compdef _lua_biptt_db_completions biptt_db
      '';
    };
  };
}

