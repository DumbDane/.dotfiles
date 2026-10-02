{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    blender.enable = lib.mkEnableOption "Enables blender";
  };

  config = lib.mkIf config.blender.enable {
    environment.systemPackages = with pkgs; [ blender ];
    #programs.blender.enable = true;
  };

}
