{ ... }:
let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        thunderbird
        obsidian
        zotero
      ];
    };
in
{
  flake.modules.nixos.office = {
    imports = [ genericPackages ];
  };
  flake.modules.darwin.office = {
    imports = [ genericPackages ];
  };
}
