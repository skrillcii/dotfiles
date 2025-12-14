-- Enable LSP server(s)
-- Note:
--  Enabling the local custom LSP server at "~/.config/nvim/lsp/*"
--  "<package_name>" must match "~/.config/nvim/lsp/<package_name>.lua".
vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")

-- Enable rounded borders in floating windows
vim.o.winborder = "rounded"

-- Set up an LspAttach autocommand to enable features based on client
--  capabilities. A single autocommand can work for multiple LSP servers!
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method("textDocument/completion") then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })

-- Add noselect to completeopt, otherwise autocompletion is annoying
-- vim.cmd("set completeopt+=noselect")

-- Enable virtual lines
-- vim.diagnostic.config({
--   virtual_lines = true,
-- })
