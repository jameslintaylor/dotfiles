" BEGIN Vundle stuff

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" code completion
Plugin 'Valloric/YouCompleteMe'

" all the languages
Plugin 'sheerun/vim-polyglot'

" theme
Plugin 'altercation/vim-colors-solarized'

" flow
Plugin 'flowtype/vim-flow'

" misc
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mattn/emmet-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" END Vundle stuff

set ruler
set tabstop=2
set shiftwidth=2

" syntax highlighting
syntax enable 
set background=dark
colo solarized 

" search highlighting
set hlsearch
hi Search cterm=bold ctermbg=none ctermfg=red

" non-intrusive matching brace highlighting
hi MatchParen cterm=bold ctermbg=none ctermfg=red

" leader remap
let mapleader = ','
set showcmd

" search down into subfolders
set path+=**

" display all matching files when we tab complete
set wildmenu

" YCM autoclose preview window 
let g:ycm_autoclose_preview_window_after_completion = 1

" YCM keymaps
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gd :YcmCompleter GetDoc<CR>

" emmet jsx 
let g:user_emmet_settings = {'javascript': {'extends': 'jsx'}}

" flow highlighting
let g:javascript_plugin_flow = 1

" flow quickfix autoclose
let g:flow#autoclose = 1

" nerdcommenter spaces please
let NERDSpaceDelims=1

" fix for first line bug using vim in hyper
set t_RV=
