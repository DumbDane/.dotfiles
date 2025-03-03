{ config, lib, pkgs, ... }:
{
    imports = [
        ./audio.nix
        ./steam.nix
        ./location.nix
    ];

    audio.enable = lib.mkDefault true;
    steam.enable = lib.mkDefault false;
}
