return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    -- Keymappings
    vim.keymap.set("n", "<Space>n", "<cmd>Neotree toggle<CR>"),
  },
}
