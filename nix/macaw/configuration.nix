# Edit this configuration file to define what should be installed on
# your Mac system. Help is (maybe) available in the configuration.nix(5) man page
# and in the NixOS manual ('nixos-help')
# Otherwise (and maybe firstly) check the darwin repository on github


{ self, pkgs, nix-darwin, nix-homebrew, mac-app-util, ... }:
let cfg = {
    applications = with pkgs; [
        obsidian
        vscode
        postman
        discord
        spotify
    ];

    packages = with pkgs; [
        zsh
        neovim
        tmux
        zoxide
        fzf
        stow
        ffmpeg
        direnv
        ripgrep
        minikube
        imagemagick
        shellcheck
        nodejs
        docker
        docker-compose
        (python3.withPackages(ps: with ps; [uv]))
    ];

    languageServers = with pkgs; [
        nixd
        lua-language-server
        dockerfile-language-server
        docker-compose-language-service
        pyright
    ];
};
in {
    imports = [ ];
    # The platform the configuration will be used on.
    # pkgs.hostPlatform = "aarch64-darwin";
    system.primaryUser = "lauridspedersen";

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = cfg.applications ++ cfg.packages ++ cfg.languageServers;


    homebrew = {
        enable = true;
        onActivation = {
            autoUpdate = true;
            upgrade = true;
            cleanup = "zap";
        };
        taps = [ ];
        brews = [ "mas" ];
        casks = [
            "ghostty"
            "zen"
            "hammerspoon"
            "prusaslicer"
            "orcaslicer"
            "bambu-studio"
        ];
        masApps = { };

    };

    # Enable alternative shell support in nix-darwin.
    programs.zsh.enable = true;


    # Shell Aliases
    # environment.shellAliases = { python = "python3"; };

    # Fonts
    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Set Git commit hash for darwin-version.
    # system.configurationRevision = self.rev or self.dirtyRev or null;


    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;

}
