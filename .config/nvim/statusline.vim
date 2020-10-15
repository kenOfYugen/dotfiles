" ====================================================================
" Make sure to:
" 1. source this file somewhere at the bottom of your config.
" 2. disable any statusline plugins, as they will override this.
" ====================================================================


" ~~~~ Statusline configuration ~~~~
function! RedrawModeColors(mode) " {{{
  " Normal mode
  if a:mode == 'n'
    hi MyStatuslineAccent guifg=#585e74 gui=none guibg=#292b34
    hi MyStatuslineAccentBody guifg=#585e74 gui=none guibg=#9ce5c0
  " Insert mode
  elseif a:mode == 'i'
    hi MyStatuslineAccent guifg=#292b34 gui=none guibg=#292b34
    hi MyStatuslineAccentBody guibg=#292b34 gui=none guifg=#f9929b
  " Replace mode
  elseif a:mode == 'R'
    hi MyStatuslineAccent guifg=#292b34 gui=none guibg=#292b34
    hi MyStatuslineAccentBody guibg=#292b34 gui=none guifg=#fbdf90
  " Visual mode
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
    hi MyStatuslineAccent guifg=#292b34 gui=none guibg=#292b34
    hi MyStatuslineAccentBody guibg=#292b34 gui=none guifg=#a3b8ef
  endif
  return ''
endfunction
" }}}


function! SetFiletype(filetype) " {{{
  if a:filetype == ''
      return '-'
  else
      return a:filetype
  endif
endfunction
" }}}


" Statusbar items
" ====================================================================
" This will not be displayed, but the function RedrawModeColors will be
" called every time the mode changes, thus updating the colors used for the
" components.
set statusline=%{RedrawModeColors(mode())}
" Left side items
" =======================
set statusline+=%#MyStatuslineAccent#
set statusline+=%#MyStatuslineAccentBody#\ \ 
" Filename
set statusline+=%#MyStatuslineSeparator#
set statusline+=%#MyStatuslineFilename#\ %.20f
set statusline+=%#MyStatuslineSeparator#\ %#reset#


" Right side items
" =======================
set statusline+=%=
" Line and Column
set statusline+=%#MyStatuslineLineCol#
set statusline+=%#MyStatuslineLineColBody#\ %2l
set statusline+=\/%#MyStatuslineLineColBody#%2c
set statusline+=%#MyStatuslineLineCol#
" Padding
set statusline+=\ 
" Current scroll percentage and total lines of the file
set statusline+=%#MyStatuslinePercentage#\|
set statusline+=%#MyStatuslinePercentageBody#\ %P
set statusline+=\/\%#MyStatuslinePercentageBody#%L
set statusline+=%#MyStatuslinePercentage#
" Padding
set statusline+=\ 
" Filetype
set statusline+=%#MyStatuslineFiletype#
set statusline+=%#MyStatuslineFiletypeBody#\ %{WebDevIconsGetFileTypeSymbol()}\ %{SetFiletype(&filetype)}\ 
set statusline+=%#MyStatuslineFiletype#


hi MyStatuslineFilename guifg=#9ce5c0 gui=none guibg=#585e74

" Setup the colors
hi StatusLine          guifg=none       guibg=#30333d  gui=NONE
hi StatusLineNC        guifg=#c0c0c0    guibg=#9ce5c0  gui=none

hi MyStatuslineSeparator guifg=#585e74 gui=none guibg=#585e74

hi reset guibg=#30333d

hi MyStatuslineFiletype guibg=#292b34 gui=NONE guifg=#585e74
hi MyStatuslineFiletypeBody guibg=#9ce5c0 gui=none guifg=#585e74

hi MyStatuslinePercentage guibg=#585e74 gui=NONE guifg=#30333d
hi MyStatuslinePercentageBody guibg=#585e74 gui=none guifg=#9ce5c0

hi MyStatuslineLineCol guibg=#585e74 gui=NONE guifg=#30333d
hi MyStatuslineLineColBody guibg=#585e74 gui=none guifg=#9ce5c0

