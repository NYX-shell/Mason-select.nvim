local M = {}
function M.has_string(Table, String)
  for index, _ in pairs(Table) do
    local TableString = Table[index]
    -- vim.print(vim.o.filetype)
    -- vim.print('"' .. lang .. '"')

    if string.lower(TableString) == string.lower(String) then
      return String
    else
      return nil
    end
  end
end
return M
