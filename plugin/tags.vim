
let g:tagfile_type='default'

let g:tag_update_filter='*'
let g:tag_search_root='./'
let g:tag_search_depth=''
let g:tag_search_ignore=[]

let g:tag_search_debug=0

let g:proj_tag_file = './tags'

function! s:updateTags( ... )
	if !empty(a:1)
		let l:tagfile = findfile( a:1 )
	else
		let l:tagfile = findfile( g:proj_tag_file )
	endif

	if !empty(l:tagfile)
		echo 'Updating tagfile ' . l:tagfile
		call s:tagcmd(l:tagfile)
		return
	endif
	
	"at this point cant find anything
	if !empty(a:1)
		echo 'Creating tagfile ' . l:tagfile
		call s:createTags(a:1) || echo "Failed to create tag file: \'" . a:1 . "\' (ctags may not want to overwrite it)"
	endif
			
	echo "Tag file not found, give me a path and I'll make one."
endfunction

" force an overwrite
"command! -nargs=? UpdateTagsForce call s:updateTagsForce("<args>")
"function! s:updateTagsForce( ... )
"	
"endfunction

function! s:createTags(tagfile)
	if empty(findfile(a:tagfile))
		call s:tagcmd(a:tagfile)
	endif
endfunction

function! s:tagcmd(tagfile)
" jsctags takes way too long?
"	if(g:tagfile_type == 'js')
"		exe 'silent '
"	else
		let l:command = 'silent !find ' . shellescape(g:tag_search_root)

		if !empty(g:tag_search_depth)
			let l:command .= ' -maxdepth ' . g:tag_search_depth
		endif


		let l:command .=	' -iname ' . shellescape(g:tag_update_filter)

		if !empty(g:tag_search_ignore)
			for dir in g:tag_search_ignore 
				let l:command .= ' -not -path ' . shellescape(dir)
			endfor
		endif

		let l:command .=  ' | ctags -L - -f ' . a:tagfile 
		let l:command .=	' --tag-relative=yes --recurse=yes '

		if(g:tag_search_debug == 1)
			echoerr 'Tagsearch: Executing command: ' . l:command
		endif

		exe l:command
		redraw!
" endif
endfunction

command! -nargs=? UpdateTags call s:updateTags("<args>")
