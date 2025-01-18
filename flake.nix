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
            systemSettings = {
                system = "x86_64-linux";
                profile = "personal";
            };
            pkgs = nixpkgs.legacyPackages.${systemSettings.system};
        in {
            nixosConfigurations = {
                system = {
                    system = systemSettings.system;
                    modules = [
                        ./configuration/configuration.nix
                    ];
                };
            };

            homeConfigurations = {
                daniel = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        (./. + "/profiles/personal/home.nix")
                    ];
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
