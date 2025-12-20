return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
        dashboard.button("t", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("m", " " .. " Mason", "<cmd> Mason <cr>"),
        dashboard.button("h", " " .. " Check health", "<cmd> checkhealth <cr>"),
        dashboard.button("s", " " .. " Settings", "<cmd> Telescope find_files cwd=~/.config/nvim <cr>"),
        dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
        -- For Snacks.picker()
        -- dashboard.button("r", " " .. " Recent files", "<cmd> lua Snacks.picker.recent() <cr>"),
        -- dashboard.button("f", " " .. " Find file", "<cmd> lua Snacks.picker.files() <cr>"),
        -- dashboard.button("t", " " .. " Find text", "<cmd> lua Snacks.picker.grep() <cr>"),
      }

      -- Set fortune footer
      local fortune = require("alpha.fortune")
      dashboard.section.footer.val = fortune()

      -- Send config to alpha
      alpha.setup(dashboard.opts)
      -- Disable folding on alpha buffer
      vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])

      -- Highlight stats
      -- vim.api.nvim_create_autocmd("User", {
      --   once = true,
      --   pattern = "LazyVimStarted",
      --   callback = function()
      --     local stats = require("lazy").stats()
      --     local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      --     local loaded_str = tostring(stats.loaded)
      --     local count_str = tostring(stats.count)
      --     local ms_str = tostring(ms)
      --     local stats_line = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      --     dashboard.section.footer.val = stats_line
      --
      --     -- Calculate highlight positions
      --     local prefix = "⚡ Neovim loaded "
      --     local prefix_len = vim.fn.strdisplaywidth(prefix)
      --     local loaded_start = prefix_len + 1
      --     local loaded_end = loaded_start + #loaded_str
      --     local count_start = loaded_end + 1
      --     local count_end = count_start + #count_str
      --     local ms_start = count_end + #" plugins in "
      --     local ms_end = ms_start + #ms_str + 2
      --
      --     dashboard.section.footer.opts = dashboard.section.footer.opts or {}
      --     dashboard.section.footer.opts.hl = {
      --       { "Special", 0, 1},
      --       { "Special", loaded_start, count_end},
      --       { "Special", ms_start, ms_end },
      --     }
      --
      --     pcall(vim.cmd.AlphaRedraw)
      --   end,
      -- })
    end,
  },
}
