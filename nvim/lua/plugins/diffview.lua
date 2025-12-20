return {
  {
    "sindrets/diffview.nvim",
    enabled = true,
    config = function()
      require("diffview").setup({})
      vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewOpen HEAD~1<CR>", { desc = "Diff Current", silent = false })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diff History", silent = false })
      vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewOpen HEAD~1<CR>", { desc = "Diff Close", silent = false })
    end,
  },
}
