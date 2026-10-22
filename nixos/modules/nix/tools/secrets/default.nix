{
  inputs,
  ...
}:
{
  flake.modules.nixos.secrets = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = ../../../../secrets.yaml;
      validateSopsFiles = false;
    };
  };
  flake.modules.darwin.secrets = {
    imports = [
      inputs.sops-nix.darwinModules.sops
    ];
    sops = {
      defaultSopsFile = ../../../../secrets.yaml;
      validateSopsFiles = false;
    };
  };

}
