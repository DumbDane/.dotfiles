{
  inputs,
  lib,
  ...
}:
let
  name = "ninox";
in
{
  flake.nixosConfigurations.${name} = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos.${name}
      { nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; }
    ];
  };
}
