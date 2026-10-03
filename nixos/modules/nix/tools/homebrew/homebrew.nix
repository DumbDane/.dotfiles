{
  flake.modules.darwin.homebrew = {
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
        "zotero"
        "hammerspoon"
        "prusaslicer"
        "orcaslicer"
        "chatgpt"
        "bambu-studio"
      ];
      masApps = { };

    };
  };
}
