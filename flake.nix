{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    honkai-railway-grub-theme.url = "github:voidlhf/StarRailGrubThemes";
    claude-shell.url = "path:/home/raj/Documents/flakes-claude";
  };

  outputs = { self, nixpkgs, honkai-railway-grub-theme, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations.linix-os = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        {
	  nix.registry.claude-shell.flake = inputs.claude-shell;
	}
      ];
      specialArgs = { inherit honkai-railway-grub-theme; };
    };
  };
}
