{
  flake.modules.nixos.arr =
    {
      config,
      ...
    }:
    let
      serviceName = "radarr";
      fqdn = "${serviceName}.${config.vpn.domain}";
    in
    {
      # imports = with self.modules.nixos; [
      #   secrets
      # ];
      # sops.secrets.radarr-admin-pwd = { };
      # sops.secrets.radarr-admin-pwd.owner = "forgejo";

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
          reverse_proxy localhost:7878
        '';
      };

      services.radarr = {
      };

    };
}
