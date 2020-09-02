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
" set nowrap

set relativenumber
" Remove Tildas
let &fcs='eob: '


" Notes
let g:notes_directories = ['~/Documents/notes']


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

let g:tex_flavor  = 'latex'
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_quickfix_mode=0


let g:vimtex_view_general_viewer = 'zathura'

" Enable Italics
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"

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
