return {
  {
    'echasnovski/mini.align',
    version = '*',
    opts = {}
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    'windwp/nvim-ts-autotag',
    opts = {}
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          normal = 'gs',
          normal_cur = 'gss',
          normal_line = 'gS',
          normal_cur_line = 'gSS',
        }
      })
    end
  },

  {
    'Wansmer/treesj',
    keys = { 'gj' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup {
        use_default_keymaps = false
      }

      vim.keymap.set('n', 'gj', require'treesj'.toggle, { desc = '[Edit] toggle treesj' })
    end,
  },
}
