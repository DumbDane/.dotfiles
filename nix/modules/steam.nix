{ config, lib, pkgs, ... }:
{
    options = {
        steam.enable = lib.mkEnableOption "Enables steam";
    };

    config = lib.mkIf config.steam.enable {
        environment.systemPackages = with pkgs; [ steam mangohud protonup-qt lutris bottles heroic ];
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
            extraPackages = with pkgs; [ nvidia-vaapi-driver ];

        };
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
            open = false;
        };

        programs.steam = {
            enable = true;
            extraPackages = with pkgs; [ gamescope ];
            gamescopeSession.enable = true;
        };
        programs.gamescope.enable = true;

        fileSystems."/games" = {
            device = "/dev/disk/by-label/Games";
            fsType = "ntfs";
        };
    };
}
