{ config, lib, pkgs, ... }:
{
    imports = [
        ./audio.nix
        ./steam.nix
    ];

    audio.enable = lib.mkDefault false;
    steam.enable = lib.mkDefault false;
}
