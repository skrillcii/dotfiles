return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
          vim.notify("Format for current buffer")
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
      {
        "<leader>ft",
        function()
          -- If autoformat is currently disabled for this buffer,
          -- then enable it, otherwise disable it
          if vim.b.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Enabled autoformat for current buffer")
          else
            vim.cmd("FormatDisable!")
            vim.notify("Disabled autoformat for current buffer")
          end
        end,
        desc = "[T]oggle autoformat for current buffer",
      },
      {
        "<leader>fT",
        function()
          -- If autoformat is currently disabled globally,
          -- then enable it globally, otherwise disable it globally
          if vim.g.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Enabled autoformat globally")
          else
            vim.cmd("FormatDisable")
            vim.notify("Disabled autoformat globally")
          end
        end,
        desc = "[T]oggle autoformat globally",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,

      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },

    -- Create custom toggle commands
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- :FormatDisable! disables autoformat for this buffer only
          vim.b.disable_autoformat = true
        else
          -- :FormatDisable disables autoformat globally
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true, -- allows the ! variant
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
