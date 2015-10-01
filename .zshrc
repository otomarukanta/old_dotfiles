
# 一般設定
#
bindkey -v                  # キーバインドのviモードに設定
setopt no_beep              # ビープ音を鳴らさない
setopt auto_cd              # ディレクトリ名などで移動
setopt auto_pushd           # cd時にディレクトリスタックにpushd
setopt correct              # コメンドのスペルを訂正
setopt magic_equal_subst    # =以降も補間 --prefix=/usrなど
setopt prompt_subst         # プロンプト定義内で変数置換やコマンド置換を扱う

#
# 補完
#
autoload -U compinit; compinit  # 補完機能を有効
setopt auto_list                # 補完候補を一覧で表示
setopt auto_menu                # 補完キー
setopt auto_pushd               # 移動したディレクトリを保存
setopt list_packed              # 補完対象の表示をつめる
setopt nolistbeep               # 補完時のビープ音を鳴らさない

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

#
# コマンド履歴
#
# setopt pushd_ignore_dups
# setopt extended_glob
setopt share_history        # 複数起動しているzshの間で履歴を共有
setopt hist_ignore_all_dups # 同じコマンドは履歴に追加しない
setopt hist_ignore_space    # スペースから始まるコマンドは履歴に追加しない

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # 単語の一部としし認識される文字のセット

#
# 見た目設定
#
autoload colors; colors # プロンプトに色をつける
autoload -Uz vcs_info
RPROMPT="%{${fg[yellow]}%}[%~]%{${reset_color}%}"
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
PROMPT="%{${fg[yellow]}%}%n@%m%{${reset_color}%} $ "
PROMPT2=''
export LSCOLORS=gxfxcxdxbxegedabagacad
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${LS_COLORS}

case "${OSTYPE}" in
    darwin*)
        alias ls="ls -GF"
        ;;
    linux*)
        alias ls="ls -F --color"
        ;;
esac
# tmuxでvimの色設定を反映
alias tmux="TERM=screen-256color-bce tmux"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
