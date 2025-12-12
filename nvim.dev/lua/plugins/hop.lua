return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    require("hop").setup({
      multi_windows = true,
    })
  end,
  keys = {
    { mode = "", "gw", "<cmd>HopWord<CR>", desc = "Hop word" },
    { mode = "", "gl", "<cmd>HopLine<CR>", desc = "Hop line" },
  },
}
