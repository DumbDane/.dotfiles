{
  inputs,
  ...
}:
{
  flake.modules.nixos.system-cli = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      cli-tools
      shell
      system-default
      virtualization
      vpn
    ];

    users.defaultUserShell = pkgs.zsh;
  };

  flake.modules.darwin.system-cli = { pkgs, ... }: {
    imports = with inputs.self.modules.darwin; [
      system-default
      cli-tools
      shell
    ];
    programs.zsh.enable = true;
    environment.systemPackages = [ pkgs.neovim ];
  };
}
