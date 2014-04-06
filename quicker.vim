" configure your key map this:
" this plugin promote one function :
"	type Ctrl + J in insert mode 
"	input your C comment	
"	then print comment in current cursor

" Auto command
imap <M-i> <Esc>:call AutoCommandEntry()<CR>a<Right>
imap <C-K> <Esc>:call AutoCommandEntry()<CR>a<Right>

" Cscope command
map <M-c> <Esc>:call MyCscope()<CR>
imap <M-c> <Esc>:call MyCscope()<CR>

" Comment command
inoremap <expr> <M-j> MyComment()
inoremap <expr> <C-J> MyComment()

" Highlight command
inoremap <expr> <M-l> MyHighLight()
noremap <M-l> <Esc>:call MyHighLight()<CR>
inoremap <expr> <C-L> MyHighLight()
noremap <C-L> <Esc>:call MyHighLight()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setting for cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  " add any database in home directory
  " if filereadable("~/cscope/cscope.out")
  "    cs add "~/cscope/cscope.out"
  " endif
  set csverb
endif

" Cscope command entry
func MyCscope()
	let keyword=expand("<cword>")
	let wordtype=confirm("What kind do you want?", "c&alling this function\ncalled &by this funcion\n&eGrep\n&find this file\n&definition\nfile &including this file\n&c-symbol\n&text String")
	if wordtype==0
		let wordtype=7
	endif
	let inputword=inputdialog("The keyword is:", keyword, keyword)
	let word={1:'c', 2:'d', 3:'e', 4:'f', 5:'g', 6:'i', 7:'s', 8:'t'}
	:execute "cs find " . word[wordtype] " " . inputword
	return
endfunc

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

" Find command string
func Judge_word(cmd_str, promote_str)
	if matchend(a:cmd_str, printf("\t%s", a:promote_str)) > 0
		return 1
	endif
	if matchend(a:cmd_str, printf(" %s", a:promote_str)) > 0
		return 1
	endif
	if strpart(a:cmd_str, 0, strlen(a:promote_str)) == a:promote_str
		return 1
	endif
	return 0
endfunc

" quicker command deal
func Select(cmd_str, line_num)
	if getreg('i')==0
		call MyConfig()
	endif
	if Judge_word(a:cmd_str, "config")
		call MyConfig()
		call setline(a:line_num, "")
	endif
	
	if Judge_word(a:cmd_str, "func")
		call MyFuncHead(a:line_num)
	endif

	if Judge_word(a:cmd_str, "file")
		call MyFileHead(a:line_num)
	endif

	if Judge_word(a:cmd_str, "mds")
		call MyModifyTag("mds", a:line_num)
	endif
	if Judge_word(a:cmd_str, "mde")
		call MyModifyTag("mde", a:line_num)
	endif

	if Judge_word(a:cmd_str, "ads")
		call MyAddTag("ads", a:line_num)
	endif
	if Judge_word(a:cmd_str, "ade")
		call MyAddTag("ade", a:line_num)
	endif

	if Judge_word(a:cmd_str, "dt")
		call MyDelTag(a:line_num)
	endif

	if Judge_word(a:cmd_str, "if")
		call MyTemplete(a:line_num, "if")
	endif

	if Judge_word(a:cmd_str, "else")
		call MyTemplete(a:line_num, "else")
	endif

	if Judge_word(a:cmd_str, "while")
		call MyTemplete(a:line_num, "while")
	endif

	if Judge_word(a:cmd_str, "for")
		call MyTemplete(a:line_num, "for")
	endif

	if Judge_word(a:cmd_str, "enum")
		call MyEnum(a:line_num)
	endif

	if Judge_word(a:cmd_str, "struct")
		call MyStruct(a:line_num)
	endif

	if Judge_word(a:cmd_str, "{")
		call MyPair(a:line_num)
	endif

	if Judge_word(a:cmd_str, "TEST(") || Judge_word(a:cmd_str, "TEST_F(")
		call MyTest(a:line_num)
	endif

	if Judge_word(a:cmd_str, "cpp")
		call MyCpp(a:line_num)
	endif

	if Judge_word(a:cmd_str, "class")
		call MyClass(a:line_num)
	endif

	if Judge_word(a:cmd_str, "debug")
		call MyDebug(a:line_num)
	endif

	if Judge_word(a:cmd_str, "hi") || Judge_word(a:cmd_str, "history")
		call MyHi(a:line_num)
	endif

	return
