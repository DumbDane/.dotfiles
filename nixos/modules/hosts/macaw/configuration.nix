{
  self,
  ...
}:
{
  flake.modules.darwin.macaw = {

    imports = with self.modules.darwin; [
      system-desktop
      browser
      homebrew
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

    system.primaryUser = "lauridspedersen";

  };
}
