local mason = require("mason-select.mason_tools") -- Import Utility tools
local utils = require("mason-select.utils")
local config = require("mason-select.config")

local M = {}

function M.filter(packages_name, filter)
  local filtered_packages_name = {}

  -- walk though all packages name
  for _, package_name in ipairs(packages_name) do
    local package = mason.get_package(package_name)
    local filter_categories = false
    local filter_languages = false

    for _, value in pairs(filter.spec.categories) do
      if utils.has_string(package.spec.categories, value) then
        filter_categories = true
      end
    end
    for _, value in pairs(filter.spec.languages) do
      if utils.has_string(package.spec.languages, value) then
        filter_languages = true
      end
    end

    if filter_categories and filter_languages then
      table.insert(filtered_packages_name, package_name)
    end
  end

  return filtered_packages_name
end

function M.available_packages_names(include_languages)
  local available_packages_name = mason.get_packages_name()
  if next(available_packages_name) == nil then
    vim.notify("Mason-registry: return \"nil\"\nCheck is Mason config correctly.", vim.log.levels.ERROR)
    return nil
  end

  -- config filter && languages
  local filter = config.options.filter
  -- add runtime_filetype -> {filter_languages}
  if config.options.auto == true then
    table.insert(filter.spec.languages, vim.o.filetype)
  end
  -- merge {filter_languages} with arg1
  if type(include_languages) == "string" then
    table.insert(filter.spec.languages, include_languages)
  end
  if type(include_languages) == "table" then
    vim.tbl_extend("force", filter.spec.languages, include_languages)
  end

  available_packages_name = M.filter(available_packages_name, filter)
  if next(available_packages_name) == nil then
    return nil
  end
  return available_packages_name
end

function M.select_package(packages_name)
  local package_name = ""

  vim.ui.select(packages_name, { prompt = "Support package(Mason)" }, function(item, _)
    if item then
      package_name = item
    end
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
      if item then
        action = item
      end
    end)
  else
    action = "Install"
  end

  return action
end

return M
