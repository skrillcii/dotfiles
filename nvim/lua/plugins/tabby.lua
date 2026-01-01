return {
  {
    "nanozuki/tabby.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("tabby").setup({
        preset = "active_wins_at_tail",
        option = {
          nerdfont = true, -- whether use nerdfont
          lualine_theme = "gruvbox", -- lualine theme name
          tab_name = {
            name_fallback = function(tabid)
              return tabid
            end,
          },
          buf_name = {
            mode = "unique", -- or 'relative', 'tail', 'shorten'
          },
        },
      })
      vim.api.nvim_set_keymap("n", "<leader>th", ":-tabmove<CR>", { noremap = true, desc = "Move tab to previous" })
      vim.api.nvim_set_keymap("n", "<leader>tp", ":+tabmove<CR>", { noremap = true, desc = "Move tab to next" })
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tr",
        ":lua require('tabby').tab_rename(vim.fn.input('New tab name: '))<CR>",
        { noremap = true, silent = true, desc = "Rename current tab" }
      )
    end,
  },
}
