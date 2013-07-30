" configure your key map this:
" this plugin promote one function :
"	type Ctrl + J in insert mode 
"	input your C comment	
"	then print comment in current cursor
imap <C-K> <Esc>:call AutoCommandEntry()<CR>i<Right>
inoremap <expr> <C-J> MyComment()
" map <expr> <C-L> MyHighLight()
inoremap <expr> <C-L> MyHighLight()
noremap <C-L> <Esc>:call MyHighLight()<CR>

" quicker command entry
func AutoCommandEntry()
	call Select(getline(line(".")), line("."))
	return
endfunc

" quick C comment
func MyComment()
	let m_comment = inputdialog("Comment:", "")
	if m_comment != ""
		return printf("\/* %s *\/", m_comment)
	endif
	return ""
endfunc

" quick world high light
let g:word_highlight={}
func MyHighLight()
	let word_need=expand("<cword>")
	if strlen(word_need)==0
		return ""
	endif
	if get(g:word_highlight, word_need) == 0
		let m = matchadd("DiffText", word_need)
		"execute "syntax keyword DiffText " . word_need
		let g:word_highlight[word_need] = m
		return ""
	endif
	let m = g:word_highlight[word_need]
	echo m
	"execute "syntax keyword concealends " . word_need
	call matchdelete(m)
	call remove(g:word_highlight, word_need)
	return ""
endfunc

" quicker command deal
func Select(cmd_str, line_num)
	if a:cmd_str == "func"
		call MyFuncHead(a:line_num)
	endif
	if a:cmd_str == "config"
		call MyConfig()
	endif
	return
endfunc

func MyConfig()
	let myname=inputdialog("What's your name?", "")
	if myname==""
		return
	endif
	call setreg('n', myname)

	let myprj=inputdialog("What's your project?", "")
	if myprj==""
		return
	endif
	call setreg('p', myprj)

	call setreg('i', 1)
	return
endfunc

func MyFuncHead(line_num)
	if getreg('i')==0
		call MyConfig()
	endif
	return
endfunc
