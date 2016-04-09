#!/bin/bash

echo "Create .gitconfig_local"
echo -n "username: "
read username
echo -n "email: "
read email

cat << EOS > $HOME/.gitconfig_local
[user]
  name = $username
  email = $email
EOS

cat $HOME/.gitconfig_local
