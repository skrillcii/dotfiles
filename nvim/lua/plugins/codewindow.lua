return {
  "gorbit99/codewindow.nvim",
  config = function()
    local codewindow = require("codewindow")
    codewindow.setup()
    vim.keymap.set("n", "<leader>mm", codewindow.toggle_minimap, { desc = "toggle minimap" })
    vim.keymap.set("n", "<leader>mf", codewindow.toggle_focus, { desc = "toggle minimap" })
  end,
}
