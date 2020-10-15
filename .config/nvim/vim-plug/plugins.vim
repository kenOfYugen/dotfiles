" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'udalov/kotlin-vim'

    Plug 'co1ncidence/javacafe'
    Plug 'majutsushi/tagbar'
    Plug 'neovimhaskell/haskell-vim'
    Plug 'ap/vim-css-color'

    " Format
    Plug 'andrejlevkovitch/vim-lua-format'

    " --------- adding the following three plugins for Latex ---------
    Plug 'lervag/vimtex'
    Plug 'Konfekt/FastFold'
    Plug 'matze/vim-tex-fold'    
    " --------- "
    Plug 'VundleVim/Vundle.vim'
    Plug 'preservim/nerdtree'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'ryanoasis/vim-devicons'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
