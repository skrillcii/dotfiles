return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      -- Recognize 'vim' global for Neovim configs
      diagnostics = { globals = { "vim" } },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      hint = { enable = false, semicolon = "Disable" },
      codeLens = { enable = true },
    },
  },
}
