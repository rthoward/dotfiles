"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=700
set hidden
set nocompatible " no vi backwards compatability
set title " set terminal title to current path
set autoread

" Enable filetype plugin
filetype plugin on
filetype indent on

" bind leader key
let mapleader=','

" backup and swap directories
set backupdir=/home/rhoward/.backup/vim_backup
set directory=/home/rhoward/.backup/vim_swap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cusrors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu
set number " draw line numbers
set cursorline
set hid "Change buffer - without saving

set laststatus=2

" Set backspace config
set backspace=eol,start,indent

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching brackets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" unhilight search on space
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark

syntax on " enable syntax hilighting
   colorscheme lucius

set encoding=utf8
set fenc=utf-8
set termencoding=utf-8

if has("gui_running")

colorscheme base16-default

   set guioptions-=m
   set guioptions-=T
   set guioptions-=r


   if has("gui_gtk2")
      set guifont=mensch\ for\ powerline\ 11
   elseif has("gui_win32")
      set guifont=Consolas:h14:cANSI
   endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tab settings
set expandtab
set shiftwidth=3
set tabstop=3
set smarttab
set softtabstop=3 " backspace treats expandtab like tab

set textwidth=80
set t_Co=256

set autoindent "Auto indent
set smartindent "Smart indent

" turn off tab expansion for makefiles
autocmd FileType make setlocal noexpandtab

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

" NERDTree
map <C-n> :NERDTreeToggle<CR>

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

let g:syntastic_cpp_checkers=['cpplint', 'gcc', 'ycm']
let g:Powerline_symbols = 'fancy'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc Leader Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remove trailing whitespace from file
nnoremap <leader>W :%s\/s\+$\\<cr>:let @/=''<CR>

" fold code from current line to next closing character
nnoremap <leader>f zf%

execute pathogen#infect()
