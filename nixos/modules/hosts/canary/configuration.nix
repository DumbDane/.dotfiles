{
  inputs,
  ...
}:
{
  flake.modules.nixos.canary =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        system-cli
        systemd-boot
        robert
      ];

      users.users.robert = {
        packages = with pkgs; [
          powertop
        ];
      };
      environment.systemPackages = with pkgs; [
        # cifs-utils # was this just used for reaching pelican?
        cron
        # gcc
        # jdk21_headless
      ];

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.05";

    };
}
