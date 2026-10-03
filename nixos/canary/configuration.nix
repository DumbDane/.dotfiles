# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# Nextcloudand in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./main-user.nix
    ./nextcloud.nix
    ./starr.nix
    ./ups.nix
    ./sops.nix
    ./forgejo.nix
    ./caddy.nix
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = false;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tmux
    # wget
    git
    direnv
    gh
    docker
    docker-compose
    bash
    cron
    caddy
    ripgrep
    jdk21_headless
    ghostty
    gcc
    nixd
    docker-compose-language-service
    docker-ls
    pyright
    nextcloud32
    cifs-utils
    tree-sitter
  ];

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = false;
    setSocketVariable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

}
