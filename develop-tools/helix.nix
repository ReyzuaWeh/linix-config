{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    nixd
    nixfmt
    taplo
  ];

  # environment.etc."helix-global/helix/config.toml".source = ./helix-config/config.toml;
  environment.etc."xdg/helix/languages.toml".source = ./helix/config.toml;
}
