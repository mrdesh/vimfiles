""""IDEAS""""
"""""""""""""
"-command to paste text as a new line (using the autoindent rules)
"	or maybe something to create autoindent rules on the fly?
"-command to go to next line and enter append mode at the end
"-command to go into "virtual edit mode"; adjusts the "virtualedit" option
"-command to source selection (so i can re-source sections of .vimrc)
"-command to select line, minus trailing whitespace

""""GENERAL""""
""""""""""""""
call pathogen#infect()
call pathogen#helptags()


if has("win32")
	let $MYVIMFILES = $USERPROFILE . "\\vimfiles"
else
	let $MYVIMFILES = $HOME . "/.vim"
endif

let $BKVIMNOTES = $HOME . "/notes.txt"
let $BKPROJECT = "../project.txt"


helptags $MYVIMFILES/doc

set hidden
set nocompatible
set backupdir=$MYVIMFILES/backups
set scrolljump=1
set sidescroll=1
set nowrap
syntax on

""""GENERAL-PLUGIN""""
""""""""""""""""""""""
"helps protodef find it's perl script (it's still broken though, damnit)
let g:protodefprotogetter = $MYVIMFILES . "/bundle/protodef/pullproto.pl"

"hack to keep Surround from hijacking visual replace
xmap <Leader>` <Plug>Vsurround

"unmaps annoying stuff from a.vim
"iunmap <Leader>ihn
"iunmap <Leader>is
"iunmap <Leader>ih

"""""INPUT"""""
"""""""""""""""
let mapleader = ' '
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

nmap <Leader>t <C-]>
nmap <Leader>T <C-T>


""""APPEARANCE""""
""""""""""""""""""
set guifont=Liberation\ Mono\ 12


set background="light"

command Shade call s:toggleColorShade()
function s:toggleColorShade()
	if &background == "light"
		let g:solarized_termcolors=256
		let g:solarized_contrast="high"
		colorscheme solarized
		set background="dark"
	else
		set background="light"	
		colorscheme default
	endif
endfunction

""set background=light
""colorscheme morning


""""TAGS""""
"""""""""""""
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
	exe '!ctags' '-f ' . l:tagfile . ' --tag-relative=yes --recurse=yes ./'
endfunction


""""OTHER""""
"""""""""""""
command Bc call s:bufferClose()
function s:bufferClose()
	let l:buf = bufnr("%")
	bprevious!
	exe 'bdelete!' . l:buf
endfunction


command Cdf call s:changeDirCurrentFile()
function s:changeDirCurrentFile()
	""this should cd to the directory of the current file	
endfunction


""""PLUGIN CONFIG""""
"""""""""""""""""""""
""EasyTags""
""""""""""""
""let g:project_tags="../tags"
""let s:project_tags_on=0
""command ToggleProjectTags call s:toggleProjectTags()
""function s:toggleProjectTags()
""	if s:project_tags_on == 0
""		"let g:easytags_always_enabled = 1 
""		let &tags=g:project_tags . "," . &tags
""		let g:easytags_dynamic_files = 1
""		let s:project_tags_on=1
""	else
""		let l:list = split(&tags,',')	
""		call remove(list,g:project_tags)
""		let &tags= join(list,',')
""		let g:easytags_dynamic_files = 0
""		let s:project_tags_on = 0
"" 	endif
""endfunction

""Surround""
""""""""""""	



