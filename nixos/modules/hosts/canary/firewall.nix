{
  flake.modules.nixos.canary = {

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.openssh.settings.PasswordAuthentication = false;
    services.openssh.settings.PermitRootLogin = "no";

    networking.firewall = {
      allowedTCPPorts = [
        22
      ];
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };
}
