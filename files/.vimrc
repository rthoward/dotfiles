"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
Bundle 'airblade/vim-gitgutter'
Bundle 'chriskempson/base16-vim'
Bundle 'Lokaltog/vim-powerline'

filetype plugin indent on

set history=700
set hidden
set nocompatible 
set title 
set autoread

let mapleader=','

set backupdir=~/.vim/_backup
set directory=~/.vim/_swap

" buffer between cursor and top / bottom of screen
set so=7

set wildmenu
set number
set cursorline

" change buffers without saving
set hid 

" status bar always
set laststatus=2

" searching
set ignorecase 
set smartcase
set hlsearch "Highlight search things
set incsearch 
set nolazyredraw
:noremap <silent> <Space> :silent noh<Bar>echo<CR>
set magic 
set showmatch
set mat=2



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tab settings
set expandtab
set shiftwidth=3
set tabstop=3
set smarttab
set softtabstop=3 " backspace treats expandtab like tab
set backspace=eol,start,indent

set textwidth=80
set t_Co=256

set autoindent "Auto indent
set smartindent "Smart indent

" turn off tab expansion for makefiles
autocmd FileType make setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" NERDTree
map <C-n> :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark

syntax on " enable syntax hilighting

set encoding=utf8
set fenc=utf-8
set termencoding=utf-8

if has("gui_running")

colorscheme base16-default

   set guioptions-=m
   set guioptions-=T
   set guioptions-=r


   if has("gui_gtk2")
      set guifont=mensch\ for\ powerline\ 12
   elseif has("gui_win32")
      set guifont=Consolas:h14:cANSI
   endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_cpp_checkers=['cpplint', 'gcc', 'ycm']
let g:Powerline_symbols = 'fancy'
