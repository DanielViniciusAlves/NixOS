{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        profile = "personal";
      };

      userSettings = {
        username = "daniel";
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration/configuration.nix
        ];
      };

      homeConfigurations = {
        daniel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              wayland.windowManager.hyprland = {
                enable = true;
                # set the flake package
                package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              };
            }
            (./. + "/profiles/personal/home.nix")
          ];
          extraSpecialArgs = {
            inherit userSettings;
          };
        };

        # work = home-manager.lib.homeManagerConfiguration {
        #     inherit pkgs;
        #     modules = [
        #         "./profiles/work/home.nix"
        #     ];
        # };
      };
    };
}
