
# 一般設定
#
bindkey -e                  # キーバインドのemacsモードに設定
setopt no_beep              # ビープ音を鳴らさない
setopt auto_cd              # ディレクトリ名などで移動
setopt auto_pushd           # cd時にディレクトリスタックにpushd
setopt correct              # コメンドのスペルを訂正
setopt magic_equal_subst    # =以降も補間 --prefix=/usrなど
setopt prompt_subst         # プロンプト定義内で変数置換やコマンド置換を扱う

#
# 補完
#
fpath=($HOME/.zsh/completions/src $fpath)
autoload -U compinit; compinit  # 補完機能を有効
setopt auto_list                # 補完候補を一覧で表示
setopt auto_menu                # 補完キー
setopt auto_pushd               # 移動したディレクトリを保存
setopt list_packed              # 補完対象の表示をつめる
setopt nolistbeep               # 補完時のビープ音を鳴らさない

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

#
# コマンド履歴
#
# setopt pushd_ignore_dups
# setopt extended_glob
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt share_history        # 複数起動しているzshの間で履歴を共有
setopt hist_ignore_all_dups # 同じコマンドは履歴に追加しない
setopt hist_ignore_space    # スペースから始まるコマンドは履歴に追加しない

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # 単語の一部としし認識される文字のセット

#
# 見た目設定
#
autoload colors; colors # プロンプトに色をつける
autoload -Uz vcs_info
setopt prompt_subst

# git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

local prompt_date="%{${bg[cyan]}${fg[black]}%}[%*]%{${reset_color}%}"
local prompt_host=" %{${fg[magenta]}%}%n@%M"
local prompt_dir="%{${reset_color}${fg[yellow]}%} [%d]%{${reset_color}%}"
PROMPT="${prompt_date}${prompt_host}${prompt_dir}
 %(?.%{${fg[green]}%}.%{${fg[red]}%})"'(´-\`).｡oO '"%{${reset_color}%}"
PROMPT2=" > "
RPROMPT='${vcs_info_msg_0_}'

export LSCOLORS=gxfxcxdxbxegedabagacad
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
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
eval "$(pyenv init -)"

# ssh setteing for tmux
AGENT_SOCK_FILE="/tmp/ssh-agent-$USER"
SSH_AGENT_FILE="$HOME/.ssh-agent-info"
if test $SSH_AUTH_SOCK ; then
  if [ $SSH_AUTH_SOCK != $AGENT_SOCK_FILE ] ; then
    ln -sf $SSH_AUTH_SOCK $AGENT_SOCK_FILE
    export SSH_AUTH_SOCK=$AGENT_SOCK_FILE
  fi
else
  test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
  if ! ssh-add -l >& /dev/null ; then
    ssh-agent > $SSH_AGENT_FILE
    source $SSH_AGENT_FILE
    ssh-add
  fi
fi

# alias
alias la="ls -a"
alias ll="ls -l"

source $HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/peco.zsh

# local依存の設定を読み込む
[ -f $HOME/.zshrc_local ] && . $HOME/.zshrc_local
