return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				imports = { granularity = { group = "module" }, prefix = "self" },
				cargo = {
					buildScripts = { enable = true },
					--allFeatures = true,
				},
				check = {
					command = "clippy",
				},
			},
		},
	},
}
