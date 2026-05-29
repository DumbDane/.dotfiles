{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.caddy = {
    enable = true;

    virtualHosts = {
      # LAN access to Radarr
      "lan.starr" = {
        hostName = "http://192.168.8.51";
        # You can also add :443 later for TLS
        extraConfig = ''
          	      	handle /radarr* {
          			reverse_proxy localhost:7878
          		}
          	      '';
      };

      # Tailscale MagicDNS access
      "canary.mullet-chimera.ts.net" = {
        # Uses Caddy's automatic HTTPS with ACME — but Tailscale won't issue public certs.
        # So: use an internal CA.
        #useACMEHost = "canary.mullet-chimera.ts.net";
        extraConfig = ''
          	        tls internal
          		handle /radarr* { 
          			reverse_proxy 127.0.0.1:7878
          		}
          	      '';
      };
    };
  };
}
