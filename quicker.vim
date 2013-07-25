"this plugin promote one function :
	"type Ctrl + J in insert mode 
	"input your C comment
	
	"then print comment in current cursor
	

" 一键添加注释

func MyComment()
	let m_comment = inputdialog("Comment:", "")
	if m_comment != ""
		return printf("\/* %s *\/", m_comment)
	endif
	return ""
endfunc
inoremap <expr> <C-J> MyComment()
