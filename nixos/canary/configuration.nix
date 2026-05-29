# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# Nextcloudand in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
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
  ];

  # Users
  main-user.enable = true;
  main-user.userName = "robert";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "canary"; # Define your hostname.
  # networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure static ip address
  networking.interfaces.eno1.ipv4.addresses = [
    {
      address = "192.168.8.51";
      prefixLength = 24;
    }
  ];

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #  users.users.robert = {
  #    isNormalUser = true;
  #    description = "Robert";
  #    extraGroups = [ "networkmanager" "wheel" ];
  #    packages = with pkgs; [
  #    #  thunderbird
  #    ];
  #  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
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
    tailscale
    jdk21_headless
    ghostty
    gcc
    nixd
    docker-compose-language-service
    docker-ls
    pyright
    nextcloud32
    pkgs.cifs-utils
  ];

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";

  # Open ports in the firewall.
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      80 # Caddy
      443 # Caddy / Tailscale
      9925 # Mealie
      25565 # Minecraft
    ];
    allowedUDPPorts = [ ];
    trustedInterfaces = [ "tailscale0" ];
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  # Enable the tailscale service
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--exit-node=magpie" ];
    useRoutingFeatures = "client";
    permitCertUid = "caddy";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
    options = "--delete-older-than 30d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
