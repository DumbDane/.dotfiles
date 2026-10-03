{
  inputs,
  ...
}:
{
  flake.modules.nixos.ninox = {
    imports = with inputs.self.modules.nixos; [
      minimal
      systemd-boot
      robert
    ];

  };

  flake.modules.nixos.robert =
    { pkgs, ... }:
    {

      users.users.robert = {
        extraGroups = [
          "audio"
          "input"
          "gamemode"
        ];
      };
      packages = with pkgs; [
        ripgrep
        direnv
        ghostty
        tailscale
        tree-sitter
        nixd
        pyright
        docker
        docker-compose
        docker-compose-language-service
        docker-ls
        prismlauncher
        unityhub
        nextcloud-client
        nixfmt
        zotero
        easyeffects
        thunderbird
      ];
    };
}
