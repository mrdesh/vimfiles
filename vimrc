" TIP: To re-source the vimrc make sure to use bangs for function and
" command definitions.
"
" ALSO: :help function-list gives you all the built in functions


if has("win32")
	let $MYVIMFILES = $USERPROFILE . "\\vimfiles"
else
	let $MYVIMFILES = $HOME . "/.vim"
endif

let g:vimwiki_list = [] "have to declare this so it can be appended to

source $MYVIMFILES/vimrc.local

" GENERAL OPTIONS {{{

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
set tw=0 "lol really vim?
"set iskeyword-=_ "ok this messes up tag searching
syntax on

" }}}
" VUNDLE {{{
"
set rtp+=$MYVIMFILES/vundle
helptags $MYVIMFILES/vundle/doc
call vundle#rc($MYVIMFILES . "/bundle")

" DrChip: http://www.drchip.org/astronaut/vim/index.html
" Kana:   https://github.com/kana

Bundle 'fholgado/minibufexpl.vim'
"Bundle 'vim-scripts/TabBar'
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
Bundle 'vim-scripts/YankRing.vim'
"Bundle 'vim-scripts/DrawIt'
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/dbext.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'tmallen/proj-vim'
Bundle 'tpope/vim-repeat'
"Bundle 'aaronbieber/quicktask'
Bundle 'vim-scripts/vimwiki'
"Bundle 'vim-scripts/project.tar.gz'
"Bundle 'vim-scripts/myprojects'
"Bundle 'jceb/vim-orgmode'
"Bundle 'vim-scripts/vimprj'
" if !has('win32')
" 	Bundle 'vim-scripts/UltiSnips'
" endif
Bundle 'garbas/vim-snipmate'
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
Bundle 'kana/vim-scratch'
Bundle 'vim-scripts/ZoomWin'
Bundle 'vim-scripts/utl.vim'
Bundle 'vim-scripts/VisIncr'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-unimpaired'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/tlib'

"" Colors
"Bundle 'altercation/vim-colors-solarized'
Bundle 'zeis/kolor'

"" Dependencies
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/DfrankUtil'

" }}}
" SETTINGS {{{

set tags=./tags;/

let $PROJTEMPLATES = $MYVIMFILES . "/project"

augroup filetypes
	au BufNewFile,BufRead *.md set filetype=markdown
augroup END

let g:NERDTreeChDirMode = 2
let g:NERDTreeShowBookmarks = 1

let g:ctrlp_extensions = [ 'tag', 'buffertag', 'mixed' ]

let g:UltiSnipsEditSplit = 'vertical'

let g:ProjFileBrowser = 'off'

let g:miniBufExplShowBufNumbers = 0

"this could be cool, mess with this
"set kp=chromium\ http\://www.google.com/search\?q\=

" }}}
" MAPPINGS {{{

nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

let mapleader = ","
let maplocalleader = "\\"

noremap <Leader><Space> :noh<CR>
noremap <Leader>. :CtrlPTag<CR>
noremap <Leader>e :CtrlPMixed<CR>
noremap <Leader>b :b#<CR>
noremap H ^
noremap L g_
inoremap <C-L> <C-R>=delimitMate#JumpAny("\<C-L>")<CR>

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

command! CDfile cd %:p:h

command! Files NERDTreeToggle

command! Tags TagbarToggle

command! ProjSettings ProjSettings

command! -nargs=1 Snippet UltiSnipsEdit <args>

command! -nargs=1 Plugin vs $MYVIMFILES/plugin/<args>.vim

"gotta find a way to make vertical splits not fuck up the layout

"command! Wiki vert topleft split +VimwikiIndex
command! Wiki e +VimwikiIndex
command! WikiSelect VimwikiUISelect
command! Homepage exe 'e ' . g:user_homepage

"command! Vimrc vert topleft split $MYVIMRC
"command! VimrcLocal vert topleft split $MYVIMFILES/vimrc.local
command! Vimrc e $MYVIMRC
command! VimrcLocal e $MYVIMFILES/vimrc.local
command! Source source $MYVIMRC
command! Scratch ScratchOpen 

" }}}
" VIM AND GIT {{{

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

