-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set LSP keymaps when LSP is attached.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    -- Show diagnostic window on CursorHold.
    vim.api.nvim_create_autocmd('CursorHold', {
      desc = 'Show diagnostic window on CursorHold',
      group = vim.api.nvim_create_augroup('diagnostic-on-cursorhold', { clear = true }),
      callback = function()
        vim.diagnostic.open_float()
      end
    })

    -- Reduce updatetime to open up diagnostic faster
    vim.opt.updatetime=1000
  end
})

-- Set padding to the hover window to prevent window to occupy full screan.
local HOVER_WINDOW_PADDING = 10
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  hover, {
    max_width = vim.o.columns - (HOVER_WINDOW_PADDING * 2),
    wrap = true,
  }
)
