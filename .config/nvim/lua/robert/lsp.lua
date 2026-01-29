local function has(cmd)
	return vim.fn.executable(cmd) == 1
end

local function on_attach(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

local lsp_configs = vim.api.nvim_get_runtime_file("lua/robert/lsp/*.lua", true)

for _, file in pairs(lsp_configs) do
	local ok, config = pcall(dofile, file)

	if ok and type(config) == "table" then
		-- Ensure capabilities exist (but don't mutate protocol shapes)
		config.capabilities =
			vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), config.capabilities or {})

		-- Compose on_attach if the server defines its own
		local server_on_attach = config.on_attach
		config.on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			if server_on_attach then
				server_on_attach(client, bufnr)
			end
		end

		local name = vim.fn.fnamemodify(file, ":t:r")
		local cmd = config.cmd and config.cmd[1]

		if cmd and has(cmd) then
			vim.lsp.config[name] = config
			vim.lsp.enable(name)
		end
	else
		vim.notify("Failed to load LSP config: " .. file, vim.log.levels.WARN)
	end
end
