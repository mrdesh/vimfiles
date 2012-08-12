""""IDEAS""""
"""""""""""""
"-command to paste text as a new line (using the autoindent rules)
"	or maybe something to create autoindent rules on the fly?
"-command to go to next line and enter append mode at the end
"-command to go into "virtual edit mode"; adjusts the "virtualedit" option
"-command to source selection (so i can re-source sections of .vimrc)
"-command to select line, minus trailing whitespace


""""GENERAL""""
"""""""""""""""
if has("win32")
	let $MYVIMFILES = $USERPROFILE . "\\vimfiles"
else
	let $MYVIMFILES = $HOME . "/.vim"
endif

""""VUNDLE""""
""""""""""""""
set nocompatible
filetype off

set rtp+=$MYVIMFILES/vundle
helptags $MYVIMFILES/vundle/doc
call vundle#rc($MYVIMFILES . "/bundle")

" Tools
Bundle 'fholgado/minibufexpl.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'vim-scripts/FuzzyFinder'
Bundle 'kien/ctrlp.vim'
"Bundle 'Shougo/neocomplcache'
"Bundle 'vim-scripts/sessionman.vim'
"Bundle 'fmoralesc/vim-pad'
"Bundle 'kshenoy/vim-signature'
Bundle 'scrooloose/syntastic'
"Bundle 'gordyt/rope-vim'

" Project management / GTD
"Bundle 'tmallen/proj-vim'
Bundle 'aaronbieber/quicktask'
"Bundle 'vim-scripts/vimwiki'
"Bundle 'jceb/vim-orgmode'
"Bundle 'vim-scripts/vimprj'

" Auto text
if !has('win32')
	Bundle 'vim-scripts/UltiSnips'
endif
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular' 								
Bundle 'Raimondi/delimitMate'
"Bundle 'vim-scripts/ProtoDef'
Bundle 'michaeljsmith/vim-indent-object' 
"Bundle 'ervandu/supertab' 
Bundle 'tomtom/tcomment_vim'

" Markup/HTML/CSS
Bundle 'mattn/zencoding-vim'
Bundle 'vim-scripts/closetag.vim'

" Colors
Bundle 'altercation/vim-colors-solarized'

" Dependencies
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/DfrankUtil'

filetype plugin indent on


""""VIM""""
"""""""""""
set rtp+=$MYVIMFILES/user
helptags $MYVIMFILES/doc

set nocompatible
set nobackup
set noswapfile
set hidden
set scrolljump=1
set sidescroll=1
set ts=2
set sw=2
set autoindent
set smartindent
set nowrap
set backspace=indent,eol,start
set rnu
set ruler
set laststatus=2
set novisualbell
set noerrorbells
set encoding=utf-8
filetype plugin indent on
set hlsearch
set incsearch
set cf
set mouse=a
set mousehide
"set iskeyword-=_ "ok this messes up tag searching
syntax on


""""PLUGIN""""
""""""""""""""
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 22

let g:ctrlp_extensions = ['tag', 'buffertag', 'line', 'undo']

nmap <C-p>t :CtrlPTag<CR>

let maplocalleader = ','

""""INPUT""""
"""""""""""""
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

"Nope. C-[ is equivalent to Esc
"nmap <C-[> <C-T>

""""APPEARANCE""""
""""""""""""""""""
colorscheme zenburn

""""OTHER""""
"""""""""""""
command Bd call s:bufferClose()
function s:bufferClose()
	let l:buf = bufnr("%")
	bprevious!
	exe 'bdelete!' . l:buf
endfunction

command Cdf cd %:p:h

