{
  inputs,
  ...
}:
{
  flake.modules.nixos.system-default = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
    ];

  };

  flake.modules.darwin.system-default = {
    imports = with inputs.self.modules.darwin; [
      system-minimal
      homebrew
    ];

  };
}
