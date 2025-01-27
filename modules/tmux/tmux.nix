{ pkgs, userSettings, ... }:

{
  home.sessionVariables = {
    TMUXINATOR_CONFIG = "/home/" + userSettings.username + "/.dotfiles/scripts/session/templates";
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

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind u new-window 'yazi'

      # bind t display-popup -E "tmux new-session -s temp-terminal -A"
      bind e display-popup -E "tmux new-session -s worktree -A 'bash ~/.scripts/worktree.sh'"
      bind g display-popup -E "tmux new-session -s temp-git -A 'lazygit'"

      # bind b display-popup -E "tmux new-session -s temp-git -A 'lua ~/.scripts/session.lua -l'"

      bind -r m resize-pane -Z

      bind o set-option -g status
    '';
  };
}
