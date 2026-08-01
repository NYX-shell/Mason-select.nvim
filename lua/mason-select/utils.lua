local M = {}
function M.has_string(Table, String)
  for _, TableString in ipairs(Table) do
    -- vim.print(vim.o.filetype)
    -- vim.print('"' .. lang .. '"')

    if string.lower(TableString) == string.lower(String) then return String end
  end
  return nil
end
return M
