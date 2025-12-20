{ config, lib, pkgs, ... }:
{
    imports = [
        ./audio.nix
        ./steam.nix
        ./games.nix
        ./location.nix
        ./shells
        ./blender.nix
    ];

    # System Settings
    audio.enable = lib.mkDefault true;
    location.enable = lib.mkDefault true;


    # User settings
    shells.zsh.enable = lib.mkDefault true;

    # GUI Applications
    steam.enable = lib.mkDefault false;
    blender.enable = lib.mkDefault true;
    games.enable = lib.mkDefault true;
}
