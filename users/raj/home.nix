{ config, ... }:
{
  home.stateVersion = "26.05";
  home.sessionVariables.XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
  imports = [
    # ./packages/vscode.nix
    ./packages/helix/helix.nix
  ];
}
