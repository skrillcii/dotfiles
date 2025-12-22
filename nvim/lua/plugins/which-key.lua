return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "List local buffer keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      -- Sort keymap list
      wk.setup({
        sort = { "local", "desc", "group", "alphanum", "mod" },
      })
      -- Add names to keymap groups
      wk.add({
        { "<leader>c", group = "Check" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>f", group = "Format" },
        { "<leader>g", group = "Git" },
        { "<leader>/", group = "Search" },
        -- Add descriptions to existing keymaps
        { "<leader>fa", desc = "[F]ormat [A]lign" },
        { "<leader>fA", desc = "[F]ormat [A]lign with preview" },
      })
    end,
  },
}