endfunc

func MyConfig()
	call confirm("Notice : this plugin only apply C language")
	let myname=inputdialog("What's your name?", "")
	if myname==""
		return
	endif
	call setreg("n", myname)

	let myprj=inputdialog("What's your project?", "")
	if myprj==""
		return
	endif
	call setreg("p", myprj)

	let filetype = confirm("Witch type this file is?", "&C-Src\n&Gtest\n&Other")
	if filetype == 0
		let filetype = 3
	endif
	call setreg("t", filetype)
	call setreg("i", 1)
	return
endfunc

func MyFuncHead(line_num)
	let funcname=inputdialog("What's your function name?", "")
	if funcname == ""
		return
	endif
	let outparam=inputdialog("What's your return type?", "")
	if outparam != ""
		let outparam = outparam." "
	endif
	let inputparam = inputdialog("What's your intput params?", "")
	call setline(a:line_num,		"\/*********************************************************")
	call append(a:line_num,			printf("*\tFunc Name   : %s", funcname))
	call append(a:line_num + 1,		printf("*\tProject     : %s", getreg("p")))
	call append(a:line_num + 2,		printf("*\tAuthor      : %s", getreg("n")))
	call append(a:line_num + 3,		printf("*\tData        : %s", strftime("%c")))
	call append(a:line_num + 4,			   "*\tDescription : ")
	call append(a:line_num + 5,			   "*\t              ")
	call append(a:line_num + 6,			   "*\tHistory     : ")
	call append(a:line_num + 7,		printf("*\t\t%s", strftime("%c")))
	call append(a:line_num + 8,			   "*\t\t\tCreate.")
	call append(a:line_num + 9,		"**********************************************************/")
	call append(a:line_num + 10,		printf("%s%s(%s)", outparam, funcname, inputparam))
	call append(a:line_num + 11,		"{")
	call append(a:line_num + 12,		"}")
	call cursor(a:line_num + 5, strlen("*\tDescription : "))
	return
endfunc

func MyFileHead(line_num)
	if getreg('i')==0
		call MyConfig()
	endif
	let filename = expand("%:t")
	call append(0,		"\/*********************************************************")
	call append(1,		printf("*\tFile Name   : %s", filename))
	call append(2,		printf("*\tProject     : %s", getreg("p")))
	call append(3,		printf("*\tAuthor      : %s", getreg("n")))
	call append(4,		printf("*\tData        : %s", strftime("%c")))
	call append(5,			   "*\tDescription : ")
	call append(6,			   "*\t              ")
	call append(7,			   "*\tHistory     : ")
	call append(8,		printf("*\t\t%s", strftime("%c")))
	call append(9,			   "*\t\t\tCreate.")
	call append(10,		"**********************************************************/")
	call setline(a:line_num + 11, "")
endfunc

func MyModifyTag(str, line_num)
	if getreg('i')==0
		call MyConfig()
	endif
	let idt = indent(a:line_num)
	let idt = idt/4
	let tab = ""
	for i in range(1, idt)
		let tab = "\t".tab
	endfor
	if a:str == "mds"
		call setline(a:line_num, printf("%s/* Begin : Modify by %s for \"%s\" at %s */", tab, getreg("n"), getreg("p"), strftime("%c"), ))
		return
	endif
	call setline(a:line_num, printf(    "%s/* End   : Modify by %s for \"%s\" at %s */", tab, getreg("n"), getreg("p"), strftime("%c"), ))
	return
