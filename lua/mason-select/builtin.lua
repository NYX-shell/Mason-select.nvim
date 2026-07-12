local mason = require "mason-select.mason_tools" -- Import Utility tools
local utils = require "mason-select.utils"

local M = {}

function M.filter(packages_name, filter)
  local filtered_packages_name = {}

  -- walk though all packages name
  for _, package_name in ipairs(packages_name) do
    local package = mason.get_package(package_name)
    local filter_categories = false
    local filter_languages = false

    for _, value in pairs(filter.spec.categories) do
      if utils.has_string(package.spec.categories, value) then filter_categories = true end
    end
    for _, value in pairs(filter.spec.languages) do
      if utils.has_string(package.spec.languages, value) then filter_languages = true end
    end

    if filter_categories and filter_languages then table.insert(filtered_packages_name, package_name) end
  end

  return filtered_packages_name
end

function M.select_package(packages_name)
  local package_name = ""

  vim.ui.select(packages_name, { prompt = "Support package(Mason)" }, function(item, _)
    if item then package_name = item end
  end)

  if package_name == "" then
    return
  else
    return package_name
  end
end

function M.select_action(package)
  local action

  if package:is_installed() then
    local actions = { "Reinstall", "Uninstall" }
    vim.ui.select(actions, { prompt = package.name .. " is installed, choose:" }, function(item, _)
      if item then action = item end
    end)
  else
    action = "Install"
  end

  return action
end

return M
