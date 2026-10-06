{
  flake.modules.nixos.caddy = {
    services.caddy = {
      enable = true;
      virtualHosts = {
        "canary.mullet-chimera.ts.net".extraConfig = ''
          tls {
            get_certificate tailscale
          }
        '';
      };

    };

  };
}
