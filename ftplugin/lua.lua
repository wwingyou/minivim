vim.bo.tabstop=2
vim.bo.shiftwidth=2

-- Execute current lua script
vim.keymap.set('n', '<C-R>', '<cmd>source %<CR>', { desc = '[Run] current lua flie' })
vim.keymap.set('v', '<C-R>', ':lua<CR>', { desc = '[Run] selected lua area' })
