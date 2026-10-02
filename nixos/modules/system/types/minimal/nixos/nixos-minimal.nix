{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.system-minimal =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        locales
      ];

      nixpkgs.config.allowUnfree = true;

      nix.gc = {
        automatic = true;
        dates = "weekly";
        persistent = true;
        options = "--delete-older-than 30d";
      };
      nix.settings.auto-optimise-store = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      # Configure danish keyboard layout
      console.keyMap = "dk-latin1";

    };
}
