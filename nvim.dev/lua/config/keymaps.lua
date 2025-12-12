-- NOTE: [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Close window
vim.keymap.set("n", "<space>w", "<cmd>:bd<CR>")
-- Quit window
vim.keymap.set("n", "<space>q", "<cmd>:q<CR>")
-- Create new tab
vim.keymap.set("n", "<space>t", "<cmd>:tabnew<CR>")
-- Substitue
vim.keymap.set({ "n", "v" }, "s", "c")

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
vim.keymap.set("n", "<C-h>", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "<C-l>", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "<C-k>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-j>", [[<cmd>horizontal resize -2<cr>]])

-- Diagnostic keybindings
vim.keymap.set("n", "gJ", "vim.diagnostic.get_next", { desc = "Move cursor to the next diagnostic" })
vim.keymap.set("n", "gK", "vim.diagnostic.get_prev", { desc = "Move cursor to the previous diagnostic" })

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
