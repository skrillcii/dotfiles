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
              local api = require("tabby.module.api")
              local win_name = require("tabby.feature.win_name")
              local cur_win = api.get_tab_current_win(tabid)
              local name = ""
              if api.is_float_win(cur_win) then
                name = "[Floating]"
              else
                name = win_name.get(cur_win)
              end
              return name
            end,
            override = nil,
          },
          buf_name = {
            mode = "unique", -- or 'relative', 'tail', 'shorten'
          },
        },
      })
      -- Keybiding
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
