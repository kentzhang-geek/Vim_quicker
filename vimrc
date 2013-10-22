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

" 设置折叠方式为缩进折叠
" set foldmethod=indent
" 设置折叠方式为标记折叠
" set foldmethod=marker
" 设置折叠方式为表达式折叠
set foldmethod=expr
set foldexpr=getline(v:lnum)[0]==\"\\t\"

" 设置自动折叠
" set foldclose=all

"设置Leader键
let mapleader = ","

"进行Tlist的设置
"TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
"是否一直处理tags.1:处理;0:不处理
let Tlist_Process_File_Always=0 "不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0

"arduino色彩高亮
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
"arudino编译文件
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

"vim字体大小
set guifont=Monospace\ 16

set nocompatible               " be iMproved
set backspace=2		" be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

filetype plugin indent on     " required!

" 自动补全映射：
" inoremap <expr> <Space>	pumvisible()?"<C-Y>":"<Space>"


" My Bundles here:
"
" Bundle 'Valloric/YouCompleteMe'

"vim-arudino
Bundle 'git://github.com/tclem/vim-arduino.git'
