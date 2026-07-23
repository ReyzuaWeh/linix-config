{ ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        lsp.enable = true;
        lsp.formatOnSave = true;
        formatter.conform-nvim.enable = true;
        formatter.conform-nvim.presets.nixfmt.enable = true;

        snippets.luasnip.enable = true;
        snippets.luasnip.setupOpts = { };
        autocomplete.nvim-cmp.enable = true;
        mini.snippets.enable = true;
        languages = {
          python.enable = true;
          nix = {
            enable = true;
          };
          enableFormat = true;
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
        };
      };
    };
  };
}
