{ config, lib, pkgs, ... }:
{
    options = {
        steam.enable = lib.mkEnableOption "Enables steam";
    };

    config = lib.mkIf config.steam.enable {
            environment.systemPackages = with pkgs; [ steam ];
            programs.steam.enable = true;
            programs.steam.extraPackages = with pkgs; [ gamescope ];
            programs.gamescope.enable = true;
        };
}
