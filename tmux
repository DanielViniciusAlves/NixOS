set-option -g prefix C-a
unbind C-b
bind-key C-b send-prefix

set -g base-index 1
setw -g pane-base-index 1

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

bind g select-window -t git

bind -r m resize-pane -Z

bind o set-option -g status

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

set -g @plugin 'egel/tmux-gruvbox'
set -g @tmux-gruvbox 'dark'

set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'NHDaly/tmux-better-mouse-mode'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
set-environment -g TMUX_PLUGIN_MANAGER_PATH '~/.tmux/plugins/'
run '~/.tmux/plugins/tpm/tpm'
