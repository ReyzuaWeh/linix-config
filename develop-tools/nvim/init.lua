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

-- require("blink.cmp").setup({
-- 	keymap = {preset = super-tab},
-- 	sources = {
-- 		default = { 'lsp', 'path', 'snippets', 'buffer' },
-- 	}
-- })
vim.opt.guicursor:append("n:ver25")
vim.opt.virtualedit:append("onemore")
vim.opt.number = true

vim.cmd("colorscheme kanagawa")

local modeList = { "i", "n", "v", "x", "s" }
vim.keymap.set(modeList, "<C-s>", "<Cmd>:w<CR>", {})
-- vim.keymap.set(modeList, "<C-S-k>", '<Esc>"_ddi')
-- vim.keymap.set(modeList, "<C-x>", "<Esc>dd")
-- vim.keymap.set(modeList, "<C-c>", "<Esc>yy")
-- vim.keymap.set(modeList, "<C-v>", "<Esc>pi")
vim.keymap.set(modeList, "<Esc>", function()
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
vim.keymap.set("i", "<M-S-Up>", "<Esc>yy<Home>pi")
vim.keymap.set("i", "<M-S-Down>", "<Esc>yy<End>pi<End>")
vim.keymap.set("i", "<C-z>", "<Cmd>normal u<CR>")
vim.keymap.set("i", "<C-y>", "<Cmd>normal <C-r><CR>")
vim.keymap.set("i", "<C-BS>", "<Left><C-o>v<C-Left>\"_d")

vim.keymap.set("v", "<BS>", '"_d')
-- vim.keymap.set("v", "<C-c>", "y")
-- vim.keymap.set("x", "<C-S-k>", '<Cmd>normal <S-v>"_d<CR>')
-- vim.keymap.set("x", "<C-v>", '"_dp')

for _, mode in ipairs(modeList) do
	vim.keymap.set(mode, "<C-/>", (mode ~= "x" and "<Esc>gcc" or "gc"), { remap = true })
	vim.keymap.set(mode, "<C-c>", (mode ~= "x" and "<Esc>yy" or "y"))
	vim.keymap.set(mode, "<C-x>", (mode ~= "x" and "<Esc>dd" or "d"))
	vim.keymap.set(mode, "<C-v>", (mode ~= "x" and "<Esc>pi" or '"_dp'))
	vim.keymap.set(mode, "<C-S-k>", (mode ~= "x" and '<Esc>"_ddi' or '<Cmd>normal <S-v>"_d<CR>'))
end

local arrows = { "Up", "Down", "Left", "Right" }

for _, arrow in ipairs(arrows) do
	vim.keymap.set("n", "<C-S-" .. arrow .. ">", "<" .. arrow .. ">" .. "v<C-" .. arrow .. ">")
	vim.keymap.set("i", "<C-S-" .. arrow .. ">", "<" .. arrow .. ">" .. "<C-o>v<C-" .. arrow .. ">")
	vim.keymap.set("v", "<C-S-" .. arrow .. ">", "<C-" .. arrow .. ">")
	if arrow == "Up" or arrow == "Down" then
		vim.keymap.set("i",
			"<M-" .. arrow .. ">",
			"<Cmd>normal Vd<CR><" ..
			(arrow == "Up" and "Home" or "End") .. ">" ..
			"<Cmd>normal p<CR>"
		)
	end
end
-- vim.keymap.set({"i", "v" ,"n"}, "<C-d>", "<Esc>viw")

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
-- require('lazydev').setup({
-- 		library = {
-- 			{ path = "luvit-meta/library", words = { 'vim%.uv' } }
-- 		}
-- })
