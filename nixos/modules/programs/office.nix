let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        thunderbird
        obsidian
      ];
    };
in
{
  flake.modules.nixos.office = { pkgs, ... }: {
    imports = [
      genericPackages
    ];
    # environment.systemPackages = [ pkgs.zotero ];

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };

  flake.modules.darwin.office = {
    imports = [
      genericPackages
    ];
    homebrew.casks = [ "zotero" ];
  };
}
