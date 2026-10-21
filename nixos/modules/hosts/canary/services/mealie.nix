{
  flake.modules.nixos.mealie =
    {
      config,
      pkgs,
      ...
    }:
    let
      serviceName = "mealie";
      fqdn = "${serviceName}.${config.vpn.domain}";
    in
    {

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
          services.${serviceName}.endpoints = {
            "tcp:443" = "tcp://localhost:443";
          };
        };
      };

      services.caddy = {
        enable = true;
        virtualHosts."${fqdn}".extraConfig = ''
          tls {
            get_certificate tailscale
          }
          reverse_proxy localhost:9000
        '';
      };

      services.mealie = {
        enable = true;
        package = pkgs.mealie;
        database.createLocally = true;

        settings = {
          ALLOW_SIGNUP = "false";
          MAX_WORKERS = 1;
          WEB_CONCURRENCY = 1;
          SECURITY_MAX_LOGIN_ATTEMPTS = 10;
          TZ = "Europe/Copenhagen";
        };
      };
    };
}
