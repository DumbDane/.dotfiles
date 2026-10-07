return {
	"saghen/blink.cmp",
	version = "1.*",
	cond = not vim.g.vscode,

	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = true },
		},

		signature = {
			enabled = true,
		},
	},
}
