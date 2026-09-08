{ config, ... }:

{
  power.ups = {
    enable = true;
    mode = "standalone";

    maxRetry = 3;

    users = {
      "nut-admin" = {
        passwordFile = config.sops.secrets."nut-admin-pwd".path;
        upsmon = "primary";
      };
      # 1. Create a dedicated read-only user for PeaNUT
      "peanut-user" = {
        passwordFile = config.sops.secrets."peanut-nut-pwd".path;
      };
    };

    ups."ELP1600" = {
      description = "Eaton Ellipse PRO 1600 with 12V 9Ah lead-acid Batt";
      driver = "usbhid-ups";
      port = "auto";
    };

    upsmon.monitor."ELP1600" = {
      system = "ELP1600@localhost";
      user = "nut-admin";
      passwordFile = config.sops.secrets."nut-admin-pwd".path;
      type = "primary";
      powerValue = 1;
    };
  };

  virtualisation.oci-containers = {
    backend = "docker"; # Or "podman"
    containers."peanut" = {
      image = "ghcr.io/brandawg93/peanut:latest";
      ports = [ "8082:8080" ];
      environment = {
        "NUT_HOST" = "127.0.0.1";
        "NUT_PORT" = "3493";
        "NUT_USER" = "peanut-user";
      };
      # Pass the password dynamically from your sops-nix secret path
      environmentFiles = [
        config.sops.secrets."peanut-nut-pwd".path
      ];
    };
  };
}
