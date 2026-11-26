{ inputs, ... }: {
  perSystem =
    { system, ... }:
    let
      pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia.wrap {
        inherit pkgs;
        # settings = (builtins.fromTOML (builtins.readFile ./noctalia.TOML)).settings;
      };
    };
}
