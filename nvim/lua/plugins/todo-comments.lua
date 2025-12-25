return {
  {
    -- INFO:
    -- TODO:
    -- TEST:
    -- WARN:
    -- FIX:

    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        NOTE = { icon = " ", color = "info", alt = { "INFO", "HINT" } },
        TODO = { icon = " ", color = "todo", alt = {} },
        TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        WARN = { icon = " ", color = "warn", alt = { "WARNING", "HACK" } },
        FIX = { icon = " ", color = "error", alt = { "FIXME", "FIXIT", "ISSUE", "BUG", "ERROR" } },
      },
      colors = {
        note = { "GruvboxBlueBold" },
        todo = { "GruvboxGreenBold" },
        test = { "GruvboxOrangeBold" },
        warn = { "GruvBoxYellowBold" },
        fix = { "GruvBoxRedBold" },
      },
    },
    vim.keymap.set("n", "<leader>xt", "<cmd>:TodoQuickFix<CR>", { desc = "[L]ist [T]odos Quickfix" }),
    vim.keymap.set("n", "<leader>xT", "<cmd>:TodoTrouble<CR>", { desc = "[L]ist [T]odos Trouble" }),
    vim.keymap.set("n", "<leader>/t", "<cmd>:TodoTelescope<CR>", { desc = "[S]earch [T]odos" }),
  },
}
