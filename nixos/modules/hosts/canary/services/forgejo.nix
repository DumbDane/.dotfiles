{ self, ... }:
{
  flake.modules.nixos.forgejo =
    {
      lib,
      config,
      ...
    }:
    let
      serviceName = "git";
      fqdn = "${serviceName}.${config.vpn.domain}";
    in
    {
      imports = with self.modules.nixos; [
        secrets
      ];
      sops.secrets.forgejo-admin-pwd = { };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          443
        ];
      };

      # Enable the OpenSSH daemon.
      services.openssh.enable = true;
      services.openssh.settings.PasswordAuthentication = false;
      services.openssh.settings.PermitRootLogin = "no";

      services.tailscale = {
        permitCertUid = "caddy";
        serve = {
          enable = true;
          services.${serviceName} = {
            endpoints = {
              "tcp:443" = "https://localhost:443";
              "tcp:22" = "tcp://localhost:22";
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
          request_body {
            max_size 512MB
          }
          reverse_proxy localhost:3000
        '';
      };

      services.forgejo = {
        enable = true;
        database.type = "postgres";
        # Enable support for Git Large File Storage
        lfs.enable = true;

        settings = {
          server = {
            SSH_PORT = lib.head config.services.openssh.ports;
            DOMAIN = "${fqdn}";
            # You need to specify this to remove the port from URLs in the web UI.
            ROOT_URL = "https://${fqdn}";
            HTTP_PORT = 3000;
          };
          service.DISABLE_REGISTRATION = true;
          # Add support for actions, based on act: https://github.com/nektos/act
          actions = {
            ENABLED = true;
            DEFAULT_ACTIONS_URL = "github";
          };
        };
      };

      sops.secrets.forgejo-admin-pwd.owner = "forgejo";
      systemd.services.forgejo.preStart =
        let
          adminCmd = "${lib.getExe config.services.forgejo.package} admin user";
          pwd = config.sops.secrets.forgejo-admin-pwd;
          user = "DumbDane";
        in
        ''
          ${adminCmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
        '';
    };
}
