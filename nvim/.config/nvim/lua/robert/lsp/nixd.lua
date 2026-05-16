return {
    cmd = { "nixd" },
    filetypes = { "nix" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "(builtins.getFlake (toString ./.)) .inputs.nixpkgs",
            },
            formatting = {
                command = { "nixfmt" }, -- or nixfmt or nixpkgs-fmt
            },
            -- options = {
            --   nixos = {
            --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
            --   },
            --   home_manager = {
            --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
            --   },
            -- },
        },
    },
}
