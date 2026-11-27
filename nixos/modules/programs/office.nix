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

    # https://github.com/NixOS/nixpkgs/pull/572466
    nixpkgs.overlays = [
      (self: super: {
        zotero =
          (import super.path {
            inherit (super) system;
            config = super.config // {
              permittedInsecurePackages = [ "firefox-esr-140-bin-unwrapped-140.17.0esr" ];
            };
          }).zotero;
      })
    ];
    environment.systemPackages = [ pkgs.zotero ];

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
