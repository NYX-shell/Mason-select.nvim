local registry = require "mason-registry"

local M = {}

function M.get_packages_name()
  registry.update()
  local packages = registry.get_all_package_names()

  return packages
end
function M.get_package(package_name) return registry.get_package(package_name) end

return M
