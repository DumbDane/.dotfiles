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

      };
  };
}
