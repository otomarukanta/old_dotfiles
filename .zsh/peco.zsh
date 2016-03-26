if which peco &> /dev/null; then
  function peco_select_history() {
    local tac
    if which gtac &> /dev/null; then
      tac="gtac"
    elif which tac &> /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER # move cursor
    zle -R -c       # refresh
    # zle reset-prompt
  }

  zle -N peco_select_history
  bindkey '^R' peco_select_history
fi
