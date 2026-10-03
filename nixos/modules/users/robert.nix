{ self, ... }:
let
  name = "robert";
in
{
  nixos."${name}" =
    { pkgs, ... }:
    {
      users.users."${name}" = {
        isNormalUser = true;
        description = "Laurids Robert Holme Pedersen";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];

        shell = pkgs.zsh;

        imports = with self.modules.nixos; [
          # things
        ];

        packages = with pkgs; [
          stow
          fzf
          zoxide
          gcc
          unzip
          jq
          # powertop
        ];
      };
    };
}
