{ pkgs, inputs, ... }: {
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    opts = {
      number = true;
      smartindent = true;
    };

    plugins = {
      lsp = {
        enable = true;
        servers.nixd = {
          enable = true;
          settings = {
            formatting.command = [ "nixfmt" ];
            nixpkgs = {
              expr = "import (builtins.getFlake \"/etc/nixos/\").inputs.nixpkgs { }";
            };
            options = {
              nixos.expr = "(builtins.getFlake \"/etc/nixos/\").nixosConfigurations.linix-os.options";
            };
          };
          #inlayHints.enable = true;
        };
        servers.nil_ls = {
          enable = false;
          settings.nil = {
            formatting.command = [ "nixfmt" ];
            nix.flake = {
              autoEvalInputs = true;
              autoArchive = true;
              nixpkgsInputName = "nixpkgs";
            };
          };
        };
      };
      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "super-tab";
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
      };
      luasnip.enable = true;
      conform-nvim.enable = true;
      conform-nvim.settings = {
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
        formatters_by_ft = {
          nix = [ "nixfmt" ];
        };
      };
      #nvim-snippets.enable = true;

      dashboard.enable = true;
    };
    colorschemes.onedark = {
      enable = true;
    };
  };
}
