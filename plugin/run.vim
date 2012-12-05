let s:intr_map = {
	\		'python' : 'python2',
	\		'ruby' : 'ruby'
	\}

command! -nargs=* Run call s:run_current("<args>")
function! s:run_current(...)

	let l:filetype = &filetype

	if empty(get(s:intr_map, l:filetype))
		return
	endif

	let l:intr = s:intr_map[ l:filetype ] 
	let l:filename = expand('%')
	let l:cmd = ''
	let l:cmd .= '!reset && '
	let l:cmd .= l:intr . ' ' . l:filename
	let l:cmd .= ' ' . join(a:000, ' ')
	exe l:cmd
endfunction

