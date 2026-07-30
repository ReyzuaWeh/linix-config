require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

local builtin = require("telescope.builtin")

-- Ctrl+P (Quick Open)
vim.keymap.set("n", "<C-p>", builtin.find_files)

-- Ctrl+Shift+F (Search in files)
vim.keymap.set("n", "<C-S-f>", builtin.live_grep)

-- Ctrl+Shift+O (Go to Symbol in File)
vim.keymap.set("n", "<C-S-o>", builtin.lsp_document_symbols)

-- Ctrl+T (Opened editors / buffers)
vim.keymap.set("n", "<C-t>", builtin.buffers)

-- Ctrl+Shift+E (Explorer alternatif jika tidak pakai Neo-tree)
vim.keymap.set("n", "<C-S-e>", builtin.find_files)

-- F1 (Help tags)
vim.keymap.set("n", "<F1>", builtin.help_tags)
