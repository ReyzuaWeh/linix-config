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
package.path = package.path
  .. ";${./nvim}/config/?.lua"
  .. ";${./nvim}/config/?/?.lua"

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
          multicursor-nvim
          nvim-lsp-file-operations
          inc-rename-nvim
          nvim-treesitter
          telescope-nvim
          nvim-autopairs

          copilot-lua
          CopilotChat-nvim
          codecompanion-nvim
        ];
      };
    };
  };
  programs.lazygit = {
    enable = true;
    settings = ''
      customCommands :
      - key : "C"
        command : "oco --commit"
        context : "files"
    '';
  };
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt
    lua-language-server
    nodejs

    ripgrep

    opencommit
  ];
}
