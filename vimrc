set nobackup
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set noexpandtab 
set nu  
set autoindent 
set cindent
colorscheme desert
syntax on
set shell=/bin/sh

"vim字体大小
set guifont=Monospace\ 16

set nocompatible " be iMproved
set backspace=2 " be iMproved
filetype off " required!

filetype plugin indent on     " required!

" let Vundle manage Vundle
" required! 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Bundle 'gmarik/vundle'


" 设置折叠方式为缩进折叠
" set foldmethod=indent
" 设置折叠方式为标记折叠
" set foldmethod=marker
" 设置折叠方式为表达式折叠
set foldmethod=expr
set foldexpr=getline(v:lnum)[0]==\"\\t\"

" 设置自动折叠
" set foldclose=all

" 设置Leader键
let mapleader = ","

" 标签导航，纬度和taglist不同
Bundle 'majutsushi/tagbar'
nmap <leader>tb :TagbarToggle<CR>  " \tb 打开tagbar窗口
let g:tagbar_autofocus = 1

Bundle 'vim-scripts/taglist.vim'
" \tl                 打开Taglist/TxtBrowser窗口，在右侧栏显示
nmap <leader>tl :Tlist<CR><c-l>
" :Tlist              调用TagList
let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window     = 1             " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close = 1             " 自动折叠
"let Tlist_Sort_Type = "name"                   " items in tags sorted by name

"arduino色彩高亮
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
"arudino编译文件
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" My Bundles here:
" YCM
" Bundle 'Valloric/YouCompleteMe'
" let g:ycm_global_ycm_extra_conf='~/.vim/YCM_extra_conf.py'
" " 自动补全配置
" set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致
" let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
" let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
" let g:ycm_complete_in_comments = 1 "在字符串输入中也能补全
" let g:ycm_complete_in_strings = 1 "注释和字符串中的文字也会被收入补全
" nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> 
" " 跳转到定义处
" let g:ycm_collect_identifiers_from_tag_files = 1 " add tags file
" let g:ycm_seed_identifiers_with_syntax = 1 " add syntax
" let g:ycm_add_preview_to_completeopt = 1 " add preview
" let g:ycm_autoclose_preview_window_after_completion = 1 " auto close compl

"" autocompl 暂时不用YCM
Bundle 'vim-scripts/AutoComplPop'

" OmniCppComplete
Bundle 'vim-scripts/OmniCppComplete'
set completeopt=menu,menuone  
let OmniCpp_MayCompleteDot=1	" 打开  . 操作符
let OmniCpp_MayCompleteArrow=1	" 打开 -> 操作符
let OmniCpp_MayCompleteScope=1	" 打开 :: 操作符
let OmniCpp_NamespaceSearch=1	" 打开命名空间
let OmniCpp_GlobalScopeSearch=1  
let OmniCpp_DefaultNamespace=["std"]  
let OmniCpp_ShowPrototypeInAbbr=1	" 打开显示函数原型
let OmniCpp_SelectFirstItem = 2		" 自动弹出时自动跳至第一个

" Syntastic
let g:syntastic_c_checkers=['make']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*gbar

" vim-arudino
Bundle 'git://github.com/tclem/vim-arduino.git'

" 宏定义补全插件
" 快速插入代码片段
" 暂时不用
" Bundle 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger = "<leader><tab>"
" let g:UltiSnipsListSnippets = "<leader>ul"
" let g:UltiSnipsJumpForwardTrigger = "<leader><tab>"
" let g:UltiSnipsJumpBackwardTrigger= "<leader><tab>"
" 
" " 定义存放代码片段的文件夹 .vim/snippets下，使用自定义和默认的，将会的到全局，有冲突的会提示
" let g:UltiSnipsSnippetDirectories=["snippets", "bundle/ultisnips/UltiSnips"]

" \s 一键保存
func! SaveFile()
    exec "w"
endfunc
map  <leader>s :call SaveFile()<CR>
imap <leader>s  <ESC>:call SaveFile()<CR>
vmap <leader>s  <ESC>:call SaveFile()<CR>

" 使用GUI界面时的设置
if  has("gui_running")
	set guioptions+=c        " 使用字符提示框
	set guioptions-=m        " 隐藏菜单栏
	"set guioptions-=T        " 隐藏工具栏
	set guioptions-=L        " 隐藏左侧滚动条
	"set guioptions-=r        " 隐藏右侧滚动条
	set guioptions-=b        " 隐藏底部滚动条
	"set showtabline=0       " 隐藏Tab栏
	set cursorline           " 突出显示当前行
endif

"目录文件导航
Bundle 'scrooloose/nerdtree'
" \nt                 打开nerdree窗口，在左侧栏显示
nmap <leader>nt :NERDTree<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

Bundle 'fholgado/minibufexpl.vim'
" 多文件切换，也可使用鼠标双击相应文件名进行切换
let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs  = 1
let g:miniBufExplModSelTarget       = 1
"解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplCycleArround=1
" buffer 切换快捷键，默认方向键左右可以切换buffer
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>

" 美化状态栏
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'unicode'

"for file search ctrlp, 文件搜索
Bundle 'kien/ctrlp.vim'
" 打开ctrlp搜索
let g:ctrlp_map = '<leader>ff'
let g:ctrlp_cmd = 'CtrlP'
" 相当于mru功能，show recently opened files
map <leader>fp :CtrlPMRU<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

Bundle 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

"自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']

" 使用pyflakes,速度比pylint快
Bundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'	"set error or warning signs
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes']
"highlight SyntasticErrorSign guifg=white guibg=black

let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
let g:syntastic_enable_balloons = 1	"whether to show balloons

:cd %:p:h
