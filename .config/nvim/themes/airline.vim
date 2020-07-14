let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = '|'


let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1

let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_section_a = '%{toupper(g:currentmode[mode()])}'
let g:airline_section_z = '%l/%L:%c'


let g:airline_theme = 'gruvbox_material'


let g:currentmode={
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ '' : 'V·Block',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'Rv' : 'V·Replace',
       \ 'c'  : 'Command',
       \}


"let g:airline_mode_map = {
"    \ '__' : '-',
"    \ 'n'  : 'N',
"    \ 'i'  : 'I',
"    \ 'R'  : 'R',
"    \ 'c'  : 'C',
"    \ 'v'  : 'V',
"    \ 'V'  : 'V',
"    \ '' : 'V',
"    \ 's'  : 'S',
"    \ }
