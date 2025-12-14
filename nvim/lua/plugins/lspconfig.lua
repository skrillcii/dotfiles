return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Language Servers
          "lua-language-server", -- A language server for Lua
          "vim-language-server", -- A language server for Vim
          "bash-language-server", -- A language server for Bash
          "pyright", -- A language server for Python
          -- Formatters, Linters
          "stylua", -- A formatter for Lua
          "black", -- A formatter for Python code
          "isort", -- A formatter for Python imports
          "ruff", -- A formatter & linter for Python
        },
      })
    end,
  },
}
