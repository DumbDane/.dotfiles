{
  flake.modules.nixos.shell =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.ghostty
      ];
    };

  flake.modules.darwin.shell = {
    homebrew.casks = [ "ghostty" ];
  };
}
