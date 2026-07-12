local M = {}
local default = {
  auto = true,
  filter = {
    spec = {
      categories = {
        "LSP",
        "DAP",
        "Linter",
        "Formatter",
      },
      languages = {
        -- "Lua"
      },
    },
  },
}
local options

function M.setup(opts)
  options = vim.tbl_deep_extend("force", options or default, opts or {})
  M.options = {}
  M.options = options
end
return M
