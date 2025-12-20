return {
  -- File: ~/.config/nvim/plugin/my_first_plugin.lua
  vim.api.nvim_create_user_command(
    "HelloWorld", -- The name of the command (:HelloWorld)
    function()
      print("Hello, World from my first plugin!") -- Print a message
    end,
    {
      nargs = 0, -- Command takes no arguments
      desc = "Prints a greeting", -- Description for help docs
    }
  ),
}
