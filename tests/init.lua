--[[ Save this as init.lua and run with:
        nvim -u init.lua
-- ]]

-- Basic settings
vim.opt.compatible = false

-- Set leader key (must be set before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set built-in colorscheme
vim.cmd [[colorscheme vim]]

-- clear data for test
-- vim.fs.rm(
--   vim.fn.stdpath "data",
--   { recursive = true }
-- )

-- Install lazy.nvim if it doesn't exist
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup {
  {
    dir = "~/projects/nvim-plugin/Mason-select.nvim",
    -- "NYX-shell/Mason-select.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      opts = {}
    },
    opts = {},

    keys = { { "<leader>lM", function() require("mason-select").open() end, desc = "Select package (Mason)" } },
  },
}
