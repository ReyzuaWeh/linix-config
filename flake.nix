{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    honkai-railway-grub-theme.url = "github:voidlhf/StarRailGrubThemes";
    claude-shell.url = "path:/home/raj/Documents/flakes-claude";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, honkai-railway-grub-theme, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations.linix-os = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
	  		nix.registry.claude-shell.flake = inputs.claude-shell;
	  		home-manager.useGlobalPkgs = true;
	  		home-manager.useUserPackages = true;
	  		# home-manager.users.raj = import ./home.nix;
	  	}
      ];
      specialArgs = { inherit honkai-railway-grub-theme; };
    };
  };
}
