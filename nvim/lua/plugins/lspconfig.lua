return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
      -- Enable LSP completion capability
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
      -- Enable Mason
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Enable Mason-Tool-Installer
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Language Servers
          "lua-language-server", -- A language server for Lua
          "basedpyright", -- A language server for Python
          "bash-language-server", -- A language server for Bash
          -- Formatters, Linters
          "stylua", -- A formatter for Lua
          "shfmt", -- A formatter for Bash
          "black", -- A formatter for Python code
          "isort", -- A formatter for Python imports
          "ruff", -- A formatter & linter for Python
          -- Parser(s)
          "tree-sitter-cli", -- A parser for syntax trees
        },
      })
    end,
  },
}
