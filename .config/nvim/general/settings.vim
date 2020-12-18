" General settings
syntax enable
set autoindent
set number
set noshowmode
set expandtab
set tabstop=4
set ignorecase
set smartcase
set shiftwidth=4
set showmatch
set splitright
set splitbelow
set foldmethod=indent
set foldlevel=99
set mouse=a
set ruler
set laststatus=2
set nostartofline
set cursorline
set showtabline=2
" set nowrap


augroup AutoGroup
    autocmd!
augroup END

command! -nargs=* Autocmd autocmd AutoGroup <args>

Autocmd BufNewFile,BufRead *.rasi set filetype=css


set relativenumber
" Remove Tildas
let &fcs='eob' 

" Start Page
let g:startify_custom_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \]

" Java Autocomplete
autocmd FileType java setlocal omnifunc=javacomplete#Complete

set termguicolors

colorscheme javacafe

" Enable Italics
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"
highlight Comment gui=italic

" My coc stuff

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


let g:indentLine_color_gui = '#585e74'

"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

