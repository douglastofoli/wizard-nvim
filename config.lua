local M = {}

M.source = debug.getinfo(1, "S").source:sub(2)

M.config = {
  wizard = {
    -- Use floating window for plugins manager (packer)
    -- @default = false
    use_window_floating_packer = false,

    -- Auto install plugins on launch, useful if you don't want to run
    -- PackerInstall every time you add a new plugin
    -- @default = true
    -- WARNING: bug here when true
    auto_install_plugins = false,

    colorscheme = "catppuccin",
  },

  nvim = {
    autocmds = {},

    functions = {},

    mappings = {},
  },
}

M.modules = {}

M.plugins = {
  {
    "catppuccin/nvim",
    as = "catppuccin",
  },
  {
    "wakatime/vim-wakatime"
  },
}

return M
