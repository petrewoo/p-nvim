-- [[ Plugin Configuration Entry Point ]]
-- This file imports all plugin configurations from subdirectories

return {
  -- Import all plugin modules
  { import = 'plugins.ui' },
  { import = 'plugins.editor' },
  { import = 'plugins.lsp' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.git' },
  { import = 'plugins.languages' },
  { import = 'plugins.misc' },
}
