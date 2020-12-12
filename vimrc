
" 插件开始
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'codota/tabnine-vim'      " 人工智能补全
"Plug 'SirVer/ultisnips'			    " 常用编码自动补全
Plug 'honza/vim-snippets'       " 常用编码自动补全，可自定义
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
Plug 'vim-scripts/taglist.vim' 	" tag插件
Plug 'majutsushi/tagbar'        " 可替换taglist，增加go语言支持
Plug 'vim-airline/vim-airline'  " 状态栏插件
Plug 'vim-airline/vim-airline-themes'   " airline的主题
Plug 'tomasr/molokai'           " vim主题
Plug 'altercation/vim-colors-solarized' " vim主题
Plug 'luochen1990/rainbow' 		  " 彩虹括号
Plug 'jiangmiao/auto-pairs'		  " 匹配
Plug 'vim-scripts/DoxygenToolkit.vim' 	" 自动注释
Plug 'airblade/vim-gitgutter'   " git侧边栏插件
Plug 'tpope/vim-fugitive'		    " git常用命令插件
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  }
Plug 'mileszs/ack.vim'          " 遍历文本插件，类似grep
Plug 'ludovicchabant/vim-gutentags'     " git操作插件
Plug 'skywind3000/asyncrun.vim' " 异步执行命令插件
Plug 'dense-analysis/ale'       " 语法错误检查插件
Plug 'Chiel92/vim-autoformat'   " 自动格式化代码插件
Plug 'vhdirk/vim-cmake'         " cmake插件，可执行cmake命令编译，配合make命令使用
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'  " markdown预览插件
Plug 'skywind3000/vim-preview'
Plug 'whatot/gtags-cscope.vim'  " gtags插件
Plug 'easymotion/vim-easymotion'    " 快速跳转行
Plug 'scrooloose/nerdcommenter'     " 注释工具
Plug 'puremourning/vimspector'      " 调试工具

Plug 'fatih/vim-go', { 'tag': '*' } " go 主要插件
Plug 'dgryski/vim-godef'            " go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'jstemmer/gotags'              " 配合tagbar展示go变量
call plug#end()
" 插件结束
"
" 设置<Leader>为','
let mapleader=';'
" 显示相对行号
set relativenumber
" 主题
" molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
"colorscheme slate
"colorscheme molokai

" solarized
let g:solarized_termcolors=256
set background=dark
"set background=light
colorscheme solarized

" 显示行号
set nu 
set nobackup

" 距离底部保留5行
set scrolloff=5

" 预览查找结果"
set incsearch
set ignorecase

" 凸显当前行列
set cursorline
"set cursorcolumn

" 总是显示状态栏
set laststatus=2

" 显示光标当前位置
set ruler

" 显示括号匹配
set showmatch


" 继承前一行的缩进方式，适用于多行注释'
set autoindent
set smartindent
" 设置Tab长度为2空格
set tabstop=2
" 设置自动缩进长度为2空格, 该选项尤其对json,xml等自动格式化有用
set shiftwidth=2
" 根据其它地方缩减的空格数来确定tab到底为多少个空格
set smarttab
" 设置空格替代TAB
set expandtab
" 设置baskspace按键能正常删除
set backspace=indent,eol,start


" 设置编码'
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" 设置粘贴时保留原格式
"set paste

" 设置自动格式化,解决复制代码过来的时候出现格式混乱
set formatoptions=tcrqn

" 让vimrc配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 去掉滴滴声
set noeb vb t_vb= 

" 高亮当前行
nmap <silent> <leader>h :<C-u>let @/ = expand('<cword>')<cr>:set hls<cr>
nmap <silent> <leader>j :noh<cr>

" quick查询结果跳转
nmap <silent> <leader>n :cn<cr>
nmap <silent> <leader>p :cp<cr>

" 启用代码折叠
"1. manual //手工定义折叠
"2. indent //用缩进表示折叠
"3. expr　 //用表达式来定义折叠
"4. syntax //用语法高亮来定义折叠
"5. diff   //对没有更改的文本进行折叠
"6. marker //用标志折叠
set foldmethod=indent
set foldlevel=99
"nnoremap <space> za 	" 快捷键：空格 - 折叠

"处理未保存或只读文件时，弹出确认
set confirm

"自动保存
set autowrite

" 禁止生成swp文件
set noswapfile

"禁止搜索到文件两端时重新搜索
"set nowrapscan

" 高亮显示搜索到的文本
set hlsearch

" 和系统共用剪贴板
set clipboard+=unnamed

" 文件类型
filetype plugin on 

" 记住浏览位置
if has("autocmd")                                                          
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif                                                        
endif 

