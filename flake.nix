{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration/configuration.nix
        ];
    };

    homeConfigurations.daniel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./modules/home/default.nix
        ];
    };
  };
}
