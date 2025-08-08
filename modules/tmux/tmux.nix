{ pkgs, userSettings, ... }:

{
  home.sessionVariables = {
    TMUXINATOR_CONFIG = "/home/" + userSettings.username + "/.dotfiles/NixOS/scripts/session/templates";
  };

  home.packages = with pkgs; [
    tmux
    tmuxinator
  ];

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;

    plugins = with pkgs; [
      tmuxPlugins.gruvbox
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];

    extraConfig = ''
      setw -g mouse on

      bind v copy-mode

      setw -g mode-keys vi

      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection

      unbind %
      bind [ split-window -h -c "#{pane_current_path}"

      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind c new-window -c "#{pane_current_path}"

      bind q killp
      bind Q confirm-before -p "Deseja realmente matar a sessão?" kill-session

      bind n next-window
      bind p previous-window

      # Move to the window with the name "git"
      bind g select-window -t git

      bind -r m resize-pane -Z

      bind o set-option -g status
    '';
  };
}
