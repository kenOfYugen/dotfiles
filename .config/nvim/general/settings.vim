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

" Markdown Preview Settings
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_browser = 'firefox'

" Nord Options
let g:lightline = {
      \ 'colorscheme': 'wal',
      \ }

let g:nord_cursor_line_number_background = 1
let g:nord_uniform_status_lines = 1
let g:nord_bold_vertical_split_line = 0

colorscheme wal

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


" Deoplete
let g:deoplete#enable_at_startup = 1
