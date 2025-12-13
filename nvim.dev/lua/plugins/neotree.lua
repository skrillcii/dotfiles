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

    -- Keymaps settings
    vim.keymap.set("n", "<Space>n", "<cmd>Neotree toggle<CR>"),
    -- Git highlight color (change type)
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#fe8019" }),
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#fe8019" }),
    -- Git highlight color (status type)
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#fb4934" }),
    vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#fe8019" }),
    vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = "#fe8019" }),
    vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#fb4934" }),

    config = function()
      require("neo-tree").setup({
        use_default_mappings = false,
        enable_git_status = true,
        enable_diagnostics = false,
        default_component_configs = {
          container = {
            enable_character_fade = false,
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = true,
            use_filtered_colors = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "✚",
              modified = "~", --"" or "~"
              deleted = "✖",
              renamed = "󰁕",
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
        },
        window = {
          position = "left",
          width = 35,
          mappings = {
            ["<2-LeftMouse>"] = "open",
            ["o"] = "open",
            ["<CR>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = {
              "toggle_preview",
              config = {
                use_float = true,
                use_snacks_image = true,
                use_image_nvim = true,
              },
            },
            ["l"] = "focus_preview",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["Z"] = "close_all_subnodes",
            ["z"] = "expand_all_subnodes",
            ["a"] = {
              "add",
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["d"] = "delete",
            ["r"] = "rename",
            ["b"] = "rename_basename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["<C-r>"] = "clear_clipboard",
            ["c"] = "copy", -- accepts the optional config.show_path option like "add".
            ["m"] = "move", -- accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          },
        },
        filesystem = {
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["gk"] = "prev_git_modified",
              ["gj"] = "next_git_modified",
            },
          },
        },
      })
    end,
  },
}
