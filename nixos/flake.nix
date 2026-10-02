{
  description = "My Dendritic Flake";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05"; # github:NixOS/nixpkgs/nixos-26.05
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # github:NixOS/nixpkgs/nixos-unstable
    nixpkgs-darwin.url = "nixpkgs/nixpkgs-26.05-darwin"; # github:NixOS/nixpkgs/nixpgs-26.05-darwin

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

  };

  # outputs =
  #   inputs@{
  #     self,
  #     nixpkgs,
  #     nix-darwin,
  #     nix-homebrew,
  #     mac-app-util,
  #     ...
  #   }:
  #   let
  #     lib = nixpkgs.lib;
  #     system = "x86_64-linux";
  #     macpkgs = import nixpkgs {
  #       system = "aarch64-darwin";
  #       config.allowUnfree = true;
  #     };
  #   in
  #   {
  #     nixosConfigurations = {
  #       Ninox = lib.nixosSystem {
  #         inherit system;
  #         modules = [
  #           ./ninox/configuration.nix
  #           ./modules
  #         ];
  #         specialArgs = { inherit inputs; };
  #       };
  #
  #       canary = nixpkgs.lib.nixosSystem {
  #         inherit system;
  #         specialArgs = { inherit inputs; };
  #         modules = [
  #           ./canary/configuration.nix
  #           inputs.sops-nix.nixosModules.sops
  #         ];
  #       };
  #     };
  #
  #     darwinConfigurations = {
  #       Macaw = nix-darwin.lib.darwinSystem {
  #         modules = [
  #           { nixpkgs.pkgs = macpkgs; }
  #           ./macaw/configuration.nix
  #           mac-app-util.darwinModules.default
  #           nix-homebrew.darwinModules.nix-homebrew
  #           {
  #             nix-homebrew = {
  #               enable = true;
  #               enableRosetta = true;
  #               user = "lauridspedersen";
  #               autoMigrate = true;
  #             };
  #           }
  #         ];
  #         specialArgs = { inherit inputs; };
  #       };
  #     };
  #   };
}
