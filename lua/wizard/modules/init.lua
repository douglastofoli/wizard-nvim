-- Wizard Nvim Modules

local system = require("wizard.core.system")
local is_plugin_disabled = require("wizard.utils").is_plugin_disabled
local use_window_floating_packer = require("wizard.core.config").config.use_window_floating_packer

-- Download Packer
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  -- require("wizard.extras.logging").info("Bootstrapping packer.nvim, please wait ...")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim",
  })
end

-- Load Packer
vim.cmd([[ packadd packer.nvim ]])
local packer = require("packer")

-- Change some defaults
packer.init({
  git = {
    clone_timeout = 300, -- 5 mins
    subcommands = {
      -- Prevent packer from downloading all branches metadata to reduce cloning cost
      -- for heavy size plugins like plenary (removed the '--no-single-branch' git flag)
      install = "clone --depth %i --progress",
    },
  },
  display = {
    open_fn = use_window_floating_packer and function()
      return require("packer.util").float({ border = "single" })
    end or nil,
  },
  profile = {
    enable = true,
  },
})

packer.startup(function(use)
  ------------------
  --     Core     --
  ------------------

  -- wbthomason/packer.nvim - A use-package inspired plugin manager for Neovim
  -- https://github.com/wbthomason/packer.nvim
  use({
    "wbthomason/packer.nvim",
    opt = true,
  })

  -- nvim-lua/plenary.nvim - All the lua functions I don't want to write twice.
  -- https://github.com/nvim-lua/plenary.nvim
  use({
    "nvim-lua/plenary.nvim",
    module = "plenary",
  })

  -- -- Disabled LSP/CMP
  local disabled_lsp = is_plugin_disabled("lsp")

  -----------------
  --     CMP     --
  -----------------

  -- hrsh7th/nvim-cmp - A completion engine plugin for neovim written in Lua
  -- https://github.com/hrsh7th/nvim-cmp
  use({
    "hrsh7th/nvim-cmp",
    wants = { "LuaSnip" },
    config = require("wizard.modules.config.cmp"),
    event = "InsertEnter",
    disable = disabled_lsp,
  })

  -- hrsh7th/cmp-nvim-lua - nvim-cmp source for nvim lua
  -- https://github.com/hrsh7th/cmp-nvim-lua
  use({
    "hrsh7th/cmp-nvim-lua",
    after = "nvim-cmp",
    disable = disabled_lsp,
  })

  -- hrsh7th/cmp-path - nvim-cmp source for path
  -- https://github.com/hrsh7th/cmp-path
  use({
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
    disable = disabled_lsp,
  })

  -- hrsh7th/cmp-nvim-lsp - nvim-cmp source for neovim builtin LSP client
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
    disable = disabled_lsp,
  })

  -- hrsh7th/cmp-buffer - nvim-cmp source for buffer words
  -- https://github.com/hrsh7th/cmp-buffer
  use({
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
    disable = disabled_lsp,
  })

  -- saadparwaiz1/cmp_luasnip - luasnip completion source for nvim-cmp
  -- https://github.com/saadparwaiz1/cmp_luasnip
  use({
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
    disable = disabled_lsp,
  })

  -----------------
  --     LSP     --
  -----------------

  -- neovim/nvim-lspconfig - Quickstart configurations for the Nvim LSP client
  -- https://github.com/neovim/nvim-lspconfig
  use({
    "neovim/nvim-lspconfig",
    config = require("wizard.modules.config.lspconfig"),
    disable = disabled_lsp,
  })

  use({
    "williamboman/nvim-lsp-installer",
    config = require("wizard.modules.config.lsp-installer"),
    after = "nvim-lspconfig",
    disable = disabled_lsp,
  })

  -- jose-elias-alvarez/null-ls.nvim - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    disable = disabled_lsp,
  })

  -- tamago324/nlsp-settings.nvim - A plugin for setting Neovim LSP with JSON or YAML files
  -- https://github.com/tamago324/nlsp-settings.nvim
  use({
    "tamago324/nlsp-settings.nvim",
    after = "nvim-lspconfig",
    disable = disabled_lsp,
  })

  ----------------------
  --     Snippets     --
  ----------------------

  -- LuaSnip
  local disabled_snippets = is_plugin_disabled("snippets")
  use({
    "L3MON4D3/LuaSnip",
    event = "BufReadPre",
    wants = "friendly-snippets",
    config = require("wizard.modules.config.luasnip"),
    requires = { "rafamadriz/friendly-snippets" },
    disable = disabled_snippets,
  })

  --------------------
  --     Editor     --
  --------------------

  -- Autopairs
  local disabled_autopairs = is_plugin_disabled("autopairs")
  use({
    "windwp/nvim-autopairs",
    config = require("wizard.modules.config.autopairs"),
    event = "BufReadPre",
    disable = disabled_autopairs,
  })

  ----------------
  --     UI     --
  ----------------

  -- Dashboard
  local disabled_dashboard = is_plugin_disabled("dashboard")
  use({
    "glepnir/dashboard-nvim",
    config = require("wizard.modules.config.dashboard"),
    disable = disabled_dashboard,
  })

  -- rcarriga/nvim-notify - A fancy, configurable, notification manager for NeoVim
  -- https://github.com/rcarriga/nvim-notify
  local disabled_notify = is_plugin_disabled("notify")
  use({
    "rcarriga/nvim-notify",
    config = require("wizard.modules.config.notify"),
    disable = disabled_notify,
  })

  local custom_plugins = require("wizard.core.config").plugins
  -- Custom plugins
  for _, plug in pairs(custom_plugins or {}) do
    packer.use(plug)
  end
end)
