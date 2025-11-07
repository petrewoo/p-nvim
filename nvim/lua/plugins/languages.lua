-- [[ Language-Specific Plugins ]]

return {
  -- Python
  {
    'vim-python/python-syntax',
    ft = 'python',
    config = function()
      vim.g.python_highlight_all = 1
    end,
  },

  -- Markdown
  {
    'plasticboy/vim-markdown',
    ft = 'markdown',
    dependencies = { 'godlygeek/tabular' },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
    end,
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npx --yes yarn install',
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreview<cr>', desc = 'Markdown preview' },
    },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0
      }
    end,
  },

  -- Go
  {
    'fatih/vim-go',
    ft = 'go',
    build = ':GoUpdateBinaries',
    config = function()
      vim.g.go_fmt_command = 'goimports'
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_def_mode = 'gopls'
      vim.g.go_info_mode = 'gopls'
    end,
  },

  -- Rust
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
    end,
  },

  -- JavaScript/TypeScript
  {
    'pangloss/vim-javascript',
    ft = { 'javascript', 'typescript' },
  },

  {
    'MaxMEllon/vim-jsx-pretty',
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },

  -- HTML/CSS
  {
    'mattn/emmet-vim',
    ft = { 'html', 'css', 'javascript', 'typescript', 'vue', 'jsx', 'tsx' },
    config = function()
      vim.g.user_emmet_leader_key = '<C-Z>'
      vim.g.user_emmet_settings = {
        javascript = {
          extends = 'jsx',
        },
        typescript = {
          extends = 'tsx',
        },
      }
    end,
  },

  -- JSON
  {
    'elzr/vim-json',
    ft = 'json',
    config = function()
      vim.g.vim_json_syntax_conceal = 0
    end,
  },

  -- YAML
  {
    'stephpy/vim-yaml',
    ft = 'yaml',
  },

  -- TOML
  {
    'cespare/vim-toml',
    ft = 'toml',
  },

  -- Docker
  {
    'ekalinin/Dockerfile.vim',
    ft = 'dockerfile',
  },

  -- Nginx
  {
    'chr4/nginx.vim',
    ft = 'nginx',
  },

  -- GraphQL
  {
    'jparise/vim-graphql',
    ft = 'graphql',
  },

  -- Terraform
  {
    'hashivim/vim-terraform',
    ft = 'terraform',
    config = function()
      vim.g.terraform_fmt_on_save = 1
      vim.g.terraform_align = 1
    end,
  },
}
