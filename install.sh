#/bin/bash

ESC_SEQ="\e["

has () {
  type "$1" > /dev/null 2>&1
  [ $? -eq 0 ]
}

logger () {
  if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
    echo "Usage:"
    return 1
  fi

  local color=

  case "$1" in
    INFO)
      color=97
      ;;
    ERROR)
      color=31
      ;;
    SUCCESS)
      color=92
      ;;
    *)
      text="$1"
  esac

  printf "${ESC_SEQ}${color}m[$1] $2\n${ESC_SEQ}0m"
}

die () {
  logger ERROR "$1"
  exit 1
}

# download dotfiles from remote repository

DOTFILES_GITHUB="https://github.com/otomarukanta/dotfiles.git"
DOTFILES_PATH="$HOME/dotfiles"
DOTFILES_TARBALL="https://github.com/otomarukanta/dotfiles/archive/master.tar.gz"

if [ -d "$DOTFILES_PATH" ]; then
  die "$DOTFILES_PATH: already exists."
fi

if has "git"; then
  git clone --recursive "$DOTFILES_GITHUB" "$DOTFILES_PATH"

elif has "curl" || has "wget"; then
  if has "curl"; then
    curl -L "$TARBALL"

  elif has "wget"; then
    wget -O "$TARBALL"

  fi | tar xv -

  mv -f dotfiles-master "$DOTFILES_PATH"

else
  die "Require curl or wget."
fi

# symlink dotfiles
cd "$DOTFILES_PATH"
make init-git-user
make symlink
