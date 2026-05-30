{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    hostName = "lan.nextcloud";
    database.createLocally = true;
    configureRedis = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = config.sops.secrets."nextcloud-admin-pwd".path;
      adminuser = "admin";
    };
    settings =
      let
        prot = "https";
        dir = "/cloud";
      in
      {
        overwriteprotocol = prot;
        overwritewebroot = dir;
        htaccess.RewriteBase = dir;
        #overwrite.cli.url = "${prot}://127.0.0.1${dir}/";

        trusted_domains = [
          "192.168.8.51"
          "canary.mullet-chimera.ts.net"
        ];
      };
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar mail;
    };
  };
  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
    {
      addr = "127.0.0.1";
      port = 8081;
    }
  ];
}
