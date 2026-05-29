{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # github:NixOS/nixpkgs/nixos-unstable

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";

    sops-nix.url = "github:mic92/sops-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      mac-app-util,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      macpkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        Ninox = lib.nixosSystem {
          inherit system;
          modules = [
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    openldap = prev.openldap.overrideAttrs (_: {
                      doCheck = false;
                    });
                  })
                ];
              }
            )
            ./ninox/configuration.nix
            ./modules
          ];
          specialArgs = { inherit inputs; };
        };
        canary = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./canary/configuration.nix
          ];
        };
      };

      darwinConfigurations = {
        Macaw = nix-darwin.lib.darwinSystem {
          modules = [
            { nixpkgs.pkgs = macpkgs; }
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
          specialArgs = { inherit inputs; };
        };
      };
    };
}
