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
