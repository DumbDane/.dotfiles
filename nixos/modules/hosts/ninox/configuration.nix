{
  inputs,
  ...
}:
{
  flake.modules.nixos.ninox = {
    imports = with inputs.self.modules.nixos; [
      minimal
      systemd-boot
    ];
  };
}
