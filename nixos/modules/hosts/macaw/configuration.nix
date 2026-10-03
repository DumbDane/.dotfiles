{
  self,
  ...
}:
{
  flake.modules.darwin.macaw = {

    imports = with self.modules.darwin; [
      browser
      homebrew
    ];

    system.primaryUser = "lauridspedersen";

  };
}
