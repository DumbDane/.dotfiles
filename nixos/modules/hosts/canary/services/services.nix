{ self, ... }:
{
  flake.modules.nixos.canary = {
    imports = with self.modules.nixos; [
      # nut
      # nextcloud
      # forgejo
    ];
  };
}
