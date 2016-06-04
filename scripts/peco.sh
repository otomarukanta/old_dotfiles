#!/bin/bash

set -eu

latest=$(
  curl -fsSI https://github.com/peco/peco/releases/latest |
  tr -d '\r' |
  awk -F'/' '/^Location:/{print $NF}'
)

: ${latest:?}

mkdir -p $HOME/bin

if [ "$(uname)" == 'Darwin' ]; then
  brew install peco
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  filename="peco_linux_amd64.tar.gz"
  curl -fsSL "https://github.com/peco/peco/releases/download/${latest}/${filename}" |
  tar -xz --to-stdout peco_linux_amd64/peco > $HOME/bin/peco
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi


chmod +x $HOME/bin/peco

$HOME/bin/peco --version
