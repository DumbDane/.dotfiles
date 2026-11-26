{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      audio
      browser
      gaming
      obs
      office
      system-cli
      systemd-boot
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
