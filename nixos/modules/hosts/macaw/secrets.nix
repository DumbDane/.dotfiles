{
  self,
  ...
}:
{
  flake.modules.darwin.macaw = { config, ... }: {

    imports = with self.modules.darwin; [
      secrets
    ];

    sops.age.keyFile = "/var/lib/sops-nix/key.txt";

    sops.secrets.github-token = { };

    sops.templates."nix-github.conf" = {
      content = ''
        access-tokens = github.com=${config.sops.placeholder.github-token}
      '';
      owner = config.system.primaryUser;
      mode = "0400";
    };

    nix.extraOptions = ''
      !include ${config.sops.templates."nix-github.conf".path}
    '';
  };
}
