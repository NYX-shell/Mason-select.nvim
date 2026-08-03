local mason = require "mason-select.mason_tools" -- Import Utility tools
local builtin = require "mason-select.builtin"

local M = {}

-- vim.print() -- for debug
M.open = function(include_languages)
  -- filter languages from opts and arg1
  local available_packages_name = M.get_available_packages_name(include_languages)
  if available_packages_name == nil then
    vim.notify("Mason-select: no found available package", vim.log.levels.WARN)
    return
  end

  builtin.select_package(available_packages_name)
end

function M.get_available_packages_name(include_languages) return builtin.available_packages_name(include_languages) end

--@param opts? myplugin.Config
function M.setup(opts) require("mason-select.config").setup(opts) end

return M
