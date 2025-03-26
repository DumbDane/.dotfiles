vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move highlighted lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- 'J' puts cursor to end of line and appends next line to current line, this stops the cursor move
vim.keymap.set("n", "J", "mzJ`z") 

-- Keep cursor in the middle of the screen when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allow for 'highlight and replace' without losing buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Delete into the void
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Yank into clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- New tmux session (use <C-b>+L to get back)(primeagen has tmux set at C-a, assuming bc dvorak?)
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format document
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix navigation??
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Find and replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Convert current file to executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


-- Go to definition and uses
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gu", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>q", vim.cmd.cclose)

