{
  inputs,
  ...
}:
{
  flake.modules.nixos.ninox =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        system-desktop
        systemd-boot
        robert
        plasma-desktop
        gaming
        obs
      ];

      users.users.robert = {
        extraGroups = [
          "audio"
          "input"
          "gamemode"
        ];
        packages = with pkgs; [
          prismlauncher
          nextcloud-client
        ];
      };
      networking.networkmanager.enable = true;
      networking.hostName = "ninox";

      system.stateVersion = "24.11";
    };
}
