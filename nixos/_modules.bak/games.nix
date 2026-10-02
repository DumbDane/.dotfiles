{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    games.enable = lib.mkEnableOption "Enables games from nixpkgs";
  };

  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [ mindustry ];
  };

}