endfunc

func MyAddTag(str, line_num)
	if getreg('i')==0
		call MyConfig()
	endif
	let idt = indent(a:line_num)
	let idt = idt/4
	let tab = ""
	for i in range(1, idt)
		let tab = "\t".tab
	endfor
	if a:str == "ads"
		call setline(a:line_num, printf("%s/* Begin : Add by %s for \"%s\" at %s */", tab, getreg("n"), getreg("p"), strftime("%c"), ))
		return
	endif
	call setline(a:line_num, printf(    "%s/* End   : Add by %s for \"%s\" at %s */", tab, getreg("n"), getreg("p"), strftime("%c"), ))
	return
endfunc

func MyDelTag(line_num)
	if getreg('i')==0
		call MyConfig()
	endif
	let idt = indent(a:line_num)
	let idt = idt/4
	let tab = ""
	for i in range(1, idt)
		let tab = "\t".tab
	endfor
	call setline(a:line_num, printf(    "%s/* Tag   : Delete by %s for \"%s\" at %s */", tab, getreg("n"), getreg("p"), strftime("%c"), ))
endfunc

func MyTemplete(line_num, string)
	let indent = indent(line("."))
	let idt = ""
	let i = indent/4
	for i in range(1, i)
		let idt = "\t".idt
	endfor
	if 0 <= match(getline(a:line_num + 1), "{")
		call cursor(a:line_num + 2, i + 1)
		return 
	endif
	if a:string != "else"
		call setline(a:line_num,		printf(	"%s%s ()", idt, a:string))
	else
		call setline(a:line_num,		printf(	"%s%s", idt, a:string))
	endif
	call append(a:line_num,			printf(	"%s{",	idt))
	call append(a:line_num + 1,		printf(	"%s\t",	idt))
	call append(a:line_num + 2,		printf(	"%s}",	idt))
	call cursor(a:line_num, i + strlen(a:string) + 1)
endfunc

func MyEnum(line_num)
	let proname = getreg("p")
	let tagname = inputdialog("Input your enum name:", "")
	if tagname == ""
		return ""
	endif
	call setline(a:line_num,	printf("typedef tag_enum_%s_%s {", getreg("p"), tagname))
	call append(a:line_num,		printf("\t%s_INVALID = 0,", toupper(tagname)))
	call append(a:line_num + 1,	printf("\t%s_BUTT ,", toupper(tagname)))
	call append(a:line_num + 2, printf("} ENUM_%s;", toupper(tagname)))
endfunc

func MyStruct(line_num)
	let proname = getreg("p")
	let tagname = inputdialog("Input your struct name:", "")
	if tagname == ""
		return ""
	endif
	call setline(a:line_num,	printf("typedef struct tag_struct_%s_%s {", getreg("p"), tagname))
	call append(a:line_num,		"\t")
	call append(a:line_num + 1, printf("} STRUCT_%s;", toupper(tagname)))
	call cursor(a:line_num + 1, 4)
endfunc

func MyPair(line_num)
	let indent = indent(line("."))
	let idt = ""
	let i = indent/4
	for i in range(1, i)
		let idt = "\t".idt
	endfor
	call setline(a:line_num,			printf(	"%s{",	idt))
	call append(a:line_num,		printf(	"%s\t",	idt))
	call append(a:line_num + 1,		printf(	"%s}",	idt))
	call cursor(a:line_num + 1, i + 1)
endfunc

