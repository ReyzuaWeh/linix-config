{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    configure = {
      customLuaRC = ''
        	${builtins.readFile ./nvim/init.lua}
        	${builtins.readFile ./nvim/treesitter.lua}
        	'';
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          kanagawa-nvim
          conform-nvim
          neo-tree-nvim
          plenary-nvim
          nui-nvim
          nvim-web-devicons
          lazygit-nvim
          toggleterm-nvim
          multicursor-nvim
          nvim-lsp-file-operations
          inc-rename-nvim
          nvim-treesitter
          telescope-nvim
          nvim-autopairs
        ];
        # manually loadable by calling `:packadd $plugin-name`
      };
    };
  };
  # environment.etc."xdg/nvim/init.lua".source = ./nvim/init.lua;
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt
    #vimPlugins.nvim-lspconfig
    #vimPlugins.lazydev-nvim
    lua-language-server
    lazygit
  ];
}
