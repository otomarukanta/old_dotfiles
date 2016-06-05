" dein settings {{{
"
" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
execute 'set runtimepath^=' . s:dein_repo_dir

let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let s:toml      = '~/.config/dein/plugins.toml'
let s:lazy_toml = '~/.config/dein/plugins_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}


"
" 一般設定
"
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

" バックアップファイルを無効化する（以下３つ）
set nowritebackup
set nobackup
set noswapfile

"
" マクロ・キー設定
"
nnoremap <silent> ; :
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap <silent> jj <Esc>
" ESCを二回押すとハイライト消去
nmap <silent> <Esc><Esc> :nohlsearch<CR>

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
if has('nvim')
  nmap <BS> <C-W>h
endif
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

filetype plugin indent on
syntax on
