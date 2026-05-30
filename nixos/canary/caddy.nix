{ ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "canary.mullet-chimera.ts.net".extraConfig = ''
          tls {
            get_certificate tailscale
          }
          handle_path /cloud* { 
            reverse_proxy 127.0.0.1:8081
          }

          route /forgejo/* {
            uri strip_prefix /forgejo
            request_body {
              max_size 512MB
            }
            reverse_proxy localhost:3000
          }
        '';

      "lan.nextcloud" = {
        hostName = "192.168.8.51";
        extraConfig = ''
          handle_path /cloud* {
            reverse_proxy 127.0.0.1:8081
          }
        '';
      };
    };

  };
}
