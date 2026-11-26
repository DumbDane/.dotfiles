{ inputs, ... }: {
  flake.modules.nixos.ninox = {
    specialisation.niri.configuration = { lib, ... }: {
      imports = with inputs.self.modules.nixos; [ niri-desktop ];

      services.desktopManager.plasma6.enable = lib.mkForce false;
    };
  };
}
