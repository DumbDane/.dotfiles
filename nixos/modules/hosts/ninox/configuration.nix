{
  inputs,
  ...
}:
{
  flake.modules.nixos.ninox =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        system-desktop
        systemd-boot
        robert
      ];

      users.users.robert = {
        extraGroups = [
          "audio"
          "input"
          "gamemode"
        ];
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
      system.stateVersion = "24.11";
    };
}
