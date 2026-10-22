{
  self,
  ...
}:
{
  flake.modules.darwin.macaw = { pkgs, ... }: {

    imports = with self.modules.darwin; [
      system-desktop
      vpn
    ];
    environment.systemPackages = with pkgs; [
      uv
      ruff
      ffmpeg
      imagemagick
      minikube
      nodejs
      postman
      vscode
      proton-pass
    ];

    system.primaryUser = "lauridspedersen";

  };
}
