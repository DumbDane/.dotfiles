{
  lib,
  config,
  ...
}:
{
  services.caddy = {
    enable = true;
    virtualHosts."canary.mullet-chimera.ts.net".extraConfig = ''
      handle /forgejo* {
        request_body {
          max_size 512MB
        }
        reverse_proxy localhost:3000
      }
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
        DOMAIN = "https://canary.mullet-chimera.ts.net";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://canary.mullet-chimera.ts.net/forgejo/";
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
}
