{ config, lib, pkgs, ... }:
{
    options = {
        steam.enable = lib.mkEnableOption "Enables steam";
    };

    config = { 
            programs.steam.enable = true;
            programs.steam.extraPackages = with pkgs; [ gamescope ];
            programs.gamescope.enable = true;
        };
}
