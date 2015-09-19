"
" 一般設定
"
set encoding=utf-8      " Vimの内部文字コードを指定
scriptencoding utf-8    " VimScriptファイルの文字コードを指定

"
" 表示
"

" 不可視文字の表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set number          " 行番号表示
set wrap            " テキスト折り返し
set textwidth=0     " 自動で改行を入らないように
set cursorline      " カーソル行の強調
set showcmd         " 入力中のコマンドを表示
set colorcolumn=80  " 80文字目に線を表示

" タブ幅の設定
set tabstop   =2    " タブの幅
set autoindent      " 改行時に前の行のインデントに合わせる
set expandtab       " タブを空白に展開
set shiftwidth=2    " 自動インデントの幅
set shiftround      " < > でインデントするときはshiftwidth倍数

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

" 保存する時、行末のスペースを削除する
autocmd BufWritePre * :%s/\s\+$//ge
"
" マクロ・キー設定
"
inoremap jj <Esc>       "入力モード中に素早くjjと入力した場合はESCとみなす
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

""""""""""""""""
"
" NeoBundle
"
""""""""""""""""
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundle

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'   " NeoBundleをNeoBundleで管理
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" complete
NeoBundleLazy 'Shougo/neocomplete.vim', {
      \ "autoload": {"insert": 1}}
NeoBundleLazy 'Rip-Rip/clang_complete', {
      \ 'autoload' : {'filetypes' : ['c', 'cpp']}
      \ }
NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip install jedi",
      \   "unix": "pip install jedi",
      \ }}
NeoBundleLazy "lambdalisue/vim-pyenv", {
      \ "depends": ['davidhalter/jedi-vim'],
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}


NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle "tyru/caw.vim"
NeoBundleLazy 'vim-jp/cpp-vim', {
      \ 'autoload' : {'filetypes' : 'cpp'}
      \ }
NeoBundleLazy 'othree/html5.vim', {
      \ "autoload" : {"filetypes": ['html']}}

" display
NeoBundle 'tomasr/molokai'
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'jiangmiao/auto-pairs'


call neobundle#end()

NeoBundleCheck

""""""""""""""""
" plugin settings
""""""""""""""""
" neocomplete

let g:acp_enableAtStartup = 0 "AutoComplPopを無効化
let g:neocomplete#enable_at_startup = 1 "補間を有効
let g:neocomplete#enable_smart_case = 1 "スマートケースに対応
let g:neocomplete#skip_auto_completion_time = "" "補間に時間がかかってもがんばる

" clang_competeと併用するときの設定
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
autocmd FileType javascript setlocal completeopt-=preview
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" プレビュー画面を使わない
autocmd FileType python setlocal completeopt-=preview

" clang_complete
" clang_completeでは自動補完を行わない
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
let g:clang_debug = 1
if has('mac')
  let g:clang_library_path="/Library/Developer/CommandLineTools/usr/lib"
endif
let g:clang_user_options = '-std=c++11'

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
let g:syntastic_check_on_open = 0 " ファイルを開いた時はチェックしない
let g:syntastic_check_on_wq = 0 " :wqの時はチェックしない

let g:syntastic_c_check_header = 1      " C
let g:syntastic_cpp_check_header = 1    " C++
if executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'
endif
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

let g:syntastic_html_tidy_exec = 'tidy5'

"
" QuickRun
"
" \r で即コンパイル and 実行
"
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


" caw.vim
" \cでコメントアウト
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

set laststatus=2
set t_Co=256
let g:lightline = {
      \ 'colorscheme' : 'wombat',
      \ }


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
  setlocal path+=./include/
endfunction

augroup vimrc-cpp
  autocmd!
  autocmd FileType cpp call s:cpp()
augroup END

set cinoptions+=:g0,0
autocmd FileType * setlocal formatoptions-=ro

autocmd BufNewFile *.html 0r ~/.vim/template/template.html
