return {
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "[D]iagnostics [R]oot" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[D]iagnostics [B]uffer" },
      { "<leader>xS", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "[D]iagnostics [S]ymbols" },
    },
  },
}
