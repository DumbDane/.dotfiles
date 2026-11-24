let
  name = "isaac";
in
{
  flake.modules.nixos."${name}" =
    { pkgs, ... }:
    {
      users.users."${name}" = {
        isNormalUser = true;
        extraGroups = [ "docker" ];
        hashedPassword = "!";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBGKYFOsXxDnWfU+q46ISBWrijprdh+Q/Rv3i1SkxeR macaw"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsBW62i8Ix4OdLSHfKG4G9cat/2W10nM6Jwo0undjdV lp@voli.dk"
        ];
        shell = pkgs.zsh;
      };

      programs.zsh.enable = true;
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      services.displayManager.hiddenUsers = [ "${name}" ];

    };
}
