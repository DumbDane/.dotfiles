{ inputs, ... }:
{
  flake.modules.darwin.homebrew = {
    imports = [
      inputs.nix-homebrew.darwinModules.nix-homebrew
      inputs.mac-app-util.darwinModules.default
    ];
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = "lauridspedersen";
      autoMigrate = true;
    };

    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };
      taps = [ ];
      brews = [ "mas" ];
      casks = [
        "hammerspoon"
        "prusaslicer"
        "orcaslicer"
        "chatgpt"
        "bambu-studio"
        "nextcloud"
        "macsyzones"
      ];
      masApps = { };

    };
  };
}
