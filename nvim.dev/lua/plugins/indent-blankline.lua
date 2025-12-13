return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config

    config = function()
      require("ibl").setup()

      --   local highlight = {
      --     "RainbowRed",
      --     "RainbowYellow",
      --     "RainbowBlue",
      --     "RainbowOrange",
      --     "RainbowGreen",
      --     "RainbowViolet",
      --     "RainbowCyan",
      --   }
      --   local hooks = require("ibl.hooks")
      --   -- create the highlight groups in the highlight setup hook, so they are reset
      --   -- every time the colorscheme changes
      --   hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      --     vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#fb4934" })
      --     vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#fabd2f" })
      --     vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#83a598" })
      --     vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fe8019" })
      --     vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#b8bb26" })
      --     vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#d3869b" })
      --     vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56b6c2" })
      --   end)
      --   require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },
}
