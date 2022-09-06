" File: _vimrc
" Date: 2009-09-22
" Author: gashero
" NOTE: 配置一份简单的vim配置文件

set nocompatible              " be iMproved, required
filetype off                  " required

" 启用vundle来管理vim插件
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 安装插件写在这之后

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 自动补全
Bundle 'Valloric/YouCompleteMe' 

" 每次保存文件 自动检测语法
Plugin 'scrooloose/syntastic'

" 文件树形结构
Plugin 'scrooloose/nerdtree'
" 隐藏.pyc文件 在nerdtree中
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" 超级搜索 ctrl + P
Plugin 'kien/ctrlp.vim'

" git集成
Plugin 'tpope/vim-fugitive'

" Powerline 状态栏
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" 安装插件写在这之前
call vundle#end()     " required
filetype plugin on    " required

" 常用命令
" :PluginList       - 查看已经安装的插件
" :PluginInstall    - 安装插件
" :PluginUpdate     - 更新插件
" :PluginSearch     - 搜索插件，例如 :PluginSearch xml就能搜到xml相关的插件
" :PluginClean      - 删除插件，把安装插件对应行删除，然后执行这个命令即可

" h: vundle         - 获取帮助

" vundle的配置到此结束，下面是你自己的配置

set nocompatible    "非兼容模式
syntax on           "开启语法高亮
set background=dark "背景色
color desert
set ruler           "在左下角显示当前文件所在行
set showcmd         "在状态栏显示命令
set showmatch       "显示匹配的括号
set ignorecase      "大小写无关匹配
set smartcase       "只能匹配，即小写全匹配，大小写混合则严格匹配
set hlsearch        "搜索时高亮显示
set incsearch       "增量搜索
"set nohls           "搜索时随着输入立即定位，不知什么原因会关闭结果高亮
set report=0        "显示修改次数
set mouse=a         "控制台启用鼠标
set number          "行号
set nobackup        "无备份
set cursorline      "高亮当前行背景
set fileencodings=ucs-bom,UTF-8,GBK,BIG5,latin1
set fileencoding=UTF-8
set fileformat=unix "换行使用unix方式
set ambiwidth=double
set noerrorbells    "不显示响铃
set visualbell      "可视化铃声
set foldmarker={,}  "缩进符号
set foldmethod=indent   "缩进作为折叠标识
set foldlevel=100   "不自动折叠
set foldopen-=search    "搜索时不打开折叠
set foldopen-=undo  "撤销时不打开折叠
set updatecount=0   "不使用交换文件
set magic           "使用正则时，除了$ . * ^以外的元字符都要加反斜线

"缩进定义
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set backspace=2     "退格键可以删除任何东西
"显示TAB字符为
set list
set list listchars=tab:<+

"映射常用操作
map [r :! python % <CR>
map [o :! python -i % <CR>
map [t :! rst2html.py % %<.html <CR>

if has("gui_running")
    set lines=25
    set columns=80
    set lazyredraw  "延迟重绘
    set guioptions-=m   "不显示菜单
    set guioptions-=T   "不显示工具栏
    set guifont=consolas\ 10
endif

if has("autocmd")
    "回到上次文件打开所在行
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    "自动检测文件类型，并载入相关的规则文件
    filetype plugin on
    filetype indent on
    "智能缩进，使用4空格，使用全局的了
    "autocmd FileType python setlocal et | setlocal sta | setlocal sw=4
    "autocmd FileType c setlocal et | setlocal sta | setlocal sw=4
    "autocmd FileType h setlocal et | setlocal sta | setlocal sw=4
endif

">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 个人配置by HeBee
" 使用:sv <filename>命令打开一个文件
"   你可以纵向分割布局（新文件会在当前文件下方界面打开
" 使用相反的命令:vs <filename>
"   你可以得到横向分割布局（新文件会在当前文件右侧界面打开）。

" 系统剪贴板
set clipboard=unnamed

" 分割布局（Split Layouts）
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 代码折叠
" Enable folding (use za to folding)
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" 字符81处竖线
set colorcolumn=81

" 其中m表示允许在两个汉字中间换行
" B表示将两行合为一行的时候不要在两个汉字之间加入空格
set fo+=mB

" NERDTree config
" open a NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"map F2 to open NERDTree
map <F2> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly Run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()
    exec "w" 
    if &filetype == 'c' 
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'py'
        exec '!time python %'
    elseif &filetype == 'sh'
        :!time bash %
    endif                                                                              
endfunc 
