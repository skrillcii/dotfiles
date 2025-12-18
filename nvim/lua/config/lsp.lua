-- Enable LSP server(s)
vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("lua_ls")

-- Enable rounded borders in floating windows
vim.o.winborder = "rounded"

-- Set up an LspAttach autocommand to enable features based on client
--  capabilities. A single autocommand can work for multiple LSP servers!
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

-- Enable virtual lines
-- vim.diagnostic.config({
--   virtual_lines = true,
-- })
--
