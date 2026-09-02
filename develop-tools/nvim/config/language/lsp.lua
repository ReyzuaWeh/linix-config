local root = vim.fn.getcwd()
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

vim.lsp.config["lua_ls"] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
            workspaces = {
                library = { root .. "/develop-tools" },
            }
        }
    }
}
vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
})

vim.lsp.enable('nixd')
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
