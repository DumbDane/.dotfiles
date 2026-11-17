{ self, ... }:
{
  flake.modules.nixos.cache =
    {
      config,
      pkgs,
      ...
    }:
    let
      serviceName = "cache";
      fqdn = "http://${serviceName}.home.arpa";
    in
    {
      imports = with self.modules.nixos; [
        secrets
      ];
      sops.secrets.nix-cache-private-pem = { };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          80
        ];
      };

      services.caddy = {
        enable = true;
        virtualHosts."${fqdn}".extraConfig = ''
          reverse_proxy localhost:${toString config.services.nix-serve.port}
        '';
      };

      services.nix-serve = {
        enable = true;
        bindAddress = "127.0.0.1";
        secretKeyFile = config.sops.secrets.nix-cache-private-pem.path;
      };

      systemd.services.nixos-upgrade.unitConfig.OnSuccess = [ "x86-prefetch.service" ];
      systemd.services.x86-prefetch = {
        description = "Prefetches x86_64 NixOS Closures";

        path = with pkgs; [
          nix
          jq
        ];

        serviceConfig.Type = "oneshot";

        script = ''
          flake="github:DumbDane/.dotfiles?dir=nixos"
          roots="/nix/var/nix/gcroots/x86-prefetch"

          mkdir -p "$roots"

          hosts=$(nix eval --json "$flake#nixosConfigurations" \
            --apply 'configs:
              builtins.filter
                (name: (builtins.getAttr name configs).config.nixpkgs.hostPlatform.system == "x86_64-linux")
                (builtins.attrNames configs)')

          for host in $(echo "$hosts" | jq -r '.[]'); do
            echo "Prefetching $host"
            nix build \
              "$flake#nixosConfigurations.$host.config.system.build.toplevel" \
              --out-link "$roots/$host"
          done
        '';
      };

    };
}
