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
      require("which-key").add({
        -- Add names to keymap groups
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
