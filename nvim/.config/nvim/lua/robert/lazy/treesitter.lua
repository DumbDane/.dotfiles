return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local languages = {
			"vim",
			"vimdoc",
			"lua",
			"query",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"java",
			"rust",
			"dockerfile",
			"yaml",
		}

		treesitter.install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function(args)
				local buf = args.buf
				local file = vim.api.nvim_buf_get_name(buf)

				local ok, stats = pcall(vim.loop.fs_stat, file)
				if ok and stats and stats.size > 1024 * 1024 then
					vim.notify(
						"File larger than 1 MB; treesitter disabled for performance",
						vim.log.levels.WARN,
						{ title = "Treesitter" }
					)
					return
				end

        local bufok, err = pcall(vim.treesitter.start, buf)
        if not bufok then
          vim.notify(
            "Treesitter unavailable for "
            .. vim.bo[buf].filetype
            .. " until parser is installed.",
            vim.log.levels.WARN,
            { title = "Treesitter" }
          )
          return
        end
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
