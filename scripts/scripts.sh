#!/bin/bash

function simple-deploy() {
  url=$1
  filename=$2
  curl -fsSL $url -o $HOME/bin/$filename
}

simple-deploy https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight diff-highlight
