return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim", opts = {} },
      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },
      -- Allows extra capabilities provided by blink.cmp
      { "saghen/blink.cmp", opts = {} },
    },
  },
}
