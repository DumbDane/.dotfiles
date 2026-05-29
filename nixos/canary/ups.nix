{
  config,
  pkgs,
  inputs,
  ...
}:

{
  power.ups = {
    enable = true;
    mode = "standalone";

    users."nut-admin" = {
      passwordFile = config.sops.secrets."nut-admin-pwd".path;
      upsmon = "primary";
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
}
