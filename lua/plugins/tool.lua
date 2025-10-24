return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    keys = {
      { '<leader>fn', '<cmd>ObsidianSearch<CR>', mode = 'n', desc = '[Obsidian] search notes' },
      { '<leader>cc', '<cmd>ObsidianNew<CR>', mode = 'n', desc = '[Obsidan] create obsidian capture note' },
      { '<leader>ct', '<cmd>ObsidianToday<CR>', mode = 'n', desc = '[Obsidan] create obsidian today note' },
      { 'gf', '<cmd>ObsidianFollowLink<CR>', mode = 'n', desc = '[Obsidan] obsidian follow link' },
    },
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. 'BufReadPre ' .. vim.fn.expand '~' .. '/my-vault/*.md'
    --   -- refer to `:h file-pattern` for more examples
    --   'BufReadPre ' .. vim.fn.expand '~' .. '/Notes/*.md',
    --   'BufNewFile ' .. vim.fn.expand '~' .. '/Notes/*.md',
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter',
    },
    opts = {
      workspaces = {
        {
          name = 'notes',
          path = '~/Notes',
        },
      },
      open_app_foreground = true,
      notes_subdir = "Inbox",
      new_notes_location = "notes_subdir",
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'Daily',
        -- Optional, if you want to change the date format for the ID of daily notes.
        -- date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        -- alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
      }
    },
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    keys = {
      { '-', '<cmd>Oil<CR>', mode = 'n', desc = 'Open oil' }
    }
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release',
      }
    },
    config = function()
      require'telescope'.setup {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            vertical = { preview_height = 0.75 }
          },
          file_ignore_patterns = { 'bin/', '%.class' },
          -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
          -- generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          }
        },
        -- file_ignore_patterns = { "%.class" }
      }
      require'telescope'.load_extension('ui-select')
      require'telescope'.load_extension('fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end, { desc = '[Telescope] find files' })
      vim.keymap.set('n', '<leader>fg', function() builtin.live_grep() end, { desc = '[Telescope] live grep' })
      vim.keymap.set('n', '<leader>fb', function() builtin.buffers() end, { desc = '[Telescope] buffers' })
      vim.keymap.set('n', '<leader>fh', function() builtin.help_tags() end, { desc = '[Telescope] help tags' })
      vim.keymap.set('n', '<leader>fr', function() builtin.oldfiles() end, { desc = '[Telescope] old files' })
    end
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(opts)
      local wc = require 'which-key'
      wc.setup(opts)
      wc.add({
        { '<leader>f', group = 'Find' },
        { '<leader>c', group = 'Create or Clear' },
        { '<leader>d', group = 'Debug' },
        { '<leader>q', group = 'Quickfix' },
        { '<leader>r', group = 'Run' },
      })
    end
  },
}
