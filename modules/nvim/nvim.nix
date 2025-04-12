{ config, pkgs, userSettings, ... }:

let
    # toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
    {

    home.packages = with pkgs; [
        # Sytem packages
        ripgrep
        xclip
        wl-clipboard
        fd

        # LSP packages
        sumneko-lua-language-server
        elixir-ls
        nixpkgs-fmt
        nil
    ];

    programs.neovim = 
        {
            enable = true;

            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;

            plugins = with pkgs.vimPlugins; [
                {
                    plugin = gruvbox-nvim;
                    config = toLuaFile ../../modules/nvim/plugin/color.lua;
                }

                {
                    plugin = telescope-nvim;
                    config = toLuaFile ../../modules/nvim/plugin/telescope/config.lua;
                }

                {
                    plugin = nvim-lspconfig;
                    config = toLuaFile ../../modules/nvim/plugin/lsp.lua;
                }

                {
                    plugin = nvim-cmp;
                    config = toLuaFile ../../modules/nvim/plugin/cmp.lua;
                }

                {
                    plugin = (nvim-treesitter.withPlugins (p: [
                        p.tree-sitter-nix
                        p.tree-sitter-vim
                        p.tree-sitter-bash
                        p.tree-sitter-lua
                        p.tree-sitter-json
                        p.tree-sitter-elixir
                    ]));
                    config = toLuaFile ../../modules/nvim/plugin/treesitter.lua;
                }

                cmp_luasnip
                cmp-nvim-lsp
                luasnip
                nvim-cmp 
                neodev-nvim
                nvim-web-devicons
                comment-nvim
                plenary-nvim
                copilot-vim
                mini-icons
                marks-nvim
                undotree
                harpoon2
                lspkind-nvim
                trouble-nvim
                vim-tmux-navigator
                oil-nvim
                transparent-nvim
            ];

            extraLuaConfig = ''
                ${builtins.readFile ./keymap.lua}
                ${builtins.readFile ./option.lua}
                ${builtins.readFile ./test.lua}
                ${builtins.readFile ./plugin/telescope/keymap.lua}
                ${builtins.readFile ./plugin/trouble.lua}
                ${builtins.readFile ./plugin/harpoon.lua}
                ${builtins.readFile ./plugin/plugins.lua}
            '';
        };
}
