return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            format = {
                enable = false,
            },
            runtime = {
                version = "Lua 5.1",
            },
            diagnostics = {
                globals = {
                    "vim",
                    "bit",
                    "it",
                    "describe",
                    "before_each",
                    "after_each",
                },
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}
