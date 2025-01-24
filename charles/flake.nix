{
    description = "My nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        mac-app-util.url = "github:hraban/mac-app-util";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, mac-app-util }:
        let
            configuration = { pkgs, config, ... }: {
                # List packages installed in system profile. To search by name, run:
                # $ nix-env -qaP | grep wget
                nixpkgs.config.allowUnfree = true;
                environment.systemPackages = with pkgs;
                    [ 
                        zsh
                        neovim
                        tmux
                        zoxide
                        fzf
                        stow
                        obsidian
                        python3
                        nodejs
                        spotify
                        discord
                    ];


                environment.shellAliases = { python = "python3"; };

                homebrew = {
                    enable = true;
                    onActivation = {
                        autoUpdate = true;
                        upgrade = true;
                        cleanup = "zap";
                    };
                    brews = [ "mas" ];
                    casks = [
                        "hammerspoon"
                        "ghostty"
                    ];
                    masApps = { };

                };

                fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

                # Necessary for using flakes on this system.
                nix.settings.experimental-features = "nix-command flakes";

                # Enable alternative shell support in nix-darwin.
                programs.zsh.enable = true;

                # Set Git commit hash for darwin-version.
                system.configurationRevision = self.rev or self.dirtyRev or null;

                # Used for backwards compatibility, please read the changelog before changing.
                # $ darwin-rebuild changelog
                system.stateVersion = 5;

                # The platform the configuration will be used on.
                nixpkgs.hostPlatform = "aarch64-darwin";
            };
        in
            {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#Macaw
            darwinConfigurations."Macaw" = nix-darwin.lib.darwinSystem {
                modules = [ 
                    configuration 
                    mac-app-util.darwinModules.default
                    nix-homebrew.darwinModules.nix-homebrew
                    {
                        nix-homebrew = { 
                            enable = true;
                            enableRosetta = true;
                            user = "lauridspedersen";
                            autoMigrate = true;
                        };
                    }
                ];
            };
        };
}
