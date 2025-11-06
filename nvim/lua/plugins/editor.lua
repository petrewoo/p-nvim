-- [[ Editor Enhancement Plugins ]]

return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file explorer' },
      { '<leader>nf', '<cmd>NvimTreeFindFile<cr>', desc = 'Find current file in tree' },
    },
    config = function()
      require('nvim-tree').setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
          side = 'left',
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { '.git', 'node_modules', '.cache', '__pycache__' },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = true,
            },
          },
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
      { '<leader>fc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>fs', '<cmd>Telescope grep_string<cr>', desc = 'Search string under cursor' },
      { '<C-p>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          prompt_prefix = '  ',
          selection_caret = ' ',
          path_display = { 'truncate' },
          file_ignore_patterns = { 'node_modules', '.git/', '__pycache__', '*.pyc' },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['<Esc>'] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })

      telescope.load_extension('fzf')
    end,
  },

  -- Code outline and navigation
  {
    'stevearc/aerial.nvim',
    keys = {
      { '<leader>a', '<cmd>AerialToggle<cr>', desc = 'Toggle code outline' },
    },
    config = function()
      require('aerial').setup({
        backends = { 'treesitter', 'lsp', 'markdown' },
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 20,
          default_direction = 'prefer_right',
        },
        attach_mode = 'window',
        close_automatic_events = {},
        show_guides = true,
      })
    end,
  },

  -- Better quickfix window
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
        },
      })
    end,
  },

  -- Enhanced f/F/t/T motions
  {
    'unblevable/quick-scope',
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end,
  },

  -- Easy motion
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    keys = {
      { '<leader>hw', '<cmd>HopWord<cr>', desc = 'Hop to word' },
      { '<leader>hl', '<cmd>HopLine<cr>', desc = 'Hop to line' },
      { '<leader>hc', '<cmd>HopChar1<cr>', desc = 'Hop to char' },
      { '<leader>hp', '<cmd>HopPattern<cr>', desc = 'Hop to pattern' },
    },
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  },

  -- Comment code
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
      { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
      { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
      { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
      { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
      { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
      { '<leader>c<space>', mode = 'n', desc = 'Toggle comment' },
    },
    config = function()
      require('Comment').setup()
    end,
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
        disable_filetype = { 'TelescopePrompt', 'vim' },
      })
    end,
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  -- Multiple cursors
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- Easy align
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'Easy align' },
    },
  },

  -- Expand region
  {
    'terryma/vim-expand-region',
    keys = {
      { '+', '<Plug>(expand_region_expand)', mode = 'v', desc = 'Expand region' },
      { '_', '<Plug>(expand_region_shrink)', mode = 'v', desc = 'Shrink region' },
    },
  },

  -- Show marks
  {
    'kshenoy/vim-signature',
  },

  -- Undo tree
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle undo tree' },
    },
  },

  -- Search and replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>S', '<cmd>lua require("spectre").toggle()<cr>', desc = 'Toggle Spectre' },
      { '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', desc = 'Search current word' },
      { '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>', desc = 'Search in current file' },
    },
    config = function()
      require('spectre').setup()
    end,
  },

  -- Which key - shows key bindings
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
      })
    end,
  },
}
