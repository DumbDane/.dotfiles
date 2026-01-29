local function has(cmd)
	return vim.fn.executable(cmd) == 1
end

local disable_formatting = {
	textDocument = {
		formatting = false,
		rangeFormatting = false,
	},
}

for _, f in pairs(vim.api.nvim_get_runtime_file("lua/robert/lsp/*.lua", true)) do
	local ok, config = pcall(dofile, f)
	if ok then
		config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, disable_formatting)
		local name = vim.fn.fnamemodify(f, ":t:r")
		local cmd = config.cmd and config.cmd[1]
		if cmd and has(cmd) then
			vim.lsp.config[name] = config
			vim.lsp.enable(name)
		end
	end

	if not ok then
		vim.notify("Failed to load LSP config: " .. f, vim.log.levels.WARN)
	end
end
