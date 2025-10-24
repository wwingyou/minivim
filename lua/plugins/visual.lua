return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      exclude = {
        filetypes = { 'dashboard' }
      }
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local custom_catppuccin = require'lualine.themes.catppuccin-mocha'

      custom_catppuccin.normal.c.bg = "none"

      require("lualine").setup({
        options = {
          theme = catppuccin,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          always_divide_middle = false,
          globalstatus = true,
        },
        on_colors = function(colors)
          colors.bg_statusline = colors.none
        end,
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { '%=', { 'filename', file_status = true } },
          lualine_x = {},
          lualine_y = { 'encoding', 'progress' },
          lualine_z = { 'location' }
        },
      })
    end,
  },

  {
    "folke/todo-comments.nvim",
    opts = {},
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        modules = {},
        ensure_installed = {
          'c',
          'lua',
          'vim',
          'vimdoc',
          'markdown',
          'markdown_inline',
          'java',
          'javascript',
          'typescript',
          'html',
        },
        ignore_install = {},
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          -- additional_vim_regex_highlighting = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "M",
            node_incremental = "M",
            scope_incremental = "H",
            node_decremental = "L",
          }
        },
        indent = {
          enable = true
        }
      }

    end
  },

}
