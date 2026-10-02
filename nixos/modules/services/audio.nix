{
  flake.modules.nixos.audio = { pkgs, ... }: {

    # enable sound with pipewire.
    environment.systemPackages = with pkgs; [
      pulseaudio
      wireplumber
    ];
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # if you want to use jack applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
      wireplumber.enable = true;
    };

  };
}
