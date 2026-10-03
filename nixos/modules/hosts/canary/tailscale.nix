{
  flake.modules.nixos.canary = {

    # Enable the tailscale service
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
      permitCertUid = "caddy";
    };
  };
}
