-- [[ ---------------- `keymaps.lua` config file ---------------- ]]

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- [[ ---------------- Function Keys ---------------- ]]
-- F2: Toggle line numbers
keymap('n', '<F2>', ':set nonumber!<CR>', opts)
-- F3: Toggle visible characters
keymap('n', '<F3>', ':set list!<CR>', opts)
-- F4: Toggle line wrapping
keymap('n', '<F4>', ':set wrap!<CR>', opts)
-- F5: Toggle paste mode
keymap('n', '<F5>', ':set paste!<CR>', opts)
-- F6: Toggle syntax highlighting
keymap('n', '<F6>', ':if exists("g:syntax_on") | syntax off | else | syntax on | endif<CR>', opts)

-- [[ ---------------- Window Navigation ---------------- ]]
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Window resizing
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- [[ ---------------- Quick Commands ---------------- ]]
-- Quick command mode
keymap('n', ';', ':', { noremap = true })

-- Save and quit
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>W', ':w!<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>Q', ':q!<CR>', opts)

-- Clear search highlight
keymap('n', '<leader>/', ':nohlsearch<CR>', opts)
keymap('n', '<Esc>', ':nohlsearch<CR>', opts)

-- [[ ---------------- Buffer Navigation ---------------- ]]
keymap('n', '[b', ':bprevious<CR>', opts)
keymap('n', ']b', ':bnext<CR>', opts)
keymap('n', '<Left>', ':bprevious<CR>', opts)
keymap('n', '<Right>', ':bnext<CR>', opts)
keymap('n', '<leader>bd', ':bdelete<CR>', opts)

-- [[ ---------------- Tab Navigation ---------------- ]]
-- Jump to specific tab
for i = 1, 9 do
  keymap('n', '<leader>' .. i, ':tabn ' .. i .. '<CR>', opts)
end

keymap('n', 'th', ':tabfirst<CR>', opts)
keymap('n', 'tl', ':tablast<CR>', opts)
keymap('n', 'tj', ':tabnext<CR>', opts)
keymap('n', 'tk', ':tabprevious<CR>', opts)
keymap('n', 'tn', ':tabnew<CR>', opts)
keymap('n', 'tp', ':tabprevious<CR>', opts)
keymap('n', 'te', ':tabedit<Space>', { noremap = true })
keymap('n', 'td', ':tabclose<CR>', opts)

-- [[ ---------------- Insert Mode Shortcuts ---------------- ]]
-- Fast exit insert mode
keymap('i', 'kj', '<Esc>', opts)
keymap('i', 'jk', '<Esc>', opts)

-- [[ ---------------- Visual Mode ---------------- ]]
-- Keep visual selection when indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move lines up and down
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Copy to system clipboard
keymap('v', '<leader>y', '"+y', opts)

-- [[ ---------------- Normal Mode Editing ---------------- ]]
-- Move cursor to beginning/end of line
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)
keymap('v', 'H', '^', opts)
keymap('v', 'L', '$', opts)

-- Keep cursor centered when scrolling
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Join lines without moving cursor
keymap('n', 'J', 'mzJ`z', opts)

-- Paste without overwriting register
keymap('x', '<leader>p', '"_dP', opts)

-- Delete without yanking
keymap('n', '<leader>d', '"_d', opts)
keymap('v', '<leader>d', '"_d', opts)

-- Copy to system clipboard
keymap('n', '<leader>y', '"+y', opts)
keymap('n', '<leader>Y', '"+Y', opts)

-- [[ ---------------- Command Mode ---------------- ]]
-- Sudo write
keymap('c', 'w!!', 'w !sudo tee % > /dev/null', { noremap = true })

-- [[ ---------------- Relative Number Toggle ---------------- ]]
keymap('n', '<C-n>', ':set relativenumber!<CR>', opts)

-- [[ ---------------- Search in Visual Mode ---------------- ]]
-- Search for selected text
keymap('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>', opts)

-- [[ ---------------- AI Assistant (Claude) ---------------- ]]
-- Main AI commands
keymap('n', '<leader>aa', '<cmd>AvanteAsk<CR>', opts)
keymap('v', '<leader>aa', '<cmd>AvanteAsk<CR>', opts)
keymap('n', '<leader>ac', '<cmd>AvanteChat<CR>', opts)
keymap('n', '<leader>at', '<cmd>AvanteToggle<CR>', opts)
keymap('n', '<leader>ax', '<cmd>AvanteClear<CR>', opts)
keymap('n', '<leader>ar', '<cmd>AvanteRefresh<CR>', opts)

-- Quick AI actions
keymap('n', '<leader>ae', ':AvanteAsk explain this code in detail<CR>', opts)
keymap('v', '<leader>ae', ':AvanteAsk explain this code in detail<CR>', opts)

keymap('n', '<leader>ao', ':AvanteAsk optimize this code for better performance<CR>', opts)
keymap('v', '<leader>ao', ':AvanteAsk optimize this code for better performance<CR>', opts)

keymap('n', '<leader>af', ':AvanteAsk find and fix bugs in this code<CR>', opts)
keymap('v', '<leader>af', ':AvanteAsk find and fix bugs in this code<CR>', opts)

keymap('n', '<leader>ad', ':AvanteAsk add detailed documentation and comments<CR>', opts)
keymap('v', '<leader>ad', ':AvanteAsk add detailed documentation and comments<CR>', opts)

keymap('n', '<leader>au', ':AvanteAsk write comprehensive unit tests<CR>', opts)
keymap('v', '<leader>au', ':AvanteAsk write comprehensive unit tests<CR>', opts)

keymap('n', '<leader>as', ':AvanteAsk suggest improvements for this code<CR>', opts)
keymap('v', '<leader>as', ':AvanteAsk suggest improvements for this code<CR>', opts)

