return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- lazy-load when formatting might happen
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      rust = { "rustfmt" },
      python = { "ruff_format" },
    },

    format_on_save = {
      lsp_fallback = false,
      timeout_ms = 500,
    },
  },
}
