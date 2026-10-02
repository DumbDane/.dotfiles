{
  ...
}:
{
  flake.modules.nixos.minimal =
    { ... }:
    {
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

      system.stateVersion = "24.11";

    };
}
