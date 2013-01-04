
let g:project_dir = fnamemodify("./project",":p:h")
let g:project_root = fnamemodify("./",":p:h")

let &runtimepath .= "," . g:project_dir

let g:proj_tag_file = './tags'

"first item is the current wiki
"call insert(g:vimwiki_list, {
call insert(g:vimwiki_list, {
\ 		'path': g:project_dir . '/wiki',
\ 		'path_html': g:project_dir . '/wiki/html',
\ 		'auto_export': 0,
\ 		'index': 'index',
\ 		'ext': '.wiki',
\ 		'syntax': 'default',
\ 		'template_path': g:project_dir . '/wiki/templates',
\ 		'template_ext': '.html',
\ 		'template_default': 'default',
\ 		'css_name': 'style.css',
\			'maxhi': 0,
\ 		'nested_syntaxes': {},
\ 		'diary_rel_path': 'diary/',
\ 		'diary_index': 'diary',
\ 		'diary_header': 'Diary',
\ 		'diary_sort': 'desc',
\ 		'diary_link_fmt': '%Y-%m-%d',
\ 		'custom_wiki2html': '',
\ 		'list_margin': -1,
\ 		'temp': 0
\})

let g:UltiSnipsDontReverseSearchPath=1

call add(g:UltiSnipsSnippetDirectories, g:project_dir . "/snippets")

command! TodoList bo 10sp +VimwikiIndex | VimwikiGoto todo

