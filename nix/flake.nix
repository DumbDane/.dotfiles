{
    description = "My Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable"; # github:NixOS/nixpkgs/nixos-unstable


        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";


        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        mac-app-util.url = "github:hraban/mac-app-util";
    };

    outputs = inputs@{self, nixpkgs, home-manager, nix-darwin, nix-homebrew, mac-app-util, ...}:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config = {
                    allowUnfree = true;
                };
            };
        in
            {
            nixosConfigurations = 
                {
                    Ninox = lib.nixosSystem {
                        inherit system;
                        modules = [ ./ninox/configuration.nix ];
                    };
                };

            homeConfigurations = 
                {
                    robert = home-manager.lib.homeManagerConfiguration {
                        inherit pkgs;
                        modules = [ ./home.nix ];
                    };
                };

            darwinConfigurations = 
                {
                    Macaw = nix-darwin.lib.darwinSystem {
                        pkgs = import nixpkgs {
                            system = "aarch64-darwin";
                            config.allowUnfree = true;
                        };
                        modules = [ 
                            ./macaw/configuration.nix 
                            mac-app-util.darwinModules.default
                            nix-homebrew.darwinModules.nix-homebrew 
                            {
                                nix-homebrew = {
                                enable = true;
                                enableRosetta = true;
                                user = "lauridspedersen";
                                autoMigrate = true;
                                };
                            }
                        ];
                    };
                };
        };
}
