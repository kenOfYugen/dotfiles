" ====================================================================
" Make sure to:
" 1. source this file somewhere at the bottom of your config.
" 2. disable any statusline plugins, as they will override this.
" ====================================================================

" Special thanks to Elenapen 

function! Gitbranchname() abort
  if get(b:, 'gitbranch_pwd', '') !=# expand('%:p:h') || !has_key(b:, 'gitbranch_path')
    call Gitbranchdetect(expand('%:p:h'))
  endif
  if has_key(b:, 'gitbranch_path') && filereadable(b:gitbranch_path)
    let branch = get(readfile(b:gitbranch_path), 0, '')
    if branch =~# '^ref: '
      hi MyStatuslineGit guifg=#3b3e4b gui=none guibg=none
      hi MyStatuslineGitBody guifg=#c0c0c0 gui=none guibg=#3b3e4b
      return substitute(branch, '^ref: \%(refs/\%(heads/\|remotes/\|tags/\)\=\)\=', '', '')
    elseif branch =~# '^\x\{20\}'
      hi MyStatuslineGit guifg=#3b3e4b gui=none guibg=none
      hi MyStatuslineGitBody guifg=#c0c0c0 gui=none guibg=#3b3e4b
      return branch[:6]
    endif
  endif
  hi MyStatuslineGit guifg=#30333d gui=none guibg=#30333d
  hi MyStatuslineGitBody guifg=#30333d gui=none guibg=#30333d
  return ''
endfunction

function! Gitbranchdir(path) abort
  let path = a:path
  let prev = ''
  while path !=# prev
    let dir = path . '/.git'
    let type = getftype(dir)
    if type ==# 'dir' && isdirectory(dir.'/objects') && isdirectory(dir.'/refs') && getfsize(dir.'/HEAD') > 10
      return dir
    elseif type ==# 'file'
      let reldir = get(readfile(dir), 0, '')
      if reldir =~# '^gitdir: '
        return simplify(path . '/' . reldir[8:])
      endif
    endif
    let prev = path
    let path = fnamemodify(path, ':h')
  endwhile
  return ''
endfunction

function! Gitbranchdetect(path) abort
  unlet! b:gitbranch_path
  let b:gitbranch_pwd = expand('%:p:h')
  let dir = Gitbranchdir(a:path)
  if dir !=# ''
    let path = dir . '/HEAD'
    if filereadable(path)
      let b:gitbranch_path = path
    endif
  endif
endfunction


" ~~~~ Statusline configuration ~~~~
" ':help statusline' is not my friend!
function! RedrawModeColors(mode) " {{{
  " Normal mode
  if a:mode == 'n'
    hi MyStatuslineAccent guifg=#3b3e4b gui=none guibg=none
    hi MyStatuslineFilename guifg=#c0c0c0 gui=none guibg=#3b3e4b
    hi MyStatuslineAccentBody guibg=#3b3e4b gui=none guifg=#7ed491
  " Insert mode
  elseif a:mode == 'i'
    hi MyStatuslineAccent guifg=#3b3e4b gui=none guibg=none
    hi MyStatuslineFilename guifg=#c0c0c0 gui=none guibg=#3b3e4b
    hi MyStatuslineAccentBody guibg=#3b3e4b gui=none guifg=#f9929b
  " Replace mode
  elseif a:mode == 'R'
    hi MyStatuslineAccent guifg=#3b3e4b gui=none guibg=none
    hi MyStatuslineFilename guifg=#c0c0c0 gui=none guibg=#3b3e4b
    hi MyStatuslineAccentBody guibg=#3b3e4b gui=none guifg=#fbdf90
  " Visual mode
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
    hi MyStatuslineAccent guifg=#3b3e4b gui=none guibg=none
    hi MyStatuslineFilename guifg=#c0c0c0 gui=none guibg=#3b3e4b
    hi MyStatuslineAccentBody guibg=#3b3e4b gui=none guifg=#a3b8ef
  endif
  " Return empty string so as not to display anything in the statusline
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
set statusline+=%#MyStatuslineAccent#
set statusline+=%#MyStatuslineAccentBody#\ 
" Filename
set statusline+=%#MyStatuslineFilename#\ %.20f
set statusline+=%#MyStatuslineSeparator#\ 
" Git Status
set statusline+=%#MyStatuslineGit#
set statusline+=%#MyStatuslineGitBody#\ %{Gitbranchname()}
set statusline+=%#MyStatuslineGit#
" Right side items
" =======================
set statusline+=%=
" Line and Column
set statusline+=%#MyStatuslineLineCol#
set statusline+=%#MyStatuslineLineColBody#\ %2l
set statusline+=\/%#MyStatuslineLineColBody#%2c
set statusline+=%#MyStatuslineLineCol#
" Padding
set statusline+=\ 
" Current scroll percentage and total lines of the file
set statusline+=%#MyStatuslinePercentage#
set statusline+=%#MyStatuslinePercentageBody#☰\ %P
set statusline+=\/\%#MyStatuslinePercentageBody#%L
set statusline+=%#MyStatuslinePercentage#
" Padding
set statusline+=\ 
" Filetype
set statusline+=%#MyStatuslineFiletype#
set statusline+=%#MyStatuslineFiletypeBody#%{SetFiletype(&filetype)}
set statusline+=%#MyStatuslineFiletype#


" Setup the colors
hi StatusLine          guifg=none       guibg=#3b3e4b  gui=NONE
hi StatusLineNC        guifg=#c0c0c0    guibg=none     gui=bold

hi MyStatuslineSeparator guifg=#3b3e4b gui=none guibg=none

hi MyStatuslineModified  guifg=#3b3e4b gui=none guibg=none

hi MyStatuslineFiletype guibg=NONE gui=NONE guifg=#3b3e4b
hi MyStatuslineFiletypeBody guifg=#ccaced gui=bold guibg=#3b3e4b

hi MyStatuslinePercentage guifg=#3b3e4b gui=NONE guibg=NONE
hi MyStatuslinePercentageBody guibg=#3b3e4b gui=none guifg=#c0c0c0

hi MyStatuslineLineCol guifg=#3b3e4b gui=NONE guibg=NONE
hi MyStatuslineLineColBody guibg=#3b3e4b gui=none guifg=#c0c0c0
