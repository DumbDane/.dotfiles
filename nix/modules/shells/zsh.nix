{ config, lib, pkgs, ... }:
{
    options = {
        shells.zsh.enable = lib.mkEnableOption "Enables zsh as defaultUserShell";
    };

    config = lib.mkIf config.shells.zsh.enable {
        environment.systemPackages = with pkgs; [ zsh ];
        programs.zsh.enable = true;

        # Default shell
        environment.shells = with pkgs; [ zsh ];
        users.defaultUserShell = pkgs.zsh;
    };

}
