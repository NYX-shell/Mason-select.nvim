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

  -- call builtin selecter
  local selected_package_name = builtin.select_package(available_packages_name)
  if not selected_package_name then return end

  -- get mason package object
  local selected_package = mason.get_package(selected_package_name)

  -- builtin action selecter
  local action = builtin.select_action(selected_package)
  if not action then return end

  vim.notify(action .. "ing " .. selected_package_name, vim.log.levels.INFO)

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

function M.get_available_packages_name(include_languages) return builtin.available_packages_name(include_languages) end

--@param opts? myplugin.Config
function M.setup(opts) require("mason-select.config").setup(opts) end

return M
