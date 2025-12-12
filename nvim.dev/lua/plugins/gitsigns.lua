return {
  {
    "lewis6991/gitsigns.nvim",
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },

      -- Keymappings
      vim.keymap.set("n", "gk", function()
        require("gitsigns").nav_hunk("prev")
      end, { desc = "Go to previous hunk" }),
      vim.keymap.set("n", "gj", function()
        require("gitsigns").nav_hunk("next")
      end, { desc = "Previous hunk" }),
    },
  },
}
