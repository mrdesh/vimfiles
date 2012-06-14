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

set rtp+=$MYVIMFILES/user
set rtp+=$MYVIMFILES/vundle
helptags $MYVIMFILES/vundle/doc
call vundle#rc($MYVIMFILES . "/bundle")

Bundle 'fholgado/minibufexpl.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Raimondi/delimitMate'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'tmallen/proj-vim'
Bundle 'vim-scripts/ProtoDef'
Bundle 'vim-scripts/UltiSnips'
Bundle 'vim-scripts/vimwiki'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/zencoding-vim'
Bundle 'michaeljsmith/vim-indent-object' 
Bundle 'godlygeek/tabular' 
Bundle 'vim-scripts/closetag.vim'

filetype plugin indent on

""""VIM""""
"""""""""""
set rtp+=$MYVIMFILES/personal
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
set iskeyword-=_ 
syntax on


""""PLUGIN""""
""""""""""""""
"helps protodef find it's perl script (it's still broken though, damnit)
let g:protodefprotogetter = $MYVIMFILES . "/bundle/protodef/pullproto.pl"

"hack to keep Surround from hijacking visual replace
autocmd VimEnter * xunmap s

let g:NERDTreeChDirMode = 2

"sets filetypes for vim-commentary
autocmd FileType python set commentstring=#\ %s
autocmd FileType html 	set commentstring=<!--\ %s\ -->
autocmd FileType lua 	set commentstring=--[[\ %s\ --]]
autocmd FileType vim 	set commentstring=\"\ %s

"nicer bindings for delimitMate
"imap <Nul> <Plug>delimitMateS-Tab		
"imap <C-g><Space> <Plug>delimitMateJumpMany

""""INPUT""""
"""""""""""""
let mapleader = ' '
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

nmap <Leader>t <C-]>
nmap <Leader>T <C-T>

"clipboard mode, works in gvim, doesn't work in some vterms?
nmap <C-Q>	"+

""""APPEARANCE""""
""""""""""""""""""
set guifont=Liberation\ Mono\ 12
set t_Co=256

""dark
"colorscheme solarized
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"set background="light"

""light
"colorscheme default
"set background="light"

""whatevs, no more solarized
colorscheme zenburn



""""TAGS""""
""""""""""""
set tags^=../tags

command UpdateTags call s:updateTags()
function s:updateTags()
	let l:file_list = split( &tags, ',' ) 
	for l:file in l:file_list
		let l:tagfile = findfile( l:file )
		if !empty( l:tagfile )
			echo 'Updating tagfile ' . l:tagfile
			exe '!ctags' '-f ' . l:tagfile . ' --tag-relative=yes --recurse=yes ./'
			return
		endif
	endfor

	echo 'Tagfile not found (try CreateTags first)'
endfunction

command -nargs=? CreateTags call s:createTags( "<args>" )
function s:createTags( ... )
	let l:tagfile = './tags'
	if !empty(a:1)
		let l:tagfile = a:1
	endif

	if !empty(findfile(l:tagfile))
		echo 'File already exists (use UpdateTags)'
		return
	endif

	echo 'Creating tagfile ' . l:tagfile
	exe '!ctags' '-f ' . l:tagfile . ' --tag-relative=yes --recurse=yes'
endfunction


""""OTHER""""
"""""""""""""
command Bc call s:bufferClose()
function s:bufferClose()
	let l:buf = bufnr("%")
	bprevious!
	exe 'bdelete!' . l:buf
endfunction


command Cdf cd %:p:h

