" vundle config
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'chriskempson/base16'
Plugin 'bling/vim-airline'

" editor settings
filetype plugin indent on
set term=xterm-256color
set history=700
set hidden
set nocompatible 
set title 
set autoread
let mapleader=','
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set so=7
set wildmenu
set number
set cursorline
set hid 
set laststatus=2
set ignorecase 
set smartcase
set hlsearch "Highlight search things
set incsearch 
set nolazyredraw
:noremap <silent> <Space> :silent noh<Bar>echo<CR>
set magic 
set showmatch
set mat=2

" fonts and colors
syntax on
set background=dark
" colorscheme for term
colorscheme lucius

set encoding=utf8
set fenc=utf-8
set termencoding=utf-8

if has("gui_running")
   colorscheme base16-ocean
   set guioptions-=m
   set guioptions-=T
   set guioptions-=r
   set guifont=Source\ Code\ Pro\ Medium:h13
endif

" tabs and indentation

set expandtab
set shiftwidth=3
set tabstop=3
set smarttab
set softtabstop=3
set backspace=eol,start,indent
set textwidth=80
set t_Co=256
set autoindent "Auto indent
set smartindent "Smart indent
autocmd FileType make setlocal noexpandtab

" rebinds

" easier way to move between splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" arrow keys move through buffers
map <right> :bn<cr>
map <left> :bp<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
catch
endtry
map 0 ^

" plugin configs
let g:syntastic_cpp_checkers=['cpplint', 'gcc', 'ycm']
let g:airline_powerline_fonts = 1
map <C-n> :NERDTreeToggle<CR>
