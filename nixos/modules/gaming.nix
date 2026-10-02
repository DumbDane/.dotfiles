{
  flake.modules.nixos.gaming =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        steam
        mangohud
        protonup-qt
        lutris
        heroic
        wine
        wineWow64Packages.stableFull
        winetricks
        vulkan-tools
      ];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;

      };
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = false;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      };

      programs.steam = {
        enable = true;
        extraPackages = with pkgs; [ gamescope ];
        gamescopeSession.enable = true;
      };
      programs.gamescope.enable = true;

    };

}
