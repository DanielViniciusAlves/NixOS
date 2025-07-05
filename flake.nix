{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        profile = "mac";
      };

      userSettings = {
        username = "daniel";
        host = "nixos";
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration/configuration.nix
        ];
        specialArgs = {
          inherit userSettings;
        };
      };

      homeConfigurations = {
        daniel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles/mac/home.nix")
          ];
          extraSpecialArgs = {
            inherit userSettings;
          };
        };
      };
    };
}
