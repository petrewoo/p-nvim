-- [[ Miscellaneous Plugins ]]

return {
  -- Tmux navigator
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>' },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>' },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>' },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>' },
    },
  },

  -- Session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'Restore session' },
      { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore last session' },
      { '<leader>qd', function() require('persistence').stop() end, desc = "Don't save session" },
    },
    config = function()
      require('persistence').setup({
        dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
        options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
      })
    end,
  },

  -- Startup screen
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[                                                    ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Config', ':e $MYVIMRC <CR>'),
        dashboard.button('s', '  Restore session', ':lua require("persistence").load() <cr>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      dashboard.section.footer.val = 'Migrated from k-vim'

      dashboard.section.footer.opts.hl = 'Type'
      dashboard.section.header.opts.hl = 'Include'
      dashboard.section.buttons.opts.hl = 'Keyword'

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Toggle floating terminal' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Toggle horizontal terminal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle vertical terminal' },
    },
    config = function()
      require('toggleterm').setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 3,
        },
      })

      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  },

  -- Project management
  {
    'ahmedkhalf/project.nvim',
    config = function()
      -- project.nvim is unmaintained and still calls vim.lsp.buf_get_clients,
      -- which is deprecated. Override with the modern API to silence the warning.
      vim.lsp.buf_get_clients = function(bufnr)
        return vim.lsp.get_clients({ bufnr = bufnr })
      end
      require('project_nvim').setup({
        detection_methods = { 'pattern', 'lsp' },
        patterns = { '.git', 'Makefile', 'package.json', 'go.mod', 'Cargo.toml' },
      })
      require('telescope').load_extension('projects')
    end,
  },

  -- Trouble - better diagnostics
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<cr>', desc = 'Toggle trouble' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace diagnostics' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document diagnostics' },
      { '<leader>xl', '<cmd>TroubleToggle loclist<cr>', desc = 'Location list' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix' },
      { 'gR', '<cmd>TroubleToggle lsp_references<cr>', desc = 'LSP references' },
    },
    config = function()
      require('trouble').setup({})
    end,
  },

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({
        signs = true,
        keywords = {
          FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
          TODO = { icon = ' ', color = 'info' },
          HACK = { icon = ' ', color = 'warning' },
          WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
          PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
          NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        },
      })
    end,
  },

  -- Better quickrun
  {
    'is0n/fm-nvim',
    keys = {
      { '<leader>r', '<cmd>lua require("fm-nvim").run()<cr>', desc = 'Run file' },
    },
  },

  -- Repeat plugin commands
  {
    'tpope/vim-repeat',
  },

  -- Better syntax for many languages
  {
    'sheerun/vim-polyglot',
  },
}
