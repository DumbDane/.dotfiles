{ config, lib, pkgs, ... }:
{
    imports = [
        ./audio.nix
        ./steam.nix
        ./location.nix
        ./shells
    ];

    # System Settings
    audio.enable = lib.mkDefault true;
    location.enable = lib.mkDefault true;


    # User settings
    shells.zsh.enable = lib.mkDefault true;

    # GUI Applications
    steam.enable = lib.mkDefault false;
}
