" TIP: To re-source the vimrc make sure to use bangs for functions and
" commands.


if has("win32")
	let $MYVIMFILES = $USERPROFILE . "\\vimfiles"
else
	let $MYVIMFILES = $HOME . "/.vim"
endif

source $MYVIMFILES/vimrc.local

" OPTIONS {{{

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
set gdefault
set cf
set mouse=a
set mousehide
set wildmenu
set foldmethod=marker
"set iskeyword-=_ "ok this messes up tag searching
syntax on

" }}}
" VUNDLE {{{

set rtp+=$MYVIMFILES/vundle
helptags $MYVIMFILES/vundle/doc
call vundle#rc($MYVIMFILES . "/bundle")

" Just for the record, check out Kana's github. He's a swiss army knife.
" Specifically, his textobj stuff.

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
"Bundle 'spolu/dwm.vim'
"Bundle 'benmills/vimux'
"Bundle 'vim-scripts/DrawIt'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'danro/rename.vim'
Bundle 'tpope/vim-fugitive'
"Bundle 'tmallen/proj-vim'
"Bundle 'aaronbieber/quicktask'
Bundle 'vim-scripts/vimwiki'
"Bundle 'jceb/vim-orgmode'
"Bundle 'vim-scripts/vimprj'
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
Bundle 'mattn/zencoding-vim'
Bundle 'vim-scripts/closetag.vim'
Bundle 'sukima/xmledit'

"" Colors
"Bundle 'altercation/vim-colors-solarized'

"" Dependencies
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/DfrankUtil'

" }}}
" SETTINGS {{{

au BufNewFile,BufRead *.md set filetype=markdown

let g:NERDTreeChDirMode = 2
let g:NERDTreeShowBookmarks = 1

let g:ctrlp_extensions = [ 'tag', 'buffertag' ]

let g:UltiSnipsEditSplit = 'vertical'

" }}}
" MAPPINGS {{{

nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

let mapleader = ","
let maplocalleader = "\\"

noremap <Leader><Space> :noh<CR>

noremap H ^
noremap L g_

"Nope. C-[ is equivalent to Esc
"nmap <C-[> <C-T>

" }}}
" SHORTCUTS {{{

command! Bd call s:bufferClose()
function! s:bufferClose()
	let l:buf = bufnr("%")
	bprevious!
	exe 'bdelete!' . l:buf
endfunction

command! Cdf cd %:p:h

command! Nt NERDTree
command! Ntc NERDTreeClose

command! Tb TagbarOpen
command! Tbc TagbarClose

command! Vimwiki VimwikiIndex

command! -nargs=1 UltiSnips UltiSnipsEdit <args>
command! -nargs=1 Us UltiSnips <args>

command! -nargs=1 Plugin vs $MYVIMFILES/plugin/<args>
command! -nargs=1 Pl Plugin<args>

" }}}
" VIM GIT MANAGEMENT {{{

command! Vimrc :vs $MYVIMRC
command! VimrcLocal :vs $MYVIMFILES/vimrc.local
command! VimrcSource :source $MYVIMRC

command! VimSettingsPush call s:vimSettingsPush()
function! s:vimSettingsPush()
	let curdir = getcwd()
	cd $MYVIMFILES
		
	!git push

	exe 'cd ' . curdir
endfunction

command! VimSettingsPull call s:vimSettingsPull()
function! s:vimSettingsPull()
	let curdir = getcwd()
	cd $MYVIMFILES
		
	!git pull

	exe 'cd ' . curdir
endfunction

command! VimSettingsFetch call s:vimSettingsFetch()
function! s:vimSettingsFetch()
	let curdir = getcwd()
	cd $MYVIMFILES
		
	!git fetch

	exe 'cd ' . curdir
endfunction

" }}}
" APPEARANCE {{{

colorscheme zenburn

" }}}

