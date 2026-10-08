{
  self,
  ...
}:
{
  flake.modules.darwin.macaw = { pkgs, ... }: {

    imports = with self.modules.darwin; [
      system-desktop
    ];
    #         modules = [
    #           { nixpkgs.pkgs = macpkgs; }
    #           ./macaw/configuration.nix
    #           mac-app-util.darwinModules.default
    #           nix-homebrew.darwinModules.nix-homebrew
    #           {
    #             nix-homebrew = {
    #               enable = true;
    #               enableRosetta = true;
    #               user = "lauridspedersen";
    #               autoMigrate = true;
    #             };
    #           }
    #         ];

    environment.systemPackages = with pkgs; [
      uv
      ruff
      ffmpeg
      imagemagick
      minikube
      nodejs
      postman
      vscode
      tailscale
    ];

    system.primaryUser = "lauridspedersen";

  };
}
