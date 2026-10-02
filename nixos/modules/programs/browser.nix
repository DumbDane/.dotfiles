{ inputs, ... }:
{
  flake.modules.nixos.browser =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  flake.modules.darwin.browser = {
    homebrew.casks = [ "zen" ];
  };
}
