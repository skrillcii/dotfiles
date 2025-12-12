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
-- LSP Hover
vim.keymap.set("n", "<S-l>", vim.lsp.buf.hover, { desc = "LSP Hover" })

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
vim.keymap.set("n", "<C-h>", [[<cmd>vertical resize +2<cr>]])
vim.keymap.set("n", "<C-l>", [[<cmd>vertical resize -2<cr>]])
vim.keymap.set("n", "<C-k>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-j>", [[<cmd>horizontal resize -2<cr>]])

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
