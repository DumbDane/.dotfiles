{
  flake.modules.nixos.canary = {

    networking.hostName = "canary";
    # networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking = {
      networkmanager.enable = true;
      # Configure static ip address
      interfaces.eno1.ipv4.addresses = [
        {
          address = "192.168.8.51";
          prefixLength = 24;
        }
      ];
      defaultGateway = {
        address = "192.168.8.1";
        interface = "eno1";
      };
      nameservers = [ "192.168.8.2" ];
    };
  };
}
