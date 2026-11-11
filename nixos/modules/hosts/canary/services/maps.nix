{
  flake.modules.nixos.maps =
    {
      config,
      ...
    }:
    let
      serviceName = "maps";
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
          header Access-Control-Allow-Origin "app://obsidian.md"
          root * /srv/maps
          file_server browse
        '';
      };

    };
}
