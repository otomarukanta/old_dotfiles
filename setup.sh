#!/bin_bash

# リンクするファイル名一覧
SYMLINK_LIST="
.vimrc
.zshrc
"

# 設定ファイルがある場所のフルパス
BASE_DIR=$(cd $(dirname $0);pwd)
cd $BASE_DIR

# シンボリックリンクを貼る
for FILE in $SYMLINK_LIST; do
    rm -fr ~/$FILE
    ln -s $BASE_DIR/$FILE ~/$FILE
done

# NeoBundleを導入する
if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# termをインストール
cd $HOME/.vim/bundle/tern_for_vim
npm install

# ログインシェルを変更する
if [ -z "`chsh -l | grep zsh`"  ]; then
    sudo yum -y install zsh
fi
chsh -s /bin/zsh
