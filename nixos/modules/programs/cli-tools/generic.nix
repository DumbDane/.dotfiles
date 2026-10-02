let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        direnv
        git
        sops
        stow
        tmux

        docker
        docker-compose

        # Needed for nvim (& formatting)
        docker-compose-language-service
        docker-ls
        dockerfile-language-server
        lua-language-server
        nixd
        nixfmt
        pyright
        ripgrep
        ruff
        stylua
        tree-sitter

        # Needed for zsh
        fzf
        zoxide
      ];
    };
in
{
  flake.modules.nixos.cli-tools = {
    imports = [ genericPackages ];
  };

  flake.modules.darwin.cli-tools = {
    imports = [ genericPackages ];
  };
}
