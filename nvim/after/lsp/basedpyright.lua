return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "requirements.txt",
    ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        extraPaths = {
          "./source/isaaclab",
          "./source/isaaclab_assets",
          "./source/isaaclab_mimic",
          "./source/isaaclab_rl",
          "./source/isaaclab_tasks",
        },
      },
    },
  },
}
