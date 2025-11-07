-- [[ ---------------- `core.lua` config file ---------------- ]]

-- [[ ---------------- General Settings ---------------- ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.history = 2000
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = true  -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'

-- Display settings
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false  -- Toggle with Ctrl+N
vim.opt.signcolumn = 'yes'  -- Always show sign column
vim.opt.wrap = false
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 5
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.laststatus = 3  -- Global statusline
vim.opt.cmdheight = 1
vim.opt.pumheight = 10  -- Popup menu height

-- Editing behavior
vim.opt.backspace = 'eol,start,indent'
vim.opt.whichwrap:append('<,>,h,l')
vim.opt.visualbell = false
vim.opt.errorbells = false
vim.opt.autoread = true  -- Auto reload changed files
vim.opt.autowrite = true  -- Auto save before commands like :next
vim.opt.confirm = true  -- Confirm before quit without save
vim.opt.hidden = true  -- Allow hidden buffers
vim.opt.mouse = 'a'  -- Enable mouse support

-- Wildmenu settings
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore = vim.opt.wildignore + {
  '*.o', '*.obj', '*.pyc', '*.swp', '*.tmp',
  '*.so', '*.zip', '*.tar.gz',
  '*/.git/*', '*/.hg/*', '*/.svn/*',
  '*/node_modules/*', '*/__pycache__/*',
  '*.DS_Store'
}

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

-- Folding settings
vim.opt.foldenable = true
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true  -- Round indent to multiple of shiftwidth

-- Performance
vim.opt.updatetime = 300  -- Faster completion
vim.opt.timeoutlen = 400  -- Faster key sequence completion
vim.opt.redrawtime = 1500
vim.opt.ttimeoutlen = 10

-- Split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- [[ ---------------- File Encoding Settings ---------------- ]]
-- Neovim always uses UTF-8 internally, encoding option is not needed
vim.opt.fileencodings = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936'
vim.opt.fileformats = 'unix,dos,mac'

-- [[ ---------------- Completion Settings ---------------- ]]
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.wildmenu = true

-- [[ ---------------- Theme Settings ---------------- ]]
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Syntax highlighting
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Set colorscheme (will be applied after plugins load)
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    pcall(vim.cmd, 'colorscheme nord')
  end
})

-- [[ ---------------- Auto Commands ---------------- ]]
-- Create undo directory if it doesn't exist
local undodir = vim.fn.stdpath('data') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end
})

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = 'checktime'
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end
})
