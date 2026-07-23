{
  description = "Reyzua's Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    honkai-railway-grub-theme.url = "github:voidlhf/StarRailGrubThemes";
    # claude-shell.url = "path:/home/raj/Documents/flakes-claude";
    nvf = {
      url = "github:notashelf/nvf";
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
      nvf,
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
          nvf.nixosModules.default
        ];
        specialArgs = { inherit honkai-railway-grub-theme; };
      };
    };
}
