"
" 一般設定
"
set encoding=utf-8      " Vimの内部文字コードを指定
scriptencoding utf-8    " VimScriptファイルの文字コードを指定

"
" 表示
"
set list            " 不可視文字の表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲  " 不可視文字の設定
set number          " 行番号表示
set wrap            " テキスト折り返し
set textwidth=0     " 自動で改行を入らないように

" タブ幅の設定
set tabstop   =4
set autoindent
set expandtab
set shiftwidth=4

" スクリーンベルの無効化（以下３つ）
set t_vb=
set visualbell
set noerrorbells

"
" 検索・置換
"
set ignorecase  " 大文字小文字区別なし
set smartcase   " 大文字の時は大文字だけ検索
set incsearch   " インクリメントサーチ
set hlsearch    " 検索マッチテキストをハイライト
set wrapscan    " 検索が最後まで行ったら最初まで戻る

"
" 編集
"
set shiftround          " < > でインデントするときはshiftwidth倍数
set infercase           " 補完時に大文字小文字区別なし
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるように
set hidden              " バッファを閉じる代わりに隠す
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧をハイライト表示する
set matchtime=3         " 対応する括弧のハイライト表示時間を３秒
set nosmartindent       " コメント行での改行でコメントにならないように
set matchpairs& matchpairs+=<:> " 括弧に<>を追加
set backspace=indent,eol,start  " バックスペースで消せる対象を増やす

" バックアップファイルを無効化する（以下３つ）
set nowritebackup
set nobackup
set noswapfile

"
" マクロ・キー設定
"

inoremap jj <Esc>   " 入力モード中に素早くjjと入力した場合はESCとみなす
nmap <silent> <Esc><Esc> :nohlsearch<CR> " ESCを二回押すとハイライト消去

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"
"
" NeoBundle
"
"
if has('vim_starting')
    if &compatible
        set nocompatible
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'   " NeoBundleをNeoBundleで管理

"
" 各種プラグイン
"
"
" vimproc
"
" 非同期で動作するすごいやつ
"
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }

"
" NeoComplete.vim
"
" 補完の基本的なやつ
"
NeoBundleLazy 'Shougo/neocomplete.vim', {
            \ "autoload": {"insert": 1}}
let g:acp_enableAtStartup = 0 "AutoComplPopを無効化
let g:neocomplete#enable_at_startup = 1 "補間を有効
let g:neocomplete#enable_smart_case = 1 "スマートケースに対応
let g:neocomplete#skip_auto_completion_time = "" "補間に時間がかかってもがんばる

"
" clang_competeと併用するときの設定
"
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" タブで補完対象を選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>" 
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>" 

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" プレビュー画面を使わない
autocmd FileType python setlocal completeopt-=preview

"
" clang_complete
"
" C++のすごい補完
"
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ }
" clang_completeでは自動補完を行わない
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
let g:clang_debug = 1
if has('mac')
    let g:clang_library_path="/Library/Developer/CommandLineTools/usr/lib"
endif
let g:clang_user_options = '-std=c++11'

NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip install jedi",
      \   "unix": "pip install jedi",
      \ }}
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
"     " jediにvimの設定を任せると'completeopt+=preview'するので
"     " 自動設定機能をOFFにし手動で設定を行う
    let g:jedi#auto_vim_configuration = 0
"     " 補完の最初の項目が選択された状態だと使いにくいためオフにする
    let g:jedi#popup_select_first = 0
"     " quickrunと被るため大文字に変更
    let g:jedi#rename_command = '<Leader>R'
"
"     let g:jedi#show_call_signatures = 0
"
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
"
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif

"     let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
"
endfunction


"
" syntastic
"
" ファイルの構文チェックをしてくれる。
"
NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open = 0 " ファイルを開いた時はチェックしない
let g:syntastic_check_on_wq = 0 " :wqの時はチェックしない

let g:syntastic_c_check_header = 1      " C
let g:syntastic_cpp_check_header = 1    " C++
if executable("clang++")
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'
endif
let g:syntastic_python_checkers = ['pyflakes', 'pep8']


"
" QuickRun
"
" \r で即コンパイル and 実行
"
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
            \ '_' : {
            \ 'outputter/buffer/split' : ':botright 8',
            \ "runner" : "vimproc",
            \ "runner/vimproc/updatetime" : 60
            \ },
            \}
let g:quickrun_config.cpp = {
            \ 'commands' : 'g++',
            \ 'cmdopt' : '-std=c++11 `pkg-config --cflags opencv` `pkg-config --libs opencv`'
            \ }
let g:quickrun_config.tex = {
            \ 'command': 'ptex2pdf',
            \ 'exec': ['%c -l -ot "-synctex=1 -interaction=nonstopmode" %s', 'open %s:r.pdf']
            \}


NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" \cでコメントアウト
NeoBundle "tyru/caw.vim"
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

" 単語をハイライトする
NeoBundle "t9md/vim-quickhl"
nmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>M <Plug>(quickhl-manual-reset) 
xmap <Space>M <Plug>(quickhl-manual-reset) 

NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/unite-outline"
NeoBundle "Shougo/unite-build"

"
" cpp-vim
"
" C++11のシンタックスハイライト用
"
NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }
NeoBundleLazy 'othree/html5.vim', {
            \ "autoload" : {"filetypes": ['html']}}
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
set t_Co=256
let g:lightline = {
            \ 'colorscheme' : 'wombat',
            \ }

" javascript 補完
NeoBundle 'marijnh/tern_for_vim'

NeoBundle 'tomasr/molokai'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

au BufRead,BufNewFile *.md set filetype=markdown

call neobundle#end()

NeoBundleCheck

filetype plugin indent on
syntax on

colorscheme molokai
highlight Normal ctermbg=none

"
"
" C++
"
"
function! s:cpp()
    " タブ幅の設定
    setlocal tabstop   =2
    setlocal shiftwidth=2
    setlocal path+=/Users/kanta/cocos2d-x/cocos2d-x-3.3beta0/cocos/
    setlocal path+=./include/
endfunction

augroup vimrc-cpp
    autocmd!
    autocmd FileType cpp call s:cpp()
augroup END

set cinoptions+=:g0,0
autocmd FileType * setlocal formatoptions-=ro
setlocal path+=/Users/kanta/cocos2d-x/cocos2d-x-3.3beta0/cocos/
