{
  flake.modules.nixos.arr =
    {
      config,
      ...
    }:
    let
      serviceName = "sonarr";
      fqdn = "${serviceName}.${config.vpn.domain}";
    in
    {
      # imports = with self.modules.nixos; [
      #   secrets
      # ];
      # sops.secrets.sonarr-admin-pwd = { };
      # sops.secrets.sonarr-admin-pwd.owner = "forgejo";

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          443
        ];
      };

      services.tailscale = {
        permitCertUid = "caddy";
        serve = {
          enable = true;
          services.${serviceName} = {
            endpoints = {
              "tcp:443" = "tcp://localhost:443";
            };
          };
        };
      };

      services.caddy = {
        enable = true;
        virtualHosts."${fqdn}".extraConfig = ''
          tls {
            get_certificate tailscale
          }
          reverse_proxy localhost:8989
        '';
      };

      services.sonarr = {
        enable = true;

      };

    };
}
