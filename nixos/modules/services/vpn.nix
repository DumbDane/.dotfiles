{
  flake.modules.nixos.vpn = { lib, ... }: {
    options.vpn.domain = lib.mkOption {
      type = lib.types.str;
      default = "mullet-chimera.ts.net";
    };
    config.services.tailscale.enable = true;
  };
  flake.modules.darwin.vpn = {
    homebrew.casks = [ "tailscale-app" ];
  };
}
