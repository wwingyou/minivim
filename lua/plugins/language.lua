return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require'cmp'
      local lspkind = require'lspkind'
      cmp.setup {
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'lazydev', group_index = 0 }
        },
        window = {
          completion = {
            side_padding = 1,
          },
        },
        formatting = {
          expandable_indicator = true,
          fields = { 'abbr', 'kind', 'menu' },
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 30,
            ellipsis_char = '...',
            show_labelDetails = true,
            menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
            }),

            -- NOTE: The function below will be called before any actual modifications from lspkind
            before = function (_, vim_item)
              -- Remove menu text
              vim_item.menu = nil
              return vim_item
            end
          }
        },
        sorting = {
          -- WARN: Don't know what exactly each comparators do. 
          -- Must check it later.
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          }
        }
      }
    end
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
      },
    },
    keys = {
      {
        '<leader>cb',
        function() require'dap'.clear_breakpoints() end,
        mode = 'n',
        desc = '[DEBUG] clear breakpoints',
      },
      {
        '<leader>qb',
        function()
          require'dap'.list_breakpoints()
          vim.cmd([[copen]])
        end,
        mode = 'n',
        desc = '[Quickfix] open breakpoint list',
      },
      {
        '<C-B>',
        function() require'dap'.toggle_breakpoint() end,
        mode = 'n',
        desc = '[DEBUG] toggle breakpoints',
      },
      {
        '<UP>',
        function() require'dap'.step_out() end,
        mode = 'n',
        desc = '[DEBUG] step out',
      },
      {
        '<DOWN>',
        function() require'dap'.step_into() end,
        mode = 'n',
        desc = '[DEBUG] step into',
      },
      {
        '<LEFT>',
        function() require'dap'.step_over() end,
        mode = 'n',
        desc = '[DEBUG] step over',
      },
      {
        '<RIGHT>',
        function() require'dap'.continue() end,
        mode = 'n',
        desc = '[DEBUG] continue',
      },
      {
        '<leader>dd',
        function() require'dap'.run_last() end,
        mode = 'n',
        desc = '[DEBUG] re-run debugger',
      }
    },
    config = function()
      local dap = require('dap')
      dap.listeners.before['launch']['jdtls'] = function(_, _)
        vim.cmd([[DapViewOpen]])
        print("debuggin started")
      end
      dap.listeners.before['attach']['jdtls'] = function(_, _)
        vim.cmd([[DapViewOpen]])
        print("debuggin attached")
      end
      dap.listeners.after['event_terminated']['jdtls'] = function(_, _)
        vim.cmd([[DapViewClose]])
        print("The debugging process is terminated")
      end
      vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})
    end
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    keys = {
      {
        '<leader>tR',
        function()
          local neotest = require'neotest'
          neotest.run.run(vim.fn.expand('%'))
          neotest.summary.open()
          neotest.output_panel.open()
        end,
        mode = 'n',
        desc = '[Test] run test file',
      },
      {
        '<leader>tr',
        function() require'neotest'.run.run() end,
        mode = 'n',
        desc = '[Test] run nearest test',
      },
      {
        '<leader>tD',
        function()
          local neotest = require'neotest'
          neotest.run.run({ vim.fn.expand('%'), strategy = 'dap' })
          neotest.summary.open()
          neotest.output_panel.open()
        end,
        mode = 'n',
        desc = '[Test] debug test file',
      },
      {
        '<leader>td',
        function() require'neotest'.run.run({ strategy = 'dap' }) end,
        mode = 'n',
        desc = '[Test] debug nearest test',
      },
      {
        '<leader>tW',
        function()
          require'neotest'.watch.toggle({ vim.fn.expand('%'), strategy = 'dap' })
        end,
        mode = 'n',
        desc = '[Test] toggle watch test file',
      },
      {
        '<leader>tw',
        function() require'neotest'.watch.toggle({ strategy = 'dap' }) end,
        mode = 'n',
        desc = '[Test] toggle watch nearest test',
      },
      {
        '<leader>ts',
        function() require'neotest'.summary.toggle() end,
        mode = 'n',
        desc = '[Test] toggle test summary window',
      },
      {
        '<leader>to',
        function() require'neotest'.output_panel.toggle() end,
        mode = 'n',
        desc = '[Test] toggle test output panel',
      },
      {
        '<leader>tc',
        function()
          local neotest = require'neotest'
          neotest.output_panel.clear()
          neotest.summary.close()
        end,
        mode = 'n',
        desc = '[Test] clear neotest windows',
      },
    },
    config = function()
      require'neotest'.setup {
        adapters = {
          -- TODO: all language specific adapters
        },
        output_panel = {
          open = '10sp'
        }
      }
    end
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require'luasnip.loaders.from_vscode'.lazy_load()
      local ls = require'luasnip'

      -- FIXME: This code cannot pregress to the last position when continually jumping forward in insert mode.
      -- Problem is fixed if I jump in select mode or returning from the end in select mode. Why?
      -- vim.keymap.set({"i", "s"}, "<Tab>", function()
      --   if ls.expand_or_jumpable() then
      --     ls.jump(1)
      --   else
      --     return '<Tab>'
      --   end
      -- end, { silent = true, expr = true })
      -- vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

      -- This keymap is pretty good. May I use this?
      vim.keymap.set({"i", "s"}, "<C-l>", function()
        ls.jump( 1)
      end, { desc = '[Luasnip] jump forward', silent = true })
      vim.keymap.set({"i", "s"}, "<C-h>", function()
        ls.jump(-1)
      end, { desc = '[Luasnip] jump backward', silent = true})
    end
  },
}
