{
  ...
}:
{
  flake.modules.darwin.system-minimal =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      # Not sure how this works
      # nix.gc = {
      #   automatic = true;
      #   dates = "weekly";
      #   persistent = true;
      #   options = "--delete-older-than 30d";
      # };
      # nix.settings.auto-optimise-store = true;

      nix.settings.experimental-features = "nix-command flakes";

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

    };
}
