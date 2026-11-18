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

      hardware.nvidia-container-toolkit.enable = true;

      networking.networkmanager.enable = true;
      networking.hostName = "ninox";
      networking.enableIPv6 = false;

      nix.settings = {
        extra-substituters = [
          "http://cache.home.arpa"
        ];
        extra-trusted-public-keys = [
          "canary-cache:srrC9pY0Z83qLYJWT3U3fe0BXQQCpXPDpD1iCsxJrNg="
        ];
      };

      system.stateVersion = "24.11";
    };
}
