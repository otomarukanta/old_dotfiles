# 設定ファイルがある場所のフルパス

# NeoBundleを導入する
if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

cp -r "$BASE_DIR/vim/template/" ~/.vim/template/
