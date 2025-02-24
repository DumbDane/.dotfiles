# Edit this configuration file to define what should be installed on
# your Mac system. Help is (maybe) available in the configuration.nix(5) man page
# and in the NixOS manual ('nixos-help')
# Otherwise (and maybe firstly) check the darwin repository on github


{ self, pkgs, nix-darwin, nix-homebrew, mac-app-util, ... }:

{
    imports = [ ];
    # The platform the configuration will be used on.
    # pkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs;
        [ 
            zsh
            neovim
            tmux
            zoxide
            fzf
            stow
            direnv
            obsidian
            nodejs
            spotify
            discord
            docker
            docker-compose
            utm
            shellcheck
            vscode
            nixd
            lua-language-server
        ];



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
            "hammerspoon"
            "db-browser-for-sqlite"
            "vagrant"
            "postman"
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
