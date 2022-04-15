-- Wizard Nvim Modules

local is_plugin_disabled = require("wizard.utils")
-- local use_floating_win_packer = require("doom.core.config").config.doom.use_floating_win_packer

-- Download Packer

local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  --require("doom.extras.logging").info("Bootstrapping packer.nvim, please wait ...")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    packer_path,
  })
end

-- Load packer
vim.cmd([[ packadd packer.nvim ]])
local packer = require("packer")

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
    open_fn = use_floating_win_packer and function()
      return require("packer.util").float({ border = "single" })
    end or nil,
  },
  profile = {
    enable = true,
  },
})

packer.startup(function(use)
  -- Core ---

  -- Plugin manager
  use({
    "wbthomason/packer.nvim",
    opt = true,
  })

  use({
    "nvim-lua/plenary.nvim",
    -- commit = pin_commit("563d9f6d083f0514548f2ac4ad1888326d0a1c66"),
    module = "plenary",
  })

  -- Snippets
  local disabled_snippets = is_plugin_disabled("snippets")

  -- Autopairs
  local disabled_autopairs = is_plugin_disabled("autopairs")

  -- CMP
  use({
    "hrsh7th/nvim-cmp",
    wants = { "LuaSnip" },
    requires = {
      {
        "L3MON4D3/LuaSnip",
        event = "BufReadPre",
        wants = "friendly-snippets",
        config = require("wizard.modules.config.luasnip"),
        disable = disabled_snippets,
        requires = { "rafamadriz/friendly-snippets" },
      },
      {
        "windwp/nvim-autopairs",
         config = require("wizard.modules.config.autopairs"),
         disable = disabled_autopairs,
         event = "BufReadPre",
      },
    },
    config = require("wizard.modules.config.cmp"),
    disable = disabled_lsp,
    event = "InsertEnter",
  })
  use({
    "hrsh7th/cmp-nvim-lua",
    disable = disabled_lsp,
    after = "nvim-cmp",
  })
  use({
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  })
  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
  })
  use({
    "hrsh7th/cmp-buffer",
    disable = disabled_lsp,
    after = "nvim-cmp",
  })
  use({
    "saadparwaiz1/cmp_luasnip",
    disable = disabled_lsp,
    after = "nvim-cmp",
  })

  -- LSP
  local disabled_lsp = is_plugin_disabled("lsp")
  use({
    "neovim/nvim-lspconfig",
    config = require("wizard.modules.config.lspconfig"),
    disable = disabled_lsp,
  })


  -- UI

  -- Dashboard
  local disabled_dashboard = is_plugin_disabled("dashboard")
  use({
    "glepnir/dashboard-nvim",
    disable = disabled_dashboard,
  })

  -- Custom Plugins
end)
