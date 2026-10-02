{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      audio
      browser
      office
      system-cli
      vibes
    ];
  };

  flake.modules.darwin.system-desktop = {
    imports = with inputs.self.modules.darwin; [
      browser
      office
      system-cli
      vibes
    ];
  };
}
