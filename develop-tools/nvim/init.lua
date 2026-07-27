vim.lsp.config["nixd"] = {
        cmd = { 'nixd' },
        filetypes = { "nix" },
	root_markers = { "flake.nix", ".git","shell.nix", "default.nix" },
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
vim.opt.completeopt = { 'menu', 'menuone' , 'noinsert' }
vim.lsp.enable('nixd')
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			client.server_capabilities.completionProvider =client.server_capabilities.completionProvider or {}
			local chars = {}
			for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true,client.id, args.buf, { autotrigger = true })
		end
	end
})
local modeList = {"i","n","v","x", "s"}
vim.keymap.set(modeList,"<C-s>","<Esc>:w<CR>",{})
vim.keymap.set(modeList,"<C-S-k>",'<Esc>"_ddi')
vim.keymap.set(modeList, "<C-x>", "<Esc>dd")
vim.keymap.set(modeList, "<C-c>", "<Esc>yy")
vim.keymap.set(modeList, "<C-v>","<Esc>pi")

vim.keymap.set("v", "<BS>",'"_d')

for _, mode in ipairs(modeList) do
	vim.keymap.set(mode, "<C-/>", "<Esc>gcc".. mode, {remap=true})
end


local arrows = { "Up", "Down", "Left", "Right" }

for _, arrow in ipairs(arrows) do
	vim.keymap.set("n", "<C-S-" .. arrow .. ">", "v<C-" .. arrow .. ">")
	vim.keymap.set("i", "<C-S-" .. arrow .. ">", "<C-o>v<C-".. arrow .. ">" )
	vim.keymap.set("v", "<C-S-" .. arrow .. ">","<C-" .. arrow .. ">")
end
vim.keymap.set({"i", "v" ,"n"}, "<C-d>", "<Esc>viw")

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

