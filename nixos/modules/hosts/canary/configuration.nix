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
}
