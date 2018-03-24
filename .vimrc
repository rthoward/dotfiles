" ----------------------------------------------------------------------------
" PATHOGEN
" ----------------------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'qpkorr/vim-bufkill'
Plugin 'bling/vim-bufferline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim'

Plugin 'w0rp/ale'
Plugin 'davidhalter/jedi-vim'

Plugin 'elixir-lang/vim-elixir'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

call vundle#end()            " required
filetype plugin indent on    " required


" ----------------------------------------------------------------------------
" KEY MAPS
" ----------------------------------------------------------------------------

" space for leader key
let mapleader = " "
nnoremap <space> <nop>

" fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>R :source ~/.vimrc<CR>
nmap <Leader>F :NERDTreeToggle<CR>

nnoremap <leader><space> :let @/=''<cr> " clear search
nnoremap <C-e> :e#<CR>
vmap <leader>c "*y

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nmap \r :call TmuxPaneRepeat()<CR>

" ----------------------------------------------------------------------------
" VIM SETTINGS
" ----------------------------------------------------------------------------

syntax on
set timeoutlen=1000 ttimeoutlen=0

" let base16colorspace=256
colorscheme dracula

set number
set relativenumber
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=2

set laststatus=2
set showmode
set showcmd

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set hidden

set t_Co=256
set background=dark

set guifont=Iosevka\ Regular:h16
 
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

" jedi-mode: disable docstring popup during autocompletion
autocmd FileType python setlocal completeopt-=preview

" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

let g:jsx_ext_required = 0

" ----------------------------------------------------------------------------
" TMUX INTEROP
" ----------------------------------------------------------------------------

let g:tmux_console_pane = 'test'

function! TmuxPaneRepeat()
  write
  silent execute ':!tmux send-keys -t' g:tmux_console_pane 'C-p' 'C-j'
  redraw!
endfunction
