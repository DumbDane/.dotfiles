{ ... }:
let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        spotify
        discord
      ];
    };
in
{
  flake.modules.nixos.vibes = { pkgs, ... }: {
    imports = [ genericPackages ];
    environment.systemPackages = with pkgs; [
      easyeffects
      unityhub
    ];
  };
  flake.modules.darwin.vibes = {
    imports = [ genericPackages ];
  };
}
