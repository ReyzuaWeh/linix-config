require("copilot").setup({
    suggestion = {
        enabled = true,
        auto_trigger = false,

        keymap = {
            accept = false,
            accept_word = false,
            accept_line = false,
            next = false,
            prev = false,
            dismiss = false,
        },
    },
    panel = {
        enabled = false,
    },
})

local suggestion = require("copilot.suggestion")

vim.keymap.set("i", "<M-CR>", function()
    suggestion.accept()
end)

vim.keymap.set("i", "<M-]>", function()
    suggestion.next()
end)

vim.keymap.set("i", "<M-[>", function()
    suggestion.prev()
end)

vim.keymap.set("i", "<C-]>", function()
    suggestion.dismiss()
end)
