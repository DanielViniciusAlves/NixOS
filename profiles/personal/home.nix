{ config, pkgs, ... }:

{
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd

  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

    programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      sumneko-lua-language-server
	  nil

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = catppuccin-nvim;
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
        plugin = oil-nvim;
        config = toLua "require(\"oil\").setup()";
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
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

    ];

    extraLuaConfig = ''
      ${builtins.readFile ../../modules/nvim/keymap.lua}
      ${builtins.readFile ../../modules/nvim/option.lua}
      ${builtins.readFile ../../modules/nvim/test.lua}
      ${builtins.readFile ../../modules/nvim/plugin/telescope/keymap.lua}
      ${builtins.readFile ../../modules/nvim/plugin/trouble.lua}
      ${builtins.readFile ../../modules/nvim/plugin/harpoon.lua}
      ${builtins.readFile ../../modules/nvim/plugin/plugins.lua}
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
