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
        preset = "modern",
        sort = {"group", "local", "desc"},
      })
      -- Add names to keymap groups
      wk.add({
        -- Add keymap groups
        { "<leader>c", group = "Check" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>f", group = "Format" },
        { "<leader>g", group = "Git" },
        { "<leader>/", group = "Search" },
        { "<leader>a", group = "LSP" },
        -- Add descriptions to existing keymaps
        { "<leader>fa", desc = "[F]ormat [A]lign" },
        { "<leader>fA", desc = "[F]ormat [A]lign with preview" },
      })
    end,
  },
}
