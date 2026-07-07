{ config, pkgs, ... }:
{
  home.stateVersion = "26.05";
  imports = [
     ./packages/vscode.nix
  ];
}