func MyTest(line_num)
	if getreg("t") != 2
		return
	endif
	let line_str = getline(a:line_num)
	let left_bracket = stridx(line_str, "(")
	let right_bracket = stridx(line_str, ")")
	let comma = stridx(line_str, ",")
	if (0 == stridx(line_str, "TEST")) && (left_bracket < comma) && (comma < right_bracket)
		let testcase = strpart(line_str, left_bracket + 1, comma - left_bracket - 1)
		let testnum = strpart(line_str, comma + 1, right_bracket - comma - 1)
		let space = stridx(testnum, " ")
		if space >= 0
			let testnum = strpart(testnum, space + 1)
		endif
		call append(a:line_num - 1,		"\/*********************************************************")
		call append(a:line_num ,			printf("*\tTest ID     : %s", printf("%s_%s", testcase, testnum)))
		call append(a:line_num + 1,		printf("*\tProject     : %s", getreg("p")))
		call append(a:line_num + 2,		printf("*\tAuthor      : %s", getreg("n")))
		call append(a:line_num + 3,		printf("*\tData        : %s", strftime("%c")))
		call append(a:line_num + 4,			   "*\tDescription : ")
		call append(a:line_num + 5,			   "*\t              ")
		call append(a:line_num + 6,			   "*\tHistory     : ")
		call append(a:line_num + 7,		printf("*\t\t%s", strftime("%c")))
		call append(a:line_num + 8,			   "*\t\t\tCreate.")
		call append(a:line_num + 9,		"**********************************************************/")
	endif		
endfunc

func MyDebug(line_num)
	call setline(a:line_num,		"#ifdef __DEBUG__") 
	call append(a:line_num,		"\t")
	call append(a:line_num + 1,		"#endif")
	call cursor(a:line_num + 1, 4)
	return
endfunc

func MyCpp(line_num)
	call setline(a:line_num,		"#ifdef __cplusplus") 
	call append(a:line_num,			"extern \"C\" {")
	call append(a:line_num + 1,		"#endif")
	call append(a:line_num + 2,		"")
	call append(a:line_num + 3,		"#ifdef __cplusplus") 
	call append(a:line_num + 4,		"}")
	call append(a:line_num + 5,		"#endif")
	call cursor(a:line_num + 2, 1)
	return
endfunc

func MyClass(line_num)
	let classname=inputdialog("What's name of this class?", "")
	if classname == ""
		return
	endif
	call setline(a:line_num,		"\/*********************************************************")
	call append(a:line_num,			printf("*\tClass Name  : %s", classname))
	call append(a:line_num + 1,		printf("*\tProject     : %s", getreg("p")))
	call append(a:line_num + 2,		printf("*\tAuthor      : %s", getreg("n")))
	call append(a:line_num + 3,		printf("*\tData        : %s", strftime("%c")))
	call append(a:line_num + 4,			   "*\tDescription : ")
	call append(a:line_num + 5,			   "*\t              ")
	call append(a:line_num + 6,			   "*\tHistory     : ")
	call append(a:line_num + 7,		printf("*\t\t%s", strftime("%c")))
	call append(a:line_num + 8,			   "*\t\t\tCreate.")
	call append(a:line_num + 9,		"**********************************************************/")
	call append(a:line_num + 10,		printf("class %s {", classname))
	call append(a:line_num + 11,		"\tprotected:")
	call append(a:line_num + 12,		"\t\t")
	call append(a:line_num + 13,	"\tprivate:")
	call append(a:line_num + 14,	"\t\t")
	call append(a:line_num + 15,	"\tpublic:")
	call append(a:line_num + 16,	"\t\t")
	call append(a:line_num + 17,	"};")
	call cursor(a:line_num + 18, 8)
	return
endfunc

func MyHi(line_num)
	let s:linum=a:line_num
	let indent = indent(line("."))
	let idt = ""
	let i = indent/4
	for i in range(1, i)
		let idt = "\t".idt
	endfor
	call setline(s:linum, printf("%s", idt))
	while s:linum > 0
		let s:linum -= 1
		if getline(s:linum) == "**********************************************************/"
			let process=inputdialog("What have you done?")
			call append(s:linum - 1, printf("*\t\t%s", strftime("%c")))
			call append(s:linum    , printf("*\t\t\t%s", process))
			return
		endif
	endwhile
	call confirm("No Headers Found, please insert headers first.")
	return
endfunc
