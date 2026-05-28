return {
    cmd = { "dart", "language-server", "--protocol=lsp" },
    filetypes = { "dart" },
    root_markers = { "pubspec.yaml", ".git" },

    settings = {
        dart = {
            completeFunctionCalls = true,
            showTodos = true,
            lineLength = 100,
        },
    },

    on_attach = function(client, bufnr)
        -- Optional: enable formatting via dart format
        client.server_capabilities.documentFormattingProvider = true
    end,
}
