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
