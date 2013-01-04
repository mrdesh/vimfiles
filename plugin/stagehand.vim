"try to get this to work without "$MYVIMFILES"

if !exists("$MYVIMFILES")
	throw "Stagehand: This script needs a MYVIMFILES set"
endif

let g:def_proj_temp_dir = $MYVIMFILES . "/stagehand"

function! s:projTemplateDir()
	let l:dir = g:def_proj_temp_dir
	if isdirectory("g:proj_temp_dir")
		let l:dir = g:proj_temp_dir
	endif

	return l:dir
endfunction

function! s:projTemplateOpen(template)
	let l:file = s:projTemplateDir() . "/" .  a:template
	exe "vs " . l:file . ".vim"
endfunction

function! s:useProjTemplate(template)
	let l:file = s:projTemplateDir() . "/" . a:template . ".vim"
	if !filereadable(l:file)
		throw "Stagehand: Template \"" . l:file . "\" doesn't exist"
	endif
	exe "source " . l:file 
endfunction

command! -nargs=1 StagehandOpen call s:projTemplateOpen("<args>")
command! -nargs=1 StagehandUse call s:useProjTemplate("<args>")
