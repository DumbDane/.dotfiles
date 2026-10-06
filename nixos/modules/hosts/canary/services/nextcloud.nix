{ self, ... }:
{
  flake.modules.nixos.nextcloud =
    let
      serviceName = "cloud";
      fqdn = "${serviceName}.mullet-chimera.ts.net";
    in
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        secrets
      ];
      sops.secrets.nextcloud-admin-pwd = { };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          443 # Caddy / Tailscale
        ];
        allowedUDPPorts = [ ];
        trustedInterfaces = [ "tailscale0" ];
      };

      services.tailscale = {
        enable = true;
        permitCertUid = "caddy";
        serve = {
          enable = true;
          services.${serviceName}.endpoints = {
            "tcp:443" = "http://localhost:8081";
          };
        };
      };

      services.caddy = {
        enable = true;
        virtualHosts."${fqdn}".extraConfig = ''
          tls {
            get_certificate tailscale
          }
          reverse_proxy localhost:8081
        '';
      };

      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud34;
        hostName = "lan.nextcloud";
        database.createLocally = true;
        configureRedis = true;
        config = {
          dbtype = "pgsql";
          adminpassFile = config.sops.secrets."nextcloud-admin-pwd".path;
          adminuser = "admin";
        };
        settings =
          let
            prot = "https";
            # TODO: figure out how to do this without bricking nextcloud
            dir = "/cloud";
          in
          {
            overwriteprotocol = prot;
            overwritewebroot = dir;
            htaccess.RewriteBase = dir;
            #overwrite.cli.url = "${prot}://127.0.0.1${dir}/";

            trusted_domains = [
              "192.168.8.51"
              "canary.mullet-chimera.ts.net"
              "${fqdn}"
            ];
          };
        extraAppsEnable = true;
        extraApps = with config.services.nextcloud.package.packages.apps; {
          inherit calendar mail;
        };
      };
      # TODO: figure out if this is needed
      services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
        {
          addr = "127.0.0.1";
          port = 8081;
        }
      ];
    };
}
