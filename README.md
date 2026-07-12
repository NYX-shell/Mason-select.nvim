# Mason-select

An mason package filter, selector. use "vim.ui.select" to select package and action.

## Install

how to install Mason-select

### Lazy.nvim

```lua
  {
    dir = "NYX-shell/mason-select.nvim/",
    dependencies = { "mason-org/mason.nvim" },
    opts = {},

    keys = { { "<leader>lM", function() require("mason-select").open() end, { desc = "Select package (Mason)" } } },
  },
```

## Configuration

Default options:

```lua
local default = {
  auto = true, -- Auto include current language
  filter = {
    spec = {
      categories = {
        "LSP", -- aways include "LSP"
        -- "DAP", -- aways exclude "DAP", if comment
        "Linter",
        "Formatter",
      },
      languages = {
        -- "Lua" -- recommand to leave this empty, for auto-include language
      },
    },
  },
}
```

## Usage

You can manually include lanuage for your need.

```lua
require("mason-select").open({"rust", "c++"}) 
```
