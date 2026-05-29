{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      description = ''
        username
      '';
      default = "robert";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = "main user";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        fzf
        zoxide
        gcc
        unzip
        jq
        powertop
        stow
        ripgrep
      ];
      shell = pkgs.zsh;
    };
  };

}
