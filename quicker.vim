" configure your key map this:
" this plugin promote one function :
"	type Ctrl + J in insert mode 
"	input your C comment	
"	then print comment in current cursor
imap <C-K> <Esc>:call AutoCommandEntry()<CR>i
inoremap <expr> <C-J> MyComment()
inoremap <expr> <C-L> MyHighLight()

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
		"let m = matchadd("DiffText", word_need)
		execute "syntax keyword DiffText " . word_need
		let g:word_highlight[word_need] = 1
		return ""
	endif
	let m = g:word_highlight[word_need]
	echo m
	execute "syntax keyword concealds " . word_need
	"call matchdelete(m)
	call remove(g:word_highlight, word_need)
	return ""
endfunc

" quicker command deal
func Select(cmd_str, line_num)
	call setline(a:line_num, "")
	call append(a:line_num, a:cmd_str)
endfunc
