-- [[ Treesitter - Better Syntax Highlighting ]]

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    init = function()
      -- Use the bash parser for zsh buffers; no dedicated zsh parser ships
      -- with nvim-treesitter, and rainbow-delimiters crashes on a nil parser.
      vim.treesitter.language.register('bash', 'zsh')
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to install
        ensure_installed = {
          'lua',
          'vim',
          'vimdoc',
          'python',
          'javascript',
          'typescript',
          'tsx',
          'json',
          'html',
          'css',
          'go',
          'rust',
          'bash',
          'markdown',
          'markdown_inline',
          'yaml',
          'toml',
          'regex',
          'dockerfile',
          'gitignore',
          'c',
          'cpp',
        },

        -- Highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Indentation
        indent = {
          enable = true,
        },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<S-CR>',
            node_decremental = '<BS>',
          },
        },

        -- Text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      })
    end,
  },

  -- Treesitter text objects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  -- Context - shows function/class context at top
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
        patterns = {
          default = {
            'class',
            'function',
            'method',
          },
        },
      })
    end,
  },
}
