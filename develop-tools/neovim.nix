{
  pkgs,
  inputs,
  ...
}: {
  programs.nixvim = {
    enable = false;
    opts = {
      number = true;
      smartindent = true;
    };

    plugins = {
      lsp = {
        enable = false;
        servers.nixd = {
          enable = true;
          settings = {
            formatting.command = ["nixfmt"];
            nixpkgs = {
              expr = "import (builtins.getFlake \"/etc/nixos/\").inputs.nixpkgs { }";
            };
            options = {
              nixos.expr = "(builtins.getFlake \"/etc/nixos/\").nixosConfigurations.linix-os.options";
            };
          };
          #inlayHints.enable = true;
        };
	};
      };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    # configure = {
    #   packages.myVimPackage = with pkgs.vimPlugins; {
    #     # loaded on launch
    #     start = [ lazydev-nvim ];
    #     # manually loadable by calling `:packadd $plugin-name`
    #   };
    # };
  };
	#  programs.bash.initExtra = ''
	#  	nvim(){
	# 	stty -ixon
	# 	command nvim "$@"
	# 	stty ixon
	# }
	#  '';
  environment.etc."xdg/nvim/init.lua".source = ./nvim/init.lua;
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt
    #vimPlugins.nvim-lspconfig
    #vimPlugins.lazydev-nvim
    lua-language-server
  ];
}
