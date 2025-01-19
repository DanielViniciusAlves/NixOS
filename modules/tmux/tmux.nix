{ pkgs, ... }:

{
    home.packages = with pkgs; [
        tmux
    ];

    programs.tmux = {
        enable = true;

        plugins = with pkgs; [
            tmuxPlugins.catppuccin
        ];
    };
}
