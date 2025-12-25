-- NOTE: [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights on search" })
-- Close window
vim.keymap.set("n", "<space>w", "<cmd>:bd<CR>", { desc = "Close window" })
-- Quit window
vim.keymap.set("n", "<space>q", "<cmd>:q<CR>", { desc = "Quit window" })
-- Create new tab
vim.keymap.set("n", "<space>t", "<cmd>:tabnew<CR>", { desc = "Create new tab" })
-- Write to buffer
vim.keymap.set("n", "<space>s", "<cmd>:w<CR>", { desc = "Wrtie to buffer" })
-- Write to buffer
vim.keymap.set("n", "<space>d", "<cmd>:diffthis<CR>", { desc = "Diff this buffer" })
-- Write to buffer
vim.keymap.set("n", "<space>D", "<cmd>:diffoff<CR>", { desc = "Diff mode off" })
-- Check health
vim.keymap.set("n", "<space>ch", "<cmd>:checkhealth<CR>", { desc = "[C]heck [H]ealth" })
-- Lazy
vim.keymap.set("n", "<space>cl", "<cmd>:Lazy<CR>", { desc = "[C]heck [L]azy" })
-- Mason
vim.keymap.set("n", "<space>cm", "<cmd>:Mason<CR>", { desc = "[C]heck [M]ason" })
-- LSP
vim.keymap.set("n", "<S-l>", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })
-- LSP
-- vim.keymap.set("n", "<space>al", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "[L]SP Hover" })
-- vim.keymap.set("n", "<space>af", "<cmd>lua vim.lsp.buf.formatting()<CR>", { desc = "[L]SP Format" })
-- vim.keymap.set("n", "<space>ar", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "[L]SP References" })
-- vim.keymap.set("n", "<space>ad", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "[L]SP Definition" })
-- vim.keymap.set("n", "<space>aD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "[L]SP Declaration" })
-- vim.keymap.set("n", "<space>ai", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "[L]SP Implementation" })
-- vim.keymap.set("n", "<space>at", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "[L]SP Type Definition" })
-- vim.keymap.set("n", "<space>an", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "[L]SP Rename" })
-- vim.keymap.set("n", "<space>aa", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "[L]SP Code Action" })
-- vim.keymap.set("n", "<space>ae", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "[L]SP Open Float" })
-- vim.keymap.set("n", "<space>aj", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "[L]SP Go to Next" })
-- vim.keymap.set("n", "<space>ak", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "[L]SP Go to Previous" })
-- Diagnostic
vim.keymap.set("n", "gJ", vim.diagnostic.goto_next, { desc = "Diagnostic next" })
vim.keymap.set("n", "gK", vim.diagnostic.goto_prev, { desc = "Diagnostic previous" })
-- Move lines
vim.keymap.set("n", "<S-j>", "<cmd>:m +1<CR>", { desc = "Move line down" })
vim.keymap.set("n", "<S-k>", "<cmd>:m -2<CR>", { desc = "Move line up" })
-- Switch between windows
vim.keymap.set("n", "<space>h", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<space>l", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<space>j", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<space>k", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Move windows around
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
-- Resize window
vim.keymap.set("n", "<C-h>", [[<cmd>vertical resize +2<CR>]])
vim.keymap.set("n", "<C-l>", [[<cmd>vertical resize -2<CR>]])
vim.keymap.set("n", "<C-k>", [[<cmd>horizontal resize +2<CR>]])
vim.keymap.set("n", "<C-j>", [[<cmd>horizontal resize -2<CR>]])
