{ self, ... }:
let
  name = "robert";
in
{
  flake.modules.nixos."${name}" =
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

      programs.zsh.enable = true;
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      imports = with self.modules.nixos; [
        # things
      ];
    };
}
