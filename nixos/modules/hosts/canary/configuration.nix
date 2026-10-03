{
  inputs,
  ...
}:
{
  flake.modules.nixos.canary = {
    imports = with inputs.self.modules.nixos; [
      minimal
      systemd-boot
    ];
  };

  flake.modules.nixos.robert =
    { pkgs, ... }:
    {
      users.users.robert = {
      };
      packages = with pkgs; [
        powertop
      ];
    };
}
