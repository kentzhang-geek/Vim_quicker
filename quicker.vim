" configure your key map this:
" this plugin promote one function :
	"type Ctrl + J in insert mode 
	"input your C comment	
	"then print comment in current cursor
inoremap <expr> <C-J> MyComment()
inoremap <expr> <C-K> AutoCommandEntry()


iabbrev teh the
iabbrev other other
iabbrev wnat wnat


func AutoCommandEntry()
	let command_str = inputdialog("Command:", "")
	if command_str != ""
		return Select(command_str)
	endif
	return ""
endfunc

func MyComment()
	let m_comment = inputdialog("Comment:", "")
	if m_comment != ""
		return printf("\/* %s *\/", m_comment)
	endif
	return ""
endfunc

func Select(cmd_str)
	return printf("%s\n",a:cmd_str)
endfunc
