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
endfunc

" quick C comment
func MyComment()
	let m_comment = inputdialog("Comment:", "")
	if m_comment != ""
		return printf("\/* %s *\/", m_comment)
	endif
	return ""
endfunc

" get a word from linebuf
"func GetWord()
	"let line_buf=getline(line("."))
	"let cur_pos=getpos(".")
	"let col_num=cur_pos[2]
	"while col_num > 1
		"if 
"endfunc

" quick world high light
func MyHighLight()
	"let word_need=
	"if 
		"let m = matchadd("DiffText", word_need)
		"return ""
	"endif
		"call matchdelete(m)
	"return ""
endfunc

" quicker command deal
func Select(cmd_str, line_num)
	call setline(a:line_num, "")
	call append(a:line_num, a:cmd_str)
endfunc
