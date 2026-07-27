{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
    helix
    nixfmt
    taplo
  ];
  xdg.enable = true;

  xdg.configFile = {
    "helix/languages.toml".enable = true;
    "helix/languages.toml".source = ./.config/languages.toml;
    "helix/config.toml".source = ./.config/config.toml;
  };
}
