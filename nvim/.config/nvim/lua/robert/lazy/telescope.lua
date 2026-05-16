return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files in cwd" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, {}, { desc = "Telescope find files tracked by git" })
		vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Telescope live ripgrep" })
		vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Telescope show diagnostics for open buffers" })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Telescope search through files with ripgrep" })
	end,
}
