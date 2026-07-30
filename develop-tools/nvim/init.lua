require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		python = { "black" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true
		}
	}
})
local ms = require("multicursor-nvim")
ms.setup()

vim.lsp.config["nixd"] = {
	cmd = { 'nixd' },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git", "shell.nix", "default.nix" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import <nixpkgs> { }'
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.linix-os.options'
				}
			}
		},

	}
}
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true
vim.lsp.enable('nixd')
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			client.server_capabilities.completionProvider = client.server_capabilities.completionProvider or
			    {}
			local chars = {}
			for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end
})

vim.opt.guicursor:append("n:ver25")
vim.opt.virtualedit:append("onemore")
vim.opt.number = true

vim.cmd("colorscheme kanagawa")

local modeList = { "i", "n", "v", "x", "s" }
vim.keymap.set(modeList, "<C-s>", "<Cmd>:w<CR>", {})
vim.keymap.set(modeList, "<Esc>", function()
	if not ms.cursorsEnabled() then
		ms.enableCursors()
	elseif ms.hasCursors() then
		ms.clearCursors()
	end
	if vim.v.hlsearch == 1 then
		vim.cmd("noh")
		vim.fn.setreg("/", "")
		return ""
	end
	return "<Esc>"
end, { expr = true, silent = true })

vim.keymap.set("n", "<CR>", "i<CR>")
vim.keymap.set("n", "<BS>", "i<BS>")
vim.keymap.set("n", "<C-e>", ":Ex<CR>")
vim.keymap.set("n", "<End>", "<End><Right>")
vim.keymap.set("n", "<C-g>", "<Cmd>LazyGit<CR>")
vim.keymap.set(modeList, "<C-b>", "<Cmd>Neotree toggle show left dir=./<CR>")
vim.keymap.set(modeList, "<C-Space>", "<Cmd>Neotree toggle float dir=./<CR>")

vim.keymap.set("i", "<C-f>", "<Esc>:/")
vim.keymap.set("i", "<M-d>", "<Cmd>normal *<CR>")
vim.keymap.set("i", "<M-S-d>", "<Cmd>normal #<CR>")
vim.keymap.set("i", "<M-S-d>.", "<Cmd>normal #<CR>")
vim.keymap.set("i", "<M-S-Up>", "<Cmd>normal \"zyyP<CR><Cmd>:let @z=\"\"<CR>")
vim.keymap.set("i", "<M-S-Down>", "<Cmd>normal \"zyyp<CR><Cmd>:let @z=\"\"<CR>")
vim.keymap.set("i", "<C-z>", "<Cmd>normal u<CR>")
vim.keymap.set("i", "<C-y>", "<Cmd>normal <C-r><CR>")
vim.keymap.set("i", "<C-BS>", "<Left><C-o>v<C-Left>\"_d")
vim.keymap.set("i", "<C-d>", "<C-o>viw")
vim.keymap.set({ "i", "n" }, "<F2>", vim.lsp.buf.rename)

vim.keymap.set({ "n", "x" }, "<C-d>", function()
	ms.matchAddCursor(1)
end)
vim.keymap.set("x", "<C-i>", ms.insertVisual)

vim.keymap.set("v", "<BS>", function()
	vim.cmd('normal! "_d')
end)

for _, mode in ipairs(modeList) do
	vim.keymap.set(mode, "<C-/>", (mode ~= "x" and "<Esc>gcc" or "gc"), { remap = true })
	vim.keymap.set(mode, "<C-c>", (mode ~= "x" and "<Cmd>normal yy<CR>" or "y"))
	vim.keymap.set(mode, "<C-x>", (mode ~= "x" and "<Cmd>normal dd<CR>" or "d"))
	vim.keymap.set(mode, "<C-v>", (mode ~= "x" and "<Left><Cmd>normal vp<CR>" or '"_dp'))
	vim.keymap.set(mode, "<C-S-k>", (mode ~= "x" and '<Cmd>normal "_ddi<CR>' or '<Cmd>normal <S-v>"_d<CR>'))
end

local arrows = { "Up", "Down", "Left", "Right" }

for _, arrow in ipairs(arrows) do
	vim.keymap.set("n", "<C-S-" .. arrow .. ">", "<" .. arrow .. ">" .. "v<C-" .. arrow .. ">")
	vim.keymap.set("i", "<C-S-" .. arrow .. ">", "<Left>" .. "<C-o>v<C-" .. arrow .. ">")
	vim.keymap.set("v", "<C-S-" .. arrow .. ">", "<C-" .. arrow .. ">")
	if arrow == "Up" or arrow == "Down" then
		vim.keymap.set("i",
			"<M-" .. arrow .. ">",
			"<Cmd>move ." .. (arrow == "Up" and "-2<" or "+1") .. ">" .. "<CR>"
		)
	end
end

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".git" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
}
vim.lsp.enable("lua_ls")