""""""""""""""" 插件配置开始 """"""""""""""""""
" 插件NerdTree
map <silent>nt :NERDTreeToggle<CR><c-l>
map <silent>nf :NERDTreeFind<CR><c-l>
"autocmd vimenter * if !argc()|NERDTree|endif "打开vim时如果没有文件自动打开NERDTree
let NERDTreeShowHidden=1

" 插件nerdtree-git-plugin
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" 插件ultisnip
"let g:UltiSnipsExpandTrigger = 你想用的键

" taglist
let Tlist_Show_One_File=1		"不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1		"如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1	"在右侧窗口中显示taglist窗口
let Tlist_Process_File_Always=1	"taglist始终解析文件中的tag，不管taglist窗口有没有打开
let Tlist_File_Fold_Auto_Close=1	"同时显示多个文件中的tag时，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来
map <silent>tl :TlistToggle<cr>

" easymotion
map <space> <Plug>(easymotion-prefix)


" go language
let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' . 
            \ 'v:variable;f:function'

" tagbar, 替换taglist, 增加对go语言的支持
map <silent>tb :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"nerdcommenter 
"add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" python 自动的会多加一个空格
au FileType python let g:NERDSpaceDelims = 0
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" airline
"let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled=0 " 关闭空白符检测
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty='⚡'
"let g:airline_theme="luna"
let g:airline_theme="bubblegum"
"set ambiwidth=double
"set t_Co=256 "xshell 下显示颜色
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle



" doxygen
let g:DoxygenToolkit_briefTag_pre="@synopsis  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return   "
let g:DoxygenToolkit_authorName="Shuai Li"
let g:DoxygenToolkit_briefTag_pre = "@brief "
let g:DoxygenToolkit_templateParamTag_pre = "@tparam "
let g:DoxygenToolkit_throwTag_pre = "@throw " " @exception is also valid
let g:DoxygenToolkit_fileTag = "@file "
let g:DoxygenToolkit_dateTag = "@date "
let g:DoxygenToolkit_authorTag = "@author "
let g:DoxygenToolkit_versionTag = "@version "
let g:DoxygenToolkit_blockTag = "@name "
let g:DoxygenToolkit_classTag = "@class "
let g:doxygen_enhanced_color = 1
let g:DoxygenToolkit_briefTag_funcName = "yes"
"let g:DoxygenToolkit_licenseTag="My own license" <-- !!! Does not end with "\<enter>"
"let g:load_doxygen_syntax = 1
"let g:DoxygenToolKit_startCommentBlock = "/// "
"let g:DoxygenToolKit_interCommentBlock = "/// "

" vim-gitgutter
nmap ghb <Plug>(GitGutterPrevHunk)
nmap ghn <Plug>(GitGutterNextHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
set updatetime=100
let g:gitgutter_max_signs=800

" LeaderF
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.root', '.project']
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
nmap <Leader>t :LeaderfBufTag<CR>
nmap <Leader>T :LeaderfTag<CR>
nmap <Leader>m :LeaderfFunction<CR>
nmap <Leader>M :LeaderfFunctionAll<CR>

" ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif
let g:ackhighlight = 1
let g:ack_use_cword_for_empty_search = 1
map <Leader>a :Ack!<Space> 

" coc
let g:coc_global_extensions = ['coc-tsserver','coc-html','coc-css', 'coc-json',
            \ 'coc-java','coc-python','coc-flutter', 'coc-cmake','coc-clangd',
            \ 'coc-emmet','coc-snippets','coc-xml','coc-yaml','coc-go',
            \ 'coc-markdownlint','coc-highlight',"coc-sh","coc-bookmark"]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-a> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
 
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" vim-gutentags 
"function! InitPrjPath()
"    let curdir=getcwd()
"    while !filereadable(".root") && !isdirectory(".svn") && !isdirectory(".git") &&  !filereadable(".project")
"        cd ..
"        if getcwd() == "/"
"            break
"        endif
"    endwhile
"    if filereadable(".root") || isdirectory(".svn") || isdirectory(".git") ||  filereadable(".project")
"		"echo "prjpath:" . getcwd()
"	else
"		execute ":cd" . curdir
"    endif
"endfunction
"call InitPrjPath()

set tags=./.tags;,.tags
autocmd filetype c,cpp set tags=$LIBCXXTAGS,./.tags;,.tags
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
" 避免多个项目数据库相互干扰,使用plus插件解决问题
let g:gutentags_auto_add_gtags_cscope = 1
" 查看日志
let g:gutentags_define_advanced_commands = 1
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
"----------vim-preview配置-----------------------------------------
"P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

" cscope 
set cscopetag
set csto=0
let g:Gtags_Close_When_Single = 1
let GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Quiet = 1
set csprg=gtags_cscope
set cscopeprg=gtags-cscope
set cscopequickfix=s-,c-,d-,i-,t-,e- 	" cw查看cscope查询结果，快速跳转到第一个结果
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" ale
let g:ale_disable_lsp = 1
" 始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en'
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'cpp': ['clang++'],
\   'c': ['clang'],
\   'python': ['flask8'],
\	'javascript': ['eslint'],
\}
"文件内容发生变化时不进行检查
"let g:ale_lint_on_text_changed = 'never'
"打开文件时不进行检查
"let g:ale_lint_on_enter = 0

" Autoformat
let g:formatdef_clangformat_google = '"clang-format -style google --sort-includes -"'
let g:formatdef_astyle_kr = '"astyle --style=kr"'
let g:formatdef_astyle_java = '"astyle --style=java"'

let g:formatters_cpp = ['clangformat_google']
let g:formatters_c = ['clangformat_google']
let g:formatters_java = ['astyle_java']

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" vim-go
"let g:go_gopls_enabled = 0 " 取消底部告警vim-go: initialized gopls
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
" godef
let g:godef_split=0 " 左右打开新窗口的时候
let g:godef_same_file_in_same_window=1 " 函数在同一个文件中时不需要打开新窗口
autocmd FileType go nnoremap <buffer> <C-]> :GoDef<cr>
autocmd FileType go nnoremap <C-\>c :GoReferrers<CR>
"autocmd FileType go nnoremap gR :GoRun<CR>
autocmd FileType go nnoremap gY :GoRun<CR> " 运行，R为vim原生替换按键，避免冲突
autocmd FileType go nnoremap gT :GoTestFunc<CR>

" command
command Run terminal %

" 快速命令
nmap <c-w>t :terminal<CR>
