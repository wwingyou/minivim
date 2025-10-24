local qf = require'utils/quickfix'

-- Set nohlsearch on pressing <ESC>.
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Shortcut to execute external program
vim.keymap.set('n', '!', ':!', { desc = 'Shortcut of executing external program' })

-- Press 'R' to substitute word under cursor.
-- NOTE: 'R' has other default action. Since I don't use it, exchanged it.
vim.keymap.set('n', 'R', function()
  local word = vim.fn.expand('<cword>')
  return ':%s/' .. word .. '/'
end, { expr = true, desc = 'Substitute word under cursor' })

-- Quickfix keymaps.
vim.keymap.set(
  'n', '(',
  function()
    if qf.index() == 1 then
      return '<cmd>cc<CR>zOzz'
    else
      return '<cmd>cp<CR>zOzz'
    end
  end,
  { expr = true, desc = '[Quickfix] next item' }
)
vim.keymap.set(
  'n', ')',
  function()
    if qf.index() == qf.size() then
      return '<cmd>cc<CR>zOzz'
    else
      return '<cmd>cn<CR>zOzz'
    end
  end,
  { expr = true, desc = '[Quickfix] prev item' }
)

vim.keymap.set('n', '<leader>qq', function()
  if qf.is_window_open() then
    vim.cmd([[cclose]])
  else
    vim.cmd([[copen]])
  end
end, { desc = '[Quickfix] toggle list' })

vim.keymap.set('n', '<leader>qe', function()
  vim.diagnostic.setqflist({ open = true, severity = "ERROR" })
end, { desc = '[Quickfix] open error list' })

vim.keymap.set('n', '<leader>qw', function()
  vim.diagnostic.setqflist({ open = true, severity = "WARN" })
end, { desc = '[Quickfix] open warnning list' })

-- Toggle previous buffer.
vim.keymap.set('n', '<C-p>', function()
  local prev_buf = vim.fn.bufnr('#')
  if (prev_buf == -1) then
    vim.api.nvim_err_writeln('No previous buffer.')
    return
  end
  vim.api.nvim_set_current_buf(prev_buf)
end, { desc = 'Toggle buffer back and forth' })

vim.keymap.set('v', '<', '<gv', { noremap = true, desc = 'Re-select indent area'})
vim.keymap.set('v', '>', '>gv', { noremap = true, desc = 'Re-select indent area'})
