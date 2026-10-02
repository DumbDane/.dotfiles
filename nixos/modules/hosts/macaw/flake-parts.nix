{
  inputs,
  lib,
  ...
}:
let
  name = "macaw";
in
{
  flake.darwinConfigurations.${name} = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      inputs.self.modules.darwin.${name}
      { nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin"; }
    ];
  };
}
