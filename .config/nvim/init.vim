"--- Plugin Stuff ---"
lua require('plugins')

"--- Settings ---"
lua require('opts')

"--- Key Bindings ---"
source $HOME/.config/nvim/keys/mappings.vim

lua require'colorizer'.setup()

hi! CocErrorSign guifg=#f9929b
hi! CocInfoSign guifg=#7ed491
hi! CocWarningSign guifg=#fbdf90
