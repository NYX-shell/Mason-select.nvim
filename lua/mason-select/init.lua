local mason = require "mason-select.mason_tools" -- Import Utility tools
local builtin = require "mason-select.builtin"
local config = require "mason-select.config"

local M = {}

-- vim.print() -- for debug
M.open = function(languages)
  local available_packages_name = mason.get_packages_name()

  -- config filter && languages
  local filter = config.options.filter
  if config.options.auto == true then table.insert(filter.spec.languages, vim.o.filetype) end
  if type(languages) == "string" then table.insert(filter.spec.languages, languages) end
  if type(languages) == "table" then vim.tbl_extend("force", filter.spec.languages, languages) end

  available_packages_name = builtin.filter(available_packages_name, filter)
  if next(available_packages_name) == nil then
    vim.print "Mason-select: no found available package"
    return
  end

  local selected_package_name = builtin.select_package(available_packages_name)
  if not selected_package_name then return end

  local selected_package = mason.get_package(selected_package_name)

  local action = builtin.select_action(selected_package)

  vim.print(action .. "ing " .. selected_package_name) -- prompt

  if action == "Install" then
    selected_package:install()
  elseif action == "Uninstall" then
    selected_package:uninstall()
  elseif action == "Reinstall" then
    selected_package:uninstall()
    selected_package:install()
  else
    return
  end
end

--@param opts? myplugin.Config
function M.setup(opts) require("mason-select.config").setup(opts) end

return M
