--------------------------------
-- modules.lua - Load modules --
--------------------------------


local modules = {}

modules.modules = {
  ui = {
    "dashboard",
    "indentlines",
    "statusline",
    "tabline",
    "which-key",
    -- "zen"
  },
  editor = {
    "autopairs",
    "auto-session",
    "dap",
    "explorer",
    "formatter",
    "gitsigns",
    "kommentary",
    "lsp",
    -- "minimap",
    -- "ranger",
    "snippets",
    "symbols",
    "telescope",
  },
  langs = {
    -- "css",
    "elixir",
    "lua",
  },
}

modules.source = nil

return modules
