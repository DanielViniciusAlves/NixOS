{ userSettings, ... }:

{
  home.file = {
    ".local/share/applications/session.desktop" = {
      text = ''
        [Desktop Entry]
        Encoding=UTF-8
        Version=1.0
        Type=Application
        Exec=kitty --hold zsh -c 'lua /home/${userSettings.username}/.scripts/session.lua -l'
        Name=Session
        Icon=terminal
      '';
    };

  };
}
