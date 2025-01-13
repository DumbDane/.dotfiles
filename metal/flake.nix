{

  description = "My Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # github:NixOS/nixpkgs/nixos-unstable
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ...}:
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
        # specialArgs = { inherit system; };
        modules = [ ./ninox/configuration.nix ];
      };
    };
    homeConfigurations = {
	robert = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
	  modules = [ ./home.nix ];
	};

    };

  };

}
