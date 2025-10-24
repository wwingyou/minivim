local M = {}

--- Check if quickfix list window is open
---@return boolean
function M.is_window_open()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix > 0 then
      return true
    end
  end
  return false
end

--- Return number of quickfix list items
---@return integer
function M.size()
  return #vim.fn.getqflist()
end

--- Return index of currently selected quickfix item
---@return integer
function M.index()
  return vim.fn.getqflist({ idx = 0 }).idx
end

return M
