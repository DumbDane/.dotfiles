{
  flake.modules.nixos.plasma-desktop = {
    # Settings for kde
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "dk";
      variant = "nodeadkeys";
    };

  };
}
