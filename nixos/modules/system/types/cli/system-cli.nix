{
  inputs,
  ...
}:
{
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-default
      cli-tools
      shell
    ];
  };

  flake.modules.darwin.system-cli = {
    imports = with inputs.self.modules.darwin; [
      system-default
      cli-tools
      shell
    ];
  };
}
