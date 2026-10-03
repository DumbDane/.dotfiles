let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        tmux
        stow
        direnv
        ripgrep

        docker
        docker-compose

        # Needed for nvim (& formatting)
        tree-sitter
        lua-language-server
        stylua
        nixd
        nixfmt
        pyright
        ruff
        docker-compose-language-service
        docker-ls

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
