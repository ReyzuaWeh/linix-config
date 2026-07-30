vim.opt.runtimepath:append("/nix/store/...-vimplugin-multicursor.nvim")

local ms = require("multicursor-nvim")
ms.setup()

vim.keymap.set("n", "<C-d>", function()
    ms.matchAddCursor(1)
end)
