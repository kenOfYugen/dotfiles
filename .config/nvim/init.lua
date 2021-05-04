-- Plugin Stuff
require('plugins')

require('globals')

-- Settings
require('opts')

-- Mappings
require('keys')

require('statusline')
require('completion')
require('bufferbar')
require('gitsigns')
require('nvimtree')
require('treesitter')
require('autopairs')
vim.cmd('source ~/.config/nvim/vim/whichkey/init.vim')
vim.cmd('source ~/.config/nvim/vim/functions.vim')

-- LSP
require('lsp')
require('lsp.clangd')
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.js-ts-ls')
require('lsp.python-ls')
require('lsp.rust-ls')
require('lsp.json-ls')
require('lsp.yaml-ls')
require('lsp.vim-ls')
require('lsp.html-ls')
require('lsp.css-ls')
