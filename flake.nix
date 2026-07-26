{
  description = "Reyzua's Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    honkai-railway-grub-theme.url = "github:voidlhf/StarRailGrubThemes";
    # claude-shell.url = "path:/home/raj/Documents/flakes-claude";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      honkai-railway-grub-theme,
      home-manager,
      nixvim,
      ...
    }@inputs:
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
          nixvim.nixosModules.nixvim
        ];
        specialArgs = {
          inherit honkai-railway-grub-theme;
          inherit inputs;
        };
      };
    };
}
