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


      programs.steam = {
        enable = true;
        extraPackages = with pkgs; [ gamescope ];
        gamescopeSession.enable = true;
      };
      programs.gamescope.enable = true;

    };
}
